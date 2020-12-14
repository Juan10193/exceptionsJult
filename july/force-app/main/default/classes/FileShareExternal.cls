@RestResource(urlMapping='/FileShareExternal/*')
global with sharing class FileShareExternal {

    @HttpGet
    global static void getFileShare() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        res.addHeader('Content-Type', 'application/json');
        string idDocumentLink = req.headers.get('idDocumentLink');
        string auth = req.headers.get('auth');
        
        Httprequest request = new HttpRequest();    
		request.setMethod('PUT');
        request.setHeader('Authorization',auth);
        request.setBody(FileShareExternal_cls.sharingType);
        request.setEndpoint(FileShareExternal_cls.orgtype +'/services/data/v43.0/connect/files/'+idDocumentLink+'/file-shares/link');
        Http http = new Http();
        HttpResponse response= http.send(request);                
        system.debug('body:'+(String.valueOf(response.getBody())));           
        res.responseBody =Blob.valueOf(response.getBody());
    }
}