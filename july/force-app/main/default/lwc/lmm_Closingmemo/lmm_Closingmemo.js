/**
 * @File Name          : lmm_Closingmemo.js
 * @Description        : 
 * @Author             : angel87ambher@gmail.com
 * @Group              : 
 * @Last Modified By   : angel87ambher@gmail.com
 * @Last Modified On   : 10/5/2020 23:50:52
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    30/4/2020   angel87ambher@gmail.com     Initial Version
**/
import { LightningElement,track,api,wire } from 'lwc';
import { getRecord} from 'lightning/uiRecordApi';
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import {FILEOPP} from './fieldsOpHelper';
import {FILECOT} from './fieldsCotizacion';
import entitiescpOp from '@salesforce/apex/Data_Access_EntityMastInCApproval_cls.entitiesInCaOp';
import getQuote from '@salesforce/apex/Data_Acess_EC_Quote.getQuotesByOpId';
import momentJs from '@salesforce/resourceUrl/momentJs';
import Animate from  '@salesforce/resourceUrl/Animate';
import { loadScript, loadStyle } from 'lightning/platformResourceLoader';
import getQuotesByOpId from '@salesforce/apex/Data_Acess_EC_Quote.getQuotesByOpId'
import {FILEDSOP} from './fieldsOpHelper';
import USER_ID from '@salesforce/user/Id';
import getUser from "@salesforce/apex/Data_Access_User_cls.getUser"


export default class Lmm_Closingmemo extends LightningElement {

    @api objectApiName;
    @api recordId;
    @track data;
    @track opportunity;
    @track opportunityId;
    @track entitysEstructure;
    @track quote =[];
    @track dataResult = {};
    @track lstAmortizacion = [];
    @track lstcuenta=[];
    @track infoGeneral = {};
    @track datosQuote={};
    @track cotizaciones = [];
    @track infoGeneral = {};
    @track opportunity;
    @track appResult;
    @track userProfile;
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
            console.log('ERROR AL CARGAR OP PARAMETRICO')
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
        ]).then(() => { 'scripts cargados Parametrico' });
        
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
        console.log('se ha guardado con exito')
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
        console.log('Un error ha ocurrido al intentar actualizar')
        console.log(event);
        console.log(event.message);
        console.log(event.detail);

        this.sipinner=false;
        this.editMode = false;
    }


    get oppName(){
        return this.opportunity.fields.Name.value;
    }

    get visibiliy(){
        if(this.userProfile ==="Administrador del sistema" || this.userProfile==="System Administrator" || this.userProfile==="Risk"){
            return false;
        }else{
            return true;
        }
    }

}