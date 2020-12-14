import { LightningElement, track, api } from 'lwc';
import getQuote from '@salesforce/apex/Data_Acess_EC_Quote.getQuoteById';
import calcularCotizacion from '@salesforce/apex/CotizadorController.calcularCotizacion';
import columnas from "./fetchDataHelper"
const columns = columnas;

export default class EcQuoteAmortizacion extends LightningElement {
    @api recordId;
    @track quote;
    @track dataResult = {};
    @track lstAmortizacion = [];
    @track lstcuenta=[];
    @track tablecols = columns.columnas;

    async connectedCallback(){
        try{
            let cotizacion = await getQuote({recordId:this.recordId});
            this.quote = cotizacion;
        }catch(error){
            console.log('error al consultar la cotizacion');
            console.log(error);
        }

        this.getAmortizacion();
    }






    async getAmortizacion (){
        if(this.quote){
            console.log('Cotizacion')
            console.log(this.quote);
            let request = JSON.parse(this.quote.RequestAmortizacion__c)
            let data = JSON.stringify(request.data);
            let programId = request.programId;
            let userId = request.userId
            try{
              let response = await calcularCotizacion({
                    userId: userId,
                    programId: programId,
                    data: data
                });

                this.dataResult = JSON.parse(response);
                if(this.dataResult.success){
                    
                    this.lstAmortizacion = this.dataResult.classObject.quoteDetailDTO.lstQuotePeriods;
                    this.dataResult.classObject.quoteDetailDTO.strCurrencyCode = this.dataResult.classObject.quoteDetailDTO.currencyAssetsDTO.strCurrencyCode
                    this.lstcuenta =[this.dataResult.classObject.quoteDetailDTO];
                    this.dataResult.classObject.quoteDetailDTO.strDescription = this.dataResult.classObject.programDTO.lstFinancialTypes.strDescription
  
                      //this.data = this.dataResult.classObject.quoteDetailDTO.dblMonthlyPayment;
                    // console.log('IMPRIMIENDO DATA:'+this.data)
                    console.log(this.dataResult)
                } else {
                    throw "Error al consultar servicio de amortizacion"
                }
            }catch(error){
                console.log('Error al consultar amortizacion');
                console.log(error);
            }finally{

            }
            
        }
    }
}