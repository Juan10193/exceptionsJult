import { LightningElement, track, api, wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { CurrentPageReference } from "lightning/navigation";
import { fireEvent } from "c/pubsub";
import saveReasonRejects from '@salesforce/apex/InvoiceReject_cls.saveReasonRejects';
import saveReasonRejectInvoice from '@salesforce/apex/InvoiceReject_cls.saveReasonRejectInvoice';
import updateSuccessInvoice from '@salesforce/apex/InvoiceReject_cls.updateSuccessInvoice';
import getAllInvoice from '@salesforce/apex/InvoiceReject_cls.saveAllReasonRejects'; 

export default class InvoiceReasonReaject extends LightningElement {
    @api recordId;
    @api objectApiName;
    
    //Update
    @track keyIndex = 0;  
    @track error;
    @track message;
    @track listInvoice = [];
    @track listInvoiceToReject = [];
    @track selectedAccountId;
    @track selectedInvoiceReject;

    @wire(CurrentPageReference) pageRef;

    // Created success, warning and error menssage
    showErrorToast(title ,message , error) {
        const evt = new ShowToastEvent({
            'title': title,
            'message': message,
            'variant': error,
            mode: 'dismissable'
        });
        this.dispatchEvent(evt);
    }

    @api
    saverejects() {
        let rejects = [];
        let rejectInvoice = [];
        let ids = [];
        let conIds = new Set();
        let validateReason = false;
        let allSelected = false;
        let generalComment = '';

        if(this.listInvoice.length > 0) {
            this.listInvoice.forEach(subtype => {
                let invoiceCP = subtype.TakedownInvoice;
                if(invoiceCP != '1111') {

                    let comentarioForInvoice;
                    console.log('id: '+ invoiceCP);
                    if(!invoiceCP.length){
                        this.showErrorToast('Warning!', 'You must select invoice for rejection' , 'warning');
                        validateReason = true;
                        return;
                    }

                    let reasonReject= subtype.ReasonForReject;
                    if(reasonReject.length) {
                        comentarioForInvoice = '';
                        subtype.ReasonForReject.forEach(reject => {
                            if(reject.comment == true) {
                                let comments = reject.commentario;
                                if(!comments.length){
                                    this.showErrorToast('Warning!', 'You must write the reason for rejection' , 'warning');
                                    validateReason = true;
                                    return;
                                }
                            }
                            
                            comentarioForInvoice += reject.subtype + ': ' + reject.commentario + '\n ';

                            let Invoice_process_reject__c = {
                                Error_version__c: reject.type,
                                Reason_for_rejection__c: reject.subtype,
                                Another_reason__c: reject.commentario,
                                Process_Type__c: this.objectApiName,
                                Takedown_Invoice__c: invoiceCP
                            };
                            conIds.add(invoiceCP);

                            Invoice_process_reject__c[this.objectApiName] = this.recordId;
                            rejects.push(Invoice_process_reject__c);

                        });

                        let Takedown_Invoice__c = {
                            Id: invoiceCP, 
                            MC_Rejection_Comments_txt__c : comentarioForInvoice,
                            MC_Estatus_Prebook_pl__c: 'action:close',
                        };
                        rejectInvoice.push(Takedown_Invoice__c);
                    }

                    else {
                        this.showErrorToast('Warning!', 'You must select reason for rejection' , 'warning');
                        validateReason = true;
                        return;
                    }
                }
                else {
                    //let comentarioForInvoice;
                    allSelected = true;
                    let reasonReject= subtype.ReasonForReject;
                    if(reasonReject.length) {
                        generalComment = '';
                        subtype.ReasonForReject.forEach(reject => {
                            if(reject.comment == true) {
                                let comments = reject.commentario;
                                if(!comments.length){
                                    this.showErrorToast('Warning!', 'You must write the reason for rejection' , 'warning');
                                    validateReason = true;
                                    return;
                                }
                            }
                            generalComment += reject.subtype + ': ' + reject.commentario + '\n ';
                        });
                    }

                    else {
                        this.showErrorToast('Warning!', 'You must select reason for rejection' , 'warning');
                        validateReason = true;
                        return;
                    }
                }
            });
        }
        else {
            this.showErrorToast('Warning!', 'Select some reason reject' , 'warning');
        }

        if ((rejects.length  > 0 || allSelected == true) && !validateReason) {
            console.log('Rejects for save' + JSON.stringify(rejects));
            let error; 

            if(allSelected) {
                error = 'all';
            }

            try {
                //saveReasonRejects({ rejects: rejects });
                //saveReasonRejectInvoice({ rejectInvoice: rejectInvoice });
                //console.log('PASAMOS PARSE')
                //fireEvent(this.pageRef, "saverejectsInvoice", { detail: rejects });
                ids = Array.from(conIds);
                this.createdRecords(rejects, rejectInvoice, error, generalComment, ids);
            } catch (error) {
                console.log("error al salvar rejects");
                console.log(error);
                this.showErrorToast('Failed!', 'Failed on save reject' + error, 'warning');
            }
        }
    }

    async createdRecords(rejects, rejectInvoice, error, generalComment, ids) {
        try {
            const result1 = await saveReasonRejects({ rejects: rejects });
            if(error == 'all') {
                const result4 = await getAllInvoice({idTakedownCP: this.recordId, comments: generalComment, ids: ids});
            }
            const result2 = await saveReasonRejectInvoice({ rejectInvoice: rejectInvoice });
            const result3 = await updateSuccessInvoice({idTakedownCP : this.recordId, error: error, comments: generalComment});
            fireEvent(this.pageRef, "saverejectsInvoice", { detail: rejects });
        }catch(error) {
            console.log(error);
            this.showErrorToast('Failed!', 'Failed on save reject: ' + error, 'warning');
        }
    }

    //Update
    addRow() {
        this.keyIndex+1;
        this.listInvoice.push(
            {
                TakedownInvoice: '',
                ReasonForReject: ''
            }
        );
    }

    removeRow(event) {
        if(this.listInvoice.length >= 0) {
            this.listInvoice.splice(event.target.accessKey,1);
            this.keyIndex-1;
        }
    }

    myLookupHandle(event){
        console.log(event.detail);
        this.selectedAccountId = event.detail;
        let selectedIndex = event.target.dataset.targetId;
        console.log('Index: ' + selectedIndex);
        this.listInvoice[selectedIndex].TakedownInvoice = this.selectedAccountId;
        console.log(this.listInvoice);
    }

    myLookupHandleInvoice(event){
        console.log('Error reject: ' + event.detail);
        this.selectedInvoiceReject = event.detail;
        let selectedIndex = event.target.dataset.targetId;
        console.log('Index: ' + selectedIndex);
        this.listInvoice[selectedIndex].ReasonForReject = this.selectedInvoiceReject;
        console.log(JSON.stringify(this.listInvoice));
    }
}