public class ES3_controller_ColsingMemo {
    
    public string 								CAparentId			    		{get;set;}
    public List<ES3_OpportunitiesInCaWraper>	opps     						{get;set;}
    public Credit_approval_CP__c 				CAparent						{get;set;}
    public Date 								Approval_Date					{get;set;}
    public String 								UW								{get;set;}
    public String 								Uww								{get;set;}
    public String 								Originador						{get;set;}
    public String 								Approval_Level					{get;set;}
    public String 								Business_Type					{get;set;}    
    public String 								CA								{get;set;}  
    public String								Aml								{get;set;}
    public String								Risk							{get;set;}
    public String 								CAstage							{get;set;}
    public String 								Economic_Group					{get;set;}
    public String 								Economic_Group_Id			    {get;set;}
    public List<ES3_WraperEntityStructure>		entityStructure 				{get;set;}
    public List<ES3_WraperEntityStructure>		cAndCStructure 					{get;set;}
    public List<WK_Exporsure__c> 				exposure  						{get;set;}
    public string opors {get;Set;}
    public Boolean isTypeWK {get;set;}
  
    
    public ES3_controller_ColsingMemo()
    {
        this.CAparentId =  (String)System.currentPageReference().getParameters().get('CAId');
        cargaCreditApproval();
        //cargaOpps();
        cargaEntityEstructure();
        cargaCAndCEstructure();
        this.Approval_Date	= this.CAparent.Decision_Date__c;				  
        this.UW	= this.CAparent.Sr_Underwriter__r.FirstName + ' ' + this.CAparent.Sr_Underwriter__r.LastName;	
        this.Uww = this.CAparent.Risk_Analyst__r.FirstName + ' ' + this.CAparent.Risk_Analyst__r.LastName;				  	
        this.Originador	= this.CAparent.CPL_rb_account__r.Owner.FirstName + ' ' + this.CAparent.CPL_rb_account__r.Owner.LastName;	
        this.Approval_Level	= this.CAparent.Approval_Level__c;				  		
        this.Business_Type		= this.CAparent.CPL_rb_account__r.ACC_fm_Target_Market__c;	
        this.CA		= this.CAparent.Name;	
        this.Aml=this.CAparent.ES3_ls_AML_Review_Status__c;
        this.Risk=this.CAparent.ES3_ls_RISK_REVIEW_STATUS__c;
        this.CAstage=this.CAparent.CPL_ls_StageName__c;
       
        this.Economic_Group		= this.CAparent.CPI_tx_Risk_Economic_Group__c;
        this.Economic_Group_Id = this.CAparent.ES3_tx_Risk_Economic_Group_Id__c;
        this.opors = json.serialize(cAndCStructure);
        system.debug('opps: ' + opors);
        this.isTypeWK = getIsRecordTypeWK(CA); 
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
    
   public void ratePercent()
   {
       
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
                             CPL_ls_DocumentsForUnderwriting__c, CPL_rb_EntityCP__c, CPL_rb_MOD_de_Credit_approval_CP__c, CPL_rb_account__c, 
                             CPL_rb_account__r.ACC_fm_Target_Market__c, CPL_rb_account__r.Owner.FirstName, CPL_rb_account__r.Owner.LastName,
                             Exposure__c, CPL_fm_Opportunities_Exposure__c, CPL_ls_StageName__c, toLabel(Type_of_credit_approval__c),
                             CPL_fm_Amount_of_opportunities__c, CPL_fm_Opportunities_in_credit_approval__c, CPI_Date_Questionary_sent_date__c, 
                             CPI_ck_FueAprobado__c, CPI_ck_ItMayBeProvidedInAnotherCurrency__c, CPI_date_Questionary_Received__c, 
                             CPI_fh_Proposal_Signed_Received_Date__c, CPI_fm_SIC_Code_Description__c, CPI_ls_Reason_Lost_Level_1__c, 
                             CPI_ls_Reason_Lost_Level_2__c, CPI_ls_Reason_Lost_Level_3__c, CPI_ls_Reason_Won_Level_1__c, CPI_ls_Reason_Won_Level_2__c, 
                             CPI_nu_CA_Rate_c__c, CPI_rb_Competitor__c, CPI_rb_OR_Override__c, CPI_rb_OR_rating__c, CPI_rb_Risk_Classification__c, 
                             CPI_rb_SIC_code__c, CPI_tx_Customer_Since__c, CPI_tx_Lost_Comments__c, CPI_tx_Not_Signed_Proposal_Reason__c, CPI_tx_OR_ID__c, 
                             CPI_tx_Risk_Economic_Group__c, CPI_tx_Won_Comments__c, CPI_un_Capex_Exposure__c, CPI_un_Fleet_Exposure__c, 
                             CPI_un_Real_Estate_Exposure__c, CPI_un_Technology_Exposure__c, CPL_ls_OR_Source__c, Risk_INtern__c, Risk_Analyst__c,Risk_Analyst__r.FirstName,Risk_Analyst__r.LastName, Inside_Sales__c,
                             Inside_Sales__r.FirstName,Inside_Sales__r.LastName,
                             Sr_Underwriter__c,Sr_Underwriter__r.FirstName, Sr_Underwriter__r.LastName, Approval_Level__c, ROI__c,  On_Hold_Comments__c, Additional_Approved_Products__c, 
                             Decision_Date__c, Government__c, of_Government_Revenues__c, Government_Level__c, Override_Reason__c, ES2_re_Guarantor__c, 
                             ES2_re_Obligor__c, ES2_re_Risk_Desicion_Entity__c, ES3_tx_Top_Parent_Name__c, ES3_rb_Legal_Team_Member__c, ES3_TX_MRA_ID__c, 
                             ES3_tx_Bloomberg_ID__c, ES3_TX_HNWI_ID__c, ES3_fm_Total_Opportunities_USD__c, ES3_rm_Total_opportunities_in_MXN__c, 
                             ES3_rm_Total_opportunities_in_USD__c, ES3_ls_AML_Review_Status__c, ES3_tx_Risk_Economic_Group_Id__c, ES3_pl_AML_Rework_reason__c, 
                             ES3_tx_AML_Rework_Comment__c, ES3_pl_AML_Declined_Comment__c, 
                             ES3_ls_RISK_REVIEW_STATUS__c, ES3_pl_Risk_Rework_reason__c, ES3_tx_Risk_Rework_Comment__c, ES3_fm_Customer_Since__c, 
                             SP3_pl_Credit_Approval_Status__c, SP3_nu_Process_Builder_Trigger__c, SP3_pl_Send_for_Approval__c, ES3_pl_AML_tomado__c, 
                             ES3_pl_Tomar_CA_para_RISK_Review__c, RecordType_List__c, Doctypes__c, ES3_CA_Comments__c , ES3_Approve_WC_Comments__c, bkl_ls_vendor__c, BKL_TXT_Credit_Approval_Summary__c, toLabel(Type_of_credit_approval_Workout__c),
                             //DATOS DE MAC
                             MC3_date_New_Expiration_Date__c
                             
                             //terminan datos de mac
                             //
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
    public PageReference backToCA()
    {
        
       
        PageReference pr = new PageReference('/' + this.CAparentId);
        
        pr.setRedirect(true); //recargamos el controlador         
        return pr;
    }
    
    
    // Metodo que retorna una consulta al objeto Exporsure, la cual permitirá llenar la tabla Exposure.    
    @AuraEnabled
    public static List<WK_Exporsure__c> getExposures(String EGId){
        System.debug('EGId: '+EGId);
        Integer EcGroupId= Integer.valueOf(EGId);
        List<WK_Exporsure__c> exposure = [SELECT 
                    	Id,
                    	WK_party_name__c,
                    	WK_economicGroupName__c, 
                    	WK_oracleAccountNumber__c, 
                    	WK_contractNumber__c, 
                    	WK_currency__c, 
                        Name, 
                    	WK_contractOec__c, 
                    	WK_exposure__c, 
                    	WK_nbv__c, 
                    	WK_open_Items_Ar__c, 
                    	WK_days_Due_Ar__c, 
                    	WK_open_Items_Dlq__c, 
                    	WK_days_Due_Dlq__c, 
                    	vertical__c 
                    FROM 
                    	WK_Exporsure__c
                    WHERE WK_economicGroupId__c=:EcGroupId];
        return exposure;
    	
    } 
    
    // Metodo que regresa un booleano para que permite verificar si el recordType del CA es de tipo Workout
     @AuraEnabled
    public static boolean getIsRecordTypeWK(String nameCA){
        RecordType idRecordTypeIdWK= [SELECT Id FROM RecordType where SobjectType='Credit_approval_CP__c' and Name='Workout'];
        boolean isRecordTypeWK = false;
        Credit_approval_CP__c ca = [SELECT RecordTypeId FROM Credit_approval_CP__c where name=: nameCA];
        if(ca.RecordTypeId == idRecordTypeIdWK.Id ){
            isRecordTypeWK=true;
        } 
        
        return isRecordTypeWK;
    	
    } 
    
}