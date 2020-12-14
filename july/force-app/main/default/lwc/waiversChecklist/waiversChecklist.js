/**
 * @description       : 
 * @author            : angel87ambher@gmail.com
 * @group             : 
 * @last modified on  : 10-02-2020
 * @last modified by  : angel87ambher@gmail.com
 * Modifications Log 
 * Ver   Date         Author                    Modification
 * 1.0   10-01-2020   angel87ambher@gmail.com   Initial Version
**/
import { LightningElement,track,api,wire } from 'lwc';
import { getRecord} from 'lightning/uiRecordApi';
import {FILEWAIVER} from './fieldsWaivers';
import momentJs from '@salesforce/resourceUrl/momentJs';
import Animate from  '@salesforce/resourceUrl/Animate';
import { loadScript, loadStyle } from 'lightning/platformResourceLoader';


export default class WaiversChecklist extends LightningElement {

    @api recordId;
    @track waivers;
    @track typeExc=false;
    @track nombre;
    @track exception;
    

    value = [];

    @wire(getRecord, {recordId:'$recordId', fields:FILEWAIVER})
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
                title: "Error loading Waiver Fields",
                message,
                variant: "error"
              })
            );
            console.log('ERROR AL CARGAR Waiver')
            console.log(error)
        }else if (data) {
            this.waivers = data;
            this.nombre =data.fields.Name.value;
            this.exception = data.fields.Document_Type__c.value;
          console.log(this.exception);
               }
    }

    connectedCallback(){
        Promise.all([
            loadScript(this, momentJs),
            loadStyle(this, Animate)
        ]).then(() => { 'scripts cargados' });
        
    }


    get optionSolicitud() {

        if(this.exception=='Credit note'){
        return [
            { label: 'Colocar especificación del monto y producto de la operación', value: 'option1' },
           
        ];
       }else if(this.exception=='Invoice'){
        return [
            { label: 'Adjuntar Evidencia (correo) fecha compromiso de refactura o emisión de nota de crédito', value: 'option1' },
            { label: 'Adjuntar PDF, XML y validación Tralix de la factura o nota de crédito incorrecta', value: 'option2' },
        ];
       }else if(this.exception=='Invoice Tralix Review'){
        return [
            { label: 'Adjuntar validación del SAT', value: 'option1' },
        ];
       }else if(this.exception=='Equipment field audit (EFA) / Appraisal'){
        return [
            { label: 'Loans: Se registra y fondea a citerio de Asset Management', value: 'option1' },
            { label: 'Arrendamiento: Sin EFA no existe registro ni fondeo', value: 'option2' },
        ];
       }else if(this.exception=='Import'){
        return [
            { label: 'Adjuntar carta / mail con explicación del cliente de porque no se cuenta con el pedimento', value: 'option1' },
        ];
       }else if(this.exception=='Insurance'){
        return [
            { label: 'Adjuntar póliza con error (si aplica)', value: 'option1' },
        ];
       }else if(this.exception=='Rapid tag'){
        return [
            { label: 'Adjuntar VoBo de TG1, facturas y facturas origen (si aplica)', value: 'option1' },
        ];
       }else if(this.exception=='Instruction letter'){
        return [
            { label: 'Adjuntar carta de instrucción corregida firmada y escaneada', value: 'option1' },
        ];
       }else if(this.exception=='Insurance CRO'){
        return [
            { label: 'Adjuntar correo con el compromiso de entrega del originador', value: 'option1' },
            { label: 'Adjuntar fecha compromiso de la póliza', value: 'option2' },
        ];
       }else if(this.exception=='Original documents delivered'){
        return [
            { label: 'Adjuntar documentos escanedos (todas las páginas)', value: 'option1' },
            { label: 'Adjuntar correo de originador dirigido a Fer Garza confirmando que tiene los documentos en su poder', value: 'option2' },
        ];
       }else if(this.exception=='Pending Payments CRO'){
        return [
            { label: 'Indicar en la solicitud el monto faltante por pagar y la relación contra el monto a fondear ', value: 'option1' },
            { label: 'Especificar motivos y razón por la cual el Cliente solicita la excepción', value: 'option2' },
        ];
       }else if(this.exception=='Pending Payments Collections'){
        return [
            { label: 'Indicar en la solicitud el monto faltante por pagar y la relación contra el monto a fondear', value: 'option1' },
        ];
       }else if(this.exception=='RUG / public registry of property Tollgate 1'){
        return [
            { label: 'Solicitud completada correctamente', value: 'option1' },
        ];
       }else if(this.exception=='Anti money laundry (AML)'){

           return null;

       }else if(this.exception=='Post-Funding Control Desk'){
        return [
            { label: 'Fe de erratas escaneado sin firmas', value: 'option1' },
            { label: 'Convenio modificatorio escaneado sin firmas', value: 'option2' },
        ];
       }else if(this.exception=='Post-Funding Risk'){

          return null;

       }else if(this.exception=='Underwriting pre-funding requirements'){

          return null;

       }
    }

    get optionCierre() {
        if(this.exception=='Credit note'){
            return null;
           }else if(this.exception=='Invoice'){
            return [
                { label: 'Adjuntar PDF, XML y validación Tralix de la factura o nota de crédito corregida', value: 'option3' },
            ];
           }else if(this.exception=='Invoice Tralix Review'){
            return [
                { label: 'Adjuntar validación Tralix de factura / nota de crédito corregida', value: 'option3' },
            ];
           }else if(this.exception=='Equipment field audit (EFA) / Appraisal'){
            return [
                { label: 'Adjuntar Reporte de EFA', value: 'option3' },
            ];
           }else if(this.exception=='Import'){
            return [
                { label: 'Adjuntar Pedimento', value: 'option3' },
            ];
           }else if(this.exception=='Insurance'){
            return [
                { label: 'Adjuntar póliza o carta cobertura', value: 'option3' },
            ];
           }else if(this.exception=='Rapid tag'){
            return [
                { label: 'Adjuntar facturas origen (si aplica)', value: 'option3' },
                { label: 'Adjuntar refacturas (si aplica)', value: 'option4' },
                { label: 'Adjuntar tarjetas de circulación', value: 'option5' },
            ];
           }else if(this.exception=='Instruction letter'){
            return [
                { label: 'Adjuntar acuse de File Room', value: 'option3' },
                { label: ' Adjuntar carta de instrucción firmada', value: 'option4' },
            ];
           }else if(this.exception=='Insurance CRO'){
            return [
                { label: 'Adjuntar póliza de seguro', value: 'option3' },
            ];
           }else if(this.exception=='Original documents delivered'){
            return [
                { label: 'Adjuntar acuse de file room', value: 'option3' },
                { label: 'Adjuntar documentos firmados', value: 'option4' },
            ];
           }else if(this.exception=='Pending Payments CRO'){
            return [
                { label: 'Adjuntar comprobante de pago', value: 'option3' },
            ];
           }else if(this.exception=='Pending Payments Collections'){
            return [
                { label: 'Adjuntar comprobante de pago', value: 'option3' },
            ];
           }else if(this.exception=='RUG / public registry of property Tollgate 1'){
            return [
                { label: 'Adjuntar consulta de RUG', value: 'option3' },
            ];
           }else if(this.exception=='Anti money laundry (AML)'){
    
               return null;
    
           }else if(this.exception=='Post-Funding Control Desk'){
            return [
                { label: 'Fe de erratas escaneado con firmas', value: 'option3' },
                { label: 'Convenio modificatorio escaneado con firmas', value: 'option4' },
                { label: 'EFA', value: 'option5' },
                { label: 'Evidencia de la solicitud de Riesgo', value: 'option6' },
            ];
           }else if(this.exception=='Post-Funding Risk'){
    
              return null;
    
           }else if(this.exception=='Underwriting pre-funding requirements'){
    
              return null;
    
           }
    }


    get typeException(){
        if(this.exception=='Credit note'){

            this.typeExc=true;

        }else if(this.exception=='Invoice'){

            this.typeExc=true;

        }else if(this.exception=='Invoice Tralix Review'){

            this.typeExc=true;

        }else if(this.exception=='Equipment field audit (EFA) / Appraisal'){

            this.typeExc=true;

        }else if(this.exception=='Import'){

            this.typeExc=true;

        }else if(this.exception=='Insurance'){

            this.typeExc=true;

        }else if(this.exception=='Rapid tag'){

            this.typeExc=true;

        }else if(this.exception=='Instruction letter'){

            this.typeExc=true;

        }else if(this.exception=='Insurance CRO'){

            this.typeExc=true;

        }else if(this.exception=='Original documents delivered'){

            this.typeExc=true;

        }else if(this.exception=='Pending Payments CRO'){

            this.typeExc=true;

        }else if(this.exception=='Pending Payments Collections'){

            this.typeExc=true;

        }else if(this.exception=='RUG / public registry of property Tollgate 1'){

            this.typeExc=true;

        }else if(this.exception=='Anti money laundry (AML)'){

            this.typeExc=true;

        }else if(this.exception=='Post-Funding Control Desk'){

            this.typeExc=true;

        }else if(this.exception=='Post-Funding Risk'){

            this.typeExc=true;

        }else if(this.exception=='Underwriting pre-funding requirements'){

            this.typeExc=true;

        }else{

            this.typeExc=false;

        }

        return this.typeExc;
    }

    handleChange(e) {
        this.value = e.detail.value;
    }
    
}