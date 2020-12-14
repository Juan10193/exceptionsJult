@Istest
private class ST_PQ_Perio_Expe_Parse_Test {
	@Istest
    static void dropDataIntoWrapper(){
        Opportunity opp = Data_Factory_Opportunity_Test.createNewOpportunityTypeWK();
        TBO021_Takedowns_forecast__c forecast = Data_Factory_EasyForecast_Test.createForecast(opp.Id);
        IST__SuperTRUMP_Template__c template = TestDataFactory_tst.createSTPricingTemplate();
        IST__SuperTRUMP_Pricing_Quote__c pq = TestDataFactory_tst.createSTPricingQuote(opp,template);
        ST_PQ_Periodic_Expense__c periodicExpense = Data_Factory_ST_PQ_PeriodicExpense_Test.createSTPQPeriodicExpense(pq.Id);
        ST_PQ_Perio_Expe_Parse_cls.dropDataIntoWrapper(periodicExpense);
    }
    
    @Istest
    static void getlist_ST_PQ_Periodic_Expense_CFS_Wrapper(){
        Opportunity opp = Data_Factory_Opportunity_Test.createNewOpportunityTypeWK();
        TBO021_Takedowns_forecast__c forecast = Data_Factory_EasyForecast_Test.createForecast(opp.Id);
        IST__SuperTRUMP_Template__c template = TestDataFactory_tst.createSTPricingTemplate();
        IST__SuperTRUMP_Pricing_Quote__c pq = TestDataFactory_tst.createSTPricingQuote(opp,template);
        ST_PQ_Periodic_Expense__c periodicExpense = Data_Factory_ST_PQ_PeriodicExpense_Test.createSTPQPeriodicExpense(pq.Id);
        ST_PQ_Periodic_Expense_Cash_Flow_Step__c periodicExpenseCashFlowStep = Data_Factory_PeriodExpseCshFlwStp_Test.createSTPQPeriodicExpenseCashFlowStep(periodicExpense.Id);
        list<ST_PQ_Periodic_Expense_Cash_Flow_Step__c> periodicExpenseCashFlowSteps = new list<ST_PQ_Periodic_Expense_Cash_Flow_Step__c>();
        periodicExpenseCashFlowSteps.add(periodicExpenseCashFlowStep);
        ST_PQ_Perio_Expe_Parse_cls.getlist_ST_PQ_Periodic_Expense_CFS_Wrapper(periodicExpenseCashFlowSteps);
    }
}