/**
 * @File Name          : EIV_EntityCallout.cls
 * @Description        : 
 * @Author             : eduardo.amiens@outlook.com
 * @Group              : 
 * @Last Modified By   : eduardo.amiens@outlook.com
 * @Last Modified On   : 12/6/2020 7:19:12
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    16/4/2020   eduardo.amiens@outlook.com     Initial Version
**/
global with sharing class EIV_EntityCallout {

    global static string getNamedCredential(){
        string namedCredential;
        switch on GetSandboxType.getTypeOfSandbox() {
            when 'DEV' {		
                namedCredential = 'getsServiceUrl';
            }	
            when 'QA' {		
                namedCredential = 'getsServiceUrlQa';
            }
            when 'PROD' {		
                namedCredential = 'getsServiceUrlProd';
            }
            when 'Developer Edition' {
            	namedCredential = 'getsServiceUrl';
        	}
            when else {		  
                namedCredential = 'getsServiceUrl';
            }
        }
        return namedCredential;
    }
    
    global static HttpResponse getEntitiesByAccountID(String sfAccountID){       
        System.debug(LoggingLevel.INFO,'Inicia getEntitiesByAccountID'); 
        Http http = new Http();        
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:' + getNamedCredential() + '/EcEntityMasterSbDat/AccountSvcRs/entities?sfAccountID='+ sfAccountID);
        request.setHeader('Accept', 'application/json; charset=utf-8' );
        request.setMethod('GET');
        request.setTimeout(120000);
        system.debug('request ' + request);
        HttpResponse response;
       	response = http.send(request);       
        system.debug('response ' + response.getBody());
        System.debug(LoggingLevel.INFO,'Termina getEntitiesByAccountID'); 
        return response;
    } 
    global static HttpResponse getEntitiesByEconomicGroup(string partyID){ 
        System.debug(LoggingLevel.INFO,'Inicia getEntitiesByEconomicGroup');       
        Http http = new Http();        
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:' + getNamedCredential() + '/EcEntityMasterSbDat/AccountSvcRs/entities?economicGroupID=' + partyID);
        request.setHeader('Accept', 'application/json; charset=utf-8' );
        request.setMethod('GET');
        request.setTimeout(120000);
        system.debug('request ' + request);
        HttpResponse response;
       	response = http.send(request);       
        system.debug('response ' + response.getBody());
        System.debug(LoggingLevel.INFO,'Termina getEntitiesByEconomicGroup'); 
        return response;
    } 
    global static HttpResponse getRequestByPartyID(string partyID){   
        System.debug(LoggingLevel.INFO,'Inicia getRequestByPartyID');     
        Http http = new Http();        
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:' + getNamedCredential() + '/EcRequestSbDat/RequestRs/requests?partyId=' + partyID);
        request.setHeader('Accept', 'application/json; charset=utf-8' );
        request.setMethod('GET');
        request.setTimeout(120000);
        system.debug('request ' + request);
        HttpResponse response;
       	response = http.send(request);       
        system.debug('response ' + response.getBody());
        System.debug(LoggingLevel.INFO,'Termina getRequestByPartyID');
        return response;
    } 
    global static HttpResponse getRequestByRequestID(string requestId, string sso){   
        System.debug(LoggingLevel.INFO,'Inicia getRequestByRequestID');     
        Http http = new Http();        
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:' + getNamedCredential() + '/EcRequestSbDat/SFRequestTypeDetailsRs/sfRequestTypeDetails?requestId=' + requestId +'&sso=' + sso);
        request.setHeader('Accept', 'application/json; charset=utf-8' );
        request.setMethod('GET');
        request.setTimeout(120000);
        system.debug('request ' + request);
        HttpResponse response;
       	response = http.send(request);       
        system.debug('response ' + response.getBody());
        System.debug(LoggingLevel.INFO,'Termina getRequestByRequestID');
        return response;
    } 
    global static HttpResponse getEntityBypartyID(string partyID, string sso){   
        System.debug(LoggingLevel.INFO,'Inicia getEntityBypartyID');     
        Http http = new Http();        
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:' + getNamedCredential() + '/EcEntityMasterSbDat/EntitySvcRs/entities/?partyID=' + partyID + '&sso=' + sso + '&applicationCode=SF&screen=UI_ENTITYMASTER');
        system.debug('request.getBody() ' + request.getBody());
        request.setHeader('Accept', 'application/json; charset=utf-8' );
        request.setMethod('GET');
        request.setTimeout(120000);
        system.debug('request ' + request);
        HttpResponse response;
       	response = http.send(request);       
        system.debug('response ' + response.getBody());
        System.debug(LoggingLevel.INFO,'Termina getEntityBypartyID');
        return response;
    } 
    global static HttpResponse createCreditBureau(string jsonRequest){   
        System.debug(LoggingLevel.INFO,'Inicia createCreditBureau'); 
        Http http = new Http();        
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:' + getNamedCredential() + '/EcRequestSbDat/SFRequestTypeDetailsRs/sfRequestTypeDetails');
    

        request.setHeader('Content-Type', 'application/json;charset=UTF-8' );
        request.setMethod('POST');
        request.setTimeout(120000);
        request.setBody(jsonRequest);
        HttpResponse response = http.send(request);       
        system.debug('response ' + response.getBody());
        System.debug(LoggingLevel.INFO,'Termina createCreditBureau');
        return response;
    } 
    global static HttpResponse getCurrentCreditBureau(string partyID){   
        System.debug(LoggingLevel.INFO,'Inicia getCurrentCreditBureau'); 
        Http http = new Http();        
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:' + getNamedCredential() + '/EcRequestSbDat/RequestRs/requests?partyId=' + partyID + '&requestType=ADVANCED%20CREDIT%20BUREAU');
        request.setHeader('Accept', 'application/json; charset=utf-8' );
        request.setMethod('GET');
        request.setTimeout(120000);
        system.debug('request ' + request);
        HttpResponse response;
       	response = http.send(request);       
        system.debug('response ' + response.getBody());
        System.debug(LoggingLevel.INFO,'Termina getCurrentCreditBureau');
        return response;
    } 


    
    global static HttpResponse getCreditBureauStepThree(string jsonParameter){   
        System.debug(LoggingLevel.INFO,'Inicia getCreditBureauStepThree'); 
        Http http = new Http();        
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:' + getNamedCredential() + '/util/reports');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8' );
        request.setMethod('POST');
        request.setBody(jsonParameter);
        request.setTimeout(120000);
        system.debug('request ' + request);
        HttpResponse response;
       	response = http.send(request);       
        system.debug('response ' + response.getBody());
        System.debug(LoggingLevel.INFO,'Termina getCreditBureauStepThree');
        return response;
    }
    
    global static HttpResponse getEntityByRFCOrName(string rfcOrName){   
        System.debug(LoggingLevel.INFO,'Inicia getEntityByRFCOrName'); 
        Http http = new Http();        
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:' + getNamedCredential() + '/EcEntityMasterSbDat/AccountSvcRs/entities?rfcOrName=' + rfcOrName);
        request.setHeader('Accept', 'application/json; charset=utf-8' );
        request.setMethod('GET');
        request.setTimeout(120000);
        system.debug('request ' + request);
        HttpResponse response;
       	response = http.send(request);       
        system.debug('response ' + response.getBody());
        System.debug(LoggingLevel.INFO,'Termina getEntityByRFCOrName');
        return response;
    }

    
}