@istest
global class Mockhttptabla_Modificacion implements HttpCalloutMock {
    global HttpResponse respond(HttpRequest req){
        system.assertEquals('http://160.34.7.97:7033/EcRequestSbDat/SFRequestTypeDetailsRs/sfRequestTypeDetails/legalAssessments/details/enterprises/modifications', req.getEndpoint());
        system.assertEquals('POST', req.getMethod());
        HttpResponse response = new HttpResponse();
        response.setHeader('Content_Type', 'application/json');
        response.setBody('{'+
        '  "laMModificationId" : 120,'+
        '  "status" : {'+
        '    "code" : "Modification ID : 120",'+
        '    "message" : "Success",'+
        '    "detail" : "S"'+
        '  }'+
        '}');
        response.setStatusCode(200);
        return response;
    }
}