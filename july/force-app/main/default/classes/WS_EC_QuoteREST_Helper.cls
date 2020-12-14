public class WS_EC_QuoteREST_Helper {

  public static EC_Quote__c getEcQuoteById(id ecQuoteId){
    EC_Quote__c ecQuote =[SELECT Id,OwnerId,IsDeleted,Name,CurrencyIsoCode,LastActivityDate,
    LastViewedDate,LastReferencedDate,Book_Yield__c,Correo_eletr_nico__c,ECQ_Opci_n_de_compra__c,
    LMM_Account__c,LMM_Anticipo_a_capital__c,LMM_Ballon__c,LMM_Comision__c,LMM_Deposito_en_gtia__c,
    LMM_Low_High__c,LMM_Meses_en_progress__c,LMM_Nuevo_Usado__c,LMM_Periodo_de_gracia__c,LMM_Progress__c,
    LMM_ROI_Sin_seguro__c,LMM_RV_PO__c,LMM_SL_B__c,LMM_Tipo_de_gracia__c,LMM_Tipo_de_pago__c,
    Monto_Total__c,Nombre_de_contacto__c,Nombre_de_la_empresa__c,Opportunity__c,Pago__c,
    Pago_de_seguro__c,Plazo__c,Prospect__c,RFC__c,RequestAmortizacion__c,Tasa_Activa__c,
    Tel_fono__c,Tipo_de_Financiamiento__c,Tipo_de_activo__c,Tipo_de_persona__c,Ubicaci_n__c,
    Valor_del_activo__c,Ventas_Ingresos_anuales__c,LMM_Gross_Margin__c,LMM_Periodo_de_pagos_progresivos__c,
    LMM_Segmento_de_Mercado__c,LMM_Seguro_EC_Financiado__c,LMM_Solo_AP_Final_de_arrendamiento__c,
    LMM_fh_Fecha_de_inicio_del_arrendamiento__c,LMM_fh_Fecha_de_inicio_del_plazo_basico__c 
    FROM EC_Quote__c WHERE Id =:ecQuoteId LIMIT 1];
    return ecQuote;
  }
}