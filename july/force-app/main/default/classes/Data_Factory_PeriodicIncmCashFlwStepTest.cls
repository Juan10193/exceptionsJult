@Istest
public class Data_Factory_PeriodicIncmCashFlwStepTest {
    public static ST_PQ_Periodic_Income_Cash_Flow_Step__c createST_PQPeriodicIncomeCashFlowStep(Id periodicIncomeId){
        ST_PQ_Periodic_Income_Cash_Flow_Step__c periodicIncome = new ST_PQ_Periodic_Income_Cash_Flow_Step__c();
        periodicIncome.Amount__c = 22000;
        periodicIncome.Balance__c =2200;
        periodicIncome.CurrencyIsoCode = 'MXN';
        periodicIncome.End_Accrual__c = 'EndAcurral';
        periodicIncome.Num_Pmts__c = 2.0;
        periodicIncome.Period__c = 'Period';
        periodicIncome.Periodic_Income__c = periodicIncomeId;
        periodicIncome.Rate__c = 20;
        periodicIncome.Start_Accrual__c = 'sccrual';
        periodicIncome.Step__c = 2.0;
        periodicIncome.Type__c ='Type';
        insert periodicIncome;
        return periodicIncome;
    }
}