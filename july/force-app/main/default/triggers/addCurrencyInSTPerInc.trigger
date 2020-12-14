trigger addCurrencyInSTPerInc on ST_PQ_Periodic_Income__c (Before Insert, Before Update) {
    for (ST_PQ_Periodic_Income__c STPerInc : Trigger.new){
        List<IST__SuperTRUMP_Pricing_Quote__c> STPricing = [select id,CurrencyIsoCode  from IST__SuperTRUMP_Pricing_Quote__c
                                                            where id =:STPerInc.Pricing_Quote__c];        
        
        STPerInc.CurrencyIsoCode = STPricing[0].CurrencyIsoCode;
    }
}