/**
 * @description       : 
 * @author            : eduardo.amiens@outlook.com
 * @group             : 
 * @last modified on  : 10-13-2020
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
 * Modifications Log 
 * Ver   Date         Author                       Modification
 * 1.0   07-15-2020   eduardo.amiens@outlook.com   Initial Version
**/
import { LightningElement, wire, track, api } from "lwc"
import { ShowToastEvent } from 'lightning/platformShowToastEvent'
import { getRecord, updateRecord } from 'lightning/uiRecordApi'
import { NavigationMixin } from 'lightning/navigation';
import blank from './views/blank.html'
import mainpage from './takedownTableDocumentsControlButtons.html'
import { refreshApex } from '@salesforce/apex';

import exceljs from '@salesforce/resourceUrl/exceljs'
import filesaver from '@salesforce/resourceUrl/filesaver'
import { loadScript } from 'lightning/platformResourceLoader'
import getContractImport from "@salesforce/apex/Takedown_XLSX_Contract_Import_lwc_cls.getContractImport"
import { makeOrderHeaderFields, makeOrderLineFields, workDownload } from './helperJS/downloadContractImport'
import getProfileCurrentUser from "@salesforce/apex/takedownTableDocumentsController_cls.getProfileCurrentUser"
import UploadAndValidateInvoices from "@salesforce/apex/takedownTableDocumentsController_cls.uploadAndValidateInvoices"
import getTakedownVisibilityISCSubmit from "@salesforce/apex/takedownTableDocumentsController_cls.getTakedownVisibilityISCSubmit"
import getTakedownVisibilityBlockAB from "@salesforce/apex/takedownTableDocumentsController_cls.getTakedownVisibilityBlockAB"
import getTakedownVisibilityValidateInvoices from "@salesforce/apex/takedownTableDocumentsController_cls.getTakedownVisibilityValidateInvoices"
import getDocumentList from "@salesforce/apex/takedownTableInvoicesController_cls.getDocumentList";
import deleteInvoices from "@salesforce/apex/takedownTableDocumentsController_cls.deleteInvoices"
import constantes from './helperJS/constantes'
import TKD_ca_Approve_Asset_Breakdown from '@salesforce/schema/Takedowns_Contingency_plan__c.TKD_ca_Approve_Asset_Breakdown__c';
import TKD_ca_Block_AB from '@salesforce/schema/Takedowns_Contingency_plan__c.TKD_ca_Block_AB__c';
import TKD_tl_Invoices_approval_comments from '@salesforce/schema/Takedowns_Contingency_plan__c.TKD_tl_Invoices_approval_comments__c';
import ID_FIELD from '@salesforce/schema/Takedowns_Contingency_plan__c.Id';
import TKD_ls_Invoices_approval_status from '@salesforce/schema/Takedowns_Contingency_plan__c.TKD_ls_Invoices_approval_status__c';
import TKD_ca_Notify_to_Prebook from '@salesforce/schema/Takedowns_Contingency_plan__c.TKD_ca_Notify_to_Prebook__c';
import TKD_ca_Block_invoices from '@salesforce/schema/Takedowns_Contingency_plan__c.TKD_ca_Block_invoices__c';

//New lines
import { registerListener } from 'c/pubsub';
import { CurrentPageReference } from 'lightning/navigation';
import updateSuccessInvoice from '@salesforce/apex/InvoiceReject_cls.updateSuccessInvoice';

export default class TakedownTableDocumentsControlButtons extends NavigationMixin(LightningElement) {
    @api recordId
    @track currenObjectName = 'Takedowns_Contingency_plan__c';

    @track toggleLockABLabel = 'Lock AB'
    @track toggleLockABIconName = 'utility:lock'

    @track toggleLockInvoicesLabel = 'Lock Invoices'
    @track toggleLockInvoicesName = 'utility:lock'

    @track selectedInvoices
    documentsToDelete
    @track approvalComments
    //buttons 
    @track permissionToValidateInvoices = true
    @track disableDeleteInvoices = true
    @track disableValidateInvoices = true
    //Este botón se utiliza para enviar una notificación a prebook,  en cuanto la notificación sea enviada, 
    //el usuario actual ya no podrá editar los assets 
    @track ButtonSubmiToReviewShow = false
    @track ButtonUnlockAndApproveShow = false
    @track disableButtonUnlockABANDApproveInvoice = false
    @track disableButtonReworkInvoices = true
    @track isButtonSubmiToReviewDisabled = false
    @track isButtonABDisabled = false
    @track isButtonInvoiceDisabled = false
    @track openModalAB = false
    @track openModalDeleteInvoices = false
    @track openModalSubmitToReview = false
    @track openModalLockAB = false
    @track openModalLockInvoices = false
    @track openModalApproveInvoices = false
    @track openModalRejectInvoices = false
    @track openModalReworkInvoices = false
    @track openModalFilterInvoices = false
    @track openModalInvoiceReject = false

    @track section = blank
    takedwownCPRecord

    initPrincipalClass = 'slds-m-top_medium slds-m-bottom_x-large animated fadeInRight'

    @track optionFilters = [];
    @api valueFilters = [];

    //New line
    @wire(CurrentPageReference) pageRef;

    connectedCallback() {
        const items = [{ label: 'xml', value: 'xml' }, { label: 'pdf', value: 'pdf' }];
        this.optionFilters.push(...items);
        registerListener("saverejectsInvoice", this.saveRejectInvoice, this);
    }

    renderedCallback() {
        const style = document.createElement('style');
        style.innerText = 'c-modal-question .slds-modal__container { max-width: 80rem !important; width: 80% !important;}';
        this.template.querySelector('div').appendChild(style);
    }

    @wire(getRecord, { recordId: "$recordId", fields: constantes.FIELDS })
    async wireRecord({ error, data }) {
        if (data) {
            this.takedwownCPRecord = await data
            console.log('data ' + JSON.stringify(data))
            //Si el registro no ha sido enviado a aprobación o si el registro se aprobó, desactivas 
            // deshabilita los botones de aprobación
            if (await data.fields.TKD_ca_Approve_Asset_Breakdown__c.value === true
                || await data.fields.TKD_ca_Notify_to_Prebook__c.value === false) {
                this.disableButtonUnlockABANDApproveInvoice = true
            } else {
                this.disableButtonUnlockABANDApproveInvoice = false
            }
            //si el registro ha sido aprobado, habilita el botón de rework
            if (data.fields.TKD_ls_Invoices_approval_status__c.displayValue === 'Approved') {
                this.disableButtonReworkInvoices = false
            } else {
                this.disableButtonReworkInvoices = true
            }
            //obtiene el nombre del perfil del current user
            let currentProfileName = await getProfileCurrentUser()
            //revisa si tiene permisos para validar invoices
            this.permissionToValidateInvoices = await getTakedownVisibilityValidateInvoices({ profileName: currentProfileName })

            //revisa si tiene permisos para enviar el AB a aprobación
            this.ButtonSubmiToReviewShow = await getTakedownVisibilityISCSubmit({ profileName: currentProfileName })
            //revisa si tiene permisos para aprobar o bloquear AB
            this.ButtonUnlockAndApproveShow = await getTakedownVisibilityBlockAB({ profileName: currentProfileName })
            //si tiene permisos para enviar a aprobar, se le bloquean los permisos para manipular invoices o ab
            if (this.ButtonSubmiToReviewShow === true) {
                this.isButtonSubmiToReviewDisabled = data.fields.TKD_ca_Notify_to_Prebook__c.value
                this.isButtonABDisabled = data.fields.TKD_ca_Block_AB__c.value
            }
            this.isButtonInvoiceDisabled = data.fields.TKD_ca_Block_invoices__c.value
            // si tiene permisos para bloquear AB o invoices se setean los valores iniciales de los botones lock o unlock
            if (this.ButtonUnlockAndApproveShow === true) {
                this.handleToggleLockABClick(data.fields.TKD_ca_Block_AB__c.value)
                this.handleToggleLockInvoiceClick(data.fields.TKD_ca_Block_invoices__c.value)
            }
            this.initPrincipalClass = 'slds-m-top_medium slds-m-bottom_x-large'
            this.section = mainpage;
        } else if (error) {
            this.dispatchEvent(new ShowToastEvent({
                title: 'Error to get Takedown CP',
                message: error.body.message,
                variant: 'error',
            }))
            this.initPrincipalClass = 'slds-m-top_medium slds-m-bottom_x-large'
            this.section = mainpage;
        }


    }
    async handleOpenModalSubmitToReview() {
        if ((this.takedwownCPRecord.fields.CPL_ls_Product__c.value !== 'PRESTAMO-FIJA'
            && this.takedwownCPRecord.fields.CPL_ls_Product__c.value !== 'PRESTAMO-VAR')
            && (this.takedwownCPRecord.fields.TKD_ls_asset_type__c.value === null
                || this.takedwownCPRecord.fields.TKD_ls_asset_type__c.value === undefined
                || this.takedwownCPRecord.fields.TKD_ls_asset_type__c.value === '')) {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: "Sorry you can't submit to review",
                    message: 'Please write the "Asset Type" field into detail section from Takedown CP',
                    variant: "warning"
                })
            );
        } else {
            await this.handleFirstOpenModalSubmitToReview()
            this.template.querySelector("c-modal-question").makeModalSmall();
        }

    }
    handleFirstOpenModalSubmitToReview() {
        this.openModalSubmitToReview = true;
    }
    async handleBlockAB() {
        this.section = blank;
        this.handleCloseModals()
        let blockAB = this.takedwownCPRecord.fields.TKD_ca_Block_AB__c.value
        const fields = {};
        console.log('blockAB ' + blockAB)
        fields[TKD_ca_Block_AB.fieldApiName] = blockAB === true ? false : true
        fields[ID_FIELD.fieldApiName] = this.recordId
        const recordInput = { fields };
        let actionLoked = blockAB === false ? 'locked' : 'unlocked';
        console.log('actionLoked ' + actionLoked)
        try {
            let pp = await updateRecord(recordInput)
            console.log('pp ' + JSON.stringify(pp))
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success!!',
                    message: 'The asset breakdown has been ' + actionLoked + ' to ISC team',
                    variant: 'success',
                })
            );
        } catch (error) {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'An error has been occurred during ' + actionLoked + ' process',
                    message: error,
                    variant: 'error',
                })
            );
        }
        this.section = mainpage;
    }
    async handleBlockInvoice() {
        this.section = blank;
        this.handleCloseModals()
        const fields = {};
        let blockInvoices = this.takedwownCPRecord.fields.TKD_ca_Block_invoices__c.value
        fields[TKD_ca_Block_invoices.fieldApiName] = blockInvoices === true ? false : true
        fields[ID_FIELD.fieldApiName] = this.recordId
        const recordInput = { fields };
        let actionLoked = blockInvoices === false ? 'locked' : 'unlocked';
        await updateRecord(recordInput)
            .then(() => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success!!',
                        message: 'The invoices have been ' + actionLoked + ' to ISC team',
                        variant: 'success',
                    })
                );
            })
            .catch(error => {
                let message = "Unknown error";
                if (Array.isArray(error.body)) {
                    message = error.body.map(e => e.message).join(", ");
                } else if (typeof error.body.message === "string") {
                    message = error.body.message;
                }
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'An error has been occurred during ' + actionLoked + ' process',
                        message,
                        variant: 'error',
                    })
                );
            });
        this.section = mainpage;
        return refreshApex(this.takedwownCPRecord);

    }

    async handleSubmitToReview() {
        this.section = blank;
        this.handleCloseModals()
        const fields = {};
        fields[ID_FIELD.fieldApiName] = this.recordId
        fields[TKD_ca_Notify_to_Prebook.fieldApiName] = true
        fields[TKD_ca_Block_AB.fieldApiName] = true
        let blockInvoices = this.takedwownCPRecord.fields.TKD_ca_Block_invoices__c.value
        fields[TKD_ca_Block_invoices.fieldApiName] = blockInvoices === true ? false : true
        fields[TKD_ls_Invoices_approval_status.fieldApiName] = 'action:submit_for_approval'

        const recordInput = { fields };
        await updateRecord(recordInput).then(result => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success!!',
                    message: 'The invoices has been submited to review',
                    variant: 'success',
                })
            );
        }).catch(errores => {
            console.log('errores ' + JSON.stringify(errores))
            let errorMessage = ''
            if (errores.body.pageErrors) {
                errores.body.pageErrors.forEach(element => {
                    errorMessage += element.message + ' '
                });
            } else if (errores.body.output) {
                errores.body.output.fieldErrors.CLI_rb_Inside_Sales_Owner__c.forEach(element => {
                    errorMessage += element.message + ' '
                });
            }
            let errorTilte = 'An error has been occurred during submit to review process'
            if(errorMessage === null || errorMessage === undefined){
                errorTilte = 'An error has been occurred during submit to review process, contact your admin'    
            }
            this.dispatchEvent(
                new ShowToastEvent({
                    title: errorTilte,
                    message: errorMessage,
                    variant: 'error',
                })
            )
        })


        this.section = mainpage;
    }
    handleFormInputChange(event) {
        this.approvalComments = event.target.value
    }
    async handleApproveInvoices(event) {
        this.section = blank;
        this.handleCloseModals()
        console.log('this.event ' + JSON.stringify(event))
        const fields = {};
        fields[TKD_ca_Approve_Asset_Breakdown.fieldApiName] = true
        fields[ID_FIELD.fieldApiName] = this.recordId
        fields[TKD_ca_Block_AB.fieldApiName] = true
        fields[TKD_tl_Invoices_approval_comments.fieldApiName] = this.approvalComments
        fields[TKD_ls_Invoices_approval_status.fieldApiName] = 'action:update_status'

        const recordInput = { fields };
        await updateRecord(recordInput)
            .then(() => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success!!',
                        message: 'The invoices has been approved',
                        variant: 'success',
                    })
                );
                // Display fresh data in the form
                return refreshApex(this.takedwownCPRecord);
            })
            .catch(error => {
                this.handleCloseModals()
                let message = "Unknown error";
                if (Array.isArray(error.body)) {
                    message = error.body.map(e => e.message).join(", ");
                } else if (typeof error.body.message === "string") {
                    message = error.body.message;
                }
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'An error has been occurred during approval invoices process, contact your admin',
                        message,
                        variant: 'error',
                    })
                );
            });
        this.section = mainpage;
    }

    async handleRejectInvoices(comment) {
        this.section = blank;
        this.handleCloseModals()
        const fields = {};
        fields[TKD_ca_Approve_Asset_Breakdown.fieldApiName] = false
        fields[ID_FIELD.fieldApiName] = this.recordId
        fields[TKD_ca_Block_AB.fieldApiName] = false
        fields[TKD_ca_Block_invoices.fieldApiName] = false
        fields[TKD_ca_Notify_to_Prebook.fieldApiName] = false
        fields[TKD_tl_Invoices_approval_comments.fieldApiName] = this.approvalComments
        //fields[TKD_tl_Invoices_approval_comments.fieldApiName] = comment
        fields[TKD_ls_Invoices_approval_status.fieldApiName] = 'action:reject'
        const recordInput = { fields };
        await updateRecord(recordInput)
            .then(() => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success!!',
                        message: 'The invoices has been rejected',
                        variant: 'success',
                    })
                );
                // Display fresh data in the form
                //fireEvent(this.pageRef, 'refreshtable');
                eval("$A.get('e.force:refreshView').fire();");
                return refreshApex(this.takedwownCPRecord);
            })
            .catch(error => {
                this.handleCloseModals()
                let message = "Unknown error";
                if (Array.isArray(error.body)) {
                    message = error.body.map(e => e.message).join(", ");
                } else if (typeof error.body.message === "string") {
                    message = error.body.message;
                }
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'An error has been occurred during approval invoices process, contact your admin',
                        message,
                        variant: 'error',
                    })
                );
            });
        this.section = mainpage;
    }


    async handleInvoiceRejects() {
        this.template.querySelector('c-invoice-reason-reaject').saverejects();
    }

    saveRejectInvoice(event) {
        console.log('entre');
        let rejects = event.detail;
        console.log('LOS REJECTS');
        console.log(rejects);
        let comment;

        updateSuccessInvoice({idTakedownCP : this.recordId});

        /*
        comment = 'Reason for reject:';
        rejects.forEach(reject => {
            let othReason = reject.Another_reason__c;
            if (!othReason.length) {
                comment +=  '' + reject.Reason_for_rejection__c;
            } else {
                comment +=  '' + reject.Reason_for_rejection__c + ': ' + reject.Another_reason__c + ',' ;
            }
        });*/

        console.log(comment);
        this.handleRejectInvoices(comment);
    }

    async handleReworkInvoices() {
        this.section = blank;
        this.handleCloseModals()
        const fields = {};
        
        fields[TKD_ca_Approve_Asset_Breakdown.fieldApiName] = false
        fields[ID_FIELD.fieldApiName] = this.recordId
        fields[TKD_ca_Block_AB.fieldApiName] = false
        fields[TKD_ca_Block_invoices.fieldApiName] = false
        fields[TKD_ca_Notify_to_Prebook.fieldApiName] = false
        fields[TKD_tl_Invoices_approval_comments.fieldApiName] = this.approvalComments
        fields[TKD_ls_Invoices_approval_status.fieldApiName] = 'action:edit_groups'
        const recordInput = { fields };
        await updateRecord(recordInput)
            .then(() => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success!!',
                        message: 'The invoices has been changed to reworked state ',
                        variant: 'success',
                    })
                );
                // Display fresh data in the form
                return refreshApex(this.takedwownCPRecord);
            })
            .catch(error => {
                console.log(error)
                this.handleCloseModals()
                let message = "Unknown error";
                if (Array.isArray(error.body)) {
                    message = error.body.map(e => e.message).join(", ");
                } else if (typeof error.body.message === "string") {
                    message = error.body.message;
                }
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'An error has been occurred during approval invoices process, contact your admin',
                        message,
                        variant: 'error',
                    })
                );
            });
        this.section = mainpage;
    }

    handleToggleLockABClick(isButtonABDisabled) {
        if (isButtonABDisabled === true) {
            this.toggleLockABIconName = 'utility:unlock';
            this.toggleLockABLabel = 'Unlock AB';
        } else {
            this.toggleLockABIconName = 'utility:lock';
            this.toggleLockABLabel = 'Lock AB';
        }
    }
    handleToggleLockInvoiceClick(isButtonInvoicesDisabled) {
        if (isButtonInvoicesDisabled === true) {
            this.toggleLockInvoicesName = 'utility:unlock';
            this.toggleLockInvoicesLabel = 'Unlock Invoices';
        } else {
            this.toggleLockInvoicesName = 'utility:lock';
            this.toggleLockInvoicesLabel = 'Lock Invoices';
        }
    }
    handleSelectedInvoices(event) {
        this.selectedInvoices = event.detail
        console.log('this.permissionToValidateInvoices ' + this.permissionToValidateInvoices)
        console.log('this.selectedInvoices ')
        console.log(this.selectedInvoices)
        console.log('this.disableDeleteInvoices ' + this.disableDeleteInvoices)
        if (this.permissionToValidateInvoices === true) {
            if (this.selectedInvoices == null || this.selectedInvoices === undefined || this.selectedInvoices.length === 0) {
                this.disableDeleteInvoices = true
                this.disableValidateInvoices = true
            } else {
                this.disableDeleteInvoices = false
                this.disableValidateInvoices = false
            }
        } else {
            this.disableValidateInvoices = true
            if (this.isButtonInvoiceDisabled === true) {
                this.disableDeleteInvoices = true
            } else if (this.selectedInvoices == null || this.selectedInvoices === undefined || this.selectedInvoices.length === 0) {
                this.disableDeleteInvoices = true
            } else {
                this.disableDeleteInvoices = false
            }
        }


    }
    handleOnselectDownloads(event) {
        switch (event.detail.value) {
            case 'dContractImport':
                this.handleDownloadContractImport()
                break;
            case 'dInvoices':
                this.handleDownloadFiles()
                break;
            default:
        }

    }
    handleOnselectSettings(event) {
        switch (event.detail.value) {
            case 'toggleLockABvalue':
                this.openModalLockAB = true
                break;
            case 'toggleLockInvoicesvalue':
                this.openModalLockInvoices = true
                break;
            case 'approveInvoices':
                this.openModalApproveInvoices = true
                break;
            case 'rejectInvoices':
                this.openModalRejectInvoices = true
                break;
            case 'reworkInvoices':
                this.openModalReworkInvoices = true
                break;
            case 'filters':
                this.openModalFilterInvoices = true
                break;
            default:
        }

    }

    handleOpenModalAB() {
        this.openModalAB = true
    }

    handleCloseModals() {
        this.openModalAB = false
        this.openModalDeleteInvoices = false
        this.openModalSubmitToReview = false
        this.openModalLockAB = false
        this.openModalLockInvoices = false
        this.openModalApproveInvoices = false
        this.openModalRejectInvoices = false
        this.openModalReworkInvoices = false
        this.openModalFilterInvoices = false
        this.openModalInvoiceReject = false
    }

    handleOpenModalAskDeleteInvoices() {
        this.openModalDeleteInvoices = true
        this.documentsToDelete = [];
        for (let invoice of this.selectedInvoices) {
            this.documentsToDelete.push({ Name: invoice.Name, Extension: invoice.TKD_txt_Extension__c });
        }
    }

    async handleMultideleteDocuments() {
        this.openModalDeleteInvoices = false;
        this.section = blank;
        if (this.selectedInvoices.length > 0) {
            let invoices = [];
            let documents = [];
            for (let invoice of this.selectedInvoices) {
                invoices.push(invoice.Id);
                documents.push(invoice.TKD_txt_Document_ID__c);
            }
            //this.documentsToDelete = [{name : name, extension : extension}];

            await deleteInvoices({ invoices: invoices, documents: documents, blockAB: this.takedwownCPRecord.fields.TKD_ca_Block_AB__c.value, ButtonUnlockAndApproveShow: this.takedwownCPRecord.fields.TKD_ca_Block_invoices__c.value })
                .then(result => {
                    this.section = mainpage;
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Success!!',
                            message: 'The documents has been deleted',
                            variant: 'success',
                        })
                    );
                }).catch(errores => {
                    this.section = mainpage; s
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
            this.disableDeleteInvoices = true
            this.disableValidateInvoices = true
        }
        this.section = mainpage;

    }

    async handleValidateInvoices() {
        console.log('this.takedwownCPRecord ' + JSON.stringify(this.takedwownCPRecord))
        let assetType = this.takedwownCPRecord.fields.TKD_ls_asset_type__c.value;
        if (assetType === null || assetType === undefined || assetType === '') {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: "Sorry we can't upload and validate files",
                    message: 'Please write the "Asset Type" field into detail section from Takedown CP',
                    variant: "warning"
                })
            );
        } else if (this.selectedInvoices.length > 0) {
            let invoicesToValidate = [];
            for (let invoice of this.selectedInvoices) {
                invoicesToValidate.push({
                    id: invoice.Id,
                    name: invoice.Name,
                    TKD_fm_validation: invoice.TKD_fm_validation__c,
                    TKD_ls_Status: invoice.TKD_ls_Status__c,
                    TKD_pd_Takedown_CP: invoice.TKD_pd_Takedown_CP__c,
                    TKD_txt_Content_Version_ID: invoice.TKD_txt_Content_Version_ID__c,
                    TKD_txt_Document_ID: invoice.TKD_txt_Document_ID__c,
                    TKD_txt_Extension: invoice.TKD_txt_Extension__c,
                    TKD_ls_asset_type: assetType,
                    AccountId: invoice.TKD_pd_Takedown_CP__r.CPL_rb_Opp__r.AccountId
                });
            }
            this.section = blank;
            // eslint-disable-next-line no-console
            await UploadAndValidateInvoices({ listTableElement: invoicesToValidate })
                .then(result => {
                    this.section = mainpage;
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Success!!',
                            message: 'The documents are in process, this can take a few minutes!!!',
                            variant: 'success',
                        }),
                    );
                }).catch(errores => {
                    this.section = mainpage;
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
        this.disableDeleteInvoices = true
        this.disableValidateInvoices = true
        this.section = mainpage;
    }

    @wire(getDocumentList, { recordId: "$recordid" })
    async wireResult(result) {
        if (await result) {
            this.takedownInvoice = await result
            this.initPrincipalClass = ''
            console.log('takedownInvoice ' + JSON.stringify(this.takedownInvoice))
        }
    }

    async handleDownloadFiles() {
        let downloadURL
        console.log('this.selectedInvoices ' + JSON.stringify(this.selectedInvoices))
        if (this.selectedInvoices !== undefined && this.selectedInvoices.length > 0) {
            downloadURL = '/sfc/servlet.shepherd/version/download'
            this.selectedInvoices.forEach(element => {
                console.log('element ' + JSON.stringify(element))
                console.log('element ' + element.TKD_txt_Content_Version_ID__c)
                downloadURL += '/' + element.TKD_txt_Content_Version_ID__c
            });
            downloadURL += '?'
        } else {
            let allTakedownInvoices = await getDocumentList({ recordId: this.recordId })
            if (allTakedownInvoices !== undefined && allTakedownInvoices.length > 0) {
                downloadURL = '/sfc/servlet.shepherd/version/download'
                allTakedownInvoices.forEach(element => {
                    console.log('element ' + JSON.stringify(element))
                    console.log('element ' + element.TKD_txt_Content_Version_ID__c)
                    downloadURL += '/' + element.TKD_txt_Content_Version_ID__c
                });
                downloadURL += '?'
            }
        }
        if (downloadURL !== undefined) {
            this[NavigationMixin.GenerateUrl]({
                type: 'standard__navItemPage',
                attributes: {
                    apiName: "customTabName",
                },
                // query string parameters
                state: {
                    c__showPanel: 'true' // Value must be a string
                }
            }).then(url => {
                window.open(downloadURL)
            });
        } else {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: "Error to download invoices",
                    message: "No data found",
                    variant: "error"
                })
            );
        }
    }
    async handleDownloadContractImport() {
        this.section = blank;
        await Promise.all([
            loadScript(this, exceljs),
            loadScript(this, filesaver)
        ]).then(() => {
            getContractImport({ objectId: this.recordId })
                .then(value => {
                    this.makeXLSX(makeOrderHeaderFields(value.listHeaders), makeOrderLineFields(value.listLines))
                    this.section = mainpage;
                }).catch(error => {
                    this.section = mainpage;
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: "Error to download Contract Import, please reload page and try again",
                            message: error,
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
    makeXLSX(listHeaders, listLines) {
        //Creas un workbook
        // eslint-disable-next-line no-console
        console.log('Hifi ' + JSON.stringify(this.takedwownCPRecord));
        let wb = XLSX.utils.book_new();
        wb.props = {
            Title: "ContractImport " + this.takedwownCPRecord.fields.Name.value,
            subject: "Contract Import",
            Author: "EngeniumCapital"
        };
        let headerData = XLSX.utils.json_to_sheet(listHeaders);
        let linesData = XLSX.utils.json_to_sheet(listLines);

        XLSX.utils.book_append_sheet(wb, headerData, 'HEADERS');
        XLSX.utils.book_append_sheet(wb, linesData, 'LINES');

        let wbout = XLSX.write(wb, { bookType: 'xlsx', type: 'binary' });
        saveAs(new Blob([workDownload(wbout)], { type: 'text/plain' }), 'ContractImport ' + this.takedwownCPRecord.fields.Name.value + '.xlsx');

    }
    render() {
        return this.section;
    }
    @api
    refresh() {
        return refreshApex(this.takedwownCPRecord);
    }

    get min() {
        return 1;
    }
    handleChange(event) {
        this.valueFilters = event.detail.value;
    }
    saveMethod() {
        console.log('this.valueFilters ' + this.valueFilters)
        this.handleCloseModals()
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'save successful',
                message: 'The filter has been changed',
                variant: 'success',
            }),
        );
    }

    handleOpenModalInvoiceReason () {
        this.openModalInvoiceReject = true
    }
}