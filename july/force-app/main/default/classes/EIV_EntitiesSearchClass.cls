public class EIV_EntitiesSearchClass {
    
    //Entidades buscadas por parametros, y variables para la busqueda
    public List<EIV_EntityWrapClass> entities         {get;set;}
    public string searchString                        {get;set;}
    public string searchRequestId                     {get;set;}
    public string searchRootRequestId                 {get;set;}
    public string searchRequestType                   {get;set;}
    public string searchSourceAccountId               {get;set;}
    public string searchSourceAccountName             {get;set;}
    public string searchSourceTopParentId             {get;set;}
    public string searchSourceTopParentName           {get;set;}
    public string searchPartyId                       {get;set;}
    public string searchPartyName                     {get;set;}
    public string searchEgPartyId                     {get;set;}
    public string searchEgPartyName                   {get;set;}
    public string searchSourceOpId                    {get;set;}
    public string searchSourceCAId                    {get;set;}
    public string searchStartDate                     {get;set;}
    public string searchEndDate                       {get;set;}
    public string searchRequestStatus                 {get;set;}
    public string searchCreatedBy                     {get;set;}
    public string searchRequestedBy                   {get;set;}
    public string searchAssignedGroup                 {get;set;}
    public string searchAssignedTo                    {get;set;}
    public string searchAssignedDate                  {get;set;}
    public string searchCreationDate                  {get;set;}
    public string searchUpdatedBy                     {get;set;}
    public string searchLastUpdateDate                {get;set;}
    public string searchSolvedBy                      {get;set;}
    public string searchSolvedDate                    {get;set;}
    public string searchSourceApplication             {get;set;}
    public string searchFinantialEntity               {get;set;}
    public string searchNameAssignedTo                {get;set;}
    
    //Lista de Requests
    public List<ES2_WraperRequest> requestList        {get;set;}
    public List<ES2_WraperRequest> documentList       {get;set;}
    public List<ES2_WraperRequest> comentList         {get;set;}     
    
    //Detalle de la respuesta
    public EIV_DetailWrapClass detail                 {get;set;}
    
    //Id de la entidad seleccionada y variables de la cuenta
    public String sAccountId                              {get;set;}
    public String sAccountName                            {get;set;}
    public String sTopParentId                            {get;set;}
    public String sTopParentName                          {get;set;}
    public String sSSO                                    {get;set;}
    public String sServiceURL                             {get;set;}
    
    //Variables para mostrar la busqueda
    public Boolean searchEntity                           {get;set;}
    
    
    //Constructor, cuando se carga la pagina se cargan los valores
    //
    public EIV_EntitiesSearchClass(ApexPages.StandardController stdController) {
    }
    
    
    public EIV_EntitiesSearchClass() {
        //Traemos los parametros de la pagina, por el momento dummy, si esta vacio mostramos la pantalla de busqueda
        this.sAccountId =  (String)System.currentPageReference().getParameters().get('AccountId');
        this.sAccountName =  (String)System.currentPageReference().getParameters().get('AccountName');
        this.sTopParentId =  (String)System.currentPageReference().getParameters().get('TopParentID');
        this.sTopParentName =  (String)System.currentPageReference().getParameters().get('TopParentName');
        this.searchEntity = true;
        this.sServiceURL = [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='URL_Servicio'][0].EIV_tx_parameter__c; 
        this.sSSO = [Select EmployeeNumber From User Where Id = :UserInfo.getUserId()][0].EmployeeNumber;  
        System.debug('Este es el Account OEJ--' + this.sAccountId ); 
        
        if (this.sAccountId == null )
        {
            System.debug('Esta vacio, es busqueda General OEJ--' + this.sAccountId ); 
            
        }
        else
        {
            System.debug('Esta lleno, es busqueda sobre una cuenta Salesforce--' + this.sAccountId);   
            this.searchEntity = false;
            if (this.sTopParentId == null || String.isBlank(this.sTopParentId) )
            {
                this.sTopParentId = this.sAccountId;
                this.sTopParentName = this.sAccountName;
                System.debug('Este es un TOP PARENT, ponemos el mismo dato de topparent = cuenta--' + this.sTopParentId);
            }
            else
            {
                this.sAccountId = this.sTopParentId;
                this.sAccountName = this.sTopParentName;
                System.debug('Este NO es un TOP PARENT, ponemos el mismo dato de cuenta = topparent --' + this.sTopParentId);
                
            }
                 
            getListEntities(this.sTopParentId, 'getEntitysFromAccount');
            //searchEntityDummy();  
        }
        
    }
    public void searchEntity()
    {
        getListEntities(this.searchString, 'getEntitySearch');
        //searchEntityDummy();
    }  
    
    public String nulltoVoidEncode(String dato)
    {
        if(String.isBlank(dato))
            return '';
        else
            return EncodingUtil.urlEncode( dato,'UTF-8');
    }
    
    public void searchRequest()
    {
        requestList = new List<ES2_WraperRequest>();
        //getdummyRequest();
        Map<string,object>jsonResponse =null;
        jsonResponse = EIV_EntityExtencionCalloutClass.callBackGetRequestDetails(this.sSSO, 'SF', this.sServiceURL, nulltoVoidEncode(searchAssignedGroup), 
                      nulltoVoidEncode( searchRequestType), nulltoVoidEncode(searchAssignedTo), nulltoVoidEncode(searchNameAssignedTo), nulltoVoidEncode(searchRequestStatus), nulltoVoidEncode(searchStartDate), nulltoVoidEncode(searchEndDate), nulltoVoidEncode(searchRequestedBy), 
                       nulltoVoidEncode(searchPartyName), nulltoVoidEncode(searchSourceTopParentName), nulltoVoidEncode(searchSourceAccountName), nulltoVoidEncode(searchEgPartyName), nulltoVoidEncode(searchRequestId), sSSO);
            //('999999', 'SF', 'http://160.34.7.97:7033', '', '', '', '', '', '', searchRequestedBy, '', '', '');
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
    
    
    public void getListEntities(String TopParentIdSeleccionado, String servicio)
    {
        //Se carga en el controlador el TopParent, se coloca en el AcountId del que se van a buscar las entidades 
        ////AccountId=0015B00000SUIBD&AccountName=Una+Prueba&TopParentID=&TopParentName=&PartyId=, Method=GET]
        //Enviaremos
        //PartyId, pasado pro la URL
        //SSO obtenido de consulta de EmployeeNumber
        //Aplication code, que sera siempre SF
        Map<String, Object> jsonResponse = null;
        entities = new List<EIV_EntityWrapClass>(); 
        if(servicio == 'getEntitysFromAccount')
            jsonResponse = EIV_EntityExtencionCalloutClass.callBackEntitiesOfTopParent(this.sTopParentId,sSSO,this.sServiceURL);
        if(servicio == 'getEntitySearch')
            jsonResponse = EIV_EntityExtencionCalloutClass.callBackEntitiesSearch(TopParentIdSeleccionado,sSSO,this.sServiceURL);
        if (jsonResponse == null)
        {
             //Hubo un error en el servidor o no esta disponible, agregar mensaje
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Oracle Server missing'));
        }
        else
        {
            //El resultado tiene status
            Map<String, Object> status = (Map<String, Object>)jsonResponse.get('status');
            System.debug('Received the following JSON response of status OEJ01:' + status);
            detail = new EIV_DetailWrapClass();
            //this.detail.errorCode =  (String)status.get('code'); //{code=0, detail=0, message=0}
            this.detail.description =  (String)status.get('detail');
            this.detail.message =  (String)status.get('message');
            
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
                        entities.add(responseToEntityObj(newAdd));
                        
                    }

                    System.debug('Received the following JSON response of address OEJ01:' + entitiesL);
 
                }         
                
                
            }
            else
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,this.detail.description));
            }
            
            
        }
        
    }    
    
    public string booleanToString(Boolean bbool)
    {
        
        if(bbool!=null &&  bbool)
            return 'true';
        else
            return 'false';            
    } 
    
    public EIV_EntityWrapClass responseToEntityObj(Map<String, Object> entityDetail)
    {
        
        EIV_EntityWrapClass etty = new EIV_EntityWrapClass();
        etty.entityName                    = (String)entityDetail.get('entityName');
        etty.Customer_Name                 = (String)entityDetail.get('customerName');
        //etty.Customer_Alias                = (String)buro.get('customerAlias');    
        etty.Customer_Type                 = (String)entityDetail.get('customerType');
        etty.Party_Id                      = String.valueOf(entityDetail.get('partyID'));
        etty.Customer_Status               = (String)entityDetail.get('customerStatus');
        etty.Cust_AccountId                = (String)entityDetail.get('custAccountId');
        etty.Top_Parent_ID                 = (String)entityDetail.get('topParentId');
        etty.Top_Parent_Name               = (String)entityDetail.get('topParentName');
        etty.Account_ID                    = (String)entityDetail.get('sFaccountID');
        etty.SF_Account_Name               = (String)entityDetail.get('sfAccountName');
        etty.RFC                           = (String)entityDetail.get('rfc');
        etty.TIN                           = (String)entityDetail.get('tin');
        etty.Economic_Group_ID             = String.valueOf(entityDetail.get('economicGroupId'));
        etty.Economic_Group_Name           = (String)entityDetail.get('economicGroupName');
        etty.EconomicGroupPartyId          = (String)entityDetail.get('economicGroupPartyId');
        //etty.Limited_information_entity    = booleanToString((Boolean)entityDetail.get('limitedInformationEntity'));
        etty.Tax_Regime                    = (String)entityDetail.get('taxRegime');
        //etty.Foreign_Entity                = booleanToString((Boolean)entityDetail.get('foreignEntity'));
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
        etty.Oracle_Account_Name           = (String)entityDetail.get('oracleAccountName');

        etty.vfSNameRead                   = vfTypeEntitieRead(etty.Customer_Type);

        return etty;       
    }
        

    
    public String vfTypeEntitieRead(String entityType){ 
        String vfStringName = '';
        if(entityType == 'Individual' || entityType == 'EIV_EntityReadPageIndividual' || entityType == 'INDIVIDUAL')
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
    
    public String vfTypeEntitieEdit(String entityType){ 
        String vfStringName = '';
        if(entityType == 'Individual' || entityType == 'EIV_EntityEditPageIndividual' || entityType == 'INDIVIDUAL')
        {
            vfStringName = 'EIV_EntityEditPageIndividual';
        }else if (entityType == 'Organization' || entityType == 'EIV_EntityEditPageOrganization' || entityType == 'ORGANIZATION')
        {
            vfStringName = 'EIV_EntityEditPageOrganization';
        }else 
        {
            vfStringName = 'EIV_EntityEditPageEconomicGroup';
        }   
        return vfStringName;
    } 
}