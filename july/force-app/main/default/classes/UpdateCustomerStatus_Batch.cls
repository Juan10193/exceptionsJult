global class UpdateCustomerStatus_Batch implements Database.Batchable<sObject> {
    public Map<String, String> 	statusRuleResultMap	{get; set;}
    public Map<Id, String> 		accountStatusMap 	{get; set;}
    //public User					currentUser			{get; set;}
    
    global UpdateCustomerStatus_Batch(Map<String, String> stsResultMap) {
        this.statusRuleResultMap = stsResultMap;
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator([SELECT Id, CreatedDate, ACC_un_Capex_Exposure__c, ACC_un_Technology_Exposure__c, ACC_un_Fleet_Exposure__c, ACC_un_Real_Estate_Exposure__c, ACC_tx_Account_Status__c FROM Account ORDER BY ACC_rb_Top_Parent_Account__c, ACC_rb_Parent_Account__c, Id]); 
    }
    
    global void execute(Database.BatchableContext BC, List<Account> scope) {  
        if (scope != null) {
            List<Account> updAccountList = new List<Account>();
            List<TBO001_AccountClassification__c> updAccountClassificationList = new List<TBO001_AccountClassification__c>();
            
            Set<Id> accountIdSet = new Set<Id>();
            
            for (Account account : scope) {
            	accountIdSet.add(account.Id);
            }
            
            List<TBO001_AccountClassification__c> accountClassificationList;
            
            try {
                accountClassificationList = [SELECT Id, TBO001_ls_Customer_Status__c, TBO001_ls_Line_of_Business__c, TBO001_tx_Customer_Since__c, TBO001_rb_Account__c FROM TBO001_AccountClassification__c WHERE TBO001_rb_Account__c IN :accountIdSet];
            }
            catch (Exception exACList) {
                System.debug('Error: ' + exACList.getMessage() + ' (Line: ' + exACList.getLineNumber() + ').');
            }            

            CustomerStatus_cls accClassCustomerStatus = new CustomerStatus_cls(accountClassificationList);
                    
            accClassCustomerStatus.setAccountClassificationStatusFromList();
            
            if (accountClassificationList.size() > 0) {
                update accountClassificationList;
            }
        }
    }
    
    global void finish(Database.BatchableContext BC) {
        //Integer recordCount = [SELECT COUNT() FROM TBO001_AccountClassification__c WHERE TBO001_rb_Account__c <> null AND TBO001_ls_Customer_Status__c <> null];
        
        //Integer sizeBlock = recordCount/2000 + (Math.mod(recordCount, 2000) != 0? 1 : 0);
        
        //Set<Id> accClassIdSet = new Set<Id>();
        
        //Map<Id, String> accountStatusMap = new Map<Id, String>();
        //String accountStatus;
       
        //Boolean hasData = true;
        
        //Integer cont = 0;
        
        //while (hasData) {
        //for (Integer i=0; i < sizeBlock; i++) {
        //	Boolean enteredIteration = false;
            
        /**    for (TBO001_AccountClassification__c accClass : [SELECT Id, TBO001_rb_Account__c, TBO001_ls_Customer_Status__c FROM TBO001_AccountClassification__c WHERE TBO001_rb_Account__c <> null AND TBO001_ls_Customer_Status__c <> null AND Id NOT IN :accClassIdSet ORDER BY TBO001_rb_Account__c, TBO001_ls_Customer_Status__c DESC LIMIT 2000]) {
                Id accountId = accClass.TBO001_rb_Account__c;
                String customerStatus = accClass.TBO001_ls_Customer_Status__c;
                
                if (accountStatusMap.get(accountId) == null) {
                    accountStatus = '';
                }
                
                if (!accountStatus.contains(customerStatus)) {
                    accountStatus += customerStatus + ';';
                    accountStatusMap.put(accountId, accountStatus);
                }
                
                accClassIdSet.add(accClass.Id);
                
                cont++;
                enteredIteration = true;
            }
            
            if (!enteredIteration) {
                hasData = false;
            }
        }
        */
        //System.debug('Record Count: ' + recordCount);
        //System.debug('Cont: ' + cont);
        
        UpdateChildAccountStatus_Batch chldAccountStatusBatch = new UpdateChildAccountStatus_Batch(statusRuleResultMap/**, accountStatusMap*/);
        Database.executeBatch(chldAccountStatusBatch, 200);
    }
}