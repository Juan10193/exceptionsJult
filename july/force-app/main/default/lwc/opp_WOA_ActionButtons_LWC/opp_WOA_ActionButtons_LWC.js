/* eslint-disable no-alert */
/* eslint-disable no-eval */
/**
 * @File Name          : opp_WOA_ActionButtons_LWC.js
 * @Description        : 
 * @Author             : benedick.esquivel@engen.com.mx y karina.torres@engen.com.mx
 * @Group              : 
 * @Last Modified By   : benedick.esquivel@engen.com.mx
 * @Last Modified On   : 08-10-2020
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    08/10/2020   angel87ambher@gmail.com     Initial Version
**/
import { LightningElement, api, wire, track } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
import { registerListener, unregisterAllListeners } from 'c/pubsub';
import actionAp from '@salesforce/apex/opp_WOA_ActionsButtonsController.processApproval';
import main from './opp_WOA_ActionButtons_LWC.html';
import blank from './blank.html';
import vissible from '@salesforce/apex/opp_WOA_ActionsButtonsController.handleVisibilityBtns';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { getRecord, updateRecord } from 'lightning/uiRecordApi';
import momentJs from '@salesforce/resourceUrl/momentJs';
import { loadScript } from 'lightning/platformResourceLoader';
import userId from '@salesforce/user/Id';
import Opportunity from'@salesforce/schema/Opportunity';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';

export default class Opp_WOA_ActionButtons_LWC extends LightningElement {
    @api recordId;
    @api objectApiName;
    @wire(CurrentPageReference) pageRef;
    @track visibilidad;
    @track section = main;
    @track Opportunity;
    @track OpportunityStage;
    @track comment;
    //Modal
    @track openMainModal = false;
    @track openmodal = false;
    @track openRecall = false;
    @track openReject = false;
    @track action;
    @track approvalValidations;
    @track isApproval = false
    @track isRecall = false
    @track isReject = false
    //Users Approval Process Permissions 
    @track isLegalUserPermission = false
    @track isLegalStagePermission = false
    @track isControlDeskUserPermission = false
    @track isControlDeskStagePermission = false

    connectedCallback() {
        console.log('objectapi: ' + this.objectApiName)
        registerListener('approvalValidations', this.handleValidations, this);
        registerListener("saverejects", this.saveReject, this);
    }

    @wire(getObjectInfo, { objectApiName: Opportunity })
    Opportunity;

    renderedCallback() {
        Promise.all([
            loadScript(this, momentJs)
        ]).then(() => { 'scripts cargadinos' });

    }

    handleValidations(event) {
        console.log('DATA DEL EVENTO');
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

    //end modal
    render() {
        return this.section;
    }

    @wire(getRecord, {
        recordId: '$recordId', fields: ['Opportunity.StageName']
    })
    getOppRecord({ data, error }) {
        console.log('OPP => ' + JSON.stringify(data));
        if (data) {
            this.Opportunity = data;
            this.OpportunityStage = this.Opportunity.fields.StageName.value;
            console.log('OPP => ', data, error, this.OpportunityStage);
            if (this.OpportunityStage === 'Tollgate 1' || this.OpportunityStage === 'Tollgate 2' ) {
                this.isControlDeskStagePermission = true
            } 
            else if (this.OpportunityStage === 'Legal') {
                this.isLegalStagePermission = false
            }
            else {
                this.isControlDeskStagePermission = false
            }
            this.processRelatedObjects();
        } else if (error) {
            console.log('AQUI ES EL ERROR')
            console.error('ERROR => ', JSON.stringify(error)); // handle error properly
        }
    }
    @wire(getRecord, {
        recordId: userId, fields: ['User.Profile.Name']
    })
    async getUserRecord({ data, error }) {
        console.log('getUserRecord => ', JSON.stringify(data), JSON.stringify(error));
        if (data) {
            if ((data.fields.Profile.value.fields.Name.value === 'Control Desk'
                || data.fields.Profile.value.fields.Name.value === 'Legal'
                || data.fields.Profile.value.fields.Name.value === 'System Administrator'
                || data.fields.Profile.value.fields.Name.value === 'Administrador del sistema')) {
                this.isControlDeskUserPermission = true
                this.isLegalUserPermission = true
            } else {
                this.isControlDeskUserPermission = false
                this.isLegalUserPermission = false
            }
        } else if (error) {
            console.error('ERROR => ', JSON.stringify(error)); // handle error properly
        }
    }

    processRelatedObjects() {
        console.log('processRelatedObjects for => ', JSON.stringify(this.Opportunity));
        // further processing like refreshApex or calling another wire service
        this.section = blank;
        this.section = main;
    }


    get visibility() {

        vissible({ recordId: this.recordId, stagename: this.OpportunityStage})
            .then(async result => {
                console.log('Debug visible' + result);
                this.visibilidad = await result

            }).catch(error => {
                console.log('error al cargar botones de aprobacion:');
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


    async handleApproval(accion, comment) {
        console.error(comment + this.OpportunityStage);
        //call modal
        //console.log(`this.takedownT1Val ${this.OpportunityT1Val}--- this.takedownStage ${this.OpportunityStage}`)
        //console.log(`--- this.checkListValT2 ${this.checkListValT2}`)
        if (this.OpportunityStage === 'Tollgate 1' || this.OpportunityStage === 'Legal' || this.OpportunityStage === 'Tollgate 2') {
            console.log(`Action ---> ${accion}`)
            actionAp({ recordId: this.recordId, action: accion, comment: comment, stagename: this.OpportunityStage })
                .then(result => {
                    this.section = blank;
                    if (accion === 'Approve') {

                        this.dispatchEvent(
                            new ShowToastEvent({
                                title: 'Success' + this.OpportunityStage,
                                message: this.OpportunityStage + ' approved Successfull',
                                variant: 'success',
                            }),
                        );
                        eval("$A.get('e.force:refreshView').fire();");
                        this.section = main;
                    } else if (accion === 'Reject') {
                        console.log('se rejecta');
                        this.dispatchEvent(
                            new ShowToastEvent({
                                title: 'Success' + this.OpportunityStage,
                                message: this.OpportunityStage + 'has been Rejected',
                                variant: 'success',
                            }),
                        );
                        eval("$A.get('e.force:refreshView').fire();");
                        this.section = main;
                    } else {
                        this.dispatchEvent(
                            new ShowToastEvent({
                                title: 'Success ' + this.OpportunityStage,
                                message: this.OpportunityStage + 'Recalled Successfull',
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
        } 
    }
}