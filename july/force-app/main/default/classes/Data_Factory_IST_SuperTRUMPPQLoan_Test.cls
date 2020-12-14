@Istest
public class Data_Factory_IST_SuperTRUMPPQLoan_Test {
    public static IST__SuperTRUMP_PQ_Loan__c createSuperTRUMPPQLoan(Id pricingPQId){
        IST__SuperTRUMP_PQ_Loan__c pqLoan = new IST__SuperTRUMP_PQ_Loan__c();
        pqLoan.IST__Advance_Payment__c = 22.0;
        pqLoan.IST__Calculation_Index__c = 22.0;
        pqLoan.IST__Description__c = 'Description';
        pqLoan.IST__Num_Payments__c = 2.0;
        pqLoan.IST__Pricing_Quote__c = pricingPQId;
        pqLoan.IST__Start_Date__c = Date.today();
        pqLoan.IST__stExternalID__c ='1231241';
        pqLoan.IST__Total_Funding__c = 20000;
        pqLoan.IST__Total_Payments__c = 200;
        insert pqLoan;
        return pqLoan;
    }
}