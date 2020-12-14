/**
 * @File Name          : tkdScoredcard.js
 * @Description        : 
 * @Author             : angel87ambher@gmail.com
 * @Group              : 
 * @Last Modified By   : angel87ambher@gmail.com
 * @Last Modified On   : 08-21-2020
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    3/7/2020   angel87ambher@gmail.com     Initial Version
**/
import { LightningElement,track,api,wire } from 'lwc';
import { getRecord} from 'lightning/uiRecordApi';
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import {FILESUP} from './fieldsSupHelper';
import momentJs from '@salesforce/resourceUrl/momentJs';
import Animate from  '@salesforce/resourceUrl/Animate';
import { loadScript, loadStyle } from 'lightning/platformResourceLoader';

export default class TkdScoredcard extends LightningElement {

    @api recordId;
    @track supplier;
    @track booking1=false;;
    @track booking2=false;
    @track sumaScoredcard;
    @track sipinner=false;
    @track editMode =false;
    @track showModalAddEntities = false;
    @track rejected=false;
    @api title;
    @api height = 'height: 640px;';
    @api initModalClass = 'slds-modal slds-fade-in-open animated fadeInRight';

    @track activeSections = [
        "INFORMACIÓN DEL PROVEEDOR"
    ];


    @wire(getRecord, {recordId:'$recordId', fields:FILESUP})
    wiresupp({error,data}){
        if(error){
            let message = "Unknown error";
            if (Array.isArray(error.body)) {
              message = error.body.map(e => e.message).join(", ");
            } else if (typeof error.body.message === "string") {
              message = error.body.message;
            }
            this.dispatchEvent(
              new ShowToastEvent({
                title: "Error loading Supplier Fields",
                message,
                variant: "error"
              })
            );
            console.log('ERROR AL CARGAR SUPPLIER')
            console.log(error)
        }else if (data) {
            this.supplier = data;
               }
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
            "INFORMACIÓN DEL PROVEEDOR"
        ];
    }

    clearEditMode(){
        this.editMode = false;
        this.activeSections = [
            "INFORMACIÓN DEL PROVEEDOR"
        ];
    }

    stageReject(event){
       this.rejected=true;
       event.preventDefault();       // stop the form from submitting
       const fields = event.detail.fields;
      this.template.querySelector('lightning-record-view-form').submit(fields);

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
            "INFORMACIÓN DEL PROVEEDOR"
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
    handleCloseModals() {
      this.showModalAddEntities = false
      this.deleteEntidadOportunidad = false
  }

  

get tipobooking(){
   if(this.supplier.fields.TKD_Tipo_de_Scorecard__c.value =='Booking Nuevo'){
      
      this.booking1=true;
      console.log('true'+this.booking1);
   }else {
      this.booking1=false;
      console.log('false'+this.booking1);

   }

   return this.booking1;
   
}

    get visibiliy(){
        if(this.userProfile ==="Administrador del sistema" || this.userProfile==="System Administrator" || this.userProfile==="Asset Management Supplier"){
            return false;
        }else{
            return true;
        }
    }

    get calculateValuesScoredcard(){

            this.sumaScoredcard=0;

                    
        if(this.supplier.fields.TKD_Tipo_de_Scorecard__c.value =='Booking Nuevo'){
        
            //INFORMACIÓN DEL PROVEEDOR 
                //SECCIÓN 1 

        if(this.supplier.fields.TKD_Tipo_de_proveedor__c.value =='FABRICANTE'){ 
        this.sumaScoredcard +=15;
        }
        else if(this.supplier.fields.TKD_Tipo_de_proveedor__c.value =='COMERCIALIZADORA'){ 
        this.sumaScoredcard +=5;
        }
        else if(this.supplier.fields.TKD_Tipo_de_proveedor__c.value =='DISTRIBUIDOR'){ 
        this.sumaScoredcard +=15;
        }
        else if(this.supplier.fields.TKD_Tipo_de_proveedor__c.value =='PERSONA FISICA'){ 
        this.sumaScoredcard +=5;
        }

                //SECCIÓN 2 


        if(this.supplier.fields.TKD_Verificacion_de_domicilio__c.value =='CORRECTA'){ 
        this.sumaScoredcard +=10;
        }
        else if(this.supplier.fields.TKD_Verificacion_de_domicilio__c.value =='INCORRECTA'){ 
        this.sumaScoredcard +=0;
        }

                //SECCIÓN 3 

        if(this.supplier.fields.TKD_Pagina_web_existente__c.value =='CORRECTA'){ 
        this.sumaScoredcard +=5;
        }
        else if(this.supplier.fields.TKD_Pagina_web_existente__c.value =='INCORRECTA'){ 
        this.sumaScoredcard +=0;
        }

                //EXPERIENCIA
                //SECCIÓN 1
                
        if(this.supplier.fields.TKD_Proveedores_sustitutos__c.value =='SI'){ 
        this.sumaScoredcard +=2;
        }
        else if(this.supplier.fields.TKD_Proveedores_sustitutos__c.value =='NO'){ 
        this.sumaScoredcard +=0;
        }					
                //SECCIÓN 2
                
        if(this.supplier.fields.TKD_Presencia_en_otras_ciudades_regiones__c.value =='SI'){ 
        this.sumaScoredcard +=6;
        }
        else if(this.supplier.fields.TKD_Presencia_en_otras_ciudades_regiones__c.value =='NO'){ 
        this.sumaScoredcard +=3;
        }

                //SECCIÓN 3
                
        if(this.supplier.fields.TKD_L_deres_en_venta_de_este_activo__c.value =='SI'){ 
        this.sumaScoredcard +=12;
        }
        else if(this.supplier.fields.TKD_L_deres_en_venta_de_este_activo__c.value =='NO'){ 
        this.sumaScoredcard +=6;
        }   

                //SECCIÓN 4
                
        if(this.supplier.fields.TKD_A_os_de_garant_a_del_activo__c.value =='SI'){ 
        this.sumaScoredcard +=5;
        }
        else if(this.supplier.fields.TKD_A_os_de_garant_a_del_activo__c.value =='NO'){ 
        this.sumaScoredcard +=0;
        }
            
                //SECCIÓN 5
                
        if(this.supplier.fields.TKD_Servicio_post_venta__c.value =='SI'){ 
        this.sumaScoredcard +=5;
        }
        else if(this.supplier.fields.TKD_Servicio_post_venta__c.value =='NO'){ 
        this.sumaScoredcard +=0;
        }			

                //SAT
                //SECCIÓN 1	
                
        if(this.supplier.fields.TKD_Validaci_n_de_RFC_ante_el_SAT__c.value =='SI'){ 
        this.sumaScoredcard +=5;
        }
        else if(this.supplier.fields.TKD_Validaci_n_de_RFC_ante_el_SAT__c.value =='NO'){ 
        this.sumaScoredcard +=0;
        }
        else if(this.supplier.fields.TKD_Validaci_n_de_RFC_ante_el_SAT__c.value =='NO LOCALIZADO'){ 
        this.sumaScoredcard +=0;
        }	

                //SECCIÓN 2	
                
        if(this.supplier.fields.Opini_n_positiva_del_SAT__c	.value =='POSITIVA'){ 
        this.sumaScoredcard +=5;
        }
        else if(this.supplier.fields.Opini_n_positiva_del_SAT__c.value =='NEGATIVA'){ 
        this.sumaScoredcard +=0;
        }
        else if(this.supplier.fields.Opini_n_positiva_del_SAT__c.value =='NO PERMIMTIDO'){ 
        this.sumaScoredcard +=0;
        }
                
                //SECCIÓN 3	
                
        if(this.supplier.fields.TKD_Revision_de_facturas_origen__c.value =='SI'){ 
        this.sumaScoredcard +=10;
        }
        else if(this.supplier.fields.TKD_Revision_de_facturas_origen__c.value =='NO'){ 
        this.sumaScoredcard +=0;
        }
        else if(this.supplier.fields.TKD_Revision_de_facturas_origen__c.value =='N/A'){ 
        this.sumaScoredcard +=10;
        }					

                //MERCADO
                //SECCIÓN 1

        if(this.supplier.fields.TKD_quien_es_quien__c.value =='SI'){ 
        this.sumaScoredcard +=10;
        }
        else if(this.supplier.fields.TKD_quien_es_quien__c.value =='NO'){ 
        this.sumaScoredcard +=0;
        }

                //SECCIÓN 2

        if(this.supplier.fields.TKD_Se_encuentra_en_Google_Search__c.value =='SI'){ 
        this.sumaScoredcard +=5;
        }
        else if(this.supplier.fields.TKD_Se_encuentra_en_Google_Search__c.value =='NO'){ 
        this.sumaScoredcard +=0;
        }

                //SECCIÓN 3
                
        if(this.supplier.fields.TKD_Se_encuentra_correcto_en_el_BIL__c.value =='SI'){ 
        this.sumaScoredcard +=5;
        }
        else if(this.supplier.fields.TKD_Se_encuentra_correcto_en_el_BIL__c	.value =='NO'){ 
        this.sumaScoredcard +=0;
        }         			
        } else if(this.supplier.fields.TKD_Tipo_de_Scorecard__c.value =='Booking'){


			    //INFORMACIÓN DEL PROVEEDOR 
                      //SECCIÓN 1 

                      if(this.supplier.fields.TKD_Tipo_de_proveedor__c.value =='FABRICANTE'){ 
                        this.sumaScoredcard +=15;
                     }
                     else if(this.supplier.fields.TKD_Tipo_de_proveedor__c.value =='COMERCIALIZADORA'){ 
                        this.sumaScoredcard +=5;
                     }
                     else if(this.supplier.fields.TKD_Tipo_de_proveedor__c.value =='DISTRIBUIDOR'){ 
                        this.sumaScoredcard +=15;
                     }
                     else if(this.supplier.fields.TKD_Tipo_de_proveedor__c.value =='PERSONA FISICA'){ 
                        this.sumaScoredcard +=5;
                     }
                 
                                       //SECCIÓN 2 
                 
                 
                     if(this.supplier.fields.TKD_Verificacion_de_domicilio__c.value =='CORRECTA'){ 
                        this.sumaScoredcard +=10;
                     }
                     else if(this.supplier.fields.TKD_Verificacion_de_domicilio__c.value =='INCORRECTA'){ 
                        this.sumaScoredcard +=0;
                     }
                             
                                       //SECCIÓN 3 
                 
                     if(this.supplier.fields.TKD_Pagina_web_existente__c.value =='CORRECTA'){ 
                        this.sumaScoredcard +=5;
                     }
                     else if(this.supplier.fields.TKD_Pagina_web_existente__c.value =='INCORRECTA'){ 
                        this.sumaScoredcard +=0;
                     }
                     
                                     //EXPERIENCIA
                                     //SECCIÓN 1
                                     
                     if(this.supplier.fields.TKD_Numero_de_veces_que_hemos_trabajo__c.value =='NO'){ 
                        this.sumaScoredcard +=0;
                     }
                     else if(this.supplier.fields.TKD_Numero_de_veces_que_hemos_trabajo__c.value =='MENOR O IGUAL A 2'){ 
                        this.sumaScoredcard +=1;
                     }
                     else if(this.supplier.fields.TKD_Numero_de_veces_que_hemos_trabajo__c.value =='MAYOR A 3 Y MENOR A 5'){ 
                        this.sumaScoredcard +=4;
                     }
                 
                     else if(this.supplier.fields.TKD_Numero_de_veces_que_hemos_trabajo__c.value =='MAYOR A 5'){ 
                        this.sumaScoredcard +=8;
                     }
                     
                                    //SECCIÓN 2
                 
                     if(this.supplier.fields.TKD_Cuantos_clientes_de_EC_han_traido__c.value =='NO'){ 
                        this.sumaScoredcard +=0;
                     }
                     else if(this.supplier.fields.TKD_Cuantos_clientes_de_EC_han_traido__c.value =='MENOR O IGUAL A 2'){ 
                        this.sumaScoredcard +=1;
                     }
                     else if(this.supplier.fields.TKD_Cuantos_clientes_de_EC_han_traido__c.value =='MAYOR A 3 Y MENOR A 5'){ 
                        this.sumaScoredcard +=4;
                     }
                 
                     else if(this.supplier.fields.TKD_Cuantos_clientes_de_EC_han_traido__c.value =='MAYOR A 5'){ 
                        this.sumaScoredcard +=8;
                     }
                 
                                    //SECCIÓN 3
                                    
                     if(this.supplier.fields.TKD_Que_montonoshafacturado_el_proveedor__c.value =='NO'){ 
                        this.sumaScoredcard +=0;
                     }
                     else if(this.supplier.fields.TKD_Que_montonoshafacturado_el_proveedor__c.value =='HASTA 2 MM MXP'){ 
                        this.sumaScoredcard +=1;
                     }
                     else if(this.supplier.fields.TKD_Que_montonoshafacturado_el_proveedor__c.value =='DE 2.1 MM A 40 MM MXP'){ 
                        this.sumaScoredcard +=4;
                     }
                     else if(this.supplier.fields.TKD_Que_montonoshafacturado_el_proveedor__c.value =='MAYOR A 40 MM MXP'){ 
                        this.sumaScoredcard +=8;
                     }
                                     //SECCIÓN 4
                                     
                     if(this.supplier.fields.TKD_Proveedores_sustitutos__c.value =='SI'){ 
                        this.sumaScoredcard +=2;
                     }
                     else if(this.supplier.fields.TKD_Proveedores_sustitutos__c.value =='NO'){ 
                        this.sumaScoredcard +=0;
                     }					
                                     //SECCIÓN 5
                                     
                     if(this.supplier.fields.TKD_Presencia_en_otras_ciudades_regiones__c.value =='SI'){ 
                        this.sumaScoredcard +=2;
                     }
                     else if(this.supplier.fields.TKD_Presencia_en_otras_ciudades_regiones__c.value =='NO'){ 
                        this.sumaScoredcard +=0;
                     }
                             
                                     //SECCIÓN 6
                                     
                     if(this.supplier.fields.TKD_L_deres_en_venta_de_este_activo__c.value =='SI'){ 
                        this.sumaScoredcard +=3;
                     }
                     else if(this.supplier.fields.TKD_L_deres_en_venta_de_este_activo__c.value =='NO'){ 
                        this.sumaScoredcard +=0;
                     }   
                             
                                     //SECCIÓN 7
                                     
                     if(this.supplier.fields.TKD_A_os_de_garant_a_del_activo__c.value =='SI'){ 
                        this.sumaScoredcard +=2;
                     }
                     else if(this.supplier.fields.TKD_A_os_de_garant_a_del_activo__c.value =='NO'){ 
                        this.sumaScoredcard +=0;
                     }
                                 
                                     //SECCIÓN 8
                                     
                     if(this.supplier.fields.TKD_Servicio_post_venta__c.value =='SI'){ 
                        this.sumaScoredcard +=2;
                     }
                     else if(this.supplier.fields.TKD_Servicio_post_venta__c.value =='NO'){ 
                        this.sumaScoredcard +=0;
                     }			
                 
                                        //SAT
                                     //SECCIÓN 1	
                                     
                     if(this.supplier.fields.TKD_Validaci_n_de_RFC_ante_el_SAT__c.value =='SI'){ 
                        this.sumaScoredcard +=5;
                     }
                     else if(this.supplier.fields.TKD_Validaci_n_de_RFC_ante_el_SAT__c.value =='NO'){ 
                        this.sumaScoredcard +=0;
                     }
                     else if(this.supplier.fields.TKD_Validaci_n_de_RFC_ante_el_SAT__c.value =='NO LOCALIZADO'){ 
                        this.sumaScoredcard +=0;
                     }	
                     
                                     //SECCIÓN 2	
                                     
                     if(this.supplier.fields.Opini_n_positiva_del_SAT__c	.value =='POSITIVA'){ 
                        this.sumaScoredcard +=5;
                     }
                     else if(this.supplier.fields.Opini_n_positiva_del_SAT__c.value =='NEGATIVA'){ 
                        this.sumaScoredcard +=0;
                     }
                     else if(this.supplier.fields.Opini_n_positiva_del_SAT__c.value =='NO PERMIMTIDO'){ 
                        this.sumaScoredcard +=0;
                     }
                                     
                                     //SECCIÓN 3	
                                     
                     if(this.supplier.fields.TKD_Revision_de_facturas_origen__c.value =='SI'){ 
                        this.sumaScoredcard +=10;
                     }
                     else if(this.supplier.fields.TKD_Revision_de_facturas_origen__c.value =='NO'){ 
                        this.sumaScoredcard +=0;
                     }
                     else if(this.supplier.fields.TKD_Revision_de_facturas_origen__c.value =='N/A'){ 
                        this.sumaScoredcard +=0;
                     }					
                             
                                     //MERCADO
                                     //SECCIÓN 1
                 
                     if(this.supplier.fields.TKD_quien_es_quien__c.value =='SI'){ 
                        this.sumaScoredcard +=10;
                     }
                     else if(this.supplier.fields.TKD_quien_es_quien__c.value =='NO'){ 
                        this.sumaScoredcard +=0;
                     }
                 
                                     //SECCIÓN 2
                 
                     if(this.supplier.fields.TKD_Se_encuentra_en_Google_Search__c.value =='SI'){ 
                        this.sumaScoredcard +=5;
                     }
                     else if(this.supplier.fields.TKD_Se_encuentra_en_Google_Search__c.value =='NO'){ 
                        this.sumaScoredcard +=0;
                     }
                 
                                     //SECCIÓN 3
                                     
                     if(this.supplier.fields.TKD_Se_encuentra_correcto_en_el_BIL__c.value =='SI'){ 
                        this.sumaScoredcard +=0;
                     }
                     else if(this.supplier.fields.TKD_Se_encuentra_correcto_en_el_BIL__c	.value =='NO'){ 
                        this.sumaScoredcard +=0;
                     }         		

        }
                
        
        return this.sumaScoredcard;

 
}

                get resultado(){

                    let suma=this.sumaScoredcard;
                    console.log('SUMA:'+suma);
                    let result ={
                        res:"",
                        variant:"Success",
                        name:"utility:chevronup",
                        color:"slds-text-color_error"
                    };
        
            
                    if(suma  >= 80){
        
                        result.res ="Aprobado";
                            result.variant = "Success";
                            result.name ="utility:chevronup";
                            result.color ="slds-text-color_success";
                            this.result = result;
                            this.appResult = result;
                            console.log('SUMA2:'+suma);
                            
                    }else{
                        result.res ="Pendiente de aprobación";
                        result.variant = "Error";
                        result.name = "utility:chevrondown";
                        result.color ="slds-text-color_error";
                        this.result = result;
                        this.appResult = result;
                        console.log('SUMA3:'+suma);

                        if(this.rejected == true){

                           result.res ="Pendiente de aprobación";
                           result.variant = "Error";
                           result.name = "utility:chevrondown";
                           result.color ="slds-text-color_error";
                           this.result = result;
                           this.appResult = result;
                           console.log('reject:'+suma);
                        }

                       
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