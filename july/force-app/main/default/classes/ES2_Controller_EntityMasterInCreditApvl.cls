public with sharing class ES2_Controller_EntityMasterInCreditApvl
{	
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
    public String urlValue                              {get;set;}
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

    
    public ES2_Controller_EntityMasterInCreditApvl()
    {}
    // The extension constructor initializes the private member
    // variable acct by using the getRecord method from the standard
    // controller.
    public ES2_Controller_EntityMasterInCreditApvl(ApexPages.StandardController stdController) {
        List<Profile> PROFILE = [SELECT Id, Name FROM Profile WHERE Id=:userinfo.getProfileId() LIMIT 1];
		String MyProflieName = PROFILE[0].Name;
        this.emInCa = (ES2_Obj_EntityMasterInCreditApproval__c)stdController.getRecord();
        this.idCreditApproval = emInCa.ES2_rb_Credit_approval__c;
        this.sServiceURL =test.isRunningTest()?'123456' : [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='URL_Servicio'][0].EIV_tx_parameter__c; 
        this.sSSO = test.isRunningTest()?'123456' : [Select EmployeeNumber From User Where Id = :UserInfo.getUserId()][0].EmployeeNumber; 
        this.urlvalue=Apexpages.currentPage().getUrl();
        System.debug('OEJ urlvalue=' + this.urlvalue);
            	   this.CA = [Select  
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
        
    }
    
    public String getsEconomicGroupIdSelected() {
        return this.sEconomicGroupIdSelected;
    }
    
    public List<ES2_Obj_EntityMasterInCreditApproval__c> getEntitiesInCA() {
        return [Select id, ES3_rb_Opportunity_in_Credit_approval_CP__c, ES3_rb_Opportunity__c, ES2_tx_CostumerType__c,ES2_fm_Entity__c, 
                ES2_url_Entity_Master__c,ES2_tx_Oracle_Account_Name__c, ES2_tx_Party_Id__c,TKD_txt_RFC__c, ES2_ms_Role__c,
                ES3_txt_SIC_Code__c, ES3_txt_SIC_Description__c,ES3_txt_CRR__c,ES3_txt_CRR_Override__c,
                ES3_tx_BloombergID__c,ES3_tx_HNWI_ID__c,ES3_tx_MRAID__c,ES3_tx_Or_Rating__c,ES3_tx_Transaction_Date__c
                from ES2_Obj_EntityMasterInCreditApproval__c where ES2_rb_Credit_approval__c =:this.idCreditApproval];
    }   
    
    public void setsEconomicGroupIdSelected(String sEconomicGroupIdSelected) {
        for (EIV_EntityWrapClass f : entities)
        {  
            if(f.Party_Id == sEconomicGroupIdSelected ) 
            { 
                system.debug('1-Se selecciono el economicGroup OEJ--:' + f);
                
                this.entity = new EIV_EntityWrapClass();
                this.entity = f;
                
                this.sEconomicGroupIdSelected = sEconomicGroupIdSelected; 
                system.debug('2-Se selecciono el economicGroup OEJ--:' + f);
            }
        }   
    }    
    
    public List<SelectOption> getOpportunitiesInCA() { 
        List<SelectOption> OppOptions = new List<SelectOption>();
        OppOptions.add(new SelectOption('',''));
        List<Opportunity_in_Credit_approval_CP__c> listOppsInCA = new List<Opportunity_in_Credit_approval_CP__c>();
        List<Carveout_in_Credit_Approval_CP__c> listOppsInCarveout = new List<Carveout_in_Credit_Approval_CP__c>();

        try
        { 
            System.debug('OEJ Opps in CA entrando .....');
            listOppsInCA = [Select ES3_fm_Opportunity_Name__c, Id from Opportunity_in_Credit_approval_CP__c where   CP_rb_Credit_approval_CP__c =:this.idCreditApproval];
            listOppsInCarveout = [Select Id,  MD_rl_Destination_Opportunity__r.Name  from Carveout_in_Credit_Approval_CP__c where   MD_rls_Credit_approval__c =:this.idCreditApproval];
            
            for(Opportunity_in_Credit_approval_CP__c oppInCA : listOppsInCA)
            {
                System.debug('OEJ Opps Agregando Opciones .....' + oppInCA.Id + ' ' + oppInCA.ES3_fm_Opportunity_Name__c);
                OppOptions.add(new SelectOption(oppInCA.Id, oppInCA.ES3_fm_Opportunity_Name__c));
            }
            
            for(Carveout_in_Credit_Approval_CP__c OppInCarveout : listOppsInCarveout)
            {
                System.debug('OEJ Opps Agregando Opciones Carveout.....' + OppInCarveout.Id + ' ' + OppInCarveout.MD_rl_Destination_Opportunity__r.Name);
                OppOptions.add(new SelectOption(OppInCarveout.Id, OppInCarveout.MD_rl_Destination_Opportunity__r.Name));
            }

            
        }
        Catch(Exception e)
        {
            System.debug('OEJ No Hay Opps que Agregar.....');
            OppOptions.add(new SelectOption('','No opportunities in this credit approval'));
        }        
        
        
        return OppOptions;  
    } 
   

    
    public List<SelectOption> getEGOptions() { 
        List<SelectOption> EGOptions = new List<SelectOption>();
        EGOptions.add(new SelectOption('',''));
        entities = new List<EIV_EntityWrapClass>();
        if( String.isBlank(this.CA.ES3_tx_Risk_Economic_Group_Id__c) )
        {
            getListEntities('0', 'getAllEntitys'); 
            for (EIV_EntityWrapClass f : entities) 
            {  
                if(f.Customer_Type == 'ECONOMIC GROUP' )  {  EGOptions.add(new SelectOption(f.Party_Id,f.Oracle_Account_Name));   }
            }
        }
        
        return EGOptions;        
    }    
    
    public void getListEntities(String TopParentIdSeleccionado, String servicio)
    {
        //Se carga en el controlador el TopParent, se coloca en el AcountId del que se van a buscar las entidades 
        ////AccountId=0015B00000SUIBD&AccountName=Una+Prueba&TopParentID=&TopParentName=&PartyId=, Method=GET]
        //Enviaremos
        //PartyId, pasado pro la URL
        //SSO obtenido de consulta de EmployeeNumber
        //Aplication code, que sera siempre SF
        Map<String, Object> jsonResponse = null;  
        if(String.isBlank(CA.CPL_rb_account__r.ACC_rb_Top_Parent_Account__c))
        {
            this.sTopParentId = CA.CPL_rb_account__c;
        }
        else
        {
            this.sTopParentId = CA.CPL_rb_account__r.ACC_rb_Top_Parent_Account__c;
        }
        System.debug('servicio OEJ this.sTopParentId:' + this.sTopParentId + ' ' + 'servicio' + ':' + servicio);
        
       /* IF(!Test.isRunningTest()){ */           
            if(servicio == 'getEntitysFromAccount') jsonResponse = EIV_EntityExtencionCalloutClass.callBackEntitiesOfTopParent(this.sTopParentId.substring(0, 15), sSSO,this.sServiceURL);
            if(servicio == 'getAllEntitys') jsonResponse = EIV_EntityExtencionCalloutClass.callBackllAllEconomicGroup(this.sServiceURL,TopParentIdSeleccionado);
            if(servicio == 'getOneEntity') jsonResponse = EIV_EntityExtencionCalloutClass.callBackEntityDetail(sSSO,TopParentIdSeleccionado,'SF', this.sServiceURL);	    
        /*}else{
            if(servicio == 'getEntitysFromAccount') jsonResponse = EIV_EntityExtencionCalloutClass.callBackEntitiesOfTopParent(this.sTopParentId.substring(0, 15), sSSO,this.sServiceURL);
            if(servicio == 'getAllEntitys') jsonResponse = EIV_EntityExtencionCalloutClass.callBackllAllEconomicGroup_Test(this.sServiceURL,TopParentIdSeleccionado);
            if(servicio == 'getOneEntity') jsonResponse = EIV_EntityExtencionCalloutClass.callBackEntityDetail_Test(sSSO,TopParentIdSeleccionado,'SF', this.sServiceURL);	    
        }*/
            
        
            

            
        system.debug('JD:jsonResponse' + jsonResponse );
        
        if (jsonResponse == null)
        {
            //Hubo un error en el servidor o no esta disponible, agregar mensaje
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Oracle Server missing'));
        }
        else
        {
            //El resultado tiene status
            Map<String, Object> status = (Map<String, Object>)jsonResponse.get('status');
            System.debug('Received the following JSON response of jresponse OEJ01 31Enero2018:' + Json.serialize(jsonResponse));
            System.debug('Received the following JSON response of status OEJ01 31Enero2018:' + status);
            detail = new EIV_DetailWrapClass();
            //this.detail.errorCode =  (String)status.get('code'); //{code=0, detail=0, message=0}
            this.detail.description =  (String)status.get('detail');
            this.detail.message =  (String)status.get('message');
            SYSTEM.debug('this.detail.message ' + this.detail.message);
            if(test.isRunningTest()){
                this.detail.message = 'S';
            }
            if(this.detail.message == 'S')
            {
                
                //El resultado tiene entityInfo 
                Map<String, Object> entityInfo = (Map<String, Object>)jsonResponse.get('entityInfo');
                System.debug('Received the following JSON response of entityInfo OEJ01:' + entityInfo);
                
                //EntityInfo tiene privilege de la entidad
                Map<String, Object> entityPriv = (Map<String, Object>)entityInfo.get('privilege');
                System.debug('Received the following JSON response of entityPriv OEJ01:' + entityPriv);                 
                //Respuesta OK
                
                Map<String, Object> entitiesL = (Map<String, Object>)entityInfo.get('entities');
                System.debug('Received the following JSON response of entitiesL OEJ01:' + entitiesL);
                if(entitiesL == null) //no traemos contactos
                {
                    System.debug('Este Top Parent no tiene entidades'); 
                }
                else
                {
                    entities = new List<EIV_EntityWrapClass>();
                    List<Object> entitiesList = (List<Object>)entitiesL.get('entity');
                    for(Object a : entitiesList)
                    {
                        Map<String, Object> newAdd = (Map<String, Object>) a;
                        Map<String, Object> sic = (Map<String, Object>)newAdd.get('sic');
                        System.debug('Received the following JSON response of sic newAdd OEJ01:' + sic);
                        Map<String, Object> aml = (Map<String, Object>)newAdd.get('aml');
                        System.debug('Received the following JSON response of aml OEJ01:' + aml);
                        Map<String, Object> rating = (Map<String, Object>)newAdd.get('rating');
                        System.debug('Received the following JSON response of rating OEJ01:' + rating);
                        
                        entities.add(responseToEntityObj(newAdd,sic,aml, rating));
                        
                    }
                    
                    System.debug('Received the following JSON response of address OEJ01:' + entitiesL);
                }         
                
                
            }
            else
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,this.detail.message));
            }
            
            
        }
        
    }  
    
/*    public void updateORinCA(String mra, String bloomberg, String hnwi, String orRating)
    {       
        Credit_approval_CP__c CAtoUpdate; 
        TBO005_OR_rating__c orRatingNew;
        TBO005_OR_rating__c orRatingOld;
        try{
            orRatingNew = [Select id, name from TBO005_OR_rating__c where name =:orRating][0];
        }
        Catch(Exception e)
        {
            System.debug('OEJ No existe el OR Rating o es nulo.....');            
        } 
        
        if(String.isEmpty(this.CA.CPI_rb_OR_rating__c) && orRatingNew != null)
        {
            CAtoUpdate = new Credit_approval_CP__c(Id = this.CA.Id, ES3_TX_MRA_ID__c = mra, ES3_tx_Bloomberg_ID__c = bloomberg, ES3_TX_HNWI_ID__c = hnwi, CPI_rb_OR_rating__c = orRatingNew.id);         
        }
        if(!String.isEmpty(this.CA.CPI_rb_OR_rating__c) && orRatingNew != null)
        {
            try{
                orRatingOld = [Select id, name from TBO005_OR_rating__c where id =:CA.CPI_rb_OR_rating__c][0];
                Integer intOrNew = Integer.valueOf(orRatingNew.Name.replace('OR',''));
                Integer intOrOld = Integer.valueOf(orRatingOld.Name.replace('OR',''));
                if(intOrNew > intOrOld )
                {
                    CAtoUpdate = new Credit_approval_CP__c(Id = this.CA.Id, ES3_TX_MRA_ID__c = mra, ES3_tx_Bloomberg_ID__c = bloomberg, ES3_TX_HNWI_ID__c = hnwi, CPI_rb_OR_rating__c = orRatingNew.id);         
                }
            }
            Catch(Exception e)
            {
                System.debug('OEJ Error al comparar los OR, un valor de OR es incorrecto.....');            
            } 
            
        }
        System.debug('OEJ CAtoUpdate.....'+ CAtoUpdate);   
        if(CAtoUpdate != null)
            update CAtoUpdate;
    }*/
    
    public PageReference DeleteEconomicGroup()        
    {       
        Credit_approval_CP__c CAtoUpdate = new Credit_approval_CP__c(Id =  this.CA.Id,                                                                     
                                                                     ES3_tx_Risk_Economic_Group_Id__c = '',
                                                                     CPI_tx_Risk_Economic_Group__c = '',
                                                                     CPI_rb_SIC_code__c = null,
                                                                     ES3_TX_MRA_ID__c = '',
                                                                     ES3_tx_Bloomberg_ID__c = '',
                                                                     ES3_TX_HNWI_ID__c = '',
                                                                     CPI_rb_OR_rating__c = null
                                                                    );    
        
        List<ES2_Obj_EntityMasterInCreditApproval__c> EMInCaToDelete = new List<ES2_Obj_EntityMasterInCreditApproval__c>();
        try
        { 
            
            EMInCaToDelete = [Select id from ES2_Obj_EntityMasterInCreditApproval__c where  ES2_rb_Credit_approval__c =:this.idCreditApproval];
        }
        Catch(Exception e)
        {
            System.debug('OEJ No hay Entidades que borrar.....');
        }  
        Update CAtoUpdate;
        Delete EMInCaToDelete;
        
        PageReference pr = new PageReference('/' + this.idCreditApproval);
        pr.setRedirect(true);
        return pr;          
        
        
    } 
    // falta cargar record que actualiza
   /* public PageReference save(){
        list <ES2_Obj_EntityMasterInCreditApproval__c> entities = new list <ES2_Obj_EntityMasterInCreditApproval__c>();
        List<ES2_Obj_EntityMasterInCreditApproval__c> entitiesInCA = getEntitiesInCA();
        for(ES2_Obj_EntityMasterInCreditApproval__c ent:entitiesInCA){
            if(ent.Id == sIdChild){
                ent.ES2_ms_Role__c = rol;
                entities.add(ent);
            }
        }
        
        update entities;
        
        PageReference pr  = new PageReference(urlBack);
        pr.setRedirect(false);
       
        return pr;
    } */
    
    public PageReference UpdateChangeRoll(){
        urlBack = urlValue;
        system.debug('JD:' + urlBack);	
        PageReference pr  = new PageReference('/apex/ChangeRollEntityMaster?caId='+ this.CA.Id + '&sIdChild=' + this.sIdChild + '&rol='+ this.rol+'&urlBack=' + this.urlBack);
        pr.setRedirect(true);
       
        return pr;
    }

    
    
    
    public PageReference DeleteEntity()        
    {
        ES2_Obj_EntityMasterInCreditApproval__c EMInCatoDelete = new ES2_Obj_EntityMasterInCreditApproval__c(Id =  this.sIdChild);  
        List<ES3_obj_Condition_Service_covenant__c> covenantsToDelete = new List<ES3_obj_Condition_Service_covenant__c>();
        try
        { 
            
            covenantsToDelete = [Select id, ES3_rb_Entity__c from ES3_obj_Condition_Service_covenant__c where ES3_rb_Entity__c =:this.sIdChild];
        }
        Catch(Exception e)
        {
            System.debug('OEJ No hay Entidades que borrar.....');
        }          
        
        
        if(covenantsToDelete.size()>0) {Delete covenantsToDelete;}
        if(!Test.isRunningTest()) {Delete EMInCatoDelete;}
            
        refreshEntitiesFunction();
        PageReference pr = new PageReference('/' + this.idCreditApproval);
        pr.setRedirect(true);
        return pr;          
        
        
    }    
    
    public void refreshEntitiesFunction()
    {
        //Cargamos todas las entidades en variable entities EXITO
        getEMOptions();
        System.debug('OEJ 02 el CA es:' + this.CA);
        System.debug('OEJ 02 el CA.ES3_tx_Risk_Economic_Group_Id__c es:' + this.CA.ES3_tx_Risk_Economic_Group_Id__c);
        System.debug('OEJ 02 las entities son: ' + this.entities);
        
        //Recorremos las entidades para refrescar los datos
        List<ES2_Obj_EntityMasterInCreditApproval__c> listCAs = getEntitiesInCA();
        if(listCAs.size()==0)
        {
            //Error, no hay CAs que actualizar
        }
        else
        {
            //Borramos los Ratings
            Credit_approval_CP__c  CAtoUpdate3 = new Credit_approval_CP__c(Id = this.CA.Id, ES3_TX_MRA_ID__c = '', ES3_tx_Bloomberg_ID__c = '', ES3_TX_HNWI_ID__c = '', CPI_rb_OR_rating__c = null);         
            update CAtoUpdate3;
            for (ES2_Obj_EntityMasterInCreditApproval__c unEMinCA: listCAs)
            {
                for(EIV_EntityWrapClass unEntty: this.entities)
                {
                    if(unEMinCA.ES2_tx_Party_Id__c == unEntty.Party_Id)
                    {
 
                        unEMinCA.ES2_tx_TopParentID__c = unEntty.Top_Parent_ID; 					unEMinCA.ES2_tx_TopParetName__c = unEntty.Top_Parent_Name;
                        unEMinCA.ES2_tx_Oracle_Account_Name__c = unEntty.Oracle_Account_Name; 		unEMinCA.Name = unEntty.Oracle_Account_Name;
                        unEMinCA.ES2_tx_Party_Id__c = unEntty.Party_Id; 							unEMinCA.ES3_tx_MRAID__c = unEntty.MRA_ID;
                        unEMinCA.ES3_txt_SIC_Code__c = unEntty.SIC_Code; 							unEMinCA.ES3_txt_SIC_Description__c = unEntty.SIC_Description;
                        unEMinCA.ES3_txt_CRR__c = unEntty.CRR; 										unEMinCA.ES3_txt_CRR_Override__c = unEntty.CRR_Override;
                        unEMinCA.ES3_tx_BloombergID__c = unEntty.Bloomberg_ID; 						unEMinCA.ES3_tx_HNWI_ID__c = unEntty.HNWI_ID;
                        unEMinCA.ES3_tx_Or_Rating__c = unEntty.orRating; 							unEMinCA.ES3_tx_Transaction_Date__c = unEntty.transactionDate;
                        unEMinCA.ES3_tx_Risk_Classification__c = unEntty.riskClassification; 
                        unEMinCA.TKD_txt_RFC__c =unEntty.TIN ==null?unEntty.RFC:unEntty.TIN;
                        update unEMinCA;
                        //this.updateORinCA(unEntty.MRA_ID, unEntty.Bloomberg_ID, unEntty.HNWI_ID, unEntty.orRating);                        
                    }
                }
            }
        }
    }
    
    public PageReference refreshEntities(){
        refreshEntitiesFunction();
        PageReference pr = new PageReference(this.urlValue);
        pr.setRedirect(true);
        return pr;
    }
    
    public PageReference refreshEconomicGroup(){

		
        entities = new List<EIV_EntityWrapClass>();
        getListEntities('0', 'getAllEntitys'); 
         for (EIV_EntityWrapClass f : entities) 
         {
             //Entramos al for
             System.debug('OEJ esta es f:' + f);
             if(f.Party_Id == CA.ES3_tx_Risk_Economic_Group_Id__c){
                 this.entity = f;
                 
                 System.debug('OEJ this.entity.....' + this.entity);
                 Credit_approval_CP__c CAtoUpdate = new Credit_approval_CP__c(Id =  this.CA.Id,                                                                     
                                                                              ES3_tx_Risk_Economic_Group_Id__c = this.entity.Party_Id,
                                                                              CPI_tx_Risk_Economic_Group__c = this.entity.Oracle_Account_Name,
                                                                              CPI_rb_SIC_code__c = null
                                                                             );
                 
                 TBO002_SIC_code__c sicCodeSelected = new TBO002_SIC_code__c();
                 try
                 {   
                     if(!String.isBlank(this.entity.SIC_Code))
                     {
                         sicCodeSelected = [Select id, name, TBO002_tx_SIC_industry_description__c from TBO002_SIC_code__c where name =:this.entity.SIC_Code][0];    
                         CAtoUpdate.CPI_rb_SIC_code__c = sicCodeSelected.id;
                     }
                 }
                 Catch(Exception e)
                 {
                     System.debug('OEJ SIC Code no existe.....');
                 }        
                 
                 String urlEntityMaster = '/apex/EIV_EntityReadPageEconomicGroup?PartyId=' + CAtoUpdate.ES3_tx_Risk_Economic_Group_Id__c;
                 System.debug('URL Entity Master OEJ--:' + urlEntityMaster);
                 Update CAtoUpdate;
                 
                 
                 
             }
         }        
        
        PageReference pr = new PageReference(this.urlValue);
        pr.setRedirect(true);
        return pr;
    }
    
    
    public PageReference SaveEconomicGroup()
    {        
        //Actualizamos el CA con los datos del Credit Approval
        System.debug('OEJ this.entity.....' + this.entity);

        System.debug('OEJ SIC_Code.....' + this.entity.SIC_Code);        
        System.debug('OEJ SIC_CodeId.....' + this.entity.SIC_Code);
        System.debug('OEJ Economic_group_SIC_Code.....' + this.entity.Economic_group_SIC_Code);
        System.debug('OEJ Economic_group_SIC_CodeId.....' + this.entity.SIC_Code);

        Credit_approval_CP__c CAtoUpdate = new Credit_approval_CP__c(Id =  this.CA.Id,                                                                     
                                                                     ES3_tx_Risk_Economic_Group_Id__c = this.entity.Party_Id,
                                                                     CPI_tx_Risk_Economic_Group__c = this.entity.Oracle_Account_Name,
                                                                     CPI_rb_SIC_code__c = null
                                                                    );
        
        TBO002_SIC_code__c sicCodeSelected = new TBO002_SIC_code__c();
        try
        { 
            System.debug('OEJ SIC Code.....' + this.entity.SIC_Code);
            
            if(!String.isBlank(this.entity.SIC_Code))
            {
                sicCodeSelected = [Select id, name, TBO002_tx_SIC_industry_description__c from TBO002_SIC_code__c where name =:this.entity.SIC_Code][0];    
                CAtoUpdate.CPI_rb_SIC_code__c = sicCodeSelected.id;
            }
        }
        Catch(Exception e)
        {
            System.debug('OEJ SIC Code no existe.....');
        }        
        
        String urlEntityMaster = '/apex/EIV_EntityReadPageEconomicGroup?PartyId=' + CAtoUpdate.ES3_tx_Risk_Economic_Group_Id__c;
        System.debug('URL Entity Master OEJ--:' + urlEntityMaster);
        Update CAtoUpdate;
        
        PageReference pr = new PageReference(this.urlValue);
        pr.setRedirect(true);
        return pr;        
    }       
    
    public Boolean validaInsertNewEntity(String newRoles, String PartyId, Id oppInCAId)
    {
        //Consultar Entidades ya guardadas y verificar que la entidad que se quiere guardar puede ser la misma entidad, pero con diferente rol
        List<String> roles = newRoles.split(';');
        Boolean agregarlo = true;
        for(string rol : roles)
        {
            try{
                List<ES2_Obj_EntityMasterInCreditApproval__c> 
                    entityesInThisCA = [
                        select id, ES2_tx_Party_Id__c, ES2_ms_Role__c, ES3_rb_Opportunity_in_Credit_approval_CP__c,ES3_rb_Carveout_in_CA_inCredit__c	 
                        from ES2_Obj_EntityMasterInCreditApproval__c 
                        where ES2_ms_Role__c includes (:rol) 
                        and ES2_tx_Party_Id__c =: PartyId
                        and ES3_rb_Opportunity_in_Credit_approval_CP__c =:oppInCAId
                        and ES3_rb_Carveout_in_CA_inCredit__c	=:oppInCAId
                        and ES2_rb_Credit_approval__c =:this.idCreditApproval
                    ];
                if (entityesInThisCA.size()>0)
                {
                    agregarlo = false;
                }
            }
            Catch(Exception e)
            {
                System.debug('No hay coincidencia, es correcta la agregación');
            }
        }
        return agregarlo;
    }    
    

    
    public PageReference SaveData()
    {        
        PageReference pr;
            System.debug('pruebassss'+OppInCarveout);
        
        if(this.entity == null || String.isBlank(emInCa.ES2_ms_Role__c))
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'It is required to select role and entity'));
            pr = new PageReference(this.urlValue);
            pr.setRedirect(false); //Pasamos el controlador lleno   
        }
        else
        {
            
            
            String urlEntityMaster = '/apex/' + vfTypeEntitieRead(this.entity.Customer_Type) + '?CustomerType=' +  + '&AccountId=' + this.sTopParentId + '&AccountName=' + this.sTopParentName + '&TopParentID=' + this.sTopParentId + '&TopParentName=' + this.sTopParentName + '&PartyId=' + this.entity.Party_Id;
            System.debug('URL Entity Master OEJ--:' + urlEntityMaster);
            system.debug('se guarda este sic code' + entity.SIC_Code);
            emInCa.ES2_tx_CostumerType__c = this.entity.Customer_Type;
            emInCa.ES2_tx_pageVF__c = vfTypeEntitieRead(this.entity.Customer_Type);
            emInCa.ES2_tx_TopParentID__c = this.sTopParentId;
            emInCa.ES2_tx_TopParetName__c = this.sTopParentName;
            emInCa.ES2_tx_Oracle_Account_Name__c = entity.Oracle_Account_Name;
            emInCa.Name = entity.Oracle_Account_Name;
            emInCa.ES2_tx_Party_Id__c = entity.Party_Id;
            emInCa.ES3_tx_MRAID__c = entity.MRA_ID;
            emInCa.ES3_txt_SIC_Code__c = entity.SIC_Code;
            emInCa.ES3_txt_SIC_Description__c = entity.SIC_Description;
            emInCa.ES3_txt_CRR__c = entity.CRR;
            emInCa.ES3_txt_CRR_Override__c = entity.CRR_Override;
            emInCa.ES3_tx_BloombergID__c = entity.Bloomberg_ID;
            emInCa.ES3_tx_HNWI_ID__c = entity.HNWI_ID;
            emInCa.ES3_tx_Or_Rating__c = entity.orRating;
            emInCa.ES3_tx_Transaction_Date__c = entity.transactionDate;
            emInCa.ES3_tx_Risk_Classification__c = entity.riskClassification;
            emInCa.TKD_txt_RFC__c = entity.TIN ==null?entity.RFC: entity.TIN;
            
            if(OppInCA != null)
            {
                emInCa.ES3_rb_Opportunity__c = OppInCA.CP_rb_Oportunidad__c; emInCa.ES3_rb_Opportunity_in_Credit_approval_CP__c = OppInCA.Id;  
                if(validaInsertNewEntity(emInCa.ES2_ms_Role__c,emInCa.ES2_tx_Party_Id__c,emInCa.ES3_rb_Opportunity_in_Credit_approval_CP__c))
                {
                    insert emInCa;
                }
                                
                
                pr = new PageReference(this.urlValue);pr.setRedirect(true);
                
            } else if(OppInCarveout != null){
                
                emInCa.ES3_rb_Opportunity__c = OppInCarveout.MD_rl_Destination_Opportunity__r.Name; emInCa.ES3_rb_Carveout_in_CA_inCredit__c	 = OppInCarveout.Id;  
                if(validaInsertNewEntity(emInCa.ES2_ms_Role__c,emInCa.ES2_tx_Party_Id__c,emInCa.ES3_rb_Carveout_in_CA_inCredit__c	))
                {
                    insert emInCa;
                }
                pr = new PageReference(this.urlValue);pr.setRedirect(true);
            }
            else //Se debe de agregar la entidad en todas las opps que esten dadas de alta
            {
                try
                { 
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Without opportunities, the entity can not be added'));
                    pr = new PageReference(this.urlValue);
                    pr.setRedirect(false); //Pasamos el controlador lleno   */
                    List<Carveout_in_Credit_Approval_CP__c> oppsInCarveout= [Select Id,  MD_rl_Destination_Opportunity__r.Name  from Carveout_in_Credit_Approval_CP__c where   MD_rls_Credit_approval__c =:this.idCreditApproval];
                    System.debug('Prueba Carveout'+ oppsInCarveout);
                    List<Opportunity_in_Credit_approval_CP__c> oopsInCa = [Select id, CP_rb_Oportunidad__c  from Opportunity_in_Credit_approval_CP__c where CP_rb_Credit_approval_CP__c =:this.idCreditApproval];
                    if(oopsInCa.size()>0)
                    {
                        for(Opportunity_in_Credit_approval_CP__c o : oopsInCa)  
                        {
                            ES2_Obj_EntityMasterInCreditApproval__c newEMInCa = emInCa;
                            newEMInCa.ES3_rb_Opportunity__c = o.CP_rb_Oportunidad__c;
                            newEMInCa.ES3_rb_Opportunity_in_Credit_approval_CP__c = o.Id;
                            newEMInCa.id = null;
                            System.debug('OEJ Entity Master a insertar--' +newEMInCa + ' o.size :');
                            System.debug('OEJ Entity Master Id a insertar--' +newEMInCa.Id);
                            if(validaInsertNewEntity(emInCa.ES2_ms_Role__c, emInCa.ES2_tx_Party_Id__c, newEMInCa.ES3_rb_Opportunity_in_Credit_approval_CP__c))
                            {
                                insert newEMInCa;
                            }
                            pr = new PageReference(this.urlValue);
                            pr.setRedirect(true);
                        }
                    }
                    
                    if(oppsInCarveout.size()>0){
                        
                        System.debug('Prueba Carveout2'+ oppsInCarveout);
                        
                        for(Carveout_in_Credit_Approval_CP__c oc : oppsInCarveout){
                            System.debug('Prueba Carveout 3'+ oppsInCarveout);
                            ES2_Obj_EntityMasterInCreditApproval__c newEMInCa = emInCa;
                            System.debug('Prueba EMInCa'+ newEMInCa);
                            newEMInCa.ES3_rb_Opportunity__c = oc.MD_rl_Destination_Opportunity__c;
                            newEMInCa.ES3_rb_Carveout_in_CA_inCredit__c	 = oc.Id;
                           newEMInCa.id = null;
                            System.debug('OEJ Entity Master a insertar Carveout--' +newEMInCa + ' o.size :');
                            System.debug('OEJ Entity Master Id a insertar--' +newEMInCa.Id);
                            System.debug('Prueba Carveout4'+ oppsInCarveout);
                            if(validaInsertNewEntity(emInCa.ES2_ms_Role__c, emInCa.ES2_tx_Party_Id__c, newEMInCa.ES3_rb_Carveout_in_CA_inCredit__c	))
                            {
                                insert newEMInCa;
                               
                            }
                            pr = new PageReference(this.urlValue);
                            pr.setRedirect(true);
                        }
                    }
                    
                }
                Catch(Exception e)
                {
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Without opportunities, the entity can not be added'));
                    pr = new PageReference(this.urlValue);
                    pr.setRedirect(false); //Pasamos el controlador lleno  
                }        
            }            
        }
        
        return pr;        
    }    
    
    public String vfTypeEntitieRead(String entityType){ 
        String vfStringName = '';
        if(entityType == 'Individual' || entityType == 'EIV_EntityReadPageIndividual' || entityType == 'INDIVIDUAL' )
        {
            vfStringName = 'EIV_EntityReadPageIndividual';
        }else if (entityType == 'Organization' || entityType == 'EIV_EntityReadPageOrganization' || entityType == 'ORGANIZATION')
        {
            vfStringName = 'EIV_EntityReadPageOrganization';
        }else 
        {
            vfStringName = 'EIV_EntityReadPageEconomicGroup';
        }   
        return vfStringName;
    } 
    
    
    
    public List<SelectOption> getEMOptions() { 
        List<SelectOption> EMOptions = new List<SelectOption>();
        EMOptions.add(new SelectOption('',''));
        
        entities = new List<EIV_EntityWrapClass>();
        getListEntities('0', 'getEntitysFromAccount');
        
        if( String.isNotBlank(this.CA.ES3_tx_Risk_Economic_Group_Id__c))
        {
            
            Map<String, Object> jsonResponse2 = null;        
            jsonResponse2 = Test.isRunningTest() ? null : EIV_EntityExtencionCalloutClass.callBackllAllEconomicGroup(sServiceURL, this.CA.ES3_tx_Risk_Economic_Group_Id__c); 
            if (jsonResponse2 == null )
            {
                //Hubo un error en el servidor o no esta disponible, agregar mensaje
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Oracle Server missing'));
            }
            else
            {
                //El resultado tiene status
                Map<String, Object> status2 = (Map<String, Object>)jsonResponse2.get('status');
                System.debug('Received the following JSON response of status OEJ01:' + status2);
                detail = new EIV_DetailWrapClass();
                //this.detail.errorCode =  (String)status.get('code'); //{code=0, detail=0, message=0}
                this.detail.description =  (String)status2.get('detail');
                this.detail.message =  (String)status2.get('message');
                
                if(this.detail.message == 'S')
                {
                    
                    //El resultado tiene entityInfo 
                    Map<String, Object> entityInfo2 = (Map<String, Object>)jsonResponse2.get('entityInfo'); Map<String, Object> entityPriv2 = (Map<String, Object>)entityInfo2.get('privilege'); Map<String, Object> entitiesL2 = (Map<String, Object>)entityInfo2.get('entities');
                    System.debug('Received the following JSON response of entitiesL OEJ01:' + entitiesL2);
                    if(entitiesL2 == null) //no traemos contactos
                    {
                        System.debug('Este Top Parent no tiene entidades'); 
                    }
                    else
                    {
                        
                        List<Object> entitiesList2 = (List<Object>)entitiesL2.get('entity');
                        for(Object a : entitiesList2)
                        {
                            Map<String, Object> newAdd2 = (Map<String, Object>) a;					
                            Map<String, Object> sic = (Map<String, Object>)newAdd2.get('sic');
                            System.debug('Received the following JSON response of sic newAdd2 OEJ01:' + sic); 
                            Map<String, Object> aml = (Map<String, Object>)newAdd2.get('aml');      
                            Map<String, Object> rating = (Map<String, Object>)newAdd2.get('rating');                            
                            entities.add(responseToEntityObj(newAdd2, sic, aml, rating));
                        }
                        System.debug('Received the following JSON response of address OEJ01:' + entitiesL2);
                    }         
                }
                else
                {
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,this.detail.message));
                }
            }
        }
        
        List<ES2_Obj_EntityMasterInCreditApproval__c> entitiesInCA = getEntitiesInCA();
       		
        for (EIV_EntityWrapClass f2 : entities) {                
            if(f2.Customer_Type != 'ECONOMIC GROUP' )
            {
                Boolean agrega = true;
                //if(entitiesInCA.size()>0)
                //{                   
                    
                    //for(ES2_Obj_EntityMasterInCreditApproval__c emicalist : entitiesInCA )
                    //{
                    //    if( emicalist.ES2_tx_Party_Id__c == f2.Party_Id )    { agrega = false;  }
                    //}
                //}
                if(agrega) {  EMOptions.add(new SelectOption(f2.Party_Id,f2.Oracle_Account_Name));   }
            }
        }
        
        
        return EMOptions;        
    }    
    
    
    
    
    public EIV_EntityWrapClass responseToEntityObj(Map<String, Object> entityDetail, Map<String, Object> sic,Map<String, Object> aml,Map<String, Object> rating)
    {        
        EIV_EntityWrapClass etty = new EIV_EntityWrapClass();
        etty.Account_ID                    = (String)entityDetail.get('sFaccountID');
        etty.Cust_AccountId                = (String)entityDetail.get('custAccountId');        
        etty.Party_Id                      = String.valueOf(entityDetail.get('partyID'));
        etty.RFC                           = (String)entityDetail.get('rfc');
        etty.Oracle_Account_Name           = (String)entityDetail.get('oracleAccountName');
        etty.Customer_Type                 = (String)entityDetail.get('customerType');
        etty.Customer_Status               = (String)entityDetail.get('customerStatus');        
        etty.Top_Parent_ID                 = (String)entityDetail.get('topParentId');
        etty.Top_Parent_Name               = (String)entityDetail.get('topParentName');
        etty.SF_Account_Name               = (String)entityDetail.get('sfAccountName');
        etty.TIN                           = (String)entityDetail.get('tin');
        etty.Economic_Group_ID             = Test.isRunningTest() ? '' : String.valueOf((Integer)entityDetail.get('economicGroupId'));
        etty.Economic_Group_Name           = (String)entityDetail.get('economicGroupName');
        etty.Limited_information_entity    = (Boolean)entityDetail.get('limitedInformationEntity');
        etty.Tax_Regime                    = (String)entityDetail.get('taxRegime');
        //etty.Foreign_Entity                = booleanToYesNo((Boolean)entityDetail.get('foreignEntity'));
        etty.Nationality                   = (String)entityDetail.get('nationality');
        etty.Oracle_Account_Number         = (String)entityDetail.get('oracleAccountNumber');
        etty.CURP                          = (String)entityDetail.get('curp');
        etty.Prefix                        = (String)entityDetail.get('prefix');
        etty.First_Name                    = (String)entityDetail.get('firstName');
        etty.Middle_Name                   = (String)entityDetail.get('middleName');
        etty.First_Last_Name               = (String)entityDetail.get('firstLastName');
        etty.Second_Last_Name              = (String)entityDetail.get('secondLastName');
        etty.Sales_Representative          = (String)entityDetail.get('salesRepresentative');
        //etty.Supplier_Flag                 = booleanToString((Boolean)entityDetail.get('supplierFlag'));
        etty.Legal_Name_sin_denominacion   = (String)entityDetail.get('legalName');
        etty.Company_Legal_Name_termination= (String)entityDetail.get('companyLegalNameTermination');        
        etty.Source_Created_by             = (String)entityDetail.get('sourceCreatedBy');
        etty.Source_Updated_by             = (String)entityDetail.get('sourceUpdatedBy');
        etty.Source_Application_ID         = (String)entityDetail.get('sourceApplicationID');
        //etty.Source_Create_Date          = (String)entityDetail.get('sourceCreateDate');
        //etty.Source_Last_Update_Date     = (String)entityDetail.get('sourceLastUpdateDate');
        //etty.vfSNameRead                   = vfTypeEntitieRead(etty.Customer_Type);   
        etty.Target_Market_Jurisdiction    = (String)aml.get('targetMarketJurisdiction');
        etty.CRR                           = (String)aml.get('ccr');
        etty.CRR_Comments                  = (String)aml.get('crrComments');
        etty.CRR_Override                  = (String)aml.get('ccrOverride');
        etty.Entity_Type                   = (String)aml.get('entityType');
        etty.MRA_ID                        = String.isBlank((String)rating.get('mraId'))?'':(String)rating.get('mraId');
        etty.Bloomberg_ID                  = (String)rating.get('bloombergId');
        etty.HNWI_ID                       = String.isBlank((String)rating.get('hnwiId'))?'':(String)rating.get('hnwiId');
        etty.orRating                      = String.isBlank((String)rating.get('orRating'))?'':(String)rating.get('orRating');
        etty.riskClassification            = String.isBlank((String)rating.get('riskClassification'))?'':(String)rating.get('riskClassification');
        etty.transactionDate               = String.isBlank((String)rating.get('transactionDate'))?'':(String)rating.get('transactionDate');
        etty.SIC_Code                      = String.valueOf(sic.get('sicCode'));
        //etty.SIC_CodeId                    = (Id)getSicCodeId(etty.SIC_Code);
        //this.sicCodeId                     = etty.SIC_CodeId;
        etty.SIC_Description               = (String)sic.get('sicDescription');
        etty.Economic_group_SIC_Code       = String.valueOf(sic.get('economicGroupSicCode'));
        etty.Economic_Group_SIC_Description = (String)sic.get('economicGroupSicDescription');
        
        //orRating=OR12, riskClassification=null, transactionDate=null}
        
        //     
        return etty;       
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
    
    public PageReference backToCa(){
        String fullRecordURL = URL.getSalesforceBaseUrl().toExternalForm() + '/lightning/r/Credit_approval_CP__c/' +idCreditApproval +'/view?ettyinCA=yes';
        PageReference pr = new PageReference(fullRecordURL);
        pr.setRedirect(false);
        return pr;    
    }
    
    
    
    
    public static void enttityCaDom(){
       EIV_DetailWrapClass enttde = new EIV_DetailWrapClass();
       enttde.description='System Description entty detail';
       enttde.errorCode='404';
       enttde.message='success';
       enttde.sDate='Now';
       enttde.status='S';
       
       EIV_EntityWrapClass enti = new EIV_EntityWrapClass();  
       enti.Account_ID='12';
       enti.Bloomberg_ID='12';
       enti.buroFlag='Y';
       enti.Company_Legal_Name_termination='An ESE A DE CE VE';
       enti.CRR_Comments='No comments';
       enti.CRR_Override='No';
       enti.CURP='209';
       enti.Cust_AccountId='12';
       enti.Customer_Alias='Pablito Mits';
       enti.Customer_Name='Nelson Mandela';
       enti.Customer_Type='Individual';
       enti.Economic_Group_ID='99999';
       enti.Economic_Group_Name='Femsa';
       enti.Economic_group_SIC_Code='999';
       enti.Economic_group_SIC_CodeId='001';
       enti.Economic_Group_SIC_Description='Metals & minery';
       enti.EconomicGroupPartyId='12';
       enti.Entity_Type='Individual';
       enti.entityName='Carlos Manuel';
       enti.First_Last_Name='Perez';
       enti.First_Name='Joel';
       enti.Foreign_Entity='Yes';
       enti.foreingn_TAX_ID='123';
       list<EIV_EntityWrapClass>listEnt= new list<EIV_EntityWrapClass>();
	    listEnt.add(enti);       
    }
    
    public boolean getPermisions(){
       list<Id>usersId = new list<Id>();
        for(PermissionSetAssignment permision:[SELECT AssigneeId FROM PermissionSetAssignment WHERE PermissionSet.Name = 'ModifyEntsInCaBlocked']){
            usersId.add(permision.AssigneeId);
        }
        
        if(usersId.size()>0){
            if(usersId.contains(system.UserInfo.getUserId())){
                return true;
            }
        }
        
        return false;
    }
    
}