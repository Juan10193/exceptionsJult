/**
 * @File Name          : Takedown_WS_OpenLegacy_cls.cls
 * @Description        : Esta clase contiene tres WebServices que serán utilizados para conectar Salesforce con OpenLegacy.
 * 					     El flujo para esta conexión consiste en la obtención de un token de conexión, envío de documentos a validación y desgloce de activos
 * @Author             : eduardo.amiens@outlook.com
 * @Group              : 
 * @Last Modified By   : eduardo.amiens@outlook.com
 * @Last Modified On   : 10-27-2020
 * @Modification Log   : 
 *==============================================================================
 * Ver         Date                     Author      		      Modification
 *==============================================================================
 * 1.0    28/7/2019 23:18:03   eduardo.amiens@outlook.com     Initial Version
**/
public with sharing class Takedown_WS_OpenLegacy_cls {
    /**
    * @description 
    * @author eduardo.villegas@engeniumcapital.com | 28/1/2020 
    * @return string 
    **/
    public static string getNamedCredential(){
        string namedCredential;
        switch on GetSandboxType.getTypeOfSandbox() {
            when 'DEV' {		
                namedCredential = 'OLInvoicesDev';
            }	
            when 'QA' {		
                namedCredential = 'OLInvoicesQA';
            }
            when 'PROD' {		
                namedCredential = 'OLInvoicesProd';
            }
            when else {		  
                namedCredential = 'OLInvoicesDev';
            }
        }
        return namedCredential;
    }

    /**
    * @description 
    * @author eduardo.villegas@engeniumcapital.com | 28/1/2020 
    * @return string 
    **/
    public static string getTokenByNamedCredential(){
        string namedCredential;
        switch on GetSandboxType.getTypeOfSandbox() {
            when 'DEV' {		
                namedCredential = 'OLInvoicesTokenDev';
            }	
            when 'QA' {		
                namedCredential = 'OLInvoicesTokenQA';
            }
            when 'PROD' {		
                namedCredential = 'OLInvoicesTokenProd';
            }
            when else {		  
                namedCredential = 'OLInvoicesTokenDev';
            }
        }
        return namedCredential;
    }
    
    /**
    * @description 
    * @author eduardo.villegas@engeniumcapital.com | 28/1/2020 
    * @return HttpResponse 
    **/
    public static HttpResponse getToken(){
                 
        Takedown_Wrapper_Token_OL_cls.TokenResponse TokenResponse = new Takedown_Wrapper_Token_OL_cls.TokenResponse();
        Http http = new Http();        
        HttpRequest request = new HttpRequest();
        if(Test.isRunningTest()){   
            request.setEndpoint('https://apps.engeniumcapital.com/getToken');   
        } else {
           request.setEndpoint('callout:' + getTokenByNamedCredential());   
        }   
        request.setMethod('POST');
        request.setTimeout(Global_SetUp.setup_TimeOut);
        
        String body = 'grant_type=client_credentials&scope=test'; 
        /** la autenticación será remplazada por un named credential**/
        request.setBody(body);
        HttpResponse response;
        try{
       		response = http.send(request);    
        }catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error al obtener el token, getCause ' + e.getCause());
            system.debug(LoggingLevel.ERROR,'Error al obtener el token, getLineNumber ' + e.getLineNumber());
            system.debug(LoggingLevel.ERROR,'Error al obtener el token, getMessage ' + e.getMessage());
            /*response = new HttpResponse();
            response.setStatusCode(408);
        	response.setStatus(e.getMessage());   */          
        }
        system.debug('response ' + response.getBody());
        return response;
    }
    
    /**
    * @description 
    * @author eduardo.villegas@engeniumcapital.com | 28/1/2020 
    * @param token 
    * @param SATValRequest 
    * @param documentID 
    * @return HttpResponse 
    **/
    public static HttpResponse SATValidationOpenLegacy(String token, String SATValRequest, id documentID){
        system.debug(LoggingLevel.INFO, 'Inicia SATValidationOpenLegacy');
        system.debug('SATValRequest ' + SATValRequest);
        Takedown_Wrapper_SATVal_OL_cls.SATValResponse SATValResponse = new Takedown_Wrapper_SATVal_OL_cls.SATValResponse();
        Http http = new Http();        
        HttpRequest request = new HttpRequest();
        if(Test.isRunningTest()){           
           request.setEndpoint('https://apps.engeniumcapital.com/SATValidationOpenLegacy');
        } else { 
           request.setEndpoint('callout:' + getNamedCredential() + '/satvalidatorxmlapi2/api/satvalidatorxml/invoice');
        }  
        request.setMethod('POST');
        request.setHeader('Authorization', 'Bearer ' + token);
        request.setHeader('Content-Type', 'application/json');
        request.setBody(SATValRequest);
        request.setTimeout(Global_SetUp.setup_TimeOut);
        HttpResponse response;
        try{
        	response = http.send(request);    
        } catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Error al obtener el satval, getCause ' + e.getCause());
            system.debug(LoggingLevel.ERROR,'Error al obtener el satval, getLineNumber ' + e.getLineNumber());
            system.debug(LoggingLevel.ERROR,'Error al obtener el satval, getMessage ' + e.getMessage());
            /*response = new HttpResponse();
            response.setStatusCode(408);
        	response.setStatus(e.getMessage());*/   
        }
        if (response.getStatusCode() == 200) {
            SATValResponse = (Takedown_Wrapper_SATVal_OL_cls.SATValResponse)JSON.deserialize(response.getBody(), Takedown_Wrapper_SATVal_OL_cls.SATValResponse.class); // Jsonstring is the above JSON
        	System.debug('SATValidationOpenLegacy response.getBody() ' + response.getBody());
        } else{            
            SATValResponse = Takedown_WS_OpenLegacy_helper_cls.setErrorResponse(String.valueof(response.getStatusCode()),response.getStatus());
            System.debug(LoggingLevel.ERROR,'StatusCode: ' + response.getStatusCode());
            System.debug(LoggingLevel.ERROR,'Body: ' + response.getBody());
        }
        return response;
    }
    /**
    * @description 
    * @author eduardo.villegas@engeniumcapital.com | 28/1/2020 
    * @param token 
    * @param findAssetsRequest 
    * @return HttpResponse 
    **/
    public static HttpResponse FindAssetsByDocument(String token, String findAssetsRequest){
        system.debug(LoggingLevel.INFO, 'Inicia FindAssetsByDocument');
        system.debug('findAssetsRequest ' + findAssetsRequest);
        Takedown_Wrapper_FindAssets_OL_cls.FindAssetsResponse findAssetsResponse = new Takedown_Wrapper_FindAssets_OL_cls.FindAssetsResponse();
        Http http = new Http();        
        HttpRequest request = new HttpRequest();
         if(Test.isRunningTest()){           
           request.setEndpoint('https://apps.engeniumcapital.com/FindAssetsByDocument');
        } else { 
           request.setEndpoint('callout:' + getNamedCredential() + '/satvalidatorxmlapi2/api/findassetsxdocumentid/assets');
        }    
        
        request.setMethod('POST');
        request.setHeader('Authorization', 'Bearer ' + token);
        request.setHeader('Content-Type', 'application/json');
        request.setBody(findAssetsRequest);
        request.setTimeout(Global_SetUp.setup_TimeOut);
        HttpResponse response = http.send(request);
        if (response.getStatusCode() == 200) {
            findAssetsResponse = (Takedown_Wrapper_FindAssets_OL_cls.FindAssetsResponse)JSON.deserialize(response.getBody(), Takedown_Wrapper_FindAssets_OL_cls.FindAssetsResponse.class); // Jsonstring is the above JSON
        	System.debug('findAssetsResponse response.getBody() ' + response.getBody());
        } else{
            System.debug(LoggingLevel.ERROR,'StatusCode: ' + response.getStatusCode());
            System.debug(LoggingLevel.ERROR,'Body: ' + response.getBody());
        }
        return response;
    }
    
    public static HttpResponse getBankAccount(String token){
        system.debug(LoggingLevel.INFO, 'Inicia FindAssetsByDocument');
        Takedown_Wrapper_FindAssets_OL_cls.FindAssetsResponse findAssetsResponse = new Takedown_Wrapper_FindAssets_OL_cls.FindAssetsResponse();
        Http http = new Http();        
        HttpRequest request = new HttpRequest();
        
        string json = '{"pbankId": null,"pbankName": ""}';
         if(Test.isRunningTest()){           
           request.setEndpoint('https://apps.engeniumcapital.com/FindAssetsByDocument');
        } else { 
           request.setEndpoint('callout:' + getNamedCredential() + '/xxecceapi/api/getbankinfoview');
        }    
        
        
        request.setMethod('POST');
        request.setHeader('Authorization', 'Bearer ' + token);
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setTimeout(Global_SetUp.setup_TimeOut);
        request.setBody(json);
        HttpResponse response = http.send(request);
        if (response.getStatusCode() == 200) {
            System.debug('getBankAccount response.getBody() ' + response.getBody());
        } else{
            System.debug(LoggingLevel.ERROR,'StatusCode: ' + response.getStatusCode());
            System.debug(LoggingLevel.ERROR,'Body: ' + response.getBody());
        }
        return response;
    }


    public static HttpResponse findContracts(String token, String JSONrequest){
        system.debug(LoggingLevel.INFO, 'Inicia findContracts');
        system.debug('request ' + JSONrequest);
        Http http = new Http();        
        HttpRequest request = new HttpRequest();
        if(Test.isRunningTest()){           
           request.setEndpoint('https://apps.engeniumcapital.com/FindAssetsByTakedown');
        } else { 
           request.setEndpoint('callout:' + getNamedCredential() + '/xxecoklapi/api/getnetbookvaluesysdate');
        }          
        request.setMethod('POST');
        request.setHeader('Authorization', 'Bearer ' + token);
        request.setHeader('Content-Type', 'application/json');
        request.setBody(JSONrequest);
        request.setTimeout(Global_SetUp.setup_TimeOut);
        HttpResponse response = http.send(request);
        if (response.getStatusCode() == 200) {
            System.debug('response.getBody() ' + response.getBody());
        } else{
            System.debug(LoggingLevel.ERROR,'StatusCode: ' + response.getStatusCode());
            System.debug(LoggingLevel.ERROR,'Body: ' + response.getBody());
        }
        return response;
    }

    public static HttpResponse getNetBookValueXdate(String token, String JSONrequest){
        system.debug(LoggingLevel.INFO, 'Inicia getNetBookValueXdate');
        system.debug('request ' + JSONrequest);
        Http http = new Http();        
        HttpRequest request = new HttpRequest();
        if(Test.isRunningTest()){           
           request.setEndpoint('https://apps.engeniumcapital.com/getNetBookValueXdate');
        } else { 
           request.setEndpoint('callout:' + getNamedCredential() + '/xxecoklapi/api/getnetbookvaluexdate');
        }          
        request.setMethod('POST');
        request.setHeader('Authorization', 'Bearer ' + token);
        request.setHeader('Content-Type', 'application/json');
        request.setBody(JSONrequest);
        request.setTimeout(Global_SetUp.setup_TimeOut);
        HttpResponse response = http.send(request);
        if (response.getStatusCode() == 200) {
            System.debug('response.getBody() ' + response.getBody());
        } else{
            System.debug(LoggingLevel.ERROR,'StatusCode: ' + response.getStatusCode());
            System.debug(LoggingLevel.ERROR,'Body: ' + response.getBody());
        }
        return response;
    }
    public static HttpResponse requestTerminationQoute(String token, String JSONrequest){
        system.debug(LoggingLevel.INFO, 'Inicia getNetBookValueXdate');
        system.debug('request ' + JSONrequest);
        Http http = new Http();        
        HttpRequest request = new HttpRequest();
        if(Test.isRunningTest()){           
           request.setEndpoint('https://apps.engeniumcapital.com/getNetBookValueXdate');
        } else { 
           request.setEndpoint('callout:' + getNamedCredential() + '/xxecoklapi/api/createterminationquote');
        }          
        request.setMethod('POST');
        request.setHeader('Authorization', 'Bearer ' + token);
        request.setHeader('Content-Type', 'application/json');
        request.setBody(JSONrequest);
        request.setTimeout(Global_SetUp.setup_TimeOut);
        HttpResponse response = http.send(request);
        if (response.getStatusCode() == 200) {
            System.debug('response.getBody() ' + response.getBody());
        } else{
            System.debug(LoggingLevel.ERROR,'StatusCode: ' + response.getStatusCode());
            System.debug(LoggingLevel.ERROR,'Body: ' + response.getBody());
        }
        return response;
    }
    
    /**
    * @description 
    * @author eduardo.villegas@engeniumcapital.com | 28/1/2020 
    * @param token 
    * @param findAssetsRequest 
    * @return HttpResponse 
    **/
    /*
    public static HttpResponse FindAssetsByTakedown(String token, String findAssetsRequest){
        system.debug(LoggingLevel.INFO, 'Inicia FindAssetsByTakedown');
        system.debug('findAssetsRequest ' + findAssetsRequest);
        Takedown_Wrapper_FindAssets_OL_cls.FindAssetsResponse findAssetsResponse = new Takedown_Wrapper_FindAssets_OL_cls.FindAssetsResponse();
        Http http = new Http();        
        HttpRequest request = new HttpRequest();
        if(Test.isRunningTest()){           
           request.setEndpoint('https://apps.engeniumcapital.com/FindAssetsByTakedown');
        } else { 
           request.setEndpoint('callout:' + Takedown_WS_OpenLegacy_helper_cls.getNamedCredential() + '/satvalidatorxmlapi2/api/findassetsxtakedownid/assets');
        }          
        request.setMethod('POST');
        request.setHeader('Authorization', 'Bearer ' + token);
        request.setHeader('Content-Type', 'application/json');
        request.setBody(findAssetsRequest);
        request.setTimeout(Global_SetUp.setup_TimeOut);
        HttpResponse response = http.send(request);
        if (response.getStatusCode() == 200) {
            findAssetsResponse = (Takedown_Wrapper_FindAssets_OL_cls.FindAssetsResponse)JSON.deserialize(response.getBody(), Takedown_Wrapper_FindAssets_OL_cls.FindAssetsResponse.class); // Jsonstring is the above JSON
        	System.debug('response.getBody() ' + response.getBody());
        } else{
            System.debug(LoggingLevel.ERROR,'StatusCode: ' + response.getStatusCode());
            System.debug(LoggingLevel.ERROR,'Body: ' + response.getBody());
        }
        return response;
    }*/
    
    
    
}