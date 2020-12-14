global class ACC_sch_CalculateCustomerSince implements Schedulable {
	global void execute(SchedulableContext sc) {
        Map<String, TBO023_Customer_Since__c> customerSinceMap = new Map<String, TBO023_Customer_Since__c>();
        
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
        }
        
        TBO001_batch_CalculateCustomerSince batchAccountClassification = new TBO001_batch_CalculateCustomerSince(customerSinceMap, fundedTakedownsMap);
        Database.executeBatch(batchAccountClassification, 200);
   }
}