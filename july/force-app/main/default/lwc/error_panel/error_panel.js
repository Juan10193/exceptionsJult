import { LightningElement, api } from 'lwc';
 
export default class Error_panel extends LightningElement {
    @api errors;
    @api istruerror;
}