@istest
global class Mockhttptabla_estatutos implements HttpCalloutMock {
    global HttpResponse respond(HttpRequest req){
        system.assertEquals('http://160.34.7.97:7033/EcRequestSbDat/SFRequestTypeDetailsRs/sfRequestTypeDetails/legalAssessments/details/enterprises/statutes', req.getEndpoint());
        system.assertEquals('POST', req.getMethod());
        HttpResponse response = new HttpResponse();
        response.setHeader('Content_Type', 'application/json');
        response.setBody('{'+
        '  "laEEstatutoId" : 38,'+
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