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
//New version 
/*
PushTopic
PushTopic pushTopic = new PushTopic();
pushTopic.Name = 'TakedownInvoiceUpdates';
pushTopic.Query = 'SELECT TKD_pd_Takedown_CP__c, TKD_txt_Content_Version_ID__c, TKD_txt_Document_ID__c, TKD_txt_Extension__c, TKD_ls_SAT_Status__c, TKD_ls_Eng_Status__c, Id, Name FROM Takedown_Invoice__c';
pushTopic.ApiVersion = 46.0;
pushTopic.NotifyForOperationCreate = true;
pushTopic.NotifyForOperationUpdate = true;
pushTopic.NotifyForOperationUndelete = false;
pushTopic.NotifyForOperationDelete = true;
pushTopic.NotifyForFields = 'Referenced';
insert pushTopic; 
takedownTableDocumentsFilter
*/
import { LightningElement, wire, track, api } from "lwc";
import { NavigationMixin } from 'lightning/navigation';
import { loadStyle } from 'lightning/platformResourceLoader';
import { refreshApex } from '@salesforce/apex';
import Animate from  '@salesforce/resourceUrl/Animate';
import getDocumentList from "@salesforce/apex/takedownTableInvoicesController_cls.getDocumentList";
import constantes from './helperJS/constantes';
import deleteInvoice from "@salesforce/apex/takedownTableDocumentsController_cls.deleteInvoice";
import blank from './views/blank.html';
import mainpage from './takedownTableInvoices.html';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { getRecord } from 'lightning/uiRecordApi'


import getProfileCurrentUser from "@salesforce/apex/takedownTableDocumentsController_cls.getProfileCurrentUser"
import getTakedownVisibilityBlockAB from "@salesforce/apex/takedownTableDocumentsController_cls.getTakedownVisibilityBlockAB"


export default class TakedownTableInvoices extends NavigationMixin(LightningElement) {
//    export default class TakedownTableInvoices extends LightningElement {

    @api recordid;
    @api takedownInvoiceId;
    @track columns = constantes.COLS;
    @track section = mainpage;

    @track sortBy;
    @track sortDirection;
    @track openmodalABForm = false;
    @track documentId;

    @track openmodelAskDeleteInvoice = false;
    @track formMode = 'view'
    @track takedwownCPRecord
    documentsToDelete = [];
    initPrincipalClass = 'animated fadeInRight'
    takedownInvoice

    
    //@wire(getDocumentList, { recordId: "$recordid"})
    //takedownInvoice;
    @wire(getDocumentList, { recordId: "$recordid"})
    async wireResult(result){
        if(await result){
            this.takedownInvoice = await result
            this.initPrincipalClass = ''
            console.log('takedownInvoice ' + JSON.stringify(this.takedownInvoice))
        }    
    }

    @wire(getRecord, { recordId: "$recordid", fields: constantes.FIELDS })
    async wireRecord({ error, data }) {
        if(await data){
            this.takedwownCPRecord = data            
            console.log('data ' + JSON.stringify(data))
            let currentProfileName = await getProfileCurrentUser()
            this.ButtonUnlockAndApproveShow = await getTakedownVisibilityBlockAB({profileName:currentProfileName})
            //si tiene permisos para enviar a aprobar, se le bloquean los permisos para manipular invoices o ab
            if(this.ButtonUnlockAndApproveShow === false){
                this.columns = this.columns.map(index => {
                    console.log(' JSON.stringify(index.typeAttributes) ' + JSON.stringify(index.typeAttributes))
                    if(index.typeAttributes)
                    index.typeAttributes.rowActions.map(rowActions =>{
                        if(rowActions.label === 'Delete'){
                            Object.assign(rowActions, {disabled: data.fields.TKD_ca_Block_invoices__c.value})
                        }
                        return rowActions                    
                    })
                    return index
                })
                if(data.fields.TKD_ca_Block_AB__c.value === true){
                    this.formMode = 'readonly'
                }

            }               
            console.log('this.columns ' + JSON.stringify(this.columns))
            } if(error){
                console.log('error ' + error)
                console.log('error ' + JSON.stringify(error))
            }
    }
    connectedCallback() {
        Promise.all([
            loadStyle(this, Animate)
        ]).then(() => { 'scripts cargadinos' });  
    }

    handleRowAction(event) {
        console.log('handleRowAction event ' + JSON.stringify(event))
        const actionName = event.detail.action.name;
        //const documentId = event.detail.row.TKD_txt_Document_ID__c;
        const extension = event.detail.row.TKD_txt_Extension__c;
        const name = event.detail.row.Name;
        this.takedownInvoiceId = event.detail.row.Id;
        this.documentId = event.detail.row.TKD_txt_Document_ID__c;
        switch (actionName) {
            case 'delete':
                //this.deleteRow();
                this.documentsToDelete = [{Name : name, Extension : extension}];
                // eslint-disable-next-line no-console
                console.log('JSON.stringify(this.documentsToDelete) ' + JSON.stringify(this.documentsToDelete))
                //this.openmodalAskDeleteInvoice();
                this.openmodelAskDeleteInvoice = true
                break;
            case 'preview':
                this.navigateToRecordViewPage(this.documentId)
                break;
            case 'assetbd':
                this.openmodalABForm = true;
                //this.openmodal(takedownInvoiceId);
                break;
            case 'openrecord':
                this.navigateToRecordViewPage(this.takedownInvoiceId)
                break;
            default:
        }

    }

    getSelectedRows(event) {
        let invoice = event.detail.selectedRows;
        console.log('JSON.stringify(invoices) ' + JSON.stringify(invoice))
        // Prevents the anchor element from navigating to a URL.
        event.preventDefault();

        // Creates the event with the contact ID data.
        const selectedEvent = new CustomEvent('selectedinvoices', { detail: invoice });

        // Dispatches the event.
        this.dispatchEvent(selectedEvent);

        /*if (invoices == null || invoices === undefined || invoices.length === 0) {
            this.isButtonDisabled = true;
        } else {
            this.isButtonDisabled = false;
        }*/

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

    navigateToRecordViewPage(id) {
        // View a custom object record.
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: id,
                objectApiName: 'Takedown_Invoice__c', // objectApiName is optional
                actionName: 'view'
            }
        });
    }

    async deleteRow() {
        this.handleCloseModals()
        this.section = blank;
        await deleteInvoice({ idInvoice: this.takedownInvoiceId, takedownDocId: this.documentId, blockAB: this.takedwownCPRecord.fields.TKD_ca_Block_AB__c.value, ButtonUnlockAndApproveShow: this.ButtonUnlockAndApproveShow})
            .then(result => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: "Success!!",
                        message: "The assets has been deleted",
                        variant: "success"
                    })
                );
            }).catch(errores => {
                console.log('errores ' + errores)
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

    handleError(event) {
        //Error is coming in the event.detail.error
        console.log('Error PushTopic ' + JSON.stringify(event.detail.error))
    }
    handleMessage(event) {
        //Message is coming in event.detail.payload
        // eslint-disable-next-line no-console
        console.log('this.payload ' + JSON.stringify(event.detail.payload));
        refreshApex(this.takedownInvoice);
    }
    handleCloseModals() {
        this.openmodalABForm = false
        this.openmodelAskDeleteInvoice = false
    }
    render(){
        return this.section;
    }
}