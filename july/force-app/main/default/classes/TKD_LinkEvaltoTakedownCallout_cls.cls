/**
 * @File Name          : TKD_LinkEvaltoTakedownCallout_cls.cls
 * @Description        : 
 * @Author             : juandedios.hernandez@engeniumcapital.com
 * @Group              : 
 * @Last Modified By   : juandedios.hernandez@engeniumcapital.com
 * @Last Modified On   : 8/10/2019 2:03:56
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    4/10/2019   juandedios.hernandez@engeniumcapital.com     Initial Version
**/
public with sharing class TKD_LinkEvaltoTakedownCallout_cls {
   
    @AuraEnabled(cacheable = false)
    public static string searchEvalsInOpportunityCallout(string opportunityId){
        Http http = new Http();
        HttpRequest  request  = new HttpRequest();
        string sandbox = GetSandboxType.getTypeOfSandbox();
        string namecred;

        if(sandbox == 'DEV'){
            namecred = 'getsServiceUrl';
        }
        if(sandbox == 'QA'){
            namecred = 'getsServiceUrlQa';
        }
        if(sandbox =='PROD'){
            namecred = 'getsServiceUrlProd';
        }

        request.setEndpoint('callout:'+ namecred + '/EcRequestSbDat/SFRequestTypeDetailsRs/sfRequestTypeDetails?requestId=&sourceOpId=' + opportunityId);
        request.setMethod('GET');
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
    public static string searchEvalsInEntities(string partyId){
        Http http = new Http();
        HttpRequest  request  = new HttpRequest();
        string sandbox = GetSandboxType.getTypeOfSandbox();
        string namecred;

        if(sandbox == 'DEV'){
            namecred = 'getsServiceUrl';
        }
        if(sandbox == 'QA'){
            namecred = 'getsServiceUrlQa';
        }
        if(sandbox =='PROD'){
            namecred = 'getsServiceUrlProd';
        }

        request.setEndpoint('callout:'+ namecred + '/EcRequestSbDat/RequestRs/requests?partyId=' + partyId );
        request.setMethod('GET');
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
    public static string searchRequestId(String sso, String app, String requestId){
        Http http = new Http();
        HttpRequest  request  = new HttpRequest();
        string sandbox = GetSandboxType.getTypeOfSandbox();
        string namecred;

        if(sandbox == 'DEV'){
            namecred = 'getsServiceUrl';
        }
        if(sandbox == 'QA'){
            namecred = 'getsServiceUrlQa';
        }
        if(sandbox =='PROD'){
            namecred = 'getsServiceUrlProd';
        }

        request.setEndpoint('callout:'+ namecred + '/EcRequestSbDat/SFRequestTypeDetailsRs/sfRequestTypeDetails?requestId=' + requestId );
        request.setMethod('GET');
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
    public static string cloneEval(string jsonReq){
        Http http = new Http();
        HttpRequest  request  = new HttpRequest();
        string sandbox = GetSandboxType.getTypeOfSandbox();
        string namecred;

        if(sandbox == 'DEV'){
            namecred = 'getsServiceUrl';
        }
        if(sandbox == 'QA'){
            namecred = 'getsServiceUrlQa';
        }
        if(sandbox =='PROD'){
            namecred = 'getsServiceUrlProd';
        }

        request.setEndpoint('callout:'+ namecred + '/EcRequestSbDat/SFRequestTypeDetailsRs/sfRequestTypeDetails');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json');
        request.setBody(jsonReq);
        request.setTimeout(120000);
        
        System.debug('Send the following request from postRequestDetail:' + request.getBody());
        System.debug(JSON.serialize(request.getBody()));

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


    @AuraEnabled
    public static string postEvalComments(string jsoNcomment){
        Http http = new Http();
        HttpRequest  request  = new HttpRequest();
        string sandbox = GetSandboxType.getTypeOfSandbox();
        string namecred;

        if(sandbox == 'DEV'){
            namecred = 'getsServiceUrl';
        }
        if(sandbox == 'QA'){
            namecred = 'getsServiceUrlQa';
        }
        if(sandbox =='PROD'){
            namecred = 'getsServiceUrlProd';
        }

        request.setEndpoint('callout:'+ namecred + '/EcRequestSbDat/SFRequestTypeDetailsRs/sfRequestTypeDetails/comments');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json');
        request.setBody(jsoNcomment);
        request.setTimeout(120000);
        System.debug('Send the following request from postRequestDetail:' + request.getBody());
        System.debug(JSON.serialize(request.getBody()));

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

}