/**
* @File Name          : CotizadorController.cls
* @Description        :
* @Author             : angel87ambher@gmail.com
* @Group              :
* @Last Modified By   : angel87ambher@gmail.com
* @Last Modified On   : 12/5/2020 1:22:30
* @Modification Log   :
* Ver       Date            Author      		    Modification
* 1.0    18/2/2020   angel87ambher@gmail.com     Initial Version
**/
public with sharing class CotizadorController {
    
    @AuraEnabled
    public static String requestPost(String url, String data){
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(url);
        request.setTimeout(120000);
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        // request.setHeader('Accept', 'application/json');
        System.debug(LoggingLevel.INFO,'data request ' + data);
        request.setBody(data);
        HttpResponse response = http.send(request);
        // Parse the JSON response
        if (response.getStatusCode() != 200) {
            system.debug('Respuesta');
            system.debug(response.getBody());
            return response.getStatusCode() + ' ' + response.getStatus();
        } else {
            system.debug('Respuesta');
            system.debug(response.getBody());
            return response.getBody();
        }
    }
    
    public static String requestGet(String url){
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(url);
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setTimeout(120000);
        request.setMethod('GET');
        
        HttpResponse response = http.send(request);
        // Parse the JSON response
        if (response.getStatusCode() != 200) {
            return response.getStatusCode() + ' ' + response.getStatus();
        } else {
            return response.getBody();
        }
    }
    
    @AuraEnabled
    public static String  iniciarCotizacion(){
        String key = 'LMM';
        String request = requestGet('callout:'+ getUrl() + '/prm/api/v3/iniciarCotizacion?ssoid=' + getSsoId() + '&key=' + key);
        return request;
        
    }
    
    @AuraEnabled
    public static String calcularCotizacion(String userId, String programId, String profitTarget , String data){
        System.debug(data);
        String request = requestPost('callout:'+ getUrl() + '/prm/api/v3/calcularCotizacion?userid=' + userId + '&programid=' + programId +'&profitTarget=' + profitTarget, data);
        return request;
    }
    
    public static String getUrl(){
        string typeofSandbox = GetSandboxType.getTypeOfSandbox();
        string namecred;
        if (typeofSandbox =='QA') {
            namecred ='getsServiceUrlQa';
        }else if(typeofSandbox =='PROD'){
            namecred = 'getsServiceUrlProd';
        }else{
            namecred ='getsServiceUrlProd';
        }
        return namecred;
        
    }
    
    public static String getSsoId(){
        
         String sSSO = [Select EmployeeNumber From User Where Id = :UserInfo.getUserId()][0].EmployeeNumber; 
         return  sSSO;
    }

    @AuraEnabled(Cacheable = false)
    public static EC_Quote__c saveCotizacion(EC_Quote__c cotizacion){
        EC_Quote__c ecquote = DMLO_EC_Quote.createQuote(cotizacion);
        return ecquote;
    }
    
}