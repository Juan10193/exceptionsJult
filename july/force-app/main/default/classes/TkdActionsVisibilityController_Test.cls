@isTest
public class TkdActionsVisibilityController_Test {
	@isTest
    public static void getVisibility(){
        Opportunity opp = Data_Factory_Opportunity_Test.createNewOpportunityTypeSales();
        list<id> Test_item = new list<id>();
        Test_item.add(opp.id);
        TkdActionsVisibilityController.getVisibility(Test_item);
    }
    @isTest
    public static void getWorkingItemByUserId(){
         Opportunity opp = Data_Factory_Opportunity_Test.createNewOpportunityTypeSales();
         list<id> Test_item = new list<id>();
         Test_item.add(opp.id);
         TkdActionsVisibilityController.getWorkingItemByUserId(Test_item);
    }
    @isTest
    public static void NoAdmingetVisibility(){
         Profile p = [SELECT Id FROM Profile WHERE Name='Generic']; 
         User u = new User(Alias = 'standt', Email='standarduser@testorgkl.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@testorgkl.com.test.eng');
        System.runAs(u) {
        	Opportunity opp = Data_Factory_Opportunity_Test.createNewOpportunityTypeSales();
        	list<id> Test_item = new list<id>();
        	Test_item.add(opp.id);
        	TkdActionsVisibilityController.getVisibility(Test_item);
        }
    }
    @isTest
    public static void NoadmingetWorkingItemByUserId(){
        Profile p = [SELECT Id FROM Profile WHERE Name='Generic']; 
        Group a = new Group();
        a.Name ='Marta';
        insert a;
        
        User u = new User( Alias = 'standt', Email='standarduser@testorgkl.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@testorgkl.com.test.eng');
        insert u;
        GroupMember Gr = new GroupMember();
        Gr.UserOrGroupId = u.id;
        Gr.GroupId = a.Id;
        insert gr;
        System.runAs(u) {
            Opportunity opp = Data_Factory_Opportunity_Test.createNewOpportunityTypeSales();
            list<id> Test_item = new list<id>();
            Test_item.add(opp.id);
            TkdActionsVisibilityController.getWorkingItemByUserId(Test_item);
        }
    }
}