/**
 * @File Name          : takedownTableABForm.js
 * @Description        : 
 * @Author             : eduardo.villegas@engeniumcapital.com
 * @Group              : 
 * @Last Modified By   : eduardo.amiens@outlook.com
 * @Last Modified On   : 10-20-2020
 * @Modification Log   : 
 *==============================================================================
 * Ver         Date                     Author      		      Modification
 *==============================================================================
 * 1.0    29/8/2019 16:13:56   eduardo.villegas@engeniumcapital.com     Initial Version 
 **/
import { LightningElement, wire, track, api } from "lwc";
import blank from './views/blank.html';
import mainpage from './takedownTableABForm.html';
import getAssetBreakdownObj from "@salesforce/apex/takedownTableABFormController_cls.getAssetBreakdown";
import getTakedownFields from "@salesforce/apex/takedownTableABFormController_cls.getTakedownFields";
import { getRecord, deleteRecord } from 'lightning/uiRecordApi';
import InsertDocumentAndUpdateInvoice from "@salesforce/apex/Takedown_Invoices_cls.InsertDocumentAndUpdateInvoice"
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';


import constantes from './helperJS/constantes';

export default class TakedownTableABForm extends LightningElement {
    @api recordid;
    @api takedownid;
    @track takedownInvoiceId = '';
    @api formMode;
    @track disableEdition = false
    @track objectApiName = 'Asset';
    @track selectedValue;
    @track navigationData = constantes.SECTIONS;
    @track openRecord;
    _takedownInvoiceData;
    @track section = blank;
    @track disableUploadFieldNewVersion = true
    fields = constantes.FIELDS_FORM;
    @track formAccountID
    @track formTakedownID
    @track formInvoiceID
    @track readOnly = true
    @track disableDelete = true
    @track openModalDeleteAsset = false
    @track isNewAsset = false
    @track resultSetNavigationMenu


    connectedCallback() {
        if (this.formMode === 'readonly') {
            this.disableEdition = true
        }
        this.formMode = 'readonly'
    }

    /*@wire(getRecord, { recordId: "$recordid", fields: constantes.FIELDS_TO_GET_RECORD })
    async getTakedownInvoiceRecord({ error, data }) {
        if (await data) {
            console.log('dataHIfi' + JSON.stringify(data))
            
            this.openRecord = '/' + data.id
            console.log('this.openRecord ' +this.openRecord)
            
            this._takedownInvoiceData = data      
            console.log('this._takedownInvoiceData ' + JSON.stringify(this._takedownInvoiceData)) 

            if(data.fields.TKD_txt_Content_Version_ID__c.value === null 
                || data.fields.TKD_txt_Content_Version_ID__c.value === undefined
                || data.fields.TKD_txt_Content_Version_ID__c.value === ''){
                    this.disableUploadFieldNewVersion = false
                }
            await getAssetBreakdownObj({ takedownInvoiceId: data.id })
                .then(result => {
                    console.log('JSON.stringify(result) ' + JSON.stringify(result))
                    let navigationItems = []
                    for (let ab of result) {
                        console.log('JSON.stringify(ab) ' + JSON.stringify(ab))
                        navigationItems.push({ label: ab.Name, name: ab.Id, icon:'utility:quote' });
                    }
                    this.navigationData.items = navigationItems;
                    this.section= mainpage;

                }).catch(errores => {
                    this.dispatchEvent(new ShowToastEvent({
                        title: 'Error to get Assets',
                        message: error.body.message,
                        variant: 'error',
                    }))
                })
            
        } else if (error) {
            this.dispatchEvent(new ShowToastEvent({
                title: 'Error to get Takedown invoices',
                message: error.body.message,
                variant: 'error',
            }))
            
        }
    }*/

    @wire(getRecord, { recordId: "$recordid", fields: constantes.FIELDS_TO_GET_RECORD })
    async getTakedownInvoiceRecord(result) {
        this.section = blank
        this._takedownInvoiceData = result

        if (await result.data) {
            console.log('dataHIfi' + JSON.stringify(result.data))

            this.openRecord = '/' + result.data.id
            console.log('this.openRecord ' + this.openRecord)


            console.log('this._takedownInvoiceData ' + JSON.stringify(this._takedownInvoiceData))
            console.log('result.data.fields.TKD_txt_Content_Version_ID__c.displayValue ' + result.data.fields.TKD_txt_Content_Version_ID__c.displayValue)

            if (result.data.fields.TKD_txt_Content_Version_ID__c.displayValue === null
                || result.data.fields.TKD_txt_Content_Version_ID__c.displayValue === undefined
                || result.data.fields.TKD_txt_Content_Version_ID__c.displayValue === '') {
                console.log('hola')
                this.disableUploadFieldNewVersion = false
            }
            this.takedownInvoiceId = await result.data.id
            /*
                        await getAssetBreakdownObj({ takedownInvoiceId: result.data.id })
                            .then(result => {
                                console.log('JSON.stringify(result) ' + JSON.stringify(result))
                                let navigationItems = []
                                for (let ab of result) {
                                    console.log('JSON.stringify(ab) ' + JSON.stringify(ab))
                                    navigationItems.push({ label: ab.Name, name: ab.Id, icon: 'utility:quote' });
                                }
                                this.navigationData.items = navigationItems;
                                //this.section= mainpage;
            
                            }).catch(errores => {
                                this.dispatchEvent(new ShowToastEvent({
                                    title: 'Error to get Assets',
                                    message: error.body.message,
                                    variant: 'error',
                                }))
                            })*/
        } else if (result.error) {
            this.dispatchEvent(new ShowToastEvent({
                title: 'Error to get Takedown invoices',
                message: result.error.body.message,
                variant: 'error',
            }))

        }
        this.section = mainpage;
    }
    @wire(getAssetBreakdownObj, { takedownInvoiceId: "$recordid" })
    setNavigationMenu(result) {
        this.resultSetNavigationMenu = result
        if (result.data) {
            console.log('mira ' + JSON.stringify(result.data))
            let navigationItems = []
            for (let ab of result.data) {
                console.log('JSON.stringify(ab) ' + JSON.stringify(ab))
                navigationItems.push({ label: ab.Name, name: ab.Id, icon: 'utility:quote' });
            }
            this.navigationData.items = navigationItems;
        }

    }
    get acceptedFormats() {
        return ['.pdf', '.xml'];
    }

    handleUploadFinished(event) {
        // Get the list of uploaded files
        const uploadedFiles = event.detail.files;
        console.log(uploadedFiles);
        let contentfiles = [];
        for (let file of uploadedFiles) {
            contentfiles.push(file.documentId);
        }

        console.log('listaIDS CONTENT');
        console.log(contentfiles);

        InsertDocumentAndUpdateInvoice({ recordId: this.recordid, contentDocumentIds: contentfiles })
            .then(result => {
                console.log('se insertaron los invoces de forma satisfactoria');
                //fireEvent(this.pageRef,'refreshtable');
                this.dispatchEvent(new ShowToastEvent({
                    title: 'No. of files uploaded : ' + uploadedFiles.length,
                    variant: 'info',
                }))
                //eval("$A.get('e.force:refreshView').fire();");
                this.closeModal();
            }).catch(errores => {
                let message = "Unknown error";
                if (Array.isArray(errores.body)) {
                    message = errores.body.map(e => e.message).join(", ");
                } else if (typeof errores.body.message === "string") {
                    message = errores.body.message;
                }
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: "Error to insert invoices",
                        message,
                        variant: "error"
                    })
                );
            })

    }

    handleSelect(event) {
        console.log('event ' + JSON.stringify(event));
        this.isNewAsset = false
        this.selectedValue = event.detail.name;
        if (this.disableEdition === false) {
            this.formMode = 'view'
            this.disableDelete = false
        }
    }
    async handleNewAsset() {
        this.isNewAsset = true
        this.handleReset();
        let takedown = await getTakedownFields({ takedownid: this.takedownid })
        console.log('takedown ' + JSON.stringify(takedown))
        console.log('this.takedownid ' + this.takedownid)
        console.log('this.recordid ' + this.recordid)

        if (takedown.CPL_rb_Opp__r) {
            this.formAccountID = takedown.CPL_rb_Opp__r.AccountId
            this.formTakedownID = this.takedownid
            this.formInvoiceID = this.recordid
            console.log('this.formAccountID ' + this.formAccountID)
            console.log('this.takedownid ' + this.takedownid)
            console.log('this.recordid ' + this.recordid)
        }

        this.selectedValue = ''
        if (this.disableEdition === false) {
            this.formMode = 'edit'
        }
    }
    handleSuccess(event) {
        console.log('mira event.detail ' + event.detail)
        this.section = blank
        this.isNewAsset = false
        this.dispatchEvent(
            new ShowToastEvent({
                title: "Success!!",
                message: 'The record has been saved.',
                variant: "Success"
            })
        );
        this.handleReset();
        this.section = mainpage
        return refreshApex(this.resultSetNavigationMenu);
    }
    handleCancel() {
        this.isNewAsset = false
    }
    handleReset() {
        try {
            this.disableDelete = true
            const inputFields = this.template.querySelectorAll(
                'lightning-input-field'
            );
            if (inputFields) {
                console.log(inputFields)
                inputFields.forEach(field => {
                    console.log('fieldrest ' + field)
                    field.reset();
                });
            }
        } catch (error) {
            console.log('error')
            console.log(error)
        }

    }
    async handleDeleteAsset() {
        try {
            await deleteRecord(this.selectedValue)
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Record deleted',
                    variant: 'success'
                })
            );

        } catch (error) {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error deleting record',
                    message: error.body.message,
                    variant: 'error'
                })
            );
        }
        this.openModalDeleteAsset = false
        this.closeModal()
        return refreshApex(this.resultSetNavigationMenu);
    }
    handleOpenModalDeleteAsset() {
        this.openModalDeleteAsset = true

    }
    handleCloseModals() {
        this.openModalDeleteAsset = false
    }
    closeModal() {
        this.navigationData.items = [];
        this.selectedValue = '';
        this.dispatchEvent(new CustomEvent('closemodal'));
    }

    render() {
        return this.section;
    }
    @api
    refresh() {
        return refreshApex(this.resultSetNavigationMenu);
    }
}