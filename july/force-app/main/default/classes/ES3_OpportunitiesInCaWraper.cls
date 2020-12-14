public class ES3_OpportunitiesInCaWraper{
    
    public List<Opportunity_in_Credit_approval_CP__c> 	    oppInCaOriginals	{get;set;}   
    
    public Opportunity_in_Credit_approval_CP__c             oppInCa             {get;set;}
    
    //Pricings
    public List<ES3_obj_Pricing_in_Credit_Approval__c>      pricings            {get;set;}
    
    //Entities dentro de una opportunity
    public List<ES2_Obj_EntityMasterInCreditApproval__c>    entityInCa          {get;set;}
    
    //SpecialConditions
    public List<ES3_obj_Condition_Service_covenant__c>      specialCondition    {get;set;}

    //covenants
    public List<ES3_obj_Condition_Service_covenant__c>      covenants           {get;set;}
    
    public   Carveout_in_Credit_Approval_CP__c             OppInCarveout {get;set;}

    
    public ES3_OpportunitiesInCaWraper(Opportunity_in_Credit_approval_CP__c oppInCa)
    {
        this.oppInCa = oppInCa;
        system.debug('oppInCa OEJ:' + oppInCa);
        cargaPricing();
        cargaEntities();
        cargaCAndC();
    }
    
    public ES3_OpportunitiesInCaWraper(Id oppInCaId)
    {
        try{
        cargaOppInCa(oppInCaId); 
        system.debug('oppInCaId OEJ:' + oppInCaId);
        cargaPricing();
        cargaEntities();
        cargaCAndC();
        CargaOppsInCaOriginal();
        }
                catch(Exception e)
        {
            
        }
    }  
    
    public void CargaOppsInCaOriginal()
    {
        this.oppInCaOriginals = new List<Opportunity_in_Credit_approval_CP__c>();
            
        try{
        this.oppInCaOriginals =    [ Select id, 
                                    CP_rb_Oportunidad__c, 
                                    CP_rb_Oportunidad__r.name, 
                                    CP_rb_Credit_approval_CP__c, 
                                    CP_rb_Credit_approval_CP__r.name,
                                    CP_rb_Credit_approval_CP__r.Approval_Level__c, CP_rb_Credit_approval_CP__r.MC3_date_New_Expiration_Date__c,
                                    CP_rb_Credit_approval_CP__r.RecordTypeId, CP_rb_Credit_approval_CP__r.RecordType.name, CP_rb_Credit_approval_CP__r.Decision_Date__c, 
                                    CP_rb_Credit_approval_CP__r.ES3_CA_Comments__c, toLabel(CP_rb_Credit_approval_CP__r.Type_of_credit_approval__c),

                                    CP_rb_Credit_approval_CP__r.CPI_tx_Risk_Economic_Group__c, CP_rb_Credit_approval_CP__r.CPI_tx_Customer_Since__c, 
                                    CP_rb_Credit_approval_CP__r.CPI_rb_SIC_code__c, CP_rb_Credit_approval_CP__r.CPI_rb_SIC_code__r.name, CP_rb_Credit_approval_CP__r.CPI_fm_SIC_Code_Description__c, CP_rb_Credit_approval_CP__r.Government__c,
                                    CP_rb_Credit_approval_CP__r.Government_Level__c, CP_rb_Credit_approval_CP__r.of_Government_Revenues__c, CP_rb_Credit_approval_CP__r.CPI_rb_Risk_Classification__c, CP_rb_Credit_approval_CP__r.CPI_rb_Risk_Classification__r.name

                                    from Opportunity_in_Credit_approval_CP__c 
                                    where CP_rb_Oportunidad__c =: oppInCa.CP_rb_Oportunidad__c and 
                                    CP_rb_Credit_approval_CP__r.Type_of_credit_approval__c !=:'MAC'
                                   ];
        }
        catch(Exception e)
        {
            
        }
        
      
    }
    
    public Credit_approval_CP__c getCreditApproval()
    {    
        Credit_approval_CP__c CAparent = new Credit_approval_CP__c();
        try{
            CAparent = [Select Id, OwnerId, Name, CurrencyIsoCode, RecordTypeId, CreatedDate, CreatedById, CPL_lm_Documentos_HandOff__c, 
                        CPL_ls_DocumentsForUnderwriting__c, CPL_rb_EntityCP__c, CPL_rb_MOD_de_Credit_approval_CP__c, CPL_rb_account__c, 
                        Exposure__c, CPL_fm_Opportunities_Exposure__c, CPL_ls_StageName__c, Type_of_credit_approval__c, 
                        CPL_fm_Amount_of_opportunities__c, CPL_fm_Opportunities_in_credit_approval__c, CPI_Date_Questionary_sent_date__c, 
                        CPI_ck_FueAprobado__c, CPI_ck_ItMayBeProvidedInAnotherCurrency__c, CPI_date_Questionary_Received__c, 
                        CPI_fh_Proposal_Signed_Received_Date__c, CPI_fm_SIC_Code_Description__c, CPI_ls_Reason_Lost_Level_1__c, 
                        CPI_ls_Reason_Lost_Level_2__c, CPI_ls_Reason_Lost_Level_3__c, CPI_ls_Reason_Won_Level_1__c, CPI_ls_Reason_Won_Level_2__c, 
                        CPI_nu_CA_Rate_c__c, CPI_rb_Competitor__c, CPI_rb_OR_Override__c, CPI_rb_OR_rating__c, CPI_rb_Risk_Classification__c, 
                        CPI_rb_SIC_code__c, CPI_tx_Customer_Since__c, CPI_tx_Lost_Comments__c, CPI_tx_Not_Signed_Proposal_Reason__c, CPI_tx_OR_ID__c, 
                        CPI_tx_Risk_Economic_Group__c, CPI_tx_Won_Comments__c, CPI_un_Capex_Exposure__c, CPI_un_Fleet_Exposure__c, 
                        CPI_un_Real_Estate_Exposure__c, CPI_un_Technology_Exposure__c, CPL_ls_OR_Source__c, Risk_INtern__c, Risk_Analyst__c, Inside_Sales__c,
                        Inside_Sales__r.FirstName,Inside_Sales__r.LastName,
                        Sr_Underwriter__c, Sr_Underwriter__r.FirstName, Sr_Underwriter__r.LastName, Approval_Level__c, ROI__c,  On_Hold_Comments__c, Additional_Approved_Products__c, 
                        Decision_Date__c, Government__c, of_Government_Revenues__c, Government_Level__c, Override_Reason__c, ES2_re_Guarantor__c, 
                        ES2_re_Obligor__c, ES2_re_Risk_Desicion_Entity__c, ES3_tx_Top_Parent_Name__c, ES3_rb_Legal_Team_Member__c, ES3_TX_MRA_ID__c, 
                        ES3_tx_Bloomberg_ID__c, ES3_TX_HNWI_ID__c, ES3_fm_Total_Opportunities_USD__c, ES3_rm_Total_opportunities_in_MXN__c, 
                        ES3_rm_Total_opportunities_in_USD__c, ES3_ls_AML_Review_Status__c, ES3_tx_Risk_Economic_Group_Id__c, ES3_pl_AML_Rework_reason__c, 
                        ES3_tx_AML_Rework_Comment__c, ES3_pl_AML_Declined_Comment__c, 
                        ES3_ls_RISK_REVIEW_STATUS__c, ES3_pl_Risk_Rework_reason__c, ES3_tx_Risk_Rework_Comment__c, ES3_fm_Customer_Since__c, 
                        SP3_pl_Credit_Approval_Status__c, SP3_nu_Process_Builder_Trigger__c, SP3_pl_Send_for_Approval__c, ES3_pl_AML_tomado__c, 
                        ES3_pl_Tomar_CA_para_RISK_Review__c, RecordType_List__c, Doctypes__c,MD_ca_Carveout__c,	MD_ca_AddOn__c,MD_ca_Incremental__c
                        FROM Credit_approval_CP__c  
                        where Id =:this.oppInCa.CP_rb_Credit_approval_CP__c][0]; 
        }
        Catch(Exception e)
        {
            System.debug('OEJ No Existe el CA que Agregar.....');
            //this.OppInCA = new Opportunity_in_Credit_approval_CP__c();
        } 
        return CAparent;
    }
    
    
    //Se cargan los estan relacionados con la opportunity in credit approval
    //que ES3_rb_Opportunity_in_Credit_approval_CP__c = oppInCa.Id  
    //
    //  
    public void cargaOppInCa(Id oppInCaId) 
    {
        this.oppInCa = new Opportunity_in_Credit_approval_CP__c();
        try{
            this.oppInCa = [Select Id, Name, CurrencyIsoCode, CreatedDate, CreatedById, CP_rb_Credit_approval_CP__c, CPL_dv_AmountOPP__c, 
                        CP_rb_Oportunidad__c, ES3_nu_Amount_Numeric__c,CP_rb_Credit_approval_CP__r.Name,
                        ES3_fm_CreditApproval_RecordType__c, Products__c, ES3_fm_Opportunity_Name__c, 
                        CP_rb_Oportunidad__r.Id, CP_rb_Oportunidad__r.AccountId, CP_rb_Oportunidad__r.RecordTypeId, CP_rb_Oportunidad__r.Name, 
                        CP_rb_Oportunidad__r.Description, CP_rb_Oportunidad__r.StageName, CP_rb_Oportunidad__r.Amount, CP_rb_Oportunidad__r.Probability, 
                        CP_rb_Oportunidad__r.CloseDate, CP_rb_Oportunidad__r.Type, CP_rb_Oportunidad__r.NextStep, CP_rb_Oportunidad__r.LeadSource, 
                        CP_rb_Oportunidad__r.IsClosed, CP_rb_Oportunidad__r.IsWon, CP_rb_Oportunidad__r.ForecastCategory, CP_rb_Oportunidad__r.ForecastCategoryName, 
                        CP_rb_Oportunidad__r.CurrencyIsoCode, CP_rb_Oportunidad__r.CampaignId, CP_rb_Oportunidad__r.HasOpportunityLineItem, 
                        CP_rb_Oportunidad__r.IsSplit, CP_rb_Oportunidad__r.Pricebook2Id, CP_rb_Oportunidad__r.OwnerId, CP_rb_Oportunidad__r.CreatedDate, 
                        CP_rb_Oportunidad__r.CreatedById, CP_rb_Oportunidad__r.FiscalQuarter, CP_rb_Oportunidad__r.FiscalYear, CP_rb_Oportunidad__r.Fiscal, 
                        CP_rb_Oportunidad__r.LastViewedDate, CP_rb_Oportunidad__r.LastReferencedDate, CP_rb_Oportunidad__r.SyncedQuoteId, 
                        CP_rb_Oportunidad__r.HasOpenActivity, CP_rb_Oportunidad__r.HasOverdueTask, CP_rb_Oportunidad__r.Budget_Confirmed__c, 
                        CP_rb_Oportunidad__r.Discovery_Completed__c, CP_rb_Oportunidad__r.ROI_Analysis_Completed__c, CP_rb_Oportunidad__r.IST__TrackingNumber__c, 
                        CP_rb_Oportunidad__r.Loss_Reason__c, CP_rb_Oportunidad__r.OPP_at_No_document_Reason__c, CP_rb_Oportunidad__r.OPP_ca_No_document__c, 
                        CP_rb_Oportunidad__r.OPP_fh_Proposal_Signed_Received_Date__c, CP_rb_Oportunidad__r.OPP_fm_Credit_Approval_Status__c, 
                        CP_rb_Oportunidad__r.OPP_fm_EditOpp__c, CP_rb_Oportunidad__r.OPP_lm_Additional_Services__c, CP_rb_Oportunidad__r.OPP_ls_Broker_Fee_Commision__c,
                        CP_rb_Oportunidad__r.OPP_ls_Broker_name__c, CP_rb_Oportunidad__r.OPP_ls_Collateral__c, CP_rb_Oportunidad__r.OPP_ls_Competitor_Floating_Fixed__c,
                        CP_rb_Oportunidad__r.OPP_ls_Competitor_Index__c, CP_rb_Oportunidad__r.OPP_ls_Competitor_Is_the_main_lender__c, 
                        CP_rb_Oportunidad__r.OPP_ls_Competitor_Product__c, CP_rb_Oportunidad__r.OPP_ls_Deal_Category__c, 
                        CP_rb_Oportunidad__r.OPP_ls_Equipment_Condition__c, CP_rb_Oportunidad__r.OPP_ls_Equipment_Import_Required__c, 
                        CP_rb_Oportunidad__r.OPP_ls_Financing_Need__c, CP_rb_Oportunidad__r.OPP_ls_Import_Type__c, CP_rb_Oportunidad__r.OPP_ls_Insurance_Type__c, 
                        CP_rb_Oportunidad__r.OPP_ls_Line_of_Business__c, CP_rb_Oportunidad__r.OPP_ls_Marketing_Initiative_1__c, 
                        CP_rb_Oportunidad__r.OPP_ls_Marketing_Initiative_2__c, CP_rb_Oportunidad__r.OPP_ls_Marketing_Initiative_3__c,
                        CP_rb_Oportunidad__r.OPP_ls_Of_sharing_reps__c, CP_rb_Oportunidad__r.OPP_ls_Opportunity_from_Broker__c, 
                        CP_rb_Oportunidad__r.OPP_ls_Opportunity_from_Vendor__c, CP_rb_Oportunidad__r.OPP_ls_Origin_of_equipment__c, CP_rb_Oportunidad__r.OPP_ls_Product__c, 
                        CP_rb_Oportunidad__r.OPP_ls_Reason_Lost_Level_1__c, CP_rb_Oportunidad__r.OPP_ls_Reason_Lost_Level_2__c, CP_rb_Oportunidad__r.OPP_ls_Reason_Lost_Level_3__c, 
                        CP_rb_Oportunidad__r.OPP_ls_Reason_Won_Level_1__c, CP_rb_Oportunidad__r.OPP_ls_Reason_Won_Level_2__c, CP_rb_Oportunidad__r.OPP_ls_Region__c, 
                        CP_rb_Oportunidad__r.OPP_ls_Shadow_Split__c, CP_rb_Oportunidad__r.OPP_ls_Shared_Opportunity__c, CP_rb_Oportunidad__r.OPP_ls_Sharing_Criteria__c, 
                        CP_rb_Oportunidad__r.OPP_ls_Sharing_Type_2__c, CP_rb_Oportunidad__r.OPP_ls_Sharing_Type_3__c, CP_rb_Oportunidad__r.OPP_ls_Sharing_Type_4__c, 
                        CP_rb_Oportunidad__r.OPP_ls_Vendor_Brand__c, CP_rb_Oportunidad__r.OPP_ls_Vendor_Distributor__c, CP_rb_Oportunidad__r.OPP_ls_Vendor_Fee_Commision__c, 
                        CP_rb_Oportunidad__r.OPP_ls_Vertical__c, CP_rb_Oportunidad__r.OPP_na_Folio__c, CP_rb_Oportunidad__r.OPP_pr_Broker_Fee_Commision__c, 
                        CP_rb_Oportunidad__r.OPP_pr_Sharing_1__c, CP_rb_Oportunidad__r.OPP_pr_Sharing_2__c, CP_rb_Oportunidad__r.OPP_pr_Sharing_3__c, 
                        CP_rb_Oportunidad__r.OPP_pr_Sharing_4__c, CP_rb_Oportunidad__r.OPP_pr_Vendor_Fee_Commision__c, CP_rb_Oportunidad__r.OPP_rb_Account_Name__c, 
                        CP_rb_Oportunidad__r.OPP_rb_Broker_Name__c, CP_rb_Oportunidad__r.OPP_rb_Closer__c, CP_rb_Oportunidad__r.OPP_rb_Competitor__c, 
                        CP_rb_Oportunidad__r.OPP_rb_Competitor_del__c, CP_rb_Oportunidad__r.OPP_rb_Credit_Approval__c, CP_rb_Oportunidad__r.OPP_rb_Refered_by__c, 
                        CP_rb_Oportunidad__r.OPP_rb_Share_Rep_1__c, CP_rb_Oportunidad__r.OPP_rb_Share_Rep_2__c, CP_rb_Oportunidad__r.OPP_rb_Share_Rep_3__c, 
                        CP_rb_Oportunidad__r.OPP_rb_Share_Rep_4__c, CP_rb_Oportunidad__r.OPP_tl_Competitor_comments__c, CP_rb_Oportunidad__r.OPP_tl_Not_Signed_Proposal_Reason__c, 
                        CP_rb_Oportunidad__r.OPP_tl_Won_Comments__c, CP_rb_Oportunidad__r.OPP_tx_Credit_Approval_Status__c, CP_rb_Oportunidad__r.OPP_tx_EXT_REF_ID__c, 
                        CP_rb_Oportunidad__r.OPP_tx_Lost_Comments__c, CP_rb_Oportunidad__r.OPP_tx_Opportunity_Comments__c, CP_rb_Oportunidad__r.OPP_tx_Original_Owner__c, 
                        CP_rb_Oportunidad__r.OPP_un_Amount_USD_Converted__c, CP_rb_Oportunidad__r.OPP_un_Competitor_Spread_bps__c, 
                        CP_rb_Oportunidad__r.OPP_un_Competitor_Term_Months__c, CP_rb_Oportunidad__r.OPP_un_Spread_Diff_vs_Competitor_in_bps__c, 
                        CP_rb_Oportunidad__r.OPP_re_Pre_screening__c, CP_rb_Oportunidad__r.OPP_re_Pricing_Proposal__c, CP_rb_Oportunidad__r.OPP_re_Takedown__c, 
                        CP_rb_Oportunidad__r.OPP_fh_Original_Created_Date__c, CP_rb_Oportunidad__r.OPP_tl_CommercialSupportComments__c, 
                        CP_rb_Oportunidad__r.OPP_fe_Lost_Date__c, CP_rb_Oportunidad__r.OPP_tx_LostStage__c, CP_rb_Oportunidad__r.OPP_tx_Lost_Date_Month__c, 
                        CP_rb_Oportunidad__r.OPP_tx_Lost_Date_Q__c, CP_rb_Oportunidad__r.OPP_tx_Lost_Date_Year__c, CP_rb_Oportunidad__r.LID__Is_Influenced__c, 
                        CP_rb_Oportunidad__r.LID__LinkedIn_Company_Id__c, CP_rb_Oportunidad__r.OPP_fh_Funded_Date__c, 
                        CP_rb_Oportunidad__r.rrpu__Alert_Message__c, CP_rb_Oportunidad__r.QLIK_ls_Vendor_Branch__c, CP_rb_Oportunidad__r.OPP_ls_Vendor_Rates_Subsides__c, 
                        CP_rb_Oportunidad__r.OPP_ls_Vendor_Risk_Support__c, CP_rb_Oportunidad__r.Latest_Funded_Takedown_Date__c, 
                        CP_rb_Oportunidad__r.CPL_ck_maybeProvidedAnotherCurrency__c, CP_rb_Oportunidad__r.CPL_date_Expiration_Date__c, 
                        CP_rb_Oportunidad__r.CPL_dv_Approved_Amount__c, CP_rb_Oportunidad__r.CPL_nu_CA_Rate__c, CP_rb_Oportunidad__r.CPL_nu_Movement_in_credit_line__c, 
                        CP_rb_Oportunidad__r.CPL_fm_Final_Balance__c, CP_rb_Oportunidad__r.CPL_nu_TakeDowns_in_Opportunity__c, CP_rb_Oportunidad__r.QLIK_ls_Vendor_Sales_Rep__c, 
                        CP_rb_Oportunidad__r.CPS2_da_Expected_1st_funding_date__c, CP_rb_Oportunidad__r.CPIS2_tx_Collateral_Description__c, CP_rb_Oportunidad__r.Approval_Date__c, 
                        CP_rb_Oportunidad__r.Proposal_Date__c, CP_rb_Oportunidad__r.Proposal_Awarded_Date__c, CP_rb_Oportunidad__r.In_Credit_Date__c, 
                        CP_rb_Oportunidad__r.Backlog_Date__c, CP_rb_Oportunidad__r.Current_Stage_Date__c, CP_rb_Oportunidad__r.Indirect_Vertical__c, 
                        CP_rb_Oportunidad__r.Indirect_Partner_Brand__c, CP_rb_Oportunidad__r.Credit_Approval_ID__c, CP_rb_Oportunidad__r.X1st_Funded_Takedown_Date__c, 
                        CP_rb_Oportunidad__r.Converted_Pipeline__c, CP_rb_Oportunidad__r.CLI_fm_Pipeline_Amount__c, CP_rb_Oportunidad__r.Opportunity_Identified_Date__c, 
                        CP_rb_Oportunidad__r.Aging_since_opportunity__c, CP_rb_Oportunidad__r.Insurance_Manager_Comments__c, CP_rb_Oportunidad__r.Aging_In_Credit_Backlog__c, 
                        CP_rb_Oportunidad__r.Reason_Engenium_Insurance_Lost__c, CP_rb_Oportunidad__r.ES3_fm_Amount_Numeric__c, 
                        CP_rb_Oportunidad__r.MC3_dt_Original_Expiration_Date__c,MD_ls_Type_Credit_MOD__c
                            FROM Opportunity_in_Credit_approval_CP__c   
                            where id =:oppInCaId][0]; 
        }
        Catch(Exception e)
        {
            System.debug('OEJ No Hay Opps que Agregar.....');
            //this.OppInCA = new Opportunity_in_Credit_approval_CP__c();
        }             
    } 
    
   public void cargaOppsCar(Id oppInCarId)
    {


try{

        this.OppInCarveout =new Carveout_in_Credit_Approval_CP__c();
       this.OppInCarveout =[Select Id, count_carvaut__c,CreatedById,CurrencyIsoCode,LastModifiedById,MD_Amount__c,MD_chec_Copy_Date_MAC__c,MD_date_Date__c,MD_fm_Restado__c,MD_fm_Sumado__c,
                              MD_num_Destination_Amount__c,MD_Opp_use_by_carveaut__c,MD_Opportunity__c,MD_rl_Destination_Opportunity__c,MD_rls_Credit_approval__c,Name,Opportunity__c,Opportunity_in_CA__c
                              FROM Carveout_in_Credit_Approval_CP__c 
                              WHERE  id =:oppInCarId][0];

      
}
        Catch(Exception e)
        {
            System.debug('OEJ No Hay Opps que Agregar Carveout.....');
            //this.OppInCA = new Opportunity_in_Credit_approval_CP__c();
        } 
        
    }
    
    public void cargaPricing() 
    {
        this.pricings = new List<ES3_obj_Pricing_in_Credit_Approval__c>();
        try{
            this.pricings = [Select Id, Name, CurrencyIsoCode, CreatedDate, CreatedById, 
                             ES3_rb_Opportunity_in_Credit_approval_CP__c, 
                             ES3_rb_Opportunity_in_Credit_approval_CP__r.Name,
                             ES3_ls_SL_B_YES_NO__c,
                             ES3_nu_Advance_PaymentPercent__c,
                             ES3_nu_Progress_Payments_M__c,
                             ES3_ls_Low_High_High_Low__c,
                             ES3_nu_Grace_Period_in_Months__c,
                             ES3_ls_Type_of_Grace_Period__c,
                             ES3_pc_Split_Trac_Percentent__c,
                             ES3_ls_EFA__c,
                             ES3_pc_Remarketing_Fee_Percent__c,
                             ES3_ls_Used_New__c,
                             ES3_tx_Appraisal__c,
                             ES3_tx_Boot_Collateral__c,
                             ES3_ls_EBO__c,
                             ES3_tl_EBO_Description__c,
                             BKL_TXT_L_H_Description__c,
                             ES3_ls_Progress_Payments__c,
                             ES3_nu_ROI_No_Insurance__c,
                             ES3_pc_Trac_Percent__c,
                             ES3_fm_RV__c,
                             ES3_fm_P_option__c,
                             BKL_pc_Lock_Fee__c,
                             BKL_lst_Prom_Note__c,
                             BLG_pr_SD_percent__c,
                             BLG_at_SD_Comment__c,
                             BKL_TXT_Progres_Description__c,
                             BKL_txt_EOL_Option__c,
                             BKL_TXT_Model_Asset_Return_Condition__c,
                             BKL_TXT_Model__c,
                             BKL_TXT_Asset__c,
                             BKL_TXT_Return_Condition__c,
                             
                                                          //Pricing Info
                             ES3_rb_Pricing__c, 
                             ES3_rb_Oportunidad__c,
                             ES3_rb_Credit_approval_CP__c, 
                             ES3_fm_Pricing_Super_Trump__c,
                             ES3_rb_Pricing__r.ES3_tx_Product_TL_QL_LOAN__c,
                             ES3_rb_Pricing__r.ES3_Opportunity_Collateral__c,
                             ES3_rb_Pricing__r.ES3_tx_ARR_ADV__c,
                             ES3_rb_Pricing__r.ES3_tx_Ballon_Bullet_Payment__c,
                             ES3_rb_Pricing__r.ES3_tx_Frequency_Monthly_Quarterly__c,
                             ES3_rb_Pricing__r.ES3_nu_Residual_Value_Percent__c,
                             
                             
                     ES3_rb_Pricing__r.Id, ES3_rb_Pricing__r.Name,
                     ES3_rb_Pricing__r.CurrencyIsoCode, 
                     ES3_rb_Pricing__r.RecordTypeId,
                     ES3_rb_Pricing__r.CreatedDate, 
                     ES3_rb_Pricing__r.LastModifiedDate, 
                     ES3_rb_Pricing__r.CreatedById,
                     ES3_rb_Pricing__r.TBO018_rb_Opportunity__c,
                     ES3_rb_Pricing__r.TBO018_rb_SuperTRUMP_Pricing_Quote__c,
                     ES3_rb_Pricing__r.Account_Name__c,
                     ES3_rb_Pricing__r.TBO018_rb_SuperTRUMP_Pricing_Quote__r.Name,
                     ES3_rb_Pricing__r.TBO018_rb_Opportunity__r.Name,
                     ES3_rb_Pricing__r.Opportunity_Owner__c, 
                     ES3_rb_Pricing__r.Region__c,
                     ES3_rb_Pricing__r.TBO018_ca_Approved_by_Risk__c, 
                     ES3_rb_Pricing__r.TBO018_dv_ANI__c, 
                     ES3_rb_Pricing__r.TBO018_dv_Amount__c, 
                     ES3_rb_Pricing__r.TBO018_dv_Gross_margin__c, 
                     ES3_rb_Pricing__r.TBO018_dv_Residual__c,
                     ES3_rb_Pricing__r.TBO018_fh_Money_Cost_Date__c,
                     ES3_rb_Pricing__r.TBO018_fh_Pricing_Fields__c, 
                     ES3_rb_Pricing__r.TBO018_fm_Commercial_Support_Owner__c, 
                     ES3_rb_Pricing__r.TBO018_fm_Credit_Approval_Status__c,
                     ES3_rb_Pricing__r.TBO018_fm_EditPricing__c, 
                     ES3_rb_Pricing__r.TBO018_ls_Type__c,
                     ES3_rb_Pricing__r.TBO018_nu_ApprovalOrder__c,
                     ES3_rb_Pricing__r.TBO018_pr_Book_Yield__c, 
                     ES3_rb_Pricing__r.TBO018_pr_Cost_of_Funds_Levered__c,
                     ES3_rb_Pricing__r.TBO018_pr_Cost_of_Funds_Unlevered__c, 
                     ES3_rb_Pricing__r.TBO018_pr_Economic_ROE__c, 
                     ES3_rb_Pricing__r.TBO018_pr_Economic_ROI__c, 
                     ES3_rb_Pricing__r.TBO018_pr_Economic_Yield__c, 
                     ES3_rb_Pricing__r.TBO018_pr_Expense_ANI__c, 
                     ES3_rb_Pricing__r.TBO018_pr_Finance_Margin__c,
                     ES3_rb_Pricing__r.TBO018_pr_Full_Term_Rate__c, 
                     ES3_rb_Pricing__r.TBO018_pr_Full_Term_Rate_w_Resid__c, 
                     ES3_rb_Pricing__r.TBO018_pr_Lending_Rate__c,
                     ES3_rb_Pricing__r.TBO018_pr_Leverage__c, 
                     ES3_rb_Pricing__r.TBO018_pr_Loss_ANI__c, 
                     ES3_rb_Pricing__r.TBO018_pr_Opening_Fee__c,
                     ES3_rb_Pricing__r.TBO018_pr_Security_Deposit__c,
                     ES3_rb_Pricing__r.TBO018_rb_Credit_Approval__c,
                     ES3_rb_Pricing__r.TBO018_rb_Takedowns__c,
                     ES3_rb_Pricing__r.TBO018_tx_Description__c, 
                     ES3_rb_Pricing__r.TBO018_tx_Pricing_Status__c, 
                     ES3_rb_Pricing__r.TBO018_tx_Product__c,
                     ES3_rb_Pricing__r.TBO018_tx_Rate_Type__c, 
                     ES3_rb_Pricing__r.TBO018_tx_Supertrump_Template__c, 
                     ES3_rb_Pricing__r.TBO018_un_Contributed_Value__c,
                     ES3_rb_Pricing__r.TBO018_un_Depreciation__c,
                     ES3_rb_Pricing__r.TBO018_un_Net_Income__c, 
                     ES3_rb_Pricing__r.TBO018_un_Term__c, 
                     ES3_rb_Pricing__r.TPO018_fm_Opportunity_SFOP__c,
                     ES3_num_SD__c,
                     ES3_pc_RV__c, 
                     ES3_pc_Rate__c,
                     ES3_pc_Opening_Fee__c,
                     ES3_pc_Frequency_Monthly_Quarterly__c,
                     ES3_pc_Term_in_months_without_PP__c,
                     ES3_pc_Term_in_Months__c,
                     ES3_num_Ballon_Bullet_Payment__c,
                     ES3_pc_P_option__c,
                     ES3_pc_CROSS_COLLATERAL__c,
                     ES3_pc_CASH_COLLATERAL__c,
                     ES3_pc_DIRECT_DEBIT__c,
                     ES3_pc_C_PELIGROSA__c,
                     ES3_pc_COLLECTION_RIGHTS__c,
                     ES3_rb_Pricing__r.ES3_tx_supertrump_tx__c
                     from ES3_obj_Pricing_in_Credit_Approval__c where ES3_rb_Opportunity_in_Credit_approval_CP__c =: oppInCa.Id]; 
        }
        Catch(Exception e)
        {
            System.debug('OEJ No Hay Opps que Agregar.....');
            //this.OppInCA = new Opportunity_in_Credit_approval_CP__c();
        }             
    }
    
    public void cargaCAndC() 
    {
        this.specialCondition = new List<ES3_obj_Condition_Service_covenant__c>();
        this.covenants = new List<ES3_obj_Condition_Service_covenant__c>();
        List<ES3_obj_Condition_Service_covenant__c> scc = new List<ES3_obj_Condition_Service_covenant__c>();
        try{
            scc = [Select Id, OwnerId, IsDeleted, Name, CurrencyIsoCode, RecordTypeId, RecordType.Name, CreatedDate, CreatedById, ES3_rb_Opportunity_in_Credit_approval_CP__c, 
                   ES3_rb_Credit_approval_CP__c, ES3_rb_Oportunidad__c, ES3_lst_Services__c, ES3_lst_Condition__c, ES3_lst_Covenant_Cuantitativo__c, 
                   ES3_txt_Service_Comments__c, ES3_TXT_Description__c, ES3_TXT_Threshold__c, ES3_lt_Status__c, ES3_LT_Min_Max__c, ES3_TX_Other__c, ES3_LST_Review__c, 
                   ES3_LST_Applies_To__c, ES3_LST_Covenant_Cualitativo__c, ES3_lt_Timing__c, ES3_DATE_Date__c, ES3_rb_Entity__c,
                   //Entity Info
                   ES3_rb_Entity__r.Id, ES3_rb_Entity__r.IsDeleted, ES3_rb_Entity__r.Name, ES3_rb_Entity__r.CurrencyIsoCode, ES3_rb_Entity__r.CreatedDate, 
                   ES3_rb_Entity__r.CreatedById, ES3_rb_Entity__r.ES2_rb_Credit_approval__c, ES3_rb_Entity__r.ES2_fm_Desicion_Entity__c, ES3_rb_Entity__r.ES2_fm_Entity__c, 
                   ES3_rb_Entity__r.ES2_fm_Garantor__c, ES3_rb_Entity__r.ES2_fm_Obligor__c, ES3_rb_Entity__r.ES2_ms_Role__c, ES3_rb_Entity__r.ES2_tx_CostumerType__c, 
                   ES3_rb_Entity__r.ES2_tx_Oracle_Account_Name__c, ES3_rb_Entity__r.ES2_tx_Party_Id__c, ES3_rb_Entity__r.ES2_tx_TopParentID__c, 
                   ES3_rb_Entity__r.ES2_tx_TopParetName__c, ES3_rb_Entity__r.ES2_tx_pageVF__c, ES3_rb_Entity__r.ES2_url_Entity_Master__c, ES3_rb_Entity__r.ES3_rb_Opportunity__c, 
                   ES3_rb_Entity__r.ES3_rb_Opportunity_in_Credit_approval_CP__c, ES3_tx_Coments__c, ES3_LT_Timing_Cualitativo__c, ES3_LT_Timing_Cuantitativo__c
                   FROM ES3_obj_Condition_Service_covenant__c   
                   where ES3_rb_Oportunidad__c =: oppInCa.CP_rb_Oportunidad__r.Id]; 
            		system.debug('JD :' + scc);
        }
        Catch(Exception e)
        {
            System.debug('OEJ No Hay Opps que Agregar.....');
            //this.OppInCA = new Opportunity_in_Credit_approval_CP__c();
        }   
        
        if(scc.size()>0)
        {
            for(ES3_obj_Condition_Service_covenant__c s: scc)
            {	
                system.debug('for s: ' + s.RecordType.Name);
                if(s.RecordType.Name.contains('Condition'))
                {
                    this.specialCondition.add(s);
                    system.debug('condition: ' +s);
                }
                else // es covenant
                {
                     system.debug('JD: ENTRAMOS AL ELSE' + s);
                     this.covenants.add(s);   
                }
                
            }
        }        
    }

    {
        this.entityInCa = new List<ES2_Obj_EntityMasterInCreditApproval__c>();
        try{
            this.entityInCa = [Select Id, IsDeleted, Name, CurrencyIsoCode, CreatedDate, CreatedById, ES2_rb_Credit_approval__c, ES2_fm_Desicion_Entity__c, 
                               ES2_fm_Entity__c, ES2_fm_Garantor__c, ES2_fm_Obligor__c, ES2_ms_Role__c, ES2_tx_CostumerType__c, ES2_tx_Oracle_Account_Name__c, 
                               ES2_tx_Party_Id__c, ES2_tx_TopParentID__c, ES2_tx_TopParetName__c, ES2_tx_pageVF__c, ES2_url_Entity_Master__c, ES3_rb_Opportunity__c, ES3_rb_Opportunity__r.Name,
                               ES3_rb_Opportunity_in_Credit_approval_CP__c, ES3_tx_BloombergID__c,ES3_tx_HNWI_ID__c,ES3_tx_MRAID__c,ES3_tx_Or_Rating__c,ES3_tx_Transaction_Date__c 
                               FROM ES2_Obj_EntityMasterInCreditApproval__c  
                               where ES3_rb_Opportunity__c =: oppInCa.CP_rb_Oportunidad__r.Id]; 
        }
        Catch(Exception e)
        {
            System.debug('OEJ No Hay Opps que Agregar.....');
            //this.OppInCA = new Opportunity_in_Credit_approval_CP__c();
        }             
    }

    public void cargaEntities() 
    {
        this.entityInCa = new List<ES2_Obj_EntityMasterInCreditApproval__c>();
        try{
            this.entityInCa = [Select Id, IsDeleted, Name, CurrencyIsoCode, CreatedDate, CreatedById, ES2_rb_Credit_approval__c, ES2_fm_Desicion_Entity__c, 
                               ES2_fm_Entity__c, ES2_fm_Garantor__c, ES2_fm_Obligor__c, ES2_ms_Role__c, ES2_tx_CostumerType__c, ES2_tx_Oracle_Account_Name__c, 
                               ES2_tx_Party_Id__c, ES2_tx_TopParentID__c, ES2_tx_TopParetName__c, ES2_tx_pageVF__c, ES2_url_Entity_Master__c, ES3_rb_Opportunity__c, ES3_rb_Opportunity__r.Name,
                               ES3_rb_Opportunity_in_Credit_approval_CP__c, ES3_tx_BloombergID__c,ES3_tx_HNWI_ID__c,ES3_tx_MRAID__c,ES3_tx_Or_Rating__c,ES3_tx_Transaction_Date__c 
                               FROM ES2_Obj_EntityMasterInCreditApproval__c  
                               where ES3_rb_Opportunity__c =: oppInCa.CP_rb_Oportunidad__r.Id]; 
        }
        Catch(Exception e)
        {
            System.debug('OEJ No Hay Opps que Agregar.....');
            //this.OppInCA = new Opportunity_in_Credit_approval_CP__c();
        }             
    }    
}