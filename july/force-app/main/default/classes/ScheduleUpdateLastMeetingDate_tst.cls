@isTest
public class ScheduleUpdateLastMeetingDate_tst {
	static testMethod void testLastMeetingDate () {
    	Account accnt = TestDataFactory_tst.createAccount();
         
        Contact contact = TestDataFactory_tst.createContact();
        
        Event evnt = TestDataFactory_tst.createEvent(contact, accnt);
        
        test.startTest();
        
        ScheduleUpdateLastMeetingDate_batch schUpdtLMD = new ScheduleUpdateLastMeetingDate_batch();
        String schTime = '0 0 0 * * ?';
        System.schedule('Update Last Meeting Date', schTime, schUpdtLMD);
        
        test.stopTest();
    }
}