function createCotizacion(lstcuenta, dataCalcular, requestAmort, selectedData, dataIniciar){
    let cotizacion =  { 'sobjectType': 'EC_Quote__c' };
    cotizacion.Book_Yield__c =lstcuenta[0].dblBookYield;
    cotizacion.Correo_eletr_nico__c = dataCalcular.strEmailToSend;
    cotizacion.Monto_Total__c = lstcuenta[0].dblTotalAmount;
    cotizacion.Nombre_de_contacto__c = dataCalcular.strContactName;
    cotizacion.Nombre_de_la_empresa__c = dataCalcular.strClientName;
    cotizacion.Pago__c = lstcuenta[0].dblMonthlyPayment;
    cotizacion.Pago_de_seguro__c = lstcuenta[0].dblFinancialInsuranceValue;
    cotizacion.Plazo__c = dataCalcular.financialTermsDTO.intTermValue.toString();
    cotizacion.RFC__c = dataCalcular.detFreeQuotationDTO.strRfc;
    cotizacion.Tasa_Activa__c = lstcuenta[0].dblRealRate;
    cotizacion.Tel_fono__c = dataCalcular.detFreeQuotationDTO.strPhoneNumber;
    cotizacion.Tipo_de_activo__c = dataCalcular.lstQuotationAssets[0].assetDTO.strDescription;
    cotizacion.Tipo_de_Financiamiento__c = dataCalcular.financialTypeDTO.strFinancialTypeKey;
    cotizacion.Tipo_de_persona__c = dataCalcular.detFreeQuotationDTO.strPersonType;
    cotizacion.Ubicaci_n__c = dataCalcular.stateDTO.strCode;
    cotizacion.Valor_del_activo__c = dataCalcular.lstQuotationAssets[0].fltAmount;
    cotizacion.Ventas_Ingresos_anuales__c = dataCalcular.detFreeQuotationDTO.annualIncomeTypeDTO.strDescription;
    cotizacion.CurrencyIsoCode = dataCalcular.currencyDTO.strCurrencyCode;
    cotizacion.RequestAmortizacion__c = (JSON.stringify(requestAmort)).replace('\\n','').replace('\\','');
    if(selectedData.sObjectType === "Account"){
        cotizacion.LMM_Account__c = selectedData.Id;
    }else if(selectedData.sObjectType ==="Lead"){
        cotizacion.Prospect__c = selectedData.Id;
    }
    cotizacion.LMM_Comision__c = dataIniciar.classObject.programDTO.lstWsProgramInputDatas.find(x => x.strInputdataKey == 'COMMISSION_OPENING').fltEnteredValue
    cotizacion.LMM_Anticipo_a_capital__c =  dataIniciar.classObject.programDTO.lstWsProgramInputDatas.find(x => x.strInputdataKey == 'HITCH').fltEnteredValue
    cotizacion.LMM_Deposito_en_gtia__c = dataIniciar.classObject.programDTO.lstWsProgramInputDatas.find(x => x.strInputdataKey == 'SECURITY_DEPOSIT').fltEnteredValue
    cotizacion.ECQ_Opci_n_de_compra__c = dataIniciar.classObject.programDTO.lstWsProgramInputDatas.find(x => x.strInputdataKey == 'PURCHASE_OPTION').fltEnteredValue
console.log('compra')
console.log(cotizacion.ECQ_Opci_n_de_compra__c);
    console.log(cotizacion);
    return cotizacion;
}

export {createCotizacion}