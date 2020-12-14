import { LightningElement, api, track } from 'lwc';
import pubsub from 'c/pubsubsimple' ; 

export default class LmmModalContactTypes extends LightningElement {
    @api contacType;
    @api reporteId;
    @api contactId;

    closeModal() {
        let message ={
            "message": 'modalclosed'
        }
        pubsub.fire('closecontactmodal', message);
        console.log('evento de cerado de modal fired');
    } 
    saveMethod() {

        
        this.closeModal();
    }

    get principalFunctionary(){
        if(this.contacType ==='Funcionario Principal'){
            return true;
        }else{
            return false;
        }
    }

    handleSubmit(event){
        event.preventDefault();
        this.template.querySelectorAll('lightning-input-field').forEach(element => {
            element.reportValidity();
        });
        console.log('submit contact')
        let campos = event.detail.fields;
        let message ={
            Id:this.contactId,
            Phone: campos.Phone,
            Title: campos.Title,
            LMM_Nombre_del_Contacto__c: campos.LMM_Nombre_del_Contacto__c,
            LMM_Ingresos__c: campos.LMM_Ingresos__c,
            LMM_A_os__c:campos.LMM_A_os__c,
            Email:campos.Email,
            LMM_Type_Reporte_Visita__c: this.contacType,
            LMM_RPYME_Name__c: campos.LMM_RPYME_Name__c
        }

            pubsub.fire('enviarcontact', message);
            const inputFields = this.template.querySelectorAll(
                'lightning-input-field'
            );
            if (inputFields) {
                inputFields.forEach(field => {
                    field.reset();
                });
            }

            this.closeModal();
    
        
    }

    handleSuccess(evt){
        pubsub.fire('actualizarcontact', evt);
        this.closeModal();
    }

   
}