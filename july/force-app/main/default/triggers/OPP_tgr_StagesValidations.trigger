trigger OPP_tgr_StagesValidations on Opportunity (before update, after update, after delete) {
   /* Set<Id> accountIdSet = new Set<Id>();
    
    if(Trigger.isUpdate) {
        List<TBO014_Credit_Approval__c> creditApprovalUpdtList = new List<TBO014_Credit_Approval__c>();
            
        for(Opportunity opp:trigger.new) {
            if ((!opp.StageName.equals(Trigger.oldMap.get(opp.Id).StageName)) && opp.StageName.equalsignorecase('Proposal')) {
                List<TBO018_Pricing__c> lstPricing =[SELECT Id, TBO018_ca_Approved_by_Risk__c, TBO018_ls_Type__c FROM TBO018_Pricing__c 
                                                     WHERE TBO018_rb_Opportunity__c = :opp.Id and TBO018_ls_Type__c = 'Proposal' and TBO018_tx_Pricing_Status__c = 'Approved'];
                
                if(lstPricing.isEmpty()) {
                 //   opp.addError(system.Label.OpportunityPricingError);     
                }
            }
            
            if (trigger.isAfter) {
                if (opp.Amount != trigger.oldMap.get(opp.Id).Amount) {
                    
                    TBO014_Credit_Approval__c creditApproval;
                    
                    try {
                        creditApproval = [SELECT Id, TBO014_un_Amount_MXN__c, TBO014_un_Amount_USD__c, TBO014_un_Total_Amount_USD_Converted__c FROM TBO014_Credit_Approval__c WHERE Id = :opp.OPP_rb_Credit_Approval__c];
                    }
                    catch (Exception exNOCA) {
                        System.debug('Error: ' + exNOCA.getMessage() + ' (Line: ' + exNOCA.getLineNumber() + ').');
                    }
                        
                    if (creditApproval != null) {
                        List<Opportunity> oppList = [SELECT Id FROM Opportunity WHERE OPP_rb_Credit_Approval__c = :creditApproval.Id];
                        Set<Id> oppIdSet = new Set<Id>();
                        
                        for (Opportunity opportunity : oppList) {
                            oppIdSet.add(opportunity.Id);
                        }
                        
                        Util_cls.calculateAmounts(creditApproval, oppIdSet);
                        
                        creditApprovalUpdtList.add(creditApproval);
                    }
                }
            }
            
            if (trigger.isAfter) {
                System.debug('Opp (' + opp.Id + '): ' + opp.StageName);
                
                if (opp.StageName.equals('Funded')) {
                    System.debug('Opp (' + opp.Id + '): ' + opp.StageName);
                    accountIdSet.add(opp.AccountId);
                }
            }
        }
        
        System.debug('Account Id Set: ' + accountIdSet);
        
        if (creditApprovalUpdtList.size() > 0) {
            update creditApprovalUpdtList;
        }
        
        List<Opportunity> fundedOpportunityList;
        
        try {
            fundedOpportunityList = [SELECT Id, AccountId, OPP_fh_Funded_Date__c FROM Opportunity WHERE AccountId IN :accountIdSet AND OPP_fh_Funded_Date__c <> null ORDER BY OPP_fh_Funded_Date__c ASC];
        }
        catch (Exception exFundedOppList) {
            System.debug('Error: ' + exFundedOppList.getMessage() + ' (Linea: ' + exFundedOppList.getLineNumber() + ').');
        }
        
        System.debug('Funded Opportunity List: ' + fundedOpportunityList);    
        
        if (fundedOpportunityList != null) {
            Map<Id, Date> accountLastFundedDateMap = new Map<Id, Date>();
            
            for (Opportunity opp : fundedOpportunityList) {
                Id accountId = opp.AccountId;
                Date fundedDate = opp.OPP_fh_Funded_Date__c;
                
                if ((accountLastFundedDateMap.size() == 0) || (accountLastFundedDateMap.get(accountId) == null)) {
                    if (fundedDate != null) {
                        accountLastFundedDateMap.put(accountId, fundedDate);
                    }
                }
            }
            
            List<Account> accList;
        
            try {
                accList = [SELECT Id, ACC_fh_Last_Date_Funded_Opportunity__c FROM Account WHERE Id IN :accountIdSet ORDER BY Id];
            }
            catch (Exception exAccList) {
                System.debug('Error: ' + exAccList.getMessage() + ' (Linea: ' + exAccList.getLineNumber() + ').');
            }
        
            System.debug('Account List: ' + accList);
            
            if (accList != null) {
                List<Account> accUpdtList = new List<Account>();
                
                for (Account acc : accList) {
                    Date lastFundedDate = accountLastFundedDateMap.get(acc.Id);
                    
                    if (lastFundedDate != null) {
                        acc.ACC_fh_Last_Date_Funded_Opportunity__c = lastFundedDate;
                        accUpdtList.add(acc);
                    }
                }
                
                System.debug('Update Account List: ' + accUpdtList );
                
                if (accUpdtList.size() > 0) {
                    update accUpdtList;
                }
            }
        }
    }
    else if (Trigger.isDelete) {
        for (Opportunity opp : Trigger.old) {
            if (!accountIdSet.contains(opp.AccountId)) {
                accountIdSet.add(opp.AccountId);
            }
        }
        
        List<Opportunity> fundedOpportunityList;
        
        try {
            fundedOpportunityList = [SELECT Id, AccountId, OPP_fh_Funded_Date__c FROM Opportunity WHERE AccountId IN :accountIdSet AND OPP_fh_Funded_Date__c <> null ORDER BY OPP_fh_Funded_Date__c ASC];
        }
        catch (Exception exFundedOppList) {
            System.debug('Error: ' + exFundedOppList.getMessage() + ' (Linea: ' + exFundedOppList.getLineNumber() + ').');
        }
        
        System.debug('Funded Opportunity List: ' + fundedOpportunityList);    
        
        if (fundedOpportunityList != null) {
            Map<Id, Date> accountLastFundedDateMap = new Map<Id, Date>();
            
            for (Opportunity opp : fundedOpportunityList) {
                Id accountId = opp.AccountId;
                Date fundedDate = opp.OPP_fh_Funded_Date__c;
                
                if ((accountLastFundedDateMap.size() == 0) || (accountLastFundedDateMap.get(accountId) == null)) {
                    if (fundedDate != null) {
                        accountLastFundedDateMap.put(accountId, fundedDate);
                    }
                }
            }
            
            List<Account> accList;
            
            try {
                accList = [SELECT Id, ACC_fh_Last_Date_Funded_Opportunity__c FROM Account WHERE Id IN :accountIdSet ORDER BY Id];
            }
            catch (Exception exAccList) {
                System.debug('Error: ' + exAccList.getMessage() + ' (Linea: ' + exAccList.getLineNumber() + ').');
            }
            
            System.debug('Account List: ' + accList);
            
            if (accList != null) {
                List<Account> accUpdtList = new List<Account>();
                
                for (Account acc : accList) {
                    Date lastFundedDate = accountLastFundedDateMap.get(acc.Id);
                    
                    if (lastFundedDate != null) {
                        acc.ACC_fh_Last_Date_Funded_Opportunity__c = lastFundedDate;
                        accUpdtList.add(acc);
                    }
                    else if ((acc.ACC_fh_Last_Date_Funded_Opportunity__c != null) && (lastFundedDate == null)) {
                        acc.ACC_fh_Last_Date_Funded_Opportunity__c = null;
                        accUpdtList.add(acc);
                    }
                }
                
                System.debug('Update Account List: ' + accUpdtList );
                
                if (accUpdtList.size() > 0) {
                    update accUpdtList;
                }
            }
        }
    }*/
}