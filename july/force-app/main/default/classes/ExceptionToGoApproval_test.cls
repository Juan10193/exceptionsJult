@IsTest
private class ExceptionToGoApproval_test {

    static testMethod void createdExceptionWithoutSubmitApproval() {
        Id idTakedownCP = ExceptionToGoApproval_test.createdTakedown();
        id idWaiber = ExceptionToGoApproval_test.createdWaiver(idTakedownCP); 
        String comment = 'Approval, sin proceso de aprobación.';
        
        ExceptionToGoApproval_cls.Response response = new ExceptionToGoApproval_cls.Response();
        response = ExceptionToGoApproval_cls.approveRecord(idWaiber, comment);
    }
    
    static testMethod void createdExceptionRecordApproval() {
        Id idTakedownCP = ExceptionToGoApproval_test.createdTakedown();
        id idWaiver = ExceptionToGoApproval_test.createdWaiver(idTakedownCP);
        ExceptionToGoApproval_test.submitForApproval(idWaiver);
        String comment = 'Prueba, aprobación de registro.';
        
        ExceptionToGoApproval_cls.Response response = new ExceptionToGoApproval_cls.Response();
        response = ExceptionToGoApproval_Cls.approveRecord(idWaiver, comment);
    }
    
    static testMethod void createdExceptionWithoutSubmitApprovalReject() {
        Id idTakedownCP = ExceptionToGoApproval_test.createdTakedown();
        id idWaiber = ExceptionToGoApproval_test.createdWaiver(idTakedownCP); 
        String comment = 'Reject, sin proceso de aprobación.';
        
        ExceptionToGoApproval_cls.Response response = new ExceptionToGoApproval_cls.Response();
        response = ExceptionToGoApproval_cls.rejectRecord(idWaiber, comment);
    }
    
    static testMethod void createdExceptionRecordReject() {
        Id idTakedownCP = ExceptionToGoApproval_test.createdTakedown();
        id idWaiver = ExceptionToGoApproval_test.createdWaiver(idTakedownCP);
        ExceptionToGoApproval_test.submitForApproval(idWaiver);
        String comment = 'Prueba, reject de registro.';
        
        ExceptionToGoApproval_cls.Response response = new ExceptionToGoApproval_cls.Response();
        response = ExceptionToGoApproval_Cls.rejectRecord(idWaiver, comment);
    }
    
    static testMethod void createdtestAnotherMethods() {
        ExceptionToGoApproval_cls.Response response = new ExceptionToGoApproval_cls.Response();
        response.status = 'Test';
        response.message = 'Test: método de prueba.';
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
    
    public static void submitForApproval(Id idWaiver) {
        Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
        req.setComments('Submit for Approval');
        req.setObjectId(idWaiver);
        req.setSubmitterId(UserInfo.getUserId());
        Approval.ProcessResult result = Approval.process(req);   
    }
}