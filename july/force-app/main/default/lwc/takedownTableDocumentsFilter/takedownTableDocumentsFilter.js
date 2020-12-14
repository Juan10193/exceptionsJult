/**
 * @File Name          : takedownTableDocumentsFilter.js
 * @Description        : 
 * @Author             : eduardo.villegas@engeniumcapital.com
 * @Group              : 
 * @Last Modified By   : eduardo.villegas@engeniumcapital.com
 * @Last Modified On   : 18/10/2019 16:27:17
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    7/9/2019   eduardo.villegas@engeniumcapital.com     Initial Version
 **/
import { LightningElement, track, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { loadStyle } from 'lightning/platformResourceLoader';
//https://daneden.github.io/animate.css/
import Animate from  '@salesforce/resourceUrl/Animate';

export default class takedownTableDocumentsFilter extends LightningElement {
    @track options = [];
    @api values = [];

    @track openmodel = false;
    @track aminatedFunction = 'animated fadeInUp';

    get min() {
        return 1;
    }

    connectedCallback() {
        const items = [{ label: 'xml', value: 'xml' }, { label: 'pdf', value: 'pdf' }];

        this.options.push(...items);
        Promise.all([
            loadStyle(this, Animate)
        ]).then(() => { 'scripts cargadinos' });
    }
    openmodal() {
        this.openmodel = true
    }
    closeModal() {
        //this.aminatedFunction = 'animated fadeOutDown';
        this.dispatchEvent(new CustomEvent('closemodal'));
        //this.openmodel = false
    }
    handleChange(event) {
        this.values = event.detail.value;
    }
    saveMethod(event) {
        // eslint-disable-next-line no-console
        console.log('this.values ' + JSON.stringify(this.values));
        event.preventDefault();
        this.showNotification();
        this.dispatchEvent(new CustomEvent('setupfilter', { detail: this.values }));
    }
    showNotification() {
        const evt = new ShowToastEvent({
            title: 'save successful',
            message: 'The setup has been changed',
            variant: 'success',
        });
        this.dispatchEvent(evt);
    }
}