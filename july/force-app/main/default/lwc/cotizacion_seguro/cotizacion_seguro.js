import { LightningElement, track, wire, api} from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getCotizacionSeguro from '@salesforce/apex/Cotizacion_seguro_controller.getCotizacionSeguro'; 
import insertCotizacionSeguro from '@salesforce/apex/Cotizacion_seguro_controller.insertCotizacionSeguro'; 
import deleteCotizacion from '@salesforce/apex/Cotizacion_seguro_controller.deleteCotizacion'; 
import getAllCotizaciones from '@salesforce/apex/Cotizacion_seguro_controller.getAllCotizaciones';

import getMoneda from '@salesforce/apex/Cotizacion_seguro_controller.getMoneda';

import { refreshApex } from '@salesforce/apex';

const options = [
    { label: 'USD', value: 'USD' },
    { label: 'MXN', value: 'MXN' }
];

const optionsMeses = [
    { label: '12 m', value: '12' },
    { label: '24 m', value: '24' },
    { label: '36 m', value: '36' },
    { label: '48 m', value: '48' },
    { label: '60 m', value: '60' }
];

const optionRazon = [
    { label: 'ENGENCAP FIN', value: 'ENGENCAP_FIN' },
    { label: 'ENGENCAP HOLDING', value: 'ENGENCAP_HOLDING' },
    { label: 'ENGENCAP S', value: 'ENGENCAP_S' }
];

const optionBien = [
    { label: 'Equipo Electrónico Fijo', value: 'EQUIPO_ELECTRONICO_FIJO' },
    { label: 'Equipo Electrónico Móvil', value: 'EQUIPO_ELECTRONICO_MOVIL' },
    { label: 'Rotura de Maquinaria', value: 'ROTURA_MAQUINARIA' },
    { label: 'Equipo de contratistas', value: 'EQUIPO_CONTRATISTAS' },
    { label: 'Contenidos', value: 'CONTENIDOS' }
];

const columns = [  
    { label: 'Descripción', fieldName: 'descripcion' , type: 'text' },
    { label: 'Suma asegurada', fieldName: 'sumaAsegurada' },
    { label: 'Prima neta', fieldName: 'primaNetaLabel', type: 'text' },
    { label: 'Gastos', fieldName: 'gastosLabel', type: 'text' },
    { label: 'IVA', fieldName: 'ivaLabel', type: 'text' },
    { label: 'Prima total', fieldName: 'primaNetaTotalLabel', type: 'text' },
    { label: 'Total', fieldName: 'primaTotalLabel', type: 'text' }
];  

const columsRecords = [
    { label: 'Descripción' , fieldName: 'QS_descripcion__c', type: 'text' },
    { label: 'Suma asegurada' , fieldName: 'QS_Suma_Asegurada__c', type: 'currency', cellAttributes: { alignment: 'left' }, typeAttributes: { currencyCode: { fieldName: 'CurrencyIsoCode' }}},
    { label: 'Prima neta', fieldName: 'QS_Prima_Neta_Label__c', type: 'text' }/*,
    { label: 'Gastos', fieldName: 'QS_Gastos_Label__c', type: 'text' },
    { label: 'IVA', fieldName: 'QS_IVA_Label__c', type: 'text' },
    { label: 'Prima neta total', fieldName: 'QS_Prima_Neta_Total_Label__c', type: 'text' },
    { label: 'Total', fieldName: 'QS_Prima_Total_Label__c', type: 'text' },
    { label: 'Fecha de creación', fieldName: 'CreatedDate', type: 'date' }*/
];

const columsProducto = [
    { label: 'Term Loan', value: 'Term Loan' },
    { label: 'True Lease', value: 'True Lease' },
    { label: 'Quasi Lease', value: 'Quasi Lease' }
];

import { NavigationMixin } from 'lightning/navigation';

export default class ChildLWC extends NavigationMixin(LightningElement) {
    @api recordId;

    @track fromCurrencyValue;
    @track options = options;

    @track fromRazonValue;
    @track optionRazon = optionRazon;

    @track fromBienValue;
    @track optionBien = optionBien;

    @track fromPeriodoValue;
    @track fromPromotorValue;
    @track fromConservaValue;

    @track fromSumaValue;

    @track columns = columns;
    @track columsRecords = columsRecords;

    @track fromProducto;
    @track columsProducto = columsProducto;

    @track cotizaciones;    
    @track cotizacionesOpportunidad;

    @track rowSelected;
    @track sumPrimaNeta = 0;
    @track sumGasto = 0;
    @track sumIVA = 0;
    @track sumTotal = 0;

    @track numberRowSelect = 0;

    @track optionsMeses = optionsMeses;
    selectedRecords = [];
    loaded = false;
    hideButton = false;
    hidetable = false;
    @track disableOption = false;

    @track tipoEquipo = [];
    @track existeTipoEquipo = false; 

    @track selectedLabel;

    //News
    @track showStartPopOver = false;
    @track showEndPopOver = false;


    wiredAccountsResult;

    @wire(getMoneda, {idOpportunidad: '$recordId'})
    wireMoneda(result){
        if(result.data) {
            const opportunityValue = result.data;
            for(let i=0; i< opportunityValue.length; i++ ){
                this.fromCurrencyValue = opportunityValue[i].CurrencyIsoCode;
                this.fromProducto = opportunityValue[i].OPP_ls_Product__c;
            }
            this.error = undefined;
        }
        else if(result.error) {
            this.error = result.error;
            this.fromCurrencyValue  = undefined;
        }
    }

    @wire(getAllCotizaciones, {idOpportunity: '$recordId'})
    wireCotizacion(result) {
        this.wiredAccountsResult = result;
        if(result.data) {
            this.cotizacionesOpportunidad = result.data;
            this.error = undefined;
            for(let i=0; i<this.cotizacionesOpportunidad.length; i++ ){
                this.sumPrimaNeta += this.cotizacionesOpportunidad[i].QS_Prima_Neta__c;
                this.sumGasto += this.cotizacionesOpportunidad[i].QS_Gastos__c;
                this.sumIVA += this.cotizacionesOpportunidad[i].QS_IVA__c;
                this.sumTotal += this.cotizacionesOpportunidad[i].QS_Prima_Total__c;
                this.tipoEquipo.push(this.cotizacionesOpportunidad[i].QS_descripcion__c);
            }
            if(this.cotizacionesOpportunidad.length > 0) {
                this.fromPeriodoValue = this.cotizacionesOpportunidad[0].QS_Periodo_Cotizacion__c.toString();
                this.fromRazonValue = this.cotizacionesOpportunidad[0].QS_Razon_social__c;
                this.disableOption = true;
            }
            else {
                this.disableOption = false;
            }
            this.sumPrimaNeta = this.formatter.format(this.sumPrimaNeta);
            this.sumGasto = this.formatter.format(this.sumGasto);
            this.sumIVA = this.formatter.format(this.sumIVA);
            this.sumTotal = this.formatter.format(this.sumTotal);
            console.log(this.sumPrimaNeta);
            console.log(this.sumGasto);
            console.log(this.sumIVA);
            console.log(this.sumTotal);
        }
        else if(result.error) {
            this.error = result.error;
            this.cotizacionesOpportunidad = undefined;
        }
    }
    
    formatter = new Intl.NumberFormat('en-US', {
        style: 'currency',
        currency: 'USD',
        minimumFractionDigits: 2
    });

    //News method
    showStartPop() {
        this.showStartPopOver = true;
    }

    showEndPop() {
        this.showEndPopOver = true;
    }

    closeStartPop() {
        this.showStartPopOver = false;
    }

    closeEndPop() {
        this.showEndPopOver = false;
    }
    //News method


    handleFromCurrencyChange(event) {
        this.fromCurrencyValue = event.detail.value;
    }

    handleFromRazonChange(event) {
        this.fromRazonValue = event.detail.value;
    }

    handleFromPeriodoChange(event) {
        this.fromPeriodoValue = event.detail.value;
    }

    handleFromPromotorChange(event) {
        this.fromPromotorValue = event.detail.value;
    }

    handleFromConservaChange(event) {
        this.fromConservaValue = event.detail.value;
    }

    handleFromBienChange(event) {
        this.fromBienValue = event.detail.value;
        this.selectedLabel = this.optionBien.find(opt => opt.value === event.detail.value).label;
    }

    handleFromProducto(event) {
        this.fromProducto = event.detail.value;
    }

    handleFromSumaChange(event) {
        this.fromSumaValue = event.detail.value;
    }

    getSelectInsert(event) {
        const rowSelect = event.detail.selectedRows;
        this.numberRowSelect = rowSelect.length;
    }

    getSelectRecord(event) {
        const rowSelect = event.detail.selectedRows;
        let cotizacionId = new Set();

        this.rowSelected = event.detail.selectedRows.length;
        if(rowSelect.length != 0){
            this.hideButton = true;
        }else {
            this.hideButton = false;
        }
        console.log('size:' + rowSelect.length);
        for(let i=0; i < rowSelect.length; i++) {
            cotizacionId.add(rowSelect[i].Id);
        }
        
        this.selectedRecords = Array.from(cotizacionId);
        console.log('Select: ' + this.selectedRecords);
    }

    handleCurrencyConversion() {
        this.loaded = true;

        const allValid = [...this.template.querySelectorAll('lightning-combobox, lightning-input')]
        .reduce((validSoFar, inputCmp) => {
                    inputCmp.reportValidity();
                    return validSoFar && inputCmp.checkValidity();
        }, true);

        //const validateField

        if (allValid) {
            getCotizacionSeguro({razonSocialConsulta : this.fromRazonValue, 
                periodo : this.fromPeriodoValue,
                moneda : this.fromCurrencyValue,
                clavePromotor : this.fromPromotorValue,
                conservarCotizacion : this.fromConservaValue,
                claveBienRiesgo : this.fromBienValue,
                sumaAsegurada : this.fromSumaValue})
            .then(result => {  

                var map = JSON.parse(result);

                if(map.status.detail == 'S') {
                    this.cotizaciones = map.quote.data; 
                    this.loaded = false;
                    this.hidetable = true;
                    this.showAlertToast('Consulta éxitosa', 'Se encontraron cotizaciones de seguros asociados a su busqueda.', 'info');
                    console.log('Registros: ' + this.cotizaciones);
                }
                else {
                    var mapError = JSON.parse(map.status.message);
                    var mensajeError = mapError.errores.error;
                    this.cotizaciones = undefined;
                    this.hidetable = false;
                    this.loaded = false;
                    this.showAlertToast('Error de consulta', mensajeError.toString() , 'warning');
                    console.log(mensajeError.toString());
                }
            
            })  
            .catch(error => {  
                this.error = error;
                this.loaded = false;
                this.showAlertToast('Error de consulta', 'Se supero el limite de la suma asegurada', 'warning');
                this.cotizaciones = undefined;
                this.hidetable = false;
                console.log('Sin registros: ' + this.error);
            });  
        } else {
            this.loaded = false;
            this.showAlertToast('Error', 'Favor de llenar los campos marcados como obligatorios', 'error');
        }
    }

    async handleSaveQuote() {
        var el = this.template.querySelector('lightning-datatable');
        console.log(el);
        var selected = el.getSelectedRows();
        console.log(selected);
        console.log(JSON.stringify(selected));
        var found = false;

        for(var i=0; i<this.tipoEquipo.length && !found; i++) {
            if(this.tipoEquipo[i]  == this.selectedLabel) {
                found = true;
                break;
            }
        }



        if(this.numberRowSelect != 0 && !found){
            insertCotizacionSeguro({json :  JSON.stringify(selected), 
                idOpportunity : this.recordId,
                divisa : this.fromCurrencyValue,
                producto: this.fromProducto,
                razonSocial: this.fromRazonValue})
                .then(result => {  
                    console.log(result);
                    this.cotizaciones = undefined;
                    this.hidetable = false;
                    this.showAlertToast('Acción éxitosa', 'Cotización de seguro añadida con éxito', 'success');
                    this.sumPrimaNeta = 0;
                    this.sumGasto = 0;
                    this.sumIVA = 0;
                    this.sumTotal = 0;
                    this.numberRowSelect = 0;
                    return refreshApex(this.wiredAccountsResult);
                    //this.cotizaciones = result; 
                })  
                .catch(error => {
                    this.showAlertToast('Error', 'Ocurrio un error al añadir a la cotización de seguro: tipo ya éxistente', 'error');
                    console.log(error);
                    //this.error = error;  
                });
                
            await getAllCotizaciones({ recordId: this.recordid });
        }
        else if(found) {
            this.showAlertToast('Error', 'No se puede duplicar el tipo de cotización', 'warning');
        }
        else {
            this.showAlertToast('', 'Selecciona la cotización a guardar', 'warning');
        }
    }

    deleteSeguroCotizacion() {
        if(this.selectedRecords) {
            this.loaded = true;
            this.deleteCotizacion();
        }
    }

    deleteCotizacion () {
        deleteCotizacion({listIdCotizacionSeguro: this.selectedRecords})
        .then(result => {
            this.loaded = false;
            this.hideButton = false;
            this.showAlertToast('Acción éxitosa', 'Cotizacion retirada con éxito', 'success');
            this.template.querySelector('lightning-datatable').selectedRows = [];
            this.rowSelected = 0;
            this.sumPrimaNeta = 0;
            this.sumGasto = 0;
            this.sumIVA = 0;
            this.sumTotal = 0;
            this.tipoEquipo = [];
            return refreshApex(this.wiredAccountsResult);
        })
        .catch(error => {
            this.loaded = false;
            this.showAlertToast('Error', 'Ocurrio un error al retirar la cotización', 'error');
        });
    }

    showAlertToast(title, message, variant) {
        const evt = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant,
            mode: 'dismissable'
        });
        this.dispatchEvent(evt);
    }

    pdf(event) {
        event.stopPropagation();

        this[NavigationMixin.GenerateUrl]({
            type: 'standard__webPage',
            attributes: {
                url: '/apex/PDFSeguroCotizacion?id='+this.recordId
            }
        }).then(generatedUrl => {
            window.open(generatedUrl);
        });
    }
}