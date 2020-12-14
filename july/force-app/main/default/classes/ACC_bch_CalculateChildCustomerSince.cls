global class ACC_bch_CalculateChildCustomerSince implements Database.Batchable<sObject>, Database.Stateful {
	//private Map<Id, String> 	customerSinceMap 	{get; set;}
    
    global ACC_bch_CalculateChildCustomerSince () {
        /**this.customerSinceMap = new Map<Id, String>();
                
        for (AggregateResult customerSinceAR : [SELECT TBO001_rb_Account__c AccountId, TBO001_tx_Customer_Since__c CustomerSince FROM TBO001_AccountClassification__c WHERE TBO001_rb_Account__c <> null AND TBO001_ls_Line_of_Business__c <> null AND TBO001_tx_Customer_Since__c <> null GROUP BY TBO001_rb_Account__c, TBO001_tx_Customer_Since__c ORDER BY TBO001_rb_Account__c, TBO001_tx_Customer_Since__c]) {
            Id accountId = String.valueOf(customerSinceAR.get('AccountId'));
            String customerSince = String.valueOf(customerSinceAR.get('CustomerSince'));
            
            if (this.customerSinceMap.get(accountId) == null) {
                this.customerSinceMap.put(accountId, customerSince);
            }
        }*/
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
    	return Database.getQueryLocator([SELECT 
                                         		Id, 
                                                ACC_tx_Customer_Since__c 
                                         FROM Account  
                                         ORDER BY 	Id, 
                                         			ACC_tx_Customer_Since__c
                                        ]
                                       );
    }
                                         
    global void execute(Database.BatchableContext BC, List<Account> scope) {
        Set<Id> accountIdSet = new Set<Id>();
        
        for (Account acc : scope) {
        	accountIdSet.add(acc.Id);
        }
        
        Map<Id, String> 	customerSinceMap = new Map<Id, String>();
        
        for (AggregateResult customerSinceAR : [SELECT TBO001_rb_Account__c AccountId, TBO001_tx_Customer_Since__c CustomerSince FROM TBO001_AccountClassification__c WHERE TBO001_rb_Account__c IN :accountIdSet AND TBO001_ls_Line_of_Business__c <> null AND TBO001_tx_Customer_Since__c <> null GROUP BY TBO001_rb_Account__c, TBO001_tx_Customer_Since__c ORDER BY TBO001_rb_Account__c, TBO001_tx_Customer_Since__c]) {
            Id accountId = String.valueOf(customerSinceAR.get('AccountId'));
            String customerSince = String.valueOf(customerSinceAR.get('CustomerSince'));
            
            if (customerSinceMap.get(accountId) == null) {
                customerSinceMap.put(accountId, customerSince);
            }
        }
        
        List<Account> accountUdtList = new List<Account>();
        
        for (Account childAcc : scope) {
            String customerSince = customerSinceMap.get(childAcc.Id);
            
            if (String.isNotEmpty(customerSince)) {
                childAcc.ACC_tx_Customer_Since__c = customerSince;
                
                accountUdtList.add(childAcc);
            }
        }
        
        if (accountUdtList.size() > 0) {
            update accountUdtList;
        }
    }
             
    global void finish(Database.BatchableContext BC) {
       	System.debug('Finalizó el calculo del Customer Since para los Account hijos.');
        
        ACC_bch_CalculateTopParentCustomerSince batchTopParentAccount = new ACC_bch_CalculateTopParentCustomerSince();
        Database.executeBatch(batchTopParentAccount, 200);
    }
}