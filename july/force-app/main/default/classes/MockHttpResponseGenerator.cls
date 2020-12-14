@isTest
global class MockHttpResponseGenerator implements HttpCalloutMock {
    // Implement this interface method
    global HTTPResponse respond(HTTPRequest request) {
         
        // Optionally, only send a mock response for a specific endpoint
        // and method.
        System.assertEquals('Data dummy/EcRequestSbDat/RequestRs/requests?requestId=Data dummy&rootRequestId=&requestType=Data dummy&sourceAccountId=&sourceAccountName=Data dummy&sourceTopParentId=&sourceTopParentName=Data dummy&partyId=&partyName=Data dummy&egPartyId=&egPartyName=Data dummy&sourceOpId=&sourceCAId=&startDate=Data dummy&endDate=Data dummy&requestStatus=Data dummy&createdBy=&requestedBy=Data dummy&assignedGroup=Data dummy&nameAssignedTo=Data dummy&assignedTo=Data dummy&assignedDate=&creationDate=&updatedBy=&lastUpdateDate=&solvedBy=&solvedDate=&sourceApplication=&finantialEntity=&sso=Data dummy', request.getEndpoint());
        System.assertEquals('GET', request.getMethod());
        
        // Create a fake response
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"entityInfo" : {"entities" : null,"privilege" : {"sso" : null,"applicationName" : null,"applicationCode" : null,"screen" : null,"employeeName" : null,"vCrud" : null}},"status" : {"message" : "S","detail" : "Success"}}');
        response.setStatusCode(200);
        return response;
    }
    
    
}