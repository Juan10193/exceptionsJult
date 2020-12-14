@Istest
public class Data_Factory_STPQRentCashFlowStep_Test {
    public static ST_PQ_Rent_Cash_Flow_Step__c createST_PQ_Rent_Cash_Flow_Step(Id pqRentId){
        ST_PQ_Rent_Cash_Flow_Step__c rentCashFlowStep = new ST_PQ_Rent_Cash_Flow_Step__c();
        rentCashFlowStep.Amount__c = 22000;
        rentCashFlowStep.Balance__c = 2000;
        rentCashFlowStep.End_Accrual__c ='EnAccrual';
        rentCashFlowStep.Num_Pmts__c = 22;
        rentCashFlowStep.Period__c = 'Period';
        rentCashFlowStep.Rate__c = 22;
        rentCashFlowStep.Rent__c = pqRentId;
        rentCashFlowStep.Start_Accrual__c = 'sa';
        rentCashFlowStep.Step__c =2;
        rentCashFlowStep.Type__c = 'LOAN';
        rentCashFlowStep.Timing__c = 'Advance';
        insert rentCashFlowStep;
        return rentCashFlowStep;
    }
}