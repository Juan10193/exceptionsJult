@IsTest
public class WrapperQuoteSeguros_cls_test {
	
    static testMethod void testRquest() {
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
        
        System.debug(WrapperQuoteSeguros_cls.parse(json));
    }
}