/* eslint-disable no-console */
/**
 * @File Name          : tkd_Convert_to_takedown.js
 * @Description        : 
 * @Author             : jhernandez@anivia.mx
 * @Group              : 
 * @Last Modified By   : juandedios.hernandez@engeniumcapital.com
 * @Last Modified On   : 27/9/2019 11:47:02
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    10/9/2019   jhernandez@anivia.mx     Initial Version
**/
import { LightningElement, api, track } from 'lwc';
import getForecast from '@salesforce/apex/TKD_Convert_to_takedownlwc_controller.getForecast';
import  convert from './templates/tkd_Convert_to_takedown.html';
import tkd_details from './templates/tkd_Convert_Details.html';
import tkd_general from './templates/tkd_Convert_GeneralInf.html';
import blankhtml from './templates/blank.html';
import lookOpps from './templates/tkd_Convert_lookOpps.html';
import lookCustomer  from './templates/tkd_Convert_lookCustomer.html';
import lookpricingCA from './templates/tkd_Covert_Pricing.html';
import customSR from '@salesforce/resourceUrl/ESFConverted';
import engrane from '@salesforce/resourceUrl/convert';
import getOppsData from '@salesforce/apex/TKD_Convert_to_takedownlwc_controller.fetchOpps';
//import getCustomerNames from '@salesforce/apex/TKD_Convert_to_takedownlwc_controller.getEntitiesInca';
import getPricingsCA from '@salesforce/apex/TKD_Convert_to_takedownlwc_controller.getPricingsInca';
import COLUMNAS from './fetchdataHelper';
import COLUMNS_CUSTOMER from './fetchdataHelper';
import COLUMNS_PRICINGCA from './fetchdataHelper';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';


export default class Tkd_Convert_to_takedown extends NavigationMixin(LightningElement) {

    @api recordId;
    @api section = blankhtml;
    @track forecast;
    @track kodey = customSR; 
    @track engrane = engrane;
    @track error;
    @track oppValidation = true;

    @track selectedOpp = {};
    @track selectedCustomer = {};
    @track selectedPricingCa = {};

    @track oppLookData=[];
    @track customerLookData=[];
    @track pricingscaLookData =[];

    @track COLUMNS = COLUMNAS.COLUMNAS;
    @track COLUMNSCUSTOMER = COLUMNS_CUSTOMER.COLUMNS_CUSTOMER;
    @track COLUMNSPRICINGCA = COLUMNS_PRICINGCA.COLUMNS_PRICINGCA;

    @track isLoaded = true;

    
    connectedCallback(){
        console.log('loool')
        getForecast({recordId:this.recordId}).
        then(result=>{
            this.forecast = result;
            this.selectedOpp.Id =this.forecast.TBO021_rb_Opportunity__c;
            this.selectedOpp.Name = this.forecast.TKD_fm_Opp_Name__c;
            this.selectedOpp.OPP_ls_Product__c = this.forecast.TBO021_rb_Opportunity__r.OPP_ls_Product__c;
            console.log('reg');
            console.log(this.forecast);

            if(this.selectedOpp.Id !== null && this.selectedOpp.Id !=='' && this.selectedOpp.Id !== undefined){
                getPricingsCA({opportunityId:this.selectedOpp.Id})
                .then(resultpri=>{
                    console.log('result Pricings In CA Porque hay opp');
                    console.log(resultpri)
                    if(resultpri.length >0 && resultpri.length < 2){
                        this.selectedPricingCa = {
                            Name: resultpri[0].Name,
                            Id: resultpri[0].Id 
                        }
                    }
                    this.error = undefined;
                }).catch(error=>{
                    this.error = error;
                })        
            }
            
            this.selectedOpp.OPP_ls_Deal_Category__c = this.forecast.TBO021_rb_Opportunity__r.OPP_ls_Deal_Category__c;
            this.selectedOpp.OPP_ls_Financing_Need__c = this.forecast.TBO021_rb_Opportunity__r.OPP_ls_Financing_Need__c;
            this.section = convert;
            this.error = undefined;
            getOppsData({accountId:this.forecast.TKD_fm_Account_Id__c})
            .then(resultado=>{
                console.log('resultopsValidation');
                let opptoConvert  = resultado.filter(({Id})=>Id ===this.selectedOpp.Id);
                console.log(opptoConvert);
                if(opptoConvert.length < 1 ){
                    this.oppValidation = false;
                }
                this.error = undefined;
            }).catch(error=>{
                this.error=error;
                this.oppValidation = undefined;
            })
        }).catch(error =>{
            this.error = error;
            this.forecast = undefined;
        })
    }

    render(){
       
       return this.section;
    }

    changeTemplatetoGeneral(){
        this.section =tkd_general;
    }

    changeTemplatetoDetails(){
        this.section = tkd_details;
    }


    async changeTemplateLookOpps(){
        await this.getOpportunities();
        this.section = lookOpps;
    }

    async changeTemplateLookEntitys(){
        await this.getEntitiesInca();
        this.section = lookCustomer; 
    }

    async changeTemplateLookPricingsInca(){
        await this.getPricingsInCa();
        this.section = lookpricingCA;
    }

    getOpportunities(){

        return new Promise(resolve=>{
            resolve(
                getOppsData({accountId:this.forecast.TKD_fm_Account_Id__c})
                .then(result=>{
                    console.log('resultops');
                    console.log(this.COLUMNS);
                    console.log(result);
                    this.oppLookData = result;
                    console.log(this.oppLookData);
                    this.error = undefined;
                }).catch(error=>{
                    this.error=error;
                    this.oppLookData = undefined;
                })
                
            )
        })
    }

    async addopp(event){
        let actionName = event.detail.action.name;
        let row = event.detail.row;
        if(actionName ==='Select'){
           
            this.selectedOpp =row;
            this.selectedCustomer = {};
            this.selectedPricingCa = {};
            await getPricingsCA({opportunityId:this.selectedOpp.Id})
            .then(result=>{
                console.log('result Pricings In CA');
                console.log(result)
                if(result.length >0 && result.length < 2){
                    this.selectedPricingCa = {
                        Name: result[0].Name,
                        Id: result[0].Id 
                    }
                }
                this.error = undefined;
            }).catch(error=>{
                this.error = error;
            })
            this.changeTemplatetoGeneral();
        }
    }

    /*getEntitiesInca(){
        return new Promise(resolve=>{
            resolve(
                getCustomerNames({opportunityId:this.selectedOpp.Id})
                .then(result=>{
                    console.log('result Entities in CA');
                    console.log(result);
                    this.customerLookData =result;
                    console.log(this.customerLookData);
                    this.error = undefined;
                }).catch(error=>{
                    this.error = error;
                    this.customerLookData = undefined;
                })
            )
        })
    }*/

    /*addCustomerName(event){
        let actionName = event.detail.action.name;
        let row = event.detail.row;
        console.log(row.Name);
        console.log(actionName);
        if(actionName ==='Select'){
            this.selectedCustomer = row;
            this.changeTemplatetoGeneral();
        }
    }*/

    getPricingsInCa(){
        return new Promise(resolve=>{
            resolve(
                getPricingsCA({opportunityId:this.selectedOpp.Id})
                .then(result=>{
                    console.log('result Pricings In CA');
                    console.log(result)
                    this.pricingscaLookData = result;
                    console.log(this.pricingscaLookData);
                    this.error = undefined;
                }).catch(error=>{
                    this.error = error;
                    this.pricingscaLookData = undefined;
                })
            )
        })
    }

    addPricingCa(event){
        let actionName = event.detail.action.name;
        let row = event.detail.row;
        console.log(row.Name);
        console.log(actionName);
        if(actionName === 'Select'){
            this.selectedPricingCa = row;
            this.changeTemplatetoGeneral();
        }
    }

    onRecordSubmit(event){
        event.preventDefault();
        console.log('se activo general form');
        let fields = event.detail;
        console.log(JSON.stringify(fields))
    }

    handleSuccess(event) {
        this.isLoaded = true;
        const toast = new ShowToastEvent({
            "title": "Convert Success!",
            "message": "Generated Takedown Id: " + event.detail.id +' success',
            "variant":"success"
        });

        this.dispatchEvent(toast);

        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: event.detail.id,
                objectApiName: 'Takedowns_Contingency_plan__c', // objectApiName is optional
                actionName: 'view'
            }
        });

    }

    handleSubmit(event){
        this.isLoaded = false;
        event.preventDefault();       // stop the form from submitting
        const fields = event.detail.fields;
        let pricing = fields.TKD_rb_Pricin_CA__c
        if(pricing !==null){
            this.template.querySelector('lightning-record-edit-form').submit(fields);
        }else{
            const toast = new ShowToastEvent({
                "title": "Pricing in CA missing",
                "message": "Please select a Pricing in CA",
                "variant":"warning"
            });
    
            this.dispatchEvent(toast);
            this.isLoaded = true;
        }
    }

    errohandler(event){
        this.isLoaded = true;
    }

    clearBoxes(event){
        let val = event.detail.value;
        console.log('value');
        console.log(val);

        if(val ==='' || val===null || val === undefined){
            this.selectedOpp = {};
            this.selectedCustomer = {};
            this.selectedPricingCa ={};
        }
    }
    
}