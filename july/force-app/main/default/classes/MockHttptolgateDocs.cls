@Istest
global class  MockHttptolgateDocs implements HttpCalloutMock {
	// Implement this interface method
    global HTTPResponse respond(HTTPRequest request) {
        
        // Optionally, only send a mock response for a specific endpoint
        // and method.
        System.assertEquals('https://test.com/EcRequestSbDat/RequestRs/requests/documents?requestId=999999999&sourceCAId=12', request.getEndpoint());
        System.assertEquals('GET', request.getMethod());
        
        // Create a fake response
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{'+
		'  "documentsList" : {'+
		'    "document" : [ {'+
		'      "requestId" : 999999999,'+
		'      "comment" : "Documento agregado desde Salesforce request ID: 999999999",'+
		'      "sourceCAId" : "12",'+
		'      "contentDocId" : 7550,'+
		'      "id" : 111,'+
		'      "type" : "Commercial Proposal",'+
		'      "name" : "TI-FO-SDLC-02-00 Crit Acept SPRINT 2 Pre Screening V1_3 Firmado.pdf",'+
		'      "url" : "TI-FO-SDLC-02-00 Crit Acept SPRINT 2 Pre Screening V1_3 Firmado.pdf",'+
		'      "startDate" : "2019/01/02 00:00:00",'+
		'      "endDate" : "2019/01/03 00:00:00",'+
		'      "createdBy" : "212584312",'+
		'      "nameCreatedBy" : "Erick Rojo",'+
		'      "creationDate" : "2019/01/02 05:16:46",'+
		'      "updatedBy" : "212584312",'+
		'      "nameUpdatedBy" : "Erick Rojo"'+
		'    }, {'+
		'      "requestId" : 999999999,'+
		'      "comment" : "Documento agregado desde Salesforce request ID: 999999999",'+
		'      "sourceCAId" : "12",'+
		'      "contentDocId" : 7600,'+
		'      "id" : 112,'+
		'      "type" : "Write Up",'+
		'      "name" : "TI-FO-SDLC-02-00 Crit Acept SPRINT 2 Pre Screening V1_3 Firmado.pdf",'+
		'      "url" : "TI-FO-SDLC-02-00 Crit Acept SPRINT 2 Pre Screening V1_3 Firmado.pdf",'+
		'      "startDate" : "2019/01/03 00:00:00",'+
		'      "endDate" : "2019/01/04 00:00:00",'+
		'      "createdBy" : "212584312",'+
		'      "nameCreatedBy" : "Erick Rojo",'+
		'      "creationDate" : "2019/01/02 05:17:38",'+
		'      "updatedBy" : "212584312",'+
		'      "nameUpdatedBy" : "Erick Rojo"'+
		'    } ]'+
		'  },'+
		'  "status" : {'+
		'    "code" : null,'+
		'    "message" : "Success",'+
		'    "detail" : "S"'+
		'  }'+
		'}');
        response.setStatusCode(200);
        return response;
    }
}