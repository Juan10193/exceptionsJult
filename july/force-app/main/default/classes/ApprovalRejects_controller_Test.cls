@ISTEst
private class ApprovalRejects_controller_Test {
    @testSetup static void setup(){
        //creation of EIV parameters
        list<EIV_Parameter__c> parameters = Test.loadData(EIV_Parameter__c.sobjectType, 'parametrosTest');
        System.assert(parameters.size()>0);
    }
    
    @Istest
    static void getRejects(){
        Takedowns_Contingency_plan__c  tkd = Data_Factory_Takedown_Test.createTakedownNowkopp('AFINAN-FIJA', 'Papus', 'RFC102990RB');
        ApprovalRejects_controller.getRejects('Takedowns_Contingency_plan__c');
        Approval_Process_Reject__c reject = new Approval_Process_Reject__c();
        reject.Error_Type__c = 'Documentos Faltantes';
        reject.Subtype_Error__c ='Anexo';
        reject.Process_Type__c ='Takedowns_Contingency_plan__c';
        reject.Takedowns_Contingency_plan__c =tkd.Id;
        list<Approval_Process_Reject__c> rejects= new list <Approval_Process_Reject__c>();
        rejects.add(reject);
        ApprovalRejects_controller.saveRejects(rejects);
   }
}