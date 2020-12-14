import { LightningElement,track, api, wire } from 'lwc';
import momentJs from '@salesforce/resourceUrl/momentJs';
import Animate from  '@salesforce/resourceUrl/Animate';
import { loadScript, loadStyle } from 'lightning/platformResourceLoader';
import getQuotesByOpId from '@salesforce/apex/Data_Acess_EC_Quote.getQuotesByOpId'
import {FILEDSOP} from './fieldsOpHelper';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import USER_ID from '@salesforce/user/Id';
import getUser from "@salesforce/apex/Data_Access_User_cls.getUser"

export default class LmmParametrico extends LightningElement {

    @api recordId;
    @track cotizaciones = [];
    @track infoGeneral = {};
    @track opportunity;
    @track appResult;
    @track userProfile;
    @track visiEdit = false;

    @track sipinner=false;

    @track editMode =false;

    @track activeSections = [
        "Información General",
        "Carácter",
        "Continuidad de Negocio",
        "Desempeño Financiero",
        "Estructura"
    ];


    @wire(getRecord, {recordId:'$recordId', fields:FILEDSOP})
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

    async connectedCallback(){
        await this.getCotizaciones();
        this.visibiliy();
    }

    /* renderedCallback(){
        Promise.all([
            loadScript(this, momentJs),
            loadStyle(this, Animate)
        ]).then(() => { 'scripts cargados Parametrico' });
        
    } */

    async getCotizaciones(){
        try{
            let prof = await getUser({recordId:USER_ID})
            console.log('user profile')
            this.userProfile = prof.Profile.Name;
            console.log(this.userProfile)
         }catch(error){
             console.log('error al cargar usuario');
             console.log(error)
        }
        try{
            this.cotizaciones = await getQuotesByOpId({recordId:this.recordId});
            console.log('Cotizaciones ligadas');
            console.log(this.cotizaciones);
            console.log(this.cotizaciones.length);
            this.infoGeneral.cotizaciones = this.cotizaciones.length;
        }catch(error){
            console.log('error al traer las cotizaciones ligadas a la oportunidad');
            console.log(error);
        }
        
    }

    changeToEdit(event){  
        this.editMode = true;
        console.log('MODO EDICION')
        console.log(this.editMode);
       
    }

    clearEditMode(){
        this.editMode = false;
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
            "Carácter",
            "Continuidad de Negocio",
            "Desempeño Financiero",
            "Estructura"
        ];
    }

    handleError(event){
        console.log('Un error ha ocurrido al intentar actualizar')
        console.log(event.detail);
        this.sipinner=false;
        
    }


    get oppName(){
        return this.opportunity.fields.Name.value;
    }

    get accountName(){
        return this.opportunity.fields.AccountId.value;
    }


    get puntosCaracter(){
        let buroCreditoRepresent= this.opportunity.fields.LMM_ls_BurodeCrditoRepresentativo__c.value === null?0:parseInt(this.opportunity.fields.LMM_ls_BurodeCrditoRepresentativo__c.value);
        let buroLgeal = this.opportunity.fields.LMM_ls_Bur_Legal__c.value === null?0:parseInt(this.opportunity.fields.LMM_ls_Bur_Legal__c.value);
        let buroAval = this.opportunity.fields.LMM_ls_BurdeCrditoAval__c.value ===null?0:parseInt(this.opportunity.fields.LMM_ls_BurdeCrditoAval__c.value);
        let expClientes = this.opportunity.fields.LMM_ls_ExpConClientesPrinc__c.value === null?0:parseInt(this.opportunity.fields.LMM_ls_ExpConClientesPrinc__c.value);
        let puntos = buroCreditoRepresent + buroLgeal + buroAval + expClientes;
        this.puntosCaracterIcon.icono = Math.sign(puntos) ===1?'utility:chevronup':Math.sign(puntos) ===-1?'utility:chevrondown':undefined;
        this.puntosCaracterIcon.variant=  this.puntosCaracterIcon.icono ==='utility:chevronup'?'Success':this.puntosCaracterIcon.icono ==='utility:chevrondown'?'error':undefined

        return puntos;    
    }

    @track puntosCaracterIcon ={}


    get puntosContinuidadNeg(){
        let anosNegocio = this.opportunity.fields.LMM_ls_Anosenelnegocio__c.value ===null?0:parseInt(this.opportunity.fields.LMM_ls_Anosenelnegocio__c.value);
        let concentEnClientes = this.opportunity.fields.LMM_ConcentracinenClientes__c.value === null?0:parseInt(this.opportunity.fields.LMM_ConcentracinenClientes__c.value);
        let riesgoIndustria = this.opportunity.fields.LMM_ls_Industria__c.value === null?0:parseInt(this.opportunity.fields.LMM_ls_Industria__c.value);
        let puntos = anosNegocio + concentEnClientes + riesgoIndustria;
        this.puntosCntNegIcon.icono = Math.sign(puntos) ===1?'utility:chevronup':Math.sign(puntos) ===-1?'utility:chevrondown':undefined;
        this.puntosCntNegIcon.variant=  this.puntosCntNegIcon.icono ==='utility:chevronup'?'Success':this.puntosCntNegIcon.icono ==='utility:chevrondown'?'error':undefined
        return puntos;
    }

    @track puntosCntNegIcon={};

    get puntosDesempFinan(){
        let diasDeAr = this.opportunity.fields.LM_ls_D_as_de_AR__c.value ===null?0:parseInt(this.opportunity.fields.LM_ls_D_as_de_AR__c.value);
        let tamanoDelDeal = this.opportunity.fields.LMM_ls_Tama_o_del_Deal__c.value ===null?0:parseInt(this.opportunity.fields.LMM_ls_Tama_o_del_Deal__c.value);
        let fccr = this.opportunity.fields.LMM_ls_FCCR__c.value ===null?0:parseInt(this.opportunity.fields.LMM_ls_FCCR__c.value);
        let totalDebVSEBITDA = this.opportunity.fields.LMM_ls_TotaldebtVSEBITDA__c.value ===null?0:parseInt(this.opportunity.fields.LMM_ls_TotaldebtVSEBITDA__c.value);
        let puntos = diasDeAr + tamanoDelDeal + fccr + totalDebVSEBITDA;
        this.puntosDesempFicon.icono = Math.sign(puntos) ===1?'utility:chevronup':Math.sign(puntos) ===-1?'utility:chevrondown':undefined;
        this.puntosDesempFicon.variant=  this.puntosDesempFicon.icono ==='utility:chevronup'?'Success':this.puntosDesempFicon.icono ==='utility:chevrondown'?'error':undefined
        return puntos;
    }

    @track puntosDesempFicon ={};

    get puntosEstructura(){
        let ltv = this.opportunity.fields.LMM_ls_LTVAdvancePaymentSD__c.value ===null?0:parseInt(this.opportunity.fields.LMM_ls_LTVAdvancePaymentSD__c.value);
        let actvoAltMon = this.opportunity.fields.LM_ls_Activaltamentemonetiz__c.value ===null?0:parseInt(this.opportunity.fields.LM_ls_Activaltamentemonetiz__c.value);
        let collateralGap = this.opportunity.fields.LMM_ls_Collateral_Gap__c.value ===null?0:parseInt(this.opportunity.fields.LMM_ls_Collateral_Gap__c.value);
        let garantAdic = this.opportunity.fields.LMM_ls_Garant_as_Adicionales__c.value ===null?0:parseInt(this.opportunity.fields.LMM_ls_Garant_as_Adicionales__c.value);
        let puntos = ltv + actvoAltMon + collateralGap + garantAdic;
        this.puntosEstrucIcon.icono = Math.sign(puntos) ===1?'utility:chevronup':Math.sign(puntos) ===-1?'utility:chevrondown':undefined;
        this.puntosEstrucIcon.variant=  this.puntosEstrucIcon.icono ==='utility:chevronup'?'Success':this.puntosEstrucIcon.icono ==='utility:chevrondown'?'error':undefined
        return puntos;
    }

    @track puntosEstrucIcon = {};

    get primarios(){
        return this.puntosCaracter + this.puntosContinuidadNeg + this.puntosDesempFinan;
    }

    get totalPoints(){
        let total = this.primarios + this.puntosEstructura;
        let result ={
            res:"",
            risk:"",
            variant:"Success",
            name:"utility:chevronup",
            color:"slds-text-color_error"
        };
        if(total< 85){
            result.res ="Rechazada";
            result.risk="C"
            result.variant = "Error";
            result.name = "utility:chevrondown"
            result.color ="slds-text-color_error";
            this.appResult = result;
           
        }

        if(total >=85 && total <90){
            result.res ="Aprobada";
            result.risk = "C";
            result.variant = "Success";
            result.name ="utility:chevronup";
            result.color ="slds-text-color_success";
            this.result = result;
            this.appResult = result;
           
        }

        if(total >=90 && total < 110){
            result.res ="Aprobada";
            result.risk = "B";
            result.variant = "Success";
            result.name ="utility:chevronup";
            result.color ="slds-text-color_success";
            this.appResult = result;
            
        }

        if(total >=110){
            result.res ="Aprobada";
            result.risk = "A";
            result.variant = "Success";
            result.name = "utility:chevronup";
            result.color ="slds-text-color_success";
            this.appResult = result;
           
        }
        return total;
    }


    visibiliy(){
        if(this.userProfile ==="Administrador del sistema" || this.userProfile==="System Administrator" || this.userProfile==="Risk"){
            console.log('es true')
            this.visiEdit = true;
           
        }else{
            console.log('es false')
            this.visiEdit = false;
          
        }
    }

}