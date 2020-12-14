public class WS_OpportunityREST_Helper {
  
  public static Opportunity getOpportunityWithRelated(id opportunityId){
    Opportunity opp = [SELECT Id, IsDeleted, AccountId, RecordTypeId, Name, Description, StageName, 
    Amount, Probability, CloseDate, Type, NextStep, LeadSource, IsClosed, IsWon, ForecastCategory, 
    ForecastCategoryName, CurrencyIsoCode, CampaignId, HasOpportunityLineItem, IsSplit, Pricebook2Id, 
    OwnerId, LastActivityDate, FiscalQuarter, FiscalYear, Fiscal, ContactId, LastViewedDate, 
    LastReferencedDate, SyncedQuoteId, HasOpenActivity, HasOverdueTask, Budget_Confirmed__c, 
    Discovery_Completed__c, ROI_Analysis_Completed__c, IST__TrackingNumber__c, Loss_Reason__c, 
    OPP_at_No_document_Reason__c, OPP_ca_No_document__c, OPP_fh_Proposal_Signed_Received_Date__c, 
    OPP_fm_Credit_Approval_Status__c, OPP_fm_EditOpp__c, OPP_lm_Additional_Services__c, 
    OPP_ls_Broker_Fee_Commision__c, OPP_ls_Broker_name__c, OPP_ls_Collateral__c, 
    OPP_ls_Competitor_Floating_Fixed__c, OPP_ls_Competitor_Index__c, OPP_ls_Competitor_Is_the_main_lender__c, 
    OPP_ls_Competitor_Product__c, OPP_ls_Deal_Category__c, OPP_ls_Equipment_Condition__c, 
    OPP_ls_Equipment_Import_Required__c, OPP_ls_Financing_Need__c, OPP_ls_Import_Type__c, 
    OPP_ls_Insurance_Type__c, OPP_ls_Line_of_Business__c, OPP_ls_Marketing_Initiative_1__c, 
    OPP_ls_Marketing_Initiative_2__c, OPP_ls_Marketing_Initiative_3__c, OPP_ls_Of_sharing_reps__c, 
    OPP_ls_Opportunity_from_Broker__c, OPP_ls_Opportunity_from_Vendor__c, OPP_ls_Origin_of_equipment__c, 
    OPP_ls_Product__c, OPP_ls_Reason_Lost_Level_1__c, OPP_ls_Reason_Lost_Level_2__c, OPP_ls_Reason_Lost_Level_3__c,
    OPP_ls_Reason_Won_Level_1__c, OPP_ls_Reason_Won_Level_2__c, OPP_ls_Region__c, OPP_ls_Shadow_Split__c, 
    OPP_ls_Shared_Opportunity__c, OPP_ls_Sharing_Criteria__c, OPP_ls_Sharing_Type_2__c,
    OPP_ls_Sharing_Type_3__c, OPP_ls_Sharing_Type_4__c, OPP_ls_Vendor_Brand__c, OPP_ls_Vendor_Distributor__c, 
    OPP_ls_Vendor_Fee_Commision__c, OPP_ls_Vertical__c, OPP_na_Folio__c, OPP_pr_Broker_Fee_Commision__c, 
    OPP_pr_Sharing_1__c, OPP_pr_Sharing_2__c, OPP_pr_Sharing_3__c, OPP_pr_Sharing_4__c, OPP_pr_Vendor_Fee_Commision__c, 
    OPP_rb_Account_Name__c, OPP_rb_Broker_Name__c, OPP_rb_Closer__c, OPP_rb_Competitor__c, OPP_rb_Competitor_del__c, 
    OPP_rb_Credit_Approval__c, OPP_rb_Refered_by__c, OPP_rb_Share_Rep_1__c, OPP_rb_Share_Rep_2__c, OPP_rb_Share_Rep_3__c,
    OPP_rb_Share_Rep_4__c, OPP_tl_Competitor_comments__c, OPP_tl_Not_Signed_Proposal_Reason__c, OPP_tl_Won_Comments__c, 
    OPP_tx_Credit_Approval_Status__c, OPP_tx_EXT_REF_ID__c, OPP_tx_Lost_Comments__c, OPP_tx_Opportunity_Comments__c, 
    OPP_tx_Original_Owner__c, OPP_un_Amount_USD_Converted__c, OPP_un_Competitor_Spread_bps__c, 
    OPP_un_Competitor_Term_Months__c, OPP_un_Spread_Diff_vs_Competitor_in_bps__c, OPP_re_Pre_screening__c, 
    OPP_re_Pricing_Proposal__c, OPP_re_Takedown__c, OPP_fh_Original_Created_Date__c, OPP_tl_CommercialSupportComments__c, 
    OPP_fe_Lost_Date__c, OPP_tx_LostStage__c, OPP_tx_Lost_Date_Month__c, OPP_tx_Lost_Date_Q__c, OPP_tx_Lost_Date_Year__c, 
    LID__Is_Influenced__c, LID__LinkedIn_Company_Id__c, OPP_fh_Funded_Date__c, geopointe__Geocode__c, rrpu__Alert_Message__c, 
    QLIK_ls_Vendor_Branch__c, OPP_ls_Vendor_Rates_Subsides__c, OPP_ls_Vendor_Risk_Support__c, Latest_Funded_Takedown_Date__c, 
    CPL_ck_maybeProvidedAnotherCurrency__c, CPL_date_Expiration_Date__c, CPL_dv_Approved_Amount__c, CPL_nu_CA_Rate__c, 
    CPL_nu_Movement_in_credit_line__c, CPL_fm_Final_Balance__c, CPL_nu_TakeDowns_in_Opportunity__c, QLIK_ls_Vendor_Sales_Rep__c, 
    CPS2_da_Expected_1st_funding_date__c, CPIS2_tx_Collateral_Description__c, Approval_Date__c, Proposal_Date__c, Proposal_Awarded_Date__c, 
    Vendor_Type__c, In_Credit_Date__c, Backlog_Date__c, Current_Stage_Date__c, Indirect_Vertical__c, Indirect_Partner_Brand__c, 
    Credit_Approval_ID__c, X1st_Funded_Takedown_Date__c, Converted_Pipeline__c, CLI_fm_Pipeline_Amount__c, 
    Opportunity_Identified_Date__c, Aging_since_opportunity__c, Insurance_Manager_Comments__c, Aging_In_Credit_Backlog__c, 
    Created_Date_with__c, Reason_Engenium_Insurance_Lost__c, Lost_Date_Marketing__c, Lost_Stage_Marketing__c, 
    Opportunity_Owner_Engenium_Area_Logo__c, Opportunity_Owner_Engenium_Area_Header__c, ES3_fm_Amount_Numeric__c, 
    ES3_tx_Products_Approved__c, Exclude_Backlog_from_Pipeline_Report__c, Total_Units_Amount_MXN__c, 
    Fleet_This_Month_Forecast_Converted__c, MD_Carveout_in_CA__c, Core_Capital_Paid_Amount__c, Fleet_This_Month_Forecast_Funded__c, 
    MC3_dt_Original_Expiration_Date__c, ROI_approved__c, Target_Market__c, Approval_Level__c, LMM_Antecedentes_del_cliente__c, 
    LMM_Cliente_desde__c, LMM_ConcentracinenClientes__c, LMM_Condiciones_pre_y_post__c, LMM_Domiciliacion__c, LMM_Fecha_de_visita__c, 
    LMM_Findigs__c, LMM_Grupo_Economico__c, LMM_Imagen_11__c,LMM_Informacion_del_aval__c, LMM_Justificaci_n_de_la_solicitud__c, 
    LMM_Motivo_del_override__c, LMM_OR_RDE__c, LMM_Obligor__c, LMM_ls_Override__c,LMM_ls_Origen_del_cliente__c, 
    LMM_Recomendacion__c,LMM_ls_Tipo_de_cliente__c, LMM_Referencias_EC__c, LMM_Resultado_AGARSA__c, LMM_Resultado_de_validaciones__c, 
    LMM_Resumen_Buro_credito_y_legal__c, LMM_Risk_Class__c, LMM_Sic_Code_Description__c, LMM_Tipo_de_credito__c, 
    LMM_Underwriter__c, LMM_ca_risk_approval_process__c, LMM_ls_Anosenelnegocio__c, LMM_ls_Bur_Legal__c, LMM_ls_BurdeCrditoAval__c, 
    LMM_ls_BurodeCrditoRepresentativo__c, LMM_ls_Collateral_Gap__c, LMM_ls_ExpConClientesPrinc__c, LMM_ls_FCCR__c, LMM_ls_Garant_as_Adicionales__c, 
    LMM_ls_Industria__c, LMM_ls_LTVAdvancePaymentSD__c, LMM_ls_Tama_o_del_Deal__c, LMM_ls_TotaldebtVSEBITDA__c, LM_ls_Activaltamentemonetiz__c, 
    LM_ls_D_as_de_AR__c, SIC_code__c, LMM_Acciones_PG__c, LMM_Anos_de_experiencia_en_el_sector__c, LMM_Anos_experiencia_cliente_p__c, 
    LMM_Apalancamiento__c, LMM_Buro_Representativo__c, LMM_Calificacion_Aval_Principal__c, LMM_FCCR__c, LMM_Maxima_concentracion__c, 
    LMM_OR15_o_mejor__c, LMM_Ratio__c, LMM_Count_EcQuotes__c, LMM_Imagen_12__c, LMM_Stage__c, Pipeline_Amount_2__c, AML_Approval_Coments__c, 
    AML_Approved_By__c, LMM_Exposure_cliente__c, LMM_Status_AML__c, LMM_Status_Risk__c, LMM_Tipo_de_cambio__c, RecordType_Name__c, LMM_rb_KYC__c, 
    (SELECT Id, Name,Nombre_de_la_empresa__c,Tipo_de_Financiamiento__c,Monto_Total__c,Tasa_Activa__c,Book_Yield__c,CurrencyIsoCode,Pago_de_seguro__c,
    Pago__c FROM EC_Quotes__r),
    (SELECT Id,Name,RecordTypeId,ES3_rb_Entity__c,ES3_LST_Covenant_Cualitativo__c,ES3_lst_Covenant_Cuantitativo__c,ES3_lst_Condition__c 
    FROM Conditions_Services_Covenants__r), 
    (SELECT Id,Name,CLI_rb_Inside_Sales_Owner__c,TDAmount__c,CPL_dt_booking_date__c,TKD_fm_Opportunity_expiration_date__c,
    TKD_fm_Remaining_days_to_expiration_date__c FROM Takedowns_CPs1__r), 
    (SELECT Id, Name FROM KYCs__r) 
    FROM Opportunity WHERE Id =:opportunityId LIMIT 1];
    return opp;
  }
}