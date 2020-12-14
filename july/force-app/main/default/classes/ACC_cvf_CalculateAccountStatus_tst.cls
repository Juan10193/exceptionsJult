@isTest(seeAllData = false)
public class ACC_cvf_CalculateAccountStatus_tst {
	static testMethod void test () {
        
        User currentUser = TestDataFactory_tst.createUser('test1@engenium.com', 'Generic', 'Sales Rep - México 1');
        User otherUser = TestDataFactory_tst.createUser('test2@engenium.com', 'Generic', 'Sales Rep - México 2');
        
        System.runAs(currentUser) { 
            Account_Status_Rules_Matrix__c rule = TestDataFactory_tst.createAccountStatusRulesMatrix('Prospect', 'Prospect');
            Account accntTopParent = TestDataFactory_tst.createAccount('Test Top Parent', '1');
            Account accnt = TestDataFactory_tst.createAccount('Test Child', '2');
                        
            accnt.ACC_rb_Top_Parent_Account__c = accntTopParent.Id;
            
            update accnt;
            
            TBO001_AccountClassification__c accTPAClass = TestDataFactory_tst.createAccountClassification(accntTopParent, 'Tier One');
            TBO001_AccountClassification__c accCHAClass = TestDataFactory_tst.createAccountClassification(accnt, 'Tier One');
            
            test.startTest();
            
            ACC_cvf_CalculateAccountStatus calculateAccountStatusCtrl = new ACC_cvf_CalculateAccountStatus();
            
            PageReference refresh = calculateAccountStatusCtrl.doCalculate();
            
            test.stopTest();
        }
    }
}