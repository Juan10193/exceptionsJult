/**
 * @File Name          : customMultipickList.js
 * @Description        : 
 * @Author             : eduardo.amiens@outlook.com
 * @Group              : 
 * @Last Modified By   : eduardo.amiens@outlook.com
 * @Last Modified On   : 13/5/2020 16:44:10
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    24/4/2020   eduardo.amiens@outlook.com     Initial Version
**/
import { LightningElement, track, api, wire} from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import { getObjectInfo,getPicklistValues } from 'lightning/uiObjectInfoApi';
import getLMM_lm_RolPKValues from '@salesforce/apex/lmmExpedienteEstructuraController.getLMM_lm_RolPKValues'
import LMM_lm_Rol from '@salesforce/schema/LMM_Entidad_de_oportunidad__c.LMM_lm_Rol__c';
import LMM_Entidad_de_oportunidad from '@salesforce/schema/LMM_Entidad_de_oportunidad__c';
import ID_FIELD from '@salesforce/schema/LMM_Entidad_de_oportunidad__c.Id';
import { ShowToastEvent } from 'lightning/platformShowToastEvent'
import { updateRecord } from 'lightning/uiRecordApi';

export default class CustomMultipickList extends LightningElement {
    
    @api recordId
    selected = []
    //@api options = []
    @api headLabel = ''
    @api helpLabel = ''

    @api titleModal = ''
    @api acceptButtonName = ''
    @api sizeModal = ''
    @api cancelButtonName = ''
    
    @track openModal = false
    
    @wire(getRecord, { recordId: '$recordId', fields: [LMM_lm_Rol] })
    propertyOrFunction(result){
        if(result.data){
            let v = getFieldValue(result.data, LMM_lm_Rol)
            console.log('bb ' + JSON.stringify(v))
            this.selected = v !== null ? v.split(";") : []
        }
        
        
    }
    
    @wire(getObjectInfo, { objectApiName: LMM_Entidad_de_oportunidad })
    objectInfo
    
    @wire(getPicklistValues, { recordTypeId: '$objectInfo.data.defaultRecordTypeId', fieldApiName: LMM_lm_Rol})
    RolValues

    @wire(getLMM_lm_RolPKValues)
    options

    handleChange(e) {
        console.log('e.detail.value ' + JSON.stringify(e.detail.value))   
        this.selected = e.detail.value
    }
    handleClick(){
        console.log('options ' + JSON.stringify(this.options))   
    }
    handleOpenModal(){
        this.openModal = true
    }
    handleCloseModal(){
        this.openModal = false
    }

    async handleUpdateRoles() {
        this.handleCloseModal()
        const fields = {};
        fields[ID_FIELD.fieldApiName] = this.recordId
        fields[LMM_lm_Rol.fieldApiName] = this.selected !== null ? this.selected.join(";") : ''
        const recordInput = { fields };
        console.log('recordInput ' + JSON.stringify(recordInput))
        try{
            await updateRecord(recordInput)
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success!!',
                    message: 'The rol has been updated ',
                    variant: 'success',
                })
            );
        }catch(error){
            console.log('error ' + JSON.stringify(error))
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'An error has been occurred during update rol',
                    message: error,
                    variant: 'error',
                })
            );
        }
    }
}