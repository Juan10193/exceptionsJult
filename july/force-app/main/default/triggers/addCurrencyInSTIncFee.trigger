trigger addCurrencyInSTIncFee on IST__SuperTRUMP_PQ_Income_Fee__c (Before Insert, Before Update) {
    for (IST__SuperTRUMP_PQ_Income_Fee__c STPIncFee : Trigger.new){
        List<IST__SuperTRUMP_Pricing_Quote__c> STPricing = [select id,CurrencyIsoCode  from IST__SuperTRUMP_Pricing_Quote__c
                                                            where id =:STPIncFee.IST__Pricing_Quote__c];        
        
        STPIncFee.CurrencyIsoCode = STPricing[0].CurrencyIsoCode;
        //break;
    }
}