public with sharing class ACC_cvf_CalculateAccountStatus {
    public Map<String, String> statusRuleResultMap {get; set;}
    
	public ACC_cvf_CalculateAccountStatus() {
        this.statusRuleResultMap = new Map<String, String>();
        
        for (Account_Status_Rules_Matrix__c rule : [SELECT Status__c, Result__c FROM Account_Status_Rules_Matrix__c]) {            
            this.statusRuleResultMap.put(rule.Status__c, rule.Result__c);
        }
    }
    
    public PageReference doCalculate() {
    	/**
        UpdateCustomerStatus_Batch customerStatusBatch = new UpdateCustomerStatus_Batch();
        Database.executeBatch(customerStatusBatch, 200);
        
        UpdateTopParentAccountStatus_Batch tpAccountStatusBatch = new UpdateTopParentAccountStatus_Batch();
        Database.executeBatch(tpAccountStatusBatch, 200);
        */
        
        UpdateCustomerStatus_Batch customerStatusBatch = new UpdateCustomerStatus_Batch(this.statusRuleResultMap);
        Database.executeBatch(customerStatusBatch, 200);
        
    	return null;
    }
}