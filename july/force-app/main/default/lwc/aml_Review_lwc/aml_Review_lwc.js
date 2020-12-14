import { LightningElement, api, wire, track } from "lwc";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import { getRecord } from "lightning/uiRecordApi";
import getUseruarios from "@salesforce/apex/Aml_Review_cls.getUseruarios";

const FIELDS = [
  "Credit_approval_CP__c.Name",
  "Credit_approval_CP__c.CreatedById",
  "Credit_approval_CP__c.Inside_Sales__c",
  "Credit_approval_CP__c.Sr_Underwriter__c",
  "Credit_approval_CP__c.Approval_Level__c",
  "Credit_approval_CP__c.CPI_tx_Risk_Economic_Group__c",
  "Credit_approval_CP__c.CPL_ls_StageName__c"
];

export default class LightningExampleAccordionConditional extends LightningElement {
  @api recordId;
  @track cA;
  @track caName;
  @track originator;
  @track isc;
  @track srUW;
  @track approvalLevel;
  @track economicGRoup;
  @track stage;

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
          title: "Error loading contact",
          message,
          variant: "error"
        })
      );
    } else if (data) {
      this.cA = data;
      this.caName = this.cA.fields.Name.value;
      this.originator = this.cA.fields.CreatedById.value;
      this.isc = this.cA.fields.Inside_Sales__c.value;
      this.srUW = this.cA.fields.Sr_Underwriter__c.value;
      this.approvalLevel = this.cA.fields.Approval_Level__c.value;
      this.economicGRoup = this.cA.fields.CPI_tx_Risk_Economic_Group__c.value;
      this.stage = this.cA.fields.CPL_ls_StageName__c.value;
      console.log(this.cA.fields.CPL_ls_StageName__c.value);

      getUseruarios({
        usIds: [this.isc, this.srUW, this.originator],
        recordId: this.recordId
      })
        .then(result => {
          console.log(result);
          this.originator =result[0].CreatedBy.Name;
          this.isc =result[0].Inside_Sales__r.Name;
          this.srUW = result[0].Sr_Underwriter__r.Name;
        })
        .catch(errores => {
          let message = "Unknown error";
          if (Array.isArray(errores.body)) {
            message = errores.body.map(e => e.message).join(", ");
          } else if (typeof errores.body.message === "string") {
            message = errores.body.message;
          }
          this.dispatchEvent(
            new ShowToastEvent({
              title: "Error loading contact",
              message,
              variant: "error"
            })
          );
        });
    }
  }

  get recordCA (){
     let caUrl = '/' + this.recordId;
    return caUrl;
  }

}