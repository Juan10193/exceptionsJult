@istest
global class MockHttpcallBackcallBackCreditBureau implements HttpCalloutMock {
	 // Implement this interface method
    global HTTPResponse respond(HTTPRequest request) {
         
        // Optionally, only send a mock response for a specific endpoint
        // and method.
        System.assertEquals('http://160.34.7.97:7033/EcCreditBureauSbBix/CreditBureauSvcRs/creditBureau?requestId=dummy&rfc=dummy&address=dummydummydummy&ecEntity=dummy&letterSigningDate=dummy&suburb=dummy&zipCode=dummy&city=dummy&state=dummy&autorizationLetter=dummy&sourceAccountId=dummy&sourceAccountName=sourceAccountName&sourceTopParentId=dummy&sourceTopParentName=dummy&partyId=dummy&comment=dummy&contractNumber=contractNumber&anex=anex&egPartyId=dummy&egPartyName=dummy&sourceOpId=dummy&sourceCAId=dummy&createdBy=dummy&dummyFlag=dummy', request.getEndpoint());
        System.assertEquals('GET', request.getMethod());
        
        // Create a fake response
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"entityInfo" : {"entities" : null,"privilege" : {"sso" : null,"applicationName" : null,"applicationCode" : null,"screen" : null,"employeeName" : null,"vCrud" : null}},"status" : {"message" : "S","detail" : "Success"}}');
        response.setStatusCode(200);
        return response;
    }    
}