/**
 * @description       : 
 * @author            : angel87ambher@gmail.com
 * @group             : 
 * @last modified on  : 08-20-2020
 * @last modified by  : angel87ambher@gmail.com
 * Modifications Log 
 * Ver   Date         Author                    Modification
 * 1.0   08-03-2020   angel87ambher@gmail.com   Initial Version
**/
import { LightningElement,track } from 'lwc';


export default class LmmRacApp extends LightningElement {

    @track buroRepresentativos;
    @track AnosExperienciaSectors;
    @track ORmejor;
    @track ExperienciaCliente;
    @track MaximaConcentracion;
    @track Fccrs;
    @track Apalancamiento;
    @track Ratio;
    @track AccionesPG;
    @track CalificacionBuro;

    get buroRepresentativo() {
        return [
            { label: 'Positivo', value: 'Positivo' },
            { label: 'Negativo', value: 'Negativo' },
            { label: 'Sin experiencia', value: 'Sin experiencia' },
        ];
    }

    handleChangeBuroRepresentativo(event) {
        this.value = event.detail.value;
        this.buroRepresentativos = this.value;
    }

    
    handleChangeAñosExperienciaSector(event) {
        this.value = event.detail.value;
        this.AnosExperienciaSectors = this.value;
    }

    handleChangeOR15(event){
        this.value = event.detail.value;
        this.ORmejor = this.value;  
    }

    handleChangeAñosexperienciacliente(event){
        this.value = event.detail.value;
        this.ExperienciaCliente = this.value;  
    }

    handleChangeMaximaConcentracion(event){
        this.value = event.detail.value;
        this.MaximaConcentracion = this.value;  
    }

    
    handleChangeFCCR(event){
        this.value = event.detail.value;
        this.Fccrs = this.value;  
    }

    handleChangeApalancamiento(event){
        this.value = event.detail.value;
        this.Apalancamiento = this.value;  
    }

    handleChangeRatio(event){
        this.value = event.detail.value;
        this.Ratio = this.value;  
    }

    handleChangeAccionesPG(event){
        this.value = event.detail.value;
        this.AccionesPG = this.value;  
    }

    handleChangeCalificacionBuro(event){
        this.value = event.detail.value;
        this.CalificacionBuro = this.value;  
    }

  get calculateValuesRac(){

    console.log('Inicio');
    console.log('Inicio' + this.sumaRAC);

if(this.empty(this.buroRepresentativos.value) || this.empty(this.AnosExperienciaSectors.value) ||this.empty(this.ORmejor.value) ||this.empty(this.ExperienciaCliente.value)||this.empty(this.MaximaConcentracion.value)||this.empty(this.Fccrs.value)||this.empty(this.Apalancamiento.value)||this.empty(this.Ratio.value)||this.empty(this.AccionesPG.value)||this.empty(this.CalificacionBuro.value)){

    return 0;}
        this.sumaRAC=0;

        //Validacion de Buro Representativo*
     if(this.buroRepresentativos.value =='Positivo'){ 
           this.sumaRAC +=10;
       }

       else if(this.buroRepresentativos.value =='Sin experiencia'){ 
        this.sumaRAC +=10;
    } 
     
   else if(this.buroRepresentativos.value =='Negativo'){ 
        this.sumaRAC +=0;
    }
     
   //Validacion de Años de experiencia en el sector 7 Pass
   
     if(this.AnosExperienciaSectors.value >=5){ 
        this.sumaRAC +=10;
    }
  else if(this.AnosExperienciaSectors.value < 5){ 
        this.sumaRAC +=0;
    } 
         
   //Validacion OR15 o mejor
   
     if(this.ORmejor.value <= 15 ){ 
        this.sumaRAC +=10;
    }
  else if(this.ORmejor.value > 15){ 
        this.sumaRAC +=0;
    } 
         
   //Validacion Años de experiencia del cliente
   
     if(this.ExperienciaCliente.value >= 5 ){ 
        this.sumaRAC +=10;
    }
  else if(this.ExperienciaCliente.value < 5){ 
        this.sumaRAC +=0;
    } 

   //Validacion Maxima concentración
   
     if(this.MaximaConcentracion.value <= 60 ){ 
        this.sumaRAC +=10;
    }
  else if(this.MaximaConcentracion.value > 60){ 
        this.sumaRAC +=0;
    } 
         
   //Validacion FCCR
   
     if(this.Fccrs.value >= 0.75 ){ 
        this.sumaRAC +=10;
    }
  else if(this.Fccrs.value < 0.75){ 
        this.sumaRAC +=0;
    } 
                      
   //Validacion Apalancamiento
   
     if(this.Apalancamiento.value <= 4 ){ 
        this.sumaRAC +=10;
    }
  else if(this.Apalancamiento.value > 4 ){ 
        this.sumaRAC +=0;
    } 

   //Validacion de Ratio
   
     if(this.Ratio.value <= 0.5 ){ 
        this.sumaRAC +=10;
    }
  else if(this.Ratio.value > 0.5){ 
        this.sumaRAC +=0;
    } 

   //Validacion de Acciones PG
   
     if(this.AccionesPG.value > 60){ 
        this.sumaRAC +=10;
    }
  else if(this.AccionesPG.value <= 60){ 
        this.sumaRAC +=0;
    } 

   //Validacion Calificación Aval Principal
   
     if(this.CalificacionBuro.value >= 690 ){ 
        this.sumaRAC +=10;
    }
  else if(this.CalificacionBuro.value < 690){ 
        this.sumaRAC +=0;
    } 
    
    console.log('Final');
    console.log(this.sumaRAC);
           return this.sumaRAC;



        }

        get icono(){
            let result2 ={
                res:"",
                variant:"Success",
                name:"utility:chevronup",
                color:"slds-text-color_error"
            };

                            //Validacion de Buro Representativo*
            if(this.buroRepresentativos.value =='Positivo'){ 
                result2.res ="Continuar";
                result2.variant = "Success";
                result2.name ="utility:chevronup";
                result2.color ="slds-text-color_success";
                this.result2 = result2;
                this.appResult2 = result2;
            }

            else if(this.buroRepresentativos.value =='Sin experiencia'){ 
                result2.res ="Continuar";
                result2.variant = "Success";
                result2.name ="utility:chevronup";
                result2.color ="slds-text-color_success";
                this.result2 = result2;
                this.appResult2 = result2;
              } 
        
            else if(this.buroRepresentativos.value =='Negativo'){ 

                result2.res ="Rechazada";
                result2.variant = "Error";
                result2.name = "utility:chevrondown";
                result2.color ="slds-text-color_error";
                this.result2 = result2;
                this.appResult2 = result2;
             }

return;
            
        }

        get resultado(){

            let suma=this.sumaRAC;
            console.log('SUMA:'+suma);
            let result ={
                res:"",
                variant:"Success",
                name:"utility:chevronup",
                color:"slds-text-color_error"
            };

    
            if(suma  >= 80){

                result.res ="Continuar";
                    result.variant = "Success";
                    result.name ="utility:chevronup";
                    result.color ="slds-text-color_success";
                    this.result = result;
                    this.appResult = result;
                    console.log('SUMA2:'+suma);
                    
                if(this.buroRepresentativos.value =='Negativo' ||this.Apalancamiento.value > 4 ||this.Fccrs.value < 0.75){
                result.res ="Rechazada";
                result.variant = "Success";
                result.name = "utility:chevrondown";
                result.color ="slds-text-color_error";
                this.result = result;
                this.appResult = result;
                console.log('SUMA2:'+suma);
                }
            
                    
            }else{
                result.res ="Rechazada";
                result.variant = "Error";
                result.name = "utility:chevrondown";
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