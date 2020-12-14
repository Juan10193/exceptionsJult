/**
 * @File Name          : tkd_checklistTollgate2.js
 * @Description        : 
 * @Author             : juandedios.hernandez@engeniumcapital.com
 * @Group              : 
 * @Last Modified By   : juandedios.hernandez@engeniumcapital.com
 * @Last Modified On   : 30/10/2019 16:21:50
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    25/10/2019   juandedios.hernandez@engeniumcapital.com     Initial Version
**/
import { LightningElement, track } from 'lwc';

export default class Tkd_checklistTollgate2 extends LightningElement {
    @track openmodel = false;

    


    openmodal() {
        this.openmodel = true
    }
    closeModal() {
        this.openmodel = false
    } 
    saveMethod() {
        
    }
}