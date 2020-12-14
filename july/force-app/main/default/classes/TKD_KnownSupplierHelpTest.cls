@Istest
public class TKD_KnownSupplierHelpTest {
    @testSetup static void setup(){
        //creation of EIV parameters
        list<EIV_Parameter__c> parameters = Test.loadData(EIV_Parameter__c.sobjectType, 'parametrosTest');
        System.assert(parameters.size()>0);
    }
    
    @Istest
    static void insertBancksTest(){
        Takedowns_Contingency_plan__c  tkd = Data_Factory_Takedown_Test.createTakedownNowkopp('AFINAN-FIJA', 'Papus', 'RFC102990RB');
        Supplier_in_approval__c supplierInApproval = Data_Factory_SupplierInApproval_Test.createNewSupplierInApprovalNoTKD(tkd.Id);
        test.startTest();
        Supplier__c supplier =  Data_Factory_SupplierTest.createSupplier('Juanchos', 'RFC102912BN10', supplierInApproval.Id); 
        TKD_Site__c site = Data_Factory_SiteTest.createSiteVSCode(tkd, supplier.Id, '123'+ string.valueOf(tkd.id));
        Bank_Account__c bnkAcc = Data_Factory_BankAccountTest.createBankAccountSiteVCODE('12356789763528930', 'Dummys Account', site.Id, '123');
        list<Bank_Account__c> bankaccounts = new list<Bank_Account__c>();
        bankaccounts.add(bnkAcc);
        
        Contact con = Data_Factory_ContactSupplier.createSupplierContact('Juanchi', 'Hernandez', site.Id);
        list<Contact> contacts = new list<Contact>();
        contacts.add(con);
        list <Supplier__c> suppliers  = new list<Supplier__c>();
        suppliers.add(supplier);
        list <TKD_Site__c> sites = new list <TKD_Site__c>();
        sites.add(site);
        TKD_CreateEstructureBatchPostSuppliers.createPostSuppliers(sites, supplier);
        TKD_KnownSupplierHelp.insertBancks(bnkAcc.RecordTypeId, sites, bankaccounts, contacts, tkd.id);
        test.stopTest();
        
        
    }

}