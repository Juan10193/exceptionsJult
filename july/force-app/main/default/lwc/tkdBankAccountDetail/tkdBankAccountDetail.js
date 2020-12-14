/**
 * @description       : 
 * @author            : eduardo.amiens@outlook.com
 * @group             : 
 * @last modified on  : 10-29-2020
 * @last modified by  : eduardo.amiens@outlook.com
 * Modifications Log 
 * Ver   Date         Author                       Modification
 * 1.0   08-13-2020   eduardo.amiens@outlook.com   Initial Version
**/
import { LightningElement, api, wire, track } from 'lwc';
import { getRecord, createRecord, updateRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex'
import { getPicklistValues, getObjectInfo } from 'lightning/uiObjectInfoApi';
import getTKD_Bank_Account from "@salesforce/apex/tkdBankAccountDetailController.getTKD_Bank_Account";
import bankAccount_Id from '@salesforce/schema/Bank_Account__c.Id';
import Bank_Name from '@salesforce/schema/Bank_Account__c.Bank_Name__c';
import Bank_Account_Currency from '@salesforce/schema/Bank_Account__c.Bank_Account_Currency__c';
import Name from '@salesforce/schema/Bank_Account__c.Name';
import Bank_Account_Name from '@salesforce/schema/Bank_Account__c.Bank_Account_Name__c';
import RecordTypeId from '@salesforce/schema/Bank_Account__c.RecordTypeId';
import TKD_rb_Site from '@salesforce/schema/Bank_Account__c.TKD_rb_Site__c';
import Contexto from '@salesforce/schema/Bank_Account__c.Contexto__c';
import Tipo_BIC from '@salesforce/schema/Bank_Account__c.Tipo_BIC__c';
import Codigo_BIC from '@salesforce/schema/Bank_Account__c.Codigo_BIC__c';
import Nombre_Banco_intermediadio from '@salesforce/schema/Bank_Account__c.Nombre_Banco_intermediadio__c';
import Tipo from '@salesforce/schema/Bank_Account__c.Tipo__c';
import Codigo from '@salesforce/schema/Bank_Account__c.Codigo__c';
import Bank_Account_OBJECT from '@salesforce/schema/Bank_Account__c';
import SR_ls_Country from '@salesforce/schema/Bank_Account__c.SR_ls_Country__c';
import SR_ls_Specific_intermediary_bank from '@salesforce/schema/Bank_Account__c.SR_ls_Specific_intermediary_bank__c';
import SR_tx_Bank_Name from '@salesforce/schema/Bank_Account__c.SR_tx_Bank_Name__c';
import SR_tx_Country from '@salesforce/schema/Bank_Account__c.SR_tx_Country__c';
import TKD_tx_OraclebankId from '@salesforce/schema/Bank_Account__c.TKD_tx_OraclebankId__c';

import SR_ls_Currency from '@salesforce/schema/TKD_Site__c.SR_ls_Currency__c';
import SiteId from '@salesforce/schema/TKD_Site__c.Id';


export default class TkdBankAccountDetail extends LightningElement {
    @api siteId
    @api bankAccountId

    @track Bank_NameData
    @track Bank_NameValue
    @track Bank_NameOptions = []

    @track Bank_Account_CurrencyValue
    @track Bank_Account_CurrencyOptions = []

    @track Tipo_BICValue
    @track Tipo_BICOptions = []

    @track TipoValue
    @track TipoOptions = []

    @track SR_ls_CountryData
    @track SR_ls_CountryValue
    @track SR_ls_CountryOptions = []

    @track specific_intermediary_bankValue
    @track specific_intermediary_bankOptions

    @track JSONWSBankAccount
    @track OraclebankId
    



    bankAccountRecord

    isSelectedEditing
    isReadOnly


     
    connectedCallback() {
        console.log('constructor ' + JSON.stringify(this.bankAccountId))
        //Si existe un registro para edición, el botón tendrá la opción de editar
        //y los campos estarán de solo lectura
        if (this.bankAccountId !== null && this.bankAccountId !== undefined) {
            this.isSelectedEditing = false
            this.isReadOnly = true
        } else { // si no existe el registro, los campos serán editables
            this.isSelectedEditing = true
            this.isReadOnly = false
        }
        this.dispatchEvent(new CustomEvent('disablesave', { detail: this.isReadOnly }));
    }

    /*@wire(getTKD_Bank_Account)
    async getTKD_Bank_AccountJSON(result) {
        let loadProgress = { getTKD_Bank_AccountJSON: true }
        console.log(JSON.stringify(result))
        if (await result.data) {

            let res = JSON.parse(result.data)
            console.log('WS Response ' + JSON.stringify(res))
            this.JSONWSBankAccount = res.xbankInfo
            this.getCountryData()
            this.dispatchEvent(new CustomEvent('loadcomplete', { detail: loadProgress }))
        } else if (await result.error) {
            console.error('Ocurrió un error al consultar el WS')
            this.dispatchEvent(new CustomEvent('loadcomplete', { detail: loadProgress }))
        }
    }*/
    getCountryData() {
        let countryData = this.JSONWSBankAccount.reduce((unique, o) => {
            if (!unique.some(obj => obj.countryName === o.countryName)) {
                unique.push(o);
            }
            return unique;
        }, []);
        countryData = countryData.sort(this.compare);
        this.SR_ls_CountryOptions = countryData.map(index => {
            return {
                label: index.countryName, value: index.countryCode
            }
        })
        console.log('countrys ' + JSON.stringify(this.SR_ls_CountryOptions));
    }
    compare(a, b) {
        if (a.countryName < b.countryName) {
            return -1;
        }
        if (a.countryName > b.countryName) {
            return 1;
        }
        return 0;
    }

    @wire(getObjectInfo, { objectApiName: Bank_Account_OBJECT })
    bankAccountObjectInfo;

    @wire(getPicklistValues, { recordTypeId: '$bankAccountObjectInfo.data.defaultRecordTypeId', fieldApiName: Bank_Account_Currency })
    async getBank_Account_Currency(result) {
        let loadProgress = { getBank_Account_Currency: true }
        if (await result.data) {
            this.Bank_Account_CurrencyOptions = result.data.values.map(index => {
                return {
                    label: index.label, value: index.value
                }
            })
            this.dispatchEvent(new CustomEvent('loadcomplete', { detail: loadProgress }))
        } else if (await result.error) {
            console.error('Ocurrió un error al consultar getBank_Account_Currency ' + JSON.stringify(result.error))
            this.dispatchEvent(new CustomEvent('loadcomplete', { detail: loadProgress }))
        }
    }
    @wire(getPicklistValues, { recordTypeId: '$bankAccountObjectInfo.data.defaultRecordTypeId', fieldApiName: Tipo_BIC })
    async getTipo_BIC(result) {
        let loadProgress = { getTipo_BIC: true }
        if (await result.data) {
            this.Tipo_BICOptions = result.data.values.map(index => {
                return {
                    label: index.label, value: index.value
                }
            })
            this.dispatchEvent(new CustomEvent('loadcomplete', { detail: loadProgress }))
        } else if (await result.error) {
            console.error('Ocurrió un error al consultar getTipo_BIC ' + JSON.stringify(result.error))
            this.dispatchEvent(new CustomEvent('loadcomplete', { detail: loadProgress }))
        }
    }

    @wire(getPicklistValues, { recordTypeId: '$bankAccountObjectInfo.data.defaultRecordTypeId', fieldApiName: Tipo })
    async getTipo(result) {
        let loadProgress = { getTipo: true }
        if (await result.data) {
            this.TipoOptions = result.data.values.map(index => {
                return {
                    label: index.label, value: index.value
                }
            })
            this.dispatchEvent(new CustomEvent('loadcomplete', { detail: loadProgress }))
        } else if (await result.error) {
            console.error('Ocurrió un error al consultar getTipo ' + JSON.stringify(result.error))
            this.dispatchEvent(new CustomEvent('loadcomplete', { detail: loadProgress }))
        }
    }

    @wire(getPicklistValues, { recordTypeId: '$bankAccountObjectInfo.data.defaultRecordTypeId', fieldApiName: SR_ls_Specific_intermediary_bank })
    async getSR_ls_Specific_intermediary_bank(result) {
        let loadProgress = { getSR_ls_Specific_intermediary_bank: true }
        //console.log('getTKD_tx_Country ' + JSON.stringify(result))
        if (await result.data) {
            this.specific_intermediary_bankOptions = result.data.values.map(index => {
                return {
                    label: index.label, value: index.value
                }
            })
            this.dispatchEvent(new CustomEvent('loadcomplete', { detail: loadProgress }))
        } else if (await result.error) {
            console.error('Ocurrió un error al consultar getSR_ls_Specific_intermediary_bank ' + JSON.stringify(result.error))
            this.dispatchEvent(new CustomEvent('loadcomplete', { detail: loadProgress }))
        }
    }


    
    @wire(getRecord, {
        recordId: '$bankAccountId', fields: [Bank_Name, Bank_Account_Currency, Name, Bank_Account_Name,
            RecordTypeId, TKD_rb_Site, Contexto, Tipo_BIC, Codigo_BIC, Nombre_Banco_intermediadio, Tipo,
            Codigo, SR_ls_Country, SR_ls_Specific_intermediary_bank,
            SR_tx_Bank_Name, SR_tx_Country, TKD_tx_OraclebankId]
    })
    async getBankAccountRecord(result) {

        console.log('bankAccountId ' + this.bankAccountId)
        this.bankAccountRecord = await result
        console.log('result ' + JSON.stringify(result))
        console.log('ejecución')
        this.asignData()
    }
    async asignData() {
        let loadProgress = { asignData: true }
        console.log('reasignando ' + JSON.stringify(this.bankAccountRecord))
        try {


            if (await this.bankAccountRecord.data) {
                this.template.querySelector("[data-field='bankAccountNumber']").value = await this.bankAccountRecord.data.fields.Name.value
                if (this.isReadOnly) {                    
                    this.template.querySelector("[data-field='bankAccountCurrencyReadOnly']").value = await this.bankAccountRecord.data.fields.Bank_Account_Currency__c.value
                    this.template.querySelector("[data-field='intermedieryBankTypeReadOnly']").value = await this.bankAccountRecord.data.fields.Tipo__c.value                    
                    this.template.querySelector("[data-field='specificIntermedieryBankReadOnly']").value = await this.bankAccountRecord.data.fields.SR_ls_Specific_intermediary_bank__c.value
                } else {
                    this.template.querySelector("[data-field='bankAccountCurrency']").value = await this.bankAccountRecord.data.fields.Bank_Account_Currency__c.value
                    this.template.querySelector("[data-field='intermedieryBankType']").value = await this.bankAccountRecord.data.fields.Tipo__c.value
                    this.template.querySelector("[data-field='specificIntermedieryBank']").value = await this.bankAccountRecord.data.fields.SR_ls_Specific_intermediary_bank__c.value
                }
                this.template.querySelector("[data-field='swiftAbaIbanTypeReadOnly']").value = await this.bankAccountRecord.data.fields.Tipo_BIC__c.value
                this.template.querySelector("[data-field='swiftAbaIbanValue']").value = await this.bankAccountRecord.data.fields.Codigo_BIC__c.value
                this.template.querySelector("[data-field='intermediaryBankName']").value = await this.bankAccountRecord.data.fields.Nombre_Banco_intermediadio__c.value
                this.template.querySelector("[data-field='intermediaryBankCode']").value = await this.bankAccountRecord.data.fields.Codigo__c.value
                this.OraclebankId = this.bankAccountRecord.data.fields.TKD_tx_OraclebankId__c.value
                await this.asignationBankWS()
                //this.dispatchEvent(new CustomEvent('loadcomplete', { detail: loadProgress }))
                    
            } else if (await this.bankAccountRecord.error) {
                console.error('Ocurrió un error al consultar asignData ' + JSON.stringify(this.bankAccountRecord.error))
                //this.dispatchEvent(new CustomEvent('loadcomplete', { detail: loadProgress }))
            } else if(this.bankAccountId === undefined || this.bankAccountId === null){
                await this.asignationBankWS()
            }
            this.dispatchEvent(new CustomEvent('loadcomplete', { detail: loadProgress }))
            
        } catch (error) {
            console.error('Error try catch asignData ' + JSON.stringify(error))
            this.dispatchEvent(new CustomEvent('loadcomplete', { detail: loadProgress }))

        }
        
    }
    async asignationBankWS(){
        console.info('Inicia asignationBankWS')
        let JSONBankAccount = await getTKD_Bank_Account()
                JSONBankAccount = JSON.parse(JSONBankAccount)
                console.log('getBankA ' + JSON.stringify(JSONBankAccount))
                this.JSONWSBankAccount = JSONBankAccount.xbankInfo
                await this.getCountryData()
                let recordFound = this.JSONWSBankAccount.find(index => index.bankId.toString() === this.OraclebankId)
                console.log('recordFound ' + JSON.stringify(recordFound))
                if(recordFound !== null && recordFound !== undefined){
                    if (this.isReadOnly){
                        this.template.querySelector("[data-field='countryReadOnly']").value = recordFound.countryName
                    } else {
                        this.template.querySelector("[data-field='country']").value = recordFound.countryCode
                    }
                    await this.hanldeCountrySelectionAsignData(recordFound.countryCode)
                    if (this.isReadOnly){
                        this.template.querySelector("[data-field='bankNameReadOnly']").value = recordFound.bankName
                    } else {
                        this.template.querySelector("[data-field='bankName']").value = recordFound.bankName
                    }
                }
    }

    hanldeChangeIntBank() {
        let Bank_Account_Currency = this.template.querySelector("[data-field='bankAccountCurrency']").value
        let country = this.template.querySelector("[data-field='country']").value
        let specificIntermedieryBank = this.template.querySelector("[data-field='specificIntermedieryBank']").value


        if (Bank_Account_Currency === 'USD' && country !== 'US' && specificIntermedieryBank === 'No') {
            this.template.querySelector("[data-field='intermediaryBankName']").value = 'CITIBANK NY'
            this.template.querySelector("[data-field='intermedieryBankType']").value = 'SWIFT'
            this.template.querySelector("[data-field='intermediaryBankCode']").value = 'CITIUS33'
        } else if (Bank_Account_Currency === 'USD' && country === 'US' && specificIntermedieryBank === 'Sí') {
            this.template.querySelector("[data-field='intermediaryBankName']").value = ''
            this.template.querySelector("[data-field='intermedieryBankType']").value = ''
            this.template.querySelector("[data-field='intermediaryBankCode']").value = ''
        }
    }

    @api
    async handleSave() {
        const allValidInputFields = [...this.template.querySelectorAll('lightning-input')]
            .reduce((validSoFar, inputFields) => {
                inputFields.reportValidity();
                return validSoFar && inputFields.checkValidity();
            }, true);
        const allValidComboBoxFields = [...this.template.querySelectorAll('lightning-combobox')]
            .reduce((validSoFar, inputFields) => {
                inputFields.reportValidity();
                return validSoFar && inputFields.checkValidity();
            }, true);
        let swiftAbaIbanType = this.template.querySelector("[data-field='swiftAbaIbanTypeReadOnly']").value
        let swiftAbaIbanValue = this.template.querySelector("[data-field='swiftAbaIbanValue']").value
            console.log('swiftAbaIbanType ' + swiftAbaIbanType)
            console.log('swiftAbaIbanValue ' + swiftAbaIbanValue)
        if (allValidInputFields && allValidComboBoxFields
            && (swiftAbaIbanType !== null && swiftAbaIbanType !== undefined && swiftAbaIbanType !== '')
            && (swiftAbaIbanValue !== null && swiftAbaIbanValue !== undefined && swiftAbaIbanValue !== '')) {
            if (this.bankAccountId === null || this.bankAccountId === undefined) {
                console.log('Está creando un registro')
                await this.createBankAccount()
            } else {
                console.log('Está actualizando un registro')
                await this.updateBankAccount()
            }
        } else if((swiftAbaIbanType === null || swiftAbaIbanType === undefined || swiftAbaIbanType === '')
        || (swiftAbaIbanValue === null || swiftAbaIbanValue === undefined || swiftAbaIbanValue === '')){
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Something is wrong',
                    message: 'The fields "SWIFT/ABA/IBAN TYPE" and "SWIFT/ABA/IBAN Value" can not be empty',
                    variant: 'error'
                })
            );
        }else {
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
    getFields() {
        let recordTypeInfos = this.bankAccountObjectInfo.data.recordTypeInfos
        let recordType
        for (var key in recordTypeInfos) {
            if (recordTypeInfos.hasOwnProperty(key)) {
                if (recordTypeInfos[key].name === 'Supplier Account') {
                    console.log('types ' + recordTypeInfos[key] + " -> " + recordTypeInfos[key].recordTypeId);
                    recordType = recordTypeInfos[key].recordTypeId
                }
            }
        }
        const fields = {};
        if (this.bankAccountId !== null && this.bankAccountId !== undefined)
            fields[bankAccount_Id.fieldApiName] = this.bankAccountId;
        fields[TKD_rb_Site.fieldApiName] = this.siteId;

        fields[Name.fieldApiName] = this.template.querySelector("[data-field='bankAccountNumber']").value
        fields[SR_tx_Bank_Name.fieldApiName] = this.template.querySelector("[data-field='bankName']").value
        fields[Bank_Account_Currency.fieldApiName] = this.template.querySelector("[data-field='bankAccountCurrency']").value
        fields[RecordTypeId.fieldApiName] = recordType;
        fields[Tipo_BIC.fieldApiName] = this.template.querySelector("[data-field='swiftAbaIbanTypeReadOnly']").value
        fields[Codigo_BIC.fieldApiName] = this.template.querySelector("[data-field='swiftAbaIbanValue']").value
        fields[Nombre_Banco_intermediadio.fieldApiName] = this.template.querySelector("[data-field='intermediaryBankName']").value
        fields[Tipo.fieldApiName] = this.template.querySelector("[data-field='intermedieryBankType']").value
        fields[Codigo.fieldApiName] = this.template.querySelector("[data-field='intermediaryBankCode']").value
        fields[SR_ls_Specific_intermediary_bank.fieldApiName] = this.template.querySelector("[data-field='specificIntermedieryBank']").value
        fields[SR_tx_Country.fieldApiName] = this.template.querySelector("[data-field='country']").value
        fields[TKD_tx_OraclebankId.fieldApiName] = this.OraclebankId !== null && this.OraclebankId !== undefined ? this.OraclebankId.toString() : ''
        console.log('fields ' + JSON.stringify(fields))
        return fields;

    }

    async createBankAccount() {
        const fields = await this.getFields();

        const recordInput = { apiName: Bank_Account_OBJECT.objectApiName, fields };
        await createRecord(recordInput)
            .then(bankAccount => {
                console.log('bankAccount ' + JSON.stringify(bankAccount))
                this.bankAccountId = bankAccount.id;
                console.log('this.bankAccountId ' + this.bankAccountId)
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Record has been created',
                        variant: 'success',
                    }),
                );
                this.updateSite()
                refreshApex(this.bankAccountRecord)
                this.dispatchEvent(new CustomEvent('handlegetsaveresultnewbankaccount', { detail: this.bankAccountId }));
                this.invertButtons()
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error creating record',
                        message: error.body.message,
                        variant: 'error',
                    }),
                );
            });
    }
    async updateBankAccount() {
        const fields = await this.getFields();
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
                this.updateSite()
                refreshApex(this.bankAccountRecord)
                this.invertButtons()
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error creating record',
                        message: error.body.message,
                        variant: 'error'
                    })
                );
            });
    }
    async updateSite() {
        const fields = {};
        fields[SiteId.fieldApiName] = this.siteId;
        fields[SR_ls_Currency.fieldApiName] = this.template.querySelector("[data-field='bankAccountCurrency']").value
        const recordInput = { fields };
        await updateRecord(recordInput)
            .then(() => {
                console.log('Actualización exitosa')
            })
            .catch(error => {
                console.error('Actualización fallida ' + JSON.stringify(error))
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error creating record',
                        message: error.body.message,
                        variant: 'error'
                    })
                );
            });
    }


    @api
    handleEditClick() {
        if (this.isSelectedEditing === true && this.validateChanges()) {
            this.handleSave()
        } else if (this.bankAccountId !== null && this.bankAccountId !== undefined) {
            this.invertButtons()
        }
        this.dispatchEvent(new CustomEvent('disablesave', { detail: this.isReadOnly }));
    }

    validateChanges() {
        let someFieldHasChanged = false
        if (this.bankAccountRecord.data)
            if (this.template.querySelector("[data-field='bankAccountNumber']").value !== this.bankAccountRecord.data.fields.Name.value
                || this.template.querySelector("[data-field='bankName']").value !== this.bankAccountRecord.data.fields.Bank_Name__c.value
                || this.template.querySelector("[data-field='bankAccountCurrency']").value !== this.bankAccountRecord.data.fields.Bank_Account_Currency__c.value
                || this.template.querySelector("[data-field='swiftAbaIbanTypeReadOnly']").value !== this.bankAccountRecord.data.fields.Tipo_BIC__c.value
                || this.template.querySelector("[data-field='swiftAbaIbanValue']").value !== this.bankAccountRecord.data.fields.Codigo_BIC__c.value
                || this.template.querySelector("[data-field='intermediaryBankName']").value !== this.bankAccountRecord.data.fields.Nombre_Banco_intermediadio__c.value
                || this.template.querySelector("[data-field='intermedieryBankType']").value !== this.bankAccountRecord.data.fields.Tipo__c.value
                || this.template.querySelector("[data-field='intermediaryBankCode']").value !== this.bankAccountRecord.data.fields.Codigo__c.value
                || this.template.querySelector("[data-field='country']").value !== this.bankAccountRecord.data.fields.SR_ls_Country__c.value) {
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
    async hanldeCountrySelectionAsignData(data) {
        let bankAccounts = this.JSONWSBankAccount.filter(index => index.countryCode === data)
        console.log('bankAccounts ' + JSON.stringify(bankAccounts))
        bankAccounts = bankAccounts.sort(this.compareBankAccount);
        console.log('bankAccountsSort ' + JSON.stringify(bankAccounts))
        this.Bank_NameOptions = await bankAccounts.map(index => {
            return {
                label: index.bankName, value: index.bankName
            }
        })
    }
    hanldeCountrySelection(event) {
        console.log('event.target.value ' + event.target.value)

        let bankAccounts = this.JSONWSBankAccount.filter(index => index.countryCode === event.target.value)
        console.log('bankAccounts ' + JSON.stringify(bankAccounts))
        bankAccounts = bankAccounts.sort(this.compareBankAccount);
        console.log('bankAccountsSort ' + JSON.stringify(bankAccounts))
        this.Bank_NameOptions = bankAccounts.map(index => {
            return {
                label: index.bankName, value: index.bankName
            }
        })
        this.hanldeChangeIntBank()
        console.log('Bank_NameOptions ' + JSON.stringify(this.Bank_NameOptions));
    }
    compareBankAccount(a, b) {
        if (a.bankName < b.bankName) {
            return -1;
        }
        if (a.bankName > b.bankName) {
            return 1;
        }
        return 0;
    }
    hanldeChangeBankName(event) {
        console.log('event.target.value ' + event.target.value)
        let countryCode = this.template.querySelector("[data-field='country']").value
        let locatedData = this.JSONWSBankAccount.find(element => element.countryCode === countryCode && element.bankName === event.target.value)
        console.log('locatedData ' + JSON.stringify(locatedData))
        this.template.querySelector("[data-field='swiftAbaIbanTypeReadOnly']").value = locatedData.tipoBic
        this.template.querySelector("[data-field='swiftAbaIbanValue']").value = locatedData.codigoBic
        this.OraclebankId = locatedData.bankId
        if (locatedData.tipoBic === null || locatedData.tipoBic === undefined
            || locatedData.codigoBic === null || locatedData.codigoBic === undefined) {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Validation data',
                    message: 'The selected bank has SWIFT/ABA/IBAN TYPE or SWIFT/ABA/IBAN Value is empty, please request the correct data.',
                    variant: 'warning',
                    mode: 'sticky'
                }),
            );
        }

    }
    @api
    refreshData() {
        return refreshApex(this.bankAccountRecord)
    }

}