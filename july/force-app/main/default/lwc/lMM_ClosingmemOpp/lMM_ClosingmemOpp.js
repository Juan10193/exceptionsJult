/**
 * @File Name          : lMM_ClosingmemOpp.js
 * @Description        : 
 * @Author             : angel87ambher@gmail.com
 * @Group              : 
 * @Last Modified By   : angel87ambher@gmail.com
 * @Last Modified On   : 1/6/2020 10:07:12
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    22/5/2020   angel87ambher@gmail.com     Initial Version
**/
import { LightningElement, wire, track, api } from 'lwc'; 
import { getRecord } from 'lightning/uiRecordApi';
import { loadScript, loadStyle } from 'lightning/platformResourceLoader';
import momentJs from '@salesforce/resourceUrl/momentJs';
import Animate from  '@salesforce/resourceUrl/Animate';
import mainsection from './lMM_ClosingmemOpp.html';
import getOpById from '@salesforce/apex/Data_Access_Opportunity_cls.getOpportunityById';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import {FILEOPP} from './fieldsOpHelper';
export default class lMM_ClosingmemOpp extends LightningElement {
    @api recordId;
    @track opportunity;
    @track cotizacion;
    @track error;
    @track tipoCredito;
    @track nameOpp;
    @track fechAprobacion;
    @track estatusOpp;
    @track uw;
    @track originador;
    @track vertical;
    @track grupoEconomico;
    @track nivelAprobacion;
    @track estatusAML;
    @track estatusRisk;
    @track moneda;
    @track multicurrency;
    @track monto;
    @track producto;
    @track quoteNameOpp;
    @track specialCondition;
    @track covCuanti;
    @track covQuali;
    @track covenans;
    @track nameCotizacion;
    @track monedaQuote;
    @track periodoGracia;
    @track tipoActivo;

    renderedCallback(){
        Promise.all([
            loadScript(this, momentJs),
            loadStyle(this, Animate)
        ]).then(() => { 'scripts cargadinos' });
        
    }

   @wire(getRecord,{recordId: '$recordId', fields: FILEOPP })
   wiredOpp({error, data}) {
        if (error) {
            let message = 'Unknown error';
            if (Array.isArray(error.body)) {
                message = error.body.map(e => e.message).join(', ');
            } else if (typeof error.body.message === 'string') {
                message = error.body.message;
            }
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error loading oppId',
                    message,
                    variant: 'error',
                }),
            );
        } else if (data) {
            try{
                this.opportunity = data.fields;
                this.opportunityId = data.id;
                this.tipoCredito = data.fields.LMM_Tipo_de_credito__c.value;
                this.nameOpp=data.fields.Name.value;
                this.fechAprobacion=data.fields.Approval_Date__c.value;
                this.estatusOpp= data.fields.StageName.value;
                this.nivelAprobacion= data.fields.Approval_Level__c.value;
                this.estatusAML= data.fields.LMM_Status_AML__c.value;
                this.estatusRisk= data.fields.LMM_Status_Risk__c.value;
                console.log('Data'+data);
                console.log('fecha'+this.fechAprobacion+'originador'+this.originador+'vertical'+this.vertical+'aml'+this.estatusAML+'risk'+this.estatusRisk);
            }catch(errcatch){
                console.log('error al cargar variables');
                console.error(errcatch);
            }}}
}