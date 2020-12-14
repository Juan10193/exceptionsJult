/**
 * @File Name          : Data_Access_S3_obj_Pricing_in_Credit_Approval_cls.cls
 * @Description        : 
 * @Author             : juandedios.hernandez@engeniumcapital.com
 * @Group              : 
 * @Last Modified By   : juandedios.hernandez@engeniumcapital.com
 * @Last Modified On   : 23/9/2019 17:08:16
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    23/9/2019   juandedios.hernandez@engeniumcapital.com     Initial Version
**/
public Without Sharing class Data_Access_PricinginCredit_Approval_cls {

    /**
    * @description 
    * @author juandedios.hernandez@engeniumcapital.com | 23/9/2019 
    * @return List<ES3_obj_Pricing_in_Credit_Approval__c> 
    **/
    public static List<ES3_obj_Pricing_in_Credit_Approval__c> pricingsInCa (string opportunityId){
        if(Schema.sObjectType.ES3_obj_Pricing_in_Credit_Approval__c.isAccessible()){
            return [SELECT Id, OwnerId, IsDeleted, Name, CurrencyIsoCode, CreatedDate,
                    CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, 
                    LastActivityDate, ES3_fm_CurrentURL__c, ES3_fm_P_option__c, 
                    ES3_fm_Pricing_Super_Trump__c, ES3_fm_RV__c, ES3_ls_EBO__c, ES3_ls_EFA__c,
                    ES3_ls_Low_High_High_Low__c, ES3_ls_Progress_Payments__c, ES3_ls_SL_B_YES_NO__c,
                    ES3_ls_Type_of_Grace_Period__c, ES3_ls_Used_New__c, ES3_nu_Advance_PaymentPercent__c, 
                    ES3_nu_Grace_Period_in_Months__c, ES3_nu_Progress_Payments_M__c, ES3_nu_ROI_No_Insurance__c, 
                    ES3_pc_Remarketing_Fee_Percent__c, ES3_pc_Split_Trac_Percentent__c, ES3_pc_Trac_Percent__c, 
                    ES3_rb_Credit_approval_CP__c, ES3_rb_Inside_sales__c, ES3_rb_Oportunidad__c, 
                    ES3_rb_Opportunity_in_Credit_approval_CP__c, ES3_rb_Pricing__c, ES3_rb_Underwriter__c, 
                    ES3_sr_underWriter__c, ES3_tx_Appraisal__c, ES3_tx_Boot_Collateral__c, ES3_tx_IdPricingDuplicate__c, 
                    ES3_num_Ballon_Bullet_Payment__c, ES3_num_SD__c, ES3_pc_Opening_Fee__c, ES3_pc_P_Option__c, ES3_pc_RV__c, 
                    ES3_pc_Rate__c, BKL_lst_Prom_Note__c, BKL_pc_Lock_Fee__c, BKL_TXT_L_H_Description__c,
                    BKL_TXT_Model_Asset_Return_Condition__c, BKL_TXT_Progres_Description__c, BKL_txt_EOL_Option__c, 
                    BLG_at_Progress_Payment_details__c, BLG_at_SD_Comment__c, BLG_pr_SD_percent__c, ES3_tl_EBO_Description__c 
                    FROM ES3_obj_Pricing_in_Credit_Approval__c where  ES3_rb_Oportunidad__c =:opportunityId ];
       
        }else{
            system.debug('Error: User is unauthorized to access to Pricings In CA');
        }

        return null;
    }

    public static ES3_obj_Pricing_in_Credit_Approval__c pricingInCAById (string pricingInCaId){
        if(Schema.sObjectType.ES3_obj_Pricing_in_Credit_Approval__c.isAccessible()){
            return [SELECT Id, OwnerId, IsDeleted, Name, CurrencyIsoCode, CreatedDate,
                    CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, 
                    LastActivityDate, ES3_fm_CurrentURL__c, ES3_fm_P_option__c, 
                    ES3_fm_Pricing_Super_Trump__c, ES3_fm_RV__c, ES3_ls_EBO__c, ES3_ls_EFA__c,
                    ES3_ls_Low_High_High_Low__c, ES3_ls_Progress_Payments__c, ES3_ls_SL_B_YES_NO__c,
                    ES3_ls_Type_of_Grace_Period__c, ES3_ls_Used_New__c, ES3_nu_Advance_PaymentPercent__c, 
                    ES3_nu_Grace_Period_in_Months__c, ES3_nu_Progress_Payments_M__c, ES3_nu_ROI_No_Insurance__c, 
                    ES3_pc_Remarketing_Fee_Percent__c, ES3_pc_Split_Trac_Percentent__c, ES3_pc_Trac_Percent__c, 
                    ES3_rb_Credit_approval_CP__c, ES3_rb_Inside_sales__c, ES3_rb_Oportunidad__c, 
                    ES3_rb_Opportunity_in_Credit_approval_CP__c, ES3_rb_Pricing__c, ES3_rb_Underwriter__c, 
                    ES3_sr_underWriter__c, ES3_tx_Appraisal__c, ES3_tx_Boot_Collateral__c, ES3_tx_IdPricingDuplicate__c, 
                    ES3_num_Ballon_Bullet_Payment__c, ES3_num_SD__c, ES3_pc_Opening_Fee__c, ES3_pc_P_Option__c, ES3_pc_RV__c, 
                    ES3_pc_Rate__c, BKL_lst_Prom_Note__c, BKL_pc_Lock_Fee__c, BKL_TXT_L_H_Description__c,
                    BKL_TXT_Model_Asset_Return_Condition__c, BKL_TXT_Progres_Description__c, BKL_txt_EOL_Option__c, 
                    BLG_at_Progress_Payment_details__c, BLG_at_SD_Comment__c,ES3_pc_Term_in_Months__c,ES3_pc_Term_in_months_without_PP__c, BLG_pr_SD_percent__c, ES3_tl_EBO_Description__c,
                    BKL_TXT_Asset__c, BKL_TXT_Return_Condition__c, ES3_pc_C_PELIGROSA__c, ES3_pc_CASH_COLLATERAL__c, ES3_pc_COLLECTION_RIGHTS__c,
                    ES3_pc_CROSS_COLLATERAL__c, ES3_pc_DIRECT_DEBIT__c
                    FROM ES3_obj_Pricing_in_Credit_Approval__c where  Id =:pricingInCaId ][0];
       
        }else{
            system.debug('Error: User is unauthorized to access to Pricing In CA');
        }

        return null;
    }
   
}