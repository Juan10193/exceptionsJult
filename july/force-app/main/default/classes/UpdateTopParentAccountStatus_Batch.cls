global class UpdateTopParentAccountStatus_Batch implements Database.Batchable<sObject> {
    public Map<String, String> 	statusRuleResultMap	{get; set;}
    /**public Map<Id, String> 		accountStatusMap 	{get; set;}
    public Map<Id, String> 		topParentStatusMap 	{get; set;}*/
    //public User					currentUser			{get; set;}
    
    global UpdateTopParentAccountStatus_Batch(Map<String, String> stsResultMap/**, Map<Id, String> accStatusMap, Map<Id, String> tPStatusMap*/) {
        this.statusRuleResultMap = stsResultMap;
        /**this.accountStatusMap = accStatusMap;
        this.topParentStatusMap = tPStatusMap;*/
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator([SELECT Id, CreatedDate, ACC_un_Capex_Exposure__c, ACC_un_Technology_Exposure__c, ACC_un_Fleet_Exposure__c, ACC_un_Real_Estate_Exposure__c, ACC_tx_Account_Status__c FROM Account WHERE ACC_rb_Top_Parent_Account__c = null ORDER BY Id]); 
    }
    
    global void execute(Database.BatchableContext BC, List<Account> scope) {  
        if (scope != null) {
            Set<Id> accountIdSet = new Set<Id>();
            
            for (Account acc : scope) {
                accountIdSet.add(acc.Id);
            }
            
            Map<Id, String> accountStatusMap = new Map<Id, String>();
        	String accountStatus;
                
            System.debug('Account Id Set: ' + accountIdSet);
            System.debug('Account Classification: ' + [SELECT Id, TBO001_rb_Account__c, TBO001_ls_Customer_Status__c FROM TBO001_AccountClassification__c WHERE TBO001_rb_Account__c IN :accountIdSet AND TBO001_ls_Customer_Status__c <> null ORDER BY TBO001_rb_Account__c, TBO001_ls_Customer_Status__c DESC]);
            
            for (TBO001_AccountClassification__c accClass : [SELECT Id, TBO001_rb_Account__c, TBO001_ls_Customer_Status__c FROM TBO001_AccountClassification__c WHERE TBO001_rb_Account__c IN :accountIdSet AND TBO001_ls_Customer_Status__c <> null ORDER BY TBO001_rb_Account__c, TBO001_ls_Customer_Status__c DESC]) {
            	Id accountId = accClass.TBO001_rb_Account__c;
                String customerStatus = accClass.TBO001_ls_Customer_Status__c;
                
                System.debug('Account Id: ' + accountId + ' - Customer Status: ' + customerStatus);
                
                if (accountStatusMap.get(accountId) == null) {
                    accountStatus = '';
                }
                
                if (!accountStatus.contains(customerStatus)) {
                    accountStatus += customerStatus + ';';
                    
                    System.debug('Account Id: ' + accountId + ' - Account Status: ' + accountStatus);
                                        
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
            
            Map<Id, String> topParentStatusMap = new Map<Id, String>();
            String topParentAccountStatus;
            
            for (AggregateResult arChildAcc : [SELECT ACC_rb_Top_Parent_Account__c TopParentId, ACC_tx_Account_Status__c Status FROM Account WHERE ACC_rb_Top_Parent_Account__c IN :accountIdSet AND ACC_tx_Account_Status__c <> null GROUP BY ACC_rb_Top_Parent_Account__c, ACC_tx_Account_Status__c ORDER BY ACC_rb_Top_Parent_Account__c, ACC_tx_Account_Status__c ASC]) {
                Id topParentId = String.valueOf(arChildAcc.get('TopParentId'));
                String childAccountStatus = String.valueOf(arChildAcc.get('Status'));
                
                if (topParentStatusMap.get(topParentId) == null) {
                    topParentAccountStatus = '';
                }
                
                topParentAccountStatus += childAccountStatus + ';';
                topParentStatusMap.put(topParentId, topParentAccountStatus);
            }
            
            List<Account> updAccountList = new List<Account>();
            //List<TBO001_AccountClassification__c> updAccountClassificationList = new List<TBO001_AccountClassification__c>();
            
            //Set<Id> accountIdSet = new Set<Id>();
            
            System.debug('Status RuleResultMap : ' + statusRuleResultMap);
            
            for (Account parentAccount : scope) {
            	//accountIdSet.add(parentAccount.Id);
                
                String currentStatus;
                String currentResult;
                
                System.debug('Account Id: ' + parentAccount.Id + ' - Current Status: ' + accountStatusMap.get(parentAccount.Id));
                
                if (String.isNotEmpty(accountStatusMap.get(parentAccount.Id))) {
                    currentStatus = accountStatusMap.get(parentAccount.Id);
                    currentStatus = currentStatus.removeEnd(';');
                    
                    System.debug('Account Id: ' + parentAccount.Id + ' - Current Status: ' + currentStatus);
                                    
                    System.debug('Account Id: ' + parentAccount.Id + ' - Status RuleResultMap : ' + statusRuleResultMap.get(currentStatus));
                    
                    if (String.isNotEmpty(statusRuleResultMap.get(currentStatus))) {
                        currentResult = statusRuleResultMap.get(currentStatus);
                        
                        System.debug('Account Id: ' + parentAccount.Id + ' - Current Status: ' + currentStatus + ' --> Current Result: ' + currentResult);
                    }
                }
                
                String topParentStatus;
                String topParentResult;
                
                if (String.isNotEmpty(topParentStatusMap.get(parentAccount.Id))) {
                    topParentStatus = topParentStatusMap.get(parentAccount.Id);
                    topParentStatus = topParentStatus.removeEnd(';');
                    
                    if (String.isNotEmpty(statusRuleResultMap.get(topParentStatus))) {
                        topParentResult = statusRuleResultMap.get(topParentStatus);
                        
                        System.debug('Account Id: ' + parentAccount.Id + ' - Top Parent Status: ' + topParentStatus + ' --> Top Parent Result: ' + topParentResult);
                    }
                }
                
                String finalStatus;
                
                if (String.isNotEmpty(currentResult) && String.isNotEmpty(topParentResult)) {
                    if (currentResult.compareTo(topParentResult) > 0) {
                        finalStatus = topParentResult + ';' + currentResult;
                    }
                    else if (currentResult.compareTo(topParentResult) < 0) {
                        finalStatus = currentResult + ';' + topParentResult;
                    }
                    else {
                        finalStatus = currentResult;
                    }
                }
                else if (String.isNotEmpty(currentResult) && String.isEmpty(topParentResult)) {
                    finalStatus = currentResult;
                }
                else {
                    finalStatus = topParentResult;
                }
                
                if (String.isNotEmpty(finalStatus)) {
                    if (String.isNotEmpty(this.statusRuleResultMap.get(finalStatus))) {
                        String finalResult = this.statusRuleResultMap.get(finalStatus);
                        
                        if (String.isEmpty(parentAccount.ACC_tx_Account_Status__c)) {
                            System.debug('Account Id: ' + parentAccount.Id + ' - Final Status: ' + finalStatus + ' --> Final Result: ' + finalResult);
                            
                            parentAccount.ACC_tx_Account_Status__c = finalResult;
                            
                            updAccountList.add(parentAccount);
                        }
                        else if (!parentAccount.ACC_tx_Account_Status__c.equals(finalResult)) {
                            System.debug('Account Id: ' + parentAccount.Id + ' - Final Status: ' + finalStatus + ' --> Final Result: ' + finalResult);
                            
                            parentAccount.ACC_tx_Account_Status__c = finalResult;
                            
                            updAccountList.add(parentAccount);
                        }
                    }
                }
            }
            
            /**
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
            
            Map<Id, Account> csAccountUpdateMap = accClassCustomerStatus.setAccountListStatus();
            
            if (csAccountUpdateMap != null) {
                if (csAccountUpdateMap.size() > 0) {
                    update csAccountUpdateMap.values();
                }
            }
			*/
            
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
        Messaging.SingleEmailMessage emailMsg = new Messaging.SingleEmailMessage();
        
        String[] toMail = new String[] {UserInfo.getUserEmail()};

		emailMsg.setToAddresses(toMail);
        
        emailMsg.setSubject('Resultado del Cálculo de Account Status');
        emailMsg.setHtmlBody('Hola ' +  UserInfo.getName() + ', <br/><br/>Ha finalizado la actualización másiva del Account Status para las cuentas existentes.');
        
        try {
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { emailMsg });
        }
        catch (Exception ex) {
            System.debug('Error: ' + ex.getMessage() + ' (Línea: ' + ex.getLineNumber() + ').');
        }
    }	
}