@Istest
private  class Data_Access_WOSSpeSecurityDeposit_Test {
	@Istest
    static void getSpe_Security_DepositTest(){
        Opportunity opp = Data_Factory_Opportunity_Test.createNewOpportunityTypeWK();
        TBO021_Takedowns_forecast__c forecast = Data_Factory_EasyForecast_Test.createForecast(opp.Id);
        IST__SuperTRUMP_Template__c template = TestDataFactory_tst.createSTPricingTemplate();
        IST__SuperTRUMP_Pricing_Quote__c pq = TestDataFactory_tst.createSTPricingQuote(opp,template);
        ST_PQ_Specified_Security_Deposit__c securityDeposit = Data_Factory_STPQSpeSecurityDeposit_Test.createSTPQSpecifiedSecurityDeposit(pq.Id);
        Data_Access_WOS_Spe_Security_Deposit.getSpe_Security_Deposit(pq.Id);
    }
}