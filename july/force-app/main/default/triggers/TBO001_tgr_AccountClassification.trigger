trigger TBO001_tgr_AccountClassification on TBO001_AccountClassification__c (before insert, after insert, before update, after update, after delete) {
    
    Set<Id> accountClassificationIdSet = new Set<Id>();
    Set<Id> accountSet = new Set<Id>();
    Set<Id> ownerIdsSet = new Set<Id>();
    
    if (Trigger.isInsert || Trigger.isUpdate) {
        for (TBO001_AccountClassification__c classification : Trigger.new) {
            if (!accountSet.contains(classification.TBO001_rb_Account__c)) {
                accountSet.add(classification.TBO001_rb_Account__c);
            }
            if (!ownerIdsSet.contains(classification.OwnerId)) {
                ownerIdsSet.add(classification.OwnerId);
            }
            
            accountClassificationIdSet.add(classification.Id);
        }
    }
    else if (Trigger.isDelete) {
        for (TBO001_AccountClassification__c classification : Trigger.old) {
            if (!accountSet.contains(classification.TBO001_rb_Account__c)) {
                accountSet.add(classification.TBO001_rb_Account__c);
            }
            if (!ownerIdsSet.contains(classification.OwnerId)) {
                ownerIdsSet.add(classification.OwnerId);
            }
            
            accountClassificationIdSet.add(classification.Id);
        }
    }
    
    System.debug('Is Insert: ' + Trigger.isInsert);
    System.debug('Is Update: ' + Trigger.isUpdate);
    System.debug('Is Delete: ' + Trigger.isDelete);
    System.debug('Account Set: ' + accountSet);
    
    Map<Id, Account> accountMap = new Map<Id, Account>();
    Set<String> accountExtRefIdSet = new Set<String>();
    
    /**
    List<Account> accountList;
    
    try {
        accountList = [SELECT Id, ACC_tx_Account_Tier__c, ACC_tx_EXT_REF_ID__c, ACC_tx_Customer_Since__c, CreatedDate, ACC_un_Capex_Exposure__c, ACC_un_Technology_Exposure__c, ACC_un_Fleet_Exposure__c, ACC_un_Real_Estate_Exposure__c, ACC_tx_Account_Status__c FROM Account WHERE Id IN :accountSet];
    }
    catch (Exception exAccList) {
        System.debug('Error: ' + exAccList.getMessage() + ' (Line: ' + exAccList.getLineNumber() + ').');
    }
    
    if (accountList != null) {
        for(Account account : accountList) {
            if ((accountMap.size() == 0) || (accountMap.get(account.Id) == null)) {
                accountMap.put(account.Id, account);
            }
            
            if (String.isNotEmpty(account.ACC_tx_EXT_REF_ID__c)) {
                accountExtRefIdSet.add(account.ACC_tx_EXT_REF_ID__c);
            }
        }
    }
    */
    
    for(Account account : [SELECT Id, ACC_tx_Account_Tier__c, ACC_tx_EXT_REF_ID__c, ACC_tx_Customer_Since__c, CreatedDate, ACC_un_Capex_Exposure__c, ACC_un_Technology_Exposure__c, ACC_un_Fleet_Exposure__c, ACC_un_Real_Estate_Exposure__c, ACC_tx_Account_Status__c FROM Account WHERE Id IN :accountSet]) {
        if ((accountMap.size() == 0) || (accountMap.get(account.Id) == null)) {
            accountMap.put(account.Id, account);
        }
        
        if (String.isNotEmpty(account.ACC_tx_EXT_REF_ID__c)) {
            accountExtRefIdSet.add(account.ACC_tx_EXT_REF_ID__c);
        }
    }
    
    Map<String, TBO023_Customer_Since__c> customerSinceMap = new Map<String, TBO023_Customer_Since__c>();
    
    /**
    List<TBO023_Customer_Since__c> customerSinceList;
    
    try {
        customerSinceList = [SELECT TBO023_tx_Ext_ref_Account_id__c, TBO023_ls_Line_Of_Business__c, TBO023_tx_Customer_since__c FROM TBO023_Customer_Since__c WHERE TBO023_tx_Ext_ref_Account_id__c IN :accountExtRefIdSet ORDER BY TBO023_tx_Ext_ref_Account_id__c, TBO023_ls_Line_Of_Business__c];
    }
    catch (Exception exCustomerSinceList) {
        System.debug('Error: ' + exCustomerSinceList.getMessage() + ' (Line: ' + exCustomerSinceList.getLineNumber() + ').');
    }
    
    if (customerSinceList != null) {
        for(TBO023_Customer_Since__c customerSince : customerSinceList) {
            String key = customerSince.TBO023_tx_Ext_ref_Account_id__c + ':' + customerSince.TBO023_ls_Line_Of_Business__c;
            
            customerSinceMap.put(key, customerSince);
        }
    }
    */

    for(TBO023_Customer_Since__c customerSince : [SELECT TBO023_tx_Ext_ref_Account_id__c, TBO023_ls_Line_Of_Business__c, TBO023_tx_Customer_since__c FROM TBO023_Customer_Since__c WHERE TBO023_tx_Ext_ref_Account_id__c IN :accountExtRefIdSet ORDER BY TBO023_tx_Ext_ref_Account_id__c, TBO023_ls_Line_Of_Business__c]) {
        String key = customerSince.TBO023_tx_Ext_ref_Account_id__c + ':' + customerSince.TBO023_ls_Line_Of_Business__c;
        
        customerSinceMap.put(key, customerSince);
    }    
    
    Map<String, Integer> fundedTakedownsMap = new Map<String, Integer>();
    
    /**
    
    List<AggregateResult> fundedTakedownList;
    
    try {
        fundedTakedownList = [SELECT TBO020_fh_Funding_Date__c FundingDate, TBO020_pd_Opportunity__r.AccountId AccountId, TBO020_pd_Opportunity__r.OPP_ls_Line_of_Business__c LineBusiness FROM TBO020_Takedowns__c WHERE TBO020_pd_Opportunity__r.AccountId IN :accountSet AND TBO020_tx_Status__c = 'Funded' AND TBO020_fh_Funding_Date__c <> null AND TBO020_pd_Opportunity__r.OPP_ls_Line_of_Business__c <> null GROUP BY TBO020_fh_Funding_Date__c, TBO020_pd_Opportunity__r.AccountId, TBO020_pd_Opportunity__r.OPP_ls_Line_of_Business__c ORDER BY TBO020_fh_Funding_Date__c, TBO020_pd_Opportunity__r.AccountId, TBO020_pd_Opportunity__r.OPP_ls_Line_of_Business__c];
    }
    catch (Exception exFundedTakedownList) {
        System.debug('Error: ' + exFundedTakedownList.getMessage() + ' (Line: ' + exFundedTakedownList.getLineNumber() + ').');
    }
    
    if (fundedTakedownList != null) {
        for (AggregateResult arTakedowns: fundedTakedownList) {
            Date fundingDate = ((Date) arTakedowns.get('FundingDate'));
            
            Integer currentYear = fundingDate.year();
            
            Id accountId = ((Id) arTakedowns.get('AccountId'));
            String lineOfBusiness = ((String) arTakedowns.get('LineBusiness'));
            
            String key = accountId + ':' + lineOfBusiness;
            
            if (fundedTakedownsMap.size() == 0) {
                fundedTakedownsMap.put(key, currentYear);
            }
            else if (fundedTakedownsMap.get(key) != null) {
                Integer storedYear = fundedTakedownsMap.get(key);
                
                if (currentYear < storedYear) {
                    fundedTakedownsMap.put(key, currentYear);
                }
            }
            else {
                fundedTakedownsMap.put(key, currentYear);
            }
        }
    }
    */    

    for (AggregateResult arTakedowns: [SELECT TBO020_fh_Funding_Date__c FundingDate, TBO020_pd_Opportunity__r.AccountId AccountId, TBO020_pd_Opportunity__r.OPP_ls_Line_of_Business__c LineBusiness FROM TBO020_Takedowns__c WHERE TBO020_pd_Opportunity__r.AccountId IN :accountSet AND TBO020_tx_Status__c = 'Funded' AND TBO020_fh_Funding_Date__c <> null AND TBO020_pd_Opportunity__r.OPP_ls_Line_of_Business__c <> null GROUP BY TBO020_fh_Funding_Date__c, TBO020_pd_Opportunity__r.AccountId, TBO020_pd_Opportunity__r.OPP_ls_Line_of_Business__c ORDER BY TBO020_fh_Funding_Date__c, TBO020_pd_Opportunity__r.AccountId, TBO020_pd_Opportunity__r.OPP_ls_Line_of_Business__c]) {
        Date fundingDate = ((Date) arTakedowns.get('FundingDate'));
        
        Integer currentYear = fundingDate.year();
        
        Id accountId = ((Id) arTakedowns.get('AccountId'));
        String lineOfBusiness = ((String) arTakedowns.get('LineBusiness'));
        
        String key = accountId + ':' + lineOfBusiness;
        
        if (fundedTakedownsMap.size() == 0) {
            fundedTakedownsMap.put(key, currentYear);
        }
        else if (fundedTakedownsMap.get(key) != null) {
            Integer storedYear = fundedTakedownsMap.get(key);
            
            if (currentYear < storedYear) {
                fundedTakedownsMap.put(key, currentYear);
            }
        }
        else {
            fundedTakedownsMap.put(key, currentYear);
        }
    }
    
    Map<String, AccountTeamMember> accountTeamMemberMap = new Map<String, AccountTeamMember>();
    
    /**
    List<AccountTeamMember> accountMemberList;
    
    try {
        accountMemberList = [SELECT Id, AccountId, UserId FROM AccountTeamMember WHERE AccountId IN :accountSet ORDER BY AccountId, UserId];
    }
    catch (Exception exAccountMemberList) {
        System.debug('Error: ' + exAccountMemberList.getMessage() + ' (Line: ' + exAccountMemberList.getLineNumber() + ').');
    }
    
    if (accountMemberList != null) {
        for (AccountTeamMember member : accountMemberList) {
            String key = member.AccountId + ':' + member.UserId;
            
            accountTeamMemberMap.put(key, member);
        }
    }
    */
    
    for (AccountTeamMember member : [SELECT Id, AccountId, UserId FROM AccountTeamMember WHERE AccountId IN :accountSet ORDER BY AccountId, UserId]) {
        String key = member.AccountId + ':' + member.UserId;
        
        accountTeamMemberMap.put(key, member);
    }
    
    Map<Id, TBO001_AccountClassification__c> accountTierMap = new Map<Id, TBO001_AccountClassification__c>();
    
    /**
    List<TBO001_AccountClassification__c> accountTierList;
    
    try {
        accountTierList = [SELECT TBO001_rb_Account__c, TBO001_ls_Tier__c, TBO001_ls_CompanyRank__c FROM TBO001_AccountClassification__c WHERE TBO001_rb_Account__c IN :accountSet ORDER BY TBO001_fm_Order_tier__c];
    }
    catch (Exception exAccountTierList) {
        System.debug('Error: ' + exAccountTierList.getMessage() + ' (Line: ' + exAccountTierList.getLineNumber() + ').');
    }
    
    if (accountTierList != null) {
        for (TBO001_AccountClassification__c accountClassification : accountTierList) {
            if ((accountTierMap.size() == 0) || (accountTierMap.get(accountClassification.TBO001_rb_Account__c) == null)) {
                accountTierMap.put(accountClassification.TBO001_rb_Account__c, accountClassification);
            }
        }
    }
    */   
    
    for (TBO001_AccountClassification__c accountClassification : [SELECT TBO001_rb_Account__c, TBO001_ls_Tier__c, TBO001_ls_CompanyRank__c FROM TBO001_AccountClassification__c WHERE TBO001_rb_Account__c IN :accountSet ORDER BY TBO001_fm_Order_tier__c]) {
        if ((accountTierMap.size() == 0) || (accountTierMap.get(accountClassification.TBO001_rb_Account__c) == null)) {
            accountTierMap.put(accountClassification.TBO001_rb_Account__c, accountClassification);
        }
    }

    //System.debug('Account Tier Map: ' + accountTierMap);
    
    Map<Id, User> userMap = new Map<Id, User>();
    
    /**
    List<User> userList;
    
    try {
        userList = [SELECT Id, USU_ls_Region__c, USU_ls_Line_of_Business__c FROM User WHERE Id IN :ownerIdsSet ORDER BY Id];
    }
    catch (Exception exUserList) {
        System.debug('Error: ' + exUserList.getMessage() + ' (Line: ' + exUserList.getLineNumber() + ').');
    }
    
    if (userList != null) {
        for (User usr : userList) {
            if ((userMap.size() == 0) || (userMap.get(usr.Id) == null)) {
                userMap.put(usr.Id, usr);
            }
        }
    }
    */    

    for (User usr : [SELECT Id, USU_ls_Region__c, USU_ls_Line_of_Business__c FROM User WHERE Id IN :ownerIdsSet ORDER BY Id]) {
        if ((userMap.size() == 0) || (userMap.get(usr.Id) == null)) {
            userMap.put(usr.Id, usr);
        }
    }
    
    Map<Id, TBO001_AccountClassification__c> accountTotalTiersMap = new Map<Id, TBO001_AccountClassification__c>();
    Map<String, TBO001_AccountClassification__c> accountClassTiersMap = new Map<String, TBO001_AccountClassification__c>();
    Map<String, TBO001_AccountClassification__c> accountClassOwnerMap = new Map<String, TBO001_AccountClassification__c>();
    Map<Id, String> accountLowestCustomerSince = new Map<Id, String>();
    
    /**
    List<TBO001_AccountClassification__c> accountClassificationList;
    
    try {
        accountClassificationList = [SELECT Id, TBO001_rb_Account__c, TBO001_ls_Tier__c, OwnerId, TBO001_tx_Customer_Since__c FROM TBO001_AccountClassification__c WHERE TBO001_rb_Account__c IN :accountSet];
    }
    catch (Exception exAccountClassList) {
        System.debug('Error: ' + exAccountClassList.getMessage() + ' (Line: ' + exAccountClassList.getLineNumber() + ').');
    }
    
    if (accountClassificationList != null) {
        for (TBO001_AccountClassification__c accClassification : accountClassificationList) {
            if (String.isNotEmpty(accClassification.TBO001_ls_Tier__c)) {
                if((accountTotalTiersMap.size() == 0) || (accountTotalTiersMap.get(accClassification.TBO001_rb_Account__c) == null)) {
                    accountTotalTiersMap.put(accClassification.TBO001_rb_Account__c, accClassification);
                }
                
                String tierKey = accClassification.TBO001_rb_Account__c + ':' + accClassification.TBO001_ls_Tier__c;
                
                if((accountClassTiersMap.size() == 0) || (accountClassTiersMap.get(tierKey) == null)) {
                    accountClassTiersMap.put(tierKey, accClassification);
                }
            }
            
            if (String.isNotEmpty(accClassification.OwnerId)) {
                String ownerKey = accClassification.TBO001_rb_Account__c + ':' + accClassification.OwnerId;
                
                if ((accountClassOwnerMap.size() == 0) || (accountClassOwnerMap.get(ownerKey) == null)) {
                    accountClassOwnerMap.put(ownerKey, accClassification);
                }
            }
            
            String lowestCustomerSinceStr = accountLowestCustomerSince.get(accClassification.TBO001_rb_Account__c);
            
            if ((accountLowestCustomerSince.size() == 0) || (lowestCustomerSinceStr == null)) {
                if (String.isNotEmpty(accClassification.TBO001_tx_Customer_Since__c)) {
                    accountLowestCustomerSince.put(accClassification.TBO001_rb_Account__c, accClassification.TBO001_tx_Customer_Since__c);
                }
            }
            else if (lowestCustomerSinceStr != null) {
                Integer lowestCustomerSinceInt = 0;
                
                if (String.isNotEmpty(lowestCustomerSinceStr)) {
                    lowestCustomerSinceInt = Integer.valueOf(lowestCustomerSinceStr);
                }
                
                Integer currentCustomerSinceInt = 0;
                    
                if (String.isNotEmpty(accClassification.TBO001_tx_Customer_Since__c)) {
                    currentCustomerSinceInt = Integer.valueOf(accClassification.TBO001_tx_Customer_Since__c);
                }
                
                if ((lowestCustomerSinceInt != 0) && (currentCustomerSinceInt != 0)) {
                    if (currentCustomerSinceInt < lowestCustomerSinceInt) {
                        accountLowestCustomerSince.put(accClassification.TBO001_rb_Account__c, accClassification.TBO001_tx_Customer_Since__c);
                    }
                }
            }
        }
    }
    */
    
    for (TBO001_AccountClassification__c accClassification : [SELECT Id, TBO001_rb_Account__c, TBO001_ls_Tier__c, OwnerId, TBO001_tx_Customer_Since__c FROM TBO001_AccountClassification__c WHERE TBO001_rb_Account__c IN :accountSet]) {
        System.debug('Account Class: ' + accClassification);
        if (String.isNotEmpty(accClassification.TBO001_ls_Tier__c)) {
            if((accountTotalTiersMap.size() == 0) || (accountTotalTiersMap.get(accClassification.TBO001_rb_Account__c) == null)) {
                accountTotalTiersMap.put(accClassification.TBO001_rb_Account__c, accClassification);
            }
            
            String tierKey = accClassification.TBO001_rb_Account__c + ':' + accClassification.TBO001_ls_Tier__c;
            
            if((accountClassTiersMap.size() == 0) || (accountClassTiersMap.get(tierKey) == null)) {
                accountClassTiersMap.put(tierKey, accClassification);
            }
        }
        
        if (String.isNotEmpty(accClassification.OwnerId)) {
            String ownerKey = accClassification.TBO001_rb_Account__c + ':' + accClassification.OwnerId;
            
            if ((accountClassOwnerMap.size() == 0) || (accountClassOwnerMap.get(ownerKey) == null)) {
                accountClassOwnerMap.put(ownerKey, accClassification);
            }
        }
        
        String lowestCustomerSinceStr = accountLowestCustomerSince.get(accClassification.TBO001_rb_Account__c);
        
        System.debug('Lowest Customer Since: ' + lowestCustomerSinceStr);
        
        if ((accountLowestCustomerSince.size() == 0) || (lowestCustomerSinceStr == null)) {
            if (String.isNotEmpty(accClassification.TBO001_tx_Customer_Since__c)) {
                accountLowestCustomerSince.put(accClassification.TBO001_rb_Account__c, accClassification.TBO001_tx_Customer_Since__c);
            }
        }
        else if (lowestCustomerSinceStr != null) {
            Integer lowestCustomerSinceInt = 0;
            
            if (String.isNotEmpty(lowestCustomerSinceStr)) {
                lowestCustomerSinceInt = Integer.valueOf(lowestCustomerSinceStr);
            }
        
       		System.debug('Lowest Customer Since Int: ' + lowestCustomerSinceInt);
            
            Integer currentCustomerSinceInt = 0;
            
            if (String.isNotEmpty(accClassification.TBO001_tx_Customer_Since__c)) {
                currentCustomerSinceInt = Integer.valueOf(accClassification.TBO001_tx_Customer_Since__c);
            }
            
            if ((lowestCustomerSinceInt != 0) && (currentCustomerSinceInt != 0)) {
                if (currentCustomerSinceInt < lowestCustomerSinceInt) {
                    accountLowestCustomerSince.put(accClassification.TBO001_rb_Account__c, accClassification.TBO001_tx_Customer_Since__c);
                }
            }
        }
    }

    System.debug('Account Total Tiers Map: ' + accountTotalTiersMap);
    
    Map<Id, Account> accUpdtMap = new Map<Id, Account>();
    Map<String, AccountTeamMember> accTeamInsMap = new Map<String, AccountTeamMember>();
    Map<String, AccountTeamMember> accTeamDelMap = new Map<String, AccountTeamMember>();
    
    if (Trigger.isInsert || Trigger.isUpdate) {
        if (accountMap.size() > 0) {
            for (TBO001_AccountClassification__c classification : Trigger.new) {
                if (String.isNotEmpty(classification.TBO001_rb_Account__c)) {
                    Account acc = accountMap.get(classification.TBO001_rb_Account__c);
    
                    Boolean isAccUpdt = false;
                    
                    if (acc != null) {
                        if (Trigger.isInsert) {
                            if (Trigger.isBefore) {
                                if (String.isNotEmpty(classification.TBO001_ls_Tier__c)) {
                                    if (!classification.TBO001_ls_Tier__c.equals('Tier Three')) {
                                        classification.TBO001_ls_CompanyRank__c = null;
                                    }   
                                }
                                
                                if (String.isNotEmpty(classification.TBO001_ls_Line_of_Business__c)) {  
                                    if (acc != null) {
                                        if (String.isNotEmpty(acc.ACC_tx_EXT_REF_ID__c)) {
                                            
                                            String customerSince;
                                            
                                            if (customerSinceMap.size() > 0) {
                                                try {
                                                    String customerSinceInsKey = acc.ACC_tx_EXT_REF_ID__c + ':' + classification.TBO001_ls_Line_of_Business__c;
                                                    
                                                    TBO023_Customer_Since__c customerSinceRef = customerSinceMap.get(customerSinceInsKey);
                                                    
                                                    if (customerSinceRef != null) {
                                                        customerSince = customerSinceRef.TBO023_tx_Customer_since__c;
                                                    }
                                                }
                                                catch (Exception exCustomerSince) {
                                                    System.debug('Error: ' + exCustomerSince.getMessage() + ' (Line: ' + exCustomerSince.getLineNumber() + ').');
                                                }
                                            }
                                            
                                            if (String.isEmpty(customerSince)) {
                                                String oppInsKey = acc.Id + ':' + classification.TBO001_ls_Line_of_Business__c;
                                                
                                                if (fundedTakedownsMap.size() > 0) {
                                                    Integer year = fundedTakedownsMap.get(oppInsKey); 
                                                    
                                                    if (year != null) {
                                                        customerSince = String.valueOf(year);
                                                    }
                                                }
                                            }
                                            
                                            if (String.isNotEmpty(customerSince)) {
                                                classification.TBO001_tx_Customer_Since__c = customerSince;
                                                
                                                if (String.isEmpty(acc.ACC_tx_Customer_Since__c)) {
                                                    acc.ACC_tx_Customer_Since__c = customerSince;
                                                    
                                                    isAccUpdt = true;
                                                }
                                                else {
                                                    Integer customerSinceAccountYear = Integer.valueOf(acc.ACC_tx_Customer_Since__c);
                                                    Integer customerSinceYear = Integer.valueOf(customerSince);
                                                    
                                                    if (customerSinceYear < customerSinceAccountYear) {
                                                        acc.ACC_tx_Customer_Since__c = customerSince;
                                                        
                                                        isAccUpdt = true;
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                                
                                if (isAccUpdt) {
                                    if (accUpdtMap != null) {
                                        Account tempAccount = accUpdtMap.get(acc.Id);
                                        
                                        if (tempAccount == null) {
                                            accUpdtMap.put(acc.Id, acc);
                                        }
                                    }
                                    else {
                                        accUpdtMap = new Map<Id, Account>();
                                        accUpdtMap.put(acc.Id, acc);
                                    }
                                }
                                
                                if (String.isNotEmpty(classification.OwnerId)) {
                                    if (acc != null) {
                                        User usr = userMap.get(classification.OwnerId);
                                        
                                        classification.TBO001_ls_Region__c = usr.USU_ls_Region__c;
                                        classification.TBO001_ls_Line_of_Business__c = usr.USU_ls_Line_of_Business__c;
                                        
                                        if (accountTeamMemberMap.size() > 0) {
                                            AccountTeamMember accountTeamMember;
                                            
                                            try {
                                                String memberInskey = acc.Id + ':' + classification.OwnerId;
                                                
                                                accountTeamMember = accountTeamMemberMap.get(memberInskey);
                                            }
                                            catch (Exception exExtATM) {
                                                System.debug('Error: ' + exExtATM.getMessage() + ' (Line: ' + exExtATM.getLineNumber() + ').');
                                            }
                                            
                                            if (accountTeamMember == null) {
                                                String keyAccTemMember = acc.Id + ':' + classification.OwnerId;
                                                
                                                if (accTeamInsMap.get(keyAccTemMember) == null) {
                                                    AccountTeamMember newAccountTeamMember = new AccountTeamMember();
                                                    
                                                    newAccountTeamMember.AccountId = acc.Id;
                                                    newAccountTeamMember.UserId = classification.OwnerId;
                                                    newAccountTeamMember.TeamMemberRole = 'Sales Rep';
                                                    newAccountTeamMember.AccountAccessLevel = 'Edit';
                                                    newAccountTeamMember.OpportunityAccessLevel = 'Edit';
                                                    newAccountTeamMember.CaseAccessLevel = 'Edit';
                                                    
                                                    accTeamInsMap.put(keyAccTemMember, newAccountTeamMember);
                                                }
                                            }
                                        }
                                        else {
                                            String keyAccTemMember = acc.Id + ':' + classification.OwnerId;
                                            
                                            if (accTeamInsMap.get(keyAccTemMember) == null) {
                                                AccountTeamMember newAccountTeamMember = new AccountTeamMember();
                                                
                                                newAccountTeamMember.AccountId = acc.Id;
                                                newAccountTeamMember.UserId = classification.OwnerId;
                                                newAccountTeamMember.TeamMemberRole = 'Sales Rep';
                                                newAccountTeamMember.AccountAccessLevel = 'Edit';
                                                newAccountTeamMember.OpportunityAccessLevel = 'Edit';
                                                newAccountTeamMember.CaseAccessLevel = 'Edit';
                                                
                                                accTeamInsMap.put(keyAccTemMember, newAccountTeamMember);
                                            }
                                        }
                                    }
                                }
                            }
                            else if (Trigger.isAfter) {
                                
                                String accountTier;
                                
                                Boolean isCompanyRankUpdt = false;
                                
                                if (accountTierMap.size() > 0) {
                                    
                                    if (String.isNotEmpty(classification.TBO001_ls_Tier__c)) {                            
                                        if (acc != null) {
                                            try {
                                                TBO001_AccountClassification__c acTier = accountTierMap.get(acc.Id);
                                                
                                                if (acTier != null) {
                                                    accountTier = acTier.TBO001_ls_Tier__c;
                                                    
                                                    if (accountTier != null) {
                                                        acc.ACC_tx_Account_Tier__c = accountTier;
                                                        
                                                        if (!accountTier.equals('Tier Three')) {
                                                            acc.ACC_tx_Company_Rank__c = null;
                                                        }
                                                        
                                                        isAccUpdt = true;
                                                    }
                                                }
                                            }
                                            catch (Exception exTierAccClass) {
                                                System.debug('Error: ' + exTierAccClass.getMessage() + ' (Line: ' + exTierAccClass.getLineNumber() + ').');
                                            }
                                        }
                                    }
                                    
                                    if (String.isNotEmpty(classification.TBO001_ls_CompanyRank__c)) {   
                                        if (acc != null) {
                                            if (String.isNotEmpty(accountTier)) {
                                                if (accountTier.equals('Tier Three')) {
                                                    String companyRank;
                                                    try {
                                                        TBO001_AccountClassification__c acTier = accountTierMap.get(acc.Id);
                                                        
                                                        if (acTier != null) {
                                                            companyRank = acTier.TBO001_ls_CompanyRank__c;
                                                            
                                                            if (companyRank != null) {
                                                                acc.ACC_tx_Company_Rank__c = companyRank;
                                                                
                                                                isCompanyRankUpdt = true;
                                                            }
                                                        }
                                                    }
                                                    catch (Exception exCompanyRankAccClass) {
                                                        System.debug('Error: ' + exCompanyRankAccClass.getMessage() + ' (Line: ' + exCompanyRankAccClass.getLineNumber() + ').');
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                                
                                if (isAccUpdt || isCompanyRankUpdt) {
                                    if (accUpdtMap != null) {
                                        Account tempAccount = accUpdtMap.get(acc.Id);
                                        
                                        if (tempAccount == null) {
                                            accUpdtMap.put(acc.Id, acc);
                                        }
                                    }
                                    else {
                                        accUpdtMap = new Map<Id, Account>();
                                        accUpdtMap.put(acc.Id, acc);
                                    }
                                }
                            }
                        }
                        else if (Trigger.isUpdate) {
                            if (Trigger.isAfter) {
                                
                                String accountTier;
                                
                                TBO001_AccountClassification__c acTier = accountTierMap.get(acc.Id);
                                        
                                if (acTier != null) {
                                    accountTier = acTier.TBO001_ls_Tier__c;
                                }
                                
                                if (classification.TBO001_ls_Tier__c != Trigger.oldMap.get(classification.Id).TBO001_ls_Tier__c) {
                                    
                                    try {                                            
                                        if (accountTier != null) {
                                            acc.ACC_tx_Account_Tier__c = accountTier;
                                            
                                            if (!accountTier.equals('Tier Three')) {
                                                acc.ACC_tx_Company_Rank__c = null;
                                            }
                                            
                                            isAccUpdt = true;
                                        }
                                    }
                                    catch (Exception exDelAccClass) {
                                        System.debug('Error: ' + exDelAccClass.getMessage() + ' (Line: ' + exDelAccClass.getLineNumber() + ').');
                                    }
                                }
                                
                                if (String.isNotEmpty(classification.TBO001_ls_CompanyRank__c)) {
                                    if (!classification.TBO001_ls_CompanyRank__c.equals(Trigger.oldMap.get(classification.Id).TBO001_ls_CompanyRank__c)) {                            
                                        if (acc != null) {
                                            if (String.isNotEmpty(accountTier)) {
                                                if (accountTier.equals('Tier Three')) {
                                                    String companyRank;
                                                    
                                                    try {                                                        
                                                        if (acTier != null) {
                                                            companyRank = acTier.TBO001_ls_CompanyRank__c;
                                                            
                                                            if (companyRank != null) {
                                                                acc.ACC_tx_Company_Rank__c = companyRank;
                                                                
                                                                isAccUpdt = true;
                                                            }
                                                        }
                                                    }
                                                    catch (Exception exCompanyRankAccClass) {
                                                        System.debug('Error: ' + exCompanyRankAccClass.getMessage() + ' (Line: ' + exCompanyRankAccClass.getLineNumber() + ').');
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                                else {
                                    if (acc != null) {
                                        acc.ACC_tx_Company_Rank__c = null;
                                        
                                        isAccUpdt = true;
                                    }
                                }
                                
                                if (isAccUpdt) {
                                    if (accUpdtMap != null) {
                                        Account tempAccount = accUpdtMap.get(acc.Id);
                                        
                                        if (tempAccount == null) {
                                            accUpdtMap.put(acc.Id, acc);
                                        }
                                    }
                                    else {
                                        accUpdtMap = new Map<Id, Account>();
                                        accUpdtMap.put(acc.Id, acc);
                                    }
                                }
                            }
                            else if(Trigger.isBefore) {
                                
                                if (String.isNotEmpty(classification.TBO001_ls_Tier__c)) {
                                    if (!classification.TBO001_ls_Tier__c.equals('Tier Three')) {
                                        classification.TBO001_ls_CompanyRank__c = null;
                                    }   
                                }
                                
                                if (classification.TBO001_ls_Line_of_Business__c != Trigger.oldMap.get(classification.Id).TBO001_ls_Line_of_Business__c) {
                                    if (String.isNotEmpty(classification.TBO001_ls_Line_of_Business__c)) {  
                                        if (acc != null) {
                                            if (String.isNotEmpty(acc.ACC_tx_EXT_REF_ID__c)) {
                                                
                                                String customerSince;
                                                
                                                if (customerSinceMap.size() > 0) {
                                                    try {
                                                        String customerSinceUpdKey = acc.ACC_tx_EXT_REF_ID__c + ':' + classification.TBO001_ls_Line_of_Business__c;
                                                        
                                                        TBO023_Customer_Since__c customerSinceRef = customerSinceMap.get(customerSinceUpdKey);
                                                        
                                                        if (customerSinceRef != null) {
                                                            customerSince = customerSinceRef.TBO023_tx_Customer_since__c;
                                                        }
                                                    }
                                                    catch (Exception exCustomerSince) {
                                                        System.debug('Error: ' + exCustomerSince.getMessage() + ' (Line: ' + exCustomerSince.getLineNumber() + ').');
                                                    }
                                                }
                                                
                                                if (String.isEmpty(customerSince)) {
                                                    if (fundedTakedownsMap.size() > 0) {
                                                        String oppUpdKey = acc.Id + ':' + classification.TBO001_ls_Line_of_Business__c;
                                                        
                                                        Integer year = fundedTakedownsMap.get(oppUpdKey); 
                                                        
                                                        if (year != null) {
                                                            customerSince = String.valueOf(year);
                                                        }
                                                    }
                                                }
                                                
                                                if (String.isNotEmpty(customerSince)) {
                                                    classification.TBO001_tx_Customer_Since__c = customerSince;
                                                    
                                                    if (String.isEmpty(acc.ACC_tx_Customer_Since__c)) {
                                                        acc.ACC_tx_Customer_Since__c = customerSince;
                                                        
                                                        isAccUpdt = true;
                                                    }
                                                    else {
                                                        if (accountLowestCustomerSince.size() > 0) {
                                                            Integer customerSinceAccountYear = Integer.valueOf(acc.ACC_tx_Customer_Since__c);
                                                            
                                                            String lowestCustomerSince;
                                                            
                                                            try {    
                                                                lowestCustomerSince = accountLowestCustomerSince.get(acc.Id);
                                                            }
                                                            catch (Exception exLowestCustomerSince) {
                                                                System.debug('Error: ' + exLowestCustomerSince.getMessage() + ' (Line: ' + exLowestCustomerSince.getLineNumber() + ').');
                                                            }
                                                            
                                                            Integer lowestCustomerSinceYear = 0;
                                                            
                                                            if (lowestCustomerSince != null) {
                                                                lowestCustomerSinceYear = Integer.valueOf(lowestCustomerSince);
                                                            }
                                                            
                                                            Integer customerSinceYear = Integer.valueOf(customerSince);
                                                            
                                                            if ((lowestCustomerSinceYear > 0) && (lowestCustomerSinceYear < customerSinceYear)) {
                                                                customerSince = lowestCustomerSince;
                                                            }
                                                            
                                                            acc.ACC_tx_Customer_Since__c = customerSince;
                                                            
                                                            isAccUpdt = true;
                                                        }
                                                    }
                                                }
                                                else {
                                                    if (accountLowestCustomerSince.size() > 0) {
                                                        classification.TBO001_tx_Customer_Since__c = null;
                                                        
                                                        String lowestCustomerSince;
                                                        
                                                        try {                                            
                                                            lowestCustomerSince = accountLowestCustomerSince.get(acc.Id);
                                                        }
                                                        catch (Exception exLowestCustomerSince) {
                                                            System.debug('Error: ' + exLowestCustomerSince.getMessage() + ' (Line: ' + exLowestCustomerSince.getLineNumber() + ').');
                                                            
                                                            acc.ACC_tx_Customer_Since__c = null;
                                                            
                                                            isAccUpdt = true;
                                                        }
                                                        
                                                        Integer lowestCustomerSinceYear = 0;
                                                        
                                                        if (lowestCustomerSince != null) {
                                                            lowestCustomerSinceYear = Integer.valueOf(lowestCustomerSince);
                                                        }
                                                        
                                                        acc.ACC_tx_Customer_Since__c = lowestCustomerSince;
                                                        
                                                        isAccUpdt = true;
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                                
                                if (isAccUpdt) {
                                    if (accUpdtMap != null) {
                                        Account tempAccount = accUpdtMap.get(acc.Id);
                                        
                                        if (tempAccount == null) {
                                            accUpdtMap.put(acc.Id, acc);
                                        }
                                    }
                                    else {
                                        accUpdtMap = new Map<Id, Account>();
                                        accUpdtMap.put(acc.Id, acc);
                                    }
                                }
                                
                                if (classification.OwnerId != Trigger.oldMap.get(classification.Id).OwnerId) {
                                    if (String.isNotEmpty(classification.OwnerId)) {
                                        if (acc != null) {
                                            User usr = userMap.get(classification.OwnerId);
                                            
                                            classification.TBO001_ls_Region__c = usr.USU_ls_Region__c;
                                            
                                            if (classification.TBO001_ls_Line_of_Business__c == null) {
                                                classification.TBO001_ls_Line_of_Business__c = usr.USU_ls_Line_of_Business__c;
                                            }
                                                
                                            if (accountTeamMemberMap.size() > 0) {
                                                Id previousOwnerId = Trigger.oldMap.get(classification.Id).OwnerId;
                                                
                                                AccountTeamMember previousAccountTeamMember;
                                                
                                                try {
                                                    String previousMemberUpdkey = acc.Id + ':' + previousOwnerId;
                                                    
                                                    previousAccountTeamMember = accountTeamMemberMap.get(previousMemberUpdkey);
                                                }
                                                catch (Exception exExtPrevATM) {
                                                    System.debug('Error: ' + exExtPrevATM.getMessage() + ' (Line: ' + exExtPrevATM.getLineNumber() + ').');
                                                }
                                                
                                                AccountTeamMember currentAccountTeamMember;
                                                
                                                try {
                                                    String currentMemberUpdkey = acc.Id + ':' + classification.OwnerId;
                                                    
                                                    currentAccountTeamMember = accountTeamMemberMap.get(currentMemberUpdkey);
                                                }
                                                catch (Exception exExtCurrATM) {
                                                    System.debug('Error: ' + exExtCurrATM.getMessage() + ' (Line: ' + exExtCurrATM.getLineNumber() + ').');
                                                }
                                                
                                                if (((previousAccountTeamMember == null) && (currentAccountTeamMember == null))) {
                                                    String keyAccTemMember = acc.Id + ':' + classification.OwnerId;
                                                    
                                                    if (accTeamInsMap.get(keyAccTemMember) == null) {
                                                        AccountTeamMember newAccountTeamMember = new AccountTeamMember();
                                                        
                                                        newAccountTeamMember.AccountId = acc.Id;
                                                        newAccountTeamMember.UserId = classification.OwnerId;
                                                        newAccountTeamMember.TeamMemberRole = 'Sales Rep';
                                                        newAccountTeamMember.AccountAccessLevel = 'Edit';
                                                        newAccountTeamMember.OpportunityAccessLevel = 'Edit';
                                                        newAccountTeamMember.CaseAccessLevel = 'Edit';
                                                        
                                                        accTeamInsMap.put(keyAccTemMember, newAccountTeamMember);
                                                    }
                                                }
                                                else if ((previousAccountTeamMember != null) && (currentAccountTeamMember != null)) {
                                                    String keyAccClassOwnerKey = classification.TBO001_rb_Account__c + ':' + previousOwnerId;
                                                    
                                                    TBO001_AccountClassification__c accClassOwner = accountClassOwnerMap.get(keyAccClassOwnerKey);
                                                    
                                                    if (accClassOwner != null) {
                                                        String keyAccTemMember = previousAccountTeamMember.AccountId + ':' + previousAccountTeamMember.UserId;
                                                        
                                                        if (accTeamDelMap.get(keyAccTemMember) == null) {
                                                            accTeamDelMap.put(keyAccTemMember, previousAccountTeamMember);
                                                        }
                                                    }
                                                }
                                                else if (previousAccountTeamMember != null) {
                                                    
                                                    String keyAccTemMember = acc.Id + ':' + classification.OwnerId;
                                                    
                                                    if (accTeamInsMap.get(keyAccTemMember) == null) {
                                                        AccountTeamMember newAccountTeamMember = new AccountTeamMember();
                                                        
                                                        newAccountTeamMember.AccountId = acc.Id;
                                                        newAccountTeamMember.UserId = classification.OwnerId;
                                                        newAccountTeamMember.TeamMemberRole = 'Sales Rep';
                                                        newAccountTeamMember.AccountAccessLevel = 'Edit';
                                                        newAccountTeamMember.OpportunityAccessLevel = 'Edit';
                                                        newAccountTeamMember.CaseAccessLevel = 'Edit';
                                                        
                                                        accTeamInsMap.put(keyAccTemMember, newAccountTeamMember);
                                                    }
                                                    
                                                    keyAccTemMember = previousAccountTeamMember.AccountId + ':' + previousAccountTeamMember.UserId;
                                                    
                                                    String keyAccClassOwnerKey = classification.TBO001_rb_Account__c + ':' + previousOwnerId;
                                                    
                                                    TBO001_AccountClassification__c accClassOwner = accountClassOwnerMap.get(keyAccClassOwnerKey);
                                                    
                                                    if (accClassOwner != null) {
                                                        if (accTeamDelMap.get(keyAccTemMember) == null) {
                                                            accTeamDelMap.put(keyAccTemMember, previousAccountTeamMember);
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        
        //Database.executeBatch(new TBO001_bch_AccountClassificationInsUpd(Trigger.oldMap, accountClassificationIdSet, ((Trigger.isInsert)? 'Insert' : ((Trigger.isUpdate)? 'Update': 'Delete')), ((Trigger.isBefore)? 'Before' : ((Trigger.isAfter)? 'After': '')), accountMap, customerSinceMap, fundedTakedownsMap, userMap, accountTeamMemberMap, accountTierMap, accountLowestCustomerSince, accountClassOwnerMap));
          
        /** Desactivar temporalmente
         * Integer intervalSeconds = 30;
         * DateTime now  = DateTime.now();
         */
        /**DateTime nextRunTimeInsUpd = now.addSeconds(intervalSeconds);
        
        String cronStringInsUpd = '' + nextRunTimeInsUpd.second() + ' ' + nextRunTimeInsUpd.minute() + ' ' + 
            nextRunTimeInsUpd.hour() + ' ' + nextRunTimeInsUpd.day() + ' ' + 
            nextRunTimeInsUpd.month() + ' ? ' + nextRunTimeInsUpd.year(); 
        
        String schNameInsUpd = TBO001_sch_AccountClassificationInsUpd.class.getName() + '-' + now.format();
        
        Boolean existsInsUpd = false;
        
        for (CronJobDetail ct : [SELECT Name, JobType FROM CronJobDetail WHERE Name = :schNameInsUpd]) {
            existsInsUpd = true;
        }
        
        if (!existsInsUpd) {
        	System.schedule(schNameInsUpd, cronStringInsUpd, new TBO001_sch_AccountClassificationInsUpd(Trigger.oldMap, accountClassificationIdSet, ((Trigger.isInsert)? 'Insert' : ((Trigger.isUpdate)? 'Update': 'Delete')), ((Trigger.isBefore)? 'Before' : ((Trigger.isAfter)? 'After': '')), accountMap, customerSinceMap, fundedTakedownsMap, userMap, accountTeamMemberMap, accountTierMap, accountLowestCustomerSince, accountClassOwnerMap));
        }*/
          
        /** Desactivar temporalmente
         * if (Trigger.isBefore) {
		 */
            /**CustomerStatus_cls customerStatus = new CustomerStatus_cls(Trigger.new);
            customerStatus.setAccountClassificationStatusFromList();*/
            
            /** Desactivar temporalmente
             * DateTime nextRunTimeCustStatus = now.addSeconds(intervalSeconds);
        
            * String cronStringCustStatus = '' + nextRunTimeCustStatus.second() + ' ' + nextRunTimeCustStatus.minute() + ' ' + 
            *    nextRunTimeCustStatus.hour() + ' ' + nextRunTimeCustStatus.day() + ' ' + 
            *    nextRunTimeCustStatus.month() + ' ? ' + nextRunTimeCustStatus.year();
			*/
            
            //Database.executeBatch(new TBO001_bch_CustomerStatusCalculation(accountSet), 200);
             
            /** Desactivar temporalmente
             * String schNameCustStatus = TBO001_sch_CustomerStatusCalculation.class.getName() + '-' + now.format();
             * Boolean existsCustStatus = false;
             * */
            
            /** Desactivar temporalmente
            for (CronJobDetail ct : [SELECT Name, JobType FROM CronJobDetail WHERE Name = :schNameCustStatus]) {
                existsCustStatus = true;
            }
            
            if (!existsCustStatus) {
                System.schedule(schNameCustStatus, cronStringCustStatus, new TBO001_sch_CustomerStatusCalculation(accountSet));
            }*/
        /** Desactivar temporalmente
         * }
         * else if (Trigger.isAfter) {
         *   Map<String, String> statusRuleResultMap = new Map<String, String>();
            
         *   for (Account_Status_Rules_Matrix__c rule : [SELECT Status__c, Result__c FROM Account_Status_Rules_Matrix__c]) {            
         *       statusRuleResultMap.put(rule.Status__c, rule.Result__c);
         *   }
            
         *   System.debug('Mapa Matriz Reglas de Status: ' + statusRuleResultMap);
            
            /**
            CustomerStatus_cls customerStatus = new CustomerStatus_cls(Trigger.new);
            Map<Id, Account> customerStatusAccountMap = customerStatus.setAccountListStatus();
            
            if (customerStatusAccountMap != null) {
                if (accUpdtMap != null) {                    
                    for (Account aUpdt : accUpdtMap.values()) {
                        Account csAccount = customerStatusAccountMap.get(aUpdt.Id);
                        
                        if (csAccount != null) {
                            aUpdt.ACC_tx_Account_Status__c = csAccount.ACC_tx_Account_Status__c;
                        }
                    }
                }
                
                for (Account topParentAccount : customerStatusAccountMap.values()) {
                    Account csChildAccount = accUpdtMap.get(topParentAccount.Id);
                    
                    if (csChildAccount == null) {
                        accUpdtMap.put(topParentAccount.Id, topParentAccount);
                    }
                }
            }
			*/
            
            /** Desactivar temporalmente
             * DateTime nextRunTimeAccStatus = now.addSeconds(intervalSeconds);
        
            * String cronStringAccStatus = '' + nextRunTimeAccStatus.second() + ' ' + nextRunTimeAccStatus.minute() + ' ' + 
                nextRunTimeAccStatus.hour() + ' ' + nextRunTimeAccStatus.day() + ' ' + 
                nextRunTimeAccStatus.month() + ' ? ' + nextRunTimeAccStatus.year();
            
            //Database.executeBatch(new ACC_bch_AccountStatusCalculation(statusRuleResultMap), 200);
             
            * String schNameAccStatus = ACC_sch_AccountStatusCalculation.class.getName() + '-' + now.format();
            
            * Boolean existsAccStatus = false;
            
            * for (CronJobDetail ct : [SELECT Name, JobType FROM CronJobDetail WHERE Name = :schNameAccStatus]) {
            *     existsAccStatus = true;
            * }
            
            * if (!existsAccStatus) {
            * 	System.schedule(schNameAccStatus, cronStringAccStatus, new ACC_sch_AccountStatusCalculation(statusRuleResultMap));
            * }
        * }
			*/
    }
    else if (Trigger.isDelete) {        
        for (TBO001_AccountClassification__c classification : Trigger.old) {
            if (classification.TBO001_rb_Account__c != null) {
                if (accountMap.size() > 0) {
                    Account acc = accountMap.get(classification.TBO001_rb_Account__c);
    
                    Boolean isAccUpdt = false;
                    
    				System.debug('Account Total Tiers Map: ' + accountTotalTiersMap);
                    
                    if (acc != null) {
                        if (accountTotalTiersMap.size() > 0) {
                            TBO001_AccountClassification__c accountTotalTiers = accountTotalTiersMap.get(acc.Id);
                            
                            if (accountTotalTiers == null) {
                                acc.ACC_tx_Account_Tier__c = null;
                                acc.ACC_tx_Company_Rank__c = null;
                                acc.ACC_tx_Account_Status__c = null;
                                acc.ACC_tx_Customer_Since__c = null;
                                
                                isAccUpdt = true;
                            }
                            
                            if (accountClassTiersMap.size() > 0) {
                                String tierKey = acc.Id + ':' + classification.TBO001_ls_Tier__c;
                                
                                TBO001_AccountClassification__c accountTiersAC = accountClassTiersMap.get(tierKey);
                                
                                if (accountTiersAC == null) { 
                                    String accountTier;
                                    
                                    if (accountTierMap.size() > 0) {
                                        try {
                                            TBO001_AccountClassification__c acTier = accountTierMap.get(acc.Id);
                                            
                                            if (acTier != null) {
                                                accountTier = acTier.TBO001_ls_Tier__c;
                                                
                                                
                                                if (String.isNotEmpty(accountTier)) {
                                                    acc.ACC_tx_Account_Tier__c = accountTier;
                                                    
                                                    isAccUpdt = true;
                                                }
                                                else {                            
                                                    acc.ACC_tx_Account_Tier__c = null;
                                                    
                                                    isAccUpdt = true;
                                                }
                                            }
                                            else {                        
                                                acc.ACC_tx_Account_Tier__c = null;
                                                
                                                isAccUpdt = true;
                                            }
                                        }
                                        catch (Exception exDelAccClass) {
                                            System.debug('Error: ' + exDelAccClass.getMessage() + ' (Line: ' + exDelAccClass.getLineNumber() + ').');
                                            
                                            acc.ACC_tx_Account_Tier__c = null;
                                            
                                            isAccUpdt = true;
                                        }
                                    }
                                    
                                }
                            }
                        }
                        else {
                            acc.ACC_tx_Account_Tier__c = null;
                            acc.ACC_tx_Company_Rank__c = null;
                            acc.ACC_tx_Account_Status__c = null;
                            acc.ACC_tx_Customer_Since__c = null;
                            
                            isAccUpdt = true;
                        }
                        
                        if (accountLowestCustomerSince.size() > 0) {
                            String lowestCustomerSince;
                            
                            try {
                                lowestCustomerSince = accountLowestCustomerSince.get(acc.Id);
                            }
                            catch (Exception exLowestCustomerSince) {
                                System.debug('Error: ' + exLowestCustomerSince.getMessage() + ' (Line: ' + exLowestCustomerSince.getLineNumber() + ').');
                                
                                acc.ACC_tx_Customer_Since__c = null;
                                
                                isAccUpdt = true;
                            }
                            
                            Integer lowestCustomerSinceYear = 0;
                            
                            if (lowestCustomerSince != null) {
                                lowestCustomerSinceYear = Integer.valueOf(lowestCustomerSince);
                            }
                            
                            acc.ACC_tx_Customer_Since__c = lowestCustomerSince;
                            
                            isAccUpdt = true;
                        }
                        
                        if (isAccUpdt) {
                            if (accUpdtMap != null) {
                                Account tempAccount = accUpdtMap.get(acc.Id);
                                
                                if (tempAccount  == null) {
                                    accUpdtMap.put(acc.Id, acc);
                                }
                            }
                            else {
                                accUpdtMap = new Map<Id, Account>();
                                accUpdtMap.put(acc.Id, acc);
                            }
                        }
                        
                        if (String.isNotEmpty(classification.OwnerId)) {
                            if (accountTeamMemberMap.size() > 0) {
                                AccountTeamMember currentAccountTeamMember;
                                
                                try {
                                    String currentMemberDelkey = acc.Id + ':' + classification.OwnerId;
                                    
                                    currentAccountTeamMember = accountTeamMemberMap.get(currentMemberDelkey);
                                }
                                catch (Exception exExtCurrATM) {
                                    System.debug('Error: ' + exExtCurrATM.getMessage() + ' (Line: ' + exExtCurrATM.getLineNumber() + ').');
                                }
                                
                                if (currentAccountTeamMember != null) {
                                    
                                    if (accountClassOwnerMap.size() > 0) {
                                        String tierKey = acc.Id + ':' + classification.OwnerId;
                                        
                                        TBO001_AccountClassification__c accountOwnersAC = accountClassOwnerMap.get(tierKey);
                                        
                                        if (accountOwnersAC == null) {  
                                            String keyAccTemMember = currentAccountTeamMember.AccountId + ':' + currentAccountTeamMember.UserId;
                                            
                                            if (accTeamDelMap.get(keyAccTemMember) == null) {
                                                accTeamDelMap.put(keyAccTemMember, currentAccountTeamMember);
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        /**
        Integer intervalSeconds = 1;
        DateTime now  = DateTime.now();
        DateTime nextRunTimeDel = now.addSeconds(intervalSeconds);
        
        String cronStringDel = '' + nextRunTimeDel.second() + ' ' + nextRunTimeDel.minute() + ' ' + 
            nextRunTimeDel.hour() + ' ' + nextRunTimeDel.day() + ' ' + 
            nextRunTimeDel.month() + ' ? ' + nextRunTimeDel.year();
        
        //Database.executeBatch(new TBO001_bch_AccountClassificationDel(accountClassificationIdSet, accountMap, accountTotalTiersMap, accountClassTiersMap, accountTierMap, accountLowestCustomerSince, accountTeamMemberMap, accountClassOwnerMap));
        
        String schNameDel = TBO001_sch_AccountClassificationDel.class.getName() + '-' + now.format();
        
        Boolean existsDel = false;
        
        for (CronJobDetail ct : [SELECT Name, JobType FROM CronJobDetail WHERE Name = :schNameDel]) {
            existsDel = true;
        }
        
        if (!existsDel) {
            System.schedule(schNameDel, cronStringDel, new TBO001_sch_AccountClassificationDel(accountClassificationIdSet, accountMap, accountTotalTiersMap, accountClassTiersMap, accountTierMap, accountLowestCustomerSince, accountTeamMemberMap, accountClassOwnerMap));
        }*/
    }
    
    if (accUpdtMap != null) {
        if (accUpdtMap.size() > 0) {
            try {
                upsert accUpdtMap.values();
            }
            catch (Exception exUpdtAcc) {
                System.debug(Util_cls.obtieneMensajeReglaValidacion(exUpdtAcc));
            }
        }
    }
    
    if (accTeamInsMap != null) {
        if (accTeamInsMap.size() > 0) {
            try {
                upsert accTeamInsMap.values();
            }
            catch (Exception exUpsAccTeam) {
                System.debug(Util_cls.obtieneMensajeReglaValidacion(exUpsAccTeam));
            }
        }
    }
    
    if (accTeamDelMap != null) {
        if (accTeamDelMap.size() > 0) {
            try {
                delete accTeamDelMap.values();
            }
            catch (Exception exDelAccTeam) {
                System.debug(Util_cls.obtieneMensajeReglaValidacion(exDelAccTeam));
            }
        }
    }
}