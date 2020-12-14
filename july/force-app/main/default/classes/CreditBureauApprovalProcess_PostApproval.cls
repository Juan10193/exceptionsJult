public class CreditBureauApprovalProcess_PostApproval {
    private Map<Id, LMM_Credit_Bureau_Approval_Process__c> newMapCreditBureauApprovalProcess;
    
    public CreditBureauApprovalProcess_PostApproval(Map<Id, LMM_Credit_Bureau_Approval_Process__c> newMapCreditBureauApprovalProcess){
        this.newMapCreditBureauApprovalProcess = newMapCreditBureauApprovalProcess;        
    }
    public void finaliceApprovalProcess(){
        list<LMM_Request_Credit_Bureau__c> listLMM_Request_Credit_Bureau = new list<LMM_Request_Credit_Bureau__c>();
        list<LMM_Request_Credit_Bureau__c> listRecordsToLockRCB = new list<LMM_Request_Credit_Bureau__c>();
        
        for(LMM_Credit_Bureau_Approval_Process__c LMM_Credit_Bureau_Approval_Process : [SELECT Id, Name, LMM_ls_Stage__c, LMM_rb_Opportunity__c, (select id, LMM_ls_Status__c from Requests_Credit_Bureau1__r) FROM LMM_Credit_Bureau_Approval_Process__c]){
            if(string.isNotEmpty(LMM_Credit_Bureau_Approval_Process.LMM_ls_Stage__c) 
               && (LMM_Credit_Bureau_Approval_Process.LMM_ls_Stage__c.equals('IN PROCESS'))){
  				for(LMM_Request_Credit_Bureau__c LMM_Request_Credit_Bureau: LMM_Credit_Bureau_Approval_Process.Requests_Credit_Bureau1__r){
                    if(string.isNotEmpty(LMM_Request_Credit_Bureau.LMM_ls_Status__c)
                      && (LMM_Request_Credit_Bureau.LMM_ls_Status__c.equals('VALIDATED'))){
                        listRecordsToLockRCB.add(LMM_Request_Credit_Bureau);
                      } else {
                      	LMM_Request_Credit_Bureau.LMM_ls_Status__c = 'IN APPROVAL PROCESS';
                    	listLMM_Request_Credit_Bureau.add(LMM_Request_Credit_Bureau); 
                        listRecordsToLockRCB.add(LMM_Request_Credit_Bureau);
                      }
                    
                }  
            } else if(string.isNotEmpty(LMM_Credit_Bureau_Approval_Process.LMM_ls_Stage__c) && LMM_Credit_Bureau_Approval_Process.LMM_ls_Stage__c.equals('REJECTED')){
  				for(LMM_Request_Credit_Bureau__c LMM_Request_Credit_Bureau: LMM_Credit_Bureau_Approval_Process.Requests_Credit_Bureau1__r){
                    LMM_Request_Credit_Bureau.LMM_ls_Status__c = 'REJECTED';
                    listLMM_Request_Credit_Bureau.add(LMM_Request_Credit_Bureau);
                }  
            } else if(string.isNotEmpty(LMM_Credit_Bureau_Approval_Process.LMM_ls_Stage__c) && LMM_Credit_Bureau_Approval_Process.LMM_ls_Stage__c.equals('APPROVED')){
         		for(LMM_Request_Credit_Bureau__c LMM_Request_Credit_Bureau: LMM_Credit_Bureau_Approval_Process.Requests_Credit_Bureau1__r){
                    LMM_Request_Credit_Bureau.LMM_ls_Status__c = 'REQUEST';
                    listLMM_Request_Credit_Bureau.add(LMM_Request_Credit_Bureau);
                    listRecordsToLockRCB.add(LMM_Request_Credit_Bureau);
                }	  
                CreditBureauApprovalProcess_batchRequest batchRequest = new CreditBureauApprovalProcess_batchRequest(LMM_Credit_Bureau_Approval_Process.LMM_rb_Opportunity__c);
                database.executeBatch(batchRequest, 100);
            }
            
        }
        CreditBureauApprovalProcess_Helper.unlockRequestCreditBureau(listLMM_Request_Credit_Bureau);
        update listLMM_Request_Credit_Bureau;
        CreditBureauApprovalProcess_Helper.lockRequestCreditBureau(listRecordsToLockRCB);
        
    }

}