trigger addCurrencyInSTAsset on IST__SuperTRUMP_PQ_Asset__c (Before Insert, Before Update) {
    for (IST__SuperTRUMP_PQ_Asset__c STAsset : Trigger.new){
        List<IST__SuperTRUMP_Pricing_Quote__c> STPricing = [select id,CurrencyIsoCode  from IST__SuperTRUMP_Pricing_Quote__c
                                                            where id =:STAsset.IST__Pricing_Quote__c];        
        
        STAsset.CurrencyIsoCode = STPricing[0].CurrencyIsoCode;
    }
}