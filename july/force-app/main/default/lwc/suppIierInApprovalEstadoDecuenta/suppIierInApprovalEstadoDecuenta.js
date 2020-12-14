import { LightningElement, track, api, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import updateDate from '@salesforce/apex/SupplierInApprovalUnlock.unlockforAccountStatement';
import loock from '@salesforce/apex/SupplierInApprovalUnlock.lockforAccountStatement';
import unlock from '@salesforce/apex/SupplierInApprovalUnlock.unlockGeneral';
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import { updateRecord } from 'lightning/uiRecordApi';

const FIELDS = ["Supplier_in_approval__c.Account_statement_date__c"];
export default class SuppIierInApprovalEstadoDecuenta extends LightningElement {
    @api recordId;
    @track supplierInApproval;
    @track fecha;
    spiner = false;

    @wire(getRecord, { recordId: "$recordId", fields: FIELDS })
    wiredRecord({ error, data }) {
        if (error) {
            let message = "Unknown error";
            if (Array.isArray(error.body)) {
                message = error.body.map(e => e.message).join(", ");
            } else if (typeof error.body.message === "string") {
                message = error.body.message;
            }
            this.dispatchEvent(
                new ShowToastEvent({
                    title: "Error loading Takdown for checklist",
                    message,
                    variant: "error"
                })
            );
        } else if (data) {
            this.supplierInApproval = data;
            this.fecha = this.supplierInApproval.fields.Account_statement_date__c.value;
            console.log('supplierIn Approval');
            console.log(this.supplierInApproval);
        }
    }

    handlechange(event) {
        this.fecha = event.target.value;
        console.log(this.fecha);
    }

    async handleClick() {
        console.log('fecha');
        console.log(this.fecha);
        console.log(this.recordId);
        try {
            this.spiner = true;
            await updateDate({ suppInAppId: this.recordId, fecha: this.fecha });
            await unlock({suppInAppId: this.recordId});
            await updateRecord({fields: { Id: this.recordId }})
            await loock({ suppInAppId: this.recordId });
            this.dispatchEvent(
                new ShowToastEvent({
                    title: "success",
                    message: "Date Updated",
                    variant: "success"
                })
            );
           

        } catch (error) {
            console.log('error al actualizar fecha');
            console.log(error);
            this.dispatchEvent(
                new ShowToastEvent({
                    title: "error",
                    message: error.message,
                    variant: "error"
                })
            );
            await loock({ suppInAppId: this.recordId });
        } finally {
            this.spiner = false;
        }
    }
}