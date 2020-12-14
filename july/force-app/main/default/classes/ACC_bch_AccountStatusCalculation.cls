global class ACC_bch_AccountStatusCalculation implements Database.Batchable<sObject> {
	public 	Map<String, String>	statusRuleResultMap	{get; set;}
    public 	Map<Id, String> 	accountStatusMap 	{get; set;}
    
    global ACC_bch_AccountStatusCalculation(Map<String, String> stsResultMap) {
        this.statusRuleResultMap = stsResultMap;
        this.accountStatusMap = new Map<Id, String>();
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator([SELECT Id, CreatedDate, ACC_un_Capex_Exposure__c, ACC_un_Technology_Exposure__c, ACC_un_Fleet_Exposure__c, ACC_un_Real_Estate_Exposure__c, ACC_tx_Account_Status__c FROM Account WHERE ACC_rb_Top_Parent_Account__c != null ORDER BY ACC_rb_Top_Parent_Account__c, ACC_rb_Parent_Account__c, Id]); 
    }
    
    global void execute(Database.BatchableContext BC, List<Account> scope) {  
        if (scope != null) {
            List<Account> updAccountList = new List<Account>();
            
            Set<Id> accountIdSet = new Set<Id>();
            
            for (Account account : scope) {
            	accountIdSet.add(account.Id);
            }
            
            Map<Id, String> accountStatusMap = new Map<Id, String>();
            Id previousAccountId;
            String accountStatus;
            
            for (AggregateResult arAccClass : [SELECT TBO001_rb_Account__c, TBO001_ls_Customer_Status__c FROM TBO001_AccountClassification__c WHERE TBO001_rb_Account__c IN :accountIdSet AND TBO001_ls_Customer_Status__c <> null GROUP BY TBO001_rb_Account__c, TBO001_ls_Customer_Status__c ORDER BY TBO001_rb_Account__c, TBO001_ls_Customer_Status__c DESC]) {
                Id accountId = String.valueOf(arAccClass.get('TBO001_rb_Account__c'));
                String customerStatus = String.valueOf(arAccClass.get('TBO001_ls_Customer_Status__c'));
                
                if (accountStatusMap.get(accountId) == null) {
                    accountStatus = '';
                }
                
                accountStatus += customerStatus + ';';
                accountStatusMap.put(accountId, accountStatus);
            }
            
            for (Account account : scope) {
            	if (String.isNotEmpty(accountStatusMap.get(account.Id))) {
            		String status = accountStatusMap.get(account.Id);
                    status = status.removeEnd(';');
                    
                    System.debug('Status: ' + status);
                    System.debug('Mapa Matriz Reglas de Status: ' + statusRuleResultMap);
                    
                	if (String.isNotEmpty(statusRuleResultMap.get(status))) {
                        String result = statusRuleResultMap.get(status);
                        
                        System.debug('Account Id: ' + account.Id + ' - Status: ' + status + ' --> Result: ' + result);
                        
                        account.ACC_tx_Account_Status__c = result;
                        
                        updAccountList.add(account);
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
        
        UpdateTopParentAccountStatus_Batch tpAccountStatusBatch = new UpdateTopParentAccountStatus_Batch(statusRuleResultMap, accountStatusMap, topAccountStatusMap);
        Database.executeBatch(tpAccountStatusBatch, 200);
    }
}