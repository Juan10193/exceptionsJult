public class ES4_EvalsInOps_Callout {
	@AuraEnabled
    public static Map<string,object>CallbackGetEvInOps(string sServiceUrl, string searchRequestId, string sourceOpId){
        Http h  = new Http();
        HttpRequest req = new HttpRequest();
        
        req.setTimeout(20000);
        req.setEndpoint(sServiceUrl + '/EcRequestSbDat/SFRequestTypeDetailsRs/sfRequestTypeDetails?requestId=' + searchRequestId +'&sourceOpId=' + sourceOpId);
        req.setMethod('GET');
        
        HttpResponse res = h.send(req);
        system.debug('respuesta:--->' +  res.getBody());
        Map<string,object> resultsMap = (Map<string,object>)JSON.deserializeUntyped(res.getBody());
        system.debug('resultsMap--' +  resultsMap);
        return resultsMap;
    }
    
    @AuraEnabled
    public static string getUrl(){
        string sServiceURL = Test.isRunningTest() ? 'https://test.com' :  [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='URL_Servicio'][0].EIV_tx_parameter__c; 
        return sServiceURL;
    }
    
     @AuraEnabled
    public static string getSSO(){
        string sso = [Select EmployeeNumber From User Where Id = :UserInfo.getUserId()][0].EmployeeNumber;
        return sso;
    }
    
    @AuraEnabled
    public static string getUrlInstance(){
        string a = System.Url.getSalesforceBaseURL().toExternalForm();
        return a;
    }
}