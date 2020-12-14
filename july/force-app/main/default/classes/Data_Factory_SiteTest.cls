@Istest
public class Data_Factory_SiteTest {
    public static TKD_Site__c createSite(Takedowns_Contingency_plan__c takedown, Id supplierId){
        TKD_Site__c site = new TKD_Site__c();
        site.Tkd_ls_Org_Name__c = takedown.CPL_ls_Operation_Unit__c;
        site.tkd_tf_phone__c ='8451021012';
        site.Tkd_ls_Country__c ='MEX';
        site.Tkd_at_Address_line_1__c ='Address line 1';
        site.Tkd_at_Address_line_2__c ='Address line 2';
        site.Tkd_tx_City__c ='Mex';
        site.TKD_ls_State__c ='MEX';
        site.Tkd_tx_Zip__c ='01230';
        site.TKD_Vendor_ID__c ='AP_IVA_16';
        site.Supplier__c = supplierId;
        site.TKD_Vat_code__c ='vatfake';
        insert site;
        return site;
    }
    
    
     public static TKD_Site__c createSiteVSCode(Takedowns_Contingency_plan__c takedown, Id supplierId, string vscode){
        TKD_Site__c site = new TKD_Site__c();
        site.Tkd_ls_Org_Name__c = takedown.CPL_ls_Operation_Unit__c;
        site.tkd_tf_phone__c ='8451021012';
        site.Tkd_ls_Country__c ='MEX';
        site.Tkd_at_Address_line_1__c ='Address line 1';
        site.Tkd_at_Address_line_2__c ='Address line 2';
        site.Tkd_tx_City__c ='Mex';
        site.TKD_ls_State__c ='MEX';
        site.Tkd_tx_Zip__c ='01230';
        site.TKD_Vendor_ID__c ='AP_IVA_16';
        site.Supplier__c = supplierId;
        site.TKD_Vat_code__c ='vatfake';
        site.TKD_Vendor_Site_ID__c = vscode;
        insert site;
        return site;
    }
    public static TKD_Site__c createNewSite(Id supplierId){
        TKD_Site__c TKD_Site = new TKD_Site__c();
        TKD_Site.Supplier__c = supplierId;
        TKD_Site.Tkd_ls_Org_Name__c = 'UO_397 HOLDING';
        TKD_Site.TKD_Vat_code__c = 'AP_IVA_0';
        TKD_Site.tkd_tf_phone__c = '42342342';
        TKD_Site.Tkd_at_Address_line_1__c = 'test address1';
        TKD_Site.Tkd_at_Address_line_2__c = 'test address2';
        TKD_Site.Tkd_tx_Zip__c = '23423';
        TKD_Site.Tkd_tx_City__c = 'Mex';
        TKD_Site.TKD_ls_State__c = 'BC';
        TKD_Site.TKD_tx_Country__c = 'MX';
        insert TKD_Site;
        return TKD_Site;
    }
}