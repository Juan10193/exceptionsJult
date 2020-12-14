@isTest
public class ContingencyPlanTest {
    static testMethod void testTriggerSumTakedowns() {
        test.startTest();
        User currentUser = TestDataFactory_tst.createUser('test@engenium.com', 'Generic', 'Sales Rep 1');
        
        System.runAs(currentUser) {
            
            Account accnt = TestDataFactory_tst.createAccount();            
            accnt.ACC_dv_Sales_Annual_Revenue__c = 200000000;            
            update accnt;            
            TBO022_Competitor__c competitor = TestDataFactory_tst.createCompetitor();            
            Opportunity opp = TestDataFactory_tst.createOpportunity(accnt, currentUser, competitor);            
            opp.StageName = 'Opportunity Identified';            
            update opp;
            
            Takedowns_Contingency_plan__c tdCPL = new Takedowns_Contingency_plan__c();
            tdCPL.CPL_rb_Opp__c = opp.id;
            insert tdCPL;
            delete tdCPL;            
        }
    }
}