@isTest
public class tkdSiteDetailController_Test {
    @testSetup static void setup(){
        //creation of EIV parameters
        list<EIV_Parameter__c> parameters = Test.loadData(EIV_Parameter__c.sobjectType, 'parametrosTest');
        System.assert(parameters.size()>0);
    }
    @isTest
    static void getSiteWithBanksAndContacts(){
        Takedowns_Contingency_plan__c  tkd = Data_Factory_Takedown_Test.createTakedownNowkopp('AFINAN-FIJA', 'Papus', 'RFC102990RB');
        Supplier_in_approval__c Supplier_in_approval = Data_Factory_SupplierInApproval_Test.createNewSupplierInApprovalNoTKD(tkd.Id);
        Supplier__c	Supplier = Data_Factory_SupplierTest.createSupplier('testvendorName', 'testRFC',Supplier_in_approval.Id);
        TKD_Site__c TKD_Site = Data_Factory_SiteTest.createNewSite(Supplier.Id);
        Data_Factory_ContactSupplier.createNewSupplierContact(TKD_Site.Id);
        Data_Factory_BankAccountTest.createNewBankAccount(TKD_Site.Id);
        tkdSiteDetailController.getSiteWithBanksAndContacts(TKD_Site.Id);
    }
    @isTest
    static void updateBankAccounts(){
        Takedowns_Contingency_plan__c  tkd = Data_Factory_Takedown_Test.createTakedownNowkopp('AFINAN-FIJA', 'Papus', 'RFC102990RB');
        Supplier_in_approval__c Supplier_in_approval = Data_Factory_SupplierInApproval_Test.createNewSupplierInApprovalNoTKD(tkd.Id);
        Supplier__c	Supplier = Data_Factory_SupplierTest.createSupplier('testvendorName', 'testRFC',Supplier_in_approval.Id);
        TKD_Site__c TKD_Site = Data_Factory_SiteTest.createNewSite(Supplier.Id);
        Data_Factory_ContactSupplier.createNewSupplierContact(TKD_Site.Id);
        Data_Factory_BankAccountTest.createNewBankAccount(TKD_Site.Id);
        tkdSiteDetailController.updateBankAccounts(TKD_Site.Id);
    }

}