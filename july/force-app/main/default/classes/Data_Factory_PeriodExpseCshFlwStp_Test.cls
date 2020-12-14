@Istest
public class Data_Factory_PeriodExpseCshFlwStp_Test {
    public static ST_PQ_Periodic_Expense_Cash_Flow_Step__c createSTPQPeriodicExpenseCashFlowStep(Id priodicExpenseId){
        ST_PQ_Periodic_Expense_Cash_Flow_Step__c periodicExpense = new ST_PQ_Periodic_Expense_Cash_Flow_Step__c();
        periodicExpense.Amount__c =22000;
        periodicExpense.Balance__c= 2200;
        periodicExpense.CurrencyIsoCode = 'MXN';
        periodicExpense.End_Accrual__c = 'ENACCRUAL';
        periodicExpense.Num_Pmts__c = 22.0;
        periodicExpense.Period__c ='PERIOD';
        periodicExpense.Periodic_Expense__c = priodicExpenseId;
        periodicExpense.Rate__c = 2;
        periodicExpense.Start_Accrual__c ='Actual';
        periodicExpense.Step__c =2.0;
        periodicExpense.Type__c ='TYPE';
        insert periodicExpense;
        return periodicExpense;
    }
}