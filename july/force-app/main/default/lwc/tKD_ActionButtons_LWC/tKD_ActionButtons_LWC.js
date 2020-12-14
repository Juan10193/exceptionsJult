/* eslint-disable no-alert */
/* eslint-disable no-eval */
/**
 * @File Name          : tKD_ActionButtons_LWC.js
 * @Description        : 
 * @Author             : eduardo.amiens@outlook.com
 * @Group              : 
 * @Last Modified By   : eduardo.amiens@outlook.com
 * @Last Modified On   : 09-04-2020
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    31/10/2019   angel87ambher@gmail.com     Initial Version
**/
import { LightningElement, api, wire, track } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
import { registerListener, unregisterAllListeners } from 'c/pubsub';
import actionAp from '@salesforce/apex/TkdActionsController.processApproval';
import main from './tKD_ActionButtons_LWC.html';
import blank from './blank.html';
import vissible from '@salesforce/apex/TkdActionsController.handleVisibilityBtns';
import updateVistoBuenoFinanzas from '@salesforce/apex/tkdActionsWithoutSharing.updateTakedown';

import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { getRecord, updateRecord } from 'lightning/uiRecordApi';
import getSupplierInApprovalStatus from '@salesforce/apex/TKD_ChecklistTolgate1Controller.getSupplierInApprovalStatus';
import momentJs from '@salesforce/resourceUrl/momentJs';
import { loadScript } from 'lightning/platformResourceLoader';
import getTakedownInvoices from '@salesforce/apex/TKD_ChecklistTolgate1Controller.getTakedownInvoices';
import opportunityValidDate from "@salesforce/apex/TKD_ChecklistTolgate1Controller.opportunityValidDate";
import userId from '@salesforce/user/Id';
import Takedowns_Contingency_plan_OBJECT from '@salesforce/schema/Takedowns_Contingency_plan__c';
import { getPicklistValues } from 'lightning/uiObjectInfoApi';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import TKD_Id from '@salesforce/schema/Takedowns_Contingency_plan__c.Id';
import TKD_ls_Visto_bueno_finanzas from '@salesforce/schema/Takedowns_Contingency_plan__c.TKD_ls_Visto_bueno_finanzas__c';

export default class TKD_ActionButtons_LWC extends LightningElement {
    @api recordId;
    @api objectApiName;
    @wire(CurrentPageReference) pageRef;
    @track visibilidad;
    @track section = main;
    @track takedown;
    @track comment;
    //modal
    @track openMainModal = false;
    @track openmodal = false;
    @track openRecall = false;
    @track openReject = false;
    @track action;
    @track approvalValidations;
    @track takedownStage;
    @track takedownT1Val;
    @track pretollgate2Val;
    @track takedownT2Val;
    @track checkListValT2 = false;

    @track isApproval = false
    @track isRecall = false
    @track isReject = false
    @track isDocumentManagementUserPermission = false
    @track isDocumentManagementStagePermission = false

    @track TKD_ls_Visto_bueno_finanzasValue
    @track TKD_ls_Visto_bueno_finanzasOptions = []


    connectedCallback() {
        console.log('objectapi: ' + this.objectApiName)
        registerListener('approvalValidations', this.handleValidations, this);
        registerListener("saverejects", this.saveReject, this);
    }

    @wire(getObjectInfo, { objectApiName: Takedowns_Contingency_plan_OBJECT })
    Takedowns_Contingency_plan_ObjectInfo;

    @wire(getPicklistValues, { recordTypeId: '$Takedowns_Contingency_plan_ObjectInfo.data.defaultRecordTypeId', fieldApiName: TKD_ls_Visto_bueno_finanzas })
    getTKD_ls_Visto_bueno_finanzasOptions(result) {
        console.log('getTKD_ls_Visto_bueno_finanzasOptions ' + JSON.stringify(result))
        if (result.data) {
            this.TKD_ls_Visto_bueno_finanzasOptions = result.data.values.map(index => {
                return {
                    label: index.label, value: index.value
                }
            })
        }
    }

    renderedCallback() {
        Promise.all([
            loadScript(this, momentJs)
        ]).then(() => { 'scripts cargadinos' });

    }

    handleValidations(event) {
        console.log('DATA DEL EEVENTO');
        console.log(event);
        this.approvalValidations = event;
        console.log('Validations by  pp toño' + JSON.stringify(this.approvalValidations));
    }

    closeModal() {
        this.openMainModal = false;
        this.openmodal = false;
        this.openRecall = false;
        this.openReject = false;
    }

    saveReject(event) {
        console.log('realmente funciona')
        if (this.action === 'Reject') {

            let rejects = event.detail;
            console.log('LOS REJECTS');
            console.log(rejects);
            let comment;
            if (this.comment === undefined) {
                comment = '==============Comments==============' + '\n' + '\n' + '====================================' + '\n';
            } else {
                comment = '==============Comments==============' + '\n' + this.comment + '\n' + '====================================' + '\n';
            }
            rejects.forEach(reject => {
                if (!comment) {
                    comment = 'Tipo: ' + reject.Error_Type__c + ' Subtipo: ' + reject.Subtype_Error__c + '\n';
                } else {
                    comment += 'Tipo: ' + reject.Error_Type__c + ' Subtipo: ' + reject.Subtype_Error__c + '\n';
                }
            });
            this.handleApproval(this.action, comment);
            this.closeModal();
        }

    }

    async saveMethod() {
        if (this.action === 'Reject') {
            this.template.querySelector('c-approval-rejects').saverejects();
        } else {
            const allValidComboBoxFields = [...this.template.querySelectorAll('lightning-combobox')]
                .reduce((validSoFar, inputFields) => {
                    inputFields.reportValidity();
                    return validSoFar && inputFields.checkValidity();
                }, true);
            if (allValidComboBoxFields) {
                if (await this.isDocumentManagementUserPermission && await this.isDocumentManagementStagePermission) {
                    await this.updateTakedownVistoBueno()
                }
                await this.handleApproval(this.action, this.comment);
                await this.closeModal();
                
            } else {
                // The form is not valid
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Something is wrong',
                        message: 'Check your input and try again.',
                        variant: 'error'
                    })
                );
            }
        }
    }

    async updateTakedownVistoBueno() {
        let Takedowns_Contingency_plan__c = {
            Id: this.recordId,
            TKD_ls_Visto_bueno_finanzas__c: this.template.querySelector("[data-field='vistoBuenoFinanzas']").value
          };
        /*
        const fields = {};
        fields[TKD_Id.fieldApiName] = this.recordId;
        fields[TKD_ls_Visto_bueno_finanzas.fieldApiName] = this.template.querySelector("[data-field='vistoBuenoFinanzas']").value;

        const recordInput = { fields };*/

        //updateRecord(recordInput)
        await updateVistoBuenoFinanzas({Takedowns_Contingency_plan:Takedowns_Contingency_plan__c})
            .then(() => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Record updated',
                        variant: 'success'
                    })
                );
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error, update record',
                        message: error.body.message,
                        variant: 'error'
                    })
                );
            });
    }


    //end modal
    render() {
        return this.section;
    }

    @wire(getRecord, {
        recordId: '$recordId', fields: ['Takedowns_Contingency_plan__c.TKD_ls_takedown_stage__c', 'Takedowns_Contingency_plan__c.CPL_ls_Deal_Category__c',
            'Takedowns_Contingency_plan__c.TKD_Tollgate_1_Val__c', 'Takedowns_Contingency_plan__c.TKD_Tollgate_2_Val__c',
            'Takedowns_Contingency_plan__c.TKD_fm_Opportunity_expiration_date__c', 'Takedowns_Contingency_plan__c.TKD_fm_Remaining_days_to_expiration_date__c',
            'Takedowns_Contingency_plan__c.TKD_ls_Visto_bueno_finanzas__c']
    })
    async getaccountRecord({ data, error }) {
        console.log('takedownRecord => ', data, error);
        if (await data) {
            this.takedown = data;
            this.takedownStage = this.takedown.fields.TKD_ls_takedown_stage__c.value;
            if (this.takedownStage === 'Registry') {
                this.isDocumentManagementStagePermission = true
            } else {
                this.isDocumentManagementStagePermission = false
            }
            this.CPL_ls_Deal_Category = this.takedown.fields.CPL_ls_Deal_Category__c.value;
            this.takedownT1Val = this.takedown.fields.TKD_Tollgate_1_Val__c.value;
            console.log('takediwnT1Val:' + this.takedownT1Val)
            this.takedownT2Val = this.takedown.fields.TKD_Tollgate_2_Val__c.value;
            this.processRelatedObjects();
        } else if (error) {
            console.error('ERROR => ', JSON.stringify(error)); // handle error properly
        }
    }
    @wire(getRecord, {
        recordId: userId, fields: ['User.Profile.Name']
    })
    async getUserRecord({ data, error }) {
        console.log('getUserRecord => ', JSON.stringify(data), JSON.stringify(error));
        if (data) {
            if ((data.fields.Profile.value.fields.Name.value === 'Document Management'
                || data.fields.Profile.value.fields.Name.value === 'System Administrator'
                || data.fields.Profile.value.fields.Name.value === 'Administrador del sistema')) {
                this.isDocumentManagementUserPermission = true
            } else {
                this.isDocumentManagementUserPermission = false
            }
        } else if (error) {
            console.error('ERROR => ', JSON.stringify(error)); // handle error properly
        }
    }


    processRelatedObjects() {
        console.log('processRelatedObjects for => ', JSON.stringify(this.takedown));
        // further processing like refreshApex or calling another wire service
        this.section = blank;
        this.section = main;
    }


    get visibility() {

        vissible({ recordId: this.recordId })
            .then(async result => {
                console.log(result);
                this.visibilidad = await result

            }).catch(error => {
                console.log('error al cargar botones de approvacion:');
                console.log(error);
            })

        return this.visibilidad;
    }

    captureComment(event) {
        let com = event.target.value;
        this.comment = com;
    }
    @track label
    @track isApproval = false
    @track isRecall = false
    @track isReject = false
    abreModal(event, action) {
        this.approvalValidations = undefined;
        this.openmodal = true;
        console.log('MODAL ABIERTO')
        if (action === undefined) {
            this.action = event.target.dataset.action;
        } else {
            this.action = action;
        }
        if (this.action === 'Approve') {
            this.label = 'Approve'
            this.isApproval = true
            this.isRecall = false
            this.isReject = false
        } else if (this.action === 'Recall') {
            this.label = 'Recall'
            this.isApproval = false
            this.isRecall = true
            this.isReject = false
        } else if (this.action === 'Reject') {
            this.label = 'Reject'
            this.isApproval = false
            this.isRecall = false
            this.isReject = true
        }
        console.log('abreModal ' + JSON.stringify(this.action));
    }
    abreRecall(event) {
        this.openRecall = true;
        console.log('MODAL ABIERTO')
        this.action = event.target.dataset.action;
    }
    abreReject(event) {
        this.openReject = true;
        console.log('MODAL ABIERTO')
        this.action = event.target.dataset.action;
        console.log(this.action)
    }


    handleApproval(accion, comment) {
        if (this.takedownStage === 'Tollgate 2') {
            this.validateCheckList();
        }
        console.log(comment);
        //call modal
        console.log(`this.takedownT1Val ${this.takedownT1Val}--- this.takedownStage ${this.takedownStage}`)
        console.log(`--- this.checkListValT2 ${this.checkListValT2}`)
        if (this.CPL_ls_Deal_Category === 'Not new origination' || this.CPL_ls_Deal_Category === 'Release' || this.CPL_ls_Deal_Category === 'Workout Restructure') {
            console.log(`Action ${accion}`)
            actionAp({ recordId: this.recordId, action: accion, comment: comment })
                .then(result => {
                    this.section = blank;
                    if (accion === 'Approve') {

                        this.dispatchEvent(
                            new ShowToastEvent({
                                title: 'Success' + this.takedownStage,
                                message: this.takedownStage + ' approved Successfull',
                                variant: 'success',
                            }),
                        );
                        eval("$A.get('e.force:refreshView').fire();");
                        this.section = main;
                    } else if (accion === 'Reject') {
                        console.log('se rejecta');
                        this.dispatchEvent(
                            new ShowToastEvent({
                                title: 'Success' + this.takedownStage,
                                message: this.takedownStage + 'has been Rejected',
                                variant: 'success',
                            }),
                        );
                        eval("$A.get('e.force:refreshView').fire();");
                        this.section = main;
                    } else {
                        this.dispatchEvent(
                            new ShowToastEvent({
                                title: 'Success ' + this.takedownStage,
                                message: this.takedownStage + 'Recalled Successfull',
                                variant: 'success',
                            }),
                        );
                        eval("$A.get('e.force:refreshView').fire();");
                        this.section = main;
                    }

                })
                .catch(errores => {
                    let errorMessage = ''
                    if (errores.body) {
                        errores.body.pageErrors.forEach(element => {
                            errorMessage += element.message + ' '
                        });
                    }
                    console.log('errores ' + JSON.stringify(errores))
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: "Error on approval process",
                            message: errorMessage,
                            variant: "error"
                        })
                    );
                })
        } else if ((this.takedownT1Val === true & this.takedownStage === 'Tollgate 1') ||
            (this.takedownT2Val === true & this.takedownStage === 'Tollgate 2' & this.checkListValT2 === true) ||
            (this.takedownStage === 'Funded') ||
            (this.takedownStage === 'Registry') ||
            (accion !== 'Approve')) {

            console.log(`Action ${accion}`)
            actionAp({ recordId: this.recordId, action: accion, comment: comment })
                .then(result => {
                    this.section = blank;
                    if (accion === 'Approve') {

                        this.dispatchEvent(
                            new ShowToastEvent({
                                title: 'Success' + this.takedownStage,
                                message: this.takedownStage + ' approved Successfull',
                                variant: 'success',
                            }),
                        );
                        eval("$A.get('e.force:refreshView').fire();");
                        this.section = main;
                    } else if (accion === 'Reject') {
                        console.log('se rejecta');
                        this.dispatchEvent(
                            new ShowToastEvent({
                                title: 'Success' + this.takedownStage,
                                message: this.takedownStage + 'has been Rejected',
                                variant: 'success',
                            }),
                        );
                        eval("$A.get('e.force:refreshView').fire();");
                        this.section = main;
                    } else {
                        this.dispatchEvent(
                            new ShowToastEvent({
                                title: 'Success ' + this.takedownStage,
                                message: this.takedownStage + 'Recalled Successfull',
                                variant: 'success',
                            }),
                        );
                        eval("$A.get('e.force:refreshView').fire();");
                        this.section = main;
                    }

                })
                .catch(errores => {
                    let errorMessage = ''
                    if (errores.body) {
                        errores.body.pageErrors.forEach(element => {
                            errorMessage += element.message + ' '
                        });
                    }
                    console.log('errores ' + JSON.stringify(errores))
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: "Error on approval process",
                            message: errorMessage,
                            variant: "error"
                        })
                    );
                })
        } else if ((this.takedownT1Val === false & accion === 'Approve' & this.takedownStage === 'Tollgate 1')
            || ((this.takedownT2Val === false & accion === 'Approve' & this.takedownStage === 'Tollgate 2')
                || (this.checkListValT2 === false & accion === 'Approve' & this.takedownStage === 'Tollgate 2'))) {
            alert('You can´t approve beacuse are validations missing ' + "\n" +
                ' please review the checklist for' + this.takedownStage)
        }
    }
    async validateCheckList() {
        let suppliersApproved = false;
        let opportunityValid = false;
        let invoicesValidation = false;
        await opportunityValidDate({ opportunityExpirationDate: this.takedown.fields.TKD_fm_Opportunity_expiration_date__c.value })
            .then(result => {
                opportunityValid = result;
                console.log('result ' + JSON.stringify(result))
            })
            .catch(error => {
                console.log("Error Approval Status");
                console.log(error);
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: "Error Opportunity expiration date",
                        message: "" + JSON.stringify(error),
                        variant: "error"
                    })
                );
            });

        await getSupplierInApprovalStatus({ takedownId: this.recordId })
            .then(result => {
                console.log('Approval Status ' + JSON.stringify(result))
                if (result.length > 0) {
                    let suppliersNotApproved = result.filter(sa => sa.tkd_ls_Stage__c !== 'APPROVED')
                    console.log('suppliersNotApproved ' + JSON.stringify(suppliersNotApproved))
                    if (suppliersNotApproved.length > 0) {
                        suppliersApproved = false;
                    } else {
                        suppliersApproved = true;
                    }
                } else {
                    suppliersApproved = false;
                }
                console.log('this.suppliersApproved ' + suppliersApproved)
            }).catch(error => {
                console.log('Error Approval Status');
                console.log(error);
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error loading approval status',
                        message: '' + JSON.stringify(error),
                        variant: 'error',
                    }),
                );
            })
        console.log('opportunityValid ' + opportunityValid)
        console.log('suppliersApproved ' + suppliersApproved)
        console.log('invoicesValidation ' + invoicesValidation)
        console.log('this.checkListValT2 ' + this.checkListValT2)
        if (opportunityValid === true & suppliersApproved === true) {
            this.checkListValT2 = true;
        } else {
            this.checkListValT2 = false;
        }
        console.log('this.checkListValT2 ' + this.checkListValT2)

    }
}