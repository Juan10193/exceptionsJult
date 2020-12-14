@isTest
public class TSK_tgr_UpdateDates_tst {
	public static testMethod void testLastCallDate() {
    	User currentUser = TestDataFactory_tst.createUser('test@engenium.com', 'Generic', 'Sales Rep 1');
        
        System.runAs(currentUser) {
            test.startTest();
            
            Account accnt = TestDataFactory_tst.createAccount();
            
            Contact contact = TestDataFactory_tst.createContact(accnt);
            
            Task tsk1 = TestDataFactory_tst.createTask(contact, accnt, 'Not Started', 'x', 'Call');
            Task tsk2 = TestDataFactory_tst.createTask(contact, accnt, 'Not Started', 'x', 'Call');
            
            Date activityDate1 = tsk1.ActivityDate;
            activityDate1 = activityDate1.addDays(-5);
            tsk1.ActivityDate = activityDate1;
            
            update tsk1;
            
            Date activityDate2 = tsk2.ActivityDate;
            activityDate2 = activityDate2.addDays(-10);
            tsk2.ActivityDate = activityDate2;
            
            update tsk2;
            
            delete tsk1;
            
            delete tsk2;
            
            test.stopTest();
        }
    }
}