trigger addCurrencyInSuperTrump on IST__SuperTRUMP_Pricing_Quote__c (After Insert, Before Update, After Update ) {
    addCurrencyInSuperTrump_handdler handler = new addCurrencyInSuperTrump_handdler();
    if(Trigger.isBefore){
        for (IST__SuperTRUMP_Pricing_Quote__c STPricing : Trigger.new){
            STPricing.CurrencyIsoCode = STPricing.MC_Currency__c;
            //break;
        }
    }
    
    if (Trigger.isUpdate && Trigger.isAfter){
        handler.newpricing(Trigger.newMap);
    } else if (Trigger.isInsert && Trigger.isAfter){
        handler.newpricing(Trigger.newMap);
    }
    
}