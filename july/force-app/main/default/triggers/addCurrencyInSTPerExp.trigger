trigger addCurrencyInSTPerExp on ST_PQ_Periodic_Expense__c (Before Insert, Before Update) {
    for (ST_PQ_Periodic_Expense__c STPerExp : Trigger.new){
        List<IST__SuperTRUMP_Pricing_Quote__c> STPricing = [select id,CurrencyIsoCode  from IST__SuperTRUMP_Pricing_Quote__c
                                                            where id =:STPerExp.Pricing_Quote__c];        
        
        STPerExp.CurrencyIsoCode = STPricing[0].CurrencyIsoCode;
    }
}