@Istest
public class TKD_supplierInTD_NewSupplierContTest {
     @testSetup static void setup(){
        //creation of EIV parameters
        list<EIV_Parameter__c> parameters = Test.loadData(EIV_Parameter__c.sobjectType, 'parametrosTest');
         System.assert(parameters.size()>0);
     }
	@Istest
    static void insertSupplierTest(){
        Takedowns_Contingency_plan__c  tkd = Data_Factory_Takedown_Test.createTakedownNowkopp('AFINAN-FIJA', 'Papus', 'RFC102990RB');
        TKD_supplierInTD_NewSupplierWrapper.Supplier supplier = new TKD_supplierInTD_NewSupplierWrapper.Supplier();
        supplier.Name ='Supplier prueba';
        supplier.TKD_tx_Vendor_name_alternative ='Supplier prueba';
        supplier.TKD_tx_Vat_Registration_Num  = 'RFC1231XT10';
        
        list<TKD_supplierInTD_NewSupplierWrapper.Site> sites = new list <TKD_supplierInTD_NewSupplierWrapper.Site>();
        TKD_supplierInTD_NewSupplierWrapper.Site sit = new TKD_supplierInTD_NewSupplierWrapper.Site();
        sit.Id ='123';
        sit.Tkd_at_Address_line_1 = 'addres1';
        sit.Tkd_at_Address_line_2 = 'addres2';
        sit.Tkd_tx_City ='DF';
        sit.Tkd_tx_Country ='MEX';
        sit.Name ='Name';
        sit.Tkd_ls_Org_Name ='UO_397 HOLDING';
        sit.tkd_tf_phone ='84510210';
        sit.Tkd_ls_State ='MEX';
        sit.Tkd_tx_Zip ='01230';
        sit.TKD_Vat_code = 'RFC1231XT10';
        sit.primaryPaySiteFlag = false;
        sit.Pay_Site_Flag = false;
       
        
        
        list<TKD_supplierInTD_NewSupplierWrapper.BankAccount> bnks = new list<TKD_supplierInTD_NewSupplierWrapper.BankAccount>();
        TKD_supplierInTD_NewSupplierWrapper.BankAccount bnk = new TKD_supplierInTD_NewSupplierWrapper.BankAccount();
        bnk.Bank_Account_Currency ='MXN';
        bnk.Bank_Account_Name ='Name';
        bnk.Name ='01231230';
        bnk.Id ='123';
        bnks.add(bnk);
        sit.bankAccount = bnks;
        list<TKD_supplierInTD_NewSupplierWrapper.SupplierContact> cons = new list<TKD_supplierInTD_NewSupplierWrapper.SupplierContact>();
        TKD_supplierInTD_NewSupplierWrapper.SupplierContact con  = new TKD_supplierInTD_NewSupplierWrapper.SupplierContact();
        con.emailAddress = 'email.@test.com';
        con.firstName ='First Name';
        con.Id = '123';
        con.lastName = 'Last Name';
        con.Phone ='8451021012';
        cons.add(con);
        sit.supplierContact = cons;
        sites.add(sit);
        supplier.sites = sites;
        TKD_supplierInTD_NewSupplierController.insertSupplier(tkd.Id, supplier);
        TKD_supplierInTD_NewSupplierController.getAccountBankCurrencyPL();
        TKD_supplierInTD_NewSupplierController.getCountryPL();

        TKD_supplierInTD_NewSupplierController.getSiteState();
        TKD_supplierInTD_NewSupplierController.getSiteVatCode();
        TKD_supplierInTD_NewSupplierController.getOperationUnit(TKD.Id);
        TKD_supplierInTD_NewSupplierController.getBankAccount();
        TKD_supplierInTD_NewSupplierController.getTipo_BIC();
        TKD_supplierInTD_NewSupplierController.getTipo();
        TKD_supplierInTD_NewSupplierController.getPago_a_Cuenta_Concentradora();
        TKD_supplierInTD_NewSupplierController.getCurrencyISOCode();
        TKD_supplierInTD_NewSupplierController.getTKD_Supplier_Swift();
    }
}