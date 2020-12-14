@isTest
public class TBO001_ext_UpdtAccountClassification_tst {
	static testMethod void testCancel () {
    	test.startTest();
        
 		User currentUser = TestDataFactory_tst.createUser('test@engenium.com', 'Generic', 'Sales Rep 1');
        
        System.runAs(currentUser) { 
            Account accnt = TestDataFactory_tst.createAccount();
            
            TBO001_AccountClassification__c accClassTierOne = TestDataFactory_tst.createAccountClassification(accnt, 'Tier One');
            
            ApexPages.StandardController standardCtrl = new ApexPages.StandardController(accClassTierOne);
            
            TBO001_ext_UpdateAccountClassification updateAccountClassificationCtrl = new TBO001_ext_UpdateAccountClassification(standardCtrl);
            
            PageReference rtrnPage = updateAccountClassificationCtrl.btnCancel();
        }
        
        test.stopTest();
    }
    
    static testMethod void testNoTier () {
        test.startTest();
        
 		User currentUser = TestDataFactory_tst.createUser('test@engenium.com', 'Generic', 'Sales Rep 1');
        
        System.runAs(currentUser) { 
            Account accnt = TestDataFactory_tst.createAccount();
            
            TBO001_AccountClassification__c accClassTierOne = TestDataFactory_tst.createAccountClassification(accnt, 'Tier One');
            
            ApexPages.StandardController standardCtrl = new ApexPages.StandardController(accClassTierOne);
            
            TBO001_ext_UpdateAccountClassification updateAccountClassificationCtrl = new TBO001_ext_UpdateAccountClassification(standardCtrl);
            updateAccountClassificationCtrl.accountClassification.TBO001_ls_Tier__c = null;
            
            PageReference rtrnPage = updateAccountClassificationCtrl.btnSave();
        }
        
        test.stopTest();
    }
    
    static testMethod void testNoLineBusiness () {
        test.startTest();
        
 		User currentUser = TestDataFactory_tst.createUser('test@engenium.com', 'Generic', 'Sales Rep 1');
        
        System.runAs(currentUser) { 
            Account accnt = TestDataFactory_tst.createAccount();
            
            TBO001_AccountClassification__c accClassTierOne = TestDataFactory_tst.createAccountClassification(accnt, 'Tier One');
            
            ApexPages.StandardController standardCtrl = new ApexPages.StandardController(accClassTierOne);
            
            TBO001_ext_UpdateAccountClassification updateAccountClassificationCtrl = new TBO001_ext_UpdateAccountClassification(standardCtrl);
            updateAccountClassificationCtrl.accountClassification.TBO001_ls_Line_of_Business__c = null;
            
            updateAccountClassificationCtrl.setTier();
            
            PageReference rtrnPage = updateAccountClassificationCtrl.btnSave();
        }
        
        test.stopTest();
    }
    
    static testMethod void testNoCompanyRank () {
        test.startTest();
        
 		User currentUser = TestDataFactory_tst.createUser('test@engenium.com', 'Generic', 'Sales Rep 1');
        
        System.runAs(currentUser) { 
            Account accnt = TestDataFactory_tst.createAccount();
            
            TBO001_AccountClassification__c accClassTierOne = TestDataFactory_tst.createAccountClassification(accnt, 'Tier One');
            
            ApexPages.StandardController standardCtrl = new ApexPages.StandardController(accClassTierOne);
            
            TBO001_ext_UpdateAccountClassification updateAccountClassificationCtrl = new TBO001_ext_UpdateAccountClassification(standardCtrl);
            updateAccountClassificationCtrl.accountClassification.TBO001_ls_Tier__c = 'Tier Three';
            
            updateAccountClassificationCtrl.setTier();
            
            PageReference rtrnPage = updateAccountClassificationCtrl.btnSave();
        }
        
        test.stopTest();
    }
    
    static testMethod void testTierFour () {
        test.startTest();
        
 		User currentUser = TestDataFactory_tst.createUser('test@engenium.com', 'Generic', 'Sales Rep 1');
        
        System.runAs(currentUser) { 
            Account accnt = TestDataFactory_tst.createAccount();
            
            TBO001_AccountClassification__c accClassTierFour = TestDataFactory_tst.createAccountClassification(accnt, 'Tier Four');
            
            ApexPages.StandardController standardCtrl = new ApexPages.StandardController(accClassTierFour);
            
            TBO001_ext_UpdateAccountClassification updateAccountClassificationCtrl = new TBO001_ext_UpdateAccountClassification(standardCtrl);
            
            updateAccountClassificationCtrl.setTier();
            
            PageReference rtrnPage = updateAccountClassificationCtrl.btnSave();
        }
        
        test.stopTest();
    }
}