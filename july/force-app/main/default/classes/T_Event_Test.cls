@IsTest 
public class T_Event_Test {
	@isTest static void test_method_one() {
        Contact con = new Contact(LastName ='testCon', Email = 'test@test.com');
        insert con;  
        Event e = new Event();
        e.WhoId=con.id;
        e.Type = 'Meeting';
        e.StartDateTime=system.today();
        e.EndDateTime=system.today()+5; 
        insert e; 
    }
}