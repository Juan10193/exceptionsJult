public with sharing class ACC_cvf_CalculateCustomerSince {    
	public ACC_cvf_CalculateCustomerSince() {}
    
    public PageReference doCalculate() {
        /**Map<String, TBO023_Customer_Since__c> customerSinceMap = new Map<String, TBO023_Customer_Since__c>();
        
        for (TBO023_Customer_Since__c customerSince : [SELECT TBO023_tx_Ext_ref_Account_id__c, TBO023_ls_Line_Of_Business__c, TBO023_tx_Customer_since__c FROM TBO023_Customer_Since__c ORDER BY TBO023_tx_Ext_ref_Account_id__c, TBO023_ls_Line_Of_Business__c]) {
            String key = customerSince.TBO023_tx_Ext_ref_Account_id__c + ':' + customerSince.TBO023_ls_Line_Of_Business__c;
            
            customerSinceMap.put(key, customerSince);
        }
        
        
        Map<String, Integer> fundedTakedownsMap = new Map<String, Integer>();
        
        for (AggregateResult fundedTakedownAR : [SELECT TBO020_fh_Funding_Date__c FundingDate, TBO020_pd_Opportunity__r.AccountId AccountId, TBO020_pd_Opportunity__r.OPP_ls_Line_of_Business__c LineBusiness FROM TBO020_Takedowns__c WHERE TBO020_tx_Status__c = 'Funded' AND TBO020_fh_Funding_Date__c <> null AND TBO020_pd_Opportunity__r.OPP_ls_Line_of_Business__c <> null GROUP BY TBO020_fh_Funding_Date__c, TBO020_pd_Opportunity__r.AccountId, TBO020_pd_Opportunity__r.OPP_ls_Line_of_Business__c ORDER BY TBO020_fh_Funding_Date__c, TBO020_pd_Opportunity__r.AccountId, TBO020_pd_Opportunity__r.OPP_ls_Line_of_Business__c]) {
            Date fundingDate = ((Date) fundedTakedownAR.get('FundingDate'));
            
            Integer currentYear = fundingDate.year();
            
            Id accountId = ((Id) fundedTakedownAR.get('AccountId'));
            String lineOfBusiness = ((String) fundedTakedownAR.get('LineBusiness'));
            
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
        }*/
        
        TBO001_batch_CalculateCustomerSince batchAccountClassification = new TBO001_batch_CalculateCustomerSince(/**customerSinceMap, fundedTakedownsMap*/);
        Database.executeBatch(batchAccountClassification, 200);
        
        return null;
    }
    
    /**
    public void CalculateForAccountClassification() {
        List<TBO001_AccountClassification__c> accountClassificationUdtList = new List<TBO001_AccountClassification__c>();
        
        for (TBO001_AccountClassification__c accClass : [SELECT Id, TBO001_rb_Account__c, TBO001_rb_Account__r.ACC_tx_EXT_REF_ID__c, TBO001_ls_Line_of_Business__c, TBO001_tx_Customer_Since__c FROM TBO001_AccountClassification__c WHERE TBO001_rb_Account__c <> null ORDER BY TBO001_rb_Account__r.ACC_tx_EXT_REF_ID__c, TBO001_rb_Account__c, TBO001_ls_Line_of_Business__c]) {
            TBO023_Customer_Since__c accClassificationCS;
            
            String customerSinceKey = accClass.TBO001_rb_Account__r.ACC_tx_EXT_REF_ID__c + ':' + accClass.TBO001_ls_Line_of_Business__c;
            
            if (String.isNotEmpty(accClass.TBO001_rb_Account__r.ACC_tx_EXT_REF_ID__c) && String.isNotEmpty(accClass.TBO001_ls_Line_of_Business__c)) {
            	accClassificationCS = this.customerSinceMap.get(customerSinceKey);
            }
            
            String takedownKey = accClass.TBO001_rb_Account__c + ':' + accClass.TBO001_ls_Line_of_Business__c;
            
            Integer takedownYear = 0;
            
            if (String.isNotEmpty(accClass.TBO001_ls_Line_of_Business__c)) {
                takedownYear = this.fundedTakedownsMap.get(takedownKey);
            }
            
            String customerSince;
            
            Boolean hasChanged = false;
            
            if ((accClassificationCS != null) && (takedownYear != null)) {
                if ((takedownYear > 0) && String.isNotEmpty(accClassificationCS.TBO023_tx_Customer_since__c)) {
                    Integer customerSinceYear = Integer.valueOf(accClassificationCS.TBO023_tx_Customer_since__c);
                    
                    if (customerSinceYear <= takedownYear) {
                        customerSince = accClassificationCS.TBO023_tx_Customer_since__c;
                        hasChanged = true;
                    }
                    else if (customerSinceYear > takedownYear) {
                        customerSince = String.valueOf(takedownYear);
                        hasChanged = true;
                    }
                }
                else if ((takedownYear > 0) && String.isEmpty(accClassificationCS.TBO023_tx_Customer_since__c)) {
                    customerSince = String.valueOf(takedownYear);
                    hasChanged = true;
                }
                else if ((takedownYear == 0) && String.isNotEmpty(accClassificationCS.TBO023_tx_Customer_since__c)) {
                    customerSince = accClassificationCS.TBO023_tx_Customer_since__c;
                    hasChanged = true;
                }
            }
            else if ((accClassificationCS != null) && (takedownYear == null)) {
                if (String.isNotEmpty(accClassificationCS.TBO023_tx_Customer_since__c)) {
                    customerSince = accClassificationCS.TBO023_tx_Customer_since__c;
                    hasChanged = true;
                }
            }
            else if ((accClassificationCS == null) && (takedownYear != null)) {
                if (takedownYear > 0) {
                    customerSince = String.valueOf(takedownYear);
                    hasChanged = true;
                }
            }
        
            if (hasChanged) {
                if (String.isNotEmpty(customerSince)) {
                    accClass.TBO001_tx_Customer_Since__c = customerSince;
                    
                    accountClassificationUdtList.add(accClass);
                }
            }
        }
        
        if (accountClassificationUdtList.size() > 0) {
            update accountClassificationUdtList;
        }
    }
    */
}