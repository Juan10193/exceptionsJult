import { LightningElement,api } from 'lwc';
import Id from '@salesforce/user/Id';
export default class Aml_review_scm_lwc extends LightningElement {
    @api userId = Id;
    @api coment;
    @api nuevoCom;

    connectedCallback(){
        if(this.coment.ownerId === this.userId){
            console.log('ownerId: ' + this.coment.ownerId)
            console.log('userId: '+ this.userId);
        const selectedEvent = new CustomEvent('changecom', { detail: true});
        this.dispatchEvent(selectedEvent);
        }else if(this.coment.ownerId !== this.userId){
            console.log('ownerId: ' + this.coment.ownerId)
            console.log('userId: '+ this.userId);
            const selectedEvent = new CustomEvent('changecom', { detail: false});
        this.dispatchEvent(selectedEvent);
        }
    }
    
    
}