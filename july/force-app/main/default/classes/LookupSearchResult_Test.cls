@isTest
public class LookupSearchResult_Test {
    @isTest
    public static void LookupSearchResult(){ 
        id Test_Id;
        string Test_SObjectType;
        string Test_Icon;
        string Test_Title;
        string Test_Subtitle; 
        LookupSearchResult Test = new LookupSearchResult(Test_Id, Test_SObjectType, Test_Icon, Test_Title, Test_Subtitle);
        Test.getId();
        Test.getSObjectType();
        Test.getIcon();
        Test.getTitle();
        Test.getSubtitle();
    }
}