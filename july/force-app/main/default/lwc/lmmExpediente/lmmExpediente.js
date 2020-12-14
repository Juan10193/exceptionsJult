/**
 * @description       : 
 * @author            : eduardo.amiens@outlook.com
 * @group             : 
 * @last modified on  : 08-19-2020
 * @last modified by  : eduardo.amiens@outlook.com
 * Modifications Log 
 * Ver   Date         Author                       Modification
 * 1.0   08-19-2020   eduardo.amiens@outlook.com   Initial Version
**/
//Juand
import { LightningElement, track, api } from 'lwc';

export default class LmmExpediente extends LightningElement {
    //Datos del Objeto y registro
    @api objectApiName;
    @api recordId;
    @api propertyUsedIn

    @track showKYC = false


    @track activeSections = [
        "Estructura",
    ];

    connectedCallback() {
        console.log('propertyUsedIn ' + this.propertyUsedIn)
    switch (this.propertyUsedIn) {
      case 'LMM':
        console.log('LMM');
        this.showKYC = true
          break;
      case 'workoutAlivios':
        console.log('workoutAlivios');
        this.showKYC = false
        break;
      default:
    }
    }
    
}