@Istest
private class Data_Access_WOS_ISTSPPricing_Quote_Test {
	@istest
    static void getAllFieldsByIDTest(){
       
        Opportunity opp = Data_Factory_Opportunity_Test.createNewOpportunityTypeWK();
        TBO021_Takedowns_forecast__c forecast = Data_Factory_EasyForecast_Test.createForecast(opp.Id);
        IST__SuperTRUMP_Template__c template = TestDataFactory_tst.createSTPricingTemplate();
        IST__SuperTRUMP_Pricing_Quote__c pq = TestDataFactory_tst.createSTPricingQuote(opp,template);
        Data_Factory_IST_SuperTrump_Expense_Fee.createExpenseFee(pq.Id);
        Data_Factory_SupTRUMPPQIncomeFee_Test.createIncomeFee(pq.Id);
        Data_Factory_IST_SuperTRUMPPQLoan_Test.createSuperTRUMPPQLoan(pq.Id);
        Data_Factory_IST_SuperTRUMPPQRent_Test.createISTSuperTRUMPPQRent(pq.Id);
        Data_Factory_ST_PQ_PeriodicExpense_Test.createSTPQPeriodicExpense(pq.Id);
        Data_Factory_ST_PQ_PeriodicIncome_Test.createST_PQ_Periodic_Income(pq.Id);
        Data_Factory_STPQSpeSecurityDeposit_Test.createSTPQSpecifiedSecurityDeposit(pq.Id);
        Data_Access_WOS_IST_SP_Pricing_Quote.getAllFieldsByID(pq.Id);
        Data_Access_WOS_IST_SP_Pricing_Quote.getAllFieldsByName(pq.Name);
        set<id> setSTPQ = new set<id>();
        Data_Access_WOS_IST_SP_Pricing_Quote.getAllFieldsBySetId(setSTPQ);
    }
}