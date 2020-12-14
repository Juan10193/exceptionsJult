@isTest
public class TBO007_ext_UpdateAccountPlan_tst {
	public static testMethod void testCancel() {
    	test.startTest();
        
        User currentUser = TestDataFactory_tst.createUser('test@engenium.com', 'Generic', 'Sales Rep 1');
        
        System.runAs(currentUser) { 
            Account accnt = TestDataFactory_tst.createAccount();
            
            Contact contact = TestDataFactory_tst.createContact(accnt);
            
            TBO007_Account_Plan__c accountPlan = TestDataFactory_tst.createAccountPlan(accnt);
            
            ApexPages.StandardController sc = new ApexPages.StandardController(accountPlan);
            
            TBO007_ext_UpdateAccountPlan updateAccountPlanCtrl = new TBO007_ext_UpdateAccountPlan(sc);

            PageReference updateAccountPlanPg = Page.TBO007_pvf_UpdateAccountPlan;
            Test.setCurrentPage(updateAccountPlanPg);
            
            PageReference rtrnPage = updateAccountPlanCtrl.btnCancel();
        }
        
        test.stopTest();
    }
    
	public static testMethod void testAccountPlanError() {
    	test.startTest();
        
        User currentUser = TestDataFactory_tst.createUser('test@engenium.com', 'Generic', 'Sales Rep 1');
        
        System.runAs(currentUser) { 
            Account accnt = TestDataFactory_tst.createAccount();
            
            Contact contact = TestDataFactory_tst.createContact(accnt);
            
            TBO007_Account_Plan__c accountPlan = TestDataFactory_tst.createAccountPlan(accnt);
            
            ApexPages.StandardController sc = new ApexPages.StandardController(accountPlan);
            
            TBO007_ext_UpdateAccountPlan updateAccountPlanCtrl = new TBO007_ext_UpdateAccountPlan(sc);

            PageReference updateAccountPlanPg = Page.TBO007_pvf_UpdateAccountPlan;
            Test.setCurrentPage(updateAccountPlanPg);
            
            updateAccountPlanCtrl.accountPlan.TBO007_un_Expected_Volume_CapEx__c = null;
            
            PageReference rtrnPage = updateAccountPlanCtrl.btnSave();
        }
        
        test.stopTest();
    }
    
	public static testMethod void testAccountException() {
    	test.startTest();
        
        User currentUser = TestDataFactory_tst.createUser('test@engenium.com', 'Generic', 'Sales Rep 1');
        
        System.runAs(currentUser) {             
            TBO007_Account_Plan__c accountPlan = TestDataFactory_tst.createAccountPlan(null);
            
            ApexPages.StandardController sc = new ApexPages.StandardController(accountPlan);
            
            TBO007_ext_UpdateAccountPlan updateAccountPlanCtrl = new TBO007_ext_UpdateAccountPlan(sc);

            PageReference updateAccountPlanPg = Page.TBO007_pvf_UpdateAccountPlan;
            Test.setCurrentPage(updateAccountPlanPg);
            
            PageReference rtrnPage = updateAccountPlanCtrl.btnSave();
        }
        
        test.stopTest();
    }
    
	public static testMethod void testContactException() {
    	test.startTest();
        
        User currentUser = TestDataFactory_tst.createUser('test@engenium.com', 'Generic', 'Sales Rep 1');
        
        System.runAs(currentUser) {             
            Account accnt = TestDataFactory_tst.createAccount();
            
            TBO007_Account_Plan__c accountPlan = TestDataFactory_tst.createAccountPlan(accnt); 
            
            ApexPages.StandardController sc = new ApexPages.StandardController(accountPlan);
            
            TBO007_ext_UpdateAccountPlan updateAccountPlanCtrl = new TBO007_ext_UpdateAccountPlan(sc);

            PageReference updateAccountPlanPg = Page.TBO007_pvf_UpdateAccountPlan;
            Test.setCurrentPage(updateAccountPlanPg);
            
            PageReference rtrnPage = updateAccountPlanCtrl.btnSave();
        }
        
        test.stopTest();
    }
    
	public static testMethod void testSave() {
    	test.startTest();
        
        User currentUser = TestDataFactory_tst.createUser('test@engenium.com', 'Generic', 'Sales Rep 1');
        
        System.runAs(currentUser) {             
            Account accnt = TestDataFactory_tst.createAccount();
            
            Contact contact = TestDataFactory_tst.createContact(accnt);
            
            TBO007_Account_Plan__c accountPlan = TestDataFactory_tst.createAccountPlan(accnt); 
            
            ApexPages.StandardController sc = new ApexPages.StandardController(accountPlan);
            
            TBO007_ext_UpdateAccountPlan updateAccountPlanCtrl = new TBO007_ext_UpdateAccountPlan(sc);

            PageReference updateAccountPlanPg = Page.TBO007_pvf_UpdateAccountPlan;
            Test.setCurrentPage(updateAccountPlanPg);
            
            PageReference rtrnPage = updateAccountPlanCtrl.btnSave();
        }
        
        test.stopTest();
    }
}