trigger addCurrencyInSTRents on IST__SuperTRUMP_PQ_Rent__c (Before Insert, Before Update) {
    for (IST__SuperTRUMP_PQ_Rent__c STPLoan : Trigger.new){
        List<IST__SuperTRUMP_Pricing_Quote__c> STPricing = [select id,CurrencyIsoCode  from IST__SuperTRUMP_Pricing_Quote__c
                                                            where id =:STPLoan.IST__Pricing_Quote__c];        
        
        STPLoan.CurrencyIsoCode = STPricing[0].CurrencyIsoCode;
        //break;
    }
}