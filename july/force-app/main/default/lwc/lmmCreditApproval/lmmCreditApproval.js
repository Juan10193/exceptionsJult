/**
 * @File Name          : lmmCreditApproval.js
 * @Description        : 
 * @Author             : angel87ambher@gmail.com
 * @Group              : 
 * @Last Modified By   : angel87ambher@gmail.com
 * @Last Modified On   : 4/6/2020 13:25:08
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    4/6/2020   angel87ambher@gmail.com     Initial Version
**/
import { LightningElement,track,api,wire } from 'lwc';
import { getRecord} from 'lightning/uiRecordApi';
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import {FILEOPP} from './fieldsOpHelper';
import momentJs from '@salesforce/resourceUrl/momentJs';
import Animate from  '@salesforce/resourceUrl/Animate';
import { loadScript, loadStyle } from 'lightning/platformResourceLoader';

export default class LmmCreditApproval extends LightningElement {

    @api recordId;
    @track data;
    @track opportunity;
    @track opportunityId;
    @track opportunity;
    @track sipinner=false;
    @track editMode =false;
    @track activeSections = [
        "Información General",
        "Descripción del Deal",
        "RAC LMM"
    ];


    @wire(getRecord, {recordId:'$recordId', fields:FILEOPP})
    wiredOpp({error,data}){
        if(error){
            let message = "Unknown error";
            if (Array.isArray(error.body)) {
              message = error.body.map(e => e.message).join(", ");
            } else if (typeof error.body.message === "string") {
              message = error.body.message;
            }
            this.dispatchEvent(
              new ShowToastEvent({
                title: "Error loading OPP Fields",
                message,
                variant: "error"
              })
            );
            console.log(error)
        }else if (data) {
            this.opportunity = data;
            console.log('OPP parametrico')
            console.log(this.opportunity);
        }
    }


    renderedCallback(){
        Promise.all([
            loadScript(this, momentJs),
            loadStyle(this, Animate)
        ]).then(() => { 'Informacion cargada' });
        
    }

    changeToEdit(event){  
        this.editMode = true;
        this.activeSections = [
            "Información General",
            "Descripción del Deal",
            "RAC LMM"
        ];
    }

    clearEditMode(){
        this.editMode = false;
        this.activeSections = [
            "Información General",
            "Descripción del Deal",
            "RAC LMM"
        ];
    }

    handleSubmit(event){
        this.sipinner =true;
        event.preventDefault();       // stop the form from submitting
        const fields = event.detail.fields;
        this.template.querySelector('lightning-record-edit-form').submit(fields);
    }

    handleSuccess(event) {
        console.log(event.detail)
        this.sipinner=false;
        this.editMode = false;
        this.activeSections = [
            "Información General",
            "Descripción del Deal",
            "RAC LMM"
        ];
    }

    handleError(event){
        console.log(event);
        console.log(event.message);
        console.log(event.detail);

        this.sipinner=false;
        this.editMode = false;
    }


    get oppName(){
        return this.opportunity.fields.Name.value;
    }

}