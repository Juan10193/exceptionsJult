trigger CON_tgr_UpdateContactDate on Task (after insert, after update) {
    Set<Id> accountIdLastActivityDateSet = new Set<Id>();
    Set<Id> contactIdLastActivityDateSet = new Set<Id>();
    Set<Id> accountIdLastCallDateSet = new Set<Id>();
    Set<Id> contactIdLastCallDateSet = new Set<Id>();
    
    for (Task tsk : Trigger.new) {
        if (Trigger.isInsert) {
            if (tsk.Status.equals('Completed')) {
                if (String.isNotEmpty(tsk.WhatId)) {
                    accountIdLastActivityDateSet.add(tsk.WhatId);
                }
                
                if (String.isNotEmpty(tsk.WhoId)) {
                    contactIdLastActivityDateSet.add(tsk.WhoId);
                }
            }
            
            if (tsk.Subject.equals('Call')) {
                if (String.isNotEmpty(tsk.WhatId)) {
                    accountIdLastCallDateSet.add(tsk.WhatId);
                }
                
                if (String.isNotEmpty(tsk.WhoId)) {
                    contactIdLastCallDateSet.add(tsk.WhoId);
                }
            }
        }
        else if (Trigger.isUpdate) {
            if ((!tsk.Status.equals(Trigger.oldMap.get(tsk.Id).Status)) && (tsk.Status.equals('Completed'))) {
                if (String.isNotEmpty(tsk.WhatId)) {
                    accountIdLastActivityDateSet.add(tsk.WhatId);
                }
                
                if (String.isNotEmpty(tsk.WhoId)) {
                    contactIdLastActivityDateSet.add(tsk.WhoId);
                }
            }
            
            if ((!tsk.Subject.equals(Trigger.oldMap.get(tsk.Id).Subject)) && (tsk.Subject.equals('Call'))) {
                if (String.isNotEmpty(tsk.WhatId)) {
                    accountIdLastCallDateSet.add(tsk.WhatId);
                }
                
                if (String.isNotEmpty(tsk.WhoId)) {
                    contactIdLastCallDateSet.add(tsk.WhoId);
                }
            }
        }
    }
    
    if (accountIdLastActivityDateSet.size() > 0) {
        List<Account> accountUpdtLastActivityDateList;
        
        try {
            accountUpdtLastActivityDateList = [SELECT Id, ACC_fm_Last_Touched_date__c FROM Account WHERE Id IN :accountIdLastActivityDateSet ORDER BY Id];
        }
        catch (Exception exAccLastActivityDateList) {
            System.debug('Error: ' + exAccLastActivityDateList.getMessage() + ' (Line: ' + exAccLastActivityDateList.getLineNumber() + ').');
        }
        
        if (accountUpdtLastActivityDateList != null) {
            for (Account acc : accountUpdtLastActivityDateList) {
                //acc.ACC_fm_Last_Touched_date__c = Date.today();
            }
            
            try {
                update accountUpdtLastActivityDateList;
            }
            catch (Exception exUpdtLastActivityDateAcc) {
                System.debug('Error: ' + exUpdtLastActivityDateAcc.getMessage() + ' (Line: ' + exUpdtLastActivityDateAcc.getLineNumber() + ').');
            }
        }
    }
    
    if (contactIdLastActivityDateSet.size() > 0) {
        List<Contact> contactUpdtLastActivityDateList;
        
        try {
            contactUpdtLastActivityDateList = [SELECT Id, CON_fh_Last_activity_date__c FROM Contact WHERE Id IN :contactIdLastActivityDateSet ORDER BY Id];
        }
        catch (Exception exConLastActivityDateList) {
            System.debug('Error: ' + exConLastActivityDateList.getMessage() + ' (Line: ' + exConLastActivityDateList.getLineNumber() + ').');
        }
        
        if (contactUpdtLastActivityDateList != null) {
            for (Contact con : contactUpdtLastActivityDateList) {
                con.CON_fh_Last_activity_date__c = Date.today();
            }
            
            try {
                update contactUpdtLastActivityDateList;
            }
            catch (Exception exUpdtLastActivityDateCon) {
                System.debug('Error: ' + exUpdtLastActivityDateCon.getMessage() + ' (Line: ' + exUpdtLastActivityDateCon.getLineNumber() + ').');
            }
        }
    }
        
    if (accountIdLastCallDateSet.size() > 0) {
        List<Account> accountUpdtLastCallDateList;
        
        try {
            accountUpdtLastCallDateList = [SELECT Id, ACC_fm_Last_Touched_date__c FROM Account WHERE Id IN :accountIdLastCallDateSet ORDER BY Id];
        }
        catch (Exception exAccLastCallDateList) {
            System.debug('Error: ' + exAccLastCallDateList.getMessage() + ' (Line: ' + exAccLastCallDateList.getLineNumber() + ').');
        }
        
        if (accountUpdtLastCallDateList != null) {
            for (Account acc : accountUpdtLastCallDateList) {
                //acc.ACC_fm_Last_Touched_date__c = Date.today();
            }
            
            try {
                update accountUpdtLastCallDateList;
            }
            catch (Exception exUpdtLastCallDateAcc) {
                System.debug('Error: ' + exUpdtLastCallDateAcc.getMessage() + ' (Line: ' + exUpdtLastCallDateAcc.getLineNumber() + ').');
            }
        }
    }
    
    if (contactIdLastCallDateSet.size() > 0) {
        List<Contact> contactUpdtLastCallDateList;
        
        try {
            contactUpdtLastCallDateList = [SELECT Id, CON_fh_Last_activity_date__c FROM Contact WHERE Id IN :contactIdLastCallDateSet ORDER BY Id];
        }
        catch (Exception exConLastCallDateList) {
            System.debug('Error: ' + exConLastCallDateList.getMessage() + ' (Line: ' + exConLastCallDateList.getLineNumber() + ').');
        }
        
        if (contactUpdtLastCallDateList != null) {
            for (Contact con : contactUpdtLastCallDateList) {
                con.CON_fh_Last_activity_date__c = Date.today();
            }
            
            try {
                update contactUpdtLastCallDateList;
            }
            catch (Exception exUpdtLastCallDateCon) {
                System.debug('Error: ' + exUpdtLastCallDateCon.getMessage() + ' (Line: ' + exUpdtLastCallDateCon.getLineNumber() + ').');
            }
        }
    }
}