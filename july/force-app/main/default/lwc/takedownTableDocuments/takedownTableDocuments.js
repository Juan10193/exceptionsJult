/**
 * @File Name          : takedownTableDocuments.js
 * @Description        : 
 * @Author             : jvillegas@freewayconsulting.com
 * @Group              : 
 * @Last Modified By   : eduardo.villegas@engeniumcapital.com
 * @Last Modified On   : 23/12/2019 14:46:50
 * @Modification Log   : 
 *==============================================================================
 * Ver         Date                     Author      		      Modification
 *==============================================================================
 * 1.0    10/7/2019 10:53:25   jvillegas@freewayconsulting.com     Initial Version
 **/
/*PushTopic
PushTopic pushTopic = new PushTopic();
pushTopic.Name = 'TakedownInvoiceUpdates';
pushTopic.Query = 'SELECT TKD_pd_Takedown_CP__c, TKD_txt_Content_Version_ID__c, TKD_txt_Document_ID__c, TKD_txt_Extension__c, TKD_ls_SAT_Status__c, TKD_ls_Eng_Status__c, Id, Name FROM Takedown_Invoice__c where TKD_txt_Extension__c != \'pdf\'';
pushTopic.ApiVersion = 46.0;
pushTopic.NotifyForOperationCreate = false;
pushTopic.NotifyForOperationUpdate = true;
pushTopic.NotifyForOperationUndelete = false;
pushTopic.NotifyForOperationDelete = false;
pushTopic.NotifyForFields = 'Referenced';
insert pushTopic; 
takedownTableDocumentsFilter
*/
import { LightningElement, wire, track, api } from "lwc";
import { CurrentPageReference } from 'lightning/navigation';
import {registerListener } from 'c/pubsub';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';
import { getRecord } from 'lightning/uiRecordApi';
import getDocumentList from "@salesforce/apex/takedownTableDocumentsController_cls.getDocumentList";
import getAssetBreakdownObj from "@salesforce/apex/takedownTableDocumentsController_cls.getAssetBreakdown";
import deleteInvoice from "@salesforce/apex/takedownTableDocumentsController_cls.deleteInvoice";
import deleteInvoices from "@salesforce/apex/takedownTableDocumentsController_cls.deleteInvoices";
import UploadAndValidateInvoices from "@salesforce/apex/takedownTableDocumentsController_cls.uploadAndValidateInvoices";
import getBooleanIfHaveAB from "@salesforce/apex/takedownTableDocumentsController_cls.haveAB";
//import submitToReview from "@salesforce/apex/takedownTableDocumentsController_cls.submitToReview";
import getTakedownVisibilityISCSubmit from "@salesforce/apex/takedownTableDocumentsController_cls.getTakedownVisibilityISCSubmit";
import getTakedownVisibilityBlockAB from "@salesforce/apex/takedownTableDocumentsController_cls.getTakedownVisibilityBlockAB";

//import blockAB from "@salesforce/apex/takedownTableDocumentsController_cls.blockAB";
import {makeOrderHeaderFields, makeOrderLineFields, workDownload} from './helperJS/downloadContractImport';
import exceljs from '@salesforce/resourceUrl/exceljs';
import filesaver from '@salesforce/resourceUrl/filesaver';
import { loadScript, loadStyle } from 'lightning/platformResourceLoader';
import getContractImport from "@salesforce/apex/Takedown_XLSX_Contract_Import_lwc_cls.getContractImport";
//https://daneden.github.io/animate.css/
import Animate from  '@salesforce/resourceUrl/Animate';
import constantes from './helperJS/constantes';
import blank from './views/blank.html';
import mainpage from './takedownTableDocuments.html';


export default class DatatableUpdateExample extends LightningElement {
    @track isButtonDisabled = true;
    @api recordId;
    @track TKD_ls_asset_type;
    @api takedownInvoiceId;
    @api refresh = false;
    @track error;
    @track columns = constantes.COLS;
    @track draftValues = [];
    @track invoices = [];
    @track openmodel = false;
    @track openmodelAB = false;
    @track openmodelFilter = false;
    @track openmodelAskDeleteInvoice = false;
    @track openmodelAskDeleteInvoices = false;
    @track sortBy;
    @track sortDirection;
    @track hasError = '';
    @track StatePicklistValues;
    @track selectedValue;
    @track filterdoctype;
    @track takedownObject;
    @track section = mainpage;
    @track idInvoice;
    @track documentId;
    documentsToDelete = [];

    @track toggleLockABLabel = 'Lock AB';
    @track toggleLockABIconName = 'utility:lock';
    @track disableOpenAB = true;
    @track disableSubmitToReview = true;
    @track disableLockAB = true;

    @wire(getBooleanIfHaveAB, { takedownID: "$recordId"})
    haveAssetBreakdown;

    @wire(getRecord, { recordId: "$recordId", fields: constantes.FIELDS })
    async wireRecord({ error, data }) {
        if (error) {
            this.dispatchEvent(new ShowToastEvent({
                title: 'Error to get Takedown CP',
                message: error.body.message,
                variant: 'error',
            }))
        } else if (data) {
            this.TKD_ls_asset_type = data.fields.TKD_ls_asset_type__c.value;
            // eslint-disable-next-line no-console
            console.log('data' + JSON.stringify(data));
            this.takedownObject = data;            
            await getTakedownVisibilityISCSubmit()
            .then(result => {
                console.log('resultsa ' + result)                
                if(this.takedownObject.fields.TKD_ca_Notify_to_Prebook__c.value === false
                    & result === true){
                        this.disableSubmitToReview = false;
                    } else {
                        this.disableSubmitToReview = true;
                    }         
                    
                    console.log('disableSubmitToReview ' + this.disableSubmitToReview)
            }).catch(errores => {
                let message = "Unknown error";
                if (Array.isArray(errores.body)) {
                    message = errores.body.map(e => e.message).join(", ");
                } else if (typeof errores.body.message === "string") {
                    message = errores.body.message;
                }
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: "Error to getTakedownVisibilityISCSubmit",
                        message,
                        variant: "error"
                    })
                );
            })
            await getTakedownVisibilityBlockAB()
            .then(result => {
                console.log('resultsa ' + result) 
                this.disableLockAB = result === true ? false : true;
                if(this.haveAssetBreakdown.data === true){
                    this.toggleLockABIconName = 'utility:unlock';
                    this.toggleLockABLabel = 'Unlock AB';
                    this.disableOpenAB = true                  
                } else if(this.haveAssetBreakdown.data === false){
                    this.toggleLockABIconName = 'utility:lock';
                    this.toggleLockABLabel = 'Lock AB';
                    this.disableOpenAB = false
                }                     
                    console.log('disableSubmitToReview ' + this.disableSubmitToReview)
            }).catch(errores => {
                let message = "Unknown error";
                if (Array.isArray(errores.body)) {
                    message = errores.body.map(e => e.message).join(", ");
                } else if (typeof errores.body.message === "string") {
                    message = errores.body.message;
                }
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: "Error to getTakedownVisibilityISCSubmit",
                        message,
                        variant: "error"
                    })
                );
            })
        }
    }
    @wire(CurrentPageReference) 
    pageRef;

    @wire(getDocumentList, { recordId: "$recordId", listFilterDocType: '$filterdoctype' })
    takedownInvoice;

    @wire(getAssetBreakdownObj, { takedownInvoiceId: "$takedownInvoiceId" })
    assetBreakdown(result) {
        if (result.data) {
            // eslint-disable-next-line no-console
            console.log('Verifica getAssetBreakdownObj');
            // eslint-disable-next-line no-console
            console.log('Verifica ' + result.data);
            let PicklistValues = [];
            this.pickListTable = result;
            for (let ab of result.data) {
                PicklistValues.push({ label: ab.Name, value: ab.Id });
            }
            this.StatePicklistValues = PicklistValues;
        } else if (result.error) {
            // eslint-disable-next-line no-console
            console.log('Error ' + JSON.stringify(result.error));
        }
    }

    // Handles click on the 'Show/hide content' button
    /*async handleSubmitToReview() {
        this.section = blank; 
        await submitToReview({takedownId: this.recordId})
            .then(result => {          
                this.disableSubmitToReview = true;               
                    refreshApex(this.takedownObject);                    
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Success',
                            message: 'The record has been submited to booking',
                            variant: 'success'
                        })
                    );
            }).catch(errores => {
                let message = "Unknown error";
                if (Array.isArray(errores.body)) {
                    message = errores.body.map(e => e.message).join(", ");
                } else if (typeof errores.body.message === "string") {
                    message = errores.body.message;
                }
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: "Error to submit to review",
                        message,
                        variant: "error"
                    })
                );
            })
            this.section = mainpage;
    }*/

    // Handles click on the 'Show/hide content' button
    async handleToggleLockABClick() {
        this.section = blank; 
        // if the current icon-name is `utility:preview` then change it to `utility:hide`
        if (this.toggleLockABIconName === 'utility:lock') {
            this.toggleLockABIconName = 'utility:unlock';
            this.toggleLockABLabel = 'Unlock AB';
            this.disableOpenAB = true
        } else {
            this.toggleLockABIconName = 'utility:lock';
            this.toggleLockABLabel = 'Lock AB';
            this.disableOpenAB = false
        }


        /*
        console.log('haveAssetBreakdown ' + JSON.stringify(this.haveAssetBreakdown))
        if(this.haveAssetBreakdown.data === false){
            this.disableOpenAB = false
        } else if(this.haveAssetBreakdown.data === true 
            & this.takedownObject.fields.TKD_ca_Block_AB__c.value === false){
            this.disableOpenAB = true
        } else if(this.haveAssetBreakdown.data === true 
            & this.takedownObject.fields.TKD_ca_Block_AB__c.value === true){
            this.disableOpenAB = false
        }*/
        let scenario = this.disableOpenAB === true ? 'blocked' : 'unblocked';
        /*await blockAB({takedownId: this.recordId, TKD_ca_Block_AB : this.disableOpenAB})
            .then(result => {
                refreshApex(this.takedownObject);                    
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Success',
                            message: 'The Asset Breakdown has been' + scenario,
                            variant: 'success'
                        })
                    );
            }).catch(errores => {
                let message = "Unknown error";
                if (Array.isArray(errores.body)) {
                    message = errores.body.map(e => e.message).join(", ");
                } else if (typeof errores.body.message === "string") {
                    message = errores.body.message;
                }
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: "Error to " + scenario + " Asset Breakdown",
                        message,
                        variant: "error"
                    })
                );
            })
            this.section = mainpage;*/
    }

    /****************************************** */
    //Handles the error
    handleError(event) {
        //Error is coming in the event.detail.error
        this.error = JSON.stringify(event.detail.error);
    }

    //Handles the message/payload from streaming api
    handleMessage(event) {
            //Message is coming in event.detail.payload
            this.payload = this.payload + JSON.stringify(event.detail.payload);
            // eslint-disable-next-line no-console
            console.log('this.payload ' + this.payload);
            refreshApex(this.takedownInvoice);
            refreshApex(this.haveAssetBreakdown);
    }
    connectedCallback() {
        this.filterdoctype = ["xml", "pdf"];
        Promise.all([
            loadStyle(this, Animate)
        ]).then(() => { 'scripts cargadinos' });
        registerListener('refreshtable', this.refreshTable, this);        
    }

    blockAB() {
        console.log('haveAssetBreakdown ' + JSON.stringify(this.haveAssetBreakdown))
        if(this.haveAssetBreakdown.data === false){
            this.disableOpenAB = false
        } else if(this.haveAssetBreakdown.data === true 
            & this.takedownObject.fields.TKD_ca_Block_AB__c.value === false){
            this.disableOpenAB = true
        } else if(this.haveAssetBreakdown.data === true 
            & this.takedownObject.fields.TKD_ca_Block_AB__c.value === true){
            this.disableOpenAB = false
        }
        blockAB({takedownId: this.recordId, TKD_ca_Block_AB : this.disableOpenAB})
            .then(result => {
                refreshApex(this.takedownInvoice);
                eval("$A.get('e.force:refreshView').fire();");
            }).catch(errores => {
                let message = "Unknown error";
                if (Array.isArray(errores.body)) {
                    message = errores.body.map(e => e.message).join(", ");
                } else if (typeof errores.body.message === "string") {
                    message = errores.body.message;
                }
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: "Error to block Asset Breakdown",
                        message,
                        variant: "error"
                    })
                );
            })
    }

    handleRowAction(event) {
        const actionName = event.detail.action.name;
        this.idInvoice = event.detail.row.Id;
        this.documentId = event.detail.row.TKD_txt_Document_ID__c;
        const extension = event.detail.row.TKD_txt_Extension__c;
        const name = event.detail.row.Name;
        //const documentId = event.detail.row.TKD_txt_Document_ID__c;
        const takedownInvoiceId = event.detail.row.Id;

        switch (actionName) {
            case 'delete':
                //this.deleteRow();
                this.documentsToDelete = [{Name : name, Extension : extension}];
                // eslint-disable-next-line no-console
                console.log('JSON.stringify(this.documentsToDelete) ' + JSON.stringify(this.documentsToDelete))
                this.openmodalAskDeleteInvoice();
                break;
            case 'preview':
                this.openDocument(this.documentId);
                break;
            case 'assetbd':
                this.openmodal(takedownInvoiceId);
                break;
            case 'openrecord':
                this.openInvoice(takedownInvoiceId);
                break;
            default:
        }

    }

    async deleteRow() {
        this.closeModal();
        this.section = blank;
        await deleteInvoice({ idInvoice: this.idInvoice, takedownDocId: this.documentId })
            .then(result => {
                eval("$A.get('e.force:refreshView').fire();");
                return refreshApex(this.takedownInvoice);
            }).catch(errores => {
                let message = "Unknown error";
                if (Array.isArray(errores.body)) {
                    message = errores.body.map(e => e.message).join(", ");
                } else if (typeof errores.body.message === "string") {
                    message = errores.body.message;
                }
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: "Error to delete invoices",
                        message,
                        variant: "error"
                    })
                );
            })
            this.section = mainpage;
    }

    async multidelete() {
        this.closeModal();
        this.section = blank;
        if (this.invoices.length > 0) {
            let invoices = [];
            let documents = [];
            for (let invoice of this.invoices) {
                invoices.push(invoice.Id);
                documents.push(invoice.TKD_txt_Document_ID__c);
            }
            //this.documentsToDelete = [{name : name, extension : extension}];

            await deleteInvoices({ invoices: invoices, documents: documents })
                .then(result => {
                    refreshApex(this.takedownInvoice);
                    eval("$A.get('e.force:refreshView').fire();");
                }).catch(errores => {
                    let message = "Unknown error";
                    if (Array.isArray(errores.body)) {
                        message = errores.body.map(e => e.message).join(", ");
                    } else if (typeof errores.body.message === "string") {
                        message = errores.body.message;
                    }
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: "Error to delete invoices",
                            message,
                            variant: "error"
                        })
                    );
                })
        }
        this.section = mainpage;
        
    }

    getSelectedRows(event) {
        this.invoices = event.detail.selectedRows;
        if (this.invoices == null || this.invoices === undefined || this.invoices.length === 0) {
            this.isButtonDisabled = true;
        } else {
            this.isButtonDisabled = false;
        }
    }

    openInvoice(takedownInvoiceId) {
        window.open('/' + takedownInvoiceId, '_blank');
    }
    openDocument(documentId) {
        window.open('/' + documentId, '_blank');
    }

    refreshTable() {
        eval("$A.get('e.force:refreshView').fire();");
        return refreshApex(this.takedownInvoice);
    }

    handlechange() {
        return refreshApex(this.takedownInvoice);
    }
    async validateInvoices() {
        console.log('this.TKD_ls_asset_type ' + JSON.stringify(this.TKD_ls_asset_type));
        if (this.TKD_ls_asset_type === null || this.TKD_ls_asset_type === undefined || this.TKD_ls_asset_type === '') {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: "Sorry we can't upload and validate files",
                    message : 'Please write the "Asset Type" field into detail section from Takedown CP',
                    variant: "warning"
                })
            );    
        } else if (this.invoices.length > 0) {
            let selectedInvoices = [];
            for (let invoice of this.invoices) {
                selectedInvoices.push({
                    id: invoice.Id,
                    name: invoice.Name,
                    TKD_fm_validation: invoice.TKD_fm_validation__c,
                    TKD_ls_Status: invoice.TKD_ls_Status__c,
                    TKD_pd_Takedown_CP: invoice.TKD_pd_Takedown_CP__c,
                    TKD_txt_Content_Version_ID: invoice.TKD_txt_Content_Version_ID__c,
                    TKD_txt_Document_ID: invoice.TKD_txt_Document_ID__c,
                    TKD_txt_Extension: invoice.TKD_txt_Extension__c,
                    TKD_ls_asset_type: this.TKD_ls_asset_type,
                    AccountId: invoice.TKD_pd_Takedown_CP__r.CPL_rb_Opp__r.AccountId
                });
            }
            this.section = blank;
            // eslint-disable-next-line no-console
            await UploadAndValidateInvoices({ listTableElement: selectedInvoices })
                .then(result => {
                    // eslint-disable-next-line no-console
                    refreshApex(this.takedownInvoice);
                    eval("$A.get('e.force:refreshView').fire();");
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Success!!',
                            message: 'The documents are in process, this can take a few minutes!!!',
                            variant: 'success',
                        }),
                    );
                }).catch(errores => {
                    // eslint-disable-next-line no-console
                    console.log('no se han cargado las facturas');
                    let message = "Unknown error";
                    if (Array.isArray(errores.body)) {
                        message = errores.body.map(e => e.message).join(", ");
                    } else if (typeof errores.body.message === "string") {
                        message = errores.body.message;
                    }
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: "Error to upload invoices",
                            message,
                            variant: "error"
                        })
                    );
                })
        }
        this.section = mainpage;
        return refreshApex(this.takedownInvoice);
    }
    openmodalAskDeleteInvoice() {        
        this.openmodelAskDeleteInvoice = true
    }
    openmodalAskDeleteInvoices() {        
        this.openmodelAskDeleteInvoices = true
        this.documentsToDelete = [];
        if (this.invoices.length > 0) {
            for (let invoice of this.invoices) {
                this.documentsToDelete.push({Name : invoice.Name, Extension : invoice.TKD_txt_Extension__c});
            }
            
        }
    }
    openListAB() {        
        this.openmodelAB = true
    }

    openModalFilter() {
        this.openmodelFilter = true
    }

    openmodal(takedownInvoiceId) {
        // eslint-disable-next-line no-console
        this.takedownInvoiceId = takedownInvoiceId;
        this.openmodel = true

    }
    closeModal() {
        this.openmodel = false
        this.openmodelAB = false
        this.openmodelFilter = false
        this.openmodelAskDeleteInvoice = false
        this.openmodelAskDeleteInvoices = false
    }
    handleSortdata(event) {
        // field name
        this.sortBy = event.detail.fieldName;

        // sort direction
        this.sortDirection = event.detail.sortDirection;

        // calling sortdata function to sort the data based on direction and selected field
        this.sortData(event.detail.fieldName, event.detail.sortDirection);
    }
    sortData(fieldname, direction) {
        // serialize the data before calling sort function
        let parseData = JSON.parse(JSON.stringify(this.takedownInvoice.data));

        // Return the value stored in the field
        let keyValue = (a) => {
            return a[fieldname];
        };

        // cheking reverse direction 
        let isReverse = direction === 'asc' ? 1 : -1;

        // sorting data 
        parseData.sort((x, y) => {
            x = keyValue(x) ? keyValue(x) : ''; // handling null values
            y = keyValue(y) ? keyValue(y) : '';

            // sorting values based on direction
            return isReverse * ((x > y) - (y > x));
        });

        // set the sorted data to data table data
        this.takedownInvoice.data = parseData;

    }
    get options() {
        return [
            { label: 'New', value: 'new' },
            { label: 'In Progress', value: 'inProgress' },
            { label: 'Finished', value: 'finished' },
        ];
    }
    handleChange(event) {
        this.selectedValue = event.detail.value;
    }
    setupfilter(event) {
        this.filterdoctype = event.detail;
        return refreshApex(this.takedownInvoice);
    }
    async downloadContractIm(){ 
        this.section = blank;
        await Promise.all([
            loadScript(this, exceljs),
            loadScript(this, filesaver)
        ]).then(() => {
            getContractImport({ objectId: this.recordId}).then(value => {
                this.makeXLSX(makeOrderHeaderFields(value.listHeaders),makeOrderLineFields(value.listLines))
                }).catch(error => {
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: "Error to download Contract Import, please reload page and try again",
                            message: error.message,
                            variant: "error"
                        })
                    );
                })
            // eslint-disable-next-line no-console
            console.log('librerias XLSX y FileServer Iniciadas');        
        }).catch(error => {
            // eslint-disable-next-line no-console
                console.log('Error');
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error loading resourse',
                        message: error.message,
                        variant: 'error',
                    }),
                );
            });
            this.section = mainpage;
    }
    makeXLSX(listHeaders,listLines){        
        //Creas un workbook
        // eslint-disable-next-line no-console
        console.log('Hifi ' + JSON.stringify(this.takedownObject));
        let wb = XLSX.utils.book_new();
        wb.props = {
            Title: "ContractImport " + this.takedownObject.fields.Name.value,
            subject: "Contract Import",
            Author: "EngeniumCapital"
        };
        let headerData = XLSX.utils.json_to_sheet(listHeaders);
        let linesData = XLSX.utils.json_to_sheet(listLines);

        XLSX.utils.book_append_sheet(wb, headerData, 'HEADERS');
        XLSX.utils.book_append_sheet(wb, linesData, 'LINES');

        let wbout = XLSX.write(wb, { bookType: 'xlsx', type: 'binary' });
        saveAs(new Blob([workDownload(wbout)], {type:'text/plain'}), 'ContractImport ' + this.takedownObject.fields.Name.value + '.xlsx');

    }
    render(){
        return this.section;
    }

    
}