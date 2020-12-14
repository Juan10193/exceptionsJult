@IsTest
public class DataConnectQuoteSeguros_cls_test {

    static TestMethod void consumeServiceQuote() {
        Map<String, Object> getResponse = new Map<String, Object>();
		List<JsonQuote.Bien> listBien = new List<JsonQuote.Bien>();
        
        JsonQuote.Bien bien = new JsonQuote.Bien();
        bien.claveBienRiesgo = 'EQUIPO_ELECTRONICO_FIJO';
        bien.sumaAsegurada = 100000;
        listBien.add(bien);
        
        DataConnectQuoteSeguros_cls dataCls = new DataConnectQuoteSeguros_cls();
        getResponse = DataConnectQuoteSeguros_cls.getQuotes(listBien, 12, 'MXN', 566, 'N', 'ENGENCAP_FIN');
    }
    
    static TestMethod void createdTabled() {
        String json = '{'+
		'    \"quote\": {'+
		'      \"data\": ['+
		'        {'+
		'          \"id\": 1,'+
		'          \"idCotizacion\": null,'+
		'          \"idBienRiesgo\": 10,'+
		'          \"descripcion\": \"Equipo Electrónico Fijo\",'+
		'          \"sumaAsegurada\": \"100000\",'+
		'          \"periodoCotizacion\": 12,'+
		'          \"primaNeta\": \"206\",'+
		'          \"primaNetaTotal\": \"2781\",'+
		'          \"gastos\": \"0\",'+
		'          \"subtotal\": \"2781\",'+
		'          \"iva\": \"444.96\",'+
		'          \"primaTotal\": \"3225.96\",'+
		'          \"primaNetaLabel\": \"$ 206.00\",'+
		'          \"primaNetaTotalLabel\": \"$ 2,781.00\",'+
		'          \"gastosLabel\": \"$ 0.00\",'+
		'          \"subtotalLabel\": \"$ 2,781.00\",'+
		'          \"ivaLabel\": \"$ 444.96\",'+
		'          \"primaTotalLabel\": \"$ 3,225.96\"'+
		'        },'+
		'        {'+
		'          \"id\": 2,'+
		'          \"idCotizacion\": null,'+
		'          \"idBienRiesgo\": 11,'+
		'          \"descripcion\": \"Equipo Electrónico Móvil\",'+
		'          \"sumaAsegurada\": \"500000\",'+
		'          \"periodoCotizacion\": 12,'+
		'          \"primaNeta\": \"2575\",'+
		'          \"primaNetaTotal\": \"2781\",'+
		'          \"gastos\": \"0\",'+
		'          \"subtotal\": \"2781\",'+
		'          \"iva\": \"444.96\",'+
		'          \"primaTotal\": \"3225.96\",'+
		'          \"primaNetaLabel\": \"$ 2,575.00\",'+
		'          \"primaNetaTotalLabel\": \"$ 2,781.00\",'+
		'          \"gastosLabel\": \"$ 0.00\",'+
		'          \"subtotalLabel\": \"$ 2,781.00\",'+
		'          \"ivaLabel\": \"$ 444.96\",'+
		'          \"primaTotalLabel\": \"$ 3,225.96\"'+
		'        }'+
		'      ]'+
		'    },'+
		'    \"status\": {'+
		'      \"code\": null,'+
		'      \"message\": null,'+
		'      \"detail\": \"S\"'+
		'    }'+
		'  }';
        
        DataConnectQuoteSeguros_cls.createdTable(json);
    }
    
    static TestMethod void saveQuote() {
        String quote = '[{"descripcion":"Equipo Electrónico Fijo","gastos":"0","gastosLabel":"$ 0.00","id":1,"idBienRiesgo":10,"iva":"296.64","ivaLabel":"$ 296.64","periodoCotizacion":12,"primaNeta":"1853.998","primaNetaLabel":"$ 1,854.00","primaNetaTotal":"1853.998","primaNetaTotalLabel":"$ 1,854.00","primaTotal":"2150.638","primaTotalLabel":"$ 2,150.64","subtotal":"1853.998","subtotalLabel":"$ 1,854.00","sumaAsegurada":"899999"}]';
    	List<WrapperQuoteSeguros_cls.Data> jsonWrapper = (List<WrapperQuoteSeguros_cls.Data>)System.JSON.deserialize(quote, List<WrapperQuoteSeguros_cls.Data>.class) ;
        String moneda = 'MXN';
        String producto = 'Term Loan';
        String razonSocial = 'ENGENCAP_FIN';
        Account testAcct = new Account (Name= 'My Test Account', BillingState= 'Puebla', BillingStreet= 'Example', BillingCountry = 'México', BillingPostalCode = '98760');
     	insert testAcct;

    	Opportunity oppt = new Opportunity(Name ='New mAWS Deal',
                            				AccountID = testAcct.ID,
                            				StageName = 'New',
                            				Amount = 3000,
                            				CloseDate = System.today());

   		insert oppt;
        
        DataConnectQuoteSeguros_cls.createdQuotes(jsonWrapper, oppt.Id, moneda, producto, razonSocial);
    }
    
    static TestMethod void getAllCuote() {
        Account testAcct = new Account (Name= 'My Test Account', BillingState= 'Puebla', BillingStreet= 'Example', BillingCountry = 'México', BillingPostalCode = '98760');
     	insert testAcct;
        List<id> idQuotte = new List<Id>();

    	Opportunity oppt = new Opportunity(Name ='New mAWS Deal',
                            				AccountID = testAcct.ID,
                            				StageName = 'New',
                            				Amount = 3000,
                            				CloseDate = System.today());

   		insert oppt;
        
        Cotizacion_seguro__c example = new Cotizacion_seguro__c(QS_Id_Quote__c = 1,
			//QS_Id_Cotizacion__c = flag.idCotizacion;
			QS_Clave_Bien_Riesgo__c = String.valueOf('11'),
			QS_descripcion__c = 'Equipo Electrónico Móvil',
			QS_Suma_Asegurada__c = 500000,
			QS_Periodo_Cotizacion__c = 12,
			QS_Prima_Neta__c = 23,
			QS_Prima_Neta_Total__c = 0,
			QS_Gastos__c = 0,
			QS_Subtotal__c = 0,
			QS_IVA__c = 0,
			QS_Prima_Total__c = 0,
			QS_Prima_Neta_Label__c = '0',
			QS_Prima_Neta_Total_Label__c = '0',
			QS_Gastos_Label__c = '0',
			QS_Subtotal_Label__c = '0',
			QS_IVA_Label__c = '0',
			QS_Prima_Total_Label__c = '0',
            Opportunity__c = oppt.Id);
        
        insert example;
        idQuotte.add(example.Id);
        DataConnectQuoteSeguros_cls.getCurrencyCode(oppt.Id);
        DataConnectQuoteSeguros_cls.getSeguroCotizacion(oppt.Id);
        DataConnectQuoteSeguros_cls.deleteRecordsTable(idQuotte);
    }
}