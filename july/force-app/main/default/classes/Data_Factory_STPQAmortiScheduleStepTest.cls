@Istest
public class Data_Factory_STPQAmortiScheduleStepTest {
    public static ST_PQ_Rent_Amortization_Schedule_Step__c createSTPQRentAmortizationScheduleStep(Id pqRent){
        ST_PQ_Rent_Amortization_Schedule_Step__c rentAmortSchlStep = new ST_PQ_Rent_Amortization_Schedule_Step__c();
        rentAmortSchlStep.Amort_Date__c = '12/12/2012';
        rentAmortSchlStep.Balance__c = 22;
        rentAmortSchlStep.Funding__c = 22;
        rentAmortSchlStep.Interest__c = 22;
        rentAmortSchlStep.Payment__c = 22;
        rentAmortSchlStep.Principal__c = 22;
        rentAmortSchlStep.Rent__c = pqRent;
        rentAmortSchlStep.Step__c =22.0;
        insert rentAmortSchlStep;
        return rentAmortSchlStep;
    }
}