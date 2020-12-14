@Istest
public class Data_Factory_IST_SuperTrump_Expense_Fee {
    public static IST__SuperTRUMP_PQ_Expense_Fee__c createExpenseFee(Id pricingPQ){
        IST__SuperTRUMP_PQ_Expense_Fee__c expenseFee = new IST__SuperTRUMP_PQ_Expense_Fee__c();
        expenseFee.IST__Amount__c =22.0;
        expenseFee.IST__Calculation_Index__c = 22.0;
        expenseFee.IST__Description__c ='Description';
        expenseFee.IST__Paid_Date__c = Date.today();
        expenseFee.IST__Percent__c =13;
        expenseFee.IST__Pricing_Quote__c = pricingPQ;
        expenseFee.IST__stExternalID__c ='1231455';
        insert expenseFee;
        return expenseFee;
    }
}