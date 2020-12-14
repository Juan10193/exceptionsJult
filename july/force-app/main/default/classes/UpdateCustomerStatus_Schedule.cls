global class UpdateCustomerStatus_Schedule implements Schedulable {
    global void execute(SchedulableContext sc) {
        Map<String, String> statusRuleResultMap = new Map<String, String>();
        
        for (Account_Status_Rules_Matrix__c rule : [SELECT Status__c, Result__c FROM Account_Status_Rules_Matrix__c]) {            
            statusRuleResultMap.put(rule.Status__c, rule.Result__c);
        }
        
       /**
        Map<Id, String> accountStatusMap = new Map<Id, String>();
        Id previousAccountId;
        String accountStatus;
        
        for (AggregateResult arAccClass : [SELECT TBO001_rb_Account__c, TBO001_ls_Customer_Status__c FROM TBO001_AccountClassification__c WHERE TBO001_rb_Account__c <> null AND TBO001_ls_Customer_Status__c <> null GROUP BY TBO001_rb_Account__c, TBO001_ls_Customer_Status__c ORDER BY TBO001_rb_Account__c, TBO001_ls_Customer_Status__c DESC]) {
            Id accountId = String.valueOf(arAccClass.get('TBO001_rb_Account__c'));
            String customerStatus = String.valueOf(arAccClass.get('TBO001_ls_Customer_Status__c'));
            
            if (accountStatusMap.get(accountId) == null) {
                accountStatus = '';
            }
            
            accountStatus += customerStatus + ';';
            accountStatusMap.put(accountId, accountStatus);
        }
        
        UpdateCustomerStatus_Batch customerStatusBatch = new UpdateCustomerStatus_Batch(statusRuleResultMap, accountStatusMap);
        Database.executeBatch(customerStatusBatch, 200);
		*/
        UpdateCustomerStatus_Batch customerStatusBatch = new UpdateCustomerStatus_Batch(statusRuleResultMap);
        Database.executeBatch(customerStatusBatch, 200);
   }
}