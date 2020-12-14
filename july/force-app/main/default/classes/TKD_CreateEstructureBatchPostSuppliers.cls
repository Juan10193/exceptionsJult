/**
 * @description       : 
 * @author            : eduardo.amiens@outlook.com
 * @group             : 
 * @last modified on  : 09-18-2020
 * @last modified by  : eduardo.amiens@outlook.com
 * Modifications Log 
 * Ver   Date         Author                       Modification
 * 1.0   09-01-2020   eduardo.amiens@outlook.com   Initial Version
**/
public class TKD_CreateEstructureBatchPostSuppliers {
    
    public static Takedown_Wrapper_NewSupplierInCA.Request_Parameters createPostSuppliers(List<TKD_Site__c> sites, Supplier__c supplier){
        Takedown_Wrapper_NewSupplierInCA.Request_Parameters parameters = new Takedown_Wrapper_NewSupplierInCA.Request_Parameters();
        Takedown_Wrapper_NewSupplierInCA.Parameters params = new Takedown_Wrapper_NewSupplierInCA.Parameters();
        Takedown_Wrapper_NewSupplierInCA.NewSupplier newSupplier = new Takedown_Wrapper_NewSupplierInCA.NewSupplier();
		newSupplier.supplierId = supplier.Id;
        newSupplier.vendorName = supplier.Name;
        newSupplier.vendorNameAlt = supplier.TKD_tx_Vendor_name_alternative__c;
        newSupplier.vatRegistrationNum = supplier.TKD_tx_Vat_Registration_Num__c;
        newSupplier.attributeCategory = 'DIOT';
        newSupplier.attribute1 = supplier.TKD_ls_Tipo_de_tercero__c;
        newSupplier.attribute2 = supplier.TKD_ls_Pais_de_residencia__c;
        newSupplier.attribute3 = supplier.Nacionalidad__c;

        Takedown_Wrapper_NewSupplierInCA.Sites sitess = new Takedown_Wrapper_NewSupplierInCA.Sites();
        Takedown_Wrapper_NewSupplierInCA.SitePost sitepost = new Takedown_Wrapper_NewSupplierInCA.SitePost();
        list<Takedown_Wrapper_NewSupplierInCA.Site> site = new list<Takedown_Wrapper_NewSupplierInCA.Site>();

        for(TKD_Site__c sit: sites){
            if(sit.Supplier__c == supplier.Id){
                Takedown_Wrapper_NewSupplierInCA.Site si = new Takedown_Wrapper_NewSupplierInCA.Site();
                si.organizationName = sit.Tkd_ls_Org_Name__c;
                si.phone = sit.tkd_tf_phone__c;
                si.country = sit.TKD_tx_Country__c;
                si.addressLine1 = sit.Tkd_at_Address_line_1__c;
                si.addressLine2 = sit.Tkd_at_Address_line_2__c;
                si.city = sit.Tkd_tx_City__c;
                si.state = sit.TKD_ls_State__c;
                si.zip = sit.Tkd_tx_Zip__c;
                si.vendorSiteCode = sit.Name;
                si.vatCode = sit.TKD_Vat_code__c;
                si.paymentCurrencyCode = string.isNotEmpty(sit.SR_ls_Currency__c) ? sit.SR_ls_Currency__c.equals('USD') ? sit.SR_ls_Currency__c : '' : '' ;
                si.primaryPaySiteFlag = sit.primaryPaySiteFlag__c ==true?'Y':'N';
                si.paySiteFlag = 'Y';
                si.inactiveDate = sit.inactiveDate__c;
                Takedown_Wrapper_NewSupplierInCA.Accounts accounts = new Takedown_Wrapper_NewSupplierInCA.Accounts();
                list<Takedown_Wrapper_NewSupplierInCA.Account> accs = new list<Takedown_Wrapper_NewSupplierInCA.Account>();
                for(Bank_Account__c bnkacc: sit.Bank_Accounts__r){
                    if(bnkacc.Bank_Account_Currency__c.equals('MXN') || bnkacc.Bank_Account_Currency__c.equals('USD')){
                        Takedown_Wrapper_NewSupplierInCA.Account account = new Takedown_Wrapper_NewSupplierInCA.Account();
                        account.bankAccountName = bnkacc.Bank_Account_Name__c;
                        account.bankName = bnkacc.SR_tx_Bank_Name__c;
                        account.currens = bnkacc.Bank_Account_Currency__c;
                        account.bankAccountNum = bnkacc.Name;
                        account.attributeCategory = 'BANCO INTERMEDIARIO';//bnkacc.Contexto__c;
                        account.attribute1 = bnkacc.Tipo_BIC__c;
                        account.attribute2 = bnkacc.Codigo_BIC__c;
                        account.attribute3 = bnkacc.Nombre_Banco_intermediadio__c;
                        account.attribute4 = bnkacc.Tipo__c;
                        account.attribute5 = bnkacc.Codigo__c;
                        account.countryCode = bnkacc.SR_tx_Country__c;
                        account.attribute15 = bnkacc.SR_ls_Specific_intermediary_bank__c;
                        account.bankId = integer.valueOf(bnkacc.TKD_tx_OraclebankId__c);
                        accs.add(account);
                    }                    
                }
                accounts.account = accs;
                si.accounts = accounts;
                Takedown_Wrapper_NewSupplierInCA.Contacts contacts = new Takedown_Wrapper_NewSupplierInCA.Contacts();
                list<Takedown_Wrapper_NewSupplierInCA.Contact> conts = new list<Takedown_Wrapper_NewSupplierInCA.Contact>();
                for(Contact cn : sit.Contacts__r){
                    Takedown_Wrapper_NewSupplierInCA.Contact cont = new Takedown_Wrapper_NewSupplierInCA.Contact();
                    cont.personFirstName = cn.FirstName;
                    cont.personLastName = cn.LastName;
                    cont.phone = cn.Phone;
                    cont.emailAddress = cn.Email;
                    cont.areaCode = cn.SR_tf_Phone_area_code__c;
                    cont.inactiveDate = cn.inactiveDate__c;
                    //cont.emailAddress = cn.CON_un_Phone_number_extension__c;
                    conts.add(cont);
                }
                contacts.contact = conts;
                si.contacts = contacts;
                site.add(si);
            }
        }
        
       
        sitess.sitePostXXXX = site;
        newSupplier.sites = sitess;
        params.supplier = newSupplier;
        parameters.parametros =params;
        return parameters;
    }
}