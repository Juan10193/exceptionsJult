/**
 * @File Name          : customCreditBureau.js
 * @Description        : 
 * @Author             : eduardo.amiens@outlook.com
 * @Group              : 
 * @Last Modified By   : eduardo.amiens@outlook.com
 * @Last Modified On   : 5/6/2020 15:57:58
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    14/5/2020   eduardo.amiens@outlook.com     Initial Version
**/
import { LightningElement, wire, track, api } from 'lwc';
import { getRecord, createRecord, updateRecord } from 'lightning/uiRecordApi'
import { refreshApex } from '@salesforce/apex'
import getRequestsCreditBureau from '@salesforce/apex/CustomCreditBureauController.getRequestsCreditBureau'
import getEntityBypartyID from '@salesforce/apex/CustomCreditBureauController.getEntityBypartyID'
import createCreditBureau from '@salesforce/apex/CustomCreditBureauController.createCreditBureau'
import getCreditBureauApprovalProcess from '@salesforce/apex/CustomCreditBureauController.getCreditBureauApprovalProcess'
import getResultssCreditBureau from '@salesforce/apex/CustomCreditBureauController.getResultssCreditBureau'
//import getLMM_Entidad_Estructura_Settings from '@salesforce/apex/CustomCreditBureauController.getLMM_Entidad_Estructura_Settings'
import getUrl from '@salesforce/apex/CustomCreditBureauController.getUrlDocs'



import { mapRequestStep1, mapRequestStep2, initialiceForm, initialiceFormWithEntity, makeRequestStepThree } from './helperJS/helpProcess';
import USER_ID from '@salesforce/user/Id';
import EmployeeNumber from '@salesforce/schema/User.EmployeeNumber';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import LMM_Request_Credit_Bureau from '@salesforce/schema/LMM_Request_Credit_Bureau__c';
import LMM_Request_Credit_Bureau_Name from '@salesforce/schema/LMM_Request_Credit_Bureau__c.Name';
import LMM_Request_Credit_Bureau_LMM_tl_JSON_Request from '@salesforce/schema/LMM_Request_Credit_Bureau__c.LMM_tl_JSON_Request__c';
import LMM_pd_Entity_CP from '@salesforce/schema/LMM_Request_Credit_Bureau__c.LMM_pd_Entity_CP__c';
import LMM_Request_Credit_Bureau_Id from '@salesforce/schema/LMM_Request_Credit_Bureau__c.Id';
import LMM_rb_Credit_Bureau_Approval_Process from '@salesforce/schema/LMM_Request_Credit_Bureau__c.LMM_rb_Credit_Bureau_Approval_Process__c';
import LMM_ls_Status from '@salesforce/schema/LMM_Request_Credit_Bureau__c.LMM_ls_Status__c';
import trafficlightIMG from '@salesforce/resourceUrl/trafficlight';
import { CryptoJS } from "c/criptojs";
import getToken from "@salesforce/apex/LMM_WS_Tollgate_cls.getToken";
import { NavigationMixin } from 'lightning/navigation';

import blank from './views/blank.html'
import mainpage from './customCreditBureau.html'

export default class CustomCreditBureau extends NavigationMixin(LightningElement) {
    @track openModal = false
    @api entityCPId
    @api opportunityID

    @track entityInfo

    @track valueRequest
    @track valueRequestOptions

    @track disabledLetterSigningDate = true
    @track requitedLetterSigningDate = false

    @track disableCreateButton = true
    @track disableFields = true

    @track variantSelectedRequest = 'brand'
    @track selectedForApprovalProcess = false
    @track disabledSelectedRequest = false
    @track varianLabelSelectedButton = 'Selected for approval'

    @track section = mainpage

    @track validationIcon
    @track validationDescriptionIcon
    listLMM_Request_Credit_Bureau

    @track CreditBureauApprovalProcessRecord

    @track dataTableAddressData

    @track valueECEntity
    get valueECEntityOptions() {
        return [
            { label: '397', value: '397' },
            { label: 'XA7', value: 'XA7' },
            { label: '798', value: '798' }
        ];
    }
    @track autorizationLetter
    get autorizationLetterOptions() {
        return [
            { label: 'YES', value: 'YES' },
            { label: 'NO', value: 'NO' }
        ];
    }

    @track alerts = []
    @track contentId
    @track showDocumentsButtonDisable = true


    @wire(getRecord, { recordId: USER_ID, fields: [EmployeeNumber] })
    userRecord

    @wire(getRecord, { recordId: '$entityCPId', fields: ['Entity_CP__c.EM_Party_ID__c'] })
    entityCPRecord

//@wire(getLMM_Entidad_Estructura_Settings)
  //  LMM_Entidad_Estructura_Settings

    @wire(getRequestsCreditBureau, { entityCPId: '$entityCPId' })
    getRequestsCB(result) {
        this.listLMM_Request_Credit_Bureau = result
        if (result.data) {
            console.log('listLMM_Request_Credit_Bureau ' + JSON.stringify(this.listLMM_Request_Credit_Bureau))

            if (result.data.filter(index => index.LMM_ls_Status__c === 'VALIDATED').length > 0) {
                this.validationIcon = 'action:approval'
                this.validationDescriptionIcon = 'This entity has a validated credit bureau'
            } else if (result.data.filter(index => index.LMM_ls_Status__c === 'REQUEST').length > 0) {
                this.validationIcon = 'action:update_status'
                this.validationDescriptionIcon = 'This entity has a credit bureau resquested to oracle'
            } else if (result.data.filter(index => index.LMM_ls_Status__c === 'REJECTED').length > 0) {
                this.validationIcon = 'action:close'
                this.validationDescriptionIcon = 'This entity has been rejected from the approval process'
            } else if (result.data.filter(index => index.LMM_ls_Status__c === 'IN APPROVAL PROCESS').length > 0) {
                this.validationIcon = 'action:submit_for_approval'
                this.validationDescriptionIcon = 'This entity is awaiting an approval process'
            } else if (result.data.filter(index => index.LMM_ls_Status__c === 'SELECTED FOR APPROVAL PROCESS').length > 0) {
                this.validationIcon = 'action:quote'
                this.validationDescriptionIcon = 'This entity has one record for submit for approval'
            } else if (result.data.filter(index => index.LMM_ls_Status__c === 'NEW').length > 0) {
                this.validationIcon = 'action:priority'
                this.validationDescriptionIcon = 'This entity has request without process'
            } if (result.data.length === 0) {
                this.validationIcon = 'action:goal'
                this.validationDescriptionIcon = 'This entity has no requests to Credit Bureau'
            }
        } else if (result.error) {
            console.log('error' + JSON.stringify(result.error));
        }
    }

    async handleOpenModal() {
        console.log('opportunityID ' + this.opportunityID)
        console.log('entityCPId ' + this.entityCPId)
        this.openModal = true
        console.log('customCreditB ' + JSON.stringify(this.entityCPRecord))
        try {
            if (this.entityCPRecord.data) {
                let entityInfo = await getEntityBypartyID({ partyID: this.entityCPRecord.data.fields.EM_Party_ID__c.value, employeeNumber: this.userRecord.data.fields.EmployeeNumber.value })
                if (entityInfo) {
                    this.entityInfo = JSON.parse(entityInfo)
                    console.log('entitiesByEconomicGroup ' + JSON.stringify(this.entityInfo))
                    if (this.entityInfo.entityInfo.addressInfo.addresses) {
                        console.log('this.entityInfo.entityInfo.addressInfo.addresses.address ' + JSON.stringify(this.entityInfo.entityInfo.addressInfo.addresses.address))
                        this.dataTableAddressData = this.entityInfo.entityInfo.addressInfo.addresses.address.filter(index => index.purpose === 'CREDIT_CONTACT')
                    }
                }

            }
            if (this.listLMM_Request_Credit_Bureau.data !== null
                && this.listLMM_Request_Credit_Bureau.data !== undefined
                && this.listLMM_Request_Credit_Bureau.data.length > 0) {
                this.valueRequestOptions = this.listLMM_Request_Credit_Bureau.data.map(index => {
                    return { label: index.Name, value: index.Name }
                })

            } else {

                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Dear user',
                        message: 'No request has been created, please create one',
                        variant: 'warning',
                    }),
                );
            }

        } catch (error) {
            console.log('an error has ocurred ' + JSON.stringify(error))

        }
        try {
            this.CreditBureauApprovalProcessRecord = await getCreditBureauApprovalProcess({ oppId: this.opportunityID })
            console.log('this.CreditBureauApprovalProcessRecord ' + JSON.stringify(this.CreditBureauApprovalProcessRecord))
            console.log('this.listLMM_Request_Credit_Bureau.data ' + JSON.stringify(this.listLMM_Request_Credit_Bureau.data))

            let validatedRequestFromEntity = this.listLMM_Request_Credit_Bureau.data.filter(index => index.LMM_ls_Status__c === 'VALIDATED')
            console.log('validatedRequestFromEntity ' + JSON.stringify(validatedRequestFromEntity))
            if (validatedRequestFromEntity.length > 0) {
                this.valueRequest = validatedRequestFromEntity[0].Name
                this.selectedForApprovalProcess = true
                this.variantSelectedRequest = 'success'
                this.disabledSelectedRequest = true
                this.varianLabelSelectedButton = 'Approved'
            } else if (this.CreditBureauApprovalProcessRecord.Requests_Credit_Bureau1__r) {
                let inApprovalProcessRequest = this.CreditBureauApprovalProcessRecord.Requests_Credit_Bureau1__r.filter(indexFilter => this.listLMM_Request_Credit_Bureau.data.some(indexSome => indexSome.Name === indexFilter.Name && (indexFilter.LMM_ls_Status__c === 'SELECTED FOR APPROVAL PROCESS' || indexFilter.LMM_ls_Status__c === 'IN APPROVAL PROCESS')))

                console.log('inApprovalProcessRequest ' + JSON.stringify(inApprovalProcessRequest))
                if (inApprovalProcessRequest.length > 0) {
                    this.valueRequest = inApprovalProcessRequest[0].Name
                    this.selectedForApprovalProcess = true
                    this.variantSelectedRequest = 'success'
                }
            }

        } catch (error) {
            console.log('an error has ocurred ' + JSON.stringify(error))
        }

    }

    handleCloseModal() {
        this.openModal = false
    }
    async handleCreateCreditBureau() {
        const allValid = [...this.template.querySelectorAll('lightning-input')]
            .reduce((validSoFar, inputCmp) => {
                inputCmp.reportValidity();
                return validSoFar && inputCmp.checkValidity();
            }, true);
        if (allValid) {
            let valueInputs = this.template.querySelectorAll("lightning-input")
            let valueComboBoxInputs = this.template.querySelectorAll('lightning-combobox')
            let LetterSigningDate = this.template.querySelector("[data-field='LetterSigningDate']").value
            let mapC = mapRequestStep1(valueInputs, valueComboBoxInputs, this.entityInfo, this.userRecord.data.fields.EmployeeNumber.value, LetterSigningDate)
            console.log('mapC ' + JSON.stringify(mapC))
            let requestMapCB = JSON.stringify(mapC)
            console.log('requestMapCB ' + requestMapCB)
            try {
                let jsonResponseCreatedCreditBureau = await createCreditBureau({ jsonRequest: requestMapCB })
                if (jsonResponseCreatedCreditBureau) {
                    this.jsonResponseCreatedCreditBureau = JSON.parse(jsonResponseCreatedCreditBureau)
                    console.log('this.jsonResponseCreatedCreditBureau ' + JSON.stringify(this.jsonResponseCreatedCreditBureau))
                    if (this.jsonResponseCreatedCreditBureau.requestId) {
                        let responseStep2 = mapRequestStep2(mapC, this.jsonResponseCreatedCreditBureau)
                        console.log('this.responseStep2 ' + JSON.stringify(responseStep2))
                        this.createSFCreditBureau(JSON.stringify(this.jsonResponseCreatedCreditBureau.requestId), JSON.stringify(responseStep2))

                    }
                }
            } catch (error) {
                console.log('ocurrio un error ' + JSON.stringify(error))
            }

        } else {
            alert('Please update the invalid form entries and try again.');
        }


    }
    async createSFCreditBureau(requestId, jsonRequest) {
        this.section = blank
        console.log('inicia creación')
        const fields = {};
        fields[LMM_Request_Credit_Bureau_Name.fieldApiName] = requestId;
        fields[LMM_Request_Credit_Bureau_LMM_tl_JSON_Request.fieldApiName] = jsonRequest;
        fields[LMM_pd_Entity_CP.fieldApiName] = this.entityCPId;

        console.log('JSON.stringify(fields) ' + JSON.stringify(fields))
        const recordInput = { apiName: LMM_Request_Credit_Bureau.objectApiName, fields };
        await createRecord(recordInput).then(record => {
            console.log('record.Id ' + record.Id)
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'The request has been created',
                    variant: 'success',
                }),
            );
            refreshApex(this.listLMM_Request_Credit_Bureau);
        }).catch(error => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error creating record',
                    message: error.body.message,
                    variant: 'error',
                }),
            );
        });
        this.handleOpenModal()
        this.section = mainpage
    }
    handleComboBoxRequestChange(event) {
        this.disableCreateButton = true
        this.valueRequest = event.detail.value
        let valueInputs = this.template.querySelectorAll("lightning-input");
        let valueComboBoxInputs = this.template.querySelectorAll('lightning-combobox')
        let valueRequestToWork = this.listLMM_Request_Credit_Bureau.data.filter(index => index.Name === event.detail.value)
        console.log('valueRequestToWork ' + JSON.stringify(valueRequestToWork))
        initialiceForm(valueInputs, valueComboBoxInputs, JSON.parse(valueRequestToWork[0].LMM_tl_JSON_Request__c))
        if (valueRequestToWork[0].LMM_ls_Status__c === 'VALIDATED') {
            this.selectedForApprovalProcess = true
            this.variantSelectedRequest = 'success'
            this.disabledSelectedRequest = true
            this.varianLabelSelectedButton = 'Approved'
        } else if (valueRequestToWork[0].LMM_ls_Status__c === 'SELECTED FOR APPROVAL PROCESS') {
            this.selectedForApprovalProcess = true
            this.variantSelectedRequest = 'success'
        } else {
            this.selectedForApprovalProcess = false
            this.variantSelectedRequest = 'brand'
        }
    }
    async handleSelectForApproval() {
        if (this.valueRequest === null || this.valueRequest === undefined || this.valueRequest === '' || this.valueRequest.length === 0) {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Please',
                    message: 'First select some request',
                    variant: 'warning'
                })
            );
        } else {
            let valueRequestToWork = this.listLMM_Request_Credit_Bureau.data.filter(index => index.Name === this.valueRequest)
            this.selectedForApprovalProcess = !this.selectedForApprovalProcess
            this.variantSelectedRequest = this.selectedForApprovalProcess === true ? 'success' : 'brand'
            let approvalProcessID
            let newStatus
            if (valueRequestToWork[0].LMM_ls_Status__c === 'NEW') {
                approvalProcessID = this.CreditBureauApprovalProcessRecord.Id
                newStatus = 'SELECTED FOR APPROVAL PROCESS'
            } else if (valueRequestToWork[0].LMM_ls_Status__c === 'SELECTED FOR APPROVAL PROCESS') {
                approvalProcessID = ''
                newStatus = 'NEW'
            }

            const fields = {};
            fields[LMM_Request_Credit_Bureau_Id.fieldApiName] = valueRequestToWork[0].Id;
            fields[LMM_rb_Credit_Bureau_Approval_Process.fieldApiName] = approvalProcessID;
            fields[LMM_ls_Status.fieldApiName] = newStatus;

            const recordInput = { fields };

            updateRecord(recordInput)
                .then(() => {
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Success',
                            message: 'Your record has been selected for Credit Bureau Approval process',
                            variant: 'success'
                        })
                    );
                    refreshApex(this.listLMM_Request_Credit_Bureau);
                })
                .catch(error => {
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Error updated record',
                            message: error.body.message,
                            variant: 'error'
                        })
                    );
                });


        }

    }
    handleComboBoxAutorizationLetter(event) {
        if (event.detail.value === 'YES') {
            this.disabledLetterSigningDate = false
            this.requitedLetterSigningDate = true
        } else {
            this.disabledLetterSigningDate = true
            this.requitedLetterSigningDate = false
            this.template.querySelector("[data-field='LetterSigningDate']").value = null
        }
    }
    createCB(event) {
        if (this.listLMM_Request_Credit_Bureau.data.filter(index => index.LMM_ls_Status__c === 'VALIDATED').length > 0) {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Sorry',
                    message: 'You can not create new request if you have a validation request',
                    variant: 'warning'
                })
            );
        } else {
            this.template.querySelectorAll('lightning-input').forEach(each => {
                each.value = '';
            });
            this.template.querySelectorAll('lightning-combobox').forEach(each => {
                each.value = '';
            });
            this.selectedForApprovalProcess = false
            this.variantSelectedRequest = 'brand'
            this.disableCreateButton = false
            console.log('event.target.dataset.requestid ' + event.target.dataset.requestid)
            let requestid = event.target.dataset.requestid
            console.log('this.entityInfo.entityInfo.addressInfo.addresses.address ' + JSON.stringify(this.entityInfo.entityInfo.addressInfo.addresses.address))
            let addressData = this.entityInfo.entityInfo.addressInfo.addresses.address.filter(index => index.locationId === Number(requestid))
            if (addressData.length > 0) {
                addressData = addressData[0]
            }
            console.log('addressData ' + JSON.stringify(addressData))
            let valueInputs = this.template.querySelectorAll("lightning-input")
            initialiceFormWithEntity(valueInputs, addressData, this.entityInfo)
        }

    }
    async handleSearchResult() {
        let getSelectedRequest = this.listLMM_Request_Credit_Bureau.data.filter(index => index.Name === this.valueRequest)
        console.log('getSelectedRequest ' + JSON.stringify(getSelectedRequest))

        try {
            console.log('this.entityInfo ' + JSON.stringify(this.entityInfo))
            console.log('valueRequest ' + this.valueRequest)
            let makeRequest = makeRequestStepThree(this.entityInfo, this.valueRequest, this.userRecord.data.fields.EmployeeNumber.value)
            console.log('makeRequestStepThrees ' + JSON.stringify(makeRequest))
            let requestJSONStepThree = JSON.stringify(makeRequest)
            let searchResult = await getResultssCreditBureau({ jsonParameter: requestJSONStepThree })
            if (searchResult) {
                console.log('searchResult1 ' + JSON.stringify(searchResult))
                let response = JSON.parse(searchResult)
                console.log('searchResult ' + JSON.stringify(response))
                if (response.getRequest.detailRequest.requestACB.alerts) {
                    let alerts = response.getRequest.detailRequest.requestACB.alerts.alert
                    this.alerts = alerts.map(index => {
                        let img
                        if (index.color === 'RED') {
                            img = trafficlightIMG + '/trafficlightRed.png'
                        } else if (index.color === 'YELLOW') {
                            img = trafficlightIMG + '/trafficlightYellow.png'
                        } else if (index.color === 'GREEN') {
                            img = trafficlightIMG + '/trafficlightGreen.png'
                        }
                        return {
                            'type': index.type,
                            'message': index.message,
                            'color': img
                        }
                    })
                }
                if(response.getRequest.detailRequest.requestACB.contentId){
                    this.contentId = response.getRequest.detailRequest.requestACB.contentId
                    this.showDocumentsButtonDisable = false
                }
            }

        } catch (error) {
            console.log('Ocurrio un error en el step 3')
        }

    }
    async handleShowDocuments() {
        let token;
        try {
            token = await getToken();
        } catch (errortoken) {
            console.log("error al consultar token");
            this.dispatchEvent(
                new ShowToastEvent({
                    title: "Error to get token content",
                    message: errortoken,
                    variant: "error"
                })
            );
        }
        let key
        if (token) {
            key = JSON.parse(token);
        }
        let url = await getUrl();
        this.urlContent = url + '?contentId=' + this.contentId + "&id=" + key.token
        console.log('URL CONTENT')
        console.log('this.urlContent ' + this.urlContent);
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
            window.open(this.urlContent)
        });
    }
    render() {
        return this.section
    }

}