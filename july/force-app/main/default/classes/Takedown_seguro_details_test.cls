@isTest
public class Takedown_seguro_details_test {

    static testMethod void getDetailsLMMOrg() {
        EIV_Parameter__c parameters = new EIV_Parameter__c();
        parameters.name = 'fecha limite';
        parameters.EIV_tx_parameter__c = '01/12/2018';
        insert parameters;

        Takedowns_Contingency_plan__c createTakedownInvoice = Takedown_utils.createdTakedownOrg('OPERFIN-FIJA','CDMX', 'CDMX123456');
    	
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/TakedownDETAILS/';
        req.params.put('idTakedown', createTakedownInvoice.Id);
        req.httpMethod = 'GET';
        req.addHeader('Content-Type', 'application/json');
        RestContext.request = req;
        RestContext.response = res;
        Takedown_seguro_details.infoTakedown();
    }
    
    static testMethod void getDetailsLMMInd() {
        EIV_Parameter__c parameters = new EIV_Parameter__c();
        parameters.name = 'fecha limite';
        parameters.EIV_tx_parameter__c = '01/12/2018';
        insert parameters;

        Takedowns_Contingency_plan__c createTakedownInvoice = Takedown_utils.createdTakedownInd('OPERFIN-FIJA','CDMX', 'CDMX123456');
    	
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/TakedownDETAILS/';
        req.params.put('idTakedown', createTakedownInvoice.Id);
        req.httpMethod = 'GET';
        req.addHeader('Content-Type', 'application/json');
        RestContext.request = req;
        RestContext.response = res;
        Takedown_seguro_details.infoTakedown();
    }
    
    static testMethod void getDetailsOldOrg() {
        EIV_Parameter__c parameters = new EIV_Parameter__c();
        parameters.name = 'fecha limite';
        parameters.EIV_tx_parameter__c = '01/12/2018';
        insert parameters;

        Takedowns_Contingency_plan__c createTakedownInvoice = Takedown_utils.createdTakedownOldOrg('OPERFIN-FIJA','CDMX', 'CDMX123456');
    	
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/TakedownDETAILS/';
        req.params.put('idTakedown', createTakedownInvoice.Id);
        req.httpMethod = 'GET';
        req.addHeader('Content-Type', 'application/json');
        RestContext.request = req;
        RestContext.response = res;
        Takedown_seguro_details.infoTakedown();
    }
    
    static testMethod void getDetailsOldInd() {
        EIV_Parameter__c parameters = new EIV_Parameter__c();
        parameters.name = 'fecha limite';
        parameters.EIV_tx_parameter__c = '01/12/2018';
        insert parameters;

        Takedowns_Contingency_plan__c createTakedownInvoice = Takedown_utils.createdTakedownOldInd('OPERFIN-FIJA','CDMX', 'CDMX123456');
    	
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/TakedownDETAILS/';
        req.params.put('idTakedown', createTakedownInvoice.Id);
        req.httpMethod = 'GET';
        req.addHeader('Content-Type', 'application/json');
        RestContext.request = req;
        RestContext.response = res;
        Takedown_seguro_details.infoTakedown();
    }
}