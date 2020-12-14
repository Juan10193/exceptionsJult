@istest
global class Mockhttptabla_Apoderados implements HttpCalloutMock {
    global HttpResponse respond(HttpRequest req){
        system.assertEquals('http://160.34.7.97:7033/EcRequestSbDat/SFRequestTypeDetailsRs/sfRequestTypeDetails/legalAssessments/details/enterprises/attorneys', req.getEndpoint());
        system.assertEquals('POST', req.getMethod());
        HttpResponse response = new HttpResponse();
        response.setHeader('Content_Type', 'application/json');
        response.setBody('{'+
        '  "laAApoderadoId" : 176,'+
        '  "status" : {'+
        '    "code" : "Attorney ID : 176",'+
        '    "message" : "Success",'+
        '    "detail" : "S"'+
        '  }'+
        '}');
        response.setStatusCode(200);
        return response;
    }
}