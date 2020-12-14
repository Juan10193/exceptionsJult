public without sharing class Data_Access_WOS_Opportunity_cls {
    public static Opportunity getOpportunityAllfields(id byId){
        Opportunity oportunity = new Opportunity();
   		for(Opportunity op : [SELECT Id, IsDeleted, AccountId, RecordTypeId, Name, Description, StageName, 
                              Amount, Probability, CloseDate, Type, NextStep, LeadSource, IsClosed, IsWon, 
                              ForecastCategory, ForecastCategoryName, CurrencyIsoCode, CampaignId, HasOpportunityLineItem, 
                              IsSplit, Pricebook2Id, OwnerId, CreatedDate, CreatedById, LastModifiedDate, 
                              LastModifiedById, SystemModstamp, LastActivityDate, FiscalQuarter, FiscalYear, 
                              Fiscal, ContactId, LastViewedDate, LastReferencedDate, SyncedQuoteId, HasOpenActivity, 
                              HasOverdueTask, Budget_Confirmed__c, Discovery_Completed__c, ROI_Analysis_Completed__c, 
                              IST__TrackingNumber__c, Loss_Reason__c, OPP_at_No_document_Reason__c, OPP_ca_No_document__c, 
                              OPP_fh_Proposal_Signed_Received_Date__c, OPP_fm_Credit_Approval_Status__c, 
                              OPP_fm_EditOpp__c, OPP_lm_Additional_Services__c, OPP_ls_Broker_Fee_Commision__c, 
                              OPP_ls_Broker_name__c, OPP_ls_Collateral__c, OPP_ls_Competitor_Floating_Fixed__c, 
                              OPP_ls_Competitor_Index__c, OPP_ls_Competitor_Is_the_main_lender__c, 
                              OPP_ls_Competitor_Product__c, OPP_ls_Deal_Category__c, OPP_ls_Equipment_Condition__c, 
                              OPP_ls_Equipment_Import_Required__c, OPP_ls_Financing_Need__c, OPP_ls_Import_Type__c, 
                              OPP_ls_Insurance_Type__c, OPP_ls_Line_of_Business__c, OPP_ls_Marketing_Initiative_1__c, 
                              OPP_ls_Marketing_Initiative_2__c, OPP_ls_Marketing_Initiative_3__c, OPP_ls_Of_sharing_reps__c, 
                              OPP_ls_Opportunity_from_Broker__c, OPP_ls_Opportunity_from_Vendor__c, OPP_ls_Origin_of_equipment__c, 
                              OPP_ls_Product__c, OPP_ls_Reason_Lost_Level_1__c, OPP_ls_Reason_Lost_Level_2__c, 
                              OPP_ls_Reason_Lost_Level_3__c, OPP_ls_Reason_Won_Level_1__c, OPP_ls_Reason_Won_Level_2__c, 
                              OPP_ls_Region__c, OPP_ls_Shadow_Split__c, OPP_ls_Shared_Opportunity__c, OPP_ls_Sharing_Criteria__c, 
                              OPP_ls_Sharing_Type_2__c, OPP_ls_Sharing_Type_3__c, OPP_ls_Sharing_Type_4__c, 
                              OPP_ls_Vendor_Brand__c, OPP_ls_Vendor_Distributor__c, OPP_ls_Vendor_Fee_Commision__c, 
                              OPP_ls_Vertical__c, OPP_na_Folio__c, OPP_pr_Broker_Fee_Commision__c, OPP_pr_Sharing_1__c, 
                              OPP_pr_Sharing_2__c, OPP_pr_Sharing_3__c, OPP_pr_Sharing_4__c, OPP_pr_Vendor_Fee_Commision__c, 
                              OPP_rb_Account_Name__c, OPP_rb_Broker_Name__c, OPP_rb_Closer__c, OPP_rb_Competitor__c, 
                              OPP_rb_Competitor_del__c, OPP_rb_Credit_Approval__c, OPP_rb_Refered_by__c, OPP_rb_Share_Rep_1__c, 
                              OPP_rb_Share_Rep_2__c, OPP_rb_Share_Rep_3__c, OPP_rb_Share_Rep_4__c, OPP_tl_Competitor_comments__c, 
                              OPP_tl_Not_Signed_Proposal_Reason__c, OPP_tl_Won_Comments__c, OPP_tx_Credit_Approval_Status__c, 
                              OPP_tx_EXT_REF_ID__c, OPP_tx_Lost_Comments__c, OPP_tx_Opportunity_Comments__c, OPP_tx_Original_Owner__c, 
                              OPP_un_Amount_USD_Converted__c, OPP_un_Competitor_Spread_bps__c, OPP_un_Competitor_Term_Months__c, 
                              OPP_un_Spread_Diff_vs_Competitor_in_bps__c, OPP_re_Pre_screening__c, OPP_re_Pricing_Proposal__c, 
                              OPP_re_Takedown__c, OPP_fh_Original_Created_Date__c, OPP_tl_CommercialSupportComments__c, 
                              OPP_fe_Lost_Date__c, OPP_tx_LostStage__c, OPP_tx_Lost_Date_Month__c, OPP_tx_Lost_Date_Q__c, 
                              OPP_tx_Lost_Date_Year__c, LID__Is_Influenced__c, LID__LinkedIn_Company_Id__c, OPP_fh_Funded_Date__c, 
                              geopointe__Geocode__c, rrpu__Alert_Message__c, QLIK_ls_Vendor_Branch__c, 
                              OPP_ls_Vendor_Rates_Subsides__c, OPP_ls_Vendor_Risk_Support__c, Latest_Funded_Takedown_Date__c, 
                              CPL_ck_maybeProvidedAnotherCurrency__c, CPL_date_Expiration_Date__c, CPL_dv_Approved_Amount__c, 
                              CPL_nu_CA_Rate__c, CPL_nu_Movement_in_credit_line__c, CPL_fm_Final_Balance__c, 
                              CPL_nu_TakeDowns_in_Opportunity__c, QLIK_ls_Vendor_Sales_Rep__c, CPS2_da_Expected_1st_funding_date__c, 
                              CPIS2_tx_Collateral_Description__c, Approval_Date__c, Proposal_Date__c, Proposal_Awarded_Date__c, 
                              In_Credit_Date__c, Backlog_Date__c, Current_Stage_Date__c, Indirect_Vertical__c, Indirect_Partner_Brand__c, 
                              Credit_Approval_ID__c, X1st_Funded_Takedown_Date__c, Converted_Pipeline__c, CLI_fm_Pipeline_Amount__c, 
                              Opportunity_Identified_Date__c, Aging_since_opportunity__c, Insurance_Manager_Comments__c, 
                              Aging_In_Credit_Backlog__c, Created_Date_with__c, Reason_Engenium_Insurance_Lost__c, Lost_Date_Marketing__c,
                              Lost_Stage_Marketing__c, Opportunity_Owner_Engenium_Area_Logo__c, Opportunity_Owner_Engenium_Area_Header__c, 
                              ES3_fm_Amount_Numeric__c, ES3_tx_Products_Approved__c, Exclude_Backlog_from_Pipeline_Report__c, 
                              Total_Units_Amount_MXN__c, Fleet_This_Month_Forecast_Converted__c, Core_Capital_Paid_Amount__c, 
                              Fleet_This_Month_Forecast_Funded__c, MC3_dt_Original_Expiration_Date__c, ROI_approved__c 
                              FROM Opportunity WHERE Id = :byId]){
                                  oportunity = op;
                              }
        return oportunity;
    }

}