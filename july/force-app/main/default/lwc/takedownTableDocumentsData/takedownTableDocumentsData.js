import { LightningElement, wire, track, api } from "lwc"
import { ShowToastEvent } from 'lightning/platformShowToastEvent'
import { getRecord, getFieldValue,getFieldDisplayValue } from 'lightning/uiRecordApi'
import constantes from './helperJS/constantes'
import { getPicklistValues } from 'lightning/uiObjectInfoApi';
import Type_FIELD from '@salesforce/schema/Takedowns_Contingency_plan__c.TKD_ls_Invoices_approval_status__c';
import Takedowns_Contingency_plan__c from '@salesforce/schema/Takedowns_Contingency_plan__c';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';


import approvalStatus from '@salesforce/schema/Takedowns_Contingency_plan__c.TKD_ls_Invoices_approval_status__c';
import comments from '@salesforce/schema/Takedowns_Contingency_plan__c.TKD_tl_Invoices_approval_comments__c';

import blank from './views/blank.html'
import mainpage from './takedownTableDocumentsData.html'

export default class TakedownTableDocumentsData extends LightningElement {

    @api recordId 

    @wire(getRecord, { recordId: "$recordId", fields: constantes.FIELDS })
    _resultData 

    get comments() {
        return getFieldValue(this._resultData.data, comments)
    }

    get approvalStatusValue() {
        return getFieldValue(this._resultData.data, approvalStatus)
    }

    get approvalStatusLabel() {
        return getFieldDisplayValue(this._resultData.data, approvalStatus)
    }
    /*@wire(getRecord, { recordId: "$recordId", fields: constantes.FIELDS })
    async wireRecord(result) {
        if(result){        
            try{
                if(await result){ 
                    this._resultData = result  
                                 
                    this.TKD_ls_Invoices_approval_status_api = await result.data.fields.TKD_ls_Invoices_approval_status__c.value
                    this.TKD_ls_Invoices_approval_status_label = await result.data.fields.TKD_ls_Invoices_approval_status__c.displayValue                    
                    this.TKD_ls_Invoices_approval_Comments = 
                }
            }catch(error){
                console.log('error ' + JSON.stringify(error))
            }
        }
        
    }*/
    
    /*@wire(getObjectInfo, { objectApiName: Takedowns_Contingency_plan__c})
    async wireRecordObject(result) {
        try{
            if(await result){
                this._recordTypeId = await Object.values(result.data.recordTypeInfos).filter(ci => ci.name === 'Takedown')[0].recordTypeId  
                
            }
        }catch(error){
            console.log('error ' + JSON.stringify(error))
        }
        
    }
    
        
    
    @wire(getPicklistValues, { recordTypeId: '$_recordTypeId', fieldApiName: Type_FIELD})
    wireRecordPK(result) {
        console.log('resultPKss ' + JSON.stringify(result))
    }*/

}