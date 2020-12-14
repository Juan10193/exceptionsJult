global class UpdateLastMeetingDate_Batch implements Database.Batchable<sObject> {
    
    set<String> setWhoId = new set<String>();
    set<String> setWhatId = new set<String>();
    
    global Database.QueryLocator start(Database.BatchableContext BC) {  
        Date antier = Date.today();
        antier = antier.adddays(-2);
        
        Date hoy = Date.today();
        
        return Database.getQueryLocator([SELECT e.Id, e.WhoId, e.WhatId, e.EndDateTime, e.AccountId FROM Event e WHERE e.EndDateTime >: antier AND e.EndDateTime <: hoy ]); 
    }
    
    global void execute(Database.BatchableContext BC, List<Event> scope) {  
        List<Event> lstEvents = (List<Event>)scope;
        
        for(Event e : lstEvents) {
            setWhoId.add(e.WhoId);
            setWhatId.add(e.WhatId);
        }
        
        List<Contact> lstContacts = [SELECT c.CON_fh_Last_meeting_Date__c, c.Id FROM Contact c WHERE Id IN :setWhoId];
        List<Account> lstAccounts = [SELECT a.ACC_fh_Last_meeting_Date__c, a.Id FROM Account a WHERE Id IN :setWhatId];
        
        for(Event e : lstEvents) {		
            for(Contact c : lstContacts) {
                c.CON_fh_Last_meeting_Date__c = Date.ValueOf(e.EndDateTime);
            }
            for(Account a:lstAccounts) {
                a.ACC_fh_Last_meeting_Date__c = Date.ValueOf(e.EndDateTime);
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