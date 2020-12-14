@Istest
private class LMM_UpdateOpportunityTotalAmountTest {
	@Istest
    static void searchOppsaFterUpdateTest(){
        Opportunity opp = new Opportunity();
        opp.Amount = 10000;
        opp.Name ='MI OPP';
        opp.RecordTypeId =  Schema.SObjectType.Opportunity.getRecordTypeInfosByDeveloperName().get('OPP_LMM').getRecordTypeId();
        opp.StageName ='Nuevo';
        opp.CloseDate = Date.today();
        opp.CurrencyIsoCode ='MXN';
        insert opp;
        EC_Quote__c q = Data_Factory_EC_Quote_Test.createEcQuoteNoOpp(10000);
        q.Opportunity__c = opp.Id;
        update q;
    }
    
    @Istest
    static void searchOppsaFterDeleteTest(){
        Opportunity opp = new Opportunity();
        opp.Amount = 10000;
        opp.Name ='MI OPP';
        opp.RecordTypeId =  Schema.SObjectType.Opportunity.getRecordTypeInfosByDeveloperName().get('OPP_LMM').getRecordTypeId();
        opp.StageName ='Nuevo';
        opp.CloseDate = Date.today();
        opp.CurrencyIsoCode ='MXN';
        insert opp;
        EC_Quote__c q = Data_Factory_EC_Quote_Test.createEcQuoteNoOpp(10000);
        delete q;
    }
}