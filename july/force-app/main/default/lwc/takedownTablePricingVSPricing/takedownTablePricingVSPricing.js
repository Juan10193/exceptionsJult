/**
 * @File Name          : takedownTablePricingVSPricing.js
 * @Description        : 
 * @Author             : eduardo.amiens@outlook.com
 * @Group              : 
 * @Last Modified By   : eduardo.amiens@outlook.com
 * @Last Modified On   : 15/11/2019 1:04:57
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    26/9/2019   eduardo.amiens@outlook.com     Initial Version
**/

import { LightningElement, wire, track, api } from "lwc";
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { loadStyle } from 'lightning/platformResourceLoader';
import getPricingVSPricing from "@salesforce/apex/Takedown_CA_VS_ST_Controller_cls.getPricingVSPricing";
import { refreshApex } from '@salesforce/apex';

import apexSearch from '@salesforce/apex/Takedown_CA_VS_ST_Controller_cls.search';
import savePQ from '@salesforce/apex/Takedown_CA_VS_ST_Controller_cls.savePQ';
import getPricings from '@salesforce/apex/Takedown_CA_VS_ST_Controller_cls.getPricings';
import getApprovedPricings from '@salesforce/apex/Takedown_CA_VS_ST_Controller_cls.getApprovedPricings';
import { getRecord } from 'lightning/uiRecordApi';

//import abortRequest from "@salesforce/apex/takedownTableDocumentsController_cls.abortRequest";
//https://daneden.github.io/animate.css/
import Animate from '@salesforce/resourceUrl/Animate';
import SuperTrumpIcon from '@salesforce/resourceUrl/SuperTrumpIcon';
import constantes from './helperJS/constantes';
import blank from './views/blank.html';
import mainpage from './takedownTablePricingVSPricing.html';

export default class TakedownTablePricingVSPricing extends LightningElement {
    @track data;
    STIcon = SuperTrumpIcon;
    @api recordId;
    @track columns = constantes.COLUMNAS;
    // @track capricing;

    // Use alerts instead of toast to notify user
    @api notifyViaAlerts = false;

    @track isMultiEntry = false;
    @track initialSelection = [
        //{ id: 'na', sObjectType: 'na', icon: 'standard:lightning_component', title: 'Inital selection', subtitle: 'Not a valid record' }
    ];
    @track errors = [];
    @track idPricing = "";
    @track Takedown_CA_VS_ST_Wrapper;
    @track linkCA;
    @track _wiredData;
    @track section = mainpage;
    @track avaiblePricings

    connectedCallback() {
        Promise.all([
            loadStyle(this, Animate)
        ]).then(() => { 'scripts cargadinos' });
    }
    
    @wire (getPricings,{ recordId: "$recordId"})
    async pricingCABooking(result) {    
        this._wiredData = result;
        if (result.data) {            
            console.log('JSON.stringify(result)1 ' + JSON.stringify(result));
            this.Takedown_CA_VS_ST_Wrapper = result.data;
                this.linkCA = '/' + this.Takedown_CA_VS_ST_Wrapper.cA_Wrapper.creditApprovalId;
                if(this.Takedown_CA_VS_ST_Wrapper.sT_Wrapper.pricingcreditApprovalId){
                    this.initialSelection = [
                        { id: this.Takedown_CA_VS_ST_Wrapper.sT_Wrapper.pricingcreditApprovalId, sObjectType: '', icon: 'standard:lightning_component', title: this.Takedown_CA_VS_ST_Wrapper.sT_Wrapper.pricingName, subtitle: '' }
                    ];
                }
        }
        console.log('constantes.FIELDS_TO_GET_RECORD ' + constantes.FIELDS_TO_GET_RECORD)
    }

    @wire(getPricingVSPricing, { recordId: "$recordId" })
    capricing;

    @wire(getRecord, { recordId: "$recordId", fields: constantes.FIELDS_TO_GET_RECORD })
    async wireRecord(result) {
        console.log('result ' + JSON.stringify(result))
        if (await result.data) {           
            this.avaiblePricings = await getApprovedPricings({opportunityID:result.data.fields.CPL_rb_Opp__c.value})    
            console.log('this.avaiblePricings ' + JSON.stringify(this.avaiblePricings))
        }
    }

    handleLookupTypeChange(event) {
        this.initialSelection = [];
        this.errors = [];
        this.isMultiEntry = event.target.checked;
    }

    handleSearch(event) {
        console.log('event.detail ' + JSON.stringify(event.detail))
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

    async handleSubmit() {
        this.checkForErrors();
        if (this.errors.length === 0) {
            this.section = blank;
            await savePQ({ takedownID: this.recordId, pqId: this.idPricing })
                .then(result => {

                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Success!!',
                            message: 'The pricing has been changed!!!',
                            variant: 'success',
                        }),
                    );
                    refreshApex(this._wiredData);
                    refreshApex(this.capricing);

                }).catch(errores => {
                    console.log('errores ' + JSON.stringify(errores));
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: "Error to upload invoices",
                            message: 'An error has ocurred during pricing update!!!',
                            variant: "error"
                        })
                    );
                })
            this.section = mainpage;
        }
    }

    checkForErrors() {
        const selection = this.template.querySelector('c-lookup').getSelection();
        console.log(' selection ' + JSON.stringify(selection));
        console.log(' this.initialSelection ' + JSON.stringify(this.initialSelection));


        if (selection.length === 0 & this.initialSelection.length > 0) {
            this.idPricing = null;
            this.errors = [];
            this.initialSelection = [];
            console.log('here');
        } else if (selection.length === 0 & this.initialSelection.length === 0) {
            this.errors = [
                { message: 'You must make a selection before submitting!' },
                { message: 'Please make a selection and try again.' }
            ];
        } else {
            this.idPricing = selection[0].id;
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
    openDocument(documentId) {
        window.open('/' + documentId, '_blank');
    }
    render() {
        return this.section;
    }
}