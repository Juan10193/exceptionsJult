@istest
global class MockGttpcallBackAuditEntity implements HttpCalloutMock {
	// Implement this interface method
    global HTTPResponse respond(HTTPRequest request) {
         
        // Optionally, only send a mock response for a specific endpoint
        // and method.
        System.assertEquals('Data dummy/EcRequestSbDat/RequestRs/requests/audits?sourceId=partyId&sourceCode=Entity%20Master', request.getEndpoint());
        System.assertEquals('GET', request.getMethod());
        
        // Create a fake response
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"entityInfo" : {"entities" : null,"privilege" : {"sso" : null,"applicationName" : null,"applicationCode" : null,"screen" : null,"employeeName" : null,"vCrud" : null}},"status" : {"message" : "S","detail" : "Success"}}');
        response.setStatusCode(200);
        return response;
    }  
}