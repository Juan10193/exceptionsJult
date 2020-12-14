@isTest
private class Eng_AddSecDepCurrencyTests
{
    static testMethod void testAddSecDepCurrencyTrigger(){
        IST__SuperTRUMP_Pricing_Quote__c quote = Eng_SuperTRUMPTestUtilities.createPricingQuote();
        
        ST_PQ_Specified_Security_Deposit__c secdep = new ST_PQ_Specified_Security_Deposit__c();
        secdep.Received__c = Date.today();
        secdep.Returned__c = Date.today().addDays(30);
        secdep.Amount__c = 40000.00;
        secdep.stExternalID__c = 'Z10001transactionsecdep108';
        secdep.Pricing_Quote__c = quote.Id;
        Database.insert(secdep);
                
        List<IST__SuperTRUMP_Pricing_Quote__c> pObjs = new List<IST__SuperTRUMP_Pricing_Quote__c>();
        List<ST_PQ_Specified_Security_Deposit__c> secdepObjs = new List<ST_PQ_Specified_Security_Deposit__c>();
         
        pObjs = [Select Id, CurrencyIsoCode From IST__SuperTRUMP_Pricing_Quote__c Where Id = :quote.Id];
        secdepObjs = [Select Id, Pricing_Quote__c, CurrencyIsoCode From ST_PQ_Specified_Security_Deposit__c Where Pricing_Quote__c = :quote.Id];
        
        System.assertequals(pObjs[0].CurrencyIsoCode, secdepObjs[0].CurrencyIsoCode);
    }
}