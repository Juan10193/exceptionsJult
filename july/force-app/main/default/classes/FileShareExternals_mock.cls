@isTest
global class FileShareExternals_mock implements HttpCalloutMock {
	global HTTPResponse respond(HTTPRequest req) {
    	HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"idDocumentLink":"0691F000000t2O7QAI"}');
        res.setStatusCode(200);
        return res;
    }
}