@isTest
public class EVT_tgr_UpdateDates_tst {
	public static testMethod void testLastMeetingDate() {
    	User currentUser = TestDataFactory_tst.createUser('test@engenium.com', 'Generic', 'Sales Rep 1');
        
        System.runAs(currentUser) {
            test.startTest();
            
            Account accnt = TestDataFactory_tst.createAccount();
            
            Contact contact = TestDataFactory_tst.createContact(accnt);
            
            Event evt1 = TestDataFactory_tst.createEvent(contact, accnt);
            Event evt2 = TestDataFactory_tst.createEvent(contact, accnt);
            
            DateTime endDateTime1 = evt1.EndDateTime;
            endDateTime1 = endDateTime1.addDays(-5);
            evt1.StartDateTime = endDateTime1;
            evt1.EndDateTime = endDateTime1;
            
            update evt1;
            
            DateTime endDateTime2 = evt2.EndDateTime;
            endDateTime2 = endDateTime2.addDays(-10);
            evt2.StartDateTime = endDateTime2;
            evt2.EndDateTime = endDateTime2;
            
            update evt2;
            
            delete evt1;
            
            delete evt2;
            
            test.stopTest();
        }
    }
}