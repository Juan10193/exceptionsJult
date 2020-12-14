@isTest
global class EIV_EntityCalloutMock implements HttpCalloutMock{
    
    global HTTPResponse respond(HTTPRequest req) {
        System.assertEquals('GET', req.getMethod());
        
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"example":"test"}');
        res.setStatusCode(200);
        return res;
    }

}