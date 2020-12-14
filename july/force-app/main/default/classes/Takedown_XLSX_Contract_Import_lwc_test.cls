@istest
public class Takedown_XLSX_Contract_Import_lwc_test {
    @istest
    static void getContractImportRent(){
        EIV_Parameter__c parameters = new EIV_Parameter__c();
        parameters.name = 'fecha limite';
        parameters.EIV_tx_parameter__c = '01/12/2018';
        insert parameters;
        Takedown_Invoice__c createTakedownInvoice = Data_Factory_TakedownInvoice_Test.createTakedownInvoice('xml');
        Takedowns_Contingency_plan__c tkd = [SELECT Id, Name, Annex_Pricing_SuperTrump__c FROM Takedowns_Contingency_plan__c where id =:createTakedownInvoice.TKD_pd_Takedown_CP__c];
        Account cuenta = Data_Factory_Account_Test.createNewAccount('lalo');
        Data_Factory_IST_SuperTrump_Expense_Fee.createExpenseFee(tkd.Annex_Pricing_SuperTrump__c);
        //test.startTest();
        IST__SuperTRUMP_PQ_Loan__c loan = Data_Factory_IST_SuperTRUMPPQLoan_Test.createSuperTRUMPPQLoan(tkd.Annex_Pricing_SuperTrump__c);
        Data_Factory_SupTRUMPPQIncomeFee_Test.createIncomeFee(tkd.Annex_Pricing_SuperTrump__c);
        //IST__SuperTRUMP_PQ_Rent__c rent = Data_Factory_IST_SuperTRUMPPQRent_Test.createISTSuperTRUMPPQRent(tkd.Annex_Pricing_SuperTrump__c);
        Data_Factory_STPQSpeSecurityDeposit_Test.createSTPQSpecifiedSecurityDeposit(tkd.Annex_Pricing_SuperTrump__c);
       	Data_Factory_Assets_test.createAsset(cuenta.id, tkd.id, createTakedownInvoice.id);
        Data_Factory_LoanAmortScheduleStep_Test.createSTPQLoanAmortizationScheduleStep(loan.id);
        Data_Factory_STPQLoanCashFlowStep_Test.createSTPQLoanCashFlowStep(loan.id);
        Takedown_XLSX_Contract_Import_lwc_cls.getContractImport(createTakedownInvoice.TKD_pd_Takedown_CP__c);
        //test.stopTest();
    }
    @istest
    static void getContractImportLoan(){
        EIV_Parameter__c parameters = new EIV_Parameter__c();
        parameters.name = 'fecha limite';
        parameters.EIV_tx_parameter__c = '01/12/2018';
        insert parameters;
        Takedown_Invoice__c createTakedownInvoice = Data_Factory_TakedownInvoice_Test.createTakedownInvoice('xml');
        Takedowns_Contingency_plan__c tkd = [SELECT Id, Name, Annex_Pricing_SuperTrump__c FROM Takedowns_Contingency_plan__c where id =:createTakedownInvoice.TKD_pd_Takedown_CP__c];
        Account cuenta = Data_Factory_Account_Test.createNewAccount('lalo');
        Data_Factory_IST_SuperTrump_Expense_Fee.createExpenseFee(tkd.Annex_Pricing_SuperTrump__c);
        //test.startTest();
        Data_Factory_SupTRUMPPQIncomeFee_Test.createIncomeFee(tkd.Annex_Pricing_SuperTrump__c);
        IST__SuperTRUMP_PQ_Rent__c rent = Data_Factory_IST_SuperTRUMPPQRent_Test.createISTSuperTRUMPPQRent(tkd.Annex_Pricing_SuperTrump__c);
        Data_Factory_STPQSpeSecurityDeposit_Test.createSTPQSpecifiedSecurityDeposit(tkd.Annex_Pricing_SuperTrump__c);
       	Data_Factory_Assets_test.createAsset(cuenta.id, tkd.id, createTakedownInvoice.id);
        Data_Factory_STPQRentCashFlowStep_Test.createST_PQ_Rent_Cash_Flow_Step(rent.id);
        Data_Factory_STPQAmortiScheduleStepTest.createSTPQRentAmortizationScheduleStep(rent.id);
        
        Takedown_XLSX_Contract_Import_lwc_cls.getContractImport(createTakedownInvoice.TKD_pd_Takedown_CP__c);
        //test.stopTest();
    }

}