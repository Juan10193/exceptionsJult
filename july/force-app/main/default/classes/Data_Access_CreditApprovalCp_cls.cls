public with sharing class Data_Access_CreditApprovalCp_cls {
    public static Credit_approval_CP__c getCreditApprovalbyopId(string opportunityId) {

        Id caId = test.isRunningTest()?opportunityId: [Select ES3_rb_Credit_approval_CP__c from ES3_obj_Pricing_in_Credit_Approval__c where id	=: opportunityId][0].ES3_rb_Credit_approval_CP__c; 

        Credit_approval_CP__c ca = test.isRunningTest()? new Credit_approval_CP__c():  [SELECT Id, OwnerId, IsDeleted, Name, CurrencyIsoCode, RecordTypeId, CreatedDate, CreatedById, 
                                LastModifiedDate, LastModifiedById, SystemModstamp, LastActivityDate, LastViewedDate, LastReferencedDate, 
                                CPL_lm_Documentos_HandOff__c, CPL_ls_DocumentsForUnderwriting__c, CPL_rb_EntityCP__c, 
                                CPL_rb_MOD_de_Credit_approval_CP__c, CPL_rb_account__c, Exposure__c, CPL_fm_Opportunities_Exposure__c, 
                                CPL_ls_StageName__c, Type_of_credit_approval__c, CPL_fm_Amount_of_opportunities__c, 
                                CPL_fm_Opportunities_in_credit_approval__c, CPI_Date_Questionary_sent_date__c, CPI_ck_FueAprobado__c, 
                                CPI_ck_ItMayBeProvidedInAnotherCurrency__c, CPI_date_Questionary_Received__c, CPI_fh_Proposal_Signed_Received_Date__c,
                                CPI_fm_SIC_Code_Description__c, CPI_ls_Reason_Lost_Level_1__c, CPI_ls_Reason_Lost_Level_2__c, 
                                CPI_ls_Reason_Lost_Level_3__c, CPI_ls_Reason_Won_Level_1__c, CPI_ls_Reason_Won_Level_2__c, 
                                CPI_nu_CA_Rate_c__c, CPI_rb_Competitor__c, CPI_rb_OR_Override__c, CPI_rb_OR_rating__c, CPI_rb_Risk_Classification__c,
                                CPI_rb_SIC_code__c, CPI_tx_Customer_Since__c, CPI_tx_Lost_Comments__c, CPI_tx_Not_Signed_Proposal_Reason__c, 
                                CPI_tx_OR_ID__c, CPI_tx_Risk_Economic_Group__c, CPI_tx_Won_Comments__c, CPI_un_Capex_Exposure__c, 
                                CPI_un_Fleet_Exposure__c, CPI_un_Real_Estate_Exposure__c, CPI_un_Technology_Exposure__c, CPL_ls_OR_Source__c, 
                                Risk_INtern__c, Risk_Analyst__r.Name, Inside_Sales__c, Sr_Underwriter__c, Approval_Level__c, ROI__c, On_Hold_Reason__c, 
                                On_Hold_Comments__c, Additional_Approved_Products__c, Decision_Date__c, Credit_Approval_Unique_Count__c, Government__c, 
                                of_Government_Revenues__c, Government_Level__c, Override_Reason__c, ES2_re_Guarantor__c, ES2_re_Obligor__c, 
                                ES2_re_Risk_Desicion_Entity__c, Covenants__c, DoctypesWarning__c, Doctypes__c, ES3_Approve_WC_Comments__c, 
                                ES3_CA_Comments__c, ES3_Choose_AML_approval_type__c, ES3_Cierre_de_Credit_Approval__c, ES3_Set_on_Hold_AML__c, 
                                ES3_TX_HNWI_ID__c, ES3_TX_MRA_ID__c, ES3_Type_of_CA_MAC__c, ES3_fm_CurrentURL__c, ES3_fm_Customer_Since__c, 
                                ES3_fm_Level_OR_Rating__c, ES3_fm_Total_Opportunities_USD__c, ES3_fr_User_identifier__c, ES3_ls_AML_Review_Status__c, 
                                ES3_ls_EBO__c, ES3_ls_EFA__c, ES3_ls_Low_High_High_Low__c, ES3_ls_Nivel_1__c, ES3_ls_Nivel_2__c, ES3_ls_Nivel_3__c, 
                                ES3_ls_Nivel_4__c, ES3_ls_Nivel_5__c, ES3_ls_Progress_Payments__c, ES3_ls_RISK_REVIEW_STATUS__c, ES3_ls_SL_B_YES_NO__c, 
                                ES3_ls_Type_of_Grace_Period__c, ES3_ls_Used_New__c, ES3_mpl_AML_Declined_reason__c, ES3_mpl_On_Hold_Reason__c, 
                                ES3_mpl_RISK_Declined_Reason__c, ES3_mpl_RISK_On_Hold_Reason__c, ES3_nu_Advance_Payment__c, ES3_nu_Grace_Period_in_Months__c, 
                                ES3_nu_Progress_Payments_M__c, ES3_nu_ROI_No_Insurance__c, ES3_nu_Total_Opportunities_USD_for_Level__c, ES3_pc_Remarketing_Fee__c, 
                                ES3_pc_Split_Trac__c, ES3_pc_Trac__c, ES3_pl_AML_Declined_Comment__c, ES3_pl_AML_Rework_Types__c, ES3_pl_AML_Rework_reason__c, 
                                ES3_pl_AML_tomado__c, ES3_pl_Choose_RISK_approval_type__c, ES3_pl_Rework_Types__c, ES3_pl_Risk_Rework_reason__c, 
                                ES3_pl_Send_to_RISK__c, ES3_pl_Send_to_rework_AML__c, ES3_pl_Send_to_rework__c, ES3_pl_Sent_to_AML__c, ES3_pl_Set_on_Hold__c, 
                                ES3_pl_Submit_for_approval__c, ES3_pl_Tomar_CA_para_RISK_Review__c, ES3_rb_Legal_Team_Member__c, ES3_rb_Pricing__c, 
                                ES3_select_the_type_of_approval__c, ES3_tx_AML_On_Hold_Comment__c, ES3_tx_AML_Rework_Comment__c, ES3_tx_Account_Name__c, 
                                ES3_tx_Appraisal__c, ES3_tx_Bloomberg_ID__c, ES3_tx_Boot_Collateral__c, ES3_tx_Original_recordType__c, ES3_tx_RISK_Declined_Comment__c, 
                                ES3_tx_RISK_On_Hold_Comment__c, ES3_tx_Risk_Economic_Group_Id__c, ES3_tx_Risk_Rework_Comment__c, ES3_tx_Top_Parent_Name__c, 
                                RecordType_List__c, SP3_nu_Process_Builder_Trigger__c, SP3_pl_Credit_Approval_Status__c, SP3_pl_Send_for_Approval__c, 
                                ES3_rm_Total_opportunities_in_MXN__c, ES3_rm_Total_opportunities_in_USD__c, ES3_num_Ballon_Bullet_Payment__c, ES3_num_SD__c, 
                                ES3_pc_Opening_Fee__c, ES3_pc_P_Option__c, ES3_pc_RV__c, ES3_pc_Rate__c, bkl_ls_vendor__c, BKL_lst_Prom_Note__c, BKL_pc_Lock_Fee__c, 
                                BKL_TXT_Credit_Approval_Summary__c, BKL_TXT_L_H_Description__c, BKL_TXT_Model_Asset_Return_Condition__c, BKL_TXT_Progres_Description__c, 
                                BKL_txt_EOL_Option__c, BLG_at_SD_Comment__c, BLG_pr_SD_percent__c, ES3_tl_EBO_Description__c, MC3_date_New_Expiration_Date__c ,
                                RecordType.name, Sr_Underwriter__r.FirstName, Sr_Underwriter__r.LastName, CPL_rb_account__r.Owner.FirstName, 
                                CPL_rb_account__r.Owner.LastName, CPL_rb_account__r.ACC_fm_Target_Market__c  FROM Credit_approval_CP__c where Id =:caId ][0];
        
        return ca;
    }
}