@Istest
private class ST_PQ_Perio_Inco_Parse_Test {
	@Istest
    static void dropDataIntoWrapperTest(){
        Opportunity opp = Data_Factory_Opportunity_Test.createNewOpportunityTypeWK();
        TBO021_Takedowns_forecast__c forecast = Data_Factory_EasyForecast_Test.createForecast(opp.Id);
        IST__SuperTRUMP_Template__c template = TestDataFactory_tst.createSTPricingTemplate();
        IST__SuperTRUMP_Pricing_Quote__c pq = TestDataFactory_tst.createSTPricingQuote(opp,template);
        ST_PQ_Periodic_Income__c periodicInCome = Data_Factory_ST_PQ_PeriodicIncome_Test.createST_PQ_Periodic_Income(pq.Id);
        ST_PQ_Perio_Inco_Parse_cls.dropDataIntoWrapper(periodicInCome);
    }
    
    @Istest 
    static void getlist_ST_PQ_Periodic_Income_CFS_WrapperTest(){
        Opportunity opp = Data_Factory_Opportunity_Test.createNewOpportunityTypeWK();
        TBO021_Takedowns_forecast__c forecast = Data_Factory_EasyForecast_Test.createForecast(opp.Id);
        IST__SuperTRUMP_Template__c template = TestDataFactory_tst.createSTPricingTemplate();
        IST__SuperTRUMP_Pricing_Quote__c pq = TestDataFactory_tst.createSTPricingQuote(opp,template);
        ST_PQ_Periodic_Income__c periodicInCome = Data_Factory_ST_PQ_PeriodicIncome_Test.createST_PQ_Periodic_Income(pq.Id);
        ST_PQ_Periodic_Income_Cash_Flow_Step__c periodicIncomeCashFlowStep = Data_Factory_PeriodicIncmCashFlwStepTest.createST_PQPeriodicIncomeCashFlowStep(periodicInCome.Id);
        list<ST_PQ_Periodic_Income_Cash_Flow_Step__c> periodicIncomeCashFlowSteps = new list<ST_PQ_Periodic_Income_Cash_Flow_Step__c>();
        periodicIncomeCashFlowSteps.add(periodicIncomeCashFlowStep);
        ST_PQ_Perio_Inco_Parse_cls.getlist_ST_PQ_Periodic_Income_CFS_Wrapper(periodicIncomeCashFlowSteps);
    }
}