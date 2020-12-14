@IsTest
public class Takedown_seguro_test {

    static testMethod void getAllRecords() {
        EIV_Parameter__c parameters = new EIV_Parameter__c();
        parameters.name = 'fecha limite';
        parameters.EIV_tx_parameter__c = '01/12/2018';
        insert parameters;

        Takedowns_Contingency_plan__c[] createTakedownInvoice = Takedown_seguro_utils.createTakeDownEval(1);
    	
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/TakedownAPI/';
        req.params.put('statusTakedown', 'Tollgate 1');
        req.httpMethod = 'GET';
        req.addHeader('Content-Type', 'application/json');
        RestContext.request = req;
        RestContext.response = res;
        Takedown_seguro.getTakedownCP();
    }
}