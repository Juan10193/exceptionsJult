global class UpdateChildAccountStatus_Batch implements Database.Batchable<sObject> {
	public Map<String, String> 	statusRuleResultMap	{get; set;}
    //public Map<Id, String> 		accountStatusMap 	{get; set;}
    //public User					currentUser			{get; set;}
    
    global UpdateChildAccountStatus_Batch(Map<String, String> stsResultMap/**, Map<Id, String> accStatusMap*/) {
        this.statusRuleResultMap = stsResultMap;
        //this.accountStatusMap = accStatusMap;
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator([SELECT Id, CreatedDate, ACC_un_Capex_Exposure__c, ACC_un_Technology_Exposure__c, ACC_un_Fleet_Exposure__c, ACC_un_Real_Estate_Exposure__c, ACC_tx_Account_Status__c FROM Account ORDER BY ACC_rb_Top_Parent_Account__c, ACC_rb_Parent_Account__c, Id]); 
    }
    
    global void execute(Database.BatchableContext BC, List<Account> scope) {  
        if (scope != null) {
            Set<Id> accountIdSet = new Set<Id>();
            
            for (Account acc : scope) {
                accountIdSet.add(acc.Id);
            }
            
            Map<Id, String> accountStatusMap = new Map<Id, String>();
        	String accountStatus;
            
            for (TBO001_AccountClassification__c accClass : [SELECT Id, TBO001_rb_Account__c, TBO001_ls_Customer_Status__c FROM TBO001_AccountClassification__c WHERE TBO001_rb_Account__c IN :accountIdSet AND TBO001_ls_Customer_Status__c <> null ORDER BY TBO001_rb_Account__c, TBO001_ls_Customer_Status__c DESC]) {
            	Id accountId = accClass.TBO001_rb_Account__c;
                String customerStatus = accClass.TBO001_ls_Customer_Status__c;
                
                if (accountStatusMap.get(accountId) == null) {
                    accountStatus = '';
                }
                
                if (!accountStatus.contains(customerStatus)) {
                    accountStatus += customerStatus + ';';
                    accountStatusMap.put(accountId, accountStatus);
                }
            }
            
            for (Id accountId : accountStatusMap.keySet()) {
                String accStatus = accountStatusMap.get(accountId);
                
                System.debug('Account Id: ' + accountId + ' - Account Status: ' + accStatus);
                
                String[] statusArr = accStatus.split(';');

                for (Integer i = 1; i < statusArr.size(); i++) {
                    String previousStatus = statusArr[i - 1];
                    String currentStatus = statusArr[i];
                    
                    if (currentStatus.compareTo(previousStatus) < 0) {
                        statusArr[i - 1] = currentStatus;
                        statusArr[i] = previousStatus;
                    }
                }
                
                String finalAccountStatus = '';
                
                for (String status : statusArr) {
                    finalAccountStatus += status + ';';
                }
                
                System.debug('Account Id: ' + accountId + ' - Final Account Status: ' + finalAccountStatus);
                
                accountStatusMap.put(accountId, finalAccountStatus);
            }
            
            List<Account> updAccountList = new List<Account>();
            
            for (Account account : scope) {
            	if (String.isNotEmpty(accountStatusMap.get(account.Id))) {
            		String status = accountStatusMap.get(account.Id);
                    status = status.removeEnd(';');
                    
                	if (String.isNotEmpty(statusRuleResultMap.get(status))) {
                        String result = statusRuleResultMap.get(status);
                        
                        if (String.isEmpty(account.ACC_tx_Account_Status__c)) {
                            System.debug('Account Id: ' + account.Id + ' - Status: ' + status + ' --> Result: ' + result);
                            
                            account.ACC_tx_Account_Status__c = result;
                            
                            updAccountList.add(account);
                        }
                        else if (!account.ACC_tx_Account_Status__c.equals(result)) {
                            System.debug('Account Id: ' + account.Id + ' - Status: ' + status + ' --> Result: ' + result);
                            
                            account.ACC_tx_Account_Status__c = result;
                            
                            updAccountList.add(account);
                        }
                    }
                }
            }
            
            if (updAccountList.size() > 0) {
                try {
                	update updAccountList;
                }
                catch (Exception exUpdAcc) {
                    System.debug('Error: ' + exUpdAcc.getMessage() + ' (Line: ' + exUpdAcc.getLineNumber() + ').');
                }
            }
        }
    }
    
    global void finish(Database.BatchableContext BC) {
        Map<Id, String> topAccountStatusMap = new Map<Id, String>();
        Id previousAccountId;
        String accountStatus;
        
        for (AggregateResult arChildAcc : [SELECT ACC_rb_Top_Parent_Account__c TopParentId, ACC_tx_Account_Status__c Status FROM Account WHERE ACC_rb_Top_Parent_Account__c <> null AND ACC_tx_Account_Status__c <> null GROUP BY ACC_rb_Top_Parent_Account__c, ACC_tx_Account_Status__c ORDER BY ACC_rb_Top_Parent_Account__c, ACC_tx_Account_Status__c ASC]) {
            Id topParentId = String.valueOf(arChildAcc.get('TopParentId'));
            String childAccountStatus = String.valueOf(arChildAcc.get('Status'));
            
            if (topAccountStatusMap.get(topParentId) == null) {
                accountStatus = '';
            }
            
            accountStatus += childAccountStatus + ';';
            topAccountStatusMap.put(topParentId, accountStatus);
        }
        
        UpdateTopParentAccountStatus_Batch tpAccountStatusBatch = new UpdateTopParentAccountStatus_Batch(statusRuleResultMap/**, accountStatusMap, topAccountStatusMap*/);
        Database.executeBatch(tpAccountStatusBatch, 200);
    }
}