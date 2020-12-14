@isTest
public class UpdateActivityDates_Schedule_tst {
	static testMethod void testScheduleLastMeetingDate () {
    	Account accnt = TestDataFactory_tst.createAccount();
         
        Contact contact = TestDataFactory_tst.createContact();
        
        Event evnt = TestDataFactory_tst.createEvent(contact, accnt);
        
        Task tsk = TestDataFactory_tst.createTask(contact, accnt, 'Not Started', 'x', 'Call');
        
        Date activityDate = tsk.ActivityDate;
        activityDate = activityDate.addDays(4);
        tsk.ActivityDate = activityDate;
        
        update tsk;
        
        test.startTest();
        
        UpdateActivityDates_Schedule schUpdtActivityDates = new UpdateActivityDates_Schedule();
        String schTime = '0 0 0 * * ?';
        System.schedule('Update Activity Dates', schTime, schUpdtActivityDates);
        
        test.stopTest();
    }
    
    /**
	static testMethod void testScheduleLastCallDate () {
    	Account accnt = TestDataFactory_tst.createAccount();
         
        Contact contact = TestDataFactory_tst.createContact();
        
        Task tsk = TestDataFactory_tst.createTask(contact, accnt, 'Not Started', 'x', 'Call');
        
        Date activityDate = tsk.ActivityDate;
        activityDate = activityDate.addDays(4);
        tsk.ActivityDate = activityDate;
        
        update tsk;
        
        test.startTest();
        
        UpdateLastCallDate_Schedule schUpdtLastCallDate = new UpdateLastCallDate_Schedule();
        String schTime = '0 0 0 * * ?';
        System.schedule('Update Last Call Date', schTime, schUpdtLastCallDate);
        
        test.stopTest();
    }
	*/
}