@Istest
public class Data_Factory_SupTRUMPPQIncomeFee_Test {
    public static IST__SuperTRUMP_PQ_Income_Fee__c createIncomeFee(Id pricingPQId){
        IST__SuperTRUMP_PQ_Income_Fee__c incomeFee = new IST__SuperTRUMP_PQ_Income_Fee__c();
        incomeFee.IST__Amount__c = 22.00;
        incomeFee.IST__Calculation_Index__c = 22.0;
        incomeFee.IST__Description__c ='description';
        incomeFee.IST__Paid_Date__c = Date.today();
        incomeFee.IST__Percent__c = 30;
        incomeFee.IST__Pricing_Quote__c = pricingPQId;
        incomeFee.IST__stExternalID__c ='234123';
        insert incomeFee;
        return incomeFee;
        
    }
}