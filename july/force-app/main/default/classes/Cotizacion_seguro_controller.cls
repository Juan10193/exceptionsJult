public with sharing class Cotizacion_seguro_controller {

   	@AuraEnabled(cacheable=true)
    public static List<Opportunity> getMoneda(String idOpportunidad) {
        return DataConnectQuoteSeguros_cls.getCurrencyCode(idOpportunidad);
    }
    
    @AuraEnabled(cacheable=true)
    public static String getCotizacionSeguro (String razonSocialConsulta, String periodo, String moneda, String clavePromotor, String conservarCotizacion, String claveBienRiesgo, String sumaAsegurada) {  
    	List<WrapperQuoteSeguros_cls.Data> listTable = new List<WrapperQuoteSeguros_cls.Data>();
		Map<String, Object> getResponse = new Map<String, Object>();
		List<JsonQuote.Bien> listBien = new List<JsonQuote.Bien>();

		JsonQuote.Bien bien = new JsonQuote.Bien();
		bien.claveBienRiesgo = claveBienRiesgo;
		bien.sumaAsegurada = Integer.valueOf(sumaAsegurada);
		listBien.add(bien);
        
        getResponse = DataConnectQuoteSeguros_cls.getQuotes(listBien, Integer.valueOf(periodo), moneda, 566, 'N', razonSocialConsulta);
        return JSON.serialize(getResponse);
    }
    
    @AuraEnabled
    public static void insertCotizacionSeguro(String json, String idOpportunity, String divisa, String producto, String razonSocial){
        List<WrapperQuoteSeguros_cls.Data> jsonWrapper = (List<WrapperQuoteSeguros_cls.Data>)System.JSON.deserialize(json, List<WrapperQuoteSeguros_cls.Data>.class) ;
        DataConnectQuoteSeguros_cls.createdQuotes(jsonWrapper, idOpportunity, divisa, producto, razonSocial);
    }
    
	@AuraEnabled(cacheable=true)
    public static List<Cotizacion_seguro__c> getAllCotizaciones(String idOpportunity) {
        return DataConnectQuoteSeguros_cls.getSeguroCotizacion(idOpportunity);
    }
    
    @AuraEnabled
    public static void deleteCotizacion(list<Id> listIdCotizacionSeguro) {
        DataConnectQuoteSeguros_cls.deleteRecordsTable(listIdCotizacionSeguro);
    }
}