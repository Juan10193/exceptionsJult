/**
 * @File Name          : Cotizador.js
 * @Description        :
 * @Author             : angel87ambher@gmail.com
 * @Group              :
 * @Last Modified By   : ChangeMeIn@UserSettingsUnder.SFDoc
 * @Last Modified On   : 11-12-2020
 * @Modification Log   :
 * Ver       Date            Author      		    Modification
 * 1.0    17/2/2020   angel87ambher@gmail.com     Initial Version
**/

import { LightningElement , track, api,wire} from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import iniciarCotizacion from '@salesforce/apex/CotizadorController.iniciarCotizacion';
import calcularCotizacion from '@salesforce/apex/CotizadorController.calcularCotizacion';
import guardarCotizacion from '@salesforce/apex/CotizadorController.saveCotizacion';
import columnas from "./fetchDataHelper"
import columnas2 from "./fetchDataHelper2"
import {createCotizacion} from "./cotizcionHelper";
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import apexSearch from '@salesforce/apex/LMM_CotizadorLookUpAccLeads.search';
import { NavigationMixin } from 'lightning/navigation';
import getAccountFields from '@salesforce/apex/LMM_CotizadorLookUpAccLeads.getAccountFields';
import getLeadFields from '@salesforce/apex/LMM_CotizadorLookUpAccLeads.getLeadFields';
const columns = columnas;
const columns2 = columnas2;

/* eslint-disable no-console */ 

export default class Cotizador extends NavigationMixin(LightningElement) {
    @api notifyViaAlerts = false;
    isMultiEntry = false;
    maxSelectionSize = 2;
    initialSelection = [
        {
            id: 'na',
            sObjectType: 'na',
            icon: 'standard:lightning_component',
            title: 'Buscar En Cuentas y Leads',
            subtitle: 'Not a valid record'
        }
    ];
    errors = [];
    @track resultados = true;
    @track selectedData = {};
    @track sipinner=false;
    @track finance=false;
    @api Afinanciero;

    val=0;

    @track dataCalcular = {};
    @track dataIniciar = {};
    @track dataResult = {};
    @track listStates = [];
   // @track listAnnual = [];
    @track listFinanTerm = [];
    @track listFinanType = [];
    @track listFinancialType = [];
    @track lstAmortizacion = [];
    @track lstcuenta=[];
    @track clickedButtonLabel;
    @track userId;
    @track programId;
    @track tablecols = columns.columnas;
    @track tabledatos = columns2.columnas2;
    @track toggleIconName = 'utility:preview';
    @track toggleButtonLabel = 'Hide content';
    @track requestAmort = {};
    @track tasActiva = null;
    @track guardado = false;

  async connectedCallback(){

        iniciarCotizacion().then(response=>{

            response = decodeURIComponent(escape(response));

            this.inidata(response);
        });

   }

    inidata(response){

        console.log(response);
        
        this.dataIniciar = JSON.parse(response);

        this.dataCalcular.detFreeQuotationDTO = {
            annualIncomeTypeDTO:{}
        };

        this.listStates =[];
      /*  this.listAnnual =[];*/
        this.listFinanTerm =[];
        this.listFinanType =[];
        this.listFinancialType = [];

        this.dataIniciar.classObject.programDTO.lstFinancialTypes.forEach(element => {
            this.listFinancialType.push({
                value: element.intFinancialTypeId + '',
                label: element.strDescription
            });
        });

        this.dataIniciar.classObject.lstStates.forEach(element => {
            this.listStates.push({
                value: element.intStateId + '',
                label: element.strName
            });
        });

     /*   this.dataIniciar.classObject.lstAnnualIncomeTypes.forEach(element => {
            this.listAnnual.push({
                value: element.intAnnualIncomeTypeId + '',
                label: element.strDescription
            });
        });*/

        this.dataIniciar.classObject.programDTO.lstFinancialTerms.forEach(element => {
            this.listFinanTerm.push({
                value: element.intFinancialTermId + '',
                label: element.strDescription
            });
        });

        this.dataIniciar.classObject.programDTO.lstWsAssets.forEach(element => {
            this.listFinanType.push({
                value: element.assetDTO.lngAssetId + '',
                label: element.assetDTO.strDescription
            });
        });

        this.userId = this.dataIniciar.classObject.detAppUserDTO.intUserId + '';
        this.programId = this.dataIniciar.classObject.programDTO.intProgramId + '';
    }

    get persona(){
        return [
            { label: 'Persona fisica con actividad empresarial', value: 'Fisica' },
            { label: 'Persona moral', value: 'Moral' },
        ];
    }

    get moneda(){
        return [
            { label: 'USD', value: 'USD' },
            { label: 'MXN', value: 'MXN' },
        ];
    }
    
    get tipofinanciamiento(){
        return this.listFinancialType;
    }

   get ubicacion(){
       return this.listStates;
    }

   /* get ventas(){
        return this.listAnnual;
    }*/

    get plazo(){
        return this.listFinanTerm;
    }

    get tipoactivo(){
        return this.listFinanType;
    }

    get financiero(){
        return this.Afinanciero = "A. Financiero";
    }

    handleChangeSlider(event){
        this.value = event.detail.value;
        this.dataIniciar.classObject.programDTO.lstWsProgramInputDatas.find(x => x.strInputdataKey == 'COMMISSION_OPENING').fltEnteredValue = parseFloat(this.value);
    }

    handleChangeSlider2(event){
        this.value = event.detail.value;
        this.dataIniciar.classObject.programDTO.lstWsProgramInputDatas.find(x => x.strInputdataKey == 'SECURITY_DEPOSIT').fltEnteredValue = parseFloat(this.value);
    }

    handleChangeSlider3(event){
        this.value = event.detail.value;
        this.dataIniciar.classObject.programDTO.lstWsProgramInputDatas.find(x => x.strInputdataKey == 'PURCHASE_OPTION').fltEnteredValue =parseFloat(this.value);
    }

    handleChangeSlider4(event){
        this.value = event.detail.value;
        this.dataIniciar.classObject.programDTO.lstWsProgramInputDatas.find(x => x.strInputdataKey == 'HITCH').fltEnteredValue = parseFloat(this.value);
    }
    
    handleChangeFinancialType(event) {
        this.value = event.detail.value;
        this.dataCalcular.financialTypeDTO= this.dataIniciar.classObject.programDTO.lstFinancialTypes.find(x =>(x.intFinancialTypeId + '')  === this.value);
    }

  /*  handleChangeVentas(event) { listFinancialType
        this.value = event.detail.value;
      //  this.dataCalcular.detFreeQuotationDTO.annualIncomeTypeDTO =  this.dataIniciar.classObject.lstAnnualIncomeTypes.find(x =>(x.intAnnualIncomeTypeId + '')  === this.value);  
        this.dataCalcular.detFreeQuotationDTO.annualIncomeTypeDTO =  this.dataIniciar.classObject.lstAnnualIncomeTypes.find(x =>(x.intAnnualIncomeTypeId == 3));    
  
    }*/

    handleChangeTasa(event){
        this.value = event.detail.value;
        this.tasActiva = this.value;
    }

    handleChangePlazo(event) {
        this.value = event.detail.value;
        this.dataCalcular.financialTermsDTO = this.dataIniciar.classObject.programDTO.lstFinancialTerms.find(x =>(x.intFinancialTermId + '')  === this.value);
    }

    handleChangeTipoActivo(event) {
        this.value = event.detail.value;
        this.dataCalcular.lstQuotationAssets  = this.dataIniciar.classObject.programDTO.lstWsAssets.filter(x =>(x.lngAssetId + '')  === this.value);
    }

    handleChangeEmpresa(event){
        this.value = event.detail.value;
        this.dataCalcular.strClientName = this.value;
    }

    handleChangeContacto(event){
        this.value = event.detail.value;
        this.dataCalcular.strContactName = this.value;
    }

    handleChangeRFC(event){
        this.value = event.detail.value;
        this.dataCalcular.detFreeQuotationDTO.strRfc = this.value;
    }

    handleChangeEmail(event){
        this.value = event.detail.value;
        this.dataCalcular.strEmailToSend = this.value;
    }

    handleChangeTel(event){
        this.value = event.detail.value;
        this.dataCalcular.detFreeQuotationDTO.strPhoneNumber = this.value;
    }

    handleChangeActivo(event){
        this.value = event.detail.value;
        this.dataCalcular.lstQuotationAssets[0].fltAmount = this.value;
    }

    handleChangePersona(event){
        this.value = event.detail.value;
        this.dataCalcular.detFreeQuotationDTO.strPersonType = this.value;
    }

   
    handleChangeMoneda(event){
        this.value = event.detail.value;
        this.dataCalcular.currencyDTO = this.dataIniciar.classObject.programDTO.lstCurrencies.find(x =>(x.strCurrencyCode == this.value));
        this.dataCalcular.quoteDetailDTO = { "currencyAssetsDTO": this.dataCalcular.currencyDTO }

    }
     
    handleChangeUbicacion(event) {
        this.value = event.detail.value;
        this.dataCalcular.stateDTO = this.dataIniciar.classObject.lstStates.find(x =>(x.intStateId + '')  === this.value);
    }

    //onchange de campo de texto tasa activa

    async handleClick(event) {

        this.clickedButtonLabel = event.target.label;
        this.dataCalcular.lstProgramInputDatas = this.dataIniciar.classObject.programDTO.lstWsProgramInputDatas;
        this.dataCalcular.financialInsuranceDTO = this.dataIniciar.classObject.lstFinancialInsurances[0];
        this.dataCalcular.lstQuotationAssets[0].intQuantity = 1;
        this.dataCalcular.detFreeQuotationDTO.annualIncomeTypeDTO.intAnnualIncomeTypeId=3;
        this.dataCalcular.detFreeQuotationDTO.annualIncomeTypeDTO.strDescription='Entre 50 y 100 millones';
        //this.dataCalcular.financialTypeDTO = this.dataIniciar.classObject.programDTO.lstFinancialTypes[0];
  
        // this.dataCalcular.financialType = this.dataIniciar.classObject.programDTO.lstFinancialTypes[0];
         console.log((JSON.stringify(this.dataCalcular)).replace('\\n','').replace('\\',''));
        calcularCotizacion({
            userId: this.userId,
            programId: this.programId,
            profitTarget:this.tasActiva,
            data:(JSON.stringify(this.dataCalcular)).replace('\\n','').replace('\\','')
        }).then(response=>{
                this.guardado = false;
                response = decodeURIComponent(escape(response));

                console.log(response);

                this.dataResult = JSON.parse(response);
                this.requestAmort.userId =this.userId;
                this.requestAmort.programId = this.programId;
                this.requestAmort.data = this.dataCalcular;
                if(this.dataResult.success){
                  this.lstAmortizacion = this.dataResult.classObject.quoteDetailDTO.lstQuotePeriods;
                  this.dataResult.classObject.quoteDetailDTO.strCurrencyCode = this.dataResult.classObject.quoteDetailDTO.currencyAssetsDTO.strCurrencyCode
                  this.dataResult.classObject.quoteDetailDTO.strDescription = this.dataResult.classObject.financialTypeDTO.strDescription
                  this.tasActiva = this.dataResult.classObject.quoteDetailDTO.dblRealRate;

                  //pintar un campo de texto con el valir de tasa activa, si cambia modificas tasa activa 

                  this.lstcuenta =[this.dataResult.classObject.quoteDetailDTO];
                  console.log('la lista cotizador')
                  console.log(this.tasActiva)
                  console.log(this.lstcuenta)

                  this.guardado = true;
                } else {
                    alert('Servicio no disponible!!!');
                }
        });

    }

    handleShowPDF() {
        console.log('this.lstAmortizacion ' + JSON.stringify(this.lstAmortizacion))
        this.dispatchEvent(new CustomEvent('pdfcot', 
        {
            detail: { lstAmortizacion:  this.lstAmortizacion, cotizacion : createCotizacion(this.lstcuenta, this.dataCalcular, this.requestAmort, this.selectedData)},
            bubbles: true,
            composed: true,
        }));
    }
    async handleSaveCotizacion(){
        this.sipinner = true;

       let cotizacion = createCotizacion(this.lstcuenta, this.dataCalcular, this.requestAmort, this.selectedData, this.dataIniciar);
       try{
        let savedCotizacion = await guardarCotizacion({cotizacion:cotizacion});
        const evt = new ShowToastEvent({
            title: "Success",
            message: "EC QUOTE successfull saved",
            variant: "success"
        });
        await  this.dispatchEvent(evt);
        console.log('Cotizacion salvada')
        console.log(savedCotizacion)
        this.sipinner = false;
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: savedCotizacion.Id,
                objectApiName: 'namespace__ObjectName', // objectApiName is optional
                actionName: 'view'
            }
        });
        this[NavigationMixin.GenerateUrl]({
            type: 'standard__navItemPage',
            attributes: {
                apiName: "customTabName",
            },
            // query string parameters
            state: {
                c__showPanel: 'true' // Value must be a string
            }
        }).then(url => {
            window.open('/apex/LMMCotizacionPDF?id=' + savedCotizacion.Id)
        });
       }catch(error){
           console.log('Error al guardar la cotizacion');
           console.log(error);
       }

       console.log('this.lstAmortizacion ' + JSON.stringify(this.lstAmortizacion))
    }

    handleLookupTypeChange(event) {
        this.initialSelection = [];
        this.errors = [];
        this.isMultiEntry = event.target.checked;
    }

    handleSearch(event) {
        apexSearch(event.detail)
            .then((results) => {
                this.template.querySelector('c-lookup').setSearchResults(results);
                if(results.length ===0){
                    this.resultados = false;
                }else{
                    this.resultados = true;
                }
            })
            .catch((error) => {
                this.notifyUser('Lookup Error', 'An error occured while searching with the lookup field.', 'error');
                // eslint-disable-next-line no-console
                console.error('Lookup error', JSON.stringify(error));
                this.errors = [error];
            });
    }

    handleSelectionChange() {
        this.checkForErrors();
    }

    handleMaxSelectionSizeChange(event) {
        this.maxSelectionSize = event.target.value;
    }

    handleSubmit() {
        this.checkForErrors();
        if (this.errors.length === 0) {
            this.notifyUser('Success', 'The form was submitted.', 'success');
        }
    }

    handleClear() {
        this.initialSelection = [];
        this.errors = [];
    }

    checkForErrors() {
        this.errors = [];
        const selection = this.template.querySelector('c-lookup').getSelection();
        console.log('LA SELECCION');
        console.log(selection);
        // Custom validation rule
        if (this.isMultiEntry && selection.length > this.maxSelectionSize) {
            this.errors.push({ message: `You may only select up to ${this.maxSelectionSize} items.` });
        }
        // Enforcing required field
        if (selection.length === 0) {
            this.errors.push({ message: 'Please make a selection.' });
        }

        if(selection.length >0){
            this.dataCalcular.strClientName = selection[0].title;
            let seleccionado = selection;
            this.autoFillFields(seleccionado);
        }
    }

    notifyUser(title, message, variant) {
        if (this.notifyViaAlerts) {
            // Notify via alert
            // eslint-disable-next-line no-alert
            alert(`${title}\n${message}`);
        } else {
            // Notify via toast
            /* const toastEvent = new ShowToastEvent({ title, message, variant });
            this.dispatchEvent(toastEvent); */
            console.log(message)
        }
    }

    navigateToNewLead() {
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'Lead',
                actionName: 'new'
            }
        });
    }

    async autoFillFields(seleccionado){
        let recordId = seleccionado[0].id;
        if(seleccionado[0].sObjectType ==="Account"){
            try{
                let fields = await getAccountFields({recordId:recordId});
                console.log('Campos de cuenta');
                console.log(fields);
                if(fields.Contacts){
                    this.template.querySelector("[data-id='NombreCon']").value = fields.Contacts[0].Name;
                    this.dataCalcular.strContactName =fields.Contacts[0].Name; 
                    this.template.querySelector("[data-id='email']").value = fields.Contacts[0].Email;
                    this.dataCalcular.strEmailToSend = fields.Contacts[0].Email;
                    this.template.querySelector("[data-id='phone']").value = fields.Contacts[0].Phone;
                    this.dataCalcular.detFreeQuotationDTO.strPhoneNumber = fields.Contacts[0].Phone;
                    this.selectedData.Id = recordId;
                    this.selectedData.sObjectType = "Account";
                }
               

            }catch(error){
                console.log('error al pre cargar campos de cuenta');
                console.log(error);
            }
            
        }else if(seleccionado[0].sObjectType ==="Lead"){
            try {
                let fields = await getLeadFields({recordId:recordId});
                console.log('CAMpos de Lead');
                console.log(fields);
                this.template.querySelector("[data-id='NombreCon']").value = fields.Name;
                this.dataCalcular.strContactName = fields.Name;
                this.template.querySelector("[data-id='email']").value = fields.Email;
                this.dataCalcular.strEmailToSend = fields.Email;
                this.template.querySelector("[data-id='phone']").value = fields.Phone;
                this.dataCalcular.detFreeQuotationDTO.strPhoneNumber = fields.Phone;
                this.selectedData.Id = recordId;
                this.selectedData.sObjectType = "Lead";

            } catch (error) {
                onsole.log('error al pre cargar campos de lead');
                console.log(error);
            }
        }
    }

               

}