global class TBO001_bch_CustomerStatusCalculation implements Database.Batchable<sObject> {
    Set<Id> 	accountIdSet	{get; set;}
    
    global TBO001_bch_CustomerStatusCalculation(Set<Id> accIdSet) {
    	this.accountIdSet = accIdSet;
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator([SELECT Id, CreatedDate, ACC_un_Capex_Exposure__c, ACC_un_Technology_Exposure__c, ACC_un_Fleet_Exposure__c, ACC_un_Real_Estate_Exposure__c, ACC_tx_Account_Status__c FROM Account WHERE Id IN :accountIdSet ORDER BY ACC_rb_Top_Parent_Account__c, ACC_rb_Parent_Account__c, Id]); 
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
    
    global void finish(Database.BatchableContext BC) {}
}