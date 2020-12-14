public class CreditBureauApprovalProcess_Helper {
    
    public static void lockRequestCreditBureau(list<LMM_Request_Credit_Bureau__c> listLMM_Request_Credit_Bureau){
        list<Approval.LockResult> listLockResult = Approval.lock(listLMM_Request_Credit_Bureau);
        for(Approval.LockResult lr : listLockResult) {
            if (lr.isSuccess()) {
                System.debug('Successfully locked account with ID: ' + lr.getId());
            }
            else {              
                for(Database.Error err : lr.getErrors()) {
                    System.debug('The following error has occurred.');                    
                    System.debug(err.getStatusCode() + ': ' + err.getMessage());
                    System.debug('Account fields that affected this error: ' + err.getFields());
                }
            }
        }
    }
    
    public static void unlockRequestCreditBureau(list<LMM_Request_Credit_Bureau__c> listLMM_Request_Credit_Bureau){
        list<Approval.UnlockResult> listUnlockResult = Approval.unlock(listLMM_Request_Credit_Bureau);
        for(Approval.UnlockResult lr : listUnlockResult) {
            if (lr.isSuccess()) {
                System.debug('Successfully unlocked Request_Credit_Bureau with ID: ' + lr.getId());
            }
            else {              
                for(Database.Error err : lr.getErrors()) {
                    System.debug('The following error has occurred.');                    
                    System.debug(err.getStatusCode() + ': ' + err.getMessage());
                    System.debug('Request_Credit_Bureau fields that affected this error: ' + err.getFields());
                }
            }
        }
    }
    

}