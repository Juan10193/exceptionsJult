trigger addCurrencyInSTExpFee on IST__SuperTRUMP_PQ_Expense_Fee__c (Before Insert, Before Update) {
    for (IST__SuperTRUMP_PQ_Expense_Fee__c STPExpFee : Trigger.new){
        List<IST__SuperTRUMP_Pricing_Quote__c> STPricing = [select id,CurrencyIsoCode  from IST__SuperTRUMP_Pricing_Quote__c
                                                            where id =:STPExpFee.IST__Pricing_Quote__c];   
        STPExpFee.CurrencyIsoCode = STPricing[0].CurrencyIsoCode;
        //break;
    }
}