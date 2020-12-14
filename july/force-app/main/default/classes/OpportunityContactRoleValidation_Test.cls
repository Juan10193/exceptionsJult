@isTest
public class OpportunityContactRoleValidation_Test {
    
     @isTest
    public static void OpportunityContactRoleValidation(){
        
        Opportunity opp = Data_Factory_Opportunity_Test.createNewOpportunityTypeSales(); 
    }
    
    @isTest
    public static void getvalidateContactRole(){
        
        Opportunity opp = Data_Factory_Opportunity_Test.createNewOpportunityTypeSales(); 
        test.startTest();
        test.stopTest();
    }

}