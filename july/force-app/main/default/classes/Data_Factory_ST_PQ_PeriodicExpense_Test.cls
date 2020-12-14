@Istest
public class Data_Factory_ST_PQ_PeriodicExpense_Test {
    public static ST_PQ_Periodic_Expense__c createSTPQPeriodicExpense(Id pricingPQId){
        ST_PQ_Periodic_Expense__c periodicExpense = new ST_PQ_Periodic_Expense__c();
        periodicExpense.Active__c = true;
        periodicExpense.Average_Payment__c =20;
        periodicExpense.Description__c='Description';
        periodicExpense.Num_Payments__c = 2.0;
        periodicExpense.Periodicity__c ='Periodicity';
        periodicExpense.Pricing_Quote__c = pricingPQId;
        periodicExpense.Start_Date__c = Date.today();
        periodicExpense.stExternalID__c = '134442';
        insert periodicExpense;
        return periodicExpense;
    }
}