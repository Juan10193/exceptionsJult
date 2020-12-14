/**
 * @File Name          : lmmClosingmemOpp.js
 * @Description        : 
 * @Author             : angel87ambher@gmail.com
 * @Group              : 
 * @Last Modified By   : angel87ambher@gmail.com
 * @Last Modified On   : 12/6/2020 0:39:48
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    9/6/2020   angel87ambher@gmail.com     Initial Version
**/
import { LightningElement, wire, track, api } from 'lwc'; 
import { getRecord } from 'lightning/uiRecordApi';
import { loadScript, loadStyle } from 'lightning/platformResourceLoader';
import momentJs from '@salesforce/resourceUrl/momentJs';
import Animate from  '@salesforce/resourceUrl/Animate';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import {FILEOPP} from './fieldsOpHelper';
import fetchCovenants from '@salesforce/apex/Data_Access_ConditionServiceCoventant.getCSC'
import getQuotesByOpId from '@salesforce/apex/Data_Acess_EC_Quote.getQuotesByOpId2'
import entsIncaOp from '@salesforce/apex/Data_Access_Entities_Oportunidad.entitiesInOp';



export default class LmmClosingmemOpp extends LightningElement {

    @api recordId;
    @track ecQuote;
    @track opportunity;
    @track opportunityId;
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
    @track quoteNameOpp;
    @track specialCondition;
    @track covCuanti;
    @track covQuali;
    @track covenans;
    @track entitysEstructure;



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
                this.originador = data.fields.Owner.displayValue;
                this.vertical = data.fields.OPP_ls_Vertical__c.value;
                this.uw = data.fields.LMM_Underwriter__r.displayValue;
                this.quoteNameOpp = data.fields.EC_Quote__c.value;
                console.log('Data'+data);
                console.log('Quote'+ this.opportunityId);
            }catch(errcatch){
                console.log('error al cargar variables');
                console.error(errcatch);
            }

            this.getEcQuoteInOpp()
            .then(res =>{
                this.ecQuote = res;
                console.log('ECQUOTE'+this.ecQuote);
            }).catch(er=>{
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error al consultar las cotizaciones en la Opp',
                        message: '' +  er,
                        variant: 'error',
                        mode:'sticky'
                    }),
                );
            })

             this.getEntitiesInOpp()
            .then(res =>{
                this.entitysEstructure = res;
               // this.entitysEstructure = this.entitysEstructure.map(item=>({...item, beneficial:item.ES2_ms_Role__c.includes('Beneficial Owner')?1:0, legalDepositary:item.ES2_ms_Role__c.includes('Legal Depositary')?1:0}));
                console.log('entidadesInOpp');
                console.log(this.entitysEstructure);
            }).catch(er=>{
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error al consultar Las Entidades In Opp',
                        message: '' +  er,
                        variant: 'error',
                        mode:'sticky'
                    }),
                );
            })

            this.getCovenans()
            .then(resultCove=>{
                this.covenans = [...resultCove].filter(({RecordType})=>{ return RecordType.Name.includes('Condition') !== true})
                console.log('Covenans');
                console.log(this.covenans);
                this.specialCondition = [...resultCove].filter(({RecordType})=>{return RecordType.Name.includes('Condition') === true})
                this.specialCondition = this.specialCondition.map((val, index)=>{
                    let ES3_tx_Coments__c = val.ES3_tx_Coments__c;
                    if(ES3_tx_Coments__c === '' || ES3_tx_Coments__c === null || ES3_tx_Coments__c===undefined ){
                        val.ES3_tx_Coments__c ='';
                    }
                    val.specialCondition = val.ES3_lst_Condition__c + '; ' + val.ES3_lt_Timing__c + '; ' + val.ES3_TXT_Description__c + ' ' + val.ES3_tx_Coments__c +'\n';
                    return val;
                })
                this.covQuali = this.covenans.filter(({RecordType})=>{return RecordType.Name.includes('Qualitative')===true});
                this.covQuali = this.covQuali.map((val,index)=>{
                    if(val.ES3_LST_Covenant_Cualitativo__c !==null & val.ES3_LST_Covenant_Cualitativo__c !==undefined & val.ES3_LST_Covenant_Cualitativo__c!==''){
                        if(val.ES3_tx_Coments__c ==='' || val.ES3_tx_Coments__c ===null || val.ES3_tx_Coments__c===undefined){
                            val.ES3_tx_Coments__c ='';
                        }
                        val.covenantCualitativo = val.ES3_TXT_Threshold__c + '; ' + val.ES3_LT_Timing_Cualitativo__c + '; ' + val.ES3_LST_Covenant_Cualitativo__c + '; ' + val.ES3_tx_Coments__c +'\n';
                        if(val.ES3_rb_Entity__c !==null & val.ES3_rb_Entity__c!==undefined & val.ES3_rb_Entity__c!==''){
                            val.covenantCualitativo =val.covenantCualitativo + val.ES3_rb_Entity__r.Name +'\n';
                        }
                    }

                    return val;
                })
                this.covCuanti = this.covenans.filter(({RecordType})=>{return RecordType.Name.includes('Quantitative')===true}).map((val,index)=>{
                    if(val.ES3_lst_Covenant_Cuantitativo__c !=='' & val.ES3_lst_Covenant_Cuantitativo__c!==null & val.ES3_lst_Covenant_Cuantitativo__c!==undefined){
                        if(val.ES3_tx_Coments__c ==='' || val.ES3_tx_Coments__c===null || val.ES3_tx_Coments__c===undefined){
                            val.ES3_tx_Coments__c = '';
                        }
                        val.covenantCuantitativo = val.ES3_LT_Min_Max__c + '; ' +  val.ES3_TXT_Threshold__c + '; ' + val.ES3_LT_Timing_Cuantitativo__c + '; ' + val.ES3_lst_Covenant_Cuantitativo__c + '; ' +val.ES3_tx_Coments__c +'\n';
                        if(val.ES3_rb_Entity__c !==null & val.ES3_rb_Entity__c!=='' & val.ES3_rb_Entity__c!==undefined){
                            val.covenantCuantitativo = val.covenantCuantitativo + val.ES3_rb_Entity__r.Name +'\n';
                        }
                    }
                    return val;
                })
            }).catch(errorCove=>{
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error al consultar los covenans de la Opportunidad',
                        message: '' +  JSON.stringify(errorCove),
                        variant: 'error',
                        mode:'sticky'
                    }),
                );
            })

        }}

        
    getEcQuoteInOpp(){
    return new Promise((resolve, reject) => {
        getQuotesByOpId({opportunityId: this.opportunityId})
        .then(result =>{
            resolve(result);
        }).catch(error=>{
            reject(new Error(JSON.stringify(error)));
        })
    });          
}

    getEntitiesInOpp(){
        return new Promise((resolve, reject) => {
            entsIncaOp({opportunityId: this.opportunityId})
            .then(result =>{
                resolve(result);
            }).catch(error=>{
                reject(new Error(JSON.stringify(error)));
            })
        });          
    }


    getCovenans(){
        return new Promise((resolve, reject) => {
            fetchCovenants({opportunityId: this.opportunityId})
            .then(result=>{
                resolve(result);
            }).catch(error=>{
                reject(new Error(JSON.stringify(error)));
            })
        });
    }


}