/**
 * @File Name          : Data_Access_Assets_cls.cls
 * @Description        : 
 * @Author             : eduardo.villegas@engeniumcapital.com
 * @Group              : 
 * @Last Modified By   : eduardo.villegas@engeniumcapital.com
 * @Last Modified On   : 22/8/2019 11:50:47
 * @Modification Log   : 
 *==============================================================================
 * Ver         Date                     Author      		      Modification
 *==============================================================================
 * 1.0    22/8/2019 11:49:12   eduardo.villegas@engeniumcapital.com     Initial Version
**/
public with sharing class Data_Access_Assets_cls {
    
    /**
    * @description
    * @author eduardo.villegas@engeniumcapital.com | 22/8/2019
    * @param id takedownInvoiceId
    * @return List<Asset>
    */
    public static List<Asset> getAssetsByTakedownInvoice(id takedownInvoiceId){
        List<Asset> listAssetBreakdown = new List<Asset>();
        if(Schema.sObjectType.Asset.isAccessible()){
            listAssetBreakdown = [SELECT Id, TKD_rb_takedown_Invoice__c, name FROM Asset where TKD_rb_takedown_Invoice__c =:takedownInvoiceId];
        }else{
            system.debug('Error: User is unauthorized to access the Asset object');
        }
        return listAssetBreakdown;
    }
    /**
    * @description
    * @author eduardo.villegas@engeniumcapital.com | 22/8/2019
    * @param id takedownInvoiceId
    * @return List<Asset>
    */
    public static List<Asset> getAssetsByTakedownInvoices(List<id> ListTakedownInvoiceId){
        List<Asset> listAssetBreakdown = new List<Asset>();
        if(Schema.sObjectType.Asset.isAccessible()){
            listAssetBreakdown = [SELECT Id, TKD_rb_takedown_Invoice__c, name FROM Asset where TKD_rb_takedown_Invoice__c =:ListTakedownInvoiceId];
        }else{
            system.debug('Error: User is unauthorized to access the Asset object');
        }
        return listAssetBreakdown;
    }
    /**
    * @description
    * @author eduardo.villegas@engeniumcapital.com | 22/8/2019
    * @param id takedownInvoiceId
    * @return List<Asset>
    */
    public static List<Asset> getAssetsByTakedownId(id takedownCPId){
        List<Asset> listAssetBreakdown = new List<Asset>();
        if(Schema.sObjectType.Asset.isAccessible()){
            listAssetBreakdown = [SELECT Name, SerialNumber, Status, Price, Quantity, Description, OwnerId, TKD_tx_arrears__c, 
                        TKD_ck_active__c, TKD_tx_brand__c, TKD_rb_Takedown_CP__c, TKD_rb_collateral__c, 
                        TKD_fm_collateral_description__c, TKD_fm_collateral_type__c, TKD_tl_ec_policy__c, 
                        TKD_tl_engine_number__c, TKD_tx_asset_external_ID__c, TKD_tx_Concept_ID__c, 
                        TKD_tx_Category__c, TKD_tx_Sub_Category__c, TKD_tx_plates__c, TDK_tx_pediment__c,
                        TKD_fh_imported_on__c, TKD_tl_imported_by__c, TKD_tx_Insurance_company__c, 
                        TKD_tx_Insurance_policy__c, TKD_tx_Model__c, TKD_tx_model_year__c, 
                        TDK_dv_Unit_cost__c, TKD_dv_total_cost__c, TKD_dv_soft_cost__c, TKD_tl_op_collateral_type__c, 
                        TKD_tl_op_collateral_description__c, TKD_tx_inciso_insurance__c, 
                        TKD_fh_insurance_expiration_date__c, TKD_tx_payment_frecuency__c, TKD_tx_payment_order__c, 
                        TKD_tx_period__c, TKD_dv_payment_amount__c, TKD_tx_payment_type__c, 
                        TKD_tx_openlegacy_created_by__c, TKD_fh_annex_a_approved_Date__c, TKD_fh_annex_a_created_Date__c, 
                        TKD_tx_annex_a_number__c, TKD_fh_annex_a_sent_date__c, TKD_ls_annex_b_status__c, 
                        TKD_tx_aseguradora__c, TKD_fh_customer_agreed_delivery_date__c, TKD_ls_delivery_status__c, 
                        TKD_ls_ec_or_customer_supplier__c, TKD_fh_fecha_de_importacion__c, 
                        TKD_fh_forcasted_delivery_date__c, TKD_ls_purchase_Status__c, TKD_fh_quote_date__c, 
                        TKD_tx_quote_number__c, TKD_fh_real_delivery_date__c, TKD_ls_stage__c, TKD_tx_supplier_name__c, 
                        TKD_fh_policy_validity__c, TKD_nu_unit_availability_days__c, TKD_ca_welcome_kit_sent__c, 
                        TKD_fh_welcome_kit_sent_date__c, TKD_ls_annex_a_status__c, TKD_fh_annex_b_sent_date__c, 
                        TKD_ft_openlegacy_created_on__c, TKD_tx_OpenLegacy_modified_by__c, 
                        TKD_ft_OpenLegacy_modified_on__c, TKD_ls_asset_type__c, TKD_rb_takedown_Invoice__c, TKD_rb_takedown_Invoice__r.TKD_txt_RFC__c, 
                        Id, CreatedDate, CreatedBy.name, LastModifiedDate, LastModifiedBy.name, 
                        CurrencyIsoCode, TKD_fm_collateral_id_oracle__c, Tkd_fm_invoice_name__c,
                                  /*TKD_rb_takedown_Invoice__r.TKD_rb_Supplier__c, */TKD_rb_takedown_Invoice__r.name, TKD_rb_takedown_Invoice__r.createddate
                                  /*TKD_rb_takedown_Invoice__r.TKD_rb_Supplier__r.TKD_at_name__c*/
                            FROM Asset 
                                where TKD_rb_takedown_Invoice__r.TKD_pd_Takedown_CP__c = :takedownCPId];
        }else{
            system.debug('Error: User is unauthorized to access the Asset object');
        }
        return listAssetBreakdown;
    }

}