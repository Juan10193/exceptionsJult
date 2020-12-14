@IsTest
private class ExceptionToGoApprovals_test {

    static testMethod void createdApproveWaiver() {
        Id idTakedownCP = ExceptionToGoApprovals_test.createdTakedown();
        id idWaiver = ExceptionToGoApprovals_test.createdWaiver(idTakedownCP);
        String action = 'Approve';
        String comment = 'Waiver approve';
        
        RestRequest restReq = new RestRequest();
        RestResponse restRes = new RestResponse();
        restReq.requestURI = 'services/apexrest/ExceptionApproval/';
        restReq.httpMethod = 'POST';
        RestContext.request = restReq;
        RestContext.response = restRes;
        ExceptionToGoApproval.approvalException(action, comment, idWaiver);
    }
    
    static testMethod void createdRejectWaiver() {
        Id idTakedownCP = ExceptionToGoApprovals_test.createdTakedown();
        id idWaiver = ExceptionToGoApprovals_test.createdWaiver(idTakedownCP);
        String action = 'Reject';
        String comment = 'Waiver reject';
        
        RestRequest restReq = new RestRequest();
        RestResponse restRes = new RestResponse();
        restReq.requestURI = 'services/apexrest/ExceptionApproval/';
        restReq.httpMethod = 'POST';
        RestContext.request = restReq;
        RestContext.response = restRes;
        ExceptionToGoApproval.approvalException(action, comment, idWaiver);
    }
    
    static testMethod void createdErrorWaiver() {
        String idWaiver = '123456789098765432';
        String action = 'Error';
        String comment = 'Waiber action error';
        
        RestRequest restReq = new RestRequest();
        RestResponse restRes = new RestResponse();
        restReq.requestURI = 'services/apexrest/ExceptionApproval/';
        restReq.httpMethod = 'POST';
        RestContext.request = restReq;
        RestContext.response = restRes;
        ExceptionToGoApproval.approvalException(action, comment, idWaiver);
    }
    
    static testMethod void createdErrorWaiverEmptyFields() {
        String idWaiver = null;
        String action = 'Error';
        String comment = 'Waiber action error';
        
        RestRequest restReq = new RestRequest();
        RestResponse restRes = new RestResponse();
        restReq.requestURI = 'services/apexrest/ExceptionApproval/';
        restReq.httpMethod = 'POST';
        RestContext.request = restReq;
        RestContext.response = restRes;
        ExceptionToGoApproval.approvalException(action, comment, idWaiver);
    } 
    
    public static id createdTakedown() {
        EIV_Parameter__c parameters = new EIV_Parameter__c();
        parameters.name = 'fecha limite';
        parameters.EIV_tx_parameter__c = '01/12/2018';
        insert parameters;
        Takedowns_Contingency_plan__c takedown = Data_Factory_Takedown_Test.createTakedown('OPERFIN-FIJA','CDMX', 'CDMX123456');
        
        return takedown.Id;
    }
    
    public static Id createdWaiver(Id idTakedownCP) {
        Id idWaiber = Schema.SObjectType.WaiverToGo__c.getRecordTypeInfosByName().get('#ExceptionToGo').getRecordTypeId();
        
        WaiverToGo__c waiber = new WaiverToGo__c();
        waiber.Stage__c = 'New';
        waiber.Document_Type__c = 'Insurance CRO';
        waiber.Reason_for_Exception__c = 'No insurance policy';
        waiber.Commitment_Date__c = Date.newInstance(2020, 15, 9);
        waiber.Due_Date__c = Date.newInstance(2020, 24, 9);
        waiber.Takedown_CP__c = idTakedownCP;
        insert waiber;
        
        return waiber.Id;
    }
}