@istest
global class MockHttpGetHitsAmlreview implements HttpCalloutMock{
	// Implement this interface method
    global HTTPResponse respond(HTTPRequest request) {
         
        // Optionally, only send a mock response for a specific endpoint
        // and method.
        System.assertEquals('https://ecoasdev01.engeniumcapital.mx:7035/EcAmlSbDat/AmlRs/aml/hits/queries', request.getEndpoint());
        System.assertEquals('POST', request.getMethod());
        
        // Create a fake response
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{'+
		'   "result": {'+
		'       "amlHits": ['+
		'           {'+
		'               "partyId": 17101,'+
		'               "entityName": "ARRENDADORA Y COMERCIALIZADORA LINGO, S.A. DE C.V. SOFOM E.N.R.",'+
		'               "entityType": "SELECTION",'+
		'               "customerType": "ORGANIZATION",'+
		'               "rfc": "ACL0311108T9",'+
		'               "sicCode": "6159",'+
		'               "sicCodeDescription": "Misc business credit institutions",'+
		'               "country": "MX",'+
		'               "hits": "true",'+
		'               "hitDescription": "WL3, ARRENDADORA Y COMERCIALIZADORA LINGO, S.A. DE C.V.  *RFC: ACL0311108T9 *CATEGORY: WL3. *STATUS: CONSULTA AL EQUIPO DE COMPLIANCE, %",'+
		'               "crr": "LOW"'+
		'           },'+
		'           {'+
		'               "partyId": 24678,'+
		'               "entityName": "BREMBO MEXICO, S.A. DE C.V.",'+
		'               "customerType": "ORGANIZATION",'+
		'               "rfc": "BME9604186V4",'+
		'               "sicCode": "3714",'+
		'               "sicCodeDescription": "Mfg motor vehicle parts/accessories",'+
		'               "country": "MX",'+
		'               "state": "NL",'+
		'               "hits": "false",'+
		'               "crr": "LOW"'+
		'           }'+
		'       ]'+
		'   },'+
		'   "status": {'+
		'       "code": null,'+
		'       "message": "Success",'+
		'       "detail": "S"'+
		'   }'+
		'}');
        response.setStatusCode(200);
        return response;
    }    
}