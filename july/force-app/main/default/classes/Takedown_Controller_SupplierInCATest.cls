@Istest
public class Takedown_Controller_SupplierInCATest {
    @testSetup static void setup(){
        //creation of EIV parameters
        list<EIV_Parameter__c> parameters = Test.loadData(EIV_Parameter__c.sobjectType, 'parametrosTest');
        System.assert(parameters.size()>0);
    }
    
    @Istest
    static void getTakedownOperationUnitTest(){
        Takedowns_Contingency_plan__c  tkd = Data_Factory_Takedown_Test.createTakedownNowkopp('AFINAN-FIJA', 'Papus', 'RFC102990RB');
        Supplier_in_approval__c supplierInApproval = Data_Factory_SupplierInApproval_Test.createNewSupplierInApprovalNoTKD(tkd.Id);
        supplierInApproval.TKD_rb_SupplierInApproval__c = tkd.Id;
        update supplierInApproval;
        test.startTest();
        Supplier__c supplier =  Data_Factory_SupplierTest.createSupplier('Juanchos', 'RFC102912BN10', supplierInApproval.Id); 
        TKD_Site__c site = Data_Factory_SiteTest.createSite(tkd, supplier.Id);
        Bank_Account__c bnkAcc = Data_Factory_BankAccountTest.createBankAccountSite('12356789763528930', 'Dummys Account', site.Id);
        list<Bank_Account__c> bankaccounts = new list<Bank_Account__c>();
        bankaccounts.add(bnkAcc);
        string rcordid = string.valueOf(tkd.Id);
        Contact con = Data_Factory_ContactSupplier.createSupplierContact('Juanchi', 'Hernandez', site.Id);
        list<Contact> contacts = new list<Contact>();
        contacts.add(con);
        list <Supplier__c> suppliers  = new list<Supplier__c>();
        suppliers.add(supplier);
        list <TKD_Site__c> sites = new list <TKD_Site__c>();
        sites.add(site);
        TKD_CreateEstructureBatchPostSuppliers.createPostSuppliers(sites, supplier);
        TKD_KnownSupplierHelp.insertBancks(bnkAcc.RecordTypeId, sites, bankaccounts, contacts, rcordid);
        test.stopTest();
        Takedown_Controller_SupplierInCA.getTakedownOperationUnit(tkd.Id);
        Takedown_Controller_SupplierInCA.getStatusSuppInApproval(tkd.Id);
    }
    
    @Istest
    static void getKnownSuplierTest(){
        string sandbox = GetSandboxType.getTypeOfSandbox();
        string namecred;
        
        if(sandbox == 'DEV'){
            namecred = 'getsServiceUrl';
        }
        if(sandbox == 'QA'){
            namecred = 'getsServiceUrlQa';
        }
        if(sandbox =='PROD'){
            namecred = 'getsServiceUrlProd';
        }            
        string testEndpoint ='callout:' + namecred + '/SupplierAPI/v2.0/suppliers/details?vendorName=' + EncodingUtil.urlEncode('biodegradables', 'UTF-8') +'&rfc='+ 'BIO1231R14' +'&currencyCode='+ '' +'&vatCode=' + ''; 
        String getResponse ='Respuesta dumy';
        
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseHandler_cls(testEndpoint, getResponse, 'GET', 'application/json', 200));
        try{
            Takedown_Controller_SupplierInca.getKnownSupplier('', '', 'biodegradables', '', '');
        }catch(Exception e){
            system.debug(e);
        }
        
    }
    
    @Istest
    static void saveListSitessTest(){
        Takedowns_Contingency_plan__c  tkd = Data_Factory_Takedown_Test.createTakedownNowkopp('AFINAN-FIJA', 'Papus', 'RFC102990RB');
        Supplier_in_approval__c supplierInApproval = Data_Factory_SupplierInApproval_Test.createNewSupplierInApprovalNoTKD(tkd.Id);
        supplierInApproval.TKD_rb_SupplierInApproval__c = tkd.Id;
        update supplierInApproval;
        test.startTest();
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
        
        Supplier__c supp = new Supplier__c();
        supp.TKD_tx_Vendor_Name__c ='VendorName';
        supp.TKD_tx_Vendor_name_alternative__c = 'Vendroname';
        supp.TKD_tx_Vat_Registration_Num__c = 'RFC1238489R12';
        
        TKD_Site__c sit = new TKD_Site__c();
        sit.Tkd_ls_Org_Name__c = tkd.CPL_ls_Operation_Unit__c;
        sit.tkd_tf_phone__c ='8451021012';
        sit.Tkd_ls_Country__c ='MEX';
        sit.Tkd_at_Address_line_1__c ='Address line 1';
        sit.Tkd_at_Address_line_2__c ='Address line 2';
        sit.Tkd_tx_City__c ='Mex';
        sit.TKD_ls_State__c ='MEX';
        sit.Tkd_tx_Zip__c ='01230';
        sit.TKD_Vendor_ID__c ='AP_IVA_16';
        
        list<Supplier__c> supps = new list<Supplier__c>();
        supps.add(supp);
        
        list<TKD_Site__c> sits = new list<TKD_Site__c>();
        sits.add(sit);
        
        
        
        TKD_CreateEstructureBatchPostSuppliers.createPostSuppliers(sites, supplier);
        string rcordid = string.valueOf(tkd.Id);
        TKD_KnownSupplierHelp.insertBancks(bnkAcc.RecordTypeId, sites, bankaccounts, contacts, rcordid);
        Takedown_Controller_SupplierInCA.saveListSitess(tkd.Id, supps, sits, bankaccounts, contacts);
        test.stopTest();
        
    }
    
    
    @Istest
    static void onSaveSupplierInApprovalTest(){
        Takedowns_Contingency_plan__c  tkd = Data_Factory_Takedown_Test.createTakedownNowkopp('AFINAN-FIJA', 'Papus', 'RFC102990RB');
        Supplier_in_approval__c supplierInApproval = Data_Factory_SupplierInApproval_Test.createNewSupplierInApprovalNoTKD(tkd.Id);
        Takedown_Controller_SupplierInCA.onSaveSupplierInApproval(tkd.Id);
    }
    
    @Istest
    static void getIdSupplierInApprovalTest(){
        Takedowns_Contingency_plan__c  tkd = Data_Factory_Takedown_Test.createTakedownNowkopp('AFINAN-FIJA', 'Papus', 'RFC102990RB');
        Supplier_in_approval__c supplierInApproval = Data_Factory_SupplierInApproval_Test.createNewSupplierInApprovalNoTKD(tkd.Id);
        supplierInApproval.TKD_rb_SupplierInApproval__c = tkd.Id;
        update supplierInApproval;
        Takedown_Controller_SupplierInCA.getIdSupplierInApproval(tkd.Id);
    }
    
    @Istest
    static void getSupplierByInvoiceTest(){
        Takedowns_Contingency_plan__c  tkd = Data_Factory_Takedown_Test.createTakedownNowkopp('AFINAN-FIJA', 'Papus', 'RFC102990RB');
        Supplier_in_approval__c supplierInApproval = Data_Factory_SupplierInApproval_Test.createNewSupplierInApprovalNoTKD(tkd.Id);
        supplierInApproval.TKD_rb_SupplierInApproval__c = tkd.Id;
        update supplierInApproval;
         Supplier__c supplier =  Data_Factory_SupplierTest.createSupplier('Juanchos', 'RFC102912BN10', supplierInApproval.Id);
        test.startTest();
        	Takedown_Controller_SupplierInCA.getSupplierByInvoice(tkd.Id);
        test.stopTest();
       
    }
    
    @Istest
    static void getallSitesOraIdByRecordIdTest(){
        Takedowns_Contingency_plan__c tkd = Data_Factory_Takedown_Test.createTakedownNowkopp('AFINAN-FIJA', 'entityCPName', 'entityCPRFCTIN');
        Supplier_in_approval__c suppInApp = Data_Factory_SupplierInApproval_Test.createNewSupplierInApprovalNoTKD(tkd.Id);
        Supplier__c supp = Data_Factory_SupplierTest.createSupplier('vendorName', 'RFC', suppInApp.Id);
        
        Takedown_Controller_SupplierInCA.getallSitesOraIdByRecordId(tkd.Id);
    }
    
    @Istest
    static void saveListSitess2Test(){
         Takedowns_Contingency_plan__c  tkd = Data_Factory_Takedown_Test.createTakedownNowkopp('AFINAN-FIJA', 'Papus', 'RFC102990RB');
        Supplier_in_approval__c supplierInApproval = Data_Factory_SupplierInApproval_Test.createNewSupplierInApprovalNoTKD(tkd.Id);
        supplierInApproval.TKD_rb_SupplierInApproval__c = tkd.Id;
        update supplierInApproval;
        test.startTest();
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
        
        Supplier__c supp = new Supplier__c();
        supp.TKD_tx_Vendor_Name__c ='VendorName';
        supp.TKD_tx_Vendor_name_alternative__c = 'Vendroname';
        supp.TKD_tx_Vat_Registration_Num__c = 'RFC1238489R12';
        
        TKD_Site__c sit = new TKD_Site__c();
        sit.Tkd_ls_Org_Name__c = tkd.CPL_ls_Operation_Unit__c;
        sit.tkd_tf_phone__c ='8451021012';
        sit.Tkd_ls_Country__c ='MEX';
        sit.Tkd_at_Address_line_1__c ='Address line 1';
        sit.Tkd_at_Address_line_2__c ='Address line 2';
        sit.Tkd_tx_City__c ='Mex';
        sit.TKD_ls_State__c ='MEX';
        sit.Tkd_tx_Zip__c ='01230';
        sit.TKD_Vendor_ID__c ='AP_IVA_16';
        
        list<Supplier__c> supps = new list<Supplier__c>();
        supps.add(supp);
        
        list<TKD_Site__c> sits = new list<TKD_Site__c>();
        sits.add(sit);
        
        
        
        TKD_CreateEstructureBatchPostSuppliers.createPostSuppliers(sites, supplier);
        string rcordid = string.valueOf(tkd.Id);
        TKD_KnownSupplierHelp.insertBancks(bnkAcc.RecordTypeId, sites, bankaccounts, contacts, rcordid);
        Takedown_Controller_SupplierInCA.saveListSitess2(tkd.Id, supps, sits, bankaccounts, contacts);
        test.stopTest();
    }
    
     @Istest
    static void saveListSitess3Test(){
         Takedowns_Contingency_plan__c  tkd = Data_Factory_Takedown_Test.createTakedownNowkopp('AFINAN-FIJA', 'Papus', 'RFC102990RB');
        Supplier_in_approval__c supplierInApproval = Data_Factory_SupplierInApproval_Test.createNewSupplierInApprovalNoTKD(tkd.Id);
        supplierInApproval.TKD_rb_SupplierInApproval__c = tkd.Id;
        update supplierInApproval;
        test.startTest();
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
        
        Supplier__c supp = new Supplier__c();
        supp.TKD_tx_Vendor_Name__c ='VendorName';
        supp.TKD_tx_Vendor_name_alternative__c = 'Vendroname';
        supp.TKD_tx_Vat_Registration_Num__c = 'RFC1238489R12';
        
        TKD_Site__c sit = new TKD_Site__c();
        sit.Tkd_ls_Org_Name__c = tkd.CPL_ls_Operation_Unit__c;
        sit.tkd_tf_phone__c ='8451021012';
        sit.Tkd_ls_Country__c ='MEX';
        sit.Tkd_at_Address_line_1__c ='Address line 1';
        sit.Tkd_at_Address_line_2__c ='Address line 2';
        sit.Tkd_tx_City__c ='Mex';
        sit.TKD_ls_State__c ='MEX';
        sit.Tkd_tx_Zip__c ='01230';
        sit.TKD_Vendor_ID__c ='AP_IVA_16';
        
        list<Supplier__c> supps = new list<Supplier__c>();
        supps.add(supp);
        
        list<TKD_Site__c> sits = new list<TKD_Site__c>();
        sits.add(sit);
        
        
        
        TKD_CreateEstructureBatchPostSuppliers.createPostSuppliers(sites, supplier);
        string rcordid = string.valueOf(tkd.Id);
        TKD_KnownSupplierHelp.insertBancks(bnkAcc.RecordTypeId, sites, bankaccounts, contacts, rcordid);
        Takedown_Controller_SupplierInCA.saveListSitess3(tkd.Id, supps, sits, bankaccounts, contacts);
        test.stopTest();
    }
    
    
     @Istest
    static void getTakedownOperationUnitTest2(){
        Takedowns_Contingency_plan__c  tkd = Data_Factory_Takedown_Test.createTakedownNowkopp('AFINAN-FIJA', 'Papus', 'RFC102990RB');
        Supplier_in_approval__c supplierInApproval = Data_Factory_SupplierInApproval_Test.createNewSupplierInApprovalNoTKD(tkd.Id);
        supplierInApproval.TKD_rb_SupplierInApproval__c = tkd.Id;
        update supplierInApproval;
        test.startTest();
        Supplier__c supplier =  Data_Factory_SupplierTest.createSupplier('Juanchos', 'RFC102912BN10', supplierInApproval.Id); 
        TKD_Site__c site = Data_Factory_SiteTest.createSite(tkd, supplier.Id);
        Bank_Account__c bnkAcc = Data_Factory_BankAccountTest.createBankAccountSite('12356789763528930', 'Dummys Account', site.Id);
        list<Bank_Account__c> bankaccounts = new list<Bank_Account__c>();
        bankaccounts.add(bnkAcc);
        string rcordid = string.valueOf(tkd.Id);
        Contact con = Data_Factory_ContactSupplier.createSupplierContact('Juanchi', 'Hernandez', site.Id);
        list<Contact> contacts = new list<Contact>();
        contacts.add(con);
        list <Supplier__c> suppliers  = new list<Supplier__c>();
        suppliers.add(supplier);
        list <TKD_Site__c> sites = new list <TKD_Site__c>();
        sites.add(site);
        TKD_CreateEstructureBatchPostSuppliers.createPostSuppliers(sites, supplier);
        TKD_KnownSupplierHelp.insertBancks(bnkAcc.RecordTypeId, sites, bankaccounts, contacts, rcordid);
        test.stopTest();
        Takedown_Controller_SupplierInCA.getTakedownOperationUnit2(tkd.Id);
        Takedown_Controller_SupplierInCA.getStatusSuppInApproval2(tkd.Id);
    }
    
      @Istest
    static void saveListSitess4Test(){
         Takedowns_Contingency_plan__c  tkd = Data_Factory_Takedown_Test.createTakedownNowkopp('AFINAN-FIJA', 'Papus', 'RFC102990RB');
        Supplier_in_approval__c supplierInApproval = Data_Factory_SupplierInApproval_Test.createNewSupplierInApprovalNoTKD(tkd.Id);
        supplierInApproval.TKD_rb_SupplierInApproval__c = tkd.Id;
        update supplierInApproval;
        test.startTest();
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
        
        Supplier__c supp = new Supplier__c();
        supp.TKD_tx_Vendor_Name__c ='VendorName';
        supp.TKD_tx_Vendor_name_alternative__c = 'Vendroname';
        supp.TKD_tx_Vat_Registration_Num__c = 'RFC1238489R12';
        
        TKD_Site__c sit = new TKD_Site__c();
        sit.Tkd_ls_Org_Name__c = tkd.CPL_ls_Operation_Unit__c;
        sit.tkd_tf_phone__c ='8451021012';
        sit.Tkd_ls_Country__c ='MEX';
        sit.Tkd_at_Address_line_1__c ='Address line 1';
        sit.Tkd_at_Address_line_2__c ='Address line 2';
        sit.Tkd_tx_City__c ='Mex';
        sit.TKD_ls_State__c ='MEX';
        sit.Tkd_tx_Zip__c ='01230';
        sit.TKD_Vendor_ID__c ='AP_IVA_16';
        
        list<Supplier__c> supps = new list<Supplier__c>();
        supps.add(supp);
        
        list<TKD_Site__c> sits = new list<TKD_Site__c>();
        sits.add(sit);
        
        
        
        TKD_CreateEstructureBatchPostSuppliers.createPostSuppliers(sites, supplier);
        string rcordid = string.valueOf(tkd.Id);
        TKD_KnownSupplierHelp.insertBancks(bnkAcc.RecordTypeId, sites, bankaccounts, contacts, rcordid);
        Takedown_Controller_SupplierInCA.saveListSitess4(tkd.Id, supps, sits, bankaccounts, contacts);
        test.stopTest();
    }
    
         @Istest
    static void saveListSitess5Test(){
         Takedowns_Contingency_plan__c  tkd = Data_Factory_Takedown_Test.createTakedownNowkopp('AFINAN-FIJA', 'Papus', 'RFC102990RB');
        Supplier_in_approval__c supplierInApproval = Data_Factory_SupplierInApproval_Test.createNewSupplierInApprovalNoTKD(tkd.Id);
        supplierInApproval.TKD_rb_SupplierInApproval__c = tkd.Id;
        update supplierInApproval;
        test.startTest();
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
        
        Supplier__c supp = new Supplier__c();
        supp.TKD_tx_Vendor_Name__c ='VendorName';
        supp.TKD_tx_Vendor_name_alternative__c = 'Vendroname';
        supp.TKD_tx_Vat_Registration_Num__c = 'RFC1238489R12';
        
        TKD_Site__c sit = new TKD_Site__c();
        sit.Tkd_ls_Org_Name__c = tkd.CPL_ls_Operation_Unit__c;
        sit.tkd_tf_phone__c ='8451021012';
        sit.Tkd_ls_Country__c ='MEX';
        sit.Tkd_at_Address_line_1__c ='Address line 1';
        sit.Tkd_at_Address_line_2__c ='Address line 2';
        sit.Tkd_tx_City__c ='Mex';
        sit.TKD_ls_State__c ='MEX';
        sit.Tkd_tx_Zip__c ='01230';
        sit.TKD_Vendor_ID__c ='AP_IVA_16';
        
        list<Supplier__c> supps = new list<Supplier__c>();
        supps.add(supp);
        
        list<TKD_Site__c> sits = new list<TKD_Site__c>();
        sits.add(sit);
        
        
        
        TKD_CreateEstructureBatchPostSuppliers.createPostSuppliers(sites, supplier);
        string rcordid = string.valueOf(tkd.Id);
        TKD_KnownSupplierHelp.insertBancks(bnkAcc.RecordTypeId, sites, bankaccounts, contacts, rcordid);
        Takedown_Controller_SupplierInCA.saveListSitess5(tkd.Id, supps, sits, bankaccounts, contacts);
        test.stopTest();
    }
    
         @Istest
    static void saveListSitess6Test(){
         Takedowns_Contingency_plan__c  tkd = Data_Factory_Takedown_Test.createTakedownNowkopp('AFINAN-FIJA', 'Papus', 'RFC102990RB');
        Supplier_in_approval__c supplierInApproval = Data_Factory_SupplierInApproval_Test.createNewSupplierInApprovalNoTKD(tkd.Id);
        supplierInApproval.TKD_rb_SupplierInApproval__c = tkd.Id;
        update supplierInApproval;
        test.startTest();
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
        
        Supplier__c supp = new Supplier__c();
        supp.TKD_tx_Vendor_Name__c ='VendorName';
        supp.TKD_tx_Vendor_name_alternative__c = 'Vendroname';
        supp.TKD_tx_Vat_Registration_Num__c = 'RFC1238489R12';
        
        TKD_Site__c sit = new TKD_Site__c();
        sit.Tkd_ls_Org_Name__c = tkd.CPL_ls_Operation_Unit__c;
        sit.tkd_tf_phone__c ='8451021012';
        sit.Tkd_ls_Country__c ='MEX';
        sit.Tkd_at_Address_line_1__c ='Address line 1';
        sit.Tkd_at_Address_line_2__c ='Address line 2';
        sit.Tkd_tx_City__c ='Mex';
        sit.TKD_ls_State__c ='MEX';
        sit.Tkd_tx_Zip__c ='01230';
        sit.TKD_Vendor_ID__c ='AP_IVA_16';
        
        list<Supplier__c> supps = new list<Supplier__c>();
        supps.add(supp);
        
        list<TKD_Site__c> sits = new list<TKD_Site__c>();
        sits.add(sit);
        
        
        
        TKD_CreateEstructureBatchPostSuppliers.createPostSuppliers(sites, supplier);
        string rcordid = string.valueOf(tkd.Id);
        TKD_KnownSupplierHelp.insertBancks(bnkAcc.RecordTypeId, sites, bankaccounts, contacts, rcordid);
        Takedown_Controller_SupplierInCA.saveListSitess6(tkd.Id, supps, sits, bankaccounts, contacts);
        test.stopTest();
    }
    
          @Istest
    static void saveListSitess7Test(){
         Takedowns_Contingency_plan__c  tkd = Data_Factory_Takedown_Test.createTakedownNowkopp('AFINAN-FIJA', 'Papus', 'RFC102990RB');
        Supplier_in_approval__c supplierInApproval = Data_Factory_SupplierInApproval_Test.createNewSupplierInApprovalNoTKD(tkd.Id);
        supplierInApproval.TKD_rb_SupplierInApproval__c = tkd.Id;
        update supplierInApproval;
        test.startTest();
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
        
        Supplier__c supp = new Supplier__c();
        supp.TKD_tx_Vendor_Name__c ='VendorName';
        supp.TKD_tx_Vendor_name_alternative__c = 'Vendroname';
        supp.TKD_tx_Vat_Registration_Num__c = 'RFC1238489R12';
        
        TKD_Site__c sit = new TKD_Site__c();
        sit.Tkd_ls_Org_Name__c = tkd.CPL_ls_Operation_Unit__c;
        sit.tkd_tf_phone__c ='8451021012';
        sit.Tkd_ls_Country__c ='MEX';
        sit.Tkd_at_Address_line_1__c ='Address line 1';
        sit.Tkd_at_Address_line_2__c ='Address line 2';
        sit.Tkd_tx_City__c ='Mex';
        sit.TKD_ls_State__c ='MEX';
        sit.Tkd_tx_Zip__c ='01230';
        sit.TKD_Vendor_ID__c ='AP_IVA_16';
        
        list<Supplier__c> supps = new list<Supplier__c>();
        supps.add(supp);
        
        list<TKD_Site__c> sits = new list<TKD_Site__c>();
        sits.add(sit);
        
        
        
        TKD_CreateEstructureBatchPostSuppliers.createPostSuppliers(sites, supplier);
        string rcordid = string.valueOf(tkd.Id);
        TKD_KnownSupplierHelp.insertBancks(bnkAcc.RecordTypeId, sites, bankaccounts, contacts, rcordid);
        Takedown_Controller_SupplierInCA.saveListSitess7(tkd.Id, supps, sits, bankaccounts, contacts);
        test.stopTest();
    }
    
          @Istest
    static void saveListSitess8Test(){
         Takedowns_Contingency_plan__c  tkd = Data_Factory_Takedown_Test.createTakedownNowkopp('AFINAN-FIJA', 'Papus', 'RFC102990RB');
        Supplier_in_approval__c supplierInApproval = Data_Factory_SupplierInApproval_Test.createNewSupplierInApprovalNoTKD(tkd.Id);
        supplierInApproval.TKD_rb_SupplierInApproval__c = tkd.Id;
        update supplierInApproval;
        test.startTest();
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
        
        Supplier__c supp = new Supplier__c();
        supp.TKD_tx_Vendor_Name__c ='VendorName';
        supp.TKD_tx_Vendor_name_alternative__c = 'Vendroname';
        supp.TKD_tx_Vat_Registration_Num__c = 'RFC1238489R12';
        
        TKD_Site__c sit = new TKD_Site__c();
        sit.Tkd_ls_Org_Name__c = tkd.CPL_ls_Operation_Unit__c;
        sit.tkd_tf_phone__c ='8451021012';
        sit.Tkd_ls_Country__c ='MEX';
        sit.Tkd_at_Address_line_1__c ='Address line 1';
        sit.Tkd_at_Address_line_2__c ='Address line 2';
        sit.Tkd_tx_City__c ='Mex';
        sit.TKD_ls_State__c ='MEX';
        sit.Tkd_tx_Zip__c ='01230';
        sit.TKD_Vendor_ID__c ='AP_IVA_16';
        
        list<Supplier__c> supps = new list<Supplier__c>();
        supps.add(supp);
        
        list<TKD_Site__c> sits = new list<TKD_Site__c>();
        sits.add(sit);
        
        
        
        TKD_CreateEstructureBatchPostSuppliers.createPostSuppliers(sites, supplier);
        string rcordid = string.valueOf(tkd.Id);
        TKD_KnownSupplierHelp.insertBancks(bnkAcc.RecordTypeId, sites, bankaccounts, contacts, rcordid);
        Takedown_Controller_SupplierInCA.saveListSitess8(tkd.Id, supps, sits, bankaccounts, contacts);
        test.stopTest();
    }
    
}