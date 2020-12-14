@Istest
public class TKD_supplierInTD_NewSupplierWrapper_Test {

    @Istest static void supplier_Test(){
        TKD_supplierInTD_NewSupplierWrapper.Supplier supplier = new TKD_supplierInTD_NewSupplierWrapper.Supplier();
        supplier.Name='PRUEBAS S.A. DE C.V.';
        supplier.TKD_tx_Vendor_name_alternative= 'PRUEBAS S.A. DE C.V.';
        supplier.TKD_tx_Vat_Registration_Num = 'PME101027F37';
        supplier.sites= new List<TKD_supplierInTD_NewSupplierWrapper.Site>(); 
    }
    
    @IsTest static void site_Test(){
        TKD_supplierInTD_NewSupplierWrapper.Site site = new TKD_supplierInTD_NewSupplierWrapper.Site();
        site.Id='a4Gm00000000lApEAI';
        site.Tkd_at_Address_line_1 ='LIBRAMIENTO LA JOYA';
        site.Tkd_at_Address_line_2 ='SN';
        site.Tkd_tx_City ='NAUCALPAN';
        site.Tkd_tx_Country ='MX';
        site.Name ='DMX16-002-1296';
        site.Tkd_ls_Org_Name ='UO_397 HOLDING';
        site.tkd_tf_phone ='55466378';
        site.Tkd_ls_State ='DF';
        site.Tkd_tx_Zip ='6600';
        site.TKD_Vat_code ='AP_IVA_16';
        site.bankAccount = new List<TKD_supplierInTD_NewSupplierWrapper.BankAccount>(); 
        site.supplierContact = new List<TKD_supplierInTD_NewSupplierWrapper.SupplierContact>();
        
    }
    
    @IsTest static void bankAccount_Test(){
        TKD_supplierInTD_NewSupplierWrapper.BankAccount  bankAccount = new TKD_supplierInTD_NewSupplierWrapper.BankAccount();
         bankAccount.Id = 'a2nm00000004C4YAAU';
         bankAccount.Name = 'asd';
         bankAccount.Bank_Account_Name = 'dasd';
         bankAccount.Bank_Name = 'ACTINVER';
         bankAccount.Bank_Account_Currency = 'USD';
    }
    
    @IsTest static void supplierContact_Test(){
        TKD_supplierInTD_NewSupplierWrapper.SupplierContact  suppContact = new TKD_supplierInTD_NewSupplierWrapper.SupplierContact();
        suppContact.Id = '003m000001HC8hoAAD';
        suppContact.firstName = 'Prueba first';
        suppContact.lastName = 'Pruebas last';
        suppContact.Phone = '5500055500';
        suppContact.emailAddress = 'jksdgsdfl@gmail.com';
    }
    
    

}