public class CreditBureauApprovalProcess_Handler extends TriggerHandlerKO{ 

    private Map<Id, LMM_Credit_Bureau_Approval_Process__c> newMapCreditBureauApprovalProcess;
    private Map<Id, LMM_Credit_Bureau_Approval_Process__c> oldMapCreditBureauApprovalProcess;
    private List<LMM_Credit_Bureau_Approval_Process__c> newListCreditBureauApprovalProcess; 
    private List<LMM_Credit_Bureau_Approval_Process__c> oldListCreditBureauApprovalProcess;
    
    private CreditBureauApprovalProcess_PostApproval creditBureauApprovalProcess_PostApproval;
    
    public CreditBureauApprovalProcess_Handler() {
        this.newMapCreditBureauApprovalProcess = (Map<Id, LMM_Credit_Bureau_Approval_Process__c>) Trigger.newMap;
    }
    public override void afterUpdate() {
        creditBureauApprovalProcess_PostApproval = new CreditBureauApprovalProcess_PostApproval(this.newMapCreditBureauApprovalProcess);
        creditBureauApprovalProcess_PostApproval.finaliceApprovalProcess();
  	}
}