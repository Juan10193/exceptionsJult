/* eslint-disable no-console */
import { LightningElement, api, wire, track } from 'lwc';
import submitforApp from '@salesforce/apex/TkdActionsController.submitForApproval';
import updateTakedown from '@salesforce/apex/tkdActionsWithoutSharing.updateTakedown';
import recallApprovalProcess from '@salesforce/apex/tkdActionsWithoutSharing.recallApprovalProcess';


import main from './tkd_SubmitForApproval.html';
import blank from './blank.html';
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import { updateRecord } from 'lightning/uiRecordApi';
import CPL_ck_Delay_Funding from '@salesforce/schema/Takedowns_Contingency_plan__c.CPL_ck_Delay_Funding__c';
import ID_FIELD from '@salesforce/schema/Takedowns_Contingency_plan__c.Id';





export default class Tkd_SubmitForApproval extends LightningElement {
  @api recordId;
  @track section = main;

  @api currentStep

  handleClick() {
    console.log('this.currentStep ' + this.currentStep)
    switch (this.currentStep) {
      case 'standar':
        console.log('Se ha seleccionado un proceso de aprobación estandar');
        this.submitForApprovalStandar()
        break;
      case 'tkd-delayFunding':
        console.log('Se ha seleccionado un proceso de aprobación de delay Funding');
        this.submitForApprovalDelayFunding()
        break;
      default:
        console.log('Lo lamentamos, por el momento no disponemos de ' + expr + '.');
    }
  }

  async submitForApprovalStandar() {
    try {
      this.section = blank;
      await submitforApp({ recordId: this.recordId });
      this.section = main;
      this.dispatchEvent(
        new ShowToastEvent({
          title: "Sucees",
          message: 'The record has been submited for approval',
          variant: "success"
        })
      );
    } catch (error) {
      console.log('error al enviar a aprovacion: ' + JSON.stringify(error));
      console.log(error);
      this.dispatchEvent(
        new ShowToastEvent({
          title: "Fail",
          message: 'Submision Failed' + JSON.stringify(error.body.pageErrors[0].message),
          variant: "error"
        })
      );
    } finally {
      this.section = main;
    }

  }
  async submitForApprovalDelayFunding() {
    let Takedowns_Contingency_plan__c = {
      Id: this.recordId,
      CPL_ck_Delay_Funding__c: true
    };
    try {
      await updateTakedown({Takedowns_Contingency_plan:Takedowns_Contingency_plan__c})
      this.dispatchEvent(
        new ShowToastEvent({
          title: 'Success',
          message: 'El registro ha sido actualizado',
          variant: 'success'
        })
      );
    } catch (error) {
      console.error('Error to update takedown ' + JSON.stringify(error))
      this.dispatchEvent(
        new ShowToastEvent({
          title: 'Error al intentar actualizar el registro',
          message: error,
          variant: 'error'
        })
      );
    }
    try {
      await recallApprovalProcess({ recordId: this.recordId })
      this.dispatchEvent(
        new ShowToastEvent({
          title: 'Success',
          message: 'El proceso de aprobación actual se ha puesto en recall, y se ha enviado a aprobación nuevamente sobre el proceso de delay funding',
          variant: 'success'
        })
      );
    } catch (error) {
      console.error('recall error ' + JSON.stringify(error))
      this.dispatchEvent(
        new ShowToastEvent({
          title: 'Error al intentar poner el proceso de aprobación en recall',
          message: error,
          variant: 'error'
        })
      );
    }
  }



}