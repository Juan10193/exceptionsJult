/**
 * @description       : 
 * @author            : eduardo.amiens@outlook.com
 * @group             : 
 * @last modified on  : 11-13-2020
 * @last modified by  : eduardo.amiens@outlook.com
 * Modifications Log 
 * Ver   Date         Author                       Modification
 * 1.0   10-30-2020   eduardo.amiens@outlook.com   Initial Version
**/
import { LightningElement, api, wire } from 'lwc';
import getQuotes from "@salesforce/apex/woaEOLQuoteController.getQuotes"
import getSelectedContracts from "@salesforce/apex/woaEOLQuoteController.getSelectedContracts"
import { ShowToastEvent } from 'lightning/platformShowToastEvent'
import submitForApproval from '@salesforce/apex/wkaCustomAPDetailController.submitForApproval';
export default class WoaEOLQuote extends LightningElement {
    @api recordId
    dataFromSelectedContract
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

    columsQuotes = [
        { label: 'Folio', fieldName: 'Name' },
        { label: 'Detalle de la negociación', fieldName: 'WOA_ls_Detalle_de_la_negociacion__c' },
        { label: 'Fecha de terminación', fieldName: 'WOA_fh_Fecha_terminacion_de_contrato__c' },
        { label: 'Estatus', fieldName: 'WOA_ls_Stage__c' },
        {
            type: "button",
            fixedWidth: 150,
            typeAttributes: {
                label: 'Ver Detalles',
                title: 'Ver Detalles',
                name: 'verDetalles',
                value: 'verDetalles',
                variant: 'brand',
                class: 'scaled-down'
            }
        }
    ];
    dataQuotes

    calculateNBV
    calculateEOC
    calculateOI

    selectedRecordId
    WOA_ls_Stage

    @wire(getQuotes, { opportunityId: '$recordId' })
    Quotes(result) {
        console.log('result Quotes' + JSON.stringify(result))
        if (result.data) {
            this.dataQuotes = result.data
        } else if (result.error) {
            console.error(result.error)
        }
    }

    async callRowAction(event) {
        this.selectedRecordId = event.detail.row.Id
        const recId = event.detail.row.Id
        const actionName = event.detail.action.name
        if (actionName === 'verDetalles') {
            this.WOA_ls_Stage = 'Estatus de aprobación: ' + event.detail.row.WOA_ls_Stage__c
            console.log('hi ' + JSON.stringify(event.detail.row))
            await getSelectedContracts({ quotedId: recId }).then(result => {
                console.log('getSelectedContracts ' + JSON.stringify(result));
                this.dataFromSelectedContract = result
                let calculateNBV = this.dataFromSelectedContract.map(index => {
                    return index.WOA_nu_NBV__c
                })
                let calculateEOC = this.dataFromSelectedContract.map(index => {
                    return index.WOA_nu_OEC__c
                })
                let calculateOI = this.dataFromSelectedContract.map(index => {
                    return index.WOA_nu_Open_items__c
                })
                let reducer = (accumulator, currentValue) => accumulator + currentValue;
                this.calculateNBV = calculateNBV.reduce(reducer)
                this.calculateEOC = calculateEOC.reduce(reducer)
                this.calculateOI = calculateEOC.reduce(reducer)
            })
                .catch(error => {
                    console.error('error' + JSON.stringify(error));
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: "Error",
                            message: 'Ourrió un error al buscar los registros ',
                            variant: "error"
                        })
                    );
                })

        }
    }
    async handleSubmitForApproval() {
        let recordIds = []
        recordIds.push(this.selectedRecordId)

        console.log('selectedRecordId ' + this.selectedRecordId)
        await submitForApproval({ recordIds: recordIds }).then(result => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: "Éxito",
                    message: 'Se ha enviado a aprobación el registro ',
                    variant: "success"
                })
            );
        }).catch(error => {
            console.error('error' + JSON.stringify(error));
            this.dispatchEvent(
                new ShowToastEvent({
                    title: "Error",
                    message: 'Ourrió un error al enviar a aprobación ',
                    variant: "error"
                })
            );
        })
    }
}