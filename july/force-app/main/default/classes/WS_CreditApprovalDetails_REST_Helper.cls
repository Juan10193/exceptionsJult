public class WS_CreditApprovalDetails_REST_Helper {
  public CaDetails creditApproval {get;set;}


  public WS_CreditApprovalDetails_REST_Helper (id creditApprovalId){
    Cadetails creditApproval = new Cadetails();
    creditApproval.caDetails = getCreditApproval(creditApprovalId);
    Credit_approval_CP__c caRelated = getRelatedList(creditApprovalId);
    creditApproval.carveoutsInCa = caRelated.Carveout_in_Credit_Approval_CP__r;
    creditApproval.creditApprovalHistory = caRelated.Histories;
    creditApproval.entitysMasterInCa = caRelated.Entites_Master_in_Credit_Approval__r;
    creditApproval.conditionsAndCovenants = caRelated.Conditions_Services_Covenants__r;
    creditApproval.pricingsInCA = caRelated.Pricings_in_Credit_Approval__r;
    creditApproval.opportunitiesInCa = caRelated.Opps_in_Credit_approval__r;
    creditApproval.exceptionsToGoInCA = caRelated.ExceptionsToGo__r;
    this.creditApproval = creditApproval;
  }


  public Credit_approval_CP__c getCreditApproval(id creditApprovalId){
    Credit_approval_CP__c ca = [SELECT Id,OwnerId,IsDeleted,Name,CurrencyIsoCode,RecordTypeId,LastActivityDate,LastViewedDate,LastReferencedDate,
    CPL_lm_Documentos_HandOff__c,CPL_ls_DocumentsForUnderwriting__c,CPL_rb_EntityCP__c,CPL_rb_MOD_de_Credit_approval_CP__c,
    CPL_rb_account__c,Exposure__c,CPL_fm_Opportunities_Exposure__c,CPL_ls_StageName__c,Type_of_credit_approval__c,
    CPL_fm_Amount_of_opportunities__c,CPL_fm_Opportunities_in_credit_approval__c,CPI_Date_Questionary_sent_date__c,
    CPI_ck_FueAprobado__c,CPI_ck_ItMayBeProvidedInAnotherCurrency__c,CPI_date_Questionary_Received__c,CPI_fh_Proposal_Signed_Received_Date__c,
    CPI_fm_SIC_Code_Description__c,CPI_ls_Reason_Lost_Level_1__c,CPI_ls_Reason_Lost_Level_2__c,CPI_ls_Reason_Lost_Level_3__c,
    CPI_ls_Reason_Won_Level_1__c,CPI_ls_Reason_Won_Level_2__c,CPI_nu_CA_Rate_c__c,CPI_rb_Competitor__c,CPI_rb_OR_Override__c,
    CPI_rb_OR_rating__c,CPI_rb_Risk_Classification__c,CPI_rb_SIC_code__c,CPI_tx_Customer_Since__c,CPI_tx_Lost_Comments__c,
    CPI_tx_Not_Signed_Proposal_Reason__c,CPI_tx_OR_ID__c,CPI_tx_Risk_Economic_Group__c,CPI_tx_Won_Comments__c,CPI_un_Capex_Exposure__c,
    CPI_un_Fleet_Exposure__c,CPI_un_Real_Estate_Exposure__c,CPI_un_Technology_Exposure__c,CPL_ls_OR_Source__c,Risk_INtern__c,
    Risk_Analyst__c,Inside_Sales__c,Sr_Underwriter__c,Approval_Level__c,ROI__c,On_Hold_Reason__c,On_Hold_Comments__c,
    Additional_Approved_Products__c,Decision_Date__c,Credit_Approval_Unique_Count__c,Government__c,of_Government_Revenues__c,
    Government_Level__c,Override_Reason__c,ES2_re_Guarantor__c,ES2_re_Obligor__c,ES2_re_Risk_Desicion_Entity__c,Covenants__c,
    DoctypesWarning__c,Doctypes__c,ES3_Approve_WC_Comments__c,ES3_CA_Comments__c,ES3_Choose_AML_approval_type__c,
    ES3_Cierre_de_Credit_Approval__c,ES3_Set_on_Hold_AML__c,ES3_TX_HNWI_ID__c,ES3_TX_MRA_ID__c,ES3_Type_of_CA_MAC__c,ES3_fm_CurrentURL__c,
    ES3_fm_Customer_Since__c,ES3_fm_Level_OR_Rating__c,ES3_fm_Total_Opportunities_USD__c,ES3_fr_User_identifier__c,ES3_ls_AML_Review_Status__c,
    ES3_ls_EBO__c,ES3_ls_EFA__c,ES3_ls_Low_High_High_Low__c,ES3_ls_Nivel_1__c,ES3_ls_Nivel_2__c,ES3_ls_Nivel_3__c,ES3_ls_Nivel_4__c,ES3_ls_Nivel_5__c,
    ES3_ls_Progress_Payments__c,ES3_ls_RISK_REVIEW_STATUS__c,ES3_ls_SL_B_YES_NO__c,ES3_ls_Type_of_Grace_Period__c,ES3_ls_Used_New__c,
    ES3_mpl_AML_Declined_reason__c,ES3_mpl_On_Hold_Reason__c,ES3_mpl_RISK_Declined_Reason__c,ES3_mpl_RISK_On_Hold_Reason__c,
    ES3_nu_Advance_Payment__c,ES3_nu_Grace_Period_in_Months__c,ES3_nu_Progress_Payments_M__c,ES3_nu_ROI_No_Insurance__c,
    ES3_nu_Total_Opportunities_USD_for_Level__c,ES3_pc_Remarketing_Fee__c,ES3_pc_Split_Trac__c,ES3_pc_Trac__c,
    ES3_pl_AML_Declined_Comment__c,ES3_pl_AML_Rework_Types__c,ES3_pl_AML_Rework_reason__c,ES3_pl_AML_tomado__c,ES3_pl_Choose_RISK_approval_type__c,
    ES3_pl_Rework_Types__c,ES3_pl_Risk_Rework_reason__c,ES3_pl_Send_to_RISK__c,ES3_pl_Send_to_rework_AML__c,ES3_pl_Send_to_rework__c,
    ES3_pl_Sent_to_AML__c,ES3_pl_Set_on_Hold__c,ES3_pl_Submit_for_approval__c,ES3_pl_Tomar_CA_para_RISK_Review__c,ES3_rb_Legal_Team_Member__c,
    ES3_rb_Pricing__c,ES3_select_the_type_of_approval__c,ES3_tx_AML_On_Hold_Comment__c,ES3_tx_AML_Rework_Comment__c,ES3_tx_Account_Name__c,
    ES3_tx_Appraisal__c,ES3_tx_Bloomberg_ID__c,ES3_tx_Boot_Collateral__c,ES3_tx_Original_recordType__c,ES3_tx_RISK_Declined_Comment__c,
    ES3_tx_RISK_On_Hold_Comment__c,ES3_tx_Risk_Economic_Group_Id__c,ES3_tx_Risk_Rework_Comment__c,ES3_tx_Top_Parent_Name__c,RecordType_List__c,
    SP3_nu_Process_Builder_Trigger__c,SP3_pl_Credit_Approval_Status__c,SP3_pl_Send_for_Approval__c,ES3_rm_Total_opportunities_in_MXN__c,
    ES3_rm_Total_opportunities_in_USD__c,ES3_num_Ballon_Bullet_Payment__c,ES3_num_SD__c,ES3_pc_Opening_Fee__c,ES3_pc_P_Option__c,ES3_pc_RV__c,
    ES3_pc_Rate__c,bkl_ls_vendor__c,BKL_lst_Prom_Note__c,BKL_pc_Lock_Fee__c,BKL_TXT_Credit_Approval_Summary__c,BKL_TXT_L_H_Description__c,
    BKL_TXT_Model_Asset_Return_Condition__c,BKL_TXT_Progres_Description__c,BKL_txt_EOL_Option__c,BLG_at_SD_Comment__c,BLG_pr_SD_percent__c,
    ES3_tl_EBO_Description__c,MC3_date_New_Expiration_Date__c,Type_of_credit_approval_Workout__c,MD_Current_Exposure__c,MD_at_Description__c,
    MD_at_Endorsement__c,MD_at_Financial_Inf_Summary__c,MD_at_Structure_comments__c,MD_ca_AddOn__c,MD_ca_Carveout__c,MD_ca_Incremental__c,
    MD_ca_MODMAC__c,MD_date_Fecha_Vigencia__c,MD_fh_Bil__c,MD_fh_CBureau__c,MD_fh_FiscalSituation__c,MD_fh_Google_Search__c,MD_fh_New_Validity_Date__c,
    MD_fh_PaymentTrend_Date__c,MD_fh_Visit__c,MD_ls_Bil_Pass__c,MD_ls_CBureau_Pass__c,MD_ls_FiscalSituation_Pass__c,MD_ls_Google_Search__c,
    MD_ls_PaymentTrend_Pass__c,MD_ls_Structure__c,MD_ls_Visit_Pass__c,MD_te_img_1__c,MD_te_img_2__c,MD_tl_Background__c,MD_tl_Bil_Comments__c,
    MD_tl_CBureau_Comments__c,MD_tl_Comments_Visit__c,MD_tl_FiscalSituation__c,MD_tl_Google_Search__c,MD_tl_Last_Approved_Int__c,
    MD_tl_PaymentTrend_Comments__c,MD_tl_Rationale__c,MD_tl_Request__c,MD_tx_Advance_Rent__c,MD_tx_EC_Insurance_Financed__c,MD_tx_Gross_Margin__c,
    MD_un_Exchange_Rate__c,MOD_Carveount_In_Ca__c,MD_fm_CP_Final_Balance__c,MD_fm_Final_Balance_USD__c,BKL_TXT_Asset__c,BKL_TXT_Return_Condition__c,
    ES3_pc_CASH_COLLATERAL__c,ES3_pc_COLLECTION_RIGHTS__c,ES3_pc_CROSS_COLLATERAL__c,ES3_pc_C_PELIGROSA__c,ES3_pc_DIRECT_DEBIT__c,
    ES3_pc_Frequency_Monthly_Quarterly__c,ES3_pc_Term_in_Months__c,ES3_pc_Term_in_months_without_PP__c,obligor_s__c FROM Credit_approval_CP__c
    WHERE Id =:creditApprovalId LIMIT 1];
    return ca;
  }

  public Credit_approval_CP__c getRelatedList(id creditApprovalId){
    Credit_approval_CP__c ca =[SELECT Id, Name, (SELECT Id,IsDeleted,Name,CurrencyIsoCode,LastActivityDate,LastViewedDate,
    LastReferencedDate,MD_Opportunity__c,MD_rls_Credit_approval__c,MD_Amount__c,MD_Opp_use_by_carveaut__c,MD_chec_Copy_Date_MAC__c,
    MD_date_Date__c,MD_fm_Restado__c,MD_fm_Sumado__c,MD_num_Destination_Amount__c,MD_rl_Destination_Opportunity__c,Opportunity__c,Opportunity_in_CA__c
    ,count_carvaut__c FROM Carveout_in_Credit_Approval_CP__r),(SELECT ParentId, OldValue, NewValue, Field, CreatedById, CreatedDate FROM Histories),
    (SELECT Id,IsDeleted,Name,CurrencyIsoCode,LastActivityDate,ES2_rb_Credit_approval__c,ES2_fm_Desicion_Entity__c,ES2_fm_Entity__c,ES2_fm_Garantor__c,
    ES2_fm_Obligor__c,ES2_ms_Role__c,ES2_tx_CostumerType__c,ES2_tx_Oracle_Account_Name__c,ES2_tx_Party_Id__c,ES2_tx_TopParentID__c,ES2_tx_TopParetName__c,
    ES2_tx_pageVF__c,ES2_url_Entity_Master__c,ES3_rb_Opportunity__c,ES3_rb_Opportunity_in_Credit_approval_CP__c,ES3_tx_BloombergID__c,ES3_tx_Entity_Name__c,
    ES3_tx_HNWI_ID__c,ES3_tx_MRAID__c,ES3_tx_Or_Rating__c,ES3_tx_Risk_Classification__c,ES3_tx_Transaction_Date__c,ES3_txt_CRR_Override__c,ES3_txt_CRR__c,
    ES3_txt_SIC_Code__c,ES3_txt_SIC_Description__c,ES2_Resolve_Comment__c,ES2_Unresolved_Items__c,ES2_chk_Adverse_Media__c,ES2_txt_Hit_Description__c,
    Status_Color__c,ES3_rb_Carveout_in_CA_inCredit__c,JR_Txt_Top_Parent_Name__c,TKD_txt_RFC__c FROM Entites_Master_in_Credit_Approval__r),
    (SELECT Id,OwnerId,IsDeleted,Name,CurrencyIsoCode,RecordTypeId,LastActivityDate,ES3_DATE_Date__c,ES3_LST_Applies_To__c,ES3_LST_Covenant_Cualitativo__c,
    ES3_LST_Review__c,ES3_LT_Min_Max__c,ES3_LT_Timing_Cualitativo__c,ES3_LT_Timing_Cuantitativo__c,ES3_TXT_Description__c,ES3_TXT_Threshold__c,ES3_TX_Other__c,
    ES3_lst_Condition__c,ES3_lst_Covenant_Cuantitativo__c,ES3_lst_Services__c,ES3_lt_Status__c,ES3_lt_Timing__c,ES3_rb_Credit_approval_CP__c,ES3_rb_Entity__c,
    ES3_rb_Inside_sales__c,ES3_rb_Oportunidad__c,ES3_rb_Opportunity_in_Credit_approval_CP__c,ES3_rb_Sr_UnderWriter__c,ES3_rb_Underwriter__c,ES3_tx_Coments__c,
    ES3_tx_CurrentURL__c,ES3_txt_Service_Comments__c  FROM Conditions_Services_Covenants__r),
    (SELECT Id,OwnerId,IsDeleted,Name,CurrencyIsoCode,LastActivityDate,ES3_fm_CurrentURL__c,ES3_fm_P_option__c,ES3_fm_Pricing_Super_Trump__c,ES3_fm_RV__c,
    ES3_ls_EBO__c,ES3_ls_EFA__c,ES3_ls_Low_High_High_Low__c,ES3_ls_Progress_Payments__c,ES3_ls_SL_B_YES_NO__c,ES3_ls_Type_of_Grace_Period__c,
    ES3_ls_Used_New__c,ES3_nu_Advance_PaymentPercent__c,ES3_nu_Grace_Period_in_Months__c,ES3_nu_Progress_Payments_M__c,ES3_nu_ROI_No_Insurance__c,
    ES3_pc_Remarketing_Fee_Percent__c,ES3_pc_Split_Trac_Percentent__c,ES3_pc_Trac_Percent__c,ES3_rb_Credit_approval_CP__c,ES3_rb_Inside_sales__c,
    ES3_rb_Oportunidad__c,ES3_rb_Opportunity_in_Credit_approval_CP__c,ES3_rb_Pricing__c,ES3_rb_Underwriter__c,ES3_sr_underWriter__c,ES3_tx_Appraisal__c,
    ES3_tx_Boot_Collateral__c,ES3_tx_IdPricingDuplicate__c,ES3_num_Ballon_Bullet_Payment__c,ES3_num_SD__c,ES3_pc_Opening_Fee__c,ES3_pc_P_Option__c,
    ES3_pc_RV__c,ES3_pc_Rate__c,BKL_lst_Prom_Note__c,BKL_pc_Lock_Fee__c,BKL_TXT_L_H_Description__c,BKL_TXT_Model_Asset_Return_Condition__c,
    BKL_TXT_Progres_Description__c,BKL_txt_EOL_Option__c,BLG_at_Progress_Payment_details__c,BLG_at_SD_Comment__c,BLG_pr_SD_percent__c,
    ES3_tl_EBO_Description__c,MD_Carveout_in_CA__c,BKL_TXT_Asset__c,BKL_TXT_Return_Condition__c,ES3_UnderWriter__c,ES3_pc_CASH_COLLATERAL__c,
    ES3_pc_COLLECTION_RIGHTS__c,ES3_pc_CROSS_COLLATERAL__c,ES3_pc_C_PELIGROSA__c,ES3_pc_DIRECT_DEBIT__c,ES3_pc_Frequency_Monthly_Quarterly__c,
    ES3_pc_Term_in_Months__c,ES3_pc_Term_in_months_without_PP__c FROM Pricings_in_Credit_Approval__r),
    (SELECT Id,IsDeleted,Name,CurrencyIsoCode,LastActivityDate,CP_rb_Credit_approval_CP__c,CPL_dv_AmountOPP__c,CP_rb_Oportunidad__c,
    CPL_tx_Opp_validate_Duplicado__c,CPL_tx_Opp_validate_Duplicado_del__c,ES3_ck_Itmaybeprovidedinanothercurrency__c,ES3_fm_Account_Name__c,
    ES3_fm_Additional_Services__c,ES3_fm_Collateral__c,ES3_fm_CreditApproval_RecordType__c,ES3_fm_Line_of_Business__c,ES3_fm_Opportunity_Name__c,
    ES3_fm_Product_In_Opportunity__c,ES3_nu_Amount_Numeric__c,ES3_nu_Pricings_in_Opportunity__c,Products__c,BKL_fm_Opportunity_from_Broker__c,
    MD_Carveout_in_CA__c,MD_Sum_Increment__c,MD_Sumado_AddOn__c,MD_div_Amount_Increment__c,MD_ls_Type_Credit_MOD__c,Create_Date_Opp__c 
    FROM Opps_in_Credit_approval__r),
    (SELECT Id,OwnerId,IsDeleted,Name,CurrencyIsoCode,RecordTypeId,LastViewedDate,LastReferencedDate,Takedown_CP__c,Document_Type__c,
    Reason_for_Exception__c,Approver__c,Requester_Comments__c,Approver_Comments__c,Stage__c,Due_Date__c,Status__c,Takedown_Amount__c,Customer_Name__c,
    Takedown_Amount_USD__c,Service_Level_Agreement_Days__c,Takedown_Status__c,Commitment_Date__c,Close_Date__c,Blanket_Insurance_Policy_Type__c,
    Blanket_Insurance_Policy_Start_Date__c,Blanket_Insurance_Policy_End_Date__c,Blanket_Insurance_Policy_Aging__c,Exception_Type__c,
    Sr_Underwriter__c,Control_Desk_Analyst__c,Product__c,Supplier_Customer__c,Other_Approver__c,No_Remediation_Details__c,
    No_Remdiation_Approver_Comments__c,Approve_Date__c,Days_Open__c,Closing_Bucket__c,Credit_Approval__c,Is_postfounding__c FROM ExceptionsToGo__r)
    FROM Credit_approval_CP__c where id =:creditApprovalId LIMIT 1];
    return ca;
  }

  public class CaDetails{
    public Credit_approval_CP__c caDetails                                          {get;set;}
    public list<Carveout_in_Credit_Approval_CP__c> carveoutsInCa                    {get;set;}
    public list<Credit_approval_CP__History> creditApprovalHistory                  {get;set;}
    public list<ES2_Obj_EntityMasterInCreditApproval__c> entitysMasterInCa          {get;set;}
    public list<ES3_obj_Condition_Service_covenant__c> conditionsAndCovenants       {get;set;}
    public list<ES3_obj_Pricing_in_Credit_Approval__c> pricingsInCA                 {get;set;}
    public list<Opportunity_in_Credit_approval_CP__c> opportunitiesInCa             {get;set;}
    public list<WaiverToGo__c> exceptionsToGoInCA                                   {get;set;}
  }
}