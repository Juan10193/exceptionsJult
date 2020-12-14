global class ACC_bch_CalcFinalTopParentCustomerSince implements Database.Batchable<sObject>, Database.Stateful {
	private Set<Id> 			topParentIdSet		{get; set;}
	private Map<Id, String> 	customerSinceMap 	{get; set;}
    
    global ACC_bch_CalcFinalTopParentCustomerSince () {
        this.topParentIdSet = new Set<Id>();
        this.customerSinceMap = new Map<Id, String>();
        
        for (Account childAccountCustomerSince : [SELECT ACC_rb_Top_Parent_Account__c, ACC_tx_Customer_Since__c FROM Account WHERE ACC_rb_Top_Parent_Account__c <> null ORDER BY ACC_rb_Top_Parent_Account__c, ACC_tx_Customer_Since__c]) {
            if (String.isNotEmpty(childAccountCustomerSince.ACC_tx_Customer_Since__c)) {
                this.topParentIdSet.add(childAccountCustomerSince.ACC_rb_Top_Parent_Account__c);
                
                if (this.customerSinceMap.get(childAccountCustomerSince.ACC_rb_Top_Parent_Account__c) == null) {
                	this.customerSinceMap.put(childAccountCustomerSince.ACC_rb_Top_Parent_Account__c, childAccountCustomerSince.ACC_tx_Customer_Since__c);
                }
            }
        }
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
    	return Database.getQueryLocator([SELECT 
                                         		Id, 
                                                ACC_tx_Customer_Since__c 
                                         FROM Account  
                                         WHERE Id IN :topParentIdSet
                                         AND ACC_rb_Top_Parent_Account__c = null
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
           
        Map<Id, String> customerSinceAccClassMap = new Map<Id, String>();
        
        for (AggregateResult customerSinceAR : [SELECT TBO001_rb_Account__c AccountId, TBO001_tx_Customer_Since__c CustomerSince FROM TBO001_AccountClassification__c WHERE TBO001_rb_Account__c IN :accountIdSet AND TBO001_ls_Line_of_Business__c <> null AND TBO001_tx_Customer_Since__c <> null GROUP BY TBO001_rb_Account__c, TBO001_tx_Customer_Since__c ORDER BY TBO001_rb_Account__c, TBO001_tx_Customer_Since__c]) {
            Id accountId = String.valueOf(customerSinceAR.get('AccountId'));
            String customerSince = String.valueOf(customerSinceAR.get('CustomerSince'));
            
            if (customerSinceAccClassMap.get(accountId) == null) {
                customerSinceAccClassMap.put(accountId, customerSince);
            }
        }          
        
        List<Account> accountUdtList = new List<Account>();
        
        for (Account topParentAcc : scope) {
            String customerSince = this.customerSinceMap.get(topParentAcc.Id);
            String customerSinceAccClass = customerSinceAccClassMap.get(topParentAcc.Id);
            
            String finalCustomerSince;
            
            if (String.isNotEmpty(customerSince) && String.isNotEmpty(customerSinceAccClass)) {
                if (customerSinceAccClass <= customerSince) {
                    finalCustomerSince = customerSinceAccClass;
                }
                else {
                    finalCustomerSince = customerSince;
                }
            }
            else if (String.isNotEmpty(customerSince)) {
                finalCustomerSince = customerSince;
            }
            else if (String.isNotEmpty(customerSinceAccClass)) {
                finalCustomerSince = customerSinceAccClass;
            }
            
            if (String.isNotEmpty(finalCustomerSince)) {
                if (topParentAcc.ACC_tx_Customer_Since__c > finalCustomerSince) {
                    topParentAcc.ACC_tx_Customer_Since__c = finalCustomerSince;
                    
                    accountUdtList.add(topParentAcc);
                }
            }
        }
        
        if (accountUdtList.size() > 0) {
            update accountUdtList;
        }
    }
             
    global void finish(Database.BatchableContext BC) {
        System.debug('Finalizó el calculo del Customer Since para los Top Parent Accounts finales.');
        
        Messaging.SingleEmailMessage emailMsg = new Messaging.SingleEmailMessage();
        
        String[] toMail = new String[] {UserInfo.getUserEmail()};

		emailMsg.setToAddresses(toMail);
        
        emailMsg.setSubject('Resultado del Cálculo de Customer Since');
        emailMsg.setHtmlBody('Hola ' +  UserInfo.getName() + ', <br/><br/>Ha finalizado la actualización másiva del Customer Since para las cuentas existentes.');
        
        try {
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { emailMsg });
        }
        catch (Exception ex) {
            System.debug('Error: ' + ex.getMessage() + ' (Línea: ' + ex.getLineNumber() + ').');
        }
    }
}