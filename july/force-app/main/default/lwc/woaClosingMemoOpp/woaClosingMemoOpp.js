/**
 * @description       : 
 * @author            : eduardo.amiens@outlook.com
 * @group             : 
 * @last modified on  : 10-16-2020
 * @last modified by  : eduardo.amiens@outlook.com
 * Modifications Log 
 * Ver   Date         Author                       Modification
 * 1.0   09-21-2020   eduardo.amiens@outlook.com   Initial Version
**/
import { LightningElement, api, wire } from 'lwc';
import { FILEOPP } from './helperJS/fieldsOpHelper';
import { getRecord } from 'lightning/uiRecordApi';

import getClosingMemo from '@salesforce/apex/woaClosingMemoOppController.getClosingMemo';


export default class WoaClosingMemoOpp extends LightningElement {
    @api recordId
    opportunityResult
    opportunityData
    closingMemo

    @wire(getRecord, { recordId: '$recordId', fields: FILEOPP })
    getOpportunityRecordwoa(result) {
        this.opportunityResult = result
        console.log('getOpportunityRecordwoa ' + JSON.stringify(result))
        if(result.data){
            this.opportunityData = result.data
        } else if(result.error){
            console.error('result.error ' + JSON.stringify(result.error))
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error loading',
                    message,
                    variant: 'error',
                }),
            );
        }
    }
    @wire(getClosingMemo, {oppId : '$recordId'})
    getClosingMemo(result){
        console.log('result ' + JSON.stringify(result))
        if(result.data){
            this.closingMemo = result.data 
        } else if(result.error){
            console.error('result.error ' + JSON.stringify(error))
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error loading',
                    message,
                    variant: 'error',
                }),
            );    
        }
    }
}