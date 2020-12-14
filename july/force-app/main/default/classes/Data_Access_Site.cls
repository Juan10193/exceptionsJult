/**
 * @File Name          : Data_Access_Site.cls
 * @Description        : 
 * @Author             : eduardo.villegas@engeniumcapital.com
 * @Group              : 
 * @Last Modified By   : eduardo.villegas@engeniumcapital.com
 * @Last Modified On   : 11/12/2019 9:22:48
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    11/12/2019   eduardo.villegas@engeniumcapital.com     Initial Version
**/
public class Data_Access_Site {
    public static list<TKD_Site__c> getSitDataBysupplierInApprovalID(Id supplierInApprovalID){
    	list<TKD_Site__c> listSites = [SELECT Supplier__r.Id, Supplier__r.TKD_tx_Vat_Registration_Num__c, 
                                       	Supplier__r.Name, Supplier__r.TKD_tx_amlHits__c, Supplier__r.TKD_tl_hitsDescription__c ,
                                        Supplier__r.TKD_un_oracleSupplier__c, CurrencyIsoCode, Supplier__r.TKD_chkb_HaveInvoice__c, 
                                        TKD_Vendor_ID__c, Name, Id,  Supplier__r.TKD_Vendor_ID__c 
                                       FROM TKD_Site__c 
                                       where Supplier__r.TKD_pd_Supplier_in_approval__c  =: supplierInApprovalID];
        return listSites;
    }
    public static list<TKD_Site__c> getSitDataBysupplier(Id supplierId){
    	list<TKD_Site__c> listSites = [SELECT Supplier__r.Id, Supplier__r.TKD_tx_Vat_Registration_Num__c, 
                                        Supplier__r.Name, Supplier__r.TKD_tx_amlHits__c, Supplier__r.TKD_tl_hitsDescription__c, 
                                        Supplier__r.TKD_un_oracleSupplier__c, Supplier__r.TKD_chkb_HaveInvoice__c, TKD_Vendor_ID__c, 
                                        Name, Id, 
                                        (Select Id, name from Bank_Accounts__r), 
                                        (Select Id, name from Contacts__r) 
                                        FROM TKD_Site__c where Supplier__c =: supplierId];
        return listSites;
    }
     public static list<TKD_Site__c> getSiteDataByid(Id siteId){
         system.debug('Elsite que se recibe:' + siteId);
    	list<TKD_Site__c> listSites = [SELECT Supplier__r.Id, Supplier__c, Supplier__r.TKD_tx_Vat_Registration_Num__c, 
                                        Supplier__r.Name, Supplier__r.TKD_tx_amlHits__c, Supplier__r.TKD_tl_hitsDescription__c, 
                                        Supplier__r.TKD_un_oracleSupplier__c, Supplier__r.TKD_chkb_HaveInvoice__c, TKD_Vendor_ID__c, 
                                        Name, Id, 
                                        (Select Id, name from Bank_Accounts__r), 
                                        (Select Id, name from Contacts__r) 
                                        FROM TKD_Site__c where id =: siteId];
        return listSites;
    }
    public static list<TKD_Site__c> getSitDataByTakedown(Takedowns_Contingency_plan__c takedown){
    	list<TKD_Site__c> listSites = [SELECT Id, Name, Supplier__c, tkd_tf_phone__c, Tkd_ls_Org_Name__c, 
                                       Tkd_ls_Country__c, Tkd_at_Address_line_1__c, Tkd_at_Address_line_2__c, 
                                       Tkd_tx_City__c, TKD_ls_State__c, Tkd_tx_Zip__c, TKD_Vendor_Site_ID__c, 
                                       TKD_Vendor_ID__c, TKD_tx_Country__c, CurrencyIsoCode,
                                       Supplier__r.Id, Supplier__r.TKD_tx_Vat_Registration_Num__c, 
                                        Supplier__r.Name, Supplier__r.TKD_tx_amlHits__c, Supplier__r.TKD_tl_hitsDescription__c, 
                                        Supplier__r.TKD_un_oracleSupplier__c, Supplier__r.TKD_chkb_HaveInvoice__c,  
                                        (Select Id, name from Bank_Accounts__r), 
                                        (Select Id, name from Contacts__r) 
                                        FROM TKD_Site__c where Supplier__r.TKD_pd_Supplier_in_approval__c =: takedown.Suppliers_in_approval__r.get(0).id AND Tkd_ls_Org_Name__c =:takedown.CPL_ls_Operation_Unit__c];
        system.debug('listSites ' + listSites);
        return listSites;
    }

}