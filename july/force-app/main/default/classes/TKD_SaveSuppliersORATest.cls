@Istest
public class TKD_SaveSuppliersORATest {
	 @testSetup static void setup(){
        //creation of EIV parameters
        list<EIV_Parameter__c> parameters = Test.loadData(EIV_Parameter__c.sobjectType, 'parametrosTest');
        System.assert(parameters.size()>0);
    }
    
    @Istest
    static void saveSuppliersTest(){
        Takedowns_Contingency_plan__c  tkd = Data_Factory_Takedown_Test.createTakedownNowkopp('AFINAN-FIJA', 'Papus', 'RFC102990RB');
        Supplier_in_approval__c supplierInApproval = Data_Factory_SupplierInApproval_Test.createNewSupplierInApprovalNoTKD(tkd.Id);
        test.startTest();
         tkd.TKD_Suppilers_Documents__c = true;
        update tkd;
        Supplier__c supplier =  Data_Factory_SupplierTest.createSupplier('Juanchos', 'RFC102912BN10', supplierInApproval.Id); 
        TKD_Site__c site = Data_Factory_SiteTest.createSite(tkd, supplier.Id);
        Bank_Account__c bnkAcc = Data_Factory_BankAccountTest.createBankAccountSite('12356789763528930', 'Dummys Account', site.Id);
        list<Bank_Account__c> bankaccounts = new list<Bank_Account__c>();
        bankaccounts.add(bnkAcc);
        
        Contact con = Data_Factory_ContactSupplier.createSupplierContact('Juanchi', 'Hernandez', site.Id);
        list<Contact> contacts = new list<Contact>();
        contacts.add(con);
        list <Supplier__c> suppliers  = new list<Supplier__c>();
        suppliers.add(supplier);
        list <TKD_Site__c> sites = new list <TKD_Site__c>();
        sites.add(site);
        list<Supplier_in_approval__c> suppsInApproval = new list<Supplier_in_approval__c>();
        supplierInApproval.tkd_ls_Stage__c ='IN PROCESS';
        suppsInApproval.add(supplierInApproval);
        update suppsInApproval;
        Supplier_in_approval__c  newSuppinapp = supplierInApproval;
        newSuppinapp.tkd_ls_Stage__c = 'APPROVED';
        list<Supplier_in_approval__c> newsuppliers = new list<Supplier_in_approval__c>();
        newsuppliers.add(newSuppinapp);
        update newsuppliers;
        set<Id>suppinappids = new set<Id>();
        for(Supplier_in_approval__c supp: newsuppliers){
            suppinappids.add(supp.Id);
        }
        TKD_SaveSuppliersORA.saveSuppliers(suppinappids);
        
    }
    
      @Istest
    static void saveSuppliersTestPP(){
        EIV_Parameter__c fechaLimiteParam = [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='fecha limite'][0];
        fechaLimiteParam.EIV_tx_parameter__c ='2019-03-03';
        update fechaLimiteParam;
        Takedowns_Contingency_plan__c  tkd = Data_Factory_Takedown_Test.createTakedownNowkoppProgress('AFINAN-FIJA', 'Papus', 'RFC102990RB');
        Supplier_in_approval__c supplierInApproval = Data_Factory_SupplierInApproval_Test.createNewSupplierInApprovalNoTKD(tkd.Id);
        test.startTest();
         tkd.TKD_Suppilers_Documents__c = true;
        update tkd;
        Supplier__c supplier =  Data_Factory_SupplierTest.createSupplier('Juanchos', 'RFC102912BN10', supplierInApproval.Id); 
        TKD_Site__c site = Data_Factory_SiteTest.createSite(tkd, supplier.Id);
        Bank_Account__c bnkAcc = Data_Factory_BankAccountTest.createBankAccountSite('12356789763528930', 'Dummys Account', site.Id);
        list<Bank_Account__c> bankaccounts = new list<Bank_Account__c>();
        bankaccounts.add(bnkAcc);
        
        Contact con = Data_Factory_ContactSupplier.createSupplierContact('Juanchi', 'Hernandez', site.Id);
        list<Contact> contacts = new list<Contact>();
        contacts.add(con);
        list <Supplier__c> suppliers  = new list<Supplier__c>();
        suppliers.add(supplier);
        list <TKD_Site__c> sites = new list <TKD_Site__c>();
        sites.add(site);
        list<Supplier_in_approval__c> suppsInApproval = new list<Supplier_in_approval__c>();
        supplierInApproval.tkd_ls_Stage__c ='IN PROCESS';
        suppsInApproval.add(supplierInApproval);
        update suppsInApproval;
        Supplier_in_approval__c  newSuppinapp = supplierInApproval;
        newSuppinapp.tkd_ls_Stage__c = 'APPROVED';
        list<Supplier_in_approval__c> newsuppliers = new list<Supplier_in_approval__c>();
        newsuppliers.add(newSuppinapp);
        update newsuppliers;
        set<Id>suppinappids = new set<Id>();
        for(Supplier_in_approval__c supp: newsuppliers){
            suppinappids.add(supp.Id);
        }
        TKD_SaveSuppliersORA.saveSuppliers(suppinappids);
        
    }
}