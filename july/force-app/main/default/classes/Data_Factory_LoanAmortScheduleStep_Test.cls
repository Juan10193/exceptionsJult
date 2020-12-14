@Istest
public class Data_Factory_LoanAmortScheduleStep_Test {
    public static ST_PQ_Loan_Amortization_Schedule_Step__c createSTPQLoanAmortizationScheduleStep(Id pqLoanId){
        ST_PQ_Loan_Amortization_Schedule_Step__c loanAmortSchStep = new ST_PQ_Loan_Amortization_Schedule_Step__c();
        loanAmortSchStep.Amort_Date__c ='12/12/2019';
        loanAmortSchStep.Balance__c = 22000;
        loanAmortSchStep.CurrencyIsoCode ='MXN';
        loanAmortSchStep.Funding__c = 2000;
        loanAmortSchStep.Interest__c = 20;
        loanAmortSchStep.Loan__c= pqLoanId;
        loanAmortSchStep.Payment__c = 200;
        loanAmortSchStep.Principal__c = 200;
        loanAmortSchStep.Step__c = 20.0;
        insert loanAmortSchStep;
        return loanAmortSchStep;
    }
}