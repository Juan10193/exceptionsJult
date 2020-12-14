global class UpdateLastCallDate_Batch implements Database.Batchable<sObject> {
    Set<String> setWhoId = new Set<String>();
    Set<String> setWhatId = new Set<String>();
    
    global Database.QueryLocator start(Database.BatchableContext BC) {  
        Date antier = Date.today();
        antier = antier.adddays(-2);
        
        Date hoy = Date.today();
        
        return Database.getQueryLocator([SELECT t.Id, t.WhoId, t.WhatId, t.ActivityDate, t.AccountId, t.Type FROM Task t WHERE t.ActivityDate >: antier AND t.ActivityDate <: hoy AND Type = 'Call' ORDER BY t.WhatId, t.WhoId, t.ActivityDate DESC]); 
    }
    
    global void execute(Database.BatchableContext BC, List<Task> scope) {  
        List<Task> lstTasks = (List<Task>)scope;
        
        for(Task t : lstTasks) {
            setWhoId.add(t.WhoId);
            setWhatId.add(t.WhatId);
        }
        
        List<Contact> lstContacts = [SELECT c.CON_fh_Last_Call_Date__c, c.Id FROM Contact c WHERE Id IN :setWhoId];
        List<Account> lstAccounts = [SELECT a.ACC_fh_Last_Call_Date__c, a.Id FROM Account a WHERE Id IN :setWhatId];
        
        for(Task t : lstTasks) {	
            for(Contact c : lstContacts) {
                c.CON_fh_Last_Call_Date__c = Date.ValueOf(t.ActivityDate);
            }
            for(Account a : lstAccounts) {
                a.ACC_fh_Last_Call_Date__c = Date.ValueOf(t.ActivityDate);
            }
        }
        
        if(lstContacts != null) {
            update lstContacts;  		
        }
        
        if(lstAccounts != null) {
            update lstAccounts;   		
        }
    }
    
    global void finish(Database.BatchableContext BC)
    {  	
    } 
}