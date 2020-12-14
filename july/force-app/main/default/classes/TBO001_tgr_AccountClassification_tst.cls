@isTest
public class TBO001_tgr_AccountClassification_tst {
    static testMethod void test_TierNotFour () {
 		User currentUser = TestDataFactory_tst.createUser('test@engenium.com', 'Generic', 'Sales Rep - México 1');
        User otherUser = TestDataFactory_tst.createUser('test2@engenium.com', 'Generic', 'Sales Rep - México 2');
        
        System.runAs(currentUser) { 
            Account accnt = TestDataFactory_tst.createAccount();
            
            TBO001_AccountClassification__c accClass = TestDataFactory_tst.createAccountClassification(accnt, 'Tier One');
            
    		test.startTest();
            
            TBO001_AccountClassification__c accClassTierTwo = TestDataFactory_tst.createAccountClassification(accnt, 'Tier Two');
            
            accClass.TBO001_ls_Tier__c = 'Tier Three';
            accClass.TBO001_ls_CompanyRank__c = 'Maquila';
            
            update accClass;
            
            accClass.TBO001_ls_Tier__c = 'Tier Two';
            accClass.TBO001_ls_CompanyRank__c = null;
            
            update accClass;
            
            //accClass.OwnerId = otherUser.Id;
            
            //update accClass;
            
            delete accClassTierTwo;
        
        	test.stopTest();
        }
    }
    
    static testMethod void test_CustomerSince () {        
 		User currentUser = TestDataFactory_tst.createUser('test@engenium.com', 'Generic', 'Sales Rep - México 1');
        User otherUser = TestDataFactory_tst.createUser('test2@engenium.com', 'Generic', 'Sales Rep - México 2');
        
        System.runAs(currentUser) { 
            Account accnt = TestDataFactory_tst.createAccount('Acc1', '1');
            
            TBO023_Customer_Since__c customerSince = TestDataFactory_tst.createCustomerSince(accnt, '2013');
            TBO023_Customer_Since__c customerSince2 = TestDataFactory_tst.createCustomerSince(accnt, '2015');
            
            customerSince2.TBO023_ls_Line_Of_Business__c = 'Technology';
            
            TBO001_AccountClassification__c accClass = TestDataFactory_tst.createAccountClassification(accnt, 'Tier Three');
            
            accClass.TBO001_ls_Customer_Status__c = 'New Customer to EC';
            accClass.TBO001_ls_Line_of_Business__c = 'Technology';
            
            update accClass;
            
        	test.startTest();
            
            TBO001_AccountClassification__c accClass2 = TestDataFactory_tst.createAccountClassification(accnt, 'Tier Three');
            
            customerSince.TBO023_ls_Line_Of_Business__c = 'Technology';
            
            update customerSince;
            
            accClass2.TBO001_ls_Line_of_Business__c = 'Technology';
            accClass2.OwnerId = otherUser.Id;
            
            update accClass2;
        
        	test.stopTest();
        }
    }
    
    static testMethod void test_CustomerSince_FromTakedown () {
    	test.startTest();
        
 		User currentUser = TestDataFactory_tst.createUser('test@engenium.com', 'Generic', 'Sales Rep - México 1');
        
        System.runAs(currentUser) { 
            Account accnt = TestDataFactory_tst.createAccount();
            
            TBO022_Competitor__c competitor = TestDataFactory_tst.createCompetitor();
            
            Opportunity opp = TestDataFactory_tst.createOpportunity(accnt, currentUser, competitor);
            
            Opportunity opp2 = TestDataFactory_tst.createOpportunity(accnt, currentUser, competitor);
            
            TBO020_Takedowns__c takedownForecast = TestDataFactory_tst.createTakedownForecast(opp, currentUser, 'Funded');
            
            TBO020_Takedowns__c takedownForecast2 = TestDataFactory_tst.createTakedownForecast(opp, currentUser, 'Funded');
            
            TBO020_Takedowns__c takedownForecast3 = TestDataFactory_tst.createTakedownForecast(opp2, currentUser, 'Funded');
            
            TBO001_AccountClassification__c accClass = TestDataFactory_tst.createAccountClassification(accnt, 'Tier Three');
            
            opp.OPP_ls_Line_of_Business__c = 'Technology';
            
            update opp;
            
            takedownForecast.TBO020_ls_Line_of_Business__c = 'Technology';
            
            update takedownForecast;
            
            accClass.TBO001_ls_Line_of_Business__c = 'Technology';
            
            update accClass;
            
            delete accClass;
        }
        
        test.stopTest();
    }
    
    static testMethod void test_CustomerSince_AccountYearGreater () {
    	test.startTest();
        
 		User currentUser = TestDataFactory_tst.createUser('test@engenium.com', 'Generic', 'Sales Rep - México 1');
        
        System.runAs(currentUser) { 
            Account accnt = TestDataFactory_tst.createAccount();
            
            accnt.ACC_tx_Customer_Since__c = '2015';
            
            update accnt;
            
            TBO023_Customer_Since__c customerSince = TestDataFactory_tst.createCustomerSince(accnt, '2013');
            
            TBO001_AccountClassification__c accClass = TestDataFactory_tst.createAccountClassification(accnt, 'Tier Three');
            
            customerSince.TBO023_ls_Line_Of_Business__c = 'Technology';
            customerSince.TBO023_tx_Customer_since__c = '2012';
            
            update customerSince;
            
            accClass.TBO001_ls_Line_of_Business__c = 'Technology';
            
            update accClass;
            
            delete accClass;
        }
        
        test.stopTest();
    }
    
    static testMethod void test_NoCustomerSince_Account () {
    	test.startTest();
        
 		User currentUser = TestDataFactory_tst.createUser('test@engenium.com', 'Generic', 'Sales Rep - México 1');
        
        System.runAs(currentUser) { 
            Account accnt = TestDataFactory_tst.createAccount();
            
            TBO001_AccountClassification__c accClass = TestDataFactory_tst.createAccountClassification(accnt, 'Tier Three');
            
            TBO023_Customer_Since__c customerSince = TestDataFactory_tst.createCustomerSince(accnt, '2013');
            
            customerSince.TBO023_ls_Line_Of_Business__c = 'Technology';
            
            update customerSince;
            
            accClass.TBO001_ls_Line_of_Business__c = 'Technology';
            
            update accClass;
            
            delete accClass;
        }
        
        test.stopTest();
    }
    
    static testMethod void test_NoCustomerSince () {
    	test.startTest();
        
 		User currentUser = TestDataFactory_tst.createUser('test@engenium.com', 'Generic', 'Sales Rep - México 1');
        
        System.runAs(currentUser) { 
            Account accnt = TestDataFactory_tst.createAccount();
            
            TBO001_AccountClassification__c accClass = TestDataFactory_tst.createAccountClassification(accnt, 'Tier Three');     
            
            accClass.TBO001_ls_Line_of_Business__c = 'Technology';
            
            update accClass;  
            
            delete accClass;
        }
        
        test.stopTest();
    }
    
    static testMethod void test_DeleteAccClass () {
        Account accnt1 = TestDataFactory_tst.createAccount('Prueba 1', '1');
        Account accnt2 = TestDataFactory_tst.createAccount('Prueba 2', '2');
            
        List<TBO001_AccountClassification__c> accClassUpdtList = new List<TBO001_AccountClassification__c>();
        
        TBO001_AccountClassification__c acc1accClass1 = TestDataFactory_tst.createAccountClassification(accnt1, 'Tier Three'); 
        
        acc1accClass1.TBO001_tx_Customer_Since__c = '2016';
        
        accClassUpdtList.add(acc1accClass1);
        
        TBO001_AccountClassification__c acc1accClass2 = TestDataFactory_tst.createAccountClassification(accnt1, 'Tier Two');   
        
        acc1accClass2.TBO001_tx_Customer_Since__c = '2015';
        
        accClassUpdtList.add(acc1accClass2);
        
        TBO001_AccountClassification__c acc1accClass3 = TestDataFactory_tst.createAccountClassification(accnt1, 'Tier One');  
        
        acc1accClass3.TBO001_tx_Customer_Since__c = '2014';
        
        accClassUpdtList.add(acc1accClass3);
        
        TBO001_AccountClassification__c acc2accClass1 = TestDataFactory_tst.createAccountClassification(accnt2, 'Tier Three');    
        
        acc2accClass1.TBO001_tx_Customer_Since__c = '2014';
        
        accClassUpdtList.add(acc2accClass1);   
        
        update accClassUpdtList;  
        
        List<TBO001_AccountClassification__c> accClassDelList = new List<TBO001_AccountClassification__c>();
        accClassDelList.add(acc1accClass1);
        accClassDelList.add(acc2accClass1);
        
        test.startTest();
        
        delete accClassDelList;
        
        test.stopTest();
    }
    
    static testMethod void test_AccountStatus() {
        User currentUser = TestDataFactory_tst.createUser('test1@engenium.com', 'Generic', 'Sales Rep - México 1');
        User otherUser = TestDataFactory_tst.createUser('test2@engenium.com', 'Generic', 'Sales Rep - México 2');
        
        System.runAs(currentUser) { 
            Account_Status_Rules_Matrix__c rule = TestDataFactory_tst.createAccountStatusRulesMatrix('Prospect', 'Prospect');
            Account accntTopParent = TestDataFactory_tst.createAccount('Test Top Parent', '1');
            Account accnt = TestDataFactory_tst.createAccount('Test Child', '2');
                        
            accnt.ACC_rb_Top_Parent_Account__c = accntTopParent.Id;
            
            update accnt;
            
            TBO001_AccountClassification__c accClass = TestDataFactory_tst.createAccountClassification(accnt, 'Tier One');
            
            test.startTest();
            
            update accClass;
            
            test.stopTest();
        }
    }
}