/* eslint-disable no-console */
/**
 * @File Name          : tkd_ClosingMemo.js
 * @Description        : 
 * @Author             : juandedios.hernandez@engeniumcapital.com
 * @Group              : 
 * @Last Modified By   : ChangeMeIn@UserSettingsUnder.SFDoc
 * @Last Modified On   : 09-21-2020
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    21/10/2019   juandedios.hernandez@engeniumcapital.com     Initial Version
**/
import { LightningElement, wire, track, api } from 'lwc'; 
import { getRecord } from 'lightning/uiRecordApi';
import { loadScript, loadStyle } from 'lightning/platformResourceLoader';
import momentJs from '@salesforce/resourceUrl/momentJs';
import Animate from  '@salesforce/resourceUrl/Animate';
import blank from './blank.html';
import mainsection from './tkd_ClosingMemo.html';
import getOpById from '@salesforce/apex/Data_Access_Opportunity_cls.getOpportunityById';
import  getcaBypcaId from '@salesforce/apex/TKD_ClosingMemoFull.getCredutApprovalbyOpId';
import fetchPQ from '@salesforce/apex/TKD_ClosingMemoFull.fecthPricingPQ';
import fetchpricingCA from '@salesforce/apex/TKD_ClosingMemoFull.fetchPricingInCA';
import fetCovenants from '@salesforce/apex/TKD_ClosingMemoFull.fetchCovenants';
import entsIncaOp from '@salesforce/apex/Data_Access_EntityMastInCApproval_cls.entitiesInCaOp';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
const FIELDS = ['Takedowns_Contingency_plan__c.CPL_rb_Opp__c', 'Takedowns_Contingency_plan__c.CPL_rb_Opp__r.Name', 'Takedowns_Contingency_plan__c.TKD_rb_Pricin_CA__r.ES3_fm_Pricing_Super_Trump__c'];

export default class Tkd_ClosingMemo extends LightningElement {
    @api recordId;
    @track cA;
    @track opportunityId;
    @track oppName;
    @track opportunity;
    @track entitysEstructure;
    @track pricingPQName;
    @track pricingPQ;
    @track pricingInCaId;
    @track pricingInCa;
    @track specialCondition;
    @track covCuanti;
    @track covQuali;
    @track covenans;

    @track section = blank;

    renderedCallback(){
        Promise.all([
            loadScript(this, momentJs),
            loadStyle(this, Animate)
        ]).then(() => { 'scripts cargadinos' });
        
    }

    render(){

        return this.section;
    }

   @wire(getRecord,{recordId: '$recordId', fields: FIELDS })
   wiredTakedown({error, data}) {
        if (error) {
            let message = 'Unknown error';
            if (Array.isArray(error.body)) {
                message = error.body.map(e => e.message).join(', ');
            } else if (typeof error.body.message === 'string') {
                message = error.body.message;
            }
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error loading takedown oppId',
                    message,
                    variant: 'error',
                }),
            );
        } else if (data) {
            try{
                this.opportunityId = data.fields.CPL_rb_Opp__c.value;
                this.oppName = data.fields.CPL_rb_Opp__r.displayValue;
                console.log('elcampo')
                console.log(data.fields.TKD_rb_Pricin_CA__r);
                
                this.pricingPQName = data.fields.TKD_rb_Pricin_CA__r.value.fields.ES3_fm_Pricing_Super_Trump__c.value;
                console.log(`Nombre del PQ: ${this.pricingPQName}`);
                this.pricingInCaId = data.fields.TKD_rb_Pricin_CA__r.value.id;
            }catch(errcatch){
                console.log('error al cargar variables');
                console.error(errcatch);
            }
            this.getEntitiesIncaOpp()
            .then(res =>{
                this.entitysEstructure = res;
                this.entitysEstructure = this.entitysEstructure.map(item=>({...item, beneficial:item.ES2_ms_Role__c.includes('Beneficial Owner')?1:0, legalDepositary:item.ES2_ms_Role__c.includes('Legal Depositary')?1:0}));
                console.log('entidadesInca');
                console.log(this.entitysEstructure);
            }).catch(er=>{
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error al consultar Las Entidades In CA',
                        message: '' +  er,
                        variant: 'error',
                        mode:'sticky'
                    }),
                );
            })
            getcaBypcaId({opportunityId: this.pricingInCaId} )
            .then(async result =>{
                await this.getOpportunity()
                    .then(resultt=>{
                        this.opportunity = resultt;
                        console.log(this.opportunity);
                    }).catch(errorfail=>{
                        this.dispatchEvent(
                            new ShowToastEvent({
                                title: 'Error al consultar el CA de la Opportunidad',
                                message: '' +  JSON.stringify(errorfail),
                                variant: 'error',
                                mode:'sticky'
                            }),
                        );
                    })
                await this.getPricingPQ()
                .then(resultpq=>{
                    this.pricingPQ = resultpq;
                    console.log('PQ');
                    console.log(this.pricingPQ)
                }).catch(errpq=>{
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Error al consultar el Pricing PQ',
                            message: '' +  JSON.stringify(errpq),
                            variant: 'error',
                            mode:'sticky'
                        }),
                    );
                })

                await this.getPricingInCA()
                .then(resultPCA=>{
                    this.pricingInCa = resultPCA;
                    console.log('PRICING IN CA');
                    console.log(this.pricingInCa);
                }).catch(errPca=>{
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Error al consultar el Pricing In CA',
                            message: '' +  JSON.stringify(errPca),
                            variant: 'error',
                            mode:'sticky'
                        }),
                    );
                })

                await this.getCovenans()
                .then(resultCove=>{
                    this.covenans = [...resultCove].filter(({RecordType})=>{ return RecordType.Name.includes('Condition') !== true})
                    console.log('Covenans');
                    console.log(this.covenans);
                    this.specialCondition = [...resultCove].filter(({RecordType})=>{return RecordType.Name.includes('Condition') === true})
                    console.log('specchal conditio')
                    console.log(this.specialCondition);
                    this.specialCondition = this.specialCondition.map((val, index)=>{
                        let ES3_tx_Coments__c = val.ES3_tx_Coments__c;
                        if(ES3_tx_Coments__c === '' || ES3_tx_Coments__c === null || ES3_tx_Coments__c===undefined ){
                            val.ES3_tx_Coments__c ='';
                        }
                        val.specialCondition = val.ES3_lst_Condition__c + '; ' + val.ES3_lt_Timing__c + '; ' + val.ES3_TXT_Description__c + ' ' + val.ES3_tx_Coments__c +'\n';
                        return val;
                    })
                    console.log('specchal conditiofiltered')
                    console.log(this.specialCondition);
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
                    console.log('Qualitativo')
                    console.log(this.covQuali);
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
                    console.log('Quantitativo');
                    console.log(this.covCuanti);
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
                this.cA = result;
                this.cA.srUnderwriter = this.cA.Sr_Underwriter__r.FirstName +' ' + this.cA.Sr_Underwriter__r.LastName;
                this.cA.originador = `${this.cA.CPL_rb_account__r.Owner.FirstName} ${this.cA.CPL_rb_account__r.Owner.LastName}`;
                this.cA.uw = this.cA.Risk_Analyst__r.Name;
                if(this.cA.Type_of_credit_approval__c ==='New'){
                    this.cA.Type_of_credit_approval__c ='Full Underwriting';
                }
                console.log('el ca');
                console.log(this.cA);
                this.section = mainsection;
            }).catch(errors=>{
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error al consultar el CA de la Opportunidad',
                        message: '' +  JSON.stringify(errors),
                        variant: 'error',
                        mode:'sticky'
                    }),
                );
            })

            
        }
   }

   getEntitiesIncaOpp(){
        return new Promise((resolve, reject) => {
            entsIncaOp({opportunityId: this.opportunityId})
            .then(result =>{
                resolve(result);
            }).catch(error=>{
                reject(new Error(JSON.stringify(error)));
            })
        });          
   }


    getOpportunity(){
       return new Promise((resolve, reject) => {
           getOpById({opportunityId:this.opportunityId})
           .then(result=>{
               resolve(result);
           }).catch(error=>{
               reject(new Error (JSON.stringify(error)));
           })
       });
   }

   getPricingPQ(){
       return new Promise((resolve, reject) => {
           fetchPQ({pqName:this.pricingPQName})
           .then(result=>{
               resolve(result)
           }).catch(error=>{
               reject(new Error(JSON.stringify(error)));
           })
       });
   }

   getPricingInCA(){
        return new Promise((resolve, reject) => {
            fetchpricingCA({pricingInCaId:this.pricingInCaId})
            .then(result=>{
                resolve(result);
            }).catch(error=>{
                reject(new Error(JSON.stringify(error)));
            })
        });
   }

   getCovenans(){
       return new Promise((resolve, reject) => {
           fetCovenants({opportunityId: this.opportunityId})
           .then(result=>{
               resolve(result);
           }).catch(error=>{
               reject(new Error(JSON.stringify(error)));
           })
       });
   }


   get openingFee(){
       let opfe;
       if(this.pricingInCa.ES3_pc_Opening_Fee__c !==null & this.pricingInCa.ES3_pc_Opening_Fee__c !=='' & this.pricingInCa.ES3_pc_Opening_Fee__c !==undefined){
            opfe= this.pricingInCa.ES3_pc_Opening_Fee__c;
       }else{
           opfe = this.pricingPQ.Opening_Fee 
       }

       return opfe;
   }

   get sd(){
       let sdM;
       if(this.pricingInCa.ES3_num_SD__c !==null & this.pricingInCa.ES3_num_SD__c !=='' & this.pricingInCa.ES3_num_SD__c !==undefined){
           sdM =this.pricingInCa.ES3_num_SD__c 
       }else{
           sdM = this.pricingPQ.Security_Deposit;
       }
       return sdM;
   }

   get ratePercent(){
       let rtp;
       if(this.pricingInCa.ES3_pc_Rate__c ===null || this.pricingInCa.ES3_pc_Rate__c ==='' || this.pricingInCa.ES3_pc_Rate__c ===undefined){

        if(this.pricingPQ.IST_TemplateName ==='EC Quasi Lease'){
            rtp =this.pricingPQ.Full_Term_Rate;
        }else if(this.pricingPQ.IST_TemplateName !=='EC Loan'){
            rtp = this.pricingPQ.FulltermRatewithresidual;
        }else{
            rtp = this.pricingPQ.IST_Lending_Rate
        }
    }else{
        rtp = this.pricingInCa.ES3_pc_Rate__c;
    }
       return rtp;
   }

   get rvpercent(){
       let product;
       let rvp;

       if(this.pricingPQ.IST_TemplateName ==='EC Loan'){
           product = 'Term Loan';
           console.log(`PRODUCT: ${product}`);
       }else{
           try{
            product = this.pricingPQ.IST_TemplateName.substring(3, this.pricingPQ.IST_TemplateName.length +1);
            console.log(`PRODUCT: ${product}`);
           }catch(error){
               console.log('EL PQ NO TIENE TEMPLATE')
               console.log(error);
           } 
       }

       if(product !== undefined){
        if(this.pricingInCa.ES3_pc_RV__c ===null || this.pricingInCa.ES3_pc_RV__c ==='' ||this.pricingInCa.ES3_pc_RV__c ===undefined){
            if(product.includes('True') || product.includes('Fleet') || product.includes('TF')){
                 rvp = this.pricingPQ.Residual_Value;
                 console.log('EL RESIDUL : ' + rvp)
                 return rvp;
            }
        }else{
            rvp = this.pricingInCa.ES3_pc_RV__c;
            return rvp;
        }
       }

       return null;
   }

   get ballon(){
       let ball;
       if(this.pricingInCa.ES3_num_Ballon_Bullet_Payment__c===null || this.pricingInCa.ES3_num_Ballon_Bullet_Payment__c==='' || this.pricingInCa.ES3_num_Ballon_Bullet_Payment__c===undefined){
           ball = this.pricingPQ.IST_Balloon;
       }else{
           ball = this.pricingInCa.ES3_num_Ballon_Bullet_Payment__c;
       }

       return ball;
   }

   get poptionPrecent(){
       let product;
       let po;

       if(this.pricingPQ.IST_TemplateName ==='EC Loan'){
        product = 'Term Loan';
        console.log(`PRODUCT: ${product}`);
    }else{
        try{
            product = this.pricingPQ.IST_TemplateName.substring(3, this.pricingPQ.IST_TemplateName.length +1);
            console.log(`PRODUCT: ${product}`);
        }catch(error){
            console.log('EL PQ NO TIENE TEMPLATE')
            console.log(error);
        }
        
    }
        if(product !== undefined){
            if(this.pricingInCa.ES3_pc_P_Option__c ===null || this.pricingInCa.ES3_pc_P_Option__c ==='' || this.pricingInCa.ES3_pc_P_Option__c === undefined){
                if(product.includes('Quasi')){
                    po = this.pricingPQ.Residual_Value;
                    return po;
                }else{
                    po = '';
                    return po;
                }
            }else{
                po = this.pricingInCa.ES3_pc_P_Option__c;
                console.log('pricing ca :' + this.pricingInCa.ES3_pc_P_Option__c )
                return po;
            }
        }
       

      
       return null;
   }
   
   get terminMonthsIncludingPP(){
       let pp;
        if(this.pricingInCa.ES3_pc_Term_in_Months__c === null || this.pricingInCa.ES3_pc_Term_in_Months__c==='' || this.pricingInCa.ES3_pc_Term_in_Months__c===undefined){
            pp = this.pricingPQ.IST_Term;
        }else{
            pp = this.pricingInCa.ES3_pc_Term_in_Months__c;
        }
        return pp;
   }

   

   get modified(){
       let datetime = this.pricingPQ.LastModifiedDate;
       let lasModi = moment.utc(datetime).format('DD/MM/YYYY');
       return lasModi;
   }

   get caUrl(){
       return `/${this.cA.Id}`;
   }

   get opUrl(){
       return `/${this.opportunityId}`;
   }

}