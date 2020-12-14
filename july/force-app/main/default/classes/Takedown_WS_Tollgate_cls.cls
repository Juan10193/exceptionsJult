public with sharing class Takedown_WS_Tollgate_cls {
    public class applicationException extends Exception {}

    @AuraEnabled(cacheable=false)
    public static string searchRequestId(String encritpData){
        Http http = new Http();
        HttpRequest  request  = new HttpRequest();
        string sandbox = GetSandboxType.getTypeOfSandbox();
        string namecred;

        if(sandbox == 'DEV'){
            namecred = 'ContentManagmentDev';
        }
        if(sandbox == 'QA'){
            namecred = 'ContentManagmentQA';
        }
        if(sandbox =='PROD'){
            namecred = 'ContentManagmentProd';
        }

        request.setEndpoint('callout:'+ namecred + '/wcmecapp/files/tollgate');
        request.setHeader('Content-Type', 'application/json');
        request.setBody(encritpData);
        request.setMethod('POST');
        request.setHeader('Authorization', '{!$Credential.AuthorizationHeaderValue}');
        request.setTimeout(120000);
        HttpResponse response = http.send(request);
        if(response.getStatusCode() == 200){
            System.debug('response.getBody() ' + response.getBody());
            return response.getBody();
        }else{
            System.debug(LoggingLevel.ERROR,'StatusCode: ' + response.getStatusCode());
            System.debug(LoggingLevel.ERROR,'Body: ' + response.getBody());
            return response.getBody();
        }
    }

    @AuraEnabled(cacheable=false)
    public static string getToken(){
        Http http = new Http();
        HttpRequest  request  = new HttpRequest();
        string sandbox = GetSandboxType.getTypeOfSandbox();
        string namecred;

        if(sandbox == 'DEV'){
            namecred = 'ContentManagmentDevToken';
        }
        if(sandbox == 'QA'){
            namecred = 'ContentManagmentQAToken';
        }
        if(sandbox =='PROD'){
            namecred = 'ContentManagmentProdToken';
        }

        request.setEndpoint('callout:'+ namecred);
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json');
        request.setHeader('Authorization', '{!$Credential.AuthorizationHeaderValue}');
        request.setTimeout(120000);
 		system.debug('request');
		system.debug(request);
        HttpResponse response = http.send(request);
        system.debug(response);
        if(response.getStatusCode() == 200){
            System.debug('response body '  + response.getBody());
            return response.getBody();
        }else{
            System.debug(LoggingLevel.ERROR,'StatusCode: ' + response.getStatusCode());
            System.debug(LoggingLevel.ERROR,'Body: ' + response.getBody());
            throw new applicationException('Error al obtener el token de content: ' + response.getBody());
        }
    }

}