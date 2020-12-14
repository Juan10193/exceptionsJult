trigger CreditBureauApprovalProcess_Trigger on LMM_Credit_Bureau_Approval_Process__c (after update) {
	new CreditBureauApprovalProcess_Handler().run(); 
}