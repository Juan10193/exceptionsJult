@isTest
public with sharing class CON_tgr_UpdateContactDate_tst {
	private static testmethod void testCompletedActivityInsert() {
    	Test.startTest();
        
        Account accnt = TestDataFactory_tst.createAccount();
        Contact contact = TestDataFactory_tst.createContact();
        Task task = TestDataFactory_tst.createTask(contact, accnt, 'Completed', 'Other', 'To Do');
        
        Test.stopTest();
    }
    
    private static testmethod void testCompletedActivityUpdate() {
    	Test.startTest();
        
        Account accnt = TestDataFactory_tst.createAccount();
        Contact contact = TestDataFactory_tst.createContact();
        Task task = TestDataFactory_tst.createTask(contact, accnt, 'In Progress', 'Other', 'To Do');
        
        task.Status = 'Completed';
        
        update task;
        
        Test.stopTest();
    }
    
    private static testmethod void testCallActivityInsert() {
    	Test.startTest();
        
        Account accnt = TestDataFactory_tst.createAccount();
        Contact contact = TestDataFactory_tst.createContact();
        Task task = TestDataFactory_tst.createTask(contact, accnt, 'In Progress', 'Call', 'Call');
        
        Test.stopTest();
    }
    
    private static testmethod void testCallActivityUpdate() {
    	Test.startTest();
        
        Account accnt = TestDataFactory_tst.createAccount();
        Contact contact = TestDataFactory_tst.createContact();
        Task task = TestDataFactory_tst.createTask(contact, accnt, 'In Progress', 'Other', 'To Do');
        
        task.Subject = 'Call';
        task.Type = 'Call';
        
        update task;
        
        Test.stopTest();
    }
}