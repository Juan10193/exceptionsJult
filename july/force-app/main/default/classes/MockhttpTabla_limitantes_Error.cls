@istest
global class MockhttpTabla_limitantes_Error implements HttpCalloutMock {
    global HttpResponse respond(HttpRequest req){
        system.assertEquals('http://160.34.7.97:7033/EcRequestSbDat/SFRequestTypeDetailsRs/sfRequestTypeDetails/legalAssessments/details/enterprises/limitations', req.getEndpoint());
        system.assertEquals('POST', req.getMethod());
        HttpResponse response = new HttpResponse();
        response.setHeader('Content_Type', 'application/json');
        response.setBody('{'+
        '  "laMLLimitId" : 119,'+
        '  "status" : {'+
        '    "code" : "Limitation ID : 119",'+
        '    "message" : "Success",'+
        '    "detail" : "S"'+
        '  }'+
        '}');
        response.setStatusCode(500);
        return response;
    }
}