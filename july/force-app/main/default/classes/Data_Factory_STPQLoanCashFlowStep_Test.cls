@Istest
public class Data_Factory_STPQLoanCashFlowStep_Test {
    public static ST_PQ_Loan_Cash_Flow_Step__c createSTPQLoanCashFlowStep(Id pqLoanId){
        ST_PQ_Loan_Cash_Flow_Step__c loanCashFlowStep = new ST_PQ_Loan_Cash_Flow_Step__c();
        loanCashFlowStep.Amount__c = 22000;
        loanCashFlowStep.Balance__c = 2000;
        loanCashFlowStep.End_Accrual__c ='EnAccrual';
        loanCashFlowStep.Loan__c = pqLoanId;
        loanCashFlowStep.Num_Pmts__c = 22.0;
        loanCashFlowStep.Period__c ='Period';
        loanCashFlowStep.Rate__c = 20;
        loanCashFlowStep.Start_Accrual__c ='SA';
        loanCashFlowStep.Step__c =2;
        loanCashFlowStep.Type__c ='Type';
        loanCashFlowStep.Timing__c = 'Advance';
        insert loanCashFlowStep;
        return loanCashFlowStep;
    }
}