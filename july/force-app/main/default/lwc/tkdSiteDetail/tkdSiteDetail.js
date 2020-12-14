/**
 * @description       : 
 * @author            : eduardo.amiens@outlook.com
 * @group             : 
 * @last modified on  : 09-14-2020
 * @last modified by  : eduardo.amiens@outlook.com
 * Modifications Log 
 * Ver   Date         Author                       Modification
 * 1.0   08-10-2020   eduardo.amiens@outlook.com   Initial Version
**/
import { LightningElement, api, wire, track } from 'lwc';
import { getRecord, deleteRecord, createRecord, updateRecord } from 'lightning/uiRecordApi';
import getSiteWithBanksAndContacts from "@salesforce/apex/tkdSiteDetailController.getSiteWithBanksAndContacts";
import updateBankAccounts from "@salesforce/apex/tkdSiteDetailController.updateBankAccounts";

import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex'
import { getPicklistValues } from 'lightning/uiObjectInfoApi';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import TKD_Site_OBJECT from '@salesforce/schema/TKD_Site__c';

import Tkd_ls_Org_Name from '@salesforce/schema/TKD_Site__c.Tkd_ls_Org_Name__c'
import TKD_Vat_code from '@salesforce/schema/TKD_Site__c.TKD_Vat_code__c';
import SR_ls_Custom_Currency from '@salesforce/schema/TKD_Site__c.SR_ls_Custom_Currency__c';
import tkd_tf_phone from '@salesforce/schema/TKD_Site__c.tkd_tf_phone__c';
import Tkd_at_Address_line_1 from '@salesforce/schema/TKD_Site__c.Tkd_at_Address_line_1__c';
import Tkd_at_Address_line_2 from '@salesforce/schema/TKD_Site__c.Tkd_at_Address_line_2__c';
import Tkd_tx_Zip from '@salesforce/schema/TKD_Site__c.Tkd_tx_Zip__c';
import Tkd_tx_City from '@salesforce/schema/TKD_Site__c.Tkd_tx_City__c';
import TKD_ls_State from '@salesforce/schema/TKD_Site__c.TKD_ls_State__c';
import TKD_tx_Country from '@salesforce/schema/TKD_Site__c.TKD_tx_Country__c';
import SupplierId from '@salesforce/schema/TKD_Site__c.Supplier__c';
import SiteId from '@salesforce/schema/TKD_Site__c.Id';



import TKD_CPL_ls_Operation_Unit from '@salesforce/schema/Takedowns_Contingency_plan__c.CPL_ls_Operation_Unit__c';





const actions = [
    { label: 'Show details', name: 'show_details' },
    { label: 'Delete', name: 'delete' },
];

const bankAccountsColumns = [
    { label: 'Bank Name', fieldName: 'SR_tx_Bank_Name__c' },
    { label: 'Account Number', fieldName: 'Name' },
    { label: 'Currency', fieldName: 'Bank_Account_Currency__c' },
    { label: 'SWIFT/ABA/IBAN Value', fieldName: 'Codigo_BIC__c' }, {
        type: 'action',
        typeAttributes: { rowActions: actions },
    },
];
const contactsColumns = [
    { label: 'First Name', fieldName: 'FirstName' },
    { label: 'Last Name', fieldName: 'LastName' },
    { label: 'Phone', fieldName: 'Phone' },
    { label: 'Email', fieldName: 'Email' },
    {
        type: 'action',
        typeAttributes: { rowActions: actions },
    },
];
export default class TkdSiteDetail extends LightningElement {
    @api siteId
    @api takedownId
    @api supplierId
    @track openModalAskDelete

    @track recordToDelete

    @track readonly = true

    @track bankAccountsData = []
    @track ContactsData = []
    bankAccountsColumns = bankAccountsColumns
    contactsColumns = contactsColumns

    resultGetRecord

    isSelectedEditing
    isReadOnly

    @track TKD_Vat_codeValue
    @track TKD_Vat_codeOptions = []

    @track SR_ls_Custom_CurrencyValue
    @track SR_ls_Custom_CurrencyOptions = []

    @track TKD_ls_StateValue
    @track TKD_ls_StateOptions = []

    @track TKD_tx_CountryValue
    @track TKD_tx_CountryOptions = []

    @track requiredState = true
    @track disableState = true

    connectedCallback() {
        console.log('constructor ' + JSON.stringify(this.siteId))
        console.log('supplierId ' + this.supplierId)
        //Si existe un registro para edición, el botón tendrá la opción de editar
        //y los campos estarán de solo lectura
        if (this.siteId !== null && this.siteId !== undefined) {
            this.isSelectedEditing = false
            this.isReadOnly = true
        } else { // si no existe el registro, los campos serán editables
            this.isSelectedEditing = true
            this.isReadOnly = false
        }
        this.dispatchEvent(new CustomEvent('disablesave', { detail: this.isReadOnly }));
    }

    @wire(getObjectInfo, { objectApiName: TKD_Site_OBJECT })
    siteObjectInfo;

    @wire(getPicklistValues, { recordTypeId: '$siteObjectInfo.data.defaultRecordTypeId', fieldApiName: TKD_Vat_code })
    getTKD_Vat_code(result) {
        let loadProgress = { getTKD_Vat_code: true }
        //console.log('getTKD_Vat_code ' + JSON.stringify(result))
        if (result.data) {
            this.TKD_Vat_codeOptions = result.data.values.map(index => {
                return {
                    label: index.label, value: index.value
                }
            })
            this.dispatchEvent(new CustomEvent('loadcomplete', { detail: loadProgress }))
        } else if (result.error) {
            console.error('Ocurrió un error al consultar getTKD_Vat_code ' + JSON.stringify(result.error))
            this.dispatchEvent(new CustomEvent('loadcomplete', { detail: loadProgress }))
        }
    }
    @wire(getPicklistValues, { recordTypeId: '$siteObjectInfo.data.defaultRecordTypeId', fieldApiName: SR_ls_Custom_Currency })
    getSR_ls_Custom_Currency(result) {
        let loadProgress = { getSR_ls_Custom_Currency: true }
        //console.log('getSR_ls_Custom_Currency ' + JSON.stringify(result))
        if (result.data) {
            this.SR_ls_Custom_CurrencyOptions = result.data.values.map(index => {
                return {
                    label: index.label, value: index.value
                }
            })
            this.dispatchEvent(new CustomEvent('loadcomplete', { detail: loadProgress }))
        } else if (result.error) {
            console.error('Ocurrió un error al consultar getSR_ls_Custom_Currency ' + JSON.stringify(result.error))
            this.dispatchEvent(new CustomEvent('loadcomplete', { detail: loadProgress }))
        }
    }
    @wire(getPicklistValues, { recordTypeId: '$siteObjectInfo.data.defaultRecordTypeId', fieldApiName: TKD_ls_State })
    getTKD_ls_State(result) {
        let loadProgress = { getTKD_ls_State: true }
        //console.log('getSR_ls_Custom_Currency ' + JSON.stringify(result))
        if (result.data) {
            this.TKD_ls_StateOptions = result.data.values.map(index => {
                return {
                    label: index.label, value: index.value
                }
            })
            this.dispatchEvent(new CustomEvent('loadcomplete', { detail: loadProgress }))
        } else if (result.error) {
            console.error('Ocurrió un error al consultar getTKD_ls_State ' + JSON.stringify(result.error))
            this.dispatchEvent(new CustomEvent('loadcomplete', { detail: loadProgress }))
        }
    }
    @wire(getPicklistValues, { recordTypeId: '$siteObjectInfo.data.defaultRecordTypeId', fieldApiName: TKD_tx_Country })
    getTKD_tx_Country(result) {
        let loadProgress = { getTKD_tx_Country: true }
        //console.log('getTKD_tx_Country ' + JSON.stringify(result))
        if (result.data) {
            this.TKD_tx_CountryOptions = result.data.values.map(index => {
                return {
                    label: index.label, value: index.value
                }
            })
            this.dispatchEvent(new CustomEvent('loadcomplete', { detail: loadProgress }))
        } else if (result.error) {
            console.error('Ocurrió un error al consultar getTKD_tx_Country ' + JSON.stringify(result.error))
            this.dispatchEvent(new CustomEvent('loadcomplete', { detail: loadProgress }))
        }
    }
    @wire(getSiteWithBanksAndContacts, { siteId: '$siteId' })
    wireGetRecordResult(result) {
        console.log('getSiteWithBanksAndContacts result ' + JSON.stringify(result))
        this.resultGetRecord = result
        this.asignData()
    }

    asignData() {
        let loadProgress = { asignData: true }
        if (this.resultGetRecord.data) {
            if (this.isReadOnly) {
                this.template.querySelector("[data-field='taxCodeReadOnly']").value = this.resultGetRecord.data.TKD_Vat_code__c
                //this.template.querySelector("[data-field='currencyReadOnly']").value = this.resultGetRecord.data.SR_ls_Custom_Currency__c
                this.template.querySelector("[data-field='StateReadOnly']").value = this.resultGetRecord.data.TKD_ls_State__c
                this.template.querySelector("[data-field='countryReadOnly']").value = this.resultGetRecord.data.TKD_tx_Country__c
            } else {
                this.template.querySelector("[data-field='taxCode']").value = this.resultGetRecord.data.TKD_Vat_code__c
                //this.template.querySelector("[data-field='currency']").value = this.resultGetRecord.data.SR_ls_Custom_Currency__c
                this.template.querySelector("[data-field='State']").value = this.resultGetRecord.data.TKD_ls_State__c
                this.template.querySelector("[data-field='country']").value = this.resultGetRecord.data.TKD_tx_Country__c
            }
            this.template.querySelector("[data-field='phone']").value = this.resultGetRecord.data.tkd_tf_phone__c
            this.template.querySelector("[data-field='addLine1']").value = this.resultGetRecord.data.Tkd_at_Address_line_1__c
            this.template.querySelector("[data-field='addLine2']").value = this.resultGetRecord.data.Tkd_at_Address_line_2__c
            this.template.querySelector("[data-field='zip']").value = this.resultGetRecord.data.Tkd_tx_Zip__c
            this.template.querySelector("[data-field='city']").value = this.resultGetRecord.data.Tkd_tx_City__c
            this.bankAccountsData = this.resultGetRecord.data.Bank_Accounts__r
            this.ContactsData = this.resultGetRecord.data.Contacts__r
            this.validateCountry()
            this.dispatchEvent(new CustomEvent('loadcomplete', { detail: loadProgress }))
        } else if (this.resultGetRecord.error) {
            console.log('An error has been ocurred ' + JSON.stringify(this.resultGetRecord.error))
            this.dispatchEvent(new CustomEvent('loadcomplete', { detail: loadProgress }))
        } else {
            this.dispatchEvent(new CustomEvent('loadcomplete', { detail: loadProgress }))
        }
    }

    @wire(getRecord, { recordId: '$takedownId', fields: [TKD_CPL_ls_Operation_Unit] })
    getTakedownRecord(result) {
        let loadProgress = { getTakedownRecord: true }
        console.log('getTakedownRecord ' + JSON.stringify(result))

        if (result.data) {
            switch (result.data.fields.CPL_ls_Operation_Unit__c.value) {
                case 'UO_397 HOLDING':
                    this.template.querySelector("[data-field='orgName']").value = 'UO_397 HOLDING'
                    break
                case 'UO_798 SOFOM':
                    this.template.querySelector("[data-field='orgName']").value = 'UO_798 SOFOM'
                    break
                case 'UO_XA7 ENGECAP':
                    this.template.querySelector("[data-field='orgName']").value = 'UO_XA7 ENGENCAP'
                    break
                default:
                    break
            }
            this.dispatchEvent(new CustomEvent('loadcomplete', { detail: loadProgress }))
        } else if (result.error) {
            console.error('Ocurrio un error al consultar el takedown ' + JSON.stringify(result.error))
            this.dispatchEvent(new CustomEvent('loadcomplete', { detail: loadProgress }))
        }
    }

    async handleOpenBankAccountModal(row) {
        let bankAccountId = ''
        if (row !== null && row !== undefined)
            bankAccountId = row.Id
        if (await this.handleSave())
            this.dispatchEvent(new CustomEvent('openbankaccountmodal', { detail: bankAccountId }));
    }

    async handleOpenContactModal(row) {
        let contactId = ''
        if (row !== null && row !== undefined)
            contactId = row.Id
        if (await this.handleSave())
            this.dispatchEvent(new CustomEvent('opencontactmodal', { detail: contactId }));
    }

    handleBankAccountRowAction(event) {
        const actionName = event.detail.action.name;
        const row = event.detail.row;
        switch (actionName) {
            case 'delete':
                this.askToDeleteRow(row);
                break;
            case 'show_details':
                this.handleOpenBankAccountModal(row);
                break;
            default:
        }
    }
    handleContactRowAction(event) {
        const actionName = event.detail.action.name;
        const row = event.detail.row;
        switch (actionName) {
            case 'delete':
                this.askToDeleteRow(row);
                break;
            case 'show_details':
                this.handleOpenContactModal(row);
                break;
            default:
        }
    }
    askToDeleteRow(row) {
        this.openModalAskDelete = true
        this.recordToDelete = row.Id
    }
    deleteRow() {
        deleteRecord(this.recordToDelete)
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
        this.recordToDelete = undefined
    }
    cancelDelete() {
        this.openModalAskDelete = false
        this.recordToDelete = undefined
    }
    @api
    async handleSave() {
        console.info('inicia handleSave')
        let resultOperation = false
        console.info('1')
        let allValidInputFields = await [...this.template.querySelectorAll('lightning-input')]
            .reduce((validSoFar, inputFields) => {
                inputFields.reportValidity();
                return validSoFar && inputFields.checkValidity();
            }, true);
        console.info('2')
        let allValidComboBoxFields = await [...this.template.querySelectorAll('lightning-combobox')]
            .reduce((validSoFar, inputFields) => {
                inputFields.reportValidity();
                return validSoFar && inputFields.checkValidity();
            }, true);
        console.info('3')
        console.log('allValidInputFields ' + allValidInputFields)
        console.log('allValidComboBoxFields ' + allValidComboBoxFields)
        console.info('4')
        if (allValidInputFields && allValidComboBoxFields) {
            if (this.siteId === null || this.siteId === undefined) {
                console.log('Está creando un registro')
                if (this.isReadOnly !== true)
                    await this.createSite()
                resultOperation = true
            } else {
                console.log('Está actualizando un registro')
                if (this.isReadOnly !== true)
                    await this.updateSite()
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
        console.log('Inicia getFields')
        const fields = {};
        if (this.siteId !== null && this.siteId !== undefined)
            fields[SiteId.fieldApiName] = this.siteId;
        fields[SupplierId.fieldApiName] = this.supplierId;
        fields[Tkd_ls_Org_Name.fieldApiName] = this.template.querySelector("[data-field='orgName']").value
        fields[TKD_Vat_code.fieldApiName] = this.template.querySelector("[data-field='taxCode']").value
        fields[tkd_tf_phone.fieldApiName] = this.template.querySelector("[data-field='phone']").value
        fields[Tkd_at_Address_line_1.fieldApiName] = this.template.querySelector("[data-field='addLine1']").value
        fields[Tkd_at_Address_line_2.fieldApiName] = this.template.querySelector("[data-field='addLine2']").value
        fields[Tkd_tx_Zip.fieldApiName] = this.template.querySelector("[data-field='zip']").value
        fields[Tkd_tx_City.fieldApiName] = this.template.querySelector("[data-field='city']").value
        if (this.disableState === false)
            fields[TKD_ls_State.fieldApiName] = this.template.querySelector("[data-field='State']").value
        fields[TKD_tx_Country.fieldApiName] = this.template.querySelector("[data-field='country']").value

        console.log('termina getFields ' + JSON.stringify(fields))
        return fields;

    }

    async createSite() {
        const fields = this.getFields();

        const recordInput = { apiName: TKD_Site_OBJECT.objectApiName, fields };
        await createRecord(recordInput)
            .then(site => {
                console.log(' site l ' + JSON.stringify(site))
                this.siteId = site.id;
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Site has been created',
                        variant: 'success',
                    }),
                );
                try {
                    updateBankAccounts({ siteId: this.siteId })
                    console.log('éxtio al actualizar los bank account')
                } catch (error) {
                    console.error(JSON.stringify(error))
                }
                refreshApex(this.resultGetRecord)
                this.dispatchEvent(new CustomEvent('handlegetsaveresultsite', { detail: this.siteId }));
                this.invertButtons()
            })
            .catch(error => {
                console.error(JSON.stringify(error))
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error creating record',
                        message: error.body.message,
                        variant: 'error',
                    }),
                );
            });
    }
    async updateSite() {
        console.log('Inicia updateSite')
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
                try {
                    updateBankAccounts({ siteId: this.siteId })
                    console.log('éxtio al actualizar los bank account')
                } catch (error) {
                    console.error(JSON.stringify(error))
                }

                refreshApex(this.resultGetRecord)
                this.invertButtons()
            })
            .catch(error => {
                console.error(JSON.stringify(error))
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error update record',
                        message: error.body.message,
                        variant: 'error'
                    })
                );
            });

    }
    validatePhone(event) {
        let phoneField = this.template.querySelector("[data-field='phone']")
        let phoneFieldValue = phoneField.value
        // is input valid text?
        if (isNaN(phoneFieldValue)) {
            phoneField.setCustomValidity("Only input numbers, not text or special characters");
        } else {
            phoneField.setCustomValidity(""); // if there was a custom error before, reset it
        }
        phoneField.reportValidity(); // Tells lightning-input to show the error right away without needing interaction

    }
    validateZip(event) {
        let zipField = this.template.querySelector("[data-field='zip']")
        let zipFieldValue = zipField.value
        // is input valid text?
        if (isNaN(zipFieldValue)) {
            zipField.setCustomValidity("Only input numbers, not text or special characters");
        } else {
            zipField.setCustomValidity(""); // if there was a custom error before, reset it
        }
        zipField.reportValidity(); // Tells lightning-input to show the error right away without needing interaction

    }
    validateCountry(event) {
        try {
            let country = this.template.querySelector("[data-field='country']").value
            console.log('country ' + country)
            this.requiredState = country === 'MX' ? true : false
            this.disableState = !this.requiredState
            if (this.disableState)
                this.template.querySelector("[data-field='State']").value = ''
        } catch (error) {
            console.log('error ' + error)
        }
    }

    @api
    handleEditClick() {
        if (this.isSelectedEditing === true && this.validateChanges()) {
            this.handleSave()
        } else if (this.siteId !== null && this.siteId !== undefined) {
            this.invertButtons()
        }
        this.dispatchEvent(new CustomEvent('disablesave', { detail: this.isReadOnly }));
    }

    validateChanges() {
        let someFieldHasChanged = false
        if (this.resultGetRecord.data)
            if (this.template.querySelector("[data-field='taxCode']").value !== this.resultGetRecord.data.TKD_Vat_code__c
                //|| this.template.querySelector("[data-field='currency']").value !== this.resultGetRecord.data.SR_ls_Custom_Currency__c
                || this.template.querySelector("[data-field='phone']").value !== this.resultGetRecord.data.tkd_tf_phone__c
                || this.template.querySelector("[data-field='addLine1']").value !== this.resultGetRecord.data.Tkd_at_Address_line_1__c
                || this.template.querySelector("[data-field='addLine2']").value !== this.resultGetRecord.data.Tkd_at_Address_line_2__c
                || this.template.querySelector("[data-field='zip']").value !== this.resultGetRecord.data.Tkd_tx_Zip__c
                || this.template.querySelector("[data-field='city']").value !== this.resultGetRecord.data.Tkd_tx_City__c
                || this.template.querySelector("[data-field='State']").value !== this.resultGetRecord.data.TKD_ls_State__c
                || this.template.querySelector("[data-field='country']").value !== this.resultGetRecord.data.TKD_tx_Country__c) {
                someFieldHasChanged = true
            }
        console.log('someFieldHasChanged ' + someFieldHasChanged)
        return someFieldHasChanged
    }

    async invertButtons() {
        this.isReadOnly = await this.isSelectedEditing
        this.isSelectedEditing = await !this.isSelectedEditing
        this.dispatchEvent(new CustomEvent('disablesave', { detail: this.isReadOnly }));

        this.asignData()
    }

    @api
    async handleRefreshRecord() {
        console.log('handleRefreshRecord')
        JSON.stringify(this.resultGetRecord)
        await refreshApex(this.resultGetRecord)
    }
}