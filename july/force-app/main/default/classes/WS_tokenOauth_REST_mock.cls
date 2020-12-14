@isTest
global class WS_tokenOauth_REST_mock implements HttpCalloutMock {
	global HTTPResponse respond(HTTPRequest req) {
    	HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"RquestID":"1234564789456123023123156456"}');
        res.setStatusCode(200);
        return res;
    }
}