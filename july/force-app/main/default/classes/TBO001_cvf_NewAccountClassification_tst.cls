@isTest
public class TBO001_cvf_NewAccountClassification_tst {
	static testMethod void testCancel () {
        test.startTest();
        
 		User currentUser = TestDataFactory_tst.createUser('test@engenium.com', 'Administrator', 'Sales Rep 1');
        
        System.runAs(currentUser) { 
            Account accnt = TestDataFactory_tst.createAccount();
            
            PageReference newAccountClassificationPg = new PageReference('/apex/TBO001_pvf_NewAccountClassification');
            newAccountClassificationPg.getParameters().put('Id', accnt.Id);
            
            TBO001_cvf_NewAccountClassification newAccountClassificationCtrl = new TBO001_cvf_NewAccountClassification();
            
            PageReference rtrnPage = newAccountClassificationCtrl.btnCancel();
        }
        
        test.stopTest();
    }
    
	static testMethod void testNoTier () {
        test.startTest();
        
 		User currentUser = TestDataFactory_tst.createUser('test@engenium.com', 'Administrator', 'Sales Rep 1');
        
        System.runAs(currentUser) { 
            Account accnt = TestDataFactory_tst.createAccount();
            
            PageReference newAccountClassificationPg = new PageReference('/apex/TBO001_pvf_NewAccountClassification');
            newAccountClassificationPg.getParameters().put('Id', accnt.Id);
            
            TBO001_cvf_NewAccountClassification newAccountClassificationCtrl = new TBO001_cvf_NewAccountClassification();
            
            PageReference rtrnPage = newAccountClassificationCtrl.btnSave();
        }
        
        test.stopTest();
    }
    
    static testMethod void testNoLineBusiness () {
        test.startTest();
        
 		User currentUser = TestDataFactory_tst.createUser('test@engenium.com', 'Administrator', 'Sales Rep 1');
        
        System.runAs(currentUser) { 
            Account accnt = TestDataFactory_tst.createAccount();
            
            PageReference newAccountClassificationPg = new PageReference('/apex/TBO001_pvf_NewAccountClassification');
            newAccountClassificationPg.getParameters().put('Id', accnt.Id);
            
            TBO001_cvf_NewAccountClassification newAccountClassificationCtrl = new TBO001_cvf_NewAccountClassification();
            newAccountClassificationCtrl.accountClassification.TBO001_ls_Tier__c = 'Tier Four';
            
            newAccountClassificationCtrl.setTier();
            
            PageReference rtrnPage = newAccountClassificationCtrl.btnSave();
        }
        
        test.stopTest();
    }
    
    static testMethod void testNoCompanyRank () {
        test.startTest();
        
 		User currentUser = TestDataFactory_tst.createUser('test@engenium.com', 'Administrator', 'Sales Rep 1');
        
        System.runAs(currentUser) { 
            Account accnt = TestDataFactory_tst.createAccount();
            
            PageReference newAccountClassificationPg = new PageReference('/apex/TBO001_pvf_NewAccountClassification');
            newAccountClassificationPg.getParameters().put('Id', accnt.Id);
            
            TBO001_cvf_NewAccountClassification newAccountClassificationCtrl = new TBO001_cvf_NewAccountClassification();
            newAccountClassificationCtrl.accountClassification.TBO001_ls_Tier__c = 'Tier Three';
            
            newAccountClassificationCtrl.setTier();
            
            newAccountClassificationCtrl.accountClassification.TBO001_ls_Line_of_Business__c = 'Equipment';
            
            PageReference rtrnPage = newAccountClassificationCtrl.btnSave();
        }
        
        test.stopTest();
    }
    
    static testMethod void testTierFourWithException () {
        test.startTest();
        
        User currentUser = TestDataFactory_tst.createUser('test@engenium.com', 'Administrator', 'Sales Rep 1');
        
        System.runAs(currentUser) { 
            Account accnt = TestDataFactory_tst.createAccount();
            
            TBO001_AccountClassification__c accClassTierOne = TestDataFactory_tst.createAccountClassification(accnt, 'Tier One');
            
            PageReference newAccountClassificationPg = new PageReference('/apex/TBO001_pvf_NewAccountClassification');
            newAccountClassificationPg.getParameters().put('Id', accnt.Id);
            
            TBO001_cvf_NewAccountClassification newAccountClassificationCtrl = new TBO001_cvf_NewAccountClassification();
            newAccountClassificationCtrl.accountClassification.TBO001_ls_Tier__c = 'Tier Four';
            
            newAccountClassificationCtrl.setTier();
            
            newAccountClassificationCtrl.accountClassification.TBO001_ls_Line_of_Business__c = 'Equipment';
            
            PageReference rtrnPage = newAccountClassificationCtrl.btnSave();
        }
        
        test.stopTest();
    }
    
    static testMethod void testTierFour () {
        test.startTest(); 
        
        User currentUser = TestDataFactory_tst.createUser('test@engenium.com', 'Administrator', 'Sales Rep 1');
        
        System.runAs(currentUser) { 
            Account accnt = TestDataFactory_tst.createAccount();
            
            TBO001_AccountClassification__c accClassTierOne = TestDataFactory_tst.createAccountClassification(accnt, 'Tier One');
            
            PageReference newAccountClassificationPg = new PageReference('/apex/TBO001_pvf_NewAccountClassification');
            newAccountClassificationPg.getParameters().put('Id', accnt.Id);
            
            TBO001_cvf_NewAccountClassification newAccountClassificationCtrl = new TBO001_cvf_NewAccountClassification();
            newAccountClassificationCtrl.accountClassification.TBO001_rb_Account__c = accnt.Id;
            newAccountClassificationCtrl.accountClassification.TBO001_ls_Tier__c = 'Tier Four';
            
            newAccountClassificationCtrl.setTier();
            
            newAccountClassificationCtrl.accountClassification.TBO001_ls_Line_of_Business__c = 'Equipment';
            
            PageReference rtrnPage = newAccountClassificationCtrl.btnSave();
        }
        
        test.stopTest();
    }
}