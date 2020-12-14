@Istest
private class Data_Access_WOS_IST_PQ_ExpenseFe_Test {
     @testSetup static void setup(){
        //creation of EIV parameters
        list<EIV_Parameter__c> parameters = Test.loadData(EIV_Parameter__c.sobjectType, 'parametrosTest');
        System.assert(parameters.size()>0);
    }
	@Istest
    static void getExpense_FeeByPQTest(){
        Opportunity opp = Data_Factory_Opportunity_Test.createNewOpportunityTypeWK();
        TBO021_Takedowns_forecast__c forecast = Data_Factory_EasyForecast_Test.createForecast(opp.Id);
        IST__SuperTRUMP_Template__c template = TestDataFactory_tst.createSTPricingTemplate();
        IST__SuperTRUMP_Pricing_Quote__c pq = TestDataFactory_tst.createSTPricingQuote(opp,template);
        IST__SuperTRUMP_PQ_Expense_Fee__c expenseFee = Data_Factory_IST_SuperTrump_Expense_Fee.createExpenseFee(pq.Id);
        Data_Access_WOS_IST_SP_PQ_Expense_Fee.getExpense_FeeByPQ(pq.Id);
    }
}