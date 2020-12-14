@isTest
public with sharing class ACC_sch_CalculateCustomerSince_tst {
    @isTest(SeeAllData=false)
    static void testCustomerSinceOverTakedownYear() {
        User currentUser = TestDataFactory_tst.createUser('test1@engenium.com', 'Generic', 'Sales Rep - México 1');
        
        System.runAs(currentUser) { 
        
            Account acc = TestDataFactory_tst.createAccount('Account Test', '010101');
            Account topParentAcc = TestDataFactory_tst.createAccount('Top Parent Test', '000000');
            Account childAcc = TestDataFactory_tst.createAccount(topParentAcc.Id, 'Child Account Test', '111111');
            
            List<Account> accList = new List<Account>();
            accList.add(acc);
            accList.add(topParentAcc);
            accList.add(childAcc);
            
            TBO001_AccountClassification__c accClass = TestDataFactory_tst.createAccountClassification(acc, 'Tier One');
            TBO001_AccountClassification__c topParentAccClass = TestDataFactory_tst.createAccountClassification(topParentAcc, 'Tier Two');
            TBO001_AccountClassification__c childAccClass = TestDataFactory_tst.createAccountClassification(childAcc, 'Tier Three');
            
            TBO022_Competitor__c competitor = TestDataFactory_tst.createCompetitor();
            
            /**Opportunity accOpp = TestDataFactory_tst.createOpportunity(acc, currentUser, competitor);
            Opportunity childAccOpp = TestDataFactory_tst.createOpportunity(childAcc, currentUser, competitor);*/
            
            List<Opportunity> oppList = TestDataFactory_tst.createOpportunities(accList, currentUser, competitor);
            
            TBO020_Takedowns__c childAccTkdwn = TestDataFactory_tst.createTakedownForecast(oppList[0], currentUser, 'Funded');
            TBO020_Takedowns__c childAccTkdwn1 = TestDataFactory_tst.createTakedownForecast(oppList[1], currentUser, 'Funded');
            TBO020_Takedowns__c childAccTkdwn2 = TestDataFactory_tst.createTakedownForecast(oppList[1], currentUser, 'Funded');
            
            Date fundedDate = childAccTkdwn1.TBO020_fh_Funding_Date__c;
            
            childAccTkdwn1.TBO020_fh_Funding_Date__c = fundedDate.addYears(-1);
            
            update childAccTkdwn1;
                
            TBO023_Customer_Since__c custSinceAccount = TestDataFactory_tst.createCustomerSince(acc, '2015');
            TBO023_Customer_Since__c custSinceTopParentAccount = TestDataFactory_tst.createCustomerSince(topParentAcc, '2016');
                    
            Map<String, TBO023_Customer_Since__c> customerSinceMap = new Map<String, TBO023_Customer_Since__c>();
            Map<String, Integer> fundedTakedownsMap = new Map<String, Integer>();
            
            test.startTest();
            
                for (TBO023_Customer_Since__c customerSince : [SELECT TBO023_tx_Ext_ref_Account_id__c, TBO023_ls_Line_Of_Business__c, TBO023_tx_Customer_since__c FROM TBO023_Customer_Since__c ORDER BY TBO023_tx_Ext_ref_Account_id__c, TBO023_ls_Line_Of_Business__c]) {
                    String key = customerSince.TBO023_tx_Ext_ref_Account_id__c + ':' + customerSince.TBO023_ls_Line_Of_Business__c;
                    
                    customerSinceMap.put(key, customerSince);
                }
                
                for (AggregateResult fundedTakedownAR : [SELECT TBO020_fh_Funding_Date__c FundingDate, TBO020_pd_Opportunity__r.AccountId AccountId, TBO020_pd_Opportunity__r.OPP_ls_Line_of_Business__c LineBusiness FROM TBO020_Takedowns__c WHERE TBO020_tx_Status__c = 'Funded' AND TBO020_fh_Funding_Date__c <> null AND TBO020_pd_Opportunity__r.OPP_ls_Line_of_Business__c <> null GROUP BY TBO020_fh_Funding_Date__c, TBO020_pd_Opportunity__r.AccountId, TBO020_pd_Opportunity__r.OPP_ls_Line_of_Business__c ORDER BY TBO020_fh_Funding_Date__c, TBO020_pd_Opportunity__r.AccountId, TBO020_pd_Opportunity__r.OPP_ls_Line_of_Business__c LIMIT 2000]) {
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
                
                try{
                    ACC_sch_CalculateCustomerSince schUpdtCS = new ACC_sch_CalculateCustomerSince();
                    String schTime = '0 0 0 * * ?';
                    System.schedule('Calculate Customer Since', schTime, schUpdtCS);
                    
                    TBO001_batch_CalculateCustomerSince batch = new TBO001_batch_CalculateCustomerSince(customerSinceMap, fundedTakedownsMap);
                    Database.executeBatch(batch, 200);
                }
                catch(Exception e){
                    
                }
            
            test.stopTest();
        }
    }
    
    @isTest(SeeAllData=false)
    static void testTakedownOverCustomerSinceYear () {
        
        User currentUser = TestDataFactory_tst.createUser('test1@engenium.com', 'Generic', 'Sales Rep - México 1');
        
        System.runAs(currentUser) { 
        
            Account topParentAcc = TestDataFactory_tst.createAccount('Top Parent Test', '000000');
            Account childAcc = TestDataFactory_tst.createAccount(topParentAcc.Id, 'Child Account Test', '111111');
            
            List<Account> accList = new List<Account>();
            accList.add(topParentAcc);
            accList.add(childAcc);
            
            TBO001_AccountClassification__c topParentAccClass = TestDataFactory_tst.createAccountClassification(topParentAcc, 'Tier Two');
            TBO001_AccountClassification__c childAccClass = TestDataFactory_tst.createAccountClassification(childAcc, 'Tier Three');
            
            TBO022_Competitor__c competitor = TestDataFactory_tst.createCompetitor();
            
            List<Opportunity> oppList = TestDataFactory_tst.createOpportunities(accList, currentUser, competitor);
            
            TBO020_Takedowns__c childAccTkdwn = TestDataFactory_tst.createTakedownForecast(oppList[0], currentUser, 'Funded');
            TBO020_Takedowns__c childAccTkdwn1 = TestDataFactory_tst.createTakedownForecast(oppList[1], currentUser, 'Funded');
            TBO020_Takedowns__c childAccTkdwn2 = TestDataFactory_tst.createTakedownForecast(oppList[1], currentUser, 'Funded');
            
            Date fundedDate1 = childAccTkdwn.TBO020_fh_Funding_Date__c;
            
            childAccTkdwn.TBO020_fh_Funding_Date__c = fundedDate1.addYears(-6);
            
            update childAccTkdwn;
            
            Date fundedDate2 = childAccTkdwn1.TBO020_fh_Funding_Date__c;
            
            childAccTkdwn1.TBO020_fh_Funding_Date__c = fundedDate2.addYears(-4);
            
            update childAccTkdwn1;
                
            TBO023_Customer_Since__c custSinceTopParentAccountAccount = TestDataFactory_tst.createCustomerSince(topParentAcc, '2017');
            TBO023_Customer_Since__c custSinceChildAccount = TestDataFactory_tst.createCustomerSince(childAcc, '2018');
            
            Map<String, TBO023_Customer_Since__c> customerSinceMap = new Map<String, TBO023_Customer_Since__c>();
            Map<String, Integer> fundedTakedownsMap = new Map<String, Integer>();
            
            test.startTest();
            
                for (TBO023_Customer_Since__c customerSince : [SELECT TBO023_tx_Ext_ref_Account_id__c, TBO023_ls_Line_Of_Business__c, TBO023_tx_Customer_since__c FROM TBO023_Customer_Since__c ORDER BY TBO023_tx_Ext_ref_Account_id__c, TBO023_ls_Line_Of_Business__c]) {
                    String key = customerSince.TBO023_tx_Ext_ref_Account_id__c + ':' + customerSince.TBO023_ls_Line_Of_Business__c;
                    
                    customerSinceMap.put(key, customerSince);
                }
                
                for (AggregateResult fundedTakedownAR : [SELECT TBO020_fh_Funding_Date__c FundingDate, TBO020_pd_Opportunity__r.AccountId AccountId, TBO020_pd_Opportunity__r.OPP_ls_Line_of_Business__c LineBusiness FROM TBO020_Takedowns__c WHERE TBO020_tx_Status__c = 'Funded' AND TBO020_fh_Funding_Date__c <> null AND TBO020_pd_Opportunity__r.OPP_ls_Line_of_Business__c <> null GROUP BY TBO020_fh_Funding_Date__c, TBO020_pd_Opportunity__r.AccountId, TBO020_pd_Opportunity__r.OPP_ls_Line_of_Business__c ORDER BY TBO020_fh_Funding_Date__c, TBO020_pd_Opportunity__r.AccountId, TBO020_pd_Opportunity__r.OPP_ls_Line_of_Business__c LIMIT 2000]) {
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
                
                try{
                    ACC_sch_CalculateCustomerSince schUpdtCS = new ACC_sch_CalculateCustomerSince();
                    String schTime = '0 0 0 * * ?';
                    System.schedule('Calculate Customer Since', schTime, schUpdtCS);
                    
                    TBO001_batch_CalculateCustomerSince batch = new TBO001_batch_CalculateCustomerSince(customerSinceMap, fundedTakedownsMap);
                    Database.executeBatch(batch, 200);
                }
                catch(Exception e){
                    
                }
            
            test.stopTest();
        }
    }
    
    @isTest(SeeAllData=false)
    static void testTakedownYear () {
        
        User currentUser = TestDataFactory_tst.createUser('test1@engenium.com', 'Generic', 'Sales Rep - México 1');
        
        System.runAs(currentUser) { 
        
            Account topParentAcc = TestDataFactory_tst.createAccount('Top Parent Test', '000000');
            Account childAcc = TestDataFactory_tst.createAccount(topParentAcc.Id, 'Child Account Test', '111111');
            
            List<Account> accList = new List<Account>();
            accList.add(topParentAcc);
            accList.add(childAcc);
            
            TBO001_AccountClassification__c topParentAccClass = TestDataFactory_tst.createAccountClassification(topParentAcc, 'Tier Two');
            TBO001_AccountClassification__c childAccClass = TestDataFactory_tst.createAccountClassification(childAcc, 'Tier Three');
            
            TBO022_Competitor__c competitor = TestDataFactory_tst.createCompetitor();
            
            List<Opportunity> oppList = TestDataFactory_tst.createOpportunities(accList, currentUser, competitor);
            
            TBO020_Takedowns__c childAccTkdwn = TestDataFactory_tst.createTakedownForecast(oppList[0], currentUser, 'Funded');
            TBO020_Takedowns__c childAccTkdwn1 = TestDataFactory_tst.createTakedownForecast(oppList[1], currentUser, 'Funded');
            TBO020_Takedowns__c childAccTkdwn2 = TestDataFactory_tst.createTakedownForecast(oppList[1], currentUser, 'Funded');
            
            Date fundedDate1 = childAccTkdwn.TBO020_fh_Funding_Date__c;
            
            childAccTkdwn.TBO020_fh_Funding_Date__c = fundedDate1.addYears(-6);
            
            update childAccTkdwn;
            
            Date fundedDate2 = childAccTkdwn1.TBO020_fh_Funding_Date__c;
            
            childAccTkdwn1.TBO020_fh_Funding_Date__c = fundedDate2.addYears(-4);
            
            update childAccTkdwn1;
                
            TBO023_Customer_Since__c custSinceTopParentAccountAccount = TestDataFactory_tst.createCustomerSince(topParentAcc, null);
            TBO023_Customer_Since__c custSinceChildAccount = TestDataFactory_tst.createCustomerSince(childAcc, null);
            
            Map<String, TBO023_Customer_Since__c> customerSinceMap = new Map<String, TBO023_Customer_Since__c>();
            Map<String, Integer> fundedTakedownsMap = new Map<String, Integer>();
            
            test.startTest();
            
                for (TBO023_Customer_Since__c customerSince : [SELECT TBO023_tx_Ext_ref_Account_id__c, TBO023_ls_Line_Of_Business__c, TBO023_tx_Customer_since__c FROM TBO023_Customer_Since__c ORDER BY TBO023_tx_Ext_ref_Account_id__c, TBO023_ls_Line_Of_Business__c]) {
                    String key = customerSince.TBO023_tx_Ext_ref_Account_id__c + ':' + customerSince.TBO023_ls_Line_Of_Business__c;
                    
                    customerSinceMap.put(key, customerSince);
                }
                
                for (AggregateResult fundedTakedownAR : [SELECT TBO020_fh_Funding_Date__c FundingDate, TBO020_pd_Opportunity__r.AccountId AccountId, TBO020_pd_Opportunity__r.OPP_ls_Line_of_Business__c LineBusiness FROM TBO020_Takedowns__c WHERE TBO020_tx_Status__c = 'Funded' AND TBO020_fh_Funding_Date__c <> null AND TBO020_pd_Opportunity__r.OPP_ls_Line_of_Business__c <> null GROUP BY TBO020_fh_Funding_Date__c, TBO020_pd_Opportunity__r.AccountId, TBO020_pd_Opportunity__r.OPP_ls_Line_of_Business__c ORDER BY TBO020_fh_Funding_Date__c, TBO020_pd_Opportunity__r.AccountId, TBO020_pd_Opportunity__r.OPP_ls_Line_of_Business__c LIMIT 2000]) {
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
                
                try{
                    ACC_sch_CalculateCustomerSince schUpdtCS = new ACC_sch_CalculateCustomerSince();
                    String schTime = '0 0 0 * * ?';
                    System.schedule('Calculate Customer Since', schTime, schUpdtCS);
                    
                    TBO001_batch_CalculateCustomerSince batch = new TBO001_batch_CalculateCustomerSince(customerSinceMap, fundedTakedownsMap);
                    Database.executeBatch(batch, 200);
                }
                catch(Exception e){
                    
                }
            
            test.stopTest();
        }
    }
    
    @isTest(SeeAllData=false)
    static void testCustomerSinceYearNoTakedown () {
        
        User currentUser = TestDataFactory_tst.createUser('test1@engenium.com', 'Generic', 'Sales Rep - México 1');
        
        System.runAs(currentUser) { 
        
            Account topParentAcc = TestDataFactory_tst.createAccount('Top Parent Test', '000000');
            Account childAcc = TestDataFactory_tst.createAccount(topParentAcc.Id, 'Child Account Test', '111111');
            
            List<Account> accList = new List<Account>();
            accList.add(topParentAcc);
            accList.add(childAcc);
            
            TBO001_AccountClassification__c topParentAccClass = TestDataFactory_tst.createAccountClassification(topParentAcc, 'Tier Two');
            TBO001_AccountClassification__c childAccClass = TestDataFactory_tst.createAccountClassification(childAcc, 'Tier Three');
                            
            TBO023_Customer_Since__c custSinceTopParentAccountAccount = TestDataFactory_tst.createCustomerSince(topParentAcc, '2015');
            TBO023_Customer_Since__c custSinceChildAccount = TestDataFactory_tst.createCustomerSince(childAcc, '2016');
            
            Map<String, TBO023_Customer_Since__c> customerSinceMap = new Map<String, TBO023_Customer_Since__c>();
            Map<String, Integer> fundedTakedownsMap = new Map<String, Integer>();
            
            test.startTest();
            
                for (TBO023_Customer_Since__c customerSince : [SELECT TBO023_tx_Ext_ref_Account_id__c, TBO023_ls_Line_Of_Business__c, TBO023_tx_Customer_since__c FROM TBO023_Customer_Since__c ORDER BY TBO023_tx_Ext_ref_Account_id__c, TBO023_ls_Line_Of_Business__c]) {
                    String key = customerSince.TBO023_tx_Ext_ref_Account_id__c + ':' + customerSince.TBO023_ls_Line_Of_Business__c;
                    
                    customerSinceMap.put(key, customerSince);
                }
                
                for (AggregateResult fundedTakedownAR : [SELECT TBO020_fh_Funding_Date__c FundingDate, TBO020_pd_Opportunity__r.AccountId AccountId, TBO020_pd_Opportunity__r.OPP_ls_Line_of_Business__c LineBusiness FROM TBO020_Takedowns__c WHERE TBO020_tx_Status__c = 'Funded' AND TBO020_fh_Funding_Date__c <> null AND TBO020_pd_Opportunity__r.OPP_ls_Line_of_Business__c <> null GROUP BY TBO020_fh_Funding_Date__c, TBO020_pd_Opportunity__r.AccountId, TBO020_pd_Opportunity__r.OPP_ls_Line_of_Business__c ORDER BY TBO020_fh_Funding_Date__c, TBO020_pd_Opportunity__r.AccountId, TBO020_pd_Opportunity__r.OPP_ls_Line_of_Business__c LIMIT 2000]) {
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
                
                try{
                    ACC_sch_CalculateCustomerSince schUpdtCS = new ACC_sch_CalculateCustomerSince();
                    String schTime = '0 0 0 * * ?';
                    System.schedule('Calculate Customer Since', schTime, schUpdtCS);
                    
                    TBO001_batch_CalculateCustomerSince batch = new TBO001_batch_CalculateCustomerSince(customerSinceMap, fundedTakedownsMap);
                    Database.executeBatch(batch, 200);
                }
                catch(Exception e){
                    
                }
            
            test.stopTest();
        }
    }
    
    @isTest(SeeAllData=false)
    static void testTakedownYearNoCustomerSince () {
        
        User currentUser = TestDataFactory_tst.createUser('test1@engenium.com', 'Generic', 'Sales Rep - México 1');
        
        System.runAs(currentUser) { 
        
            Account topParentAcc = TestDataFactory_tst.createAccount('Top Parent Test', '000000');
            Account childAcc = TestDataFactory_tst.createAccount(topParentAcc.Id, 'Child Account Test', '111111');
            
            List<Account> accList = new List<Account>();
            accList.add(topParentAcc);
            accList.add(childAcc);
            
            TBO001_AccountClassification__c topParentAccClass = TestDataFactory_tst.createAccountClassification(topParentAcc, 'Tier Two');
            TBO001_AccountClassification__c childAccClass = TestDataFactory_tst.createAccountClassification(childAcc, 'Tier Three');
            
            TBO022_Competitor__c competitor = TestDataFactory_tst.createCompetitor();
            
            List<Opportunity> oppList = TestDataFactory_tst.createOpportunities(accList, currentUser, competitor);
            
            TBO020_Takedowns__c childAccTkdwn = TestDataFactory_tst.createTakedownForecast(oppList[0], currentUser, 'Funded');
            TBO020_Takedowns__c childAccTkdwn1 = TestDataFactory_tst.createTakedownForecast(oppList[1], currentUser, 'Funded');
            TBO020_Takedowns__c childAccTkdwn2 = TestDataFactory_tst.createTakedownForecast(oppList[1], currentUser, 'Funded');
            
            Date fundedDate1 = childAccTkdwn.TBO020_fh_Funding_Date__c;
            
            childAccTkdwn.TBO020_fh_Funding_Date__c = fundedDate1.addYears(-6);
            
            update childAccTkdwn;
            
            Date fundedDate2 = childAccTkdwn1.TBO020_fh_Funding_Date__c;
            
            childAccTkdwn1.TBO020_fh_Funding_Date__c = fundedDate2.addYears(-4);
            
            update childAccTkdwn1;
            
            Map<String, TBO023_Customer_Since__c> customerSinceMap = new Map<String, TBO023_Customer_Since__c>();
            Map<String, Integer> fundedTakedownsMap = new Map<String, Integer>();
            
            test.startTest();
            
                for (TBO023_Customer_Since__c customerSince : [SELECT TBO023_tx_Ext_ref_Account_id__c, TBO023_ls_Line_Of_Business__c, TBO023_tx_Customer_since__c FROM TBO023_Customer_Since__c ORDER BY TBO023_tx_Ext_ref_Account_id__c, TBO023_ls_Line_Of_Business__c]) {
                    String key = customerSince.TBO023_tx_Ext_ref_Account_id__c + ':' + customerSince.TBO023_ls_Line_Of_Business__c;
                    
                    customerSinceMap.put(key, customerSince);
                }
                
                for (AggregateResult fundedTakedownAR : [SELECT TBO020_fh_Funding_Date__c FundingDate, TBO020_pd_Opportunity__r.AccountId AccountId, TBO020_pd_Opportunity__r.OPP_ls_Line_of_Business__c LineBusiness FROM TBO020_Takedowns__c WHERE TBO020_tx_Status__c = 'Funded' AND TBO020_fh_Funding_Date__c <> null AND TBO020_pd_Opportunity__r.OPP_ls_Line_of_Business__c <> null GROUP BY TBO020_fh_Funding_Date__c, TBO020_pd_Opportunity__r.AccountId, TBO020_pd_Opportunity__r.OPP_ls_Line_of_Business__c ORDER BY TBO020_fh_Funding_Date__c, TBO020_pd_Opportunity__r.AccountId, TBO020_pd_Opportunity__r.OPP_ls_Line_of_Business__c LIMIT 2000]) {
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
                
                try{
                    ACC_sch_CalculateCustomerSince schUpdtCS = new ACC_sch_CalculateCustomerSince();
                    String schTime = '0 0 0 * * ?';
                    System.schedule('Calculate Customer Since', schTime, schUpdtCS);
                    
                    TBO001_batch_CalculateCustomerSince batch = new TBO001_batch_CalculateCustomerSince(customerSinceMap, fundedTakedownsMap);
                    Database.executeBatch(batch, 200);
                }
                catch(Exception e){
                    
                }
            
            test.stopTest();
        }
    }
}