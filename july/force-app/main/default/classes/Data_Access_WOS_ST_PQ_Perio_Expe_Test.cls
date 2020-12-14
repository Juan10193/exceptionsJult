@Istest
private class Data_Access_WOS_ST_PQ_Perio_Expe_Test {
	@Istest
    static void getAllFieldsBySetIDTest(){
        Opportunity opp = Data_Factory_Opportunity_Test.createNewOpportunityTypeWK();
        TBO021_Takedowns_forecast__c forecast = Data_Factory_EasyForecast_Test.createForecast(opp.Id);
        IST__SuperTRUMP_Template__c template = TestDataFactory_tst.createSTPricingTemplate();
        IST__SuperTRUMP_Pricing_Quote__c pq = TestDataFactory_tst.createSTPricingQuote(opp,template);
        ST_PQ_Periodic_Expense__c priodicExpense = Data_Factory_ST_PQ_PeriodicExpense_Test.createSTPQPeriodicExpense(pq.Id);
        set<Id>periodicExpenseIds = new set<Id>();
        periodicExpenseIds.add(priodicExpense.Id);
        Data_Access_WOS_ST_PQ_Perio_Expe_cls.getAllFieldsBySetID(periodicExpenseIds);
    }
}