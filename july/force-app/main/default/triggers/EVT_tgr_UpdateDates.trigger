trigger EVT_tgr_UpdateDates on Event (after insert, after update, after delete) {
    Set<Id> accountIdLastDateSet = new Set<Id>();
    Set<Id> contactIdLastDateSet = new Set<Id>();
    
    if (Trigger.isInsert || Trigger.isUpdate) {
        for (Event evt : Trigger.new) {
            if (Trigger.isInsert) { 
                if (String.isNotEmpty(evt.WhatId)) {
                    accountIdLastDateSet.add(evt.WhatId);
                }
                
                if (String.isNotEmpty(evt.WhoId)) {
                    contactIdLastDateSet.add(evt.WhoId);
                }
            }
            else if (Trigger.isUpdate) {
                if (String.isNotEmpty(evt.WhatId)) {
                    accountIdLastDateSet.add(evt.WhatId);
                }
                
                if (String.isNotEmpty(evt.WhoId)) {
                    contactIdLastDateSet.add(evt.WhoId);
                }
            }
        }
            
        List<Event> meetingDateAccList;
        
        try {
            meetingDateAccList = [SELECT WhatId, EndDateTime FROM Event WHERE EndDateTime <= TODAY AND WhatId IN :accountIdLastDateSet ORDER BY WhatId, EndDateTime DESC];
        }
        catch (Exception exLMDA) {
            System.debug('Error: ' + exLMDA.getMessage() + ' (Line: ' +  exLMDA.getLineNumber() + ').');
        }
        
        if (meetingDateAccList != null) {
            Map<Id, Date> lastMeetingDateMap = new Map<Id, Date>();
            
            for (Event accEvent : meetingDateAccList) {
                DateTime endDate = accEvent.EndDateTime;
                
                if (lastMeetingDateMap.isEmpty()) {
                    lastMeetingDateMap.put(accEvent.WhatId, endDate.date());
                }
                else if (lastMeetingDateMap.get(accEvent.WhatId) == null) {
                    lastMeetingDateMap.put(accEvent.WhatId, endDate.date());
                }
            }
        
            List<Account> accountList;
        
            try {
                accountList = [SELECT Id, ACC_fh_Last_meeting_Date__c FROM Account WHERE Id IN :accountIdLastDateSet ORDER BY Id];
            }
            catch (Exception exAccList) {
                System.debug('Error: ' + exAccList.getMessage() + ' (Line: ' +  exAccList.getLineNumber() + ').');
            }
            
            List<Account> accUpdtList = new List<Account>();
            
            for (Account acc : accountList) {
                Date accLastMeetingDate = lastMeetingDateMap.get(acc.Id);
                
                if (accLastMeetingDate != null) {
                    acc.ACC_fh_Last_meeting_Date__c = accLastMeetingDate;
                    
                    accUpdtList.add(acc);
                }
            }
            
            if (accUpdtList.size() > 0) {
                update accUpdtList;
            }
        }
        
        List<Event> meetingDateCntList;
        
        try {
            meetingDateCntList = [SELECT WhoId, EndDateTime FROM Event WHERE EndDateTime <= TODAY AND WhoId IN :contactIdLastDateSet ORDER BY WhoId, EndDateTime DESC];
        }
        catch (Exception exLMDC) {
            System.debug('Error: ' + exLMDC.getMessage() + ' (Line: ' +  exLMDC.getLineNumber() + ').');
        }
        
        if (meetingDateCntList != null) {
            Map<Id, Date> lastMeetingDateMap = new Map<Id, Date>();
            
            for (Event cntEvent : meetingDateCntList) {
                DateTime endDate = cntEvent.EndDateTime;
                
                if (lastMeetingDateMap.isEmpty()) {
                    lastMeetingDateMap.put(cntEvent.WhoId, endDate.date());
                }
                else if (lastMeetingDateMap.get(cntEvent.WhoId) == null) {
                    lastMeetingDateMap.put(cntEvent.WhoId, endDate.date());
                }
            }
        
            List<Contact> contactList;
            
            try {
                contactList = [SELECT Id, CON_fh_Last_meeting_Date__c FROM Contact WHERE Id IN :contactIdLastDateSet ORDER BY Id];
            }
            catch (Exception exCntList) {
                System.debug('Error: ' + exCntList.getMessage() + ' (Line: ' +  exCntList.getLineNumber() + ').');
            }
            
            List<Contact> cntUpdtList = new List<Contact>();
            
            for (Contact cnt : contactList) {
                Date cntLastMeetingDate = lastMeetingDateMap.get(cnt.Id);
                
                if (cntLastMeetingDate != null) {
                    cnt.CON_fh_Last_meeting_Date__c = cntLastMeetingDate;
                    
                    cntUpdtList.add(cnt);
                }
            }
            
            if (cntUpdtList.size() > 0) {
                update cntUpdtList;
            }
        }
    }
    else if (Trigger.isDelete) {
        for (Event evt : Trigger.old) { 
            if (String.isNotEmpty(evt.WhatId)) {
                accountIdLastDateSet.add(evt.WhatId);
            }
            
            if (String.isNotEmpty(evt.WhoId)) {
                contactIdLastDateSet.add(evt.WhoId);
            }
        }
        
        List<Event> meetingDateAccList;
        
        try {
            meetingDateAccList = [SELECT WhatId, EndDateTime FROM Event WHERE EndDateTime <= TODAY AND WhatId IN :accountIdLastDateSet ORDER BY WhatId, EndDateTime DESC];
        }
        catch (Exception exLMDA) {
            System.debug('Error: ' + exLMDA.getMessage() + ' (Line: ' +  exLMDA.getLineNumber() + ').');
        }
        
        if (meetingDateAccList != null) {
            Map<Id, Date> lastMeetingDateMap = new Map<Id, Date>();
            
            for (Event accEvent : meetingDateAccList) {
                DateTime endDate = accEvent.EndDateTime;
                
                if (lastMeetingDateMap.isEmpty()) {
                    lastMeetingDateMap.put(accEvent.WhatId, endDate.date());
                }
                else if (lastMeetingDateMap.get(accEvent.WhatId) == null) {
                    lastMeetingDateMap.put(accEvent.WhatId, endDate.date());
                }
            }
        
            List<Account> accountList;
        
            try {
                accountList = [SELECT Id, ACC_fh_Last_meeting_Date__c FROM Account WHERE Id IN :accountIdLastDateSet ORDER BY Id];
            }
            catch (Exception exAccList) {
                System.debug('Error: ' + exAccList.getMessage() + ' (Line: ' +  exAccList.getLineNumber() + ').');
            }
            
            List<Account> accUpdtList = new List<Account>();
            
            for (Account acc : accountList) {
                Date accLastMeetingDate = lastMeetingDateMap.get(acc.Id);
                
                if (accLastMeetingDate != null) {
                    acc.ACC_fh_Last_meeting_Date__c = accLastMeetingDate;
                    
                    accUpdtList.add(acc);
                }
                else if ((acc.ACC_fh_Last_meeting_Date__c != null) && (accLastMeetingDate == null)) {
                    acc.ACC_fh_Last_meeting_Date__c = null;
                    
                    accUpdtList.add(acc);
                }
            }
            
            if (accUpdtList.size() > 0) {
                update accUpdtList;
            }
        }
        
        List<Event> meetingDateCntList;
        
        try {
            meetingDateCntList = [SELECT WhoId, EndDateTime FROM Event WHERE EndDateTime <= TODAY AND WhoId IN :contactIdLastDateSet ORDER BY WhoId, EndDateTime DESC];
        }
        catch (Exception exLMDC) {
            System.debug('Error: ' + exLMDC.getMessage() + ' (Line: ' +  exLMDC.getLineNumber() + ').');
        }
        
        if (meetingDateCntList != null) {
            Map<Id, Date> lastMeetingDateMap = new Map<Id, Date>();
            
            for (Event cntEvent : meetingDateCntList) {
                DateTime endDate = cntEvent.EndDateTime;
                
                if (lastMeetingDateMap.isEmpty()) {
                    lastMeetingDateMap.put(cntEvent.WhoId, endDate.date());
                }
                else if (lastMeetingDateMap.get(cntEvent.WhoId) == null) {
                    lastMeetingDateMap.put(cntEvent.WhoId, endDate.date());
                }
            }
        
            List<Contact> contactList;
            
            try {
                contactList = [SELECT Id, CON_fh_Last_meeting_Date__c FROM Contact WHERE Id IN :contactIdLastDateSet ORDER BY Id];
            }
            catch (Exception exCntList) {
                System.debug('Error: ' + exCntList.getMessage() + ' (Line: ' +  exCntList.getLineNumber() + ').');
            }
            
            List<Contact> cntUpdtList = new List<Contact>();
            
            for (Contact cnt : contactList) {
                Date cntLastMeetingDate = lastMeetingDateMap.get(cnt.Id);
                
                if (cntLastMeetingDate != null) {
                    cnt.CON_fh_Last_meeting_Date__c = cntLastMeetingDate;
                    
                    cntUpdtList.add(cnt);
                }
                else if ((cnt.CON_fh_Last_meeting_Date__c != null) && (cntLastMeetingDate == null)) {
                    cnt.CON_fh_Last_meeting_Date__c = null;
                    
                    cntUpdtList.add(cnt);
                }
            }
            
            if (cntUpdtList.size() > 0) {
                update cntUpdtList;
            }
        }
    }
}