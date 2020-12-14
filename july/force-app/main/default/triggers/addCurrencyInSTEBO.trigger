trigger addCurrencyInSTEBO on SuperTRUMP_PQ_EBO__c (Before Insert, Before Update) {
    for (SuperTRUMP_PQ_EBO__c STEBO : Trigger.new){
        List<IST__SuperTRUMP_Pricing_Quote__c> STPricing = [select id,CurrencyIsoCode  from IST__SuperTRUMP_Pricing_Quote__c
                                                            where id =:STEBO.Pricing_Quote__c];        
        
        STEBO.CurrencyIsoCode = STPricing[0].CurrencyIsoCode;
    }
}