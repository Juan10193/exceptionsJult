@isTest
public class tkdSupplierDetailController_Test {
    @testSetup static void setup(){
        //creation of EIV parameters
        list<EIV_Parameter__c> parameters = Test.loadData(EIV_Parameter__c.sobjectType, 'parametrosTest');
        System.assert(parameters.size()>0);
    }
    @isTest
    static void getSupplierWithSites(){
        Takedowns_Contingency_plan__c  tkd = Data_Factory_Takedown_Test.createTakedownNowkopp('AFINAN-FIJA', 'Papus', 'RFC102990RB');
        Supplier_in_approval__c Supplier_in_approval = new Supplier_in_approval__c();
        Supplier_in_approval.TKD_rb_SupplierInApproval__c = tkd.Id;
        insert Supplier_in_approval;
        Supplier__c	Supplier = new Supplier__c();
        Supplier.Name = 'Test Name';
        Supplier.TKD_tx_Vendor_name_alternative__c = 'Test Name';
        Supplier.TKD_tx_Vat_Registration_Num__c = 'PATI010203C04';
        Supplier.TKD_pd_Supplier_in_approval__c = Supplier_in_approval.Id;
        insert supplier;
        tkdSupplierDetailController.getSupplierWithSites(supplier.Id);      
    }
    @isTest
    static void getSupplierInApprovalId(){
        Takedowns_Contingency_plan__c  tkd = Data_Factory_Takedown_Test.createTakedownNowkopp('AFINAN-FIJA', 'Papus', 'RFC102990RB');
        Supplier_in_approval__c Supplier_in_approval = new Supplier_in_approval__c();
        Supplier_in_approval.TKD_rb_SupplierInApproval__c = tkd.Id;
        insert Supplier_in_approval;
        Supplier__c	Supplier = new Supplier__c();
        Supplier.Name = 'Test Name';
        Supplier.TKD_tx_Vendor_name_alternative__c = 'Test Name';
        Supplier.TKD_tx_Vat_Registration_Num__c = 'PATI010203C04';
        Supplier.TKD_pd_Supplier_in_approval__c = Supplier_in_approval.Id;
        insert supplier;
        tkdSupplierDetailController.getSupplierInApprovalId(tkd.Id);        
    }
    @isTest
    static void cloneSite(){
        Takedowns_Contingency_plan__c  tkd = Data_Factory_Takedown_Test.createTakedownNowkopp('AFINAN-FIJA', 'Papus', 'RFC102990RB');
        Supplier_in_approval__c Supplier_in_approval = Data_Factory_SupplierInApproval_Test.createNewSupplierInApprovalNoTKD(tkd.Id);
        Supplier__c	Supplier = Data_Factory_SupplierTest.createSupplier('testvendorName', 'testRFC',Supplier_in_approval.Id);
        TKD_Site__c TKD_Site = Data_Factory_SiteTest.createNewSite(Supplier.Id);
        Data_Factory_ContactSupplier.createNewSupplierContact(TKD_Site.Id);
        Data_Factory_BankAccountTest.createNewBankAccount(TKD_Site.Id);
        tkdSupplierDetailController.cloneSite(TKD_Site.Id);
    }
}