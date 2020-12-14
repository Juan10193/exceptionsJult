/**
 * @File Name          : MockHttpResponseHandler.cls
 * @Description        : 
 * @Author             : juandedios.hernandez@engeniumcapital.com
 * @Group              : 
 * @Last Modified By   : juandedios.hernandez@engeniumcapital.com
 * @Last Modified On   : 30/9/2019 18:01:58
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    30/9/2019   juandedios.hernandez@engeniumcapital.com     Initial Version
**/

@isTest
global class MockHttpResponseHandler_cls implements HttpCalloutMock {
    private string endpoint {get;set;}
    private string body {get;set;}
    private string method	{get;set;}
    private string contentType {get;set;}
    private integer statusCode {get;set;}
    
    
    public MockHttpResponseHandler_cls(string endpoint, string body, string method, string contentType, integer statusCode){
        this.endpoint = endpoint;
        this.body = body;
        this.method = method;
        this.contentType = contentType;
        this.statusCode = statusCode;
    }
    
    global HttpResponse respond(HttpRequest req) {
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', contentType);
        res.setBody(body);
        res.setStatusCode(statusCode);
        return res;
    }
    
}