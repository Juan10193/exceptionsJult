/**
 * @description       : 
 * @author            : angel87ambher@gmail.com
 * @group             : 
 * @last modified on  : 08-07-2020
 * @last modified by  : angel87ambher@gmail.com
 * Modifications Log 
 * Ver   Date         Author                    Modification
 * 1.0   08-07-2020   angel87ambher@gmail.com   Initial Version
**/
import { LightningElement, track, api} from 'lwc';
import Animate from  '@salesforce/resourceUrl/Animate';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { loadStyle } from 'lightning/platformResourceLoader';


export default class ModalScorecard extends LightningElement {

    @api title;
    @api height = 'height: 640px;';
    //@api subTitle;
    //@api body;
    @api disableCloseButton = false
    @api closeButtonName;
    @api disableAcceptButton = false
    @api acceptButtonName;
    //Puedes añadir esto de ejemplo: slds-modal slds-fade-in-open animated fadeInRight slds-modal_large
    @api initModalClass = 'slds-modal slds-fade-in-open animated fadeInRight';
    
    @track approvalComments

    connectedCallback() {
        Promise.all([
            loadStyle(this, Animate)
        ])
        .then(console.log('Succes to loading resourse'))
        .catch(error => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error loading resourse',
                    message: error.message,
                    variant: 'error',
                }),
            );
        });        
    }

    closeModal(event) {
        // Prevents the anchor element from navigating to a URL.
        event.preventDefault()

        // Creates the event with the contact ID data.
        const closeEvent = new CustomEvent('close')

        // Dispatches the event.
        this.dispatchEvent(closeEvent)         
    } 
    acceptModal(event) {
        // Prevents the anchor element from navigating to a URL.
        event.preventDefault()
        
        let eventDetail = {approvalComments:this.approvalComments}
        // Creates the event with the contact ID data.
        const closeEvent = new CustomEvent('accept',{ detail: eventDetail })

        // Dispatches the event.
        this.dispatchEvent(closeEvent)         
    } 

    @api
    makeModalSmall(){
        this.initModalClass = this.initModalClass + ' slds-modal_small'
    }

    @api
    makeModalMedium(){
        this.initModalClass = this.initModalClass + ' slds-modal_medium'
    }

    @api makeModalLarge(){
        this.initModalClass = this.initModalClass + ' slds-modal_large'
    }
    
}