/**
 * @description       : 
 * @author            : eduardo.amiens@outlook.com
 * @group             : 
 * @last modified on  : 10-21-2020
 * @last modified by  : eduardo.amiens@outlook.com
 * Modifications Log 
 * Ver   Date         Author                       Modification
 * 1.0   08-25-2020   eduardo.amiens@outlook.com   Initial Version
**/
import { LightningElement, wire, api, track } from 'lwc'
import { getRecord, getFieldValue } from 'lightning/uiRecordApi'
import { ShowToastEvent } from "lightning/platformShowToastEvent"
import AML_AP_Stage from '@salesforce/schema/Opportunity.WKA_rb_AP_AML__r.WKA_Stage__c'
import Riesgo_AP_Stage from '@salesforce/schema/Opportunity.WKA_rb_AP_Riesgo__r.WKA_Stage__c'
import Tesoreria_AP_Stage from '@salesforce/schema/Opportunity.WKA_rb_AP_Tesoreria__r.WKA_Stage__c'
import Pricing_AP_Stage from '@salesforce/schema/Opportunity.WKA_rb_AP_Pricing__r.WKA_Stage__c'

import AML_AP_LastModifiedDate from '@salesforce/schema/Opportunity.WKA_rb_AP_AML__r.LastModifiedDate'
import Riesgo_AP_LastModifiedDate from '@salesforce/schema/Opportunity.WKA_rb_AP_Riesgo__r.LastModifiedDate'
import Tesoreria_AP_LastModifiedDate from '@salesforce/schema/Opportunity.WKA_rb_AP_Tesoreria__r.LastModifiedDate'
import Pricing_AP_LastModifiedDate from '@salesforce/schema/Opportunity.WKA_rb_AP_Pricing__r.LastModifiedDate'

import Tesoreria_RecordId from '@salesforce/schema/Opportunity.WKA_rb_AP_Tesoreria__c'
import Riesgo_RecordId from '@salesforce/schema/Opportunity.WKA_rb_AP_Riesgo__c'
import AML_RecordId from '@salesforce/schema/Opportunity.WKA_rb_AP_AML__c'
import Pricing_RecordId from '@salesforce/schema/Opportunity.WKA_rb_AP_Pricing__c'

import submitForApproval from '@salesforce/apex/wkaCustomAPDetailController.submitForApproval';

import { NavigationMixin } from 'lightning/navigation';

export default class WkaCustomAPDetail extends NavigationMixin(LightningElement) {
    @api recordId
    @track openModalClosingMemo = false
    @track disableAcceptButton = false
    @track showSpinner = false

    @wire(getRecord, { recordId: '$recordId', fields: [AML_AP_Stage, Riesgo_AP_Stage, Tesoreria_AP_Stage,
                                                        AML_AP_LastModifiedDate, Riesgo_AP_LastModifiedDate, 
                                                        Tesoreria_AP_LastModifiedDate,
                                                        Tesoreria_RecordId, Riesgo_RecordId, AML_RecordId,
                                                        Pricing_AP_Stage, Pricing_AP_LastModifiedDate, Pricing_RecordId] })
    opportunityRecord

    /* Obtiene los íconos del proceso de aprobación */
    get AML_AP_StageIcon() {        
        return this.getApprovalIcon(getFieldValue(this.opportunityRecord.data, AML_AP_Stage))
    }
    get Riesgo_AP_StageIcon() {        
        return this.getApprovalIcon(getFieldValue(this.opportunityRecord.data, Riesgo_AP_Stage))
    }
    get Tesoreria_AP_StageIcon() {        
        return this.getApprovalIcon(getFieldValue(this.opportunityRecord.data, Tesoreria_AP_Stage))
    }
    get Pricing_AP_StageIcon() {        
        return this.getApprovalIcon(getFieldValue(this.opportunityRecord.data, Pricing_AP_Stage))
    }
    
    /* Obtiene los estatus del proceso de aprobación */
    get AML_AP_Stage() {        
        return getFieldValue(this.opportunityRecord.data, AML_AP_Stage)
    }
    get Riesgo_AP_Stage() {        
        return getFieldValue(this.opportunityRecord.data, Riesgo_AP_Stage)
    }
    get Tesoreria_AP_Stage() {        
        return getFieldValue(this.opportunityRecord.data, Tesoreria_AP_Stage)
    }
    get Pricing_AP_Stage() {        
        return getFieldValue(this.opportunityRecord.data, Pricing_AP_Stage)
    }

    get AML_AP_LastModifiedDate() {      
        console.log('this.opportunityRecord.data ' + JSON.stringify(this.opportunityRecord.data))  
        return getFieldValue(this.opportunityRecord.data, AML_AP_LastModifiedDate)
    }
    get Riesgo_AP_LastModifiedDate() {        
        return getFieldValue(this.opportunityRecord.data, Riesgo_AP_LastModifiedDate)
    }
    get Tesoreria_AP_LastModifiedDate() {        
        return getFieldValue(this.opportunityRecord.data, Tesoreria_AP_LastModifiedDate)
    }
    get Pricing_AP_LastModifiedDate() {        
        return getFieldValue(this.opportunityRecord.data, Pricing_AP_LastModifiedDate)
    }

    /* Obtiene las fechas de modificación del proceso de aprobación */
    getApprovalIcon(value){
        let iconValue
        switch (value) {
            case 'Nuevo':                
                iconValue = 'action:priority'
                break
            case 'Enviado':
                iconValue = 'action:submit_for_approval'
                break
            case 'Recuperado':
                iconValue = 'action:new_child_case'
                break
            case 'Aprobado':
                iconValue = 'action:approval'
                break
            case 'Rechazado':
                iconValue = 'action:close'
                break
            default:
                iconValue = 'action:priority'
                break
        }
        return iconValue

    }
    handleOpenModalClosingMemo(){
        this.openModalClosingMemo = true
        this.disableAcceptButton = true
    }
    handleCloseModalClosingMemo(){
        this.openModalClosingMemo = false
        this.disableAcceptButton = false
    }
    handleAMLOpenRecord(event){
        switch (event.detail.value) {
            case 'AbrirRegistro':
                this.openRecord(getFieldValue(this.opportunityRecord.data, AML_RecordId))
                break;
            default:
        }
    }
    handleRiskOpenRecord(event){
        switch (event.detail.value) {
            case 'AbrirRegistro':
                this.openRecord(getFieldValue(this.opportunityRecord.data, Riesgo_RecordId))
                break;
            default:
        }
    }
    handleTesoreriaOpenRecord(event){
        console.log('test ' + getFieldValue(this.opportunityRecord.data, Tesoreria_RecordId))
        switch (event.detail.value) {
            case 'AbrirRegistro':
                this.openRecord(getFieldValue(this.opportunityRecord.data, Tesoreria_RecordId))
                break;
            default:
        }
    }
    handlePricingOpenRecord(event){
        console.log('test ' + getFieldValue(this.opportunityRecord.data, Pricing_RecordId))
        switch (event.detail.value) {
            case 'AbrirRegistro':
                this.openRecord(getFieldValue(this.opportunityRecord.data, Pricing_RecordId))
                break;
            default:
        }
    }
    openRecord(recordId){
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: recordId,
                objectApiName: 'WKA_Custom_Approval_Process__c', // objectApiName is optional
                actionName: 'view'
            }
        });
    }

    async hanldeSubmitForApproval(){
        this.showSpinner = true
        let recordIds = [];
        recordIds.push(getFieldValue(this.opportunityRecord.data, Tesoreria_RecordId))
        recordIds.push(getFieldValue(this.opportunityRecord.data, Riesgo_RecordId))
        recordIds.push(getFieldValue(this.opportunityRecord.data, AML_RecordId))
        recordIds.push(getFieldValue(this.opportunityRecord.data, Pricing_RecordId))
        let approvalResult
        try{
            approvalResult = await submitForApproval({recordIds : recordIds})
            this.dispatchEvent(
                new ShowToastEvent({
                  title: "Éxito",
                  message: 'El registro se ha enviado para su aprobación',
                  variant: "success"
                })
              );
        } catch(error){
            console.error('error ' + JSON.stringify(error))
            console.error('approvalResult ' + JSON.stringify(approvalResult))
            this.dispatchEvent(
                new ShowToastEvent({
                  title: "Error",
                  message: 'Ourrió un error al envíar el registro, contacte a su administrador',
                  variant: "error"
                })
              );
        }
        this.showSpinner = false
    }

    showPDF(event) {
        event.stopPropagation();

        this[NavigationMixin.GenerateUrl]({
            type: 'standard__webPage',
            attributes: {
                url: '/apex/PDFClosingMemo?id='+this.recordId
            }
        }).then(generatedUrl => {
            window.open(generatedUrl);
        });
    }
}