@isTest
public class TBO007_cvf_CreateAccountPlan_tst {
	public static testMethod void testCancel() {
    	test.startTest();
        
        User currentUser = TestDataFactory_tst.createUser('test@engenium.com', 'Generic', 'Sales Rep 1');
        
        System.runAs(currentUser) { 
            Account accnt = TestDataFactory_tst.createAccount();
            
            Contact contact = TestDataFactory_tst.createContact(accnt);
            
            PageReference createAccountPlanPg = new PageReference('/apex/TBO007_pvf_CreateAccountPlan');
            createAccountPlanPg.getParameters().put('account', accnt.Id);
            
            TBO007_cvf_CreateAccountPlan createAccountPlanCtrl = new TBO007_cvf_CreateAccountPlan();
                        
            PageReference rtrnPage = createAccountPlanCtrl.btnCancel();
        }
        
        test.stopTest();
    }
    
	public static testMethod void testPreCallPlanError() {
    	test.startTest();
        
        User currentUser = TestDataFactory_tst.createUser('test@engenium.com', 'Generic', 'Sales Rep 1');
        
        System.runAs(currentUser) { 
            Account accnt = TestDataFactory_tst.createAccount();
            
            Contact contact = TestDataFactory_tst.createContact(accnt);
            
            PageReference createAccountPlanPg = new PageReference('/apex/TBO007_pvf_CreateAccountPlan');
            createAccountPlanPg.getParameters().put('account', accnt.Id);
            
            TBO007_cvf_CreateAccountPlan createAccountPlanCtrl = new TBO007_cvf_CreateAccountPlan();
            createAccountPlanCtrl.account = accnt;
                        
            PageReference rtrnPage = createAccountPlanCtrl.btnSave();
        }
        
        test.stopTest();
    }
    
	public static testMethod void testAccountException() {
    	test.startTest();
        
        User currentUser = TestDataFactory_tst.createUser('test@engenium.com', 'Generic', 'Sales Rep 1');
        
        System.runAs(currentUser) { 
            Account accnt = TestDataFactory_tst.createAccount();
            
            Contact contact = TestDataFactory_tst.createContact(accnt);
            
            PageReference createAccountPlanPg = new PageReference('/apex/TBO007_pvf_CreateAccountPlan');
            createAccountPlanPg.getParameters().put('account', accnt.Id);
            
            TBO007_cvf_CreateAccountPlan createAccountPlanCtrl = new TBO007_cvf_CreateAccountPlan();
            createAccountPlanCtrl.accountPlan.TBO007_un_Expected_Volume_CapEx__c = 10;
                        
            PageReference rtrnPage = createAccountPlanCtrl.btnSave();
        }
        
        test.stopTest();
    }
    
	public static testMethod void testContactException() {
    	test.startTest();
        
        User currentUser = TestDataFactory_tst.createUser('test@engenium.com', 'Generic', 'Sales Rep 1');
        
        System.runAs(currentUser) { 
            Account accnt = TestDataFactory_tst.createAccount();
            
            PageReference createAccountPlanPg = new PageReference('/apex/TBO007_pvf_CreateAccountPlan');
            ApexPages.currentPage().getParameters().put('account', accnt.Id);
            
            TBO007_cvf_CreateAccountPlan createAccountPlanCtrl = new TBO007_cvf_CreateAccountPlan();
            createAccountPlanCtrl.accountPlan.TBO007_un_Expected_Volume_CapEx__c = 10;
                        
            PageReference rtrnPage = createAccountPlanCtrl.btnSave();
        }
        
        test.stopTest();
    }
    
	public static testMethod void testSave() {
    	test.startTest();
        
        User currentUser = TestDataFactory_tst.createUser('test@engenium.com', 'Generic', 'Sales Rep 1');
        
        System.runAs(currentUser) { 
            Account accnt = TestDataFactory_tst.createAccount();
            
            Contact contact = TestDataFactory_tst.createContact(accnt);
            
            PageReference createAccountPlanPg = new PageReference('/apex/TBO007_pvf_CreateAccountPlan');
            ApexPages.currentPage().getParameters().put('account', accnt.Id);
            
            TBO007_cvf_CreateAccountPlan createAccountPlanCtrl = new TBO007_cvf_CreateAccountPlan();
            createAccountPlanCtrl.accountPlan.TBO007_un_Expected_Volume_CapEx__c = 10;
                        
            PageReference rtrnPage = createAccountPlanCtrl.btnSave();
        }
        
        test.stopTest();
    }
}