/**
 * @File Name          : libreriasTest.js
 * @Description        : 
 * @Author             : eduardo.villegas@engeniumcapital.com
 * @Group              : 
 * @Last Modified By   : eduardo.villegas@engeniumcapital.com
 * @Last Modified On   : 26/12/2019 11:16:22
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    26/12/2019   eduardo.villegas@engeniumcapital.com     Initial Version
**/
import { LightningElement } from 'lwc';
import { loadScript, loadStyle } from 'lightning/platformResourceLoader';
import jquery341js from '@salesforce/resourceUrl/jquery341js';

export default class LibreriasTest extends LightningElement {
    async connectedCallback() {
        console.log('Inician las librerias');
        await Promise.all([
            loadScript(this, jquery341js)
        ]).then(() => {
            console.log('libreria iniciada');        
        }).catch(error => {
            // eslint-disable-next-line no-console
                console.log('Error');
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error loading resourse',
                        message: error.message,
                        variant: 'error',
                    }),
                );
            });
    }

    
}