@isTest
global class MockHttpES3_DocSInRequestCalloutClass implements HttpCalloutMock{
    // Implement this interface method
    global HTTPResponse respond(HTTPRequest request) {
            // Optionally, only send a mock response for a specific endpoint
        // and method.
        System.assertEquals('https://test.com/EcRequestSbDat/RequestRs/requests/documents?requestId=999999999&sourceCAId=a', request.getEndpoint());
        System.assertEquals('GET', request.getMethod());
        
         HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"entityInfo" : {"entities" : null,"privilege" : {"sso" : null,"applicationName" : null,"applicationCode" : null,"screen" : null,"employeeName" : null,"vCrud" : null}},"status" : {"message" : "S","detail" : "Success"}}');
        response.setStatusCode(200);
        return response;
        
	}
}