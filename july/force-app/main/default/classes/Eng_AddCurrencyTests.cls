@isTest
private class Eng_AddCurrencyTests
{
    static testMethod void testAddCurrencyTriggers(){
        IST__SuperTRUMP_Pricing_Quote__c quote = Eng_SuperTRUMPTestUtilities.createPricingQuote();
        
        SuperTRUMP_PQ_EBO__c ebo = new SuperTRUMP_PQ_EBO__c();
        ebo.EBO_Date__c = Date.today().addDays(30);
        ebo.Amount__c = 40000.00;
        ebo.Based_on__c = 'Specified value';
        ebo.Term__c = 48;
        ebo.stExternalID__c = 'Z10001transactionebo108';
        ebo.Pricing_Quote__c = quote.Id;
        Database.insert(ebo);
        
        IST__SuperTRUMP_PQ_Asset__c asset = new IST__SuperTRUMP_PQ_Asset__c();
        asset.IST__Asset_Cost__c = 50000.00;
        asset.IST__Delivery__c = Date.today();
        asset.IST__stExternalID__c = 'z10001transactionasset109';
        asset.IST__Pricing_Quote__c = quote.Id;
        Database.insert(asset);
        
        List<IST__SuperTRUMP_Pricing_Quote__c> pObjs = new List<IST__SuperTRUMP_Pricing_Quote__c>();
        List<SuperTRUMP_PQ_EBO__c> eboObjs = new List<SuperTRUMP_PQ_EBO__c>();
        List<IST__SuperTRUMP_PQ_Asset__c> aObjs = new List<IST__SuperTRUMP_PQ_Asset__c>();
        List<ST_PQ_Periodic_Income__c> piObjs = new List<ST_PQ_Periodic_Income__c>();
        List<ST_PQ_Periodic_Expense__c> peObjs = new List<ST_PQ_Periodic_Expense__c>();
         
        pObjs = [Select Id, CurrencyIsoCode From IST__SuperTRUMP_Pricing_Quote__c Where Id = :quote.Id];
        eboObjs = [Select Id, Pricing_Quote__c, CurrencyIsoCode From SuperTRUMP_PQ_EBO__c Where Pricing_Quote__c = :quote.Id];
        aObjs = [Select Id, IST__Pricing_Quote__c, CurrencyIsoCode From IST__SuperTRUMP_PQ_Asset__c Where IST__Pricing_Quote__c = :quote.Id];
        piObjs = [Select Id, Pricing_Quote__c, CurrencyIsoCode From ST_PQ_Periodic_Income__c Where Pricing_Quote__c = :quote.Id];
        peObjs = [Select Id, Pricing_Quote__c, CurrencyIsoCode From ST_PQ_Periodic_Expense__c Where Pricing_Quote__c = :quote.Id];
        
        System.assertequals(pObjs[0].CurrencyIsoCode, eboObjs[0].CurrencyIsoCode);
        System.assertequals(pObjs[0].CurrencyIsoCode, aObjs[0].CurrencyIsoCode);
        System.assertequals(pObjs[0].CurrencyIsoCode, piObjs[0].CurrencyIsoCode);
        System.assertequals(pObjs[0].CurrencyIsoCode, peObjs[0].CurrencyIsoCode);
    }
}