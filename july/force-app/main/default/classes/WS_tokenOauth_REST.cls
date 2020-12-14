@RestResource(urlMapping='/SFtoken/*')
global with sharing class WS_tokenOauth_REST {
    
    @HttpGet
    global static void doGet(){
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        res.addHeader('Content-Type', 'application/json');
        string parameters = req.headers.get('parameters');
        WSExposedCredential__mdt creds = WS_ValidateTokenHelper.validateParametersHeader(parameters);
        if(creds !=null || Test.isRunningTest()){
            System.debug('CREDENCIALES VALIDAS');
            string nameCred = WS_ValidateTokenHelper.orgtype =='Sandbox'?'OauthTokenSF_Sandbox':'OauthTokenSF_Prod';

            Httprequest request = new HttpRequest();    
            request.setMethod('POST');
            request.setHeader('Content-Type','application/x-www-form-urlencoded');
            request.setBody('grant_type=password' + 
                        '&client_id=' + creds.Client_ID__c + 
                        '&client_secret=' + creds.Client_Secret__c + 
                        '&username=' + creds.SF_User__c +
                        '&password=' + creds.SF_Password__c
                       ); 
            system.debug('mensaje');
            System.debug(request.getBody());
            request.setEndpoint('callout:' +nameCred) ;         
            Http http = new Http();
            HttpResponse response= http.send(request);                
            system.debug('body:'+(String.valueOf(response.getBody())));           
            res.responseBody =Blob.valueOf(response.getBody());  
        }
    }
}