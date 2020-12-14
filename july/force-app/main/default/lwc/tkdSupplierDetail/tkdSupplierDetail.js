/**
 * @description       : 
 * @author            : eduardo.amiens@outlook.com
 * @group             : 
 * @last modified on  : 09-27-2020
 * @last modified by  : eduardo.amiens@outlook.com
 * Modifications Log 
 * Ver   Date         Author                       Modification
 * 1.0   08-04-2020   eduardo.amiens@outlook.com   Initial Version
**/
import { LightningElement, api, wire, track } from 'lwc';
import { createRecord, updateRecord, deleteRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex'
import supplierId from '@salesforce/schema/Supplier__c.Id';
import Name from '@salesforce/schema/Supplier__c.Name';
import TKD_tx_Vendor_name_alternative from '@salesforce/schema/Supplier__c.TKD_tx_Vendor_name_alternative__c';
import TKD_tx_Vat_Registration_Num from '@salesforce/schema/Supplier__c.TKD_tx_Vat_Registration_Num__c';
import TKD_pd_Supplier_in_approval from '@salesforce/schema/Supplier__c.TKD_pd_Supplier_in_approval__c';

import getSupplierWithSites from "@salesforce/apex/tkdSupplierDetailController.getSupplierWithSites";
import getSupplierInApprovalId from "@salesforce/apex/tkdSupplierDetailController.getSupplierInApprovalId";

import supplier_OBJECT from '@salesforce/schema/Supplier__c';

import cloneSite from "@salesforce/apex/tkdSupplierDetailController.cloneSite";


const actions = [
    { label: 'Show details', name: 'show_details' },
    { label: 'Delete', name: 'delete' },
    { label: 'Clone', name: 'clone' },
];

const columns = [
    { label: 'Name', fieldName: 'Name' },
    { label: 'Country', fieldName: 'TKD_tx_Country__c' },
    { label: 'State', fieldName: 'TKD_ls_State__c' },
    { label: 'City', fieldName: 'Tkd_tx_City__c' },
    {
        type: 'action',
        typeAttributes: { rowActions: actions },
    },
];
export default class TkdSupplierDetail extends LightningElement {
    @api supplierId
    @api takedownId
    @track supplierInApprovalId
    @track openModalAskDelete = false
    @track openModalAskClone = false
    @track recordToWork

    @track readonly = true

    isReadOnly

    @track sitesData = []
    columns = columns;
    resultGetRecord

    @track selectedSiteId = ''

    isSelectedEditing
    isReadOnly

    connectedCallback() {
        console.log('constructor ' + JSON.stringify(this.supplierId))
        //Si existe un registro para edición, el botón tendrá la opción de editar
        //y los campos estarán de solo lectura
        if (this.supplierId !== null && this.supplierId !== undefined) {
            this.isSelectedEditing = false
            this.isReadOnly = true
        } else { // si no existe el registro, los campos serán editables
            this.isSelectedEditing = true
            this.isReadOnly = false
        }
        this.dispatchEvent(new CustomEvent('disablesave', { detail: this.isReadOnly }));
    }

    @wire(getSupplierInApprovalId, { takedownId: '$takedownId' })
    async wiregetSupplierInApprovalId(result) {
        let loadProgress = {getSupplierInApprovalId : true}
        if (await result.data) {
            this.supplierInApprovalId = result.data
            this.dispatchEvent(new CustomEvent('loadcomplete', { detail: loadProgress }))
        } else if(result.error) {
            console.error('Error al consultar getSupplierInApprovalId' + JSON.stringify(getSupplierInApprovalId))
            this.dispatchEvent(new CustomEvent('loadcomplete', { detail: loadProgress }))
        }
        console.log('this.supplierInApprovalId ' + JSON.stringify(this.supplierInApprovalId))
    }

    @wire(getSupplierWithSites, { supplierId: '$supplierId' })
    async wiregetSupplierWithSites(result) {
        let loadProgress = {wiregetSupplierWithSites : true}
        console.log('supplier detail id ' + this.supplierId)
        console.log('takedownId ' + this.takedownId)
        console.log('supplierInApprovalId ' + this.supplierInApprovalId)
        console.log('wireGetRecordResult result ' + JSON.stringify(result))
        this.resultGetRecord = result
        if (await result.data) {
            this.template.querySelector("[data-field='vendorName']").value = result.data.Name
            this.template.querySelector("[data-field='vendorNameAlt']").value = result.data.TKD_tx_Vendor_name_alternative__c
            this.template.querySelector("[data-field='vatRegistrationNum']").value = result.data.TKD_tx_Vat_Registration_Num__c
            this.sitesData = result.data.Sites__r
            this.dispatchEvent(new CustomEvent('loadcomplete', { detail: loadProgress }))
        } else if (await result.error) {
            console.log('An error has been ocurred ' + JSON.stringify(result.error))
            this.dispatchEvent(new CustomEvent('loadcomplete', { detail: loadProgress }))
        }
        if (this.supplierId === null || this.supplierId === undefined) {
            this.readonly = false
        }
        
        
    }

    handleUpdate() {

    }
    handleRowAction(event) {
        const actionName = event.detail.action.name;
        const row = event.detail.row;
        switch (actionName) {
            case 'delete':
                this.askToDeleteRow(row);
                break;
            case 'show_details':
                this.handleOpenModalSiteDetail(row);
                break;
            case 'clone':
                this.askToCloneRecord(row);
                break;
            default:
        }
    }
    askToCloneRecord(row) {
        console.log('delete ' + JSON.stringify(row.Id))
        this.openModalAskClone = true
        this.recordToWork = row.Id
    }
    async cloneSiteRecord(){
        this.openModalAskClone = false
        try{
            await cloneSite({siteId:this.recordToWork})
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Record has been cloned',
                    variant: 'success'
                })
            );
            refreshApex(this.resultGetRecord)
        } catch(error){
            console.log('error ' + JSON.stringify(error))
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Record has been cloned',
                    variant: 'success'
                })
            );
        }
    }
    askToDeleteRow(row) {
        console.log('delete ' + JSON.stringify(row.Id))
        this.openModalAskDelete = true
        this.recordToWork = row.Id
    }
    closeModal() {
        this.openModalAskClone = false
        this.openModalAskDelete = false
        this.recordToWork = undefined
    }
    deleteRow() {
        deleteRecord(this.recordToWork)
            .then(() => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Record deleted',
                        variant: 'success'
                    })
                );
                refreshApex(this.resultGetRecord)
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error deleting record',
                        message: error,
                        variant: 'error'
                    })
                );
            });
        this.openModalAskDelete = false
        this.recordToWork = undefined
    }

    showRowDetails(row) {
        this.record = row;
    }
    async handleOpenModalSiteDetail(row) {
        let siteId = ''
        if (row !== null && row !== undefined)
            siteId = row.Id
        if (await this.handleSave())
            this.dispatchEvent(new CustomEvent('opensitemodal', { detail: siteId }));
    }
    @api
    async handleSave() {
        let resultOperation = false
        const allValidInputFields = [...this.template.querySelectorAll('lightning-input')]
            .reduce((validSoFar, inputFields) => {
                inputFields.reportValidity();
                return validSoFar && inputFields.checkValidity();
            }, true);
        console.log('allValidInputFields ' + allValidInputFields)
        if (allValidInputFields) {
            if (this.supplierId === null || this.supplierId === undefined) {
                console.log('Está creando un registro')
                await this.createSupplier()
                resultOperation = true
            } else {
                console.log('Está actualizando un registro')
                await this.updateSupplier()
                resultOperation = true
            }
        } else {
            // The form is not valid
            resultOperation = false
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Something is wrong',
                    message: 'Check your input and try again.',
                    variant: 'error'
                })
            );
        }
        return resultOperation
    }
    getFields() {
        const fields = {}
        if (this.supplierId !== null && this.supplierId !== undefined)
            fields[supplierId.fieldApiName] = this.supplierId
        fields[Name.fieldApiName] = this.template.querySelector("[data-field='vendorName']").value
        fields[TKD_tx_Vendor_name_alternative.fieldApiName] = this.template.querySelector("[data-field='vendorNameAlt']").value
        fields[TKD_tx_Vat_Registration_Num.fieldApiName] = this.template.querySelector("[data-field='vatRegistrationNum']").value
        if (this.supplierId === null || this.supplierId === undefined)
            fields[TKD_pd_Supplier_in_approval.fieldApiName] = this.supplierInApprovalId
        console.log('fields ' + JSON.stringify(fields))
        return fields
    }
    async createSupplier() {
        const fields = this.getFields()

        const recordInput = { apiName: supplier_OBJECT.objectApiName, fields }
        await createRecord(recordInput)
            .then(supplier => {
                console.log('supplier ' + JSON.stringify(supplier))
                this.supplierId = supplier.id;
                console.log('this.supplierId ' + JSON.stringify(this.supplierId))
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Supplier created',
                        variant: 'success',
                    }),
                );
                this.dispatchEvent(new CustomEvent('handlegetsaveresultsupplier', { detail: this.supplierId }));
                this.invertButtons()
            })
            .catch(error => {
                console.error('error ' + JSON.stringify(error))
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error creating record',
                        message,
                        variant: 'error',
                    }),
                );
            });
    }
    async updateSupplier() {
        console.log('Inicia updateSupplier')
        const fields = this.getFields();
        const recordInput = { fields };
        await updateRecord(recordInput)
            .then(() => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Record updated',
                        variant: 'success'
                    })
                );
                this.invertButtons()
                refreshApex(this.resultGetRecord)

            })
            .catch(error => {
                console.error('error ' + JSON.stringify(error))
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error update record',
                        message,
                        variant: 'error'
                    })
                );
            });

    }
    async invertButtons() {
        this.isReadOnly = await this.isSelectedEditing
        this.isSelectedEditing = await !this.isSelectedEditing
        this.dispatchEvent(new CustomEvent('disablesave', { detail: this.isReadOnly }));

        //this.asignData()
    }
    validateChanges() {
        let someFieldHasChanged = false
        if (this.resultGetRecord.data)
            if (this.template.querySelector("[data-field='vendorName']").value !== this.resultGetRecord.data.Name
                || this.template.querySelector("[data-field='vendorNameAlt']").value !== this.resultGetRecord.data.TKD_tx_Vendor_name_alternative__c
                || this.template.querySelector("[data-field='vatRegistrationNum']").value !== this.resultGetRecord.data.TKD_tx_Vat_Registration_Num__c) {
                someFieldHasChanged = true
            }
        console.log('someFieldHasChanged ' + someFieldHasChanged)
        return someFieldHasChanged
    }
    @api
    handleEditClick() {
        if (this.isSelectedEditing === true && this.validateChanges()) {
            this.handleSave()
        } else if (this.supplierId !== null && this.supplierId !== undefined) {
            this.invertButtons()
        }
        this.dispatchEvent(new CustomEvent('disablesave', { detail: this.isReadOnly }));
    }
    handleCopyVendorName() {
        if (this.template.querySelector("[data-field='vendorName']").value !== null) {
            this.template.querySelector("[data-field='vendorNameAlt']").value = this.template.querySelector("[data-field='vendorName']").value
        }
    }
    handleUpperCaseRFC() {
        if (this.template.querySelector("[data-field='vatRegistrationNum']").value !== null) {
            this.template.querySelector("[data-field='vatRegistrationNum']").value.toUpperCase()
        }

    }
    @api
    async handleRefreshRecord() {
        console.log('handleRefreshRecord')
        JSON.stringify(this.resultGetRecord)
        await refreshApex(this.resultGetRecord)
    }

}