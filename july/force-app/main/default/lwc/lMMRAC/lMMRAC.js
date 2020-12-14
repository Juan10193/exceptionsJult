/**
 * @File Name          : lMMRAC.js
 * @Description        : 
 * @Author             : angel87ambher@gmail.com
 * @Group              : 
 * @Last Modified By   : angel87ambher@gmail.com
 * @Last Modified On   : 2/6/2020 16:44:48
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    1/6/2020   angel87ambher@gmail.com     Initial Version
**/
import { LightningElement,track,api,wire } from 'lwc';
import { getRecord} from 'lightning/uiRecordApi';
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import {FILEOPP} from './fieldsOpHelper';
import momentJs from '@salesforce/resourceUrl/momentJs';
import Animate from  '@salesforce/resourceUrl/Animate';
import { loadScript, loadStyle } from 'lightning/platformResourceLoader';



export default class LMMRAC extends LightningElement {
    @api objectApiName;
    @api recordId;
    @track data;
    @track opportunity;
    @track appResult;
    @track sipinner=false;
    @track editMode =false;
    @track sumaRAC;
    @track val;
    @track activeSections = [
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
            console.log('ERROR AL CARGAR OPP')
            console.log(error)
        }else if (data) {
            this.opportunity = data;
            console.log('OPP')
            console.log(this.opportunity);        }
    }


    connectedCallback(){
        Promise.all([
            loadScript(this, momentJs),
            loadStyle(this, Animate)
        ]).then(() => { 'scripts cargados' });
        
    }

    changeToEdit(event){  
        this.editMode = true;
        this.activeSections = [
            "RAC LMM"
        ];
    }

    clearEditMode(){
        this.editMode = false;
        this.activeSections = [
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

  get calculateValuesRac(){

if(this.empty(this.opportunity.fields.LMM_Buro_Representativo__c.value) || this.empty(this.opportunity.fields.LMM_Anos_de_experiencia_en_el_sector__c.value) ||this.empty(this.opportunity.fields.LMM_OR15_o_mejor__c.value) ||this.empty(this.opportunity.fields.LMM_Anos_experiencia_cliente_p__c.value)||this.empty(this.opportunity.fields.LMM_Maxima_concentracion__c.value)||this.empty(this.opportunity.fields.LMM_FCCR__c.value)||this.empty(this.opportunity.fields.LMM_Apalancamiento__c.value)||this.empty(this.opportunity.fields.LMM_Ratio__c.value)||this.empty(this.opportunity.fields.LMM_Acciones_PG__c.value)||this.empty(this.opportunity.fields.LMM_Calificacion_Aval_Principal__c.value)){

    return 0;
    
}
        this.sumaRAC=0;

        //Validacion de Buro Representativo*
     if(this.opportunity.fields.LMM_Buro_Representativo__c.value =='Positivo'){ 
           this.sumaRAC +=10;
       }

       else if(this.opportunity.fields.LMM_Buro_Representativo__c.value =='Sin experiencia'){ 
        this.sumaRAC +=10;
    } 
     
   else if(this.opportunity.fields.LMM_Buro_Representativo__c.value =='Negativo'){ 
        this.sumaRAC +=0;
    }
     
   //Validacion de Años de experiencia en el sector 7 Pass
   
     if(this.opportunity.fields.LMM_Anos_de_experiencia_en_el_sector__c.value >=5){ 
        this.sumaRAC +=10;
    }
  else if(this.opportunity.fields.LMM_Anos_de_experiencia_en_el_sector__c.value < 5){ 
        this.sumaRAC +=0;
    } 
         
   //Validacion OR15 o mejor
   
     if(this.opportunity.fields.LMM_OR15_o_mejor__c.value <= 15 ){ 
        this.sumaRAC +=10;
    }
  else if(this.opportunity.fields.LMM_OR15_o_mejor__c.value > 15){ 
        this.sumaRAC +=0;
    } 
         
   //Validacion Años de experiencia del cliente
   
     if(this.opportunity.fields.LMM_Anos_experiencia_cliente_p__c.value >= 5 ){ 
        this.sumaRAC +=10;
    }
  else if(this.opportunity.fields.LMM_Anos_experiencia_cliente_p__c.value < 5){ 
        this.sumaRAC +=0;
    } 

   //Validacion Maxima concentración
   
     if(this.opportunity.fields.LMM_Maxima_concentracion__c.value <= 60 ){ 
        this.sumaRAC +=10;
    }
  else if(this.opportunity.fields.LMM_Maxima_concentracion__c.value > 60){ 
        this.sumaRAC +=0;
    } 
         
   //Validacion FCCR
   
     if(this.opportunity.fields.LMM_FCCR__c.value >= 0.75 ){ 
        this.sumaRAC +=10;
    }
  else if(this.opportunity.fields.LMM_FCCR__c.value < 0.75){ 
        this.sumaRAC +=0;
    } 
                      
   //Validacion Apalancamiento
   
     if(this.opportunity.fields.LMM_Apalancamiento__c.value <= 4 ){ 
        this.sumaRAC +=10;
    }
  else if(this.opportunity.fields.LMM_Apalancamiento__c.value > 4 ){ 
        this.sumaRAC +=0;
    } 

   //Validacion de Ratio
   
     if(this.opportunity.fields.LMM_Ratio__c.value <= 0.5 ){ 
        this.sumaRAC +=10;
    }
  else if(this.opportunity.fields.LMM_Ratio__c.value > 0.5){ 
        this.sumaRAC +=0;
    } 

   //Validacion de Acciones PG
   
     if(this.opportunity.fields.LMM_Acciones_PG__c.value > 60){ 
        this.sumaRAC +=10;
    }
  else if(this.opportunity.fields.LMM_Acciones_PG__c.value <= 60){ 
        this.sumaRAC +=0;
    } 

   //Validacion Calificación Aval Principal
   
     if(this.opportunity.fields.LMM_Calificacion_Aval_Principal__c.value >= 690 ){ 
        this.sumaRAC +=10;
    }
  else if(this.opportunity.fields.LMM_Calificacion_Aval_Principal__c.value < 690){ 
        this.sumaRAC +=0;
    } 
    
           return this.sumaRAC;

        }

        get resultado(){

            let suma=this.sumaRAC;
            console.log('SUMA:'+suma);
            let result ={
                res:"",
                variant:"Success",
                color:"slds-text-color_error"
            };

    
            if(suma  >= 80){

                result.res ="Continuar";
                    result.variant = "Success";
                    result.color ="slds-text-color_success";
                    this.result = result;
                    this.appResult = result;
                    console.log('SUMA2:'+suma);
                    
                if(this.opportunity.fields.LMM_Buro_Representativo__c.value =='Negativo' ||this.opportunity.fields.LMM_Apalancamiento__c.value > 4 ||this.opportunity.fields.LMM_FCCR__c.value < 0.75){
                result.res ="Rechazada";
                result.variant = "Success";
                result.color ="slds-text-color_error";
                this.result = result;
                this.appResult = result;
                console.log('SUMA2:'+suma);
                }
            
                    
            }else{
                result.res ="Rechazada";
                result.variant = "Error";
                result.color ="slds-text-color_error";
                this.result = result;
                this.appResult = result;
                console.log('SUMA3:'+suma);
               
            }

            return suma;
           
        }

       empty( val ) {

 

    if (val === undefined)
       return true;

 

   if (typeof (val) == 'function' || typeof (val) == 'number' || typeof (val) == 'boolean' || Object.prototype.toString.call(val) === '[object Date]')
       return false;

 

   if (val == null || val.length === 0)   
       return true;

 

   if (typeof (val) == "object") {
       var r = true;
       for (var f in val)
           r = false;
       return r;
   }

 

   return false;
}
}