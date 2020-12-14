import { LightningElement, api, track, wire } from 'lwc';
import getUnresolvedItems from "@salesforce/apex/Aml_Review_cls.getUnresolvedItems";
import { refreshApex } from "@salesforce/apex";
import { ShowToastEvent } from "lightning/platformShowToastEvent"; // import toast message event .
export default class AmlReviewUnrlItemModal extends LightningElement {
    @api unresolveditemsids;
    @track unreList;
    @track unresolvedOn =false;
    @track error;
    wiredUnresolved;
    @track approve=false;

    @wire(getUnresolvedItems,{Ids:'$unresolveditemsids'})
    wiredUnresolvedItems(result){
        this.wiredUnresolved = result;
        if(result.data){
            console.log('unresolveditemlist')
            console.log(this.wiredUnresolved);
            this.unreList = result.data;
            this.unresolvedOn =true;
            this.error = undefined;
        }else if(result.error) {
            this.error = result.error;
            this.wiredUnresolved = undefined;
        }
    }

   
    onRecordSubmit(event){
        event.preventDefault();
        console.log('evento submit');
        console.log(event.detail.fields.RecordID__c);
        
        
        const fields = event.detail.fields;
        console.log(fields.ES2_Unresolved_Items__c);
        
        if(fields.ES2_Resolve_Comment__c==='' || fields.ES2_Resolve_Comment__c===null){
            alert('A comment is required');
        }else{
            this.template.querySelector("[data-id="+fields.RecordID__c +"]").submit(fields);
        }
        
    }

    handleSuccess(event) {
        let showWarning = new ShowToastEvent({
          title: "Success!!",
          message: "Updated",
          variant: "success"
        });
        this.dispatchEvent(showWarning);
        return refreshApex(this.wiredUnresolved);
    }

    closeModal() {
        this.dispatchEvent(new CustomEvent('closeur', {detail:{modal:false}}));
    } 
}