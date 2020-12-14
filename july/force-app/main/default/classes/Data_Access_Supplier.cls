public class Data_Access_Supplier {
    

    public static List<Supplier__c> getSuppliersAndSitesBySuppIds(set<Id> supplierIds){

        List<Supplier__c> suppliers = [Select Id, IsDeleted, Name, CurrencyIsoCode, LastActivityDate, 
                                TKD_tx_Vendor_Name__c, TKD_tx_Vat_Registration_Num__c,Categoria__c,
                                TKD_tx_Contexto__c, TKD_ls_Tipo_de_tercero__c, TKD_ls_Pais_de_residencia__c,
                                Nacionalidad__c, TKD_pd_Supplier_in_approval__c, TKD_tx_amlHits__c, TKD_tl_hitsDescription__c, 
                                TKD_un_oracleSupplier__c, TKD_tx_Vendor_name_alternative__c, TKD_Vendor_ID__c, TKD_chkb_HaveInvoice__c, 
                                TKD_tx_Supplier_Unique_ID__c, (Select Id from Sites__r) from Supplier__c
                                where Id IN:supplierIds];
        return suppliers;
    }
    public static List<Supplier__c> getSuppliersAndSitesByid(id takedownId){

        List<Supplier__c> suppliers = [Select Id, IsDeleted, Name, CurrencyIsoCode, LastActivityDate, 
                                TKD_tx_Vendor_Name__c, TKD_tx_Vat_Registration_Num__c, TKD_tx_Supplier_Unique_ID__c, 
                                TKD_tx_Contexto__c, TKD_ls_Tipo_de_tercero__c, TKD_ls_Pais_de_residencia__c, Categoria__c,
                                Nacionalidad__c, TKD_pd_Supplier_in_approval__c, TKD_tx_amlHits__c, TKD_tl_hitsDescription__c, 
                                TKD_un_oracleSupplier__c, TKD_tx_Vendor_name_alternative__c, TKD_Vendor_ID__c, TKD_chkb_HaveInvoice__c,
                                       (Select Supplier__c, tkd_tf_phone__c, Tkd_ls_Org_Name__c, Tkd_ls_Country__c, 
                                        Tkd_at_Address_line_1__c, Tkd_at_Address_line_2__c, Tkd_tx_City__c, 
                                        TKD_ls_State__c, Tkd_tx_Zip__c, TKD_Vendor_Site_ID__c, TKD_Vendor_ID__c, 
                                        TKD_tx_Country__c, Name, Id from Sites__r),
                                       (SELECT Id, Name FROM Takedown_Invoices__r)
                                       from Supplier__c
                                where TKD_pd_Supplier_in_approval__r.TKD_rb_SupplierInApproval__c =:takedownId];
        return suppliers;
    }    
    public static Supplier__c getSuppliersAndSitesBySuppid(id takedownId){

        Supplier__c supplier = [Select Id, IsDeleted, Name, CurrencyIsoCode, 
                                TKD_tx_Vendor_Name__c, TKD_tx_Vat_Registration_Num__c, TKD_tx_Supplier_Unique_ID__c, 
                                TKD_tx_Contexto__c, TKD_ls_Tipo_de_tercero__c, TKD_ls_Pais_de_residencia__c, Categoria__c,
                                Nacionalidad__c, TKD_pd_Supplier_in_approval__c, TKD_tx_amlHits__c, TKD_tl_hitsDescription__c, 
                                TKD_un_oracleSupplier__c, TKD_tx_Vendor_name_alternative__c, TKD_Vendor_ID__c, TKD_chkb_HaveInvoice__c,
                                       (Select Supplier__c, tkd_tf_phone__c, Tkd_ls_Org_Name__c, Tkd_ls_Country__c, 
                                        Tkd_at_Address_line_1__c, Tkd_at_Address_line_2__c, Tkd_tx_City__c, 
                                        TKD_ls_State__c, Tkd_tx_Zip__c, TKD_Vendor_Site_ID__c, TKD_Vendor_ID__c, 
                                        TKD_tx_Country__c, Name, Id from Sites__r),
                                       (SELECT Id, Name FROM Takedown_Invoices__r)
                                       from Supplier__c
                                where id=:takedownId];
        return supplier;
    }
}