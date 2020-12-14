@isTest
public class ACC_cvf_CalculateCustomerSince_tst {
	@isTest(SeeAllData=false)
    static void test () {
        
        User currentUser = TestDataFactory_tst.createUser('test1@engenium.com', 'Generic', 'Sales Rep - México 1');
        
        System.runAs(currentUser) { 
        
            Account acc = TestDataFactory_tst.createAccount('Account Test', '010101');
            Account topParentAcc = TestDataFactory_tst.createAccount('Top Parent Test', '000000');
            Account childAcc = TestDataFactory_tst.createAccount(topParentAcc.Id, 'Child Account Test', '111111');
            
            List<Account> accList = new List<Account>();
            accList.add(acc);
            accList.add(topParentAcc);
            accList.add(childAcc);
            
            update accList;
            
            TBO001_AccountClassification__c accClass = TestDataFactory_tst.createAccountClassification(acc, 'Tier One');
            TBO001_AccountClassification__c topParentAccClass = TestDataFactory_tst.createAccountClassification(topParentAcc, 'Tier Two');
            TBO001_AccountClassification__c childAccClass = TestDataFactory_tst.createAccountClassification(childAcc, 'Tier Three', 'Equipment', '2013');
                        
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
            
            test.startTest();
            
            ACC_cvf_CalculateCustomerSince calculateCustomerSinceCtrl = new ACC_cvf_CalculateCustomerSince();
            
            PageReference refresh = calculateCustomerSinceCtrl.doCalculate();
            
            test.stopTest();
        }
    }
}