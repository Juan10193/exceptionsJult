/**
 * @File Name          : Data_Acess_EC_Quote.cls
 * @Description        : 
 * @Author             : angel87ambher@gmail.com
 * @Group              : 
 * @Last Modified By   : angel87ambher@gmail.com
 * @Last Modified On   : 10/6/2020 1:34:26
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    9/6/2020   angel87ambher@gmail.com     Initial Version
**/
public without sharing class Data_Acess_EC_Quote {
   
    @AuraEnabled(Cacheable=false)
    public static EC_Quote__c getQuoteById(string recordId){
        EC_Quote__c ecquote = [SELECT Id, OwnerId, IsDeleted, Name, CurrencyIsoCode, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, 
                            Tipo_de_Financiamiento__c, Pago__c, Tasa_Activa__c, Book_Yield__c, Monto_Total__c, 
                            Pago_de_seguro__c, Ubicaci_n__c, Ventas_Ingresos_anuales__c, Tipo_de_activo__c, Tipo_de_persona__c, Nombre_de_la_empresa__c, Nombre_de_contacto__c, RFC__c, 
                            Correo_eletr_nico__c, Tel_fono__c, Plazo__c, Valor_del_activo__c, Opportunity__c, RequestAmortizacion__c,
                            LMM_Deposito_en_gtia__c, LMM_Comision__c, LMM_Anticipo_a_capital__c, ECQ_Opci_n_de_compra__c 
                            FROM EC_Quote__c WHERE Id =:recordId][0];
        
        return ecquote;
    }
    
    @AuraEnabled
    public static List<EC_Quote__c> getQuotesByOpId(string recordId){
        List<EC_Quote__c> quotes =[SELECT Id, OwnerId, IsDeleted, Name, CurrencyIsoCode, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, 
        Tipo_de_Financiamiento__c, Pago__c, Tasa_Activa__c, Book_Yield__c, Monto_Total__c, 
        Pago_de_seguro__c, Ubicaci_n__c, Ventas_Ingresos_anuales__c, Tipo_de_activo__c, Tipo_de_persona__c, Nombre_de_la_empresa__c, Nombre_de_contacto__c, RFC__c, 
        Correo_eletr_nico__c, Tel_fono__c, Plazo__c, Valor_del_activo__c, Opportunity__c, RequestAmortizacion__c FROM EC_Quote__c WHERE Opportunity__c =:recordId ];

        return quotes;
    }
    

    @AuraEnabled(Cacheable=false)
    public static EC_Quote__c getQuoteByIdOp(string recordId){
        EC_Quote__c ecquote = [SELECT Id, OwnerId, IsDeleted, Name, Opportunity__c, CurrencyIsoCode, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, 
                            Tipo_de_Financiamiento__c, Pago__c, Tasa_Activa__c, Book_Yield__c, Monto_Total__c, 
                            Pago_de_seguro__c, Ubicaci_n__c, Ventas_Ingresos_anuales__c, Tipo_de_activo__c, Tipo_de_persona__c, Nombre_de_la_empresa__c, Nombre_de_contacto__c, RFC__c, 
                            Correo_eletr_nico__c, Tel_fono__c, Plazo__c, Valor_del_activo__c, RequestAmortizacion__c,
                            LMM_Deposito_en_gtia__c, LMM_Comision__c, LMM_Anticipo_a_capital__c, ECQ_Opci_n_de_compra__c,LMM_Periodo_de_gracia__c
                            FROM EC_Quote__c WHERE Opportunity__c =:recordId][0];
        
        return ecquote;
    }

    @AuraEnabled
    public static List<EC_Quote__c> getQuotesByOpId2(string opportunityId){
        List<EC_Quote__c> quotes2 =[SELECT Id, OwnerId, IsDeleted, Name, CurrencyIsoCode, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, 
        Tipo_de_Financiamiento__c, Pago__c, Tasa_Activa__c, Book_Yield__c, Monto_Total__c, LMM_Tipo_de_gracia__c,
        Pago_de_seguro__c, Ubicaci_n__c, Ventas_Ingresos_anuales__c, Tipo_de_activo__c, Tipo_de_persona__c, Nombre_de_la_empresa__c, Nombre_de_contacto__c, RFC__c, 
        Correo_eletr_nico__c, Tel_fono__c, Plazo__c, Valor_del_activo__c, Opportunity__c, RequestAmortizacion__c FROM EC_Quote__c WHERE Opportunity__c =:opportunityId ];

        return quotes2;
    }


}