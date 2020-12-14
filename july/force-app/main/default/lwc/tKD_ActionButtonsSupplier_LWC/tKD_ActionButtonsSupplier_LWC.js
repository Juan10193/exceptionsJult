/* eslint-disable no-eval */
/**
 * @File Name          : tKD_ActionButtons_LWC.js
 * @Description        : 
 * @Author             : angel87ambher@gmail.com
 * @Group              : 
 * @Last Modified By   : ChangeMeIn@UserSettingsUnder.SFDoc
 * @Last Modified On   : 09-17-2020
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    31/10/2019   angel87ambher@gmail.com     Initial Version
**/
import { LightningElement, api,wire, track} from 'lwc';
import actionAp from '@salesforce/apex/TkdActionsController.processApproval';
import main from './tKD_ActionButtonsSupplier_LWC.html';
import blank from './blank.html';
import vissible from '@salesforce/apex/TkdActionsController.handleVisibilityBtns'; 
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { getRecord } from 'lightning/uiRecordApi';

export default class TKD_ActionButtons_LWC extends LightningElement {
    @api recordId;
    @track visibilidad;
    @track section =main;
    @track takedown;
    @track comment;
    //modal
    @track openmodal = false;
    @track action;
    @track rejectAction = false;
    @track fecha;
    @track stageSupp;

    
    closeModal() {
        this.openmodal = false
    } 

    saveMethod() {
        this.handleApproval(this.action, this.comment);
        this.closeModal();
    }
    
    //end modal
    render(){
        return this.section;
    }

    @wire(getRecord, { recordId: '$recordId', fields: ['Supplier_in_approval__c.tkd_ls_Stage__c','Supplier_in_approval__c.Account_statement_date__c', 'Supplier_in_approval__c.tkd_ls_Stage_Supplier__c'] })
    getaccountRecord({ data, error }) {
        console.log('takedownRecord => ', data, error);
        if (data) {
            this.takedown = data;
            this.fecha = this.takedown.fields.Account_statement_date__c.value;
            console.log('Fecha aprovacion:' + this.fecha);
            this.stageSupp = this.takedown.fields.tkd_ls_Stage_Supplier__c.value;
            console.log('stage supp:' + this.stageSupp);
            this.processRelatedObjects();
        } else if (error) {
            console.error('ERROR => ', JSON.stringify(error)); // handle error properly
        }
    }

    processRelatedObjects() {
        console.log('processRelatedObjects for => ', JSON.stringify(this.takedown));
        // further processing like refreshApex or calling another wire service
        this.section =blank;
        this.section = main;
    }

    handleApproval(accion, comment) {
        let confirmFecha = true;
       if(accion ==="Approve" && this.stageSupp ==='IN PROCESS' && this.fecha ===null){
        confirmFecha = confirm("No se ha ingresado la fecha de Estado de cuenta, ¿Estas seguro de aprobar sin haberla seleccionado?, En caso de seleccionar OK la aprobación aplicará únicamente para este Takedown y en caso de requerirse para otro Takedown se deberá aprobar nuevamente");
       }
        console.log(comment);
        if(confirmFecha ===true){
                //call modal
                console.log(`Action ${accion}`)
                actionAp({recordId:this.recordId, action:accion, comment:comment})
                .then(result=>{
                    this.section =blank;
                    if(accion ==='Approve'){
                        this.dispatchEvent(
                            new ShowToastEvent({
                                title: 'Success Supplier',
                                message: 'Supplier approved Successfull',
                                variant: 'success',
                            }),
                        );
                        eval("$A.get('e.force:refreshView').fire();");
                        this.section = main;
                    }else if(accion ==='Reject'){
                        this.dispatchEvent(
                            new ShowToastEvent({
                                title: 'Success Supplier',
                                message: 'Supplier has been Rejected',
                                variant: 'success',
                            }),
                        );
                        eval("$A.get('e.force:refreshView').fire();");
                        this.section = main;
                    }else{
                        this.dispatchEvent(
                            new ShowToastEvent({
                                title: 'Success Supplier',
                                message: 'Supplier Recalled Successfull',
                                variant: 'success',
                            }),
                        );
                        eval("$A.get('e.force:refreshView').fire();");
                        this.section = main;
                    }
                    
                })
                .catch(error=>{
                    console.log(error);
                })

        }
    
    
    }

    get visibility(){

        vissible({recordId:this.recordId})
        .then(async result=>{
            console.log(result);
            this.visibilidad =await result
            
        }).catch(error=>{
            console.log('error al cargar botones de approvacion:');
            console.log(error);
        })

        return this.visibilidad;
    }

    captureComment(event){
        let com = event.target.value;
        this.comment = com;
    }

    abreModal(event){
        this.openmodal = true;
        console.log('MODAL ABIERTO')
        this.action = event.target.dataset.action;
        console.log(JSON.stringify(this.action));
        if(this.action === 'Reject'){
            this.rejectAction = true;
        } else {
            this.rejectAction = false;
        }
        console.log('rejectAction ' + this.rejectAction);

    }
}