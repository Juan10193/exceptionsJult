trigger addCurrencyInSTSecDep on ST_PQ_Specified_Security_Deposit__c (Before Insert, Before Update) {
    for (ST_PQ_Specified_Security_Deposit__c STSecDep : Trigger.new){
        List<IST__SuperTRUMP_Pricing_Quote__c> STPricing = [select id,CurrencyIsoCode  from IST__SuperTRUMP_Pricing_Quote__c
                                                            where id =:STSecDep.Pricing_Quote__c];        
        
        STSecDep.CurrencyIsoCode = STPricing[0].CurrencyIsoCode;
    }
}