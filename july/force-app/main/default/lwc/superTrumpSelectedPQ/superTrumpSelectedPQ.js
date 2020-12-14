/**
 * @File Name          : SuperTrumpSelectedPQ.js
 * @Description        : 
 * @Author             : eduardo.villegas@engeniumcapital.com
 * @Group              : 
 * @Last Modified By   : eduardo.villegas@engeniumcapital.com
 * @Last Modified On   : 21/10/2019 17:13:39
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    13/9/2019   eduardo.villegas@engeniumcapital.com     Initial Version
 **/
import { LightningElement, track, api, wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

/** SampleLookupController.search() Apex method */
import apexSearch from '@salesforce/apex/Takedown_CA_VS_ST_Controller_cls.search';
import savePQ from '@salesforce/apex/Takedown_CA_VS_ST_Controller_cls.savePQ';
import getPricings from '@salesforce/apex/Takedown_CA_VS_ST_Controller_cls.getPricings';

//import abortRequest from "@salesforce/apex/takedownTableDocumentsController_cls.abortRequest";
//https://daneden.github.io/animate.css/
import Animate from  '@salesforce/resourceUrl/Animate';
import { loadStyle } from 'lightning/platformResourceLoader';
import SuperTrumpIcon from '@salesforce/resourceUrl/SuperTrumpIcon';

export default class SuperTrumpSelectedPQ extends LightningElement {
    STIcon = SuperTrumpIcon; 
    @api recordId;
    // Use alerts instead of toast to notify user
    @api notifyViaAlerts = false;

    @track isMultiEntry = false;
    @track initialSelection = [
        //{ id: 'na', sObjectType: 'na', icon: 'standard:lightning_component', title: 'Inital selection', subtitle: 'Not a valid record' }
    ];
    @track errors = [];
    @track idPricing = "";

    connectedCallback() {
        Promise.all([
            loadStyle(this, Animate)
        ]).then(() => { 'scripts cargadinos' });
    }

    @wire(getPricings, { recordID: "$recordId" })
    wireRecord({ error, data }) {
        if (error) {
            this.dispatchEvent(new ShowToastEvent({
                title: 'Error to get Takedown CP',
                message: error,
                variant: 'error',
            }))
        } else if (data) {
            console.log('datos de tkcp ' + JSON.stringify(data));
            //this.TKD_pd_Takedown_CP = data.fields.TKD_ls_asset_type__c.value;
        }
    }

    handleLookupTypeChange(event) {
        //this.initialSelection = [];
        this.errors = [];
        this.isMultiEntry = event.target.checked;
    }

    handleSearch(event) {
        apexSearch(event.detail)
            .then(results => {
                this.template.querySelector('c-lookup').setSearchResults(results);
            })
            .catch(error => {
                this.notifyUser('Lookup Error', 'An error occured while searching with the lookup field.', 'error');
                // eslint-disable-next-line no-console
                console.error('Lookup error', JSON.stringify(error));
                this.errors = [error];
            });
    }

    handleSelectionChange() {
        this.errors = [];
    }

    handleSubmit() {
        this.checkForErrors();
        if (this.errors.length === 0) {
            savePQ({ takedownID: this.recordId, pqId: this.idPricing })
            .then(result => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success!!',
                        message: 'The pricing has been changed!!!',
                        variant: 'success',
                    }),
                );
                eval("$A.get('e.force:refreshView').fire();");
            }).catch(errores => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: "Error to upload invoices",
                        message: 'An error has ocurred during pricing update!!!',
                        variant: "error"
                    })
                );
            })
        }
    }

    checkForErrors() {
        const selection = this.template.querySelector('c-lookup').getSelection();
        console.log(' selection ' + JSON.stringify(selection));
        
        
        if (selection.length === 0) {
            this.errors = [
                { message: 'You must make a selection before submitting!' },
                { message: 'Please make a selection and try again.' }
            ];
        } else {
            this.idPricing = selection[0].id;
            console.log(' hit there ' + JSON.stringify(selection));
            this.errors = [];
        }
    }

    notifyUser(title, message, variant) {
        if (this.notifyViaAlerts) {
            // Notify via alert
            // eslint-disable-next-line no-alert
            alert(`${title}\n${message}`);
        } else {
            // Notify via toast
            const toastEvent = new ShowToastEvent({ title, message, variant });
            this.dispatchEvent(toastEvent);
        }
    }
}