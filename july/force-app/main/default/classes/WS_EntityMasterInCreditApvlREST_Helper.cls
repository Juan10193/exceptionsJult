public class WS_EntityMasterInCreditApvlREST_Helper {
    list<ES2_Obj_EntityMasterInCreditApproval__c> enititesInCaTable {get;set;} 
    public boolean showEdit {get;Set;}
    public boolean noQuery {get;Set;}
    public string urlBack  {get;Set;}
    public string rol {get;Set;}
    public string caChangeRol {get;set;}
    private final ES2_Obj_EntityMasterInCreditApproval__c emInCa;
    public EIV_DetailWrapClass detail                   {get;set;}
    public List<EIV_EntityWrapClass> entities           {get;set;}
    public EIV_EntityWrapClass entity                   {get;set;}
    public Credit_approval_CP__c CA                     {get;set;}	
    public String idCreditApproval                      {get;set;}
    public String sServiceURL                           {get;set;}
    public String sSSO                                  {get;set;}
    public String sTopParentName                        {get;set;}
    public String sTopParentId                          {get;set;}
    public String sEconomicGroup                        {get;set;}
    public List<ES2_WraperRequest> requestList          {get;set;}
    public String sEconomicGroupIdSelected;
    public String sEntityMasterIdSelected;
    public String sOpportunityIdSelected;
    public String sOpportunityIdSelectedCarv;
    public Opportunity_in_Credit_approval_CP__c OppInCA {get;set;}
    public Carveout_in_Credit_Approval_CP__c OppInCarveout {get;set;}
//public String urlValue                              {get;set;}
    public String sIdChild                              {get;set { sIdChild = value; System.debug('value sIdChild OEJ: '+value); }}
    public String sRoleChild                            {get;set { sRoleChild = value; System.debug('value sRoleChild OEJ: '+value); }}
    public boolean updtEcg						{get;set;}
    public boolean updtEntities {get;set;}
    public string  recordtypeCa {get;set;}
    public String getsEntityMasterIdSelected() {
        system.debug('yo estoy con ' + this.sEntityMasterIdSelected);
        return this.sEntityMasterIdSelected;
    }
    
    public void setsEntityMasterIdSelected(String sEntityMasterIdSelected) {
        system.debug('Se selecciono La entidad sEntityMasterIdSelected OEJ--:' + this.sEntityMasterIdSelected);
        for (EIV_EntityWrapClass f : entities) {  
            //system.debug('Se busca La entidad sEntityMasterIdSelected OEJ--:' + f);
            if(f.Party_Id == sEntityMasterIdSelected )
            {
                system.debug('Se selecciono La entidad OEJ--:' + f);
                this.entity = f;
                searchRequest();
                //system.debug('La entidad tiene estas solicitudes OEJ--:'+ requestList.size() + '------' + requestList);
                DateTime dtAML = (DateTime)JSON.deserialize('"1990-10-08T11:08:17Z"', DateTime.class);
                DateTime dtCB = (DateTime)JSON.deserialize('"1990-10-08T11:08:17Z"', DateTime.class);
                for(ES2_WraperRequest req : requestList)
                {
                    if(req.pOutRequestType == 'CREDIT BUREAU')
                    {
                        if(dtCB < (DateTime)JSON.deserialize('"' + req.pOutLastUpdateDate.remove('.000-05:00') + 'Z"', DateTime.class))
                        {
                            dtCB =(DateTime)JSON.deserialize('"' + req.pOutLastUpdateDate.remove('.000-05:00') + 'Z"', DateTime.class);
                            System.debug('Es CB req.pOutLastUpdateDate OEJ:' + req.pOutLastUpdateDate  );
                        }
                        
                    }
                    if(req.pOutRequestType == 'AML HITS CRR')
                    {
                        if(dtAML < (DateTime)JSON.deserialize('"' + req.pOutLastUpdateDate.remove('.000-05:00') + 'Z"', DateTime.class))
                        {
                            dtAML = (DateTime)JSON.deserialize('"' + req.pOutLastUpdateDate.remove('.000-05:00') + 'Z"', DateTime.class);
                            System.debug('Es AML req.pOutLastUpdateDate OEJ:' + req.pOutLastUpdateDate  );
                        }
                        
                    }
                }
            }                                                            
        }
        
    }    
    
    public String getsOpportunityIdSelected() {
        return this.sOpportunityIdSelected;
    }
    
    public void setsOpportunityIdSelected(String sOpportunityIdSelected) {
        system.debug('Se selecciono La oportunidad sOpportunityIdSelected OEJ--:' + sOpportunityIdSelected);
        try{
            this.OppInCA = [Select  CPL_dv_AmountOPP__c, ES3_nu_Amount_Numeric__c, CP_rb_Credit_approval_CP__c, ES3_fm_CreditApproval_RecordType__c, 
                            CP_rb_Oportunidad__c, ES3_fm_Opportunity_Name__c, Products__c, Id, name 
                            from Opportunity_in_Credit_approval_CP__c where Id =:sOpportunityIdSelected][0]; 
            this.OppInCarveout = [Select Id,  MD_rl_Destination_Opportunity__r.Name  from Carveout_in_Credit_Approval_CP__c where   MD_rls_Credit_approval__c =:this.idCreditApproval];
        }
        Catch(Exception e)
        {
            System.debug('OEJ No Hay Opps que Agregar.....');
            //this.OppInCA = new Opportunity_in_Credit_approval_CP__c();
        }  
        
    }    

    
    public WS_EntityMasterInCreditApvlREST_Helper()
    {}
    // The extension constructor initializes the private member
    // variable acct by using the getRecord method from the standard
    // controller.
    public WS_EntityMasterInCreditApvlREST_Helper(ApexPages.StandardController stdController) {
        List<Profile> PROFILE = [SELECT Id, Name FROM Profile WHERE Id=:userinfo.getProfileId() LIMIT 1];
		String MyProflieName = PROFILE[0].Name;
        this.emInCa = (ES2_Obj_EntityMasterInCreditApproval__c)stdController.getRecord();
        system.debug('EL ESTANDAR');
        system.debug(this.emInCa);
        this.idCreditApproval = emInCa.ES2_rb_Credit_approval__c;
        this.sServiceURL =test.isRunningTest()?'123456' : [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='URL_Servicio'][0].EIV_tx_parameter__c; 
        this.sSSO = test.isRunningTest()?'123456' : [Select EmployeeNumber From User Where Id = :UserInfo.getUserId()][0].EmployeeNumber; 
        //this.urlvalue=Apexpages.currentPage().getUrl();
        //System.debug('OEJ urlvalue=' + this.urlvalue);
            	   this.CA = [Select RecordTypeId, 
                   CPL_rb_account__r.ACC_rb_Top_Parent_Account__c, 
                   CPI_tx_Risk_Economic_Group__c,
                   ES3_tx_Risk_Economic_Group_Id__c,
                   CPI_rb_SIC_code__r.name,
                   Type_of_credit_approval__c,
                   CPI_rb_SIC_code__c,
                   CPI_fm_SIC_Code_Description__c,
                   Id,
                   CPI_rb_OR_rating__c,
                   name,
                   CPL_rb_account__c,
                   	CPL_ls_StageName__c
                   from  Credit_approval_CP__c 
                   where id =:emInCa.ES2_rb_Credit_approval__c][0];
        SYSTEM.debug('EL CA ORALE');
        system.debug(this.CA); 
                   this.recordtypeCa = test.isRunningTest()?'Workout':Schema.getGlobalDescribe().get('Credit_approval_CP__c').getDescribe().getRecordTypeInfosById().get(CA.RecordTypeId).getName();

        if(CA.CPI_tx_Risk_Economic_Group__c ==''||CA.CPI_tx_Risk_Economic_Group__c==null){
            updtEcg=false;
        } else{ updtEcg=true; } 
        
        List<ES2_Obj_EntityMasterInCreditApproval__c> entitiesInCA = getEntitiesInCA();
        
         if(entitiesInCA.size()==0){  this.updtEntities =false;
            
         }else{
            this.updtEntities=true;
             
         }
        
        this.showEdit =(CA.CPL_ls_StageName__c=='Approved' || CA.CPL_ls_StageName__c== 'Withdrawn' || CA.CPL_ls_StageName__c== 'Declined')&&(MyProflieName != 'Administrator')?false:true;
        this.enititesInCaTable = getEntitiesInCA();
    }

    public void searchRequest()
    {
        requestList = new List<ES2_WraperRequest>();
        //getdummyRequest();
        Map<string,object>jsonResponse =null;
        jsonResponse = EIV_EntityExtencionCalloutClass.callBackGetRequestForPartyId(this.sSSO, 'SF', this.sServiceURL, this.entity.Party_Id);
        system.debug('JD: RESPUESTA ' + jsonResponse);
        if(jsonResponse != null)
            
        {
            Map<String, Object> mapRequests = (Map<String, Object>)jsonResponse.get('requests');
            if(mapRequests==null)
            {
                System.debug('OEJ: No existen solicitudes requests que revisar');
            }   
            else
            {
                System.debug('OEJ: Si existen solicitudes requests que revisar');
                ES2_Controller_KWYPMoralFill rellena = new  ES2_Controller_KWYPMoralFill();
                
                
                requestList = rellena.rellenarHeader(mapRequests);
                system.debug('lista de request OEJ : ' + requestList.size() + ' La Lista: ' +requestList);
            }
        }
        else
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Oracle Server missing'));
        }
        
    }    	
    
    public List<ES2_Obj_EntityMasterInCreditApproval__c> getEntitiesInCA() {
        return [Select id, ES3_rb_Opportunity_in_Credit_approval_CP__c, ES3_rb_Opportunity__c, ES2_tx_CostumerType__c,ES2_fm_Entity__c, 
                ES2_url_Entity_Master__c,ES2_tx_Oracle_Account_Name__c, ES2_tx_Party_Id__c,TKD_txt_RFC__c, ES2_ms_Role__c,
                ES3_txt_SIC_Code__c, ES3_txt_SIC_Description__c,ES3_txt_CRR__c,ES3_txt_CRR_Override__c,
                ES3_tx_BloombergID__c,ES3_tx_HNWI_ID__c,ES3_tx_MRAID__c,ES3_tx_Or_Rating__c,ES3_tx_Transaction_Date__c
                from ES2_Obj_EntityMasterInCreditApproval__c where ES2_rb_Credit_approval__c =:this.idCreditApproval];
    }   
}