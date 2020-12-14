@IsTest
public class DMLO_Supplier_Test {
	@isTest
    public static void deletSupplier(){
        EIV_Parameter__c parameters = new EIV_Parameter__c();
        parameters.name = 'fecha limite';
        parameters.EIV_tx_parameter__c = '01/12/2018';
        insert parameters;
        Takedowns_Contingency_plan__c TKD = Data_Factory_Takedown_Test.createTakedownNowkopp('OPERFIN-FIJA', 'MARACUYA', 'LOL1231HSR12');
        Supplier_in_approval__c supInapp = Data_Factory_SupplierInApproval_Test.createNewSupplierInApprovalNoTKD(TKD.Id);
        Supplier__c sup = new Supplier__c();
        sup.TKD_pd_Supplier_in_approval__c = supInapp.id;
        insert sup;
        DMLO_Supplier.deletSupplier(sup);
    }
    @isTest
    public static void nulldeletSupplier(){
        EIV_Parameter__c parameters = new EIV_Parameter__c();
        parameters.name = 'fecha limite';
        parameters.EIV_tx_parameter__c = '01/12/2018';
        insert parameters;
       Takedowns_Contingency_plan__c TKD = Data_Factory_Takedown_Test.createTakedownNowkopp('OPERFIN-FIJA', 'MARACUYA', 'LOL1231HSR12');
        Supplier_in_approval__c supInapp = Data_Factory_SupplierInApproval_Test.createNewSupplierInApprovalNoTKD(TKD.Id);
        User readOnlyUser = [Select Id FROM User WHERE IsActive = true LIMIT 1];
        Test.startTest();
        Supplier__c sup = Data_Factory_SupplierTest.createSupplier('vendorName', 'RFC', supInapp.Id);
        
        DMLO_Supplier.deletSupplier(sup);
         Test.stopTest();
    }
}