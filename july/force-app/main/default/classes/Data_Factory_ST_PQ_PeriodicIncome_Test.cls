@Istest
public class Data_Factory_ST_PQ_PeriodicIncome_Test {
    public static ST_PQ_Periodic_Income__c createST_PQ_Periodic_Income(Id pricingPQId){
        ST_PQ_Periodic_Income__c periodicIncome = new ST_PQ_Periodic_Income__c();
        periodicIncome.Active__c = true;
        periodicIncome.Average_Payment__c = 22000;
        periodicIncome.CurrencyIsoCode ='MXN';
        periodicIncome.Description__c ='Description';
        periodicIncome.Num_Payments__c = 2.0;
        periodicIncome.Periodicity__c ='Periodicity';
        periodicIncome.Pricing_Quote__c = pricingPQId;
        periodicIncome.Start_Date__c = date.today();
        periodicIncome.stExternalID__c = '123177';
        insert periodicIncome;
        return periodicIncome;
    }
}