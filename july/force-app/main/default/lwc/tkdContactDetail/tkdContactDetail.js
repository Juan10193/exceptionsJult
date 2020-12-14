/**
 * @description       : 
 * @author            : eduardo.amiens@outlook.com
 * @group             : 
 * @last modified on  : 09-14-2020
 * @last modified by  : eduardo.amiens@outlook.com
 * Modifications Log 
 * Ver   Date         Author                       Modification
 * 1.0   08-13-2020   eduardo.amiens@outlook.com   Initial Version
**/
import { LightningElement, api, wire } from 'lwc';
import { getRecord, createRecord, updateRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import contact_Id from '@salesforce/schema/Contact.Id';
import FirstName from '@salesforce/schema/Contact.FirstName';
import LastName from '@salesforce/schema/Contact.LastName';
import Phone from '@salesforce/schema/Contact.Phone';
import Email from '@salesforce/schema/Contact.Email';
import Department from '@salesforce/schema/Contact.Department';
import CON_un_Phone_number_extension from '@salesforce/schema/Contact.CON_un_Phone_number_extension__c';
import SR_tf_Phone_area_code from '@salesforce/schema/Contact.SR_tf_Phone_area_code__c';


import RecordTypeId from '@salesforce/schema/Contact.RecordTypeId';
import TKD_rb_Site from '@salesforce/schema/Contact.TKD_rb_Site__c';
import Contact_OBJECT from '@salesforce/schema/Contact';

export default class TkdContactDetail extends LightningElement {
    @api siteId
    @api contactId

    contactRecord

    isSelectedEditing
    isReadOnly

    connectedCallback() {
        console.log('constructor ' + JSON.stringify(this.contactId))
        //Si existe un registro para edición, el botón tendrá la opción de editar
        //y los campos estarán de solo lectura
        if (this.contactId !== null && this.contactId !== undefined) {
            this.isSelectedEditing = false
            this.isReadOnly = true
        } else { // si no existe el registro, los campos serán editables
            this.isSelectedEditing = true
            this.isReadOnly = false
        }
        this.dispatchEvent(new CustomEvent('disablesave', { detail: this.isReadOnly }));
    }


    @wire(getRecord, {
        recordId: '$contactId', fields: [FirstName, LastName, Phone, Email,
            TKD_rb_Site, Department, CON_un_Phone_number_extension, SR_tf_Phone_area_code]
    })
    getContactRecord(result) {
        console.log('getContactRecord ' + JSON.stringify(result))
        this.contactRecord = result
        if (result.data) {
            this.template.querySelector("[data-field='firstName']").value = result.data.fields.FirstName.value
            this.template.querySelector("[data-field='lastName']").value = result.data.fields.LastName.value
            this.template.querySelector("[data-field='phoneNumber']").value = result.data.fields.Phone.value
            this.template.querySelector("[data-field='emailAddress']").value = result.data.fields.Email.value

            this.template.querySelector("[data-field='department']").value = result.data.fields.Department.value
            this.template.querySelector("[data-field='phoneAreaCode']").value = result.data.fields.SR_tf_Phone_area_code__c.value
            /*this.template.querySelector("[data-field='phoneExtensión']").value = result.data.fields.CON_un_Phone_number_extension__c.value*/
        }
    }
    @wire(getObjectInfo, { objectApiName: Contact_OBJECT })
    ContactObjectInfo;

    @api
    handleSave() {
        const allValidInputFields = [...this.template.querySelectorAll('lightning-input')]
            .reduce((validSoFar, inputFields) => {
                inputFields.reportValidity();
                return validSoFar && inputFields.checkValidity();
            }, true);

        if (allValidInputFields) {
            if (this.contactId === null || this.contactId === undefined) {
                console.log('Está creando un registro')
                this.createContact()
            } else {
                console.log('Está actualizando un registro')
                this.updateContact()
            }
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

    /*validatePhone(event) {
        let phoneField = this.template.querySelector("[data-field='phoneNumber']")
        let phoneFieldValue = phoneField.value
        // is input valid text?
        if (isNaN(phoneFieldValue)) {
            phoneField.setCustomValidity("Only input numbers, not text or special characters");
        } else if(phoneFieldValue.length > 10){
            phoneField.setCustomValidity("you can only add up to 10 digits");
        }else {
            phoneField.setCustomValidity(""); // if there was a custom error before, reset it
        }
        phoneField.reportValidity(); // Tells lightning-input to show the error right away without needing interaction

    }*/
    /*validateExtension() {
        let phoneExtensionField = this.template.querySelector("[data-field='phoneExtensión']")
        let phoneExtensionFieldValue = phoneExtensionField.value
        // is input valid text?
        if (isNaN(phoneExtensionFieldValue)) {
            phoneExtensionField.setCustomValidity("Only input numbers, not text or special characters");
        } else {
            phoneExtensionField.setCustomValidity(""); // if there was a custom error before, reset it
        }
        phoneExtensionField.reportValidity(); // Tells lightning-input to show the error right away without needing interaction
    }
    validateAreaCode() {
        let phoneAreaCodeField = this.template.querySelector("[data-field='phoneAreaCode']")
        let phoneAreaCodeFieldValue = phoneAreaCodeField.value
        // is input valid text?
        if (isNaN(phoneAreaCodeFieldValue)) {
            phoneAreaCodeField.setCustomValidity("Only input numbers, not text or special characters");
        } else {
            phoneAreaCodeField.setCustomValidity(""); // if there was a custom error before, reset it
        }
        phoneAreaCodeField.reportValidity(); // Tells lightning-input to show the error right away without needing interaction
    }*/

    getFields() {
        let recordTypeInfos = this.ContactObjectInfo.data.recordTypeInfos
        let recordType
        for (var key in recordTypeInfos) {
            if (recordTypeInfos.hasOwnProperty(key)) {
                if (recordTypeInfos[key].name === 'Supplier Contact') {
                    console.log('types ' + recordTypeInfos[key] + " -> " + recordTypeInfos[key].recordTypeId);
                    recordType = recordTypeInfos[key].recordTypeId
                }
            }
        }
        const fields = {};
        if (this.contactId !== null && this.contactId !== undefined)
            fields[contact_Id.fieldApiName] = this.contactId
        fields[TKD_rb_Site.fieldApiName] = this.siteId;
        fields[RecordTypeId.fieldApiName] = recordType;
        fields[FirstName.fieldApiName] = this.template.querySelector("[data-field='firstName']").value
        fields[LastName.fieldApiName] = this.template.querySelector("[data-field='lastName']").value
        fields[Phone.fieldApiName] = this.template.querySelector("[data-field='phoneNumber']").value
        fields[Email.fieldApiName] = this.template.querySelector("[data-field='emailAddress']").value

        fields[Department.fieldApiName] = this.template.querySelector("[data-field='department']").value
        //fields[CON_un_Phone_number_extension.fieldApiName] = this.template.querySelector("[data-field='phoneExtensión']").value
        fields[SR_tf_Phone_area_code.fieldApiName] = this.template.querySelector("[data-field='phoneAreaCode']").value
        return fields;

    }

    createContact() {
        const fields = this.getFields();
        console.log('fields ' + JSON.stringify(fields))
        const recordInput = { apiName: Contact_OBJECT.objectApiName, fields };
        createRecord(recordInput)
            .then(contact => {
                console.log('contact ' + JSON.stringify(contact))
                this.contactId = contact.id;
                console.log('this.contactId ' + this.contactId)
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Record has been created',
                        variant: 'success',
                    }),
                );
                this.dispatchEvent(new CustomEvent('handlegetsaveresultnewcontact', { detail: this.contactId }));
                this.invertButtons()
            })
            .catch(error => {
                console.error('error ' + JSON.stringify(error))
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error creating record',
                        message: error.body.message,
                        variant: 'error',
                    }),
                );
            });
    }

    updateContact() {
        const fields = this.getFields();
        const recordInput = { fields };
        updateRecord(recordInput)
            .then(() => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Record updated',
                        variant: 'success'
                    })
                );
                this.invertButtons()
            })
            .catch(error => {
                console.error('error ' + JSON.stringify(error))
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error updated record',
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
        } else if (this.contactId !== null && this.contactId !== undefined) {
            this.invertButtons()
        }



        this.dispatchEvent(new CustomEvent('disablesave', { detail: this.isReadOnly }));
    }
    validateChanges() {
        let someFieldHasChanged = false
        if (this.contactRecord.data)
            if (this.template.querySelector("[data-field='firstName']").value !== this.contactRecord.data.fields.FirstName.value
                || this.template.querySelector("[data-field='lastName']").value !== this.contactRecord.data.fields.LastName.value
                || this.template.querySelector("[data-field='phoneNumber']").value !== this.contactRecord.data.fields.Phone.value
                || this.template.querySelector("[data-field='emailAddress']").value !== this.contactRecord.data.fields.Email.value
                || this.template.querySelector("[data-field='department']").value !== this.contactRecord.data.fields.Department.value
                || this.template.querySelector("[data-field='phoneAreaCode']").value !== this.contactRecord.data.fields.SR_tf_Phone_area_code__c.value
                /*|| this.template.querySelector("[data-field='phoneExtensión']").value !== this.contactRecord.data.fields.CON_un_Phone_number_extension__c.value*/) {
                someFieldHasChanged = true
            }
        console.log('someFieldHasChanged ' + someFieldHasChanged)
        return someFieldHasChanged
    }
    invertButtons() {
        this.isReadOnly = this.isSelectedEditing
        this.isSelectedEditing = !this.isSelectedEditing

        this.dispatchEvent(new CustomEvent('disablesave', { detail: this.isReadOnly }));
    }
}