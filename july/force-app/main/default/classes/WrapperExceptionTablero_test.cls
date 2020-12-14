@IsTest
private class WrapperExceptionTablero_test {

    static testMethod void waiverOnSubmit() {
        Id idTakedownCP = WrapperExceptionTablero_test.createdTakedown();
        Id idWaiber = WrapperExceptionTablero_test.createdWaiver(idTakedownCP);
        WrapperExceptionTablero_test.submitForApproval(idWaiber);
        
        WrapperExceptionTablero.getDashboard() ;
    }
    
    static testMethod void waiverOnExpertOpinion() {
        Id idTakedownCP = WrapperExceptionTablero_test.createdTakedown();
        Id idWaiber = WrapperExceptionTablero_test.createdWaiver(idTakedownCP);
        Id idApprovalSubmit = WrapperExceptionTablero_test.submitForApproval(idWaiber);
        WrapperExceptionTablero_test.approveRecordForApproval(idApprovalSubmit);
        
        WaiverToGo__c updateStage = [SELECT id, Stage__c FROM WaiverToGo__c WHERE id =: idWaiber];
        updateStage.Stage__c = 'Completed';
        update updateStage;
        
        WrapperExceptionTablero_test.submitForApproval(updateStage.Id);
        WrapperExceptionTablero.getDashboard() ;
    }
    
    public static Id createdTakedown() {
        EIV_Parameter__c parameters = new EIV_Parameter__c();
        parameters.name = 'Fecha limite';
        parameters.EIV_tx_parameter__c = '01/12/2018';
        insert parameters;
        
        Takedowns_Contingency_plan__c takedown = Data_Factory_Takedown_Test.createTakedown('OPERFIN-FIJA','CDMX', 'CDMX123456');
        return takedown.id;        
    }
    
    public static Id createdWaiver(Id idTakedown) {
        Id idWaiver = Schema.SObjectType.WaiverToGo__c.getRecordTypeInfosByName().get('#ExceptionToGo').getRecordTypeId();
        
        WaiverToGo__c waiver = new WaiverToGo__c();
        waiver.Stage__c = 'New';
        waiver.Document_Type__c = 'Insurance CRO';
        waiver.Reason_for_Exception__c = 'No insurance policy';
        waiver.Commitment_Date__c = Date.newInstance(2020, 9, 15);
        waiver.Due_Date__c = Date.newInstance(2020, 9, 24);
        waiver.Takedown_CP__c = idTakedown;
        insert waiver;
        
        return waiver.Id;
    }
    
    public static Id submitForApproval(Id idWaiver) {
        Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
        req.setComments('Submit for Approval');
        req.setObjectId(idWaiver);
        req.setSubmitterId(UserInfo.getUserId());
        Approval.ProcessResult result = Approval.process(req);
        
        return result.getNewWorkitemIds()[0];
    }
    
    public static void approveRecordForApproval(Id idProcessApproval) {
        Approval.ProcessWorkitemRequest approve = new Approval.ProcessWorkitemRequest();
        approve.setComments('Approve Exception');
        approve.setAction('Approve');
        approve.setWorkitemId(idProcessApproval);
     	Approval.ProcessResult result =  Approval.process(approve);   
    }
}