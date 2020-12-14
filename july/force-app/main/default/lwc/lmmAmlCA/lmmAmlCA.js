import { LightningElement,track, api, wire } from 'lwc';

const FIELDSOP = ['Opportunity.StageName', 'Opportunity.LMM_Status_Risk__c', 'Opportunity.LMM_Status_AML__c',];
import { getRecord, getFieldValue, updateRecord  } from 'lightning/uiRecordApi';
import USER_ID from '@salesforce/user/Id';
import getUser from "@salesforce/apex/Data_Access_User_cls.getUser";
import ID_FIELD from "@salesforce/schema/Opportunity.Id";
import STATUS_AML from "@salesforce/schema/Opportunity.LMM_Status_AML__c";
import APPROBEDBYAML from "@salesforce/schema/Opportunity.AML_Approved_By__c";
import AML_COMMENTS from '@salesforce/schema/Opportunity.AML_Approval_Coments__c';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class LmmAmlCA extends LightningElement {
    @api recordId
    @track opportunity
    @track userProfile;
    @track userName;
    @track statusRisk;
    @track statusAml;
    @track sipinner = false;
    @track actionAML;

    @track amlComments;
    @track amlIcon = {
        iconName:null,
        iconTitle:null
    }

    @track riskIcon ={
        iconName:null,
        iconTitle:null
    }

    @track viewComments = false;

    async connectedCallback(){
        try{
            let prof = await getUser({recordId:USER_ID})
            console.log('user profile')
            this.userProfile = prof.Profile.Name;
            console.log(this.userProfile)
            this.userName = prof.Name;
            console.log(this.userName);
         }catch(error){
             console.log('error al cargar usuario ca buttons');
             console.log(error)
        }
    }

    @wire(getRecord, {recordId:'$recordId', fields:FIELDSOP})
    async wiredOpp({error,data}){
        if(error){
            let message = "Unknown error";
            if (Array.isArray(error.body)) {
              message = error.body.map(e => e.message).join(", ");
            } else if (typeof error.body.message === "string") {
              message = error.body.message;
            }
            console.log('ERROR AL CARGAR OP BUTTON AML')
            console.log(error)
        }else if (data) {
            this.opportunity = data;
            console.log('OPP FIELDS CA')
            console.log(this.opportunity);
            this.statusRisk = this.opportunity.fields.LMM_Status_Risk__c.value;
            this.statusAml = this.opportunity.fields.LMM_Status_AML__c.value;
            if(this.statusAml ==='Approved'){
                this.amlIcon.iconName = "standard:task2";
                this.amlIcon.iconTitle='Approved';
                
            }
            if(this.statusAml ==='Rejected'){
                this.amlIcon.iconName = "standard:first_non_empty";
                this.amlIcon.iconTitle='Rejected';
            }
            if(this.statusAml ==='Pending'){
                this.amlIcon.iconName = "standard:waits";
                this.amlIcon.iconTitle='Pending';
            }

            if(this.statusRisk ==='Approved'){
                this.riskIcon.iconName = "standard:task2";
                this.riskIcon.iconTitle='Approved';
                
            }
            if(this.statusRisk ==='Rejected'){
                this.riskIcon.iconName = "standard:first_non_empty";
                this.riskIcon.iconTitle='Rejected';
            }
            if(this.statusRisk ==='Pending'){
                this.riskIcon.iconName = "standard:waits";
                this.riskIcon.iconTitle='Pending';
            }
        }
    }



    async handleSendToAML(){
        this.sipinner = true;
        const fields ={};
        fields[ID_FIELD.fieldApiName] = this.recordId;
        fields[STATUS_AML.fieldApiName] = "Pending";
        const recordInput = { fields };
        try{
            await updateRecord(recordInput)
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Send to AML',
                    variant: 'success'
                })
            );
        }catch(error){
            console.log('error al enviar cadena a aml')
            console.log(error)
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error creating record',
                    message: error.body.message,
                    variant: 'error'
                })
            );
        }finally{
            this.sipinner = false;
        }
        
    }

    async handleApproveAML(){
        this.isModalOpen = true;
        this.actionAML ='Approved';
    }

    async handleRejectAML(){
        this.isModalOpen = true;
        this.actionAML = "Rejected";
    }

    handleAMLComments(event){
        this.amlComments = event.detail.value;
        console.log('COMMENTS AML')
        console.log(this.amlComments);
    }

    handleViewComments (){
        this.viewComments = true;
    }

    handleCloseComments (){
        this.viewComments = false;
    }

     //Boolean tracked variable to indicate if modal is open or not default value is false as modal is closed when page is loaded 
     @track isModalOpen = false;
     openModal() {
         // to open modal set isModalOpen tarck value as true
         this.isModalOpen = true;
     }
     closeModal() {
         // to close modal set isModalOpen tarck value as false
         this.isModalOpen = false;
     }
     async submitDetails() {
         // to close modal set isModalOpen tarck value as false
         //Add your code to call apex method or do some processing
         this.isModalOpen = false;
         this.sipinner = true;
        const fields ={};
        fields[ID_FIELD.fieldApiName] = this.recordId;
        fields[STATUS_AML.fieldApiName] = this.actionAML;
        fields[APPROBEDBYAML.fieldApiName] =this.userName;
        fields[AML_COMMENTS.fieldApiName] = this.amlComments;
        const recordInput = { fields };
        try{
            await updateRecord(recordInput)
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: `${this.actionAML} AML`,
                    variant: 'success'
                })
            );
        }catch(error){
            console.log(`ERROR TO ${this.actionAML} AML`)
            console.log(error)
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error creating record',
                    message: error.body.message,
                    variant: 'error'
                })
            );
        }finally{
            this.sipinner = false;
        }
     }



    get visibilityAML(){
        if((this.userProfile ==='AML' || this.userProfile==='System Administrator' || this.userProfile==='Administrador del sistema')
        &&(this.statusAml==="Pending")){
            return true;
        }else{
            return false;
        }
    }

    get visibilityRisk(){
        if( (this.userProfile ==='Risk' || this.userProfile==='System Administrator' || 
            this.userProfile==='Administrador del sistema') &&(this.statusAml ===null && this.statusRisk !==null)){

            return true;
        }else{
            return false;
        }
    }
}