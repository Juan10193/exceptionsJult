@isTest
private class Eng_STCalculationIdServiceTests
{
    static testMethod void testGetPid()
    {
        IST__SuperTRUMP_Pricing_Quote__c quote = Eng_SuperTRUMPTestUtilities.createPricingQuote();
        IST__SuperTRUMP_PQ_Rent__c rent = [Select Id, IST__stExternalId__c, IST__Description__c From IST__SuperTRUMP_PQ_Rent__c Where IST__Pricing_Quote__c = :quote.Id Limit 1];
        Integer pid = Eng_STCalculationIdService.getPID(rent, sObjectType.IST__SuperTRUMP_PQ_Rent__c.fields.IST__stExternalId__c.sObjectField);
        System.assertequals(104, pid);
        
        pid = Eng_STCalculationIDService.getPID(rent, sObjectType.IST__SuperTRUMP_PQ_Rent__c.fields.IST__Description__c.sObjectField);
        System.assertequals(null, pid);
    }
}