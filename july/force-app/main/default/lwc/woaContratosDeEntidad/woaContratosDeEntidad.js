/**
 * @description       : 
 * @author            : eduardo.amiens@outlook.com
 * @group             : 
 * @last modified on  : 11-19-2020
 * @last modified by  : eduardo.amiens@outlook.com
 * Modifications Log 
 * Ver   Date         Author                       Modification
 * 1.0   10-14-2020   eduardo.amiens@outlook.com   Initial Version
**/
import { LightningElement, api, wire, track } from 'lwc';

import { getPicklistValues, getObjectInfo } from 'lightning/uiObjectInfoApi';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi'
import { ShowToastEvent } from 'lightning/platformShowToastEvent'
import Animate from '@salesforce/resourceUrl/Animate';
import { loadScript, loadStyle } from 'lightning/platformResourceLoader';
import getContractsFromEntities from "@salesforce/apex/woaContratosDeEntidadController.getContractsFromEntities"
import getSelectedContracts from "@salesforce/apex/woaContratosDeEntidadController.getSelectedContracts"
import deleteContracts from "@salesforce/apex/woaContratosDeEntidadController.deleteContracts"
import updateContracts from "@salesforce/apex/woaContratosDeEntidadController.updateContracts"


import insertContracts from '@salesforce/apex/woaContratosDeEntidadController.insertContracts'
import getNetBookValuesXdate from '@salesforce/apex/woaContratosDeEntidadController.getNetBookValuesXdate'
import insertQuote from '@salesforce/apex/woaContratosDeEntidadController.insertQuote'



import OEC from '@salesforce/schema/Opportunity.WOA_re_OEC__c'
import StageName from '@salesforce/schema/Opportunity.StageName'

import OpenItems from '@salesforce/schema/Opportunity.WOA_re_Open_items__c'
import NBV from '@salesforce/schema/Opportunity.WOA_re_NBV__c'
import WOA_fh_Fecha_de_terminacion_de_contrato from '@salesforce/schema/Opportunity.WOA_fh_Fecha_de_terminacion_de_contrato__c'
import CurrencyIsoCode from '@salesforce/schema/Opportunity.CurrencyIsoCode'
import momentJs from '@salesforce/resourceUrl/momentJs';

import { refreshApex } from '@salesforce/apex'
import WOA_OLFM_Cotizacion_OBJECT from '@salesforce/schema/WOA_OLFM_Cotizacion__c';
import WOA_ls_Detalle_de_la_negociacion from '@salesforce/schema/WOA_OLFM_Cotizacion__c.WOA_ls_Detalle_de_la_negociacion__c';
export default class WoaContratosDeEntidad extends LightningElement {
    @api recordId
    @track showModalBuscarContratos = false
    @track showModalRecalcularNBV = false
    @track showModalCotizacionTerminacionContrato = false
    @track selectedRowFromOracle
    @track selectedRowFromSF
    @track finishWireOpportunityRecord = true
    @track finishWireGetContracts = false
    @track finishWireGetSelectedContracts = false
    @track showSpinnerInProcess = false
    selectedContractsFromSF
    @track step = '1'

    @track fechaParaNBV

    @track detalleDeLaNegociacionValue
    @track detalleDeLaNegociacionOptions = []
    

    get disableCloseButton() {
        if (this.step === '1') {
            return true
        } else {
            return false
        }
    }

    get stepAcceptButtonLabel() {
        if (this.step === '1' || this.step === '2') {
            return 'Siguiente'
        } else {
            return 'Guardar'
        }
    }

    get modalSize() {
        if (this.step === '1') {
            return 'slds-modal slds-fade-in-open animated fadeInRight slds-modal_small'
        } else {
            return 'slds-modal slds-fade-in-open animated fadeInRight slds-modal_large'
        }
    }

    get visibleStep1() {
        if (this.step === '1') {
            return true
        } else {
            return false
        }
    }
    get visibleStep2() {
        if (this.step === '2') {
            return true
        } else {
            return false
        }
    }
    get visibleStep3() {
        if (this.step === '3') {
            return true
        } else {
            return false
        }
    }

    get showSpinner() {
        let show = true
        if (this.finishWireOpportunityRecord === true
            && this.finishWireGetContracts === true
            && this.finishWireGetSelectedContracts === true) {
            show = false
        }
        return show
    }

    get disableAllButtonsByStage() {
        if(getFieldValue(this.opportunityRecord.data, StageName) === 'Nuevo' 
        || getFieldValue(this.opportunityRecord.data, StageName) === 'Negociación'){
            
            return false
        } else {
            return true
        }
    }

    get disableButtonsOnRows() {
        let disable = false
        if (this.selectedRowFromSF === null || this.selectedRowFromSF === undefined
            || this.selectedRowFromSF.length === 0 || this.disableAllButtonsByStage) {
            disable = true
        }
        return disable
    }
    get disableInsertRows() {
        console.log('this.selectedRowFromOracle')
        let disable = false
        if (this.selectedRowFromOracle === null || this.selectedRowFromOracle === undefined
            || this.selectedRowFromOracle.length === 0) {
            disable = true
            console.log('no ')
        }
        return disable
    }

    get OEC() {
        return getFieldValue(this.opportunityRecord.data, OEC)
    }
    get OpenItems() {
        return getFieldValue(this.opportunityRecord.data, OpenItems)
    }
    get NBV() {
        return getFieldValue(this.opportunityRecord.data, NBV)
    }
    get CurrencyIsoCode() {
        return getFieldValue(this.opportunityRecord.data, CurrencyIsoCode)
    }

    columnsFromSelectedContract = [
        { label: 'Cliente', fieldName: 'WOA_tx_Customer_name__c' },
        { label: 'Contrato OLFM', fieldName: 'WOA_tx_contract_Id__c' },
        { label: 'Producto', fieldName: 'WOA_tx_Product_Name__c' },
        { label: 'Plazo', fieldName: 'WOA_nu_Term_Months__c' },
        { label: 'Estatus', fieldName: 'WOA_tx_Status__c' },
        { label: 'Activos', fieldName: 'WOA_nu_Asset_Quantity__c' },
        { label: 'OEC', fieldName: 'WOA_nu_OEC__c', type: 'currency', typeAttributes: { currencyCode: { fieldName: 'CurrencyIsoCode' } } },
        { label: 'NBV', fieldName: 'WOA_nu_NBV__c', type: 'currency', typeAttributes: { currencyCode: { fieldName: 'CurrencyIsoCode' } } },
        { label: 'OpenItems', fieldName: 'WOA_nu_Open_items__c', type: 'currency', typeAttributes: { currencyCode: { fieldName: 'CurrencyIsoCode' } } },
        { label: 'Divisa', fieldName: 'CurrencyIsoCode' }
    ];
    dataFromSelectedContract = []

    columnsFromSearchContract = [
        { label: 'Cliente', fieldName: 'pcustomerName' },
        { label: 'Contrato OLFM', fieldName: 'pcontractId' },
        { label: 'Producto', fieldName: 'pproductName' },
        { label: 'Plazo', fieldName: 'ptermMonths' },
        { label: 'Estatus', fieldName: 'pstatus' },
        { label: 'Activos', fieldName: 'passetQty' },
        { label: 'OEC', fieldName: 'poec', type: 'currency', typeAttributes: { currencyCode: { fieldName: 'pcurrency' } } },
        { label: 'NBV', fieldName: 'pnbv', type: 'currency', typeAttributes: { currencyCode: { fieldName: 'pcurrency' } } },
        { label: 'OpenItems', fieldName: 'popenItems', type: 'currency', typeAttributes: { currencyCode: { fieldName: 'pcurrency' } } },
        { label: 'Divisa', fieldName: 'pcurrency' }

    ];
    dataFromSearchContract = []

    dataFromRecalculatedContract = []

    columnsFromTerminationQoute = [
        { label: 'Cliente', fieldName: 'pcustomerName' },
        { label: 'Contrato OLFM', fieldName: 'pcontractId' },
        { label: 'Número de Contrato', fieldName: 'pcontractNumber'},
        { label: 'Número de documento legal', fieldName: 'plegalDocumentNumber'},
        { label: 'Id cotización', fieldName: 'pquoteId' },
        { label: 'Número de cotización', fieldName: 'pquoteNumber' },
        { label: 'Id de cliente', fieldName: 'pcustomerId' },
        { label: 'Producto', fieldName: 'pproductName' },
        { label: 'Plazo', fieldName: 'ptermMonths' },
        { label: 'Estatus del contrato', fieldName: 'pcontractStatus' },
        { label: 'Estatus de la cotización', fieldName: 'pquoteStatus' },
        { label: 'Fecha de terminación de contrato', fieldName: 'pdateEffectiveFrom' },
        { label: 'Activos', fieldName: 'passetQty' },
        { label: 'Cotizaciones', fieldName: 'pquoteQty' },
        { label: 'Monto de la compra', fieldName: 'ppurchaseAmount' },
        { label: 'Monto de terminación', fieldName: 'pterminationAmount' },
        { label: 'Costo de financiación', fieldName: 'pbreakFoundingCost' },
        { label: 'Tarifa de transferencia de título', fieldName: 'ptitleTransFee' },
        { label: 'Multa por pago anticipado', fieldName: 'pprepaymentPenalty' },
        { label: 'Cantidad de plazo', fieldName: 'ptermnAmountAdj' },
        { label: 'OEC', fieldName: 'poec', type: 'currency', typeAttributes: { currencyCode: { fieldName: 'pcurrency' } } },
        //{ label: 'NBV', fieldName: 'pnbv', type: 'currency', typeAttributes: { currencyCode: { fieldName: 'pcurrency' } } },
        { label: 'OpenItems', fieldName: 'popenItems' },
        //{ label: 'Divisa', fieldName: 'pcurrency' }

    ];
    dataFromTerminationQuote = []

    connectedCallback() {
        Promise.all([
            loadStyle(this, Animate), loadScript(this, momentJs)
        ])
            .then(console.log('Succes to loading resourse'))
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error loading resourse',
                        message: error.message,
                        variant: 'error',
                    }),
                );
            });
    }

    @wire(getObjectInfo, { objectApiName: WOA_OLFM_Cotizacion_OBJECT })
    WOA_OLFM_Cotizacion_OBJECTInfo;

    @wire(getPicklistValues, { recordTypeId: '$WOA_OLFM_Cotizacion_OBJECTInfo.data.defaultRecordTypeId', fieldApiName: WOA_ls_Detalle_de_la_negociacion })
    async getWOA_ls_Detalle_de_la_negociacion(result) {
        console.log('getWOA_ls_Detalle_de_la_negociacion result ' + JSON.stringify(result) )
        if (await result.data) {
            this.detalleDeLaNegociacionOptions = result.data.values.map(index => {
                return {
                    label: index.label, value: index.value
                }
            })
        } else if (await result.error) {
            console.error('Ocurrió un error al consultar getWOA_ls_Detalle_de_la_negociacion ' + JSON.stringify(result.error))
        }
    }

    @wire(getRecord, {
        recordId: '$recordId', fields: [OEC, OpenItems, NBV, WOA_fh_Fecha_de_terminacion_de_contrato, 
            CurrencyIsoCode, StageName]
    })
    opportunityRecord

    @wire(getContractsFromEntities, { opportunityId: '$recordId' })
    getContracts(result) {
        console.log('recordId ' + this.recordId)
        console.log('result getContracts ' + JSON.stringify(result))
        if (result.data) {
            console.log('this.data ' + this.data);
            result.data.forEach((element) => {
                let jsResponse = JSON.parse(element)
                console.log('jsResponse ' + JSON.stringify(jsResponse))
                let arrayObj = jsResponse.xnvbData
                this.dataFromSearchContract = arrayObj

            });
            console.log(this.dataFromSearchContract);
            this.finishWireGetContracts = true
        } else if (result.error) {
            console.error('error al consultar entidades ' + JSON.stringify(result))
            this.finishWireGetContracts = true
        }
    }
    @wire(getSelectedContracts, { opportunityId: '$recordId' })
    getSelectedContracts(result) {
        console.log('getSelectedContracts ' + JSON.stringify(result))
        this.selectedContractsFromSF = result
        if (result.data) {
            this.dataFromSelectedContract = result.data
            this.finishWireGetSelectedContracts = true
        } else if (result.error) {
            console.error('Ha ocurrido un error ' + JSON.stringify(result.error))
            this.finishWireGetSelectedContracts = true
        }
    }
    handleOpenSearchContractModal() {
        this.showModalBuscarContratos = true
    }
    handleOpenRecalcularNBVModal() {
        this.showModalRecalcularNBV = true
        this.step = '1'
    }
    handleOpenCotizacionTerminacionContrato() {
        this.showModalCotizacionTerminacionContrato = true
        this.step = '1'
    }

    handleCloseModals() {
        this.showModalRecalcularNBV = false
        this.showModalBuscarContratos = false
        this.showModalCotizacionTerminacionContrato = false
    }
    async guardarContratos() {
        this.showModalBuscarContratos = false
        this.showSpinnerInProcess = true
        let listWOA_OLF_contract = this.selectedRowFromOracle.map(index => {
            return {
                WOA_tx_contract_Id__c: index.pcontractId.toString(),
                Name: index.pcontractNumber,
                WOA_tx_Customer_name__c: index.pcustomerName,
                WOA_tx_Product_Name__c: index.pproductName,
                WOA_nu_Term_Months__c: index.ptermMonths,
                WOA_tx_Status__c: index.pstatus,
                WOA_nu_Asset_Quantity__c: index.passetQty,
                WOA_nu_OEC__c: index.poec,
                WOA_nu_NBV__c: index.pnbv,
                WOA_nu_Open_items__c: index.popenItems,
                WOA_pd_Opportunity__c: this.recordId,
                CurrencyIsoCode: index.pcurrency
            }
        })
        await insertContracts({ listWOA_OLF_contract: listWOA_OLF_contract }).then(result => {
            console.log('Se insertó correctamente ');
            this.dispatchEvent(
                new ShowToastEvent({
                    title: "Éxito",
                    message: 'El registro se ha insertado correctamente',
                    variant: "success"
                })
            );
            refreshApex(this.selectedContractsFromSF)
            refreshApex(this.opportunityRecord)

        })
            .catch(error => {
                console.error('error' + JSON.stringify(error));
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: "Error",
                        message: 'Ourrió un error al insertar los registros, contacte a su administrador ',
                        variant: "error"
                    })
                );
            })
        this.showSpinnerInProcess = false
        this.selectedRowFromOracle = []
    }
    getSelectedRowsFromOracle(event) {
        console.info('Inicia getSelectedRowsFromOracle')
        this.selectedRowFromOracle = event.detail.selectedRows;
        console.log('event ' + JSON.stringify(this.selectedRowFromOracle))
    }
    getSelectedRowsFromSF(event) {
        console.info('Inicia getSelectedRowsFromSF')
        this.selectedRowFromSF = event.detail.selectedRows;
        console.log('event ' + JSON.stringify(this.selectedRowFromSF))
    }
    async handleDeleteSelectedRowsFromSF() {
        this.showSpinnerInProcess = true
        await deleteContracts({ listWOA_OLF_contract: this.selectedRowFromSF }).then(result => {
            console.log('Se eliminaron correctamente ' + JSON.stringify(result));
            this.dispatchEvent(
                new ShowToastEvent({
                    title: "Éxito",
                    message: 'Los registros se han eliminados correctamente',
                    variant: "success"
                })
            );
            refreshApex(this.selectedContractsFromSF)
            refreshApex(this.opportunityRecord)
        }).catch(error => {
            console.error('error al eliminar' + JSON.stringify(error));
            this.dispatchEvent(
                new ShowToastEvent({
                    title: "Error",
                    message: 'Ourrió un error al eliminar los registros, contacte a su administrador ',
                    variant: "error"
                })
            );
        });
        this.showSpinnerInProcess = false
    }
    backStep() {
        let currentStep = Number(this.step)
        currentStep = currentStep - 1
        this.step = currentStep.toString()
    }
    nextStep() {
        if (this.showModalRecalcularNBV) {
            let currentStep = Number(this.step)
            if (currentStep === 3) {
                this.updateContracts()
            }
            currentStep = currentStep + 1
            if (currentStep === 2) {
                this.recalcularNBV()
            }
            this.step = currentStep.toString()
        }
    }
    async recalcularNBV() {
        console.info('Inicia recalcularNBV')
        this.showModalRecalcularNBV = false
        this.dataFromRecalculatedContract = []
        this.showSpinnerInProcess = true
        let NBVDate = this.fechaParaNBV
        console.log('NBVDate ' + NBVDate)
        let momentoFecha = moment.utc(NBVDate).format()
        console.log('momentoFecha ' + momentoFecha)
        let contratosARecalcular = this.selectedRowFromSF.map(index => {
            return JSON.stringify({
                pcalcDate: momentoFecha,
                pcontractNumber: index.Name,
            })
        })
        console.log('ss')
        console.log(contratosARecalcular)
        await getNetBookValuesXdate({ listJSONRequest: contratosARecalcular }).then(result => {
            console.log('valores recalculados ' + JSON.stringify(result))
            result.forEach((element) => {
                let jsResponse = JSON.parse(element)
                console.log('jsResponse ' + JSON.stringify(jsResponse))
                Array.prototype.push.apply(this.dataFromRecalculatedContract, jsResponse.xnvbData);
            });
            this.dispatchEvent(
                new ShowToastEvent({
                    title: "Éxito",
                    message: 'Valores recalculados',
                    variant: "success"
                })
            );
            console.log('dataFromRecalculatedContract ' + JSON.stringify(this.dataFromRecalculatedContract))
        }).catch(error => {
            console.error('error al consultar' + JSON.stringify(error));
            this.dispatchEvent(
                new ShowToastEvent({
                    title: "Error",
                    message: 'Ourrió un error al consultar ',
                    variant: "error"
                })
            );
        });
        this.showSpinnerInProcess = false
        this.showModalRecalcularNBV = true
    }
    async solicitudDeTerminacion() {
        console.info('Inicia solicitudDeTerminacion')
        this.showModalCotizacionTerminacionContrato = false
        this.dataFromTerminationQuote = []
        this.showSpinnerInProcess = true 
        let WOA_OLFM_Cotizacion = {
            WOA_pd_Oportunidad__c : this.recordId, 
            WOA_fh_Fecha_terminacion_de_contrato__c : this.template.querySelector("[data-field='fechaTerminacionContrato']").value,
            WOA_ls_Detalle_de_la_negociacion__c : this.detalleDeLaNegociacionValue !== null ? this.detalleDeLaNegociacionValue.join(";") : '' 
        }
        let listContracts = this.selectedRowFromSF.map(index =>{
                return index.Id
            })
        console.log('WOA_OLFM_Cotizacion ' + JSON.stringify(WOA_OLFM_Cotizacion))
        console.log('listContracts ' + JSON.stringify(listContracts))
        await insertQuote({ listContracts: listContracts, WOA_OLFM_Cotizacion : WOA_OLFM_Cotizacion}).then(result => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: "Éxito",
                    message: 'Datos insertados',
                    variant: "success"
                })
            );
        }).catch(error => {
            console.error('error al insetar' + JSON.stringify(error));
            this.dispatchEvent(
                new ShowToastEvent({
                    title: "Error",
                    message: 'Ourrió un error al consultar ',
                    variant: "error"
                })
            );
        });
        this.showSpinnerInProcess = false
    }
    async updateContracts() {
        this.showModalRecalcularNBV = false
        this.showSpinnerInProcess = true
        let dataToUpdate = this.dataFromSelectedContract
        let dataToUpdateD = this.dataFromSelectedContract.map(mapindex => {
            let rowSearched = this.dataFromRecalculatedContract.find(index => index.pcontractNumber === mapindex.Name)
            return {
                //WOA_tx_contract_Id__c : rowSearched.pcontractId.toString(),
                //Name : rowSearched.pcontractNumber,
                //WOA_tx_Customer_name__c : rowSearched.pcustomerName,
                Id: mapindex.Id,
                WOA_tx_Product_Name__c: rowSearched.pproductName,
                WOA_nu_Term_Months__c: rowSearched.ptermMonths,
                WOA_tx_Status__c: rowSearched.pstatus,
                WOA_nu_Asset_Quantity__c: rowSearched.passetQty,
                WOA_nu_OEC__c: rowSearched.poec,
                WOA_nu_NBV__c: rowSearched.pnbv,
                WOA_nu_Open_items__c: rowSearched.popenItems
                //WOA_pd_Opportunity__c : this.recordId,
                //CurrencyIsoCode : rowSearched.pcurrency
            }
        })
        console.log('papas ' + JSON.stringify(dataToUpdateD))
        await updateContracts({ listWOA_OLF_contract: dataToUpdateD }).then(result => {
            console.log('Se actualizó correctamente ');
            this.dispatchEvent(
                new ShowToastEvent({
                    title: "Éxito",
                    message: 'Los registros se han actualizado correctamente',
                    variant: "success"
                })
            );
            refreshApex(this.selectedContractsFromSF)
            refreshApex(this.opportunityRecord)

        })
            .catch(error => {
                console.error('error' + JSON.stringify(error));
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: "Error",
                        message: 'Ourrió un error al actualizar los registros, contacte a su administrador ',
                        variant: "error"
                    })
                );
            })
        this.showSpinnerInProcess = false
    }
    
    handleChangeDualListBox(e) {
        console.log('e.detail.value ' + JSON.stringify(e.detail.value))   
        this.detalleDeLaNegociacionValue = e.detail.value
    }

}