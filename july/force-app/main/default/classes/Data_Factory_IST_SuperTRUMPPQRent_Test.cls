@Istest
public class Data_Factory_IST_SuperTRUMPPQRent_Test {
    public static IST__SuperTRUMP_PQ_Rent__c createISTSuperTRUMPPQRent(Id pricingPQId){
        IST__SuperTRUMP_PQ_Rent__c pqRent = new IST__SuperTRUMP_PQ_Rent__c();
        pqRent.IST__Advance_Payment__c =22.0;
        pqRent.IST__Calculation_Index__c =22.0;
        pqRent.IST__Description__c = 'Description';
        pqRent.IST__Num_Payments__c =2.0;
        pqRent.IST__Pricing_Quote__c = pricingPQId;
        pqRent.IST__stExternalID__c = '123141';
        pqRent.IST__Total_Payments__c = 22.0;
        insert pqRent;
        ST_PQ_Rent_Cash_Flow_Step__c ST_PQ_Rent_Cash_Flow_Step = new ST_PQ_Rent_Cash_Flow_Step__c();
        ST_PQ_Rent_Cash_Flow_Step.Amount__c = 10;
        ST_PQ_Rent_Cash_Flow_Step.Balance__c = 10;
        ST_PQ_Rent_Cash_Flow_Step.Start_Accrual__c = 'Arrear';
        ST_PQ_Rent_Cash_Flow_Step.Num_Pmts__c = 10;
        //ST_PQ_Rent_Cash_Flow_Step.Period__c = 2;
        ST_PQ_Rent_Cash_Flow_Step.Rate__c = 3;
        ST_PQ_Rent_Cash_Flow_Step.Rent__c = pqRent.Id;
        ST_PQ_Rent_Cash_Flow_Step.Step__c = 1;
        ST_PQ_Rent_Cash_Flow_Step.Timing__c = 'Arrears';
        insert ST_PQ_Rent_Cash_Flow_Step;
        return pqRent;
    }
    public static IST__SuperTRUMP_PQ_Rent__c createISTSuperTRUMPPQRentWithOutAdvance(Id pricingPQId){
        IST__SuperTRUMP_PQ_Rent__c pqRent = new IST__SuperTRUMP_PQ_Rent__c();
        pqRent.IST__Calculation_Index__c =22.0;
        pqRent.IST__Description__c = 'Description';
        pqRent.IST__Num_Payments__c =2.0;
        pqRent.IST__Pricing_Quote__c = pricingPQId;
        pqRent.IST__stExternalID__c = '123141';
        pqRent.IST__Total_Payments__c = 22.0;
        insert pqRent;
        ST_PQ_Rent_Cash_Flow_Step__c ST_PQ_Rent_Cash_Flow_Step = new ST_PQ_Rent_Cash_Flow_Step__c();
        ST_PQ_Rent_Cash_Flow_Step.Amount__c = 10;
        ST_PQ_Rent_Cash_Flow_Step.Balance__c = 10;
        ST_PQ_Rent_Cash_Flow_Step.Start_Accrual__c = 'Arrear';
        ST_PQ_Rent_Cash_Flow_Step.Num_Pmts__c = 1;
        ST_PQ_Rent_Cash_Flow_Step.Period__c = 'Stub';
        ST_PQ_Rent_Cash_Flow_Step.Rate__c = 3;
        ST_PQ_Rent_Cash_Flow_Step.Rent__c = pqRent.Id;
        ST_PQ_Rent_Cash_Flow_Step.Step__c = 1;
        ST_PQ_Rent_Cash_Flow_Step.Timing__c = 'Equal';
        ST_PQ_Rent_Cash_Flow_Step.Type__c = 'Payment';
        insert ST_PQ_Rent_Cash_Flow_Step;
        return pqRent;
    }
}