public with sharing class MD_Controller_PDF_MODMAC {
    
        
          public  Carveout_in_Credit_Approval_CP__c         Carveout          {get;set;}
          public  Opportunity                               Opportunity       {get;set;}
          public  Opportunity_in_Credit_approval_CP__c	    OpportunityInCa   {get;set;}
    
          Map<Id, String> OppsInCa                   {get;set;}
    
    public string 								CAparentId			    		{get;set;}
    public List<ES3_OpportunitiesInCaWraper>	opps     						{get;set;}
    public List<MD_ExtencionControllerOpcas>	oppsCar   						{get;set;}
    public Credit_approval_CP__c 				CAparent						{get;set;}
    public Date 								Approval_Date					{get;set;}
    public String 								SUW								{get;set;}
    public String 								UW								{get;set;}
    public String 								Inside_sales		            {get;set;}
    public String 								Originador						{get;set;}
    public String 								Approval_Level					{get;set;}
    public String 								Business_Type					{get;set;}    
    public String 								CA								{get;set;}  
    public String								Aml								{get;set;}
    public String								Risk							{get;set;}
    public String 								CAstage							{get;set;}
    public String 								Economic_Group					{get;set;}
    public String                               Sic_Code                        {get;set;}
    public Boolean                              Add_On                          {get;set;}
    public String                               Background                      {get;set;}
    public Boolean                              Carveouts                       {get;set;}
    public String                               Comments_Bil                    {get;set;}
    public String                               Comments_CBureau                {get;set;}
    public String                               Comments_Fiscal_Situation       {get;set;}
    public String                               Comments_Payment_trend          {get;set;}
    public Decimal                              Current_Exposure                {get;set;}
    public Date                                 Date_Bil                        {get;set;}
    public Date                                 Date_CBureau                    {get;set;}
    public Date                                 Date_Fiscal_Situation           {get;set;}
    public Date                                 Date_Payment_Trend              {get;set;}
    public String                               Description                     {get;set;}
    public String                               Endorsement                     {get;set;}
    public Date                                 Fecha_Vigencia                  {get;set;}
    public String                               Financial_Inf_Summary           {get;set;}
    public String                               Google_search                   {get;set;}
    public Boolean                              Incremental                     {get;set;}
    public String                               Last_Approved_Int               {get;set;}
    public Boolean                              MAC_MOD                         {get;set;}
    public String                               Pass_Bil                        {get;set;}
    public String                               Pass_CBureau                    {get;set;}
    public String                               Pass_Fiscal_Situation           {get;set;}
    public String                               Pass_Payment_Trend              {get;set;}
    public String                               Rationale_com                   {get;set;}
    public String                               Request                         {get;set;}
    public String                               Account_Name                    {get;set;} 
    public String                               Risk_Classification             {get;set;}
    public Decimal                              Obligor_Ca                      {get;set;}
    public String                               Risk_Dec_Entity                 {get;set;}
    public Decimal                              Opp_Mxn                         {get;set;}
    public Decimal                              Opp_USD                         {get;set;}
    public Decimal                              Sum_Opp_USD                     {get;set;}
    public Decimal                              Total_Exposure                  {get;set;}
    public Date                                 Visit_Date                      {get;set;}
    public String                               Visit_Pass                      {get;set;}
    public String                               Comments_Visit                  {get;set;}
    public String                               Comments_Google_Search	        {get;set;}
    public Date                                 Google_Search_Date	            {get;set;}
    public String                               Google_Search_Pass	            {get;set;}
    public List<ES3_WraperEntityStructure>		entityStructure 				{get;set;}
    public List<ES3_WraperEntityStructure>		cAndCStructure 					{get;set;}
    public string                               opors                           {get;Set;}  
    public string                               img1                            {get;set;}
    public string                               img2                            {get;set;}
    public Decimal                              tc                              {get;set;}
    public Decimal                              Totaltc                         {get;set;}
    public string                               EC                              {get;set;}
    public string                               Advance                         {get;set;}
    public string                               PpDeal                          {get;set;}
    public string                               GrossMargin                     {get;set;}
    public string                               SourceOpp                       {get;set;}
    public string                               SourceCA                        {get;set;}
    public Decimal                              TotalTE                         {get;set;}
    public String 								Uww								{get;set;}
    public String                               ApprovalOR                      {get;set;}
    public String                               OROverride                      {get;set;}
    
  

    
    public MD_Controller_PDF_MODMAC()
    {
        
        try{
            
        this.CAparentId =  (String)System.currentPageReference().getParameters().get('CAId');
        cargaCreditApproval();
        cargaOpps();
        cargaOppsCar();
        cargaEntityEstructure();
        cargaCAndCEstructure();
     
        this.Approval_Date	= this.CAparent.Decision_Date__c;				  
        this.SUW	= this.CAparent.Sr_Underwriter__r.FirstName + ' ' + this.CAparent.Sr_Underwriter__r.LastName;	
        this.Uww = this.CAparent.Risk_Analyst__r.FirstName + ' ' + this.CAparent.Risk_Analyst__r.LastName;	
        this.Originador	= this.CAparent.CPL_rb_account__r.Owner.FirstName + ' ' + this.CAparent.CPL_rb_account__r.Owner.LastName;	
        this.Approval_Level	= this.CAparent.Approval_Level__c;				  		
        this.Business_Type		= this.CAparent.CPL_rb_account__r.ACC_fm_Target_Market__c;	
        this.CA		= this.CAparent.Name;	
        this.Aml=this.CAparent.ES3_ls_AML_Review_Status__c;
        this.Risk=this.CAparent.ES3_ls_RISK_REVIEW_STATUS__c;
        this.CAstage=this.CAparent.CPL_ls_StageName__c;
        this.Sic_Code =this.CAparent.CPI_rb_SIC_code__r.Name;
        this.Economic_Group		= this.CAparent.CPI_tx_Risk_Economic_Group__c;
        this.UW	= this.CAparent.Risk_Analyst__r.FirstName + ' ' + this.CAparent.Risk_Analyst__r.LastName;
        this.Inside_sales =this.CAparent.Inside_Sales__r.FirstName + ' ' +this.CAparent.Inside_Sales__r.LastName;
        this.Account_Name = this.CAparent.CPL_rb_account__r.Name;
        this.Add_On = this.CAparent.MD_ca_AddOn__c;                      
        this.Background = this.CAparent.MD_tl_Background__c;
        this.Carveouts = this.CAparent.MD_ca_Carveout__c;
        this.Comments_Bil = this.CAparent.MD_tl_Bil_Comments__c;
        this.Comments_CBureau = this.CAparent.MD_tl_CBureau_Comments__c;
        this.Comments_Fiscal_Situation = this.CAparent.MD_tl_FiscalSituation__c;
        this.Comments_Payment_trend = this.CAparent.MD_tl_PaymentTrend_Comments__c;
        this.Date_Bil = this.CAparent.MD_fh_Bil__c;
        this.Date_CBureau = this.CAparent.MD_fh_CBureau__c;
        this.Date_Fiscal_Situation = this.CAparent.MD_fh_FiscalSituation__c;
        this.Date_Payment_Trend = this.CAparent.MD_fh_PaymentTrend_Date__c;
        this.Description = this.CAparent.MD_at_Description__c;
        this.Endorsement = this.CAparent.MD_at_Endorsement__c;
        this.Fecha_Vigencia = this.CAparent.MD_date_Fecha_Vigencia__c;
        this.Financial_Inf_Summary = this.CAparent.MD_at_Financial_Inf_Summary__c;
        this.Incremental = this.CAparent.MD_ca_Incremental__c;
        this.Last_Approved_Int = this.CAparent.MD_tl_Last_Approved_Int__c;
        this.MAC_MOD = this.CAparent.MD_ca_MODMAC__c;
        this.Pass_Bil = this.CAparent.MD_ls_Bil_Pass__c;
        this.Pass_CBureau = this.CAparent.MD_ls_CBureau_Pass__c;
        this.Pass_Fiscal_Situation = this.CAparent.MD_ls_FiscalSituation_Pass__c;
        this.Pass_Payment_Trend = this.CAparent.MD_ls_PaymentTrend_Pass__c;
        this.Rationale_com = this.CAparent.MD_tl_Rationale__c;
        this.Request = this.CAparent.MD_tl_Request__c;
        this.Risk_Classification = this.CAparent.CPI_rb_Risk_Classification__r.Name;
        this.Current_Exposure = (this.CAparent.MD_Current_Exposure__c)/(1000);
        this.Obligor_Ca = this.CAparent.ES2_re_Obligor__c;
        this.Risk_Dec_Entity = this.CAparent.CPL_rb_EntityCP__r.Name;
        this.Opp_Mxn = this.CAparent.ES3_rm_Total_opportunities_in_MXN__c;
        this.Opp_USD = this.CAparent.ES3_rm_Total_opportunities_in_USD__c;
        this.Sum_Opp_USD = this.CAparent.ES3_fm_Total_Opportunities_USD__c;
        this.Total_Exposure = this.CAparent.Exposure__c;
        this.Visit_Pass = this.CAparent.MD_ls_Visit_Pass__c;
        this.Visit_Date = this.CAparent.MD_fh_Visit__c;
        this.Comments_Visit = this.CAparent.MD_tl_Comments_Visit__c;
        this.Comments_Google_Search = this.CAparent.MD_tl_Google_Search__c;
        this.Google_Search_Date = this.CAparent.MD_fh_Google_Search__c;
        this.Google_Search_Pass = this.CAparent.MD_ls_Google_Search__c;
        this.img1 = this.CAparent.MD_te_img_1__c;
        this.img2 = this.CAparent.MD_te_img_2__c;
        this.tc = this.CAparent.CPI_nu_CA_Rate_c__c;
        this.Totaltc =((this.Sum_Opp_USD + Current_Exposure))/1000;
        this.EC = this.CAparent.MD_tx_EC_Insurance_Financed__c;
        this.Advance = this.CAparent.MD_tx_Advance_Rent__c;
        this.GrossMargin= this.CAparent.MD_tx_Gross_Margin__c;
        this.PpDeal= this.CAparent.MD_tx_PP_Deal__c;
        this.ApprovalOR=this.CAparent.CPI_rb_OR_rating__r.Name;
        this.OROverride=this.CAparent.CPI_rb_OR_Override__r.Name;

        
        
        
                       
       this.opors = json.serialize(cAndCStructure);
       system.debug('Opps: ' + opors);
                }
        Catch(Exception e)
        {
            System.debug('Algun campo esta null');
            //this.OppInCA = new Opportunity_in_Credit_approval_CP__c();
        }

    }
    
  public void cargaEntityEstructure()
    {
        this.entityStructure = new List<ES3_WraperEntityStructure>();
        if(this.opps != null && this.opps.size()>0)
        {
            
            for(ES3_OpportunitiesInCaWraper op : this.opps )
            {
                ES3_WraperEntityStructure wEE = new ES3_WraperEntityStructure();
                wEE.oportunityName = op.oppInCa.ES3_fm_Opportunity_Name__c;
                //recorrer las oportunidades para encontrar los roles de las entidades
                if(op.entityInCa.size()>0)
                {
                    List<ES2_Obj_EntityMasterInCreditApproval__c> list_entities = new List<ES2_Obj_EntityMasterInCreditApproval__c>();
                    
                    for(ES2_Obj_EntityMasterInCreditApproval__c einCA : op.entityInCa)
                    {
                        if(einCA.ES2_rb_Credit_approval__c == this.CAparentId){
							list_entities.add(einCA);
                 		}
                    }
                                        
                    for(ES2_Obj_EntityMasterInCreditApproval__c einCA : list_entities)
                    {
                     	wEE = cargaVarsEstructure(einCA, wEE);
                    }
                    
                    
                }
                
               entityStructure.add(wEE);
            }
        }        
    }

    public ES3_WraperEntityStructure cargaVarsEstructure(ES2_Obj_EntityMasterInCreditApproval__c einCA, ES3_WraperEntityStructure wEE)
    {

        if(!String.isBlank(einCA.ES2_ms_Role__c))
        {
            If(einCA.ES2_ms_Role__c.contains( 'Obligor' ))
            {
                wEE.obligor = wEE.obligor + einCA.ES2_tx_Oracle_Account_Name__c + '</br>';                
            }
            If(einCA.ES2_ms_Role__c.contains( 'Guarantor' ))
            {
                wEE.guarantor = wEE.guarantor + einCA.ES2_tx_Oracle_Account_Name__c + '</br>';   
            }
            If(einCA.ES2_ms_Role__c.contains( 'Risk Decision Entity' ))
            {
                wEE.riskDescisionEntity = wEE.riskDescisionEntity + einCA.ES2_tx_Oracle_Account_Name__c + '</br>';   
            }
            If(einCA.ES2_ms_Role__c.contains( 'Beneficial Owner' ))
            {
                wEE.beneficialOwner = wEE.beneficialOwner + einCA.ES2_tx_Oracle_Account_Name__c + '</br>';   
            }   
            If(einCA.ES2_ms_Role__c.contains( 'Legal Depositary' ))
            {
                wEE.legalDepositary = wEE.legalDepositary + einCA.ES2_tx_Oracle_Account_Name__c + '</br>';   
            }              
        }
        System.debug('EntityStructure wEE OEJ:' + wEE);
        return wEE;
        
    }
    
    public void cargaCAndCEstructure()
    {
        this.cAndCStructure = new List<ES3_WraperEntityStructure>();
        if(this.opps != null && this.opps.size()>0)
        {
            System.debug('Opportunidades'+ opps.size());
            for(ES3_OpportunitiesInCaWraper op : this.opps )
            {
               
                ES3_WraperEntityStructure wEE = new ES3_WraperEntityStructure();
                wEE.oportunityName = op.oppInCa.ES3_fm_Opportunity_Name__c;
                system.debug('JD: op.specialcondition' + op.specialCondition);
                //recorrer las oportunidades para encontrar covenants y Special Conditions
                if(op.specialCondition.size()>0)
                {
                    for(ES3_obj_Condition_Service_covenant__c sCondition : op.specialCondition)
                    {
                        System.debug('JD: scondition' + sCondition);
                        if(String.isBlank(sCondition.ES3_tx_Coments__c)) { sCondition.ES3_tx_Coments__c = ''; }
                        wEE.specialCondition = wEE.specialCondition + sCondition.ES3_lst_Condition__c + '; ' + sCondition.ES3_lt_Timing__c + '; ' + sCondition.ES3_TXT_Description__c + ' ' + sCondition.ES3_tx_Coments__c + ' </br>';  
                    }
                }
                
                if(op.covenants.size()>0)
                {
                    
                    for(ES3_obj_Condition_Service_covenant__c sCovenant : op.covenants)
                    {
                        
                       system.debug('JD: scovenants' + sCovenant.RecordType.Name);

                        if(sCovenant.RecordType.Name.contains('Qualitative'))
                        {
                            if(String.isNotBlank(sCovenant.ES3_LST_Covenant_Cualitativo__c))
                            {
                                System.debug('JD: sCovenant' + sCovenant);
                                if(String.isBlank(sCovenant.ES3_tx_Coments__c)) {sCovenant.ES3_tx_Coments__c = ''; }
                                wEE.covenantCualitativo = wEE.covenantCualitativo +  sCovenant.ES3_TXT_Threshold__c + '; ' + sCovenant.ES3_LT_Timing_Cualitativo__c + '; ' + sCovenant.ES3_LST_Covenant_Cualitativo__c + '; ' + sCovenant.ES3_tx_Coments__c + '</br>' ;      
                                if( String.isNotEmpty(sCovenant.ES3_rb_Entity__c)) { wEE.covenantCualitativo = wEE.covenantCualitativo + sCovenant.ES3_rb_Entity__r.Name + '</br>'; }
                            }
                        }
                        if(sCovenant.RecordType.Name.contains('Quantitative'))
                        {
                            if(String.isNotBlank(sCovenant.ES3_lst_Covenant_Cuantitativo__c))
                            {
                                System.debug('JD: sCovenant' + sCovenant);
                                if(String.isBlank(sCovenant.ES3_tx_Coments__c )){ sCovenant.ES3_tx_Coments__c = ''; }
                                wEE.covenantCuantitativo = wEE.covenantCuantitativo + sCovenant.ES3_LT_Min_Max__c + '; ' +  sCovenant.ES3_TXT_Threshold__c + '; ' + sCovenant.ES3_LT_Timing_Cuantitativo__c + '; ' + sCovenant.ES3_lst_Covenant_Cuantitativo__c + '; ' + sCovenant.ES3_tx_Coments__c + '</br>' ;      
                                if( String.isNotEmpty(sCovenant.ES3_rb_Entity__c)) { wEE.covenantCuantitativo = wEE.covenantCuantitativo + sCovenant.ES3_rb_Entity__r.Name + '</br>'; }
                            }
                            
                        }
                    }
                }                
               cAndCStructure.add(wEE);
            }
        }        
    }
    
    
    public void cargaCreditApproval() {
        system.debug('Se recibio el ID del Credit Approval OEJ--:' + this.CAparentId);
        //Buscamos y cargamos el Credit Approval
        try{
            this.CAparent = [Select Id, OwnerId, Name, CurrencyIsoCode, RecordTypeId, RecordType.name, CreatedDate, CreatedById, CPL_lm_Documentos_HandOff__c, 
                             CPL_ls_DocumentsForUnderwriting__c, CPL_rb_EntityCP__r.Name, CPL_rb_MOD_de_Credit_approval_CP__c, CPL_rb_account__c, 
                             CPL_rb_account__r.ACC_fm_Target_Market__c, CPL_rb_account__r.Owner.FirstName, CPL_rb_account__r.Owner.LastName,
                             Exposure__c, CPL_fm_Opportunities_Exposure__c, CPL_ls_StageName__c, toLabel(Type_of_credit_approval__c),
                             CPL_fm_Amount_of_opportunities__c, CPL_fm_Opportunities_in_credit_approval__c, CPI_Date_Questionary_sent_date__c, 
                             CPI_ck_FueAprobado__c, CPI_ck_ItMayBeProvidedInAnotherCurrency__c, CPI_date_Questionary_Received__c, 
                             CPI_fh_Proposal_Signed_Received_Date__c, CPI_fm_SIC_Code_Description__c, CPI_ls_Reason_Lost_Level_1__c, 
                             CPI_ls_Reason_Lost_Level_2__c, CPI_ls_Reason_Lost_Level_3__c, CPI_ls_Reason_Won_Level_1__c, CPI_ls_Reason_Won_Level_2__c, 
                             CPI_nu_CA_Rate_c__c, CPI_rb_Competitor__c, CPI_rb_OR_Override__c, CPI_rb_OR_rating__c, CPI_rb_Risk_Classification__r.Name, 
                             CPI_rb_SIC_code__r.Name, CPI_tx_Customer_Since__c, CPI_tx_Lost_Comments__c, CPI_tx_Not_Signed_Proposal_Reason__c, CPI_tx_OR_ID__c, 
                             CPI_tx_Risk_Economic_Group__c, CPI_tx_Won_Comments__c, CPI_un_Capex_Exposure__c, CPI_un_Fleet_Exposure__c, 
                             CPI_un_Real_Estate_Exposure__c, CPI_un_Technology_Exposure__c, CPL_ls_OR_Source__c, Risk_INtern__c,Risk_Analyst__r.FirstName, Risk_Analyst__r.LastName, Inside_Sales__c,
                             Inside_Sales__r.FirstName,Inside_Sales__r.LastName,CPL_rb_account__r.Name,
                             Sr_Underwriter__c,Sr_Underwriter__r.FirstName, Sr_Underwriter__r.LastName, Approval_Level__c, ROI__c,  On_Hold_Comments__c, Additional_Approved_Products__c, 
                             Decision_Date__c, Government__c, of_Government_Revenues__c, Government_Level__c, Override_Reason__c, ES2_re_Guarantor__c, 
                             ES2_re_Obligor__c, ES2_re_Risk_Desicion_Entity__c, ES3_tx_Top_Parent_Name__c, ES3_rb_Legal_Team_Member__c, ES3_TX_MRA_ID__c, 
                             ES3_tx_Bloomberg_ID__c, ES3_TX_HNWI_ID__c, ES3_fm_Total_Opportunities_USD__c, ES3_rm_Total_opportunities_in_MXN__c, 
                             ES3_rm_Total_opportunities_in_USD__c, ES3_ls_AML_Review_Status__c, ES3_tx_Risk_Economic_Group_Id__c, ES3_pl_AML_Rework_reason__c, 
                             ES3_tx_AML_Rework_Comment__c, ES3_pl_AML_Declined_Comment__c,
                             ES3_ls_RISK_REVIEW_STATUS__c, ES3_pl_Risk_Rework_reason__c, ES3_tx_Risk_Rework_Comment__c, ES3_fm_Customer_Since__c, 
                             SP3_pl_Credit_Approval_Status__c, SP3_nu_Process_Builder_Trigger__c, SP3_pl_Send_for_Approval__c, ES3_pl_AML_tomado__c, 
                             ES3_pl_Tomar_CA_para_RISK_Review__c, RecordType_List__c, Doctypes__c, ES3_CA_Comments__c , ES3_Approve_WC_Comments__c, bkl_ls_vendor__c, BKL_TXT_Credit_Approval_Summary__c,ES3_tx_Account_Name__c,
                             Risk_Analyst__c,CPI_rb_OR_rating__r.Name,CPI_rb_OR_Override__r.Name,
                            
                             //DATOS DE MAC
                             MC3_date_New_Expiration_Date__c,
                             //terminan datos de mac
                             //DATOS DE MOD
                             MD_ca_AddOn__c,MD_tl_Background__c,MD_ca_Carveout__c,MD_tl_Bil_Comments__c,MD_tl_CBureau_Comments__c,
                             MD_tl_FiscalSituation__c,MD_tl_PaymentTrend_Comments__c,MD_fh_FiscalSituation__c,MD_fh_PaymentTrend_Date__c,
                             MD_at_Description__c,MD_at_Endorsement__c,MD_date_Fecha_Vigencia__c,
                             MD_ca_Incremental__c,MD_tl_Last_Approved_Int__c,MD_ls_Bil_Pass__c,MD_ls_CBureau_Pass__c,MD_ls_FiscalSituation_Pass__c,
                             MD_ls_PaymentTrend_Pass__c,MD_tl_Rationale__c,MD_tl_Request__c,MD_ls_Structure__c,MD_at_Structure_comments__c,
                             MD_fh_Bil__c,MD_fh_CBureau__c,MD_Current_Exposure__c,MD_tl_Comments_Visit__c,MD_fh_Visit__c,MD_ls_Visit_Pass__c,
                             MD_tl_Google_Search__c,MD_fh_Google_Search__c,MD_ls_Google_Search__c,MD_ca_MODMAC__c,MD_te_img_1__c,MD_te_img_2__c,MD_un_Exchange_Rate__c,
                             MD_tx_EC_Insurance_Financed__c, MD_tx_PP_Deal__c,MD_tx_Gross_Margin__c,MD_tx_Advance_Rent__c,MD_at_Financial_Inf_Summary__c
                             //Terminan Datos de MOD
                             FROM Credit_approval_CP__c  
                             where Id =:this.CAparentId][0]; 
            
            
            
            
        }
        Catch(Exception e)
        {
            System.debug('OEJ No Existe el CA que Agregar.....');
            //this.OppInCA = new Opportunity_in_Credit_approval_CP__c();
        }  
        
        if(this.CAparent != null)
        {
            //Cargamos las Oportunidades existentes en el Credit Approval
            cargaOpps();
            cargaOppsCar();
        }
    }     
    
    public void cargaOpps()
    {
        List<Opportunity_in_Credit_approval_CP__c> OppsInCA;
        try{
            OppsInCA = [Select Id
                        FROM Opportunity_in_Credit_approval_CP__c  
                        where CP_rb_Credit_approval_CP__c =:this.CAparentId]; 
            System.debug('OEJ Opps in CA.....:' + OppsInCA);
        }
        Catch(Exception e)
        {
            System.debug('OEJ No Hay Opps que Agregar.....');
            //this.OppInCA = new Opportunity_in_Credit_approval_CP__c();
        }  
        
        if(OppsInCA.size()>0)
        {
            opps = new List<ES3_OpportunitiesInCaWraper>();
            System.debug('OEJ OppsInCA.size().....' + OppsInCA.size());
            for(Opportunity_in_Credit_approval_CP__c op : OppsInCA)
            {
                ES3_OpportunitiesInCaWraper oppWraper= new ES3_OpportunitiesInCaWraper(op.id);
                opps.add(oppWraper);
            }
            
            
        }
    }
  
    
        public void cargaOppsCar()
    {
        List<Carveout_in_Credit_Approval_CP__c> OppsInCarveout;
        try{
            OppsInCarveout= [Select Id, Name,Opportunity_in_CA__c	, Opportunity_in_CA__r.Name , count_carvaut__c,CreatedById,CurrencyIsoCode,LastModifiedById,MD_Amount__c,MD_chec_Copy_Date_MAC__c,
                                  MD_date_Date__c,MD_fm_Restado__c,MD_fm_Sumado__c,MD_num_Destination_Amount__c,MD_Opp_use_by_carveaut__c,MD_Opportunity__r.Name,
                                  MD_rl_Destination_Opportunity__c,MD_rls_Credit_approval__c,MD_rls_Credit_approval__r.Name
                           
                            FROM Carveout_in_Credit_Approval_CP__c   
                            where MD_rls_Credit_approval__c=:this.CAparentId]; 
            System.debug('OEJ Opps in CA.....:' + OppsInCarveout);
        }
        Catch(Exception e)
        {
            System.debug('OEJ No Hay Opps que Agregar.....');
            //this.OppInCA = new Opportunity_in_Credit_approval_CP__c();
        }  
        
        if(OppsInCarveout.size()>0)
        {
            oppsCar = new List<MD_ExtencionControllerOpcas>();
            System.debug('OEJ OppsInCA.size().....' + OppsInCarveout.size());
            for(Carveout_in_Credit_Approval_CP__c op2 : OppsInCarveout)
            {
                MD_ExtencionControllerOpcas oppWraper2= new MD_ExtencionControllerOpcas(op2.id); 
                oppsCar.add(oppWraper2);
                 
            }
            
            
        }
    }

    
    

    public PageReference backToCA()
    {
        PageReference pr = new PageReference('/' + this.CAparentId);            
        
        pr.setRedirect(true); //recargamos el controlador         
        return pr;
    }
    
    

}