public with sharing class DataConnectQuoteSeguros_cls {
    
    public DataConnectQuoteSeguros_cls() {
        
    }
    
    public static List<Opportunity> getCurrencyCode(String idOpportunidad) {
        return [SELECT id, CurrencyIsoCode, OPP_ls_Product__c FROM Opportunity WHERE id =: idOpportunidad LIMIT 1];
    }
    
    public static Map<String, Object> getQuotes(List<JsonQuote.Bien> lstBien, Integer periodo, String moneda, Integer clavePromotor, String conservarCotizacion, String razonSocialConsulta) {
        List<JsonQuote.Bien> listBien = new List<JsonQuote.Bien>();
        List<JsonQuote.Data> datas = new List<JsonQuote.Data>();
        Map<String, Object> empty = new Map<String, Object>();
        
        for(JsonQuote.Bien flag : lstBien) {
        	JsonQuote.Bien bien = new JsonQuote.Bien();
        	bien.claveBienRiesgo = flag.claveBienRiesgo;
			bien.sumaAsegurada = flag.sumaAsegurada;
        	listBien.add(bien);
    	}
        
        JsonQuote.Coberturas coberturas = new JsonQuote.Coberturas();
		coberturas.bien = listBien;
        
        JsonQuote.Data data = new JsonQuote.Data();
		data.periodo = periodo;
		data.moneda = moneda;
		data.clavePromotor = clavePromotor;
		data.conservarCotizacion = conservarCotizacion;
		data.coberturas = coberturas;
		datas.add(data);
        
        JsonQuote jsonData = new JsonQuote();
		jsonData.data = datas;
        
        JsonQuote.Quote_Z quote_Z = new JsonQuote.Quote_Z();
		quote_Z.razonSocialConsulta = razonSocialConsulta;
		quote_Z.quote = jsonData;
        System.debug(Test.isRunningTest() ? empty : ConsumeQuoteSeguro_cls.createdQuote(System.JSON.serialize(quote_Z))); 
        return Test.isRunningTest() ? empty : ConsumeQuoteSeguro_cls.createdQuote(System.JSON.serialize(quote_Z));
    }
    
    public static List<WrapperQuoteSeguros_cls.Data> createdTable(String jsonResponse) {
        WrapperQuoteSeguros_cls listQuotes = WrapperQuoteSeguros_cls.parse(jsonResponse);
        List<WrapperQuoteSeguros_cls.Data> listTable = new List<WrapperQuoteSeguros_cls.Data>();
		System.debug(jsonResponse.length());        
        if(jsonResponse.length() > 10){
            for(WrapperQuoteSeguros_cls.Data flag :  listQuotes.quote.data) {
                WrapperQuoteSeguros_cls.Data quote = new WrapperQuoteSeguros_cls.Data();
                quote.id = flag.id;
                //quote.idCotizacion = flag.idCotizacion;
                quote.idBienRiesgo = flag.idBienRiesgo;
                quote.descripcion = flag.descripcion;
                /*quote.sumaAsegurada = flag.sumaAsegurada;
                quote.periodoCotizacion = flag.periodoCotizacion;
                quote.primaNeta = flag.primaNeta;
                quote.primaNetaTotal = flag.primaNetaTotal;
                quote.gastos = flag.gastos;
                quote.subtotal = flag.subtotal;
                quote.iva = flag.iva;
                quote.primaTotal = flag.primaTotal;
                quote.primaNetaLabel = flag.primaNetaLabel;
                quote.primaNetaTotalLabel = flag.primaNetaTotalLabel;
                quote.gastosLabel = flag.gastosLabel;
                quote.subtotalLabel = flag.subtotalLabel;
                quote.ivaLabel = flag.ivaLabel;
                quote.primaTotalLabel = flag.primaTotalLabel;*/
                listTable.add(quote);
            }
        }
        
        return listTable;
    }
    
    public static void createdQuotes(List<WrapperQuoteSeguros_cls.Data> listQuotes, String IdOpportunity, String divisa, String producto, String razonSocial) {
        //WrapperQuoteSeguros_cls listQuotes = WrapperQuoteSeguros_cls.parse(jsonResponse);
        List<Cotizacion_seguro__c> listSeguro = new List<Cotizacion_seguro__c>();
        
        for(WrapperQuoteSeguros_cls.Data flag :  listQuotes){
            Cotizacion_seguro__c newSeguro = new Cotizacion_seguro__c();
			newSeguro.QS_Id_Quote__c = flag.id ;
			//newSeguro.QS_Id_Cotizacion__c = flag.idCotizacion;
			newSeguro.QS_Clave_Bien_Riesgo__c = String.valueOf(flag.idBienRiesgo);
			newSeguro.QS_descripcion__c = flag.descripcion;
			newSeguro.QS_Suma_Asegurada__c = Decimal.valueOf(flag.sumaAsegurada);
			newSeguro.QS_Periodo_Cotizacion__c = flag.periodoCotizacion;
			newSeguro.QS_Prima_Neta__c = Decimal.valueOf(flag.primaNeta);
			newSeguro.QS_Prima_Neta_Total__c = Decimal.valueOf(flag.primaNetaTotal);
			newSeguro.QS_Gastos__c = Decimal.valueOf(flag.gastos);
			newSeguro.QS_Subtotal__c = Decimal.valueOf(flag.subtotal);
			newSeguro.QS_IVA__c = Decimal.valueOf(flag.iva);
			newSeguro.QS_Prima_Total__c = Decimal.valueOf(flag.primaTotal);
			newSeguro.QS_Prima_Neta_Label__c = flag.primaNetaLabel;
			newSeguro.QS_Prima_Neta_Total_Label__c = flag.primaNetaTotalLabel;
			newSeguro.QS_Gastos_Label__c = flag.gastosLabel;
			newSeguro.QS_Subtotal_Label__c = flag.subtotalLabel;
			newSeguro.QS_IVA_Label__c = flag.ivaLabel;
			newSeguro.QS_Prima_Total_Label__c = flag.primaTotalLabel;
            newSeguro.Opportunity__c = IdOpportunity;
            newSeguro.CurrencyIsoCode = divisa; 
            newSeguro.Producto__c = producto;
            newSeguro.QS_Razon_social__c = razonSocial;
            listSeguro.add(newSeguro);
        }
        
        try {
            insert listSeguro;
        }catch(dmlexception e) {
            System.debug('Error created record: ' + e.getMessage());
        }
    }
    
    public static void deleteRecordsTable(list<Id> listIdCotizacionSeguro) {
        try {
            List<Cotizacion_seguro__c> listCotizacion = new List<Cotizacion_seguro__c>();
            for(Id flag : listIdCotizacionSeguro) {
                listCotizacion.add(new Cotizacion_seguro__c(Id = flag));
            }
            if(!listCotizacion.isEmpty()) {
				delete listCotizacion;
            }
        } 
        catch (Exception ex) {
            System.debug(ex.getMessage());
            throw new AuraHandledException(ex.getMessage());
        }
    }
    
    public static List<Cotizacion_seguro__c> getSeguroCotizacion(String idOpportunity) {
        List<Cotizacion_seguro__c> allSeguroCotizacion = new List<Cotizacion_seguro__c>();
		for(Cotizacion_seguro__c flag : [SELECT QS_descripcion__c, QS_Suma_Asegurada__c, CurrencyIsoCode, QS_Prima_Neta_Label__c, QS_Gastos_Label__c, QS_IVA_Label__c, QS_Prima_Neta_Total_Label__c, QS_Prima_Total_Label__c, CreatedDate, QS_Prima_Neta__c, QS_Gastos__c, QS_IVA__c, QS_Prima_Total__c, QS_Periodo_Cotizacion__c, QS_Razon_social__c FROM Cotizacion_seguro__c WHERE Opportunity__c =: idOpportunity ORDER BY CreatedDate DESC]) {
        	allSeguroCotizacion.add(flag);
        }
        return allSeguroCotizacion;
    }
}