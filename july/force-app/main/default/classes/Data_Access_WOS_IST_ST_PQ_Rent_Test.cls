@Istest
private class Data_Access_WOS_IST_ST_PQ_Rent_Test {
    @Istest
    static void getAllFieldsBySetIDTest(){
        Opportunity opp = Data_Factory_Opportunity_Test.createNewOpportunityTypeWK();
        TBO021_Takedowns_forecast__c forecast = Data_Factory_EasyForecast_Test.createForecast(opp.Id);
        IST__SuperTRUMP_Template__c template = TestDataFactory_tst.createSTPricingTemplate();
        IST__SuperTRUMP_Pricing_Quote__c pq = TestDataFactory_tst.createSTPricingQuote(opp,template);
        IST__SuperTRUMP_PQ_Rent__c pqRent = Data_Factory_IST_SuperTRUMPPQRent_Test.createISTSuperTRUMPPQRent(pq.Id);
        set<Id>pqRentIds = new set<Id>();
        pqRentIds.add(pqRent.Id);
        Data_Access_WOS_IST_ST_PQ_Rent_cls.getAllFieldsBySetID(pqRentIds);
    }
}