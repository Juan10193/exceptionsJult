trigger TSK_tgr_UpdateDates on Task (after insert, after update, after delete) {
	Set<Id> accountIdLastDateSet = new Set<Id>();
    Set<Id> contactIdLastDateSet = new Set<Id>();
    
    if (Trigger.isInsert || Trigger.isUpdate) {
        for (Task tsk : Trigger.new) {
            if (Trigger.isInsert) { 
                if (String.isNotEmpty(tsk.Type)) {
                    if (tsk.Type.equals('Call')) {
                        if (String.isNotEmpty(tsk.WhatId)) {
                            accountIdLastDateSet.add(tsk.WhatId);
                        }
                        
                        if (String.isNotEmpty(tsk.WhoId)) {
                            contactIdLastDateSet.add(tsk.WhoId);
                        }
                    }
                }
            }
            else if (Trigger.isUpdate) {
                if (Trigger.oldMap.get(tsk.Id) != null) {
                    if (String.isNotEmpty(Trigger.oldMap.get(tsk.Id).Type)) {
                        if ((!Trigger.oldMap.get(tsk.Id).Type.equals(tsk.Type)) && tsk.Type.equals('Call')) {
                            if (String.isNotEmpty(tsk.WhatId)) {
                                accountIdLastDateSet.add(tsk.WhatId);
                            }
                            
                            if (String.isNotEmpty(tsk.WhoId)) {
                                contactIdLastDateSet.add(tsk.WhoId);
                            }
                        }
                    }
                    else if (String.isNotEmpty(tsk.Type) && tsk.Type.equals('Call')) {
                        if (String.isNotEmpty(tsk.WhatId)) {
                            accountIdLastDateSet.add(tsk.WhatId);
                        }
                        
                        if (String.isNotEmpty(tsk.WhoId)) {
                            contactIdLastDateSet.add(tsk.WhoId);
                        }
                    }
                }
            }
        }
            
        List<Task> callDateAccList;
        
        try {
            callDateAccList = [SELECT WhatId, ActivityDate FROM Task WHERE ActivityDate <= TODAY AND Type = 'Call' AND WhatId IN :accountIdLastDateSet ORDER BY WhatId, ActivityDate DESC];
        }
        catch (Exception exLCDA) {
            System.debug('Error: ' + exLCDA.getMessage() + ' (Line: ' +  exLCDA.getLineNumber() + ').');
        }
        
        if (callDateAccList != null) {
            Map<Id, Date> lastCallDateMap = new Map<Id, Date>();
            
            for (Task accTask : callDateAccList) {
                DateTime callDate = accTask.ActivityDate;
                callDate = callDate.addDays(1);
                
                if (lastCallDateMap.isEmpty()) {
                    lastCallDateMap.put(accTask.WhatId, callDate.date());
                }
                else if (lastCallDateMap.get(accTask.WhatId) == null) {
                    lastCallDateMap.put(accTask.WhatId, callDate.date());
                }
            }
        
            List<Account> accountList;
            
            try {
                accountList = [SELECT Id, ACC_fh_Last_Call_Date__c FROM Account WHERE Id IN :accountIdLastDateSet ORDER BY Id];
            }
            catch (Exception exAccList) {
                System.debug('Error: ' + exAccList.getMessage() + ' (Line: ' +  exAccList.getLineNumber() + ').');
            }
            
            List<Account> accUpdtList = new List<Account>();
            
            for (Account acc : accountList) {
                Date accLastCallDate = lastCallDateMap.get(acc.Id);
                
                if (accLastCallDate != null) {
                    acc.ACC_fh_Last_Call_Date__c = accLastCallDate;
                    
                    accUpdtList.add(acc);
                }
            }
            
            if (accUpdtList.size() > 0) {
                update accUpdtList;
            }
        }
        
        List<Task> callDateCntList;
        
        try {
            callDateCntList = [SELECT WhoId, ActivityDate FROM Task WHERE ActivityDate <= TODAY AND Type = 'Call' AND WhoId IN :contactIdLastDateSet ORDER BY WhoId, ActivityDate DESC];
        }
        catch (Exception exLCDC) {
            System.debug('Error: ' + exLCDC.getMessage() + ' (Line: ' +  exLCDC.getLineNumber() + ').');
        }
        
        if (callDateCntList != null) {
            Map<Id, Date> lastCallDateMap = new Map<Id, Date>();
            
            for (Task cntTask : callDateCntList) {
                DateTime endDate = cntTask.ActivityDate;
                endDate = endDate.addDays(1);
                
                if (lastCallDateMap.isEmpty()) {
                    lastCallDateMap.put(cntTask.WhoId, endDate.date());
                }
                else if (lastCallDateMap.get(cntTask.WhoId) == null) {
                    lastCallDateMap.put(cntTask.WhoId, endDate.date());
                }
            }
        
            List<Contact> contactList;
            
            try {
                contactList = [SELECT Id, CON_fh_Last_Call_Date__c FROM Contact WHERE Id IN :contactIdLastDateSet ORDER BY Id];
            }
            catch (Exception exCntList) {
                System.debug('Error: ' + exCntList.getMessage() + ' (Line: ' +  exCntList.getLineNumber() + ').');
            }
            
            List<Contact> cntUpdtList = new List<Contact>();
            
            for (Contact cnt : contactList) {
                Date cntLastCallDate = lastCallDateMap.get(cnt.Id);
                
                if (cntLastCallDate != null) {
                    cnt.CON_fh_Last_Call_Date__c = cntLastCallDate;
                    
                    cntUpdtList.add(cnt);
                }
            }
            
            if (cntUpdtList.size() > 0) {
                update cntUpdtList;
            }
        }
    }
    else if (Trigger.isDelete) {
        for (Task tsk : Trigger.old) {
            if (tsk.Type.equals('Call')) {
                if (String.isNotEmpty(tsk.WhatId)) {
                    accountIdLastDateSet.add(tsk.WhatId);
                }
                
                if (String.isNotEmpty(tsk.WhoId)) {
                    contactIdLastDateSet.add(tsk.WhoId);
                }
            }
        }
            
        List<Task> callDateAccList;
        
        try {
            callDateAccList = [SELECT WhatId, ActivityDate FROM Task WHERE ActivityDate <= TODAY AND Type = 'Call' AND WhatId IN :accountIdLastDateSet ORDER BY WhatId, ActivityDate DESC];
        }
        catch (Exception exLCDA) {
            System.debug('Error: ' + exLCDA.getMessage() + ' (Line: ' +  exLCDA.getLineNumber() + ').');
        }
        
        if (callDateAccList != null) {
            Map<Id, Date> lastCallDateMap = new Map<Id, Date>();
            
            for (Task accTask : callDateAccList) {
                DateTime callDate = accTask.ActivityDate;
                callDate = callDate.addDays(1);
                
                if (lastCallDateMap.isEmpty()) {
                    lastCallDateMap.put(accTask.WhatId, callDate.date());
                }
                else if (lastCallDateMap.get(accTask.WhatId) == null) {
                    lastCallDateMap.put(accTask.WhatId, callDate.date());
                }
            }
        
            List<Account> accountList;
            
            try {
                accountList = [SELECT Id, ACC_fh_Last_Call_Date__c FROM Account WHERE Id IN :accountIdLastDateSet ORDER BY Id];
            }
            catch (Exception exAccList) {
                System.debug('Error: ' + exAccList.getMessage() + ' (Line: ' +  exAccList.getLineNumber() + ').');
            }
            
            List<Account> accUpdtList = new List<Account>();
            
            for (Account acc : accountList) {
                Date accLastCallDate = lastCallDateMap.get(acc.Id);
                
                if (accLastCallDate != null) {
                    acc.ACC_fh_Last_Call_Date__c = accLastCallDate;
                    
                    accUpdtList.add(acc);
                }
                else if ((acc.ACC_fh_Last_Call_Date__c != null) && (accLastCallDate == null)) {
                    acc.ACC_fh_Last_Call_Date__c = null;
                    
                    accUpdtList.add(acc);
                }
            }
            
            if (accUpdtList.size() > 0) {
                update accUpdtList;
            }
        }
        
        List<Task> callDateCntList;
        
        try {
            callDateCntList = [SELECT WhoId, ActivityDate FROM Task WHERE ActivityDate <= TODAY AND Type = 'Call' AND WhoId IN :contactIdLastDateSet ORDER BY WhoId, ActivityDate DESC];
        }
        catch (Exception exLCDC) {
            System.debug('Error: ' + exLCDC.getMessage() + ' (Line: ' +  exLCDC.getLineNumber() + ').');
        }
        
        if (callDateCntList != null) {
            Map<Id, Date> lastCallDateMap = new Map<Id, Date>();
            
            for (Task cntTask : callDateCntList) {
                DateTime endDate = cntTask.ActivityDate;
                endDate = endDate.addDays(1);
                
                if (lastCallDateMap.isEmpty()) {
                    lastCallDateMap.put(cntTask.WhoId, endDate.date());
                }
                else if (lastCallDateMap.get(cntTask.WhoId) == null) {
                    lastCallDateMap.put(cntTask.WhoId, endDate.date());
                }
            }
        
            List<Contact> contactList;
            
            try {
                contactList = [SELECT Id, CON_fh_Last_Call_Date__c FROM Contact WHERE Id IN :contactIdLastDateSet ORDER BY Id];
            }
            catch (Exception exCntList) {
                System.debug('Error: ' + exCntList.getMessage() + ' (Line: ' +  exCntList.getLineNumber() + ').');
            }
            
            List<Contact> cntUpdtList = new List<Contact>();
            
            for (Contact cnt : contactList) {
                Date cntLastCallDate = lastCallDateMap.get(cnt.Id);
                
                if (cntLastCallDate != null) {
                    cnt.CON_fh_Last_Call_Date__c = cntLastCallDate;
                    
                    cntUpdtList.add(cnt);
                }
                else if ((cnt.CON_fh_Last_Call_Date__c != null) && (cntLastCallDate == null)) {
                    cnt.CON_fh_Last_Call_Date__c = null;
                    
                    cntUpdtList.add(cnt);
                }
            }
            
            if (cntUpdtList.size() > 0) {
                update cntUpdtList;
            }
        }
    }
}