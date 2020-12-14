@Istest
private class Data_Access_TBO014_Credit_Approval_Test {
	@Istest
    static void getCABysetIDTest(){
        set<Id> ids = new set<id>();
        Credit_approval_CP__c cp =  Data_Factory_CreditApproval_Test.createNewCreditApprovalTypeCA('accountName');
        ids.add(cp.Id);
        try{
             Data_Access_TBO014_Credit_Approval.getCABysetID(ids);
        }catch(exception e){
            
        }
       
    }
}