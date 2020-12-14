/**
 * @File Name          : EIV_EntityExtendClassBis.cls
 * @Description        : 
 * @Author             : eduardo.amiens@outlook.com
 * @Group              : 
 * @Last Modified By   : eduardo.amiens@outlook.com
 * @Last Modified On   : 21/11/2019 22:02:26
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    21/11/2019   eduardo.amiens@outlook.com     Initial Version
**/
public class EIV_EntityExtendClassBis {    
    //Entidades buscadas por parametros, y variables para la busqueda
    public List<EIV_EntityWrapClass> entities         {get;set;}
    public EIV_EntityWrapClass entity                 {get;set;}
    public EIV_PrivilegesWrapClass entityprivileges   {get;set;}    
    
    //Lista de Requests
    public List<ES2_WraperRequest> requestList          {get;set;}
    public List<ES2_WraperRequest> documentList         {get;set;}
    public List<ES2_WraperRequest> comentList           {get;set;} 
    public List<ES2_wraper_documents> wraperDocList     {get;set;} 
    
    //lista de contactos 
    public List<EIV_ContactWrapClass> contactList     {get;set;}
    public EIV_ContactWrapClass contactObj            {get;set;}
    public EIV_PrivilegesWrapClass contactPrivileges  {get;set;}    
    
    //lista de Invoicing 
    public List<EIV_InvoicingWrapClass> invoicingList {get;set;}
    public EIV_InvoicingWrapClass invoicingObj        {get;set;}
    public EIV_PrivilegesWrapClass invoicingPrivileges {get;set;}   
    
    //ista de Address 
    public List<EIV_AddressWrapClass> addressList     {get;set;}
    public EIV_AddressWrapClass        addressObj     {get;set;}
    public EIV_PrivilegesWrapClass addressPrivileges  {get;set;}    
    
    //Detalle de la respuesta
    public EIV_DetailWrapClass detail                 {get;set;}
    
    //SSO del empleado
    String sSSO                                       {get;set;}
    //Id de la entidad seleccionada y variables de la cuenta
    
    public String sAccountId{
        get {
            return sAccountId; 
        }
        set {
            system.debug('original ' + value);
            if(value!=null && value.length() >= 15){
               String s2 = value.substring(0, 15);
            system.debug('valor '+s2);
            this.sAccountId = s2; 
            }else{
                system.debug('valor vacio');
            }
            
        }
    }
    
    public String sAccountName                            {get;set;}
    
    public string sTopParentId {
        get {
            return sTopParentId; 
        }
        set {
            system.debug('original ' + value);
            if(value!=null && value.length() >= 15){
               String s2 = value.substring(0, 15);
            system.debug('valor '+s2);
            this.sTopParentId = s2; 
            }else{
                system.debug('valor vacio');
            }
            
        }
    }
    
    public String sTopParentName                          {get;set;}
    public String sPartyId                                {get;set;}
    public String sCustomerType                           {get;set;}
    public String sTargetMarket                           {get;set;}
    public String sServiceURL                             {get;set;}
    //Variables para childs
    public String sAdressId                               {get;set;}
    public String sContactId                              {get;set;}
    public String sInvoicingId                            {get;set;}
    public String sIdChild                                {get;set { sIdChild = value; System.debug('value sIdChild OEJ: '+value); }}
    public String sIdTypeRequest                          {get;set { sIdTypeRequest = value; System.debug('value sIdTypeRequest OEJ: '+value); }}        
    public String sEconomicGroupIdSelected;
    public String sicCodeId;
    public String postalCodeId;
    
    //para descargar doctos
    public string docId                                 {get;set;}
    public string docUrl                                {get;set;}
    public string cddate                                {get;set;}
    public boolean urlflag                              {get;set;}
    public string backUrl                               {get;set;}
    public list <string> doctypess {get;Set;}
    public string doctiposString {get;set;}
    //para encriptarURl
    public string encodedTextAES                        {get;set;}
    
    public string URLRetorno                            {get;set;}
    
    //Aqui empieza cambio para modificar TopParent SEBAS 'se rifo'
    //public string topParentSelected {get;set;}
    public string topParentSelected;
    
        public String gettopParentSelected() {
        return this.topParentSelected;
    }
    public void settopParentSelected(String topParentSelected) {
        String NameAccount = '';
        try{
            system.debug('topParentSelected ' + topParentSelected);
            system.debug('query ' + [Select name from Account where id =: topParentSelected][0].name);
            NameAccount = [Select name from Account where id =: topParentSelected][0].name;
        }
        Catch(Exception e)
        {
            NameAccount = ' '; 
            System.debug('No existe el ID');
        }
        this.entity.SF_Account_Name = NameAccount;
        this.entity.Top_Parent_Name = NameAccount;
        this.entity.Top_Parent_ID = topParentSelected;
        this.entity.Account_ID = topParentSelected;
        this.sAccountId = topParentSelected;
        this.sAccountName = NameAccount;
        this.topParentSelected = topParentSelected;
        this.sTopParentId = topParentSelected;
        system.debug('this.topParentSelected ' + this.topParentSelected);
        
        //system.debug('Se selecciono el economicGroup OEJ--:' + f);
        
    }
    
    //Aqui termina cambio para modificar TopParent SEBAS
    public String getsEconomicGroupIdSelected() {
        return this.sEconomicGroupIdSelected;
    }
    
    public void setsEconomicGroupIdSelected(String sEconomicGroupIdSelected) {
        for (EIV_EntityWrapClass f : entities) {  if(f.Party_Id == sEconomicGroupIdSelected ) { this.entity.Economic_Group_ID = f.Party_Id; this.entity.Economic_Group_Name = f.Oracle_Account_Name; this.sEconomicGroupIdSelected = sEconomicGroupIdSelected; system.debug('Se selecciono el economicGroup OEJ--:' + f);}}   
    }
    
    public List<ES2_Obj_EntityMasterInCreditApproval__c> getCAsInEntity()
    {
        
        return Test.isRunningTest() ? null : [Select id, ES2_rb_Credit_approval__c, ES2_ms_Role__c,ES2_tx_TopParetName__c, ES2_rb_Credit_approval__r.name from ES2_Obj_EntityMasterInCreditApproval__c  where ES2_tx_Party_Id__c =: entity.Party_Id];
            
            }    
    
    public String getCodeId() {
        return sicCodeId;
    }
    
    
    public void setCodeId(String sicCodeId) {
        System.debug('El id del sic code seleccionado es OEJ:' +sicCodeId);
        try{
            TBO002_SIC_code__c sicCodeObj = [Select id, name, TBO002_tx_SIC_industry_description__c, TBO002_ls_SIC_industry__c from TBO002_SIC_code__c where Id =:sicCodeId Limit 1];
            entity.SIC_Code = sicCodeObj.Name;
            entity.SIC_Description = sicCodeObj.TBO002_tx_SIC_industry_description__c; 
            entity.SIC_CodeId = sicCodeObj.Id;
            entity.SIC_CodeIndustry = sicCodeObj.TBO002_ls_SIC_industry__c;
            this.sicCodeId = sicCodeId;} CATCH(exception e){ System.debug('El id del sic code seleccionado no existe OEJ'); }
    }
    
    public String getSicCodeDescriptionEntitie() {
        System.debug('El id del sic code seleccionado es OEJ:' +sicCodeId);
        String description = '';
        if(String.isNotBlank(entity.SIC_Code) )
        {
            try{
                description = [Select TBO002_tx_SIC_industry_description__c from TBO002_SIC_code__c where name =:this.entity.SIC_Code][0].TBO002_tx_SIC_industry_description__c;
            }catch(exception e){
                System.debug('El id del sic code seleccionado no existe OEJ');
            }
        }
        return description;
    }    
    
    
    public String getSicCodeDescriptionEG() {
        System.debug('El id del sic code seleccionado es OEJ:' +sicCodeId);
        String description = '';
        if(String.isNotBlank(this.entity.SIC_Code) )
        {
            try{
                description = [Select TBO002_tx_SIC_industry_description__c from TBO002_SIC_code__c where name =:this.entity.Economic_group_SIC_Code][0].TBO002_tx_SIC_industry_description__c;
            }catch(exception e){
                System.debug('El id del sic code seleccionado no existe OEJ');
            }
        }
        return description;
    }     
    
    public String postalCodeZIP {get;set;}
    public String postalCodeState {get;set;}
    
    public String getPostalCode() {
        return postalCodeId;
    }
    
    public String getPostalCode(String PostalCode) {
        
        try{
            EIV_PostalCodeCatalog__c postalCodeCatalog = [Select id, EIV_tx_Codigo_Estado__c, EIV_tx_Postal_Code__c from EIV_PostalCodeCatalog__c where EIV_tx_Postal_Code__c =:PostalCode Limit 1];
            System.debug('Codigo Postal consultado' + postalCodeCatalog);
            postalCodeState = postalCodeCatalog.EIV_tx_Codigo_Estado__c;
            addressObj.State = postalCodeCatalog.EIV_tx_Codigo_Estado__c;
            addressObj.Zip_Code = postalCodeCatalog.EIV_tx_Postal_Code__c;
            postalCodeZIP = postalCodeCatalog.EIV_tx_Postal_Code__c;
            addressObj.PostalCodeId = postalCodeCatalog.id;
            this.postalCodeId = postalCodeCatalog.Id;
            
        }catch(exception e){
            System.debug('El id del codigoPostal no existe OEJ');
        }               
        
        return postalCodeId;
    }    
    
    public void setPostalCode(String codePostalId) {
        
        try{
            EIV_PostalCodeCatalog__c postalCodeCatalog = [Select id, EIV_tx_Codigo_Estado__c, EIV_tx_Postal_Code__c from EIV_PostalCodeCatalog__c where Id =:codePostalId Limit 1];
            System.debug('Codigo Postal consultado' + postalCodeCatalog);
            postalCodeState = postalCodeCatalog.EIV_tx_Codigo_Estado__c; addressObj.State = postalCodeCatalog.EIV_tx_Codigo_Estado__c; addressObj.Zip_Code = postalCodeCatalog.EIV_tx_Postal_Code__c; postalCodeZIP = postalCodeCatalog.EIV_tx_Postal_Code__c; addressObj.PostalCodeId = postalCodeCatalog.id; this.postalCodeId = codePostalId;
            
        }catch(exception e){
            System.debug('El id del codigoPostal no existe OEJ');
        }        
        
        
    }    
    
    public string zipCodeForMex(String Nacionality, String ZipCode)
    {
        if(Nacionality == 'MEX')
        {
            return this.postalCodeZIP;
        }
        else
        {
            return ZipCode;
        }
        
    }
    public string stateForMex(String Nacionality, String state)
    {
        if(Nacionality == 'MEX')
        {
            return this.postalCodeState;
        }
        else
        {
            return state;
        }
        
    }    
    
    
    
    //Constructor, cuando se carga la pagina se cargan los valores
    //public EIV_EntityExtendClass(ApexPages.StandardController stdController) {
    public EIV_EntityExtendClassBis() {
        System.debug(LoggingLevel.INFO,'Inicia EIV_EntityExtendClassBis');
        contactObj = new EIV_ContactWrapClass();
        
        //Traemos los parametros de la pagina, por el momento entidad Dummy  
            this.sAccountId =  (String)System.currentPageReference().getParameters().get('AccountId');
            this.sAccountName =  (String)System.currentPageReference().getParameters().get('AccountName');
            this.sTopParentId =  (String)System.currentPageReference().getParameters().get('TopParentID');
            this.sTopParentName =  (String)System.currentPageReference().getParameters().get('TopParentName');
            this.sPartyId =  (String)System.currentPageReference().getParameters().get('PartyId');  
            this.sCustomerType =  (String)System.currentPageReference().getParameters().get('CustomerType');  
            this.sTargetMarket = (String)System.currentPageReference().getParameters().get('TargetMarket');    
         
        
        //IP DEV: http://160.34.7.97:7033
        //IP SOAQA:  http://160.34.7.238:7033
        //IP SOAPROD:  http://160.34.7.184:7033 
        
        
        this.sServiceURL = Test.isRunningTest() ? '' : [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='URL_Servicio'][0].EIV_tx_parameter__c; 
        this.sSSO = Test.isRunningTest() ? '' :  [Select EmployeeNumber From User Where Id = :UserInfo.getUserId()][0].EmployeeNumber;        
        System.debug('Este es el valor de partyid OEJ--' + this.sPartyId );  
        
        //Cargamos los permisos por default porel momento
        /*entityPrivileges = new EIV_PrivilegesWrapClass();
entityPrivileges.bCreate = true;
entityPrivileges.bRead = true;
entityPrivileges.bUpdate = true;
contactPrivileges = entityPrivileges;
invoicingPrivileges = entityPrivileges;
addressPrivileges = entityPrivileges;*/
        
        
        if ( String.isNotBlank(this.sPartyId)  )
        {
            System.debug('Esta lleno, estamos leyendo o actualizando una entidad OEJ--' + this.sPartyId );   
            getDetailEntity(this.sPartyId);
            //getdummyRequest();
            searchRequest();
            
        }
        else 
        {
            System.debug('Esta vacio, estamos creando una entidad OEJ--' + this.sPartyId );
            //Llenamos la entidad con los valores que ya traemos de la cuenta
            this.entity = new EIV_EntityWrapClass();
            this.entity.Target_Market_Jurisdiction = this.sTargetMarket;
            System.debug('Top Parent Name OEJ:' + this.sTopParentName);
            
            if(String.isBlank(this.sTopParentId))
            {
                System.debug('Top Parent Name esta en blanco OEJ:' + this.sTopParentName);
                this.entity.Top_Parent_ID = this.sAccountId;
                this.entity.Top_Parent_Name = this.sAccountName;
                this.sTopParentId = this.sAccountId;
                this.sTopParentName = this.sAccountName;
            }
            else
            {
                System.debug('Top Parent Name NO esta en blanco OEJ:' + this.sTopParentName);
                this.sAccountId = this.sTopParentId;
                this.sAccountName = this.sTopParentName;
                this.entity.Account_ID = this.sTopParentId;
                this.entity.SF_Account_Name = this.sTopParentName;
                
            }
            System.debug('Top Parent Name :' + this.sTopParentName);
            System.debug('Top Parent Id :' + this.sTopParentId);
            if(this.sCustomerType == null){this.sCustomerType = '';}
            if( this.sCustomerType.contains('Individual'))
            {
                this.entity.Customer_Type = 'INDIVIDUAL';
            }
            else if ( this.sCustomerType.contains('Organi'))
            {
                this.entity.Customer_Type = 'ORGANIZATION';
            }
            else
            {
                this.entity.Customer_Type = 'ECONOMIC GROUP';
            }
        }
        /*String NameAccount = '';
        try{
            NameAccount = [Select name from Account where id =: topParentSelected][0].id;
        }
        Catch(Exception e)
        {
            NameAccount = 'TestName'; 
            System.debug('No existe el ID');
        }*/
        //this.topParentSelected = this.entity.Top_Parent_Name;
        settopParentSelected(this.sTopParentId);
    }  
    
    public PageReference Cancel()
    {        
        PageReference pr = new PageReference('/' + this.sAccountId);
        pr.setRedirect(true);
        return pr;        
    }  
    
    public List<ES2_wraper_documents> getDocumentListForEntity()
    {
        
        return Test.isRunningTest() ? null : ES2_DocumentFill.fillDocumentsListForEntity(EIV_EntityExtencionCalloutClass.callBackGetDocumentsInEntity(sServiceURL, this.entity.Party_Id));
    }
    
    public List<ES2_wraper_audits> getAuditListForEntity()
    {
        
        return Test.isRunningTest() ? null : ES2_DocumentFill.fillAuditListForEntity(EIV_EntityExtencionCalloutClass.callBackAuditEntity(this.entity.Party_Id, sServiceURL));
    }    
    
    public List<SelectOption> getEGOptions() { 
        List<SelectOption> EGOptions = new List<SelectOption>();
        EGOptions.add(new SelectOption('','SELECTION'));
        getListEntities('0', 'getAllEntitys'); for (EIV_EntityWrapClass f : entities) {  if(f.Customer_Type == 'ECONOMIC GROUP' ) { EGOptions.add(new SelectOption(f.Party_Id,f.Oracle_Account_Name)); }}
        return EGOptions;        
    }    
    
    public List<EIV_EntityWrapClass> getEntitiesFromEconomicGroup() {   
        List<EIV_EntityWrapClass> entitiesInEG = new List<EIV_EntityWrapClass>();
        getListEntities(this.sPartyId, 'getAllEntitys');
        for (EIV_EntityWrapClass f : entities) {  
            if(f.Customer_Type != 'ECONOMIC GROUP' && f.Economic_Group_ID == this.entity.Party_Id )
            {
                entitiesInEG.add(f);
            }
            
        }
        return entitiesInEG;        
    }    
    
    
    
    public PageReference SaveEntity()
    {
        
        this.sCustomerType = this.entity.Customer_Type;
        system.debug('OEJ SaveEntity 2106OEJ' + this.entity.Customer_Type);
        PageReference pr;        
        //falta logica del guardado
        //primero genero la entidad como JSON
        Map<String, Object> jsonResponse = null;
        try{
        jsonResponse = EIV_EntityExtencionCalloutClass.postEntity(entityToJson(),this.sServiceURL);
        }catch(Exception e){
            system.debug('Error al guardar ' + e.getLineNumber()); 
            if(e.getLineNumber() == 178){
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.FATAL,'Porfavor seleccione un top parent'));
            }
        }
        if (jsonResponse == null) //Error en ORACLE, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Oracle Server missing'));
            pr = new PageReference('/apex/' + vfTypeEntitieEdit(this.entity.Customer_Type));
            pr.setRedirect(false); //Pasamos el controlador lleno 
        }
        else
        {
            //El resultado tiene status
            Map<String, Object> status = (Map<String, Object>)jsonResponse.get('status');
            System.debug('Received the following JSON response of status OEJ01:' + status);
            detail = new EIV_DetailWrapClass();
            this.detail.errorCode =  (String)status.get('code'); //{code=S,N, detail=0, message=0}
            this.detail.description =  (String)status.get('detail');
            this.detail.message =  (String)status.get('message');
            this.sPartyId = (String)jsonResponse.get('partyID');
            system.debug('OEJ--PartyID:' +sPartyId );
            if(this.detail.message == 'S' && String.isNotBlank(this.sPartyId) ) //Exito en el salvado, pasamos a la pagina de lectura y recargamos el controlador
            {
                EM_EntityCP entityCP = new EM_EntityCP();
                entityCP.entityCPFromEntityMaster(this.entity.RFC, this.entity.TIN, this.sPartyId, this.sSSO, false);
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,this.detail.description));
                pr = new PageReference('/apex/' + vfTypeEntitieRead(this.entity.Customer_Type) + '?CustomerType=' + this.entity.Customer_Type + '&AccountId=' + this.sAccountId + '&AccountName=' + this.sAccountName + '&TopParentID=' + this.sTopParentId + '&TopParentName=' + this.sTopParentName + '&PartyId=' + this.sPartyId);
                pr.setRedirect(true); //Recargamos el controlador  
                
            }
            else //Error en el salvado, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,this.detail.description));
                pr = new PageReference('/apex/' + vfTypeEntitieEdit(this.entity.Customer_Type));
                pr.setRedirect(false); //Pasamos el controlador lleno  
            }            
        }        
        return pr;        
    }   
    
    public PageReference NewEntity()
    {
        //this.sCustomerType = this.sCustomerType.replace('Read','Edit'); falta logica del guardado
        System.debug('Top Parent Id en el boton de NewEntity:' + this.sTopParentId);System.debug('Top Parent Name en el boton de NewEntity:' + this.sTopParentName);
        PageReference pr = new PageReference('/apex/EIV_EntitySelectTypePage?AccountId=' + this.sAccountId + '&AccountName=' + this.sAccountName + '&TopParentID=' + this.sTopParentId +  '&TargetMarket=' + this.sTargetMarket + '&TopParentName=' + this.sTopParentName + '&PartyId='  );
        pr.setRedirect(false); //Pasamos el controlador lleno  
        return pr;        
    }       
    public PageReference NewAML()
    {
        //falta logica del guardado
        PageReference pr = new PageReference('/apex/ES2_EditPage_AML?TopParentID=' + this.sTopParentId + 
                                             '&TopParentName=' + this.sTopParentName + 
                                             '&OracleAccountName=' + this.entity.Oracle_Account_Name +                                              
                                             '&PartyId=' + this.entity.Party_Id + 
                                             '&RequestType=AML Hits / CRR' +
                                             '&requestId=');
        pr.setRedirect(true); //Pasamos el controlador vacio  
        return pr;        
    }     
    public PageReference NewDocument()
    {
        //falta logica del guardado
        /////***////
        
        PageReference pr = new PageReference('/apex/ES2_EditPage_ADD_COMENTARIOS?TopParentID=' + this.sTopParentId + 
                                             '&TopParentName=' + this.sTopParentName + 
                                             '&OracleAccountName=' + this.entity.Oracle_Account_Name +                                              
                                             '&PartyId=' + this.entity.Party_Id + 
                                             '&requestId=');
        pr.setRedirect(true); //Pasamos el controlador vacio  
        return pr;        
    }      
    public PageReference NewComment()
    {
        //falta logica del guardado
        /////***////
        
        PageReference pr = new PageReference('/apex/ES2_EditPage_ADD_DOCUMENTOS?TopParentID=' + this.sTopParentId + 
                                             '&TopParentName=' + this.sTopParentName + 
                                             '&OracleAccountName=' + this.entity.Oracle_Account_Name +                                              
                                             '&PartyId=' + this.entity.Party_Id + 
                                             '&requestId=');
        pr.setRedirect(true); //Pasamos el controlador vacio  
        return pr;        
    }         
    public PageReference NewNDA()
    {
        //falta logica del guardado
        /////***////
        
        PageReference pr = new PageReference('/apex/ES2_EditPage_NDA?TopParentID=' + this.sTopParentId + 
                                             '&TopParentName=' + this.sTopParentName + 
                                             '&OracleAccountName=' + this.entity.Oracle_Account_Name +                                              
                                             '&PartyId=' + this.entity.Party_Id + 
                                             '&requestId=');
        pr.setRedirect(true); //Pasamos el controlador vacio  
        return pr;        
    }
    //principio lo que se agrego para ES5
    public PageReference NewLA()
    {
        //falta logica del guardado
        /////***////
        //'&TopParentName=' + this.sTopParentName +
        System.debug('Entity.Top_Parent_Name ' +Entity.Top_Parent_Name );
        PageReference pr = new PageReference('/apex/ES5_EditPage_Legal_Assessment?TopParentID=' + this.sTopParentId + 
                                             '&TopParentName=' + Entity.Top_Parent_Name + 
                                             '&OracleAccountName=' + this.entity.Oracle_Account_Name +                                              
                                             '&PartyId=' + this.entity.Party_Id + 
                                             '&requestId=');
        pr.setRedirect(true); //Pasamos el controlador vacio  
        return pr;        
    }
    
    public string rfcotin(){
        string a;
        if(this.entity.Nationality != 'MEX'){
            a=this.entity.TIN;
        }else{
            a=this.entity.RFC;
        }
        return a;
    }
    
    public PageReference NewLAPM()
    {
        //falta logica del guardado
        /////***////
        //
        PageReference pr;
        system.debug('JDLL: me llega "' + this.entity.Oracle_Account_Number + '" y "'+this.entity.Nationality + '"' );
        if( entity.Oracle_Account_Number == null || entity.Nationality == null){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'falta informacion para poder generar esta solicitud falta Oracle Account Number o Nacionalidad'));
            pr = new PageReference('/apex/' + vfTypeEntitieRead(this.entity.Customer_Type) + '?CustomerType=' + this.entity.Customer_Type + '&AccountId=' + this.sAccountId + '&AccountName=' + this.sAccountName + '&TopParentID=' + this.sTopParentId + '&TopParentName=' + this.sTopParentName + '&PartyId=' + this.sPartyId);
                pr.setRedirect(false); //Recargamos el controlador
        }else{
            System.debug('Apexpages.currentPage().getUrl(); ' + Apexpages.currentPage().getUrl().substringBefore('?'));
            pr= new PageReference('/apex/ES5_Legal_Assassment?' +
                                  'TopParentID=' + pasnull(this.sTopParentId) +
                                  '&TopParentName=' + pasnull(Entity.Top_Parent_Name) +
                                  '&OracleAccountName=' + pasnull(this.entity.Oracle_Account_Name) +
                                  '&PartyId=' + pasnull(this.entity.Party_Id) +
                                  
                                  '&tax='+ pasnull(this.entity.Tax_Regime) +
                                  '&CURP='+ pasnull(this.entity.CURP) +
                                  '&Nombre=' + pasnull(this.entity.entityName) +
                                  '&Nocuenta='+pasnull(this.entity.Oracle_Account_Number) +
                                  
                                  '&Nationality='+pasnull(this.entity.Nationality)+
                                  '&Entitytype='+pasnull(this.entity.Customer_type)+
                                  '&RFC='+ pasnull(rfcotin())+
                                  '&EG='+pasnull(this.entity.Economic_Group_Name)+
                                  
                                  '&from=Entity' +
                                  '&URLRetorno=' + Apexpages.currentPage().getUrl().substringBefore('?'));
            
            pr.setRedirect(true); //Pasamos el controlador vacio
            
            
        }
        return pr;
    }
    
    public PageReference NewLAPF()
    {
        //falta logica del guardado
        /////***////
        PageReference pr;
        if(string.isEmpty(this.entity.Oracle_Account_Number)|| string.isEmpty(this.entity.Nationality)){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'falta informacion para poder generar esta solicitud falta Oracle Account Number o Nacionalidad'));
            pr = new PageReference('/apex/' + vfTypeEntitieRead(this.entity.Customer_Type) + '?CustomerType=' + this.entity.Customer_Type + '&AccountId=' + this.sAccountId + '&AccountName=' + this.sAccountName + '&TopParentID=' + this.sTopParentId + '&TopParentName=' + this.sTopParentName + '&PartyId=' + this.sPartyId);
                pr.setRedirect(false); //Recargamos el controlador              
        }else{
        system.debug('Entity.Top_Parent_Name ' + Entity.Top_Parent_Name);
        pr = new PageReference('/apex/ES5_Legal_Assassment?TopParentID=' + pasnull(this.sTopParentId) +
                                             '&TopParentName=' + pasnull(Entity.Top_Parent_Name) +
                                             '&OracleAccountName=' + pasnull(this.entity.Oracle_Account_Name) +
                                             '&PartyId=' + pasnull(this.entity.Party_Id) +
                                             '&requestId='+
                                             '&Nocuenta='+pasnull(this.entity.Oracle_Account_Number)+
                                             '&Nationality='+pasnull(this.entity.Nationality)+
                                             '&Entitytype='+pasnull(this.entity.Customer_type)+
                                             '&RFC='+ pasnull(rfcotin())+
                                             '&CURP='+ pasnull(this.entity.CURP)+
                                             '&tax='+ pasnull(this.entity.Tax_Regime)+
                                             '&EG='+pasnull(this.entity.Economic_Group_Name)+
                                             '&from=Entity' +
                                            '&URLRetorno=' + Apexpages.currentPage().getUrl().substringBefore('?'));
        pr.setRedirect(true); //Pasamos el controlador vacio
        }
        return pr;
    }
        public string pasnull(string a){
        if(a!=null || a=='\n'){
            return a;
        }else{
            return '';
        }
    }
    //fin lo que se agrego para ES5
    
    public PageReference NewEVAL()
    {
        //falta logica del guardado
        /////***////
        PageReference pr = new PageReference('/apex/ES4_EditPage_EVAL?TopParentID=' + this.sTopParentId +
                                             '&TopParentName=' + this.sTopParentName +
                                             '&OracleAccountName=' + this.entity.Oracle_Account_Name +
                                             '&PartyId=' + this.entity.Party_Id +
                                             '&requestId='+
                                             '&from=Entity'+'&eval=new');
        pr.setRedirect(true); //Pasamos el controlador vacio
        return pr;
    }
    
    
    public PageReference newKYCPF()
    {
        //falta logica del guardado
        /////***////
        ES2_controller_POSTjson vacio = new ES2_controller_POSTjson();
        string nr = '';
        
        PageReference pr = new PageReference('/apex/ES2_EditPage_KWYPersonaFisica?TopParentID=' + this.sTopParentId +
                                             '&RequestType=KYC Individual' +
                                             '&AccountId=' + this.sAccountId +
                                             '&AccountName=' + this.sAccountName + 
                                             '&CustomerType='+ this.entity.Customer_Type +
                                             '&TopParentName=' + this.sTopParentName + 
                                             '&OracleAccountName=' + this.entity.Oracle_Account_Name +                                              
                                             '&PartyId=' + this.entity.Party_Id + 
                                             '&RFC=' + vacio.pasnull(this.entity.RFC) +
                                             '&Nationality=' + vacio.pasnull(this.entity.Nationality) +
                                             
                                             '&Calle=' + vacio.pasnull(this.addressList ==null ? nr : this.addressList[0].Street)  +
                                             '&Outnum=' + vacio.pasnull(this.addressList ==null? nr : this.addressList[0].Outdoor_Number) +
                                             '&Intnum=' + vacio.pasnull(this.addressList ==null? nr : this.addressList[0].Interior_Number) +
                                             '&County=' + vacio.pasnull(this.addressList ==null? nr : this.addressList[0].County) + 
                                             '&Municipality=' + vacio.pasnull(this.addressList ==null? nr : this.addressList[0].Municipality) +
                                             '&City=' + vacio.pasnull(this.addressList ==null? nr : this.addressList[0].City) +
                                             '&Estate=' + vacio.pasnull(this.addressList ==null? nr : this.addressList[0].State) +
                                             '&Country='+ vacio.pasnull(this.addressList ==null? nr : this.addressList[0].Country) +
                                             '&Zip=' + vacio.pasnull(this.addressList ==null? nr : this.addressList[0].Zip_Code) +
                                             '&requestId=');
        /*TopParentID=' + this.sTopParentId + 
'&TopParentName=' + this.sTopParentName + 
'&OracleAccountName=' + this.entity.Oracle_Account_Name +  
'&CustomerType='+ this.entity.Customer_Type +
'&AccountId=' + this.sAccountId + 
'&AccountName=' + this.sAccountName + 
'&TopParentID=' + this.sTopParentId + 
'&TargetMarket=' + this.sTargetMarket +
'&PartyId=' + this.entity.Party_Id + 
'&requestId=' +this.sIdChild);*/
        pr.setRedirect(false); //Pasamos el controlador vacio  
        return pr;        
    }      
    public PageReference newKYCPM()
    {
        //falta logica del guardado
        /////***////
        ES2_controller_POSTjson vacio = new ES2_controller_POSTjson();
        string nr = '';
        PageReference pr = new PageReference('/apex/ES2_EditPage_KWYPersonaMoral?TopParentID=' + this.sTopParentId +
                                             '&RequestType=KYC Organization' +
                                             '&CustomerType='+ this.entity.Customer_Type +
                                             '&TopParentName=' + this.sTopParentName +
                                             '&TopParentId=' + this.sTopParentId +
                                             '&AccountId=' +this.sAccountId +
                                             '&OracleAccountName=' + this.entity.Oracle_Account_Name +                                              
                                             '&PartyId=' + this.entity.Party_Id +
                                             '&RFC=' + vacio.pasnull(this.entity.RFC ==null ? nr : this.entity.RFC) +
                                             '&Nationality=' + vacio.pasnull(this.entity.Nationality) +
                                             '&SIC='+ vacio.pasnull(this.entity.SIC_Description)  + 
                                             '&Calle=' + vacio.pasnull(this.addressList ==null ? nr : this.addressList[0].Street)  +
                                             '&Outnum=' + vacio.pasnull(this.addressList ==null? nr : this.addressList[0].Outdoor_Number) +
                                             '&Intnum=' + vacio.pasnull(this.addressList ==null? nr : this.addressList[0].Interior_Number) +
                                             '&County=' + vacio.pasnull(this.addressList ==null? nr : this.addressList[0].County) + 
                                             '&Municipality=' + vacio.pasnull(this.addressList ==null? nr : this.addressList[0].Municipality) +
                                             '&City=' + vacio.pasnull(this.addressList ==null? nr : this.addressList[0].City) +
                                             '&Estate=' + vacio.pasnull(this.addressList ==null? nr : this.addressList[0].State) +
                                             '&Country='+ vacio.pasnull(this.addressList ==null? nr : this.addressList[0].Country) +
                                             '&Zip=' + vacio.pasnull(this.addressList ==null? nr : this.addressList[0].Zip_Code) +                                             
                                             '&requestId=');
        
        
        /*TopParentID=' + this.sTopParentId + 
'&TopParentName=' + this.sTopParentName + 
'&OracleAccountName=' + this.entity.Oracle_Account_Name +  
'&CustomerType='+ this.entity.Customer_Type +
'&AccountId=' + this.sAccountId + 
'&AccountName=' + this.sAccountName + 
'&TopParentID=' + this.sTopParentId + 
'&TargetMarket=' + this.sTargetMarket +
'&PartyId=' + this.entity.Party_Id + 
'&requestId=' +this.sIdChild);*/
        
        pr.setRedirect(true); //Pasamos el controlador vacio  
        return pr;        
    }      
    
    public PageReference newCreditBureau()
    {
        //falta logica del guardado
        /////***////
        
        ES2_controller_POSTjson vacio = new ES2_controller_POSTjson();
        
        system.debug('OEJ sIdChild Antes de recargar la Addres:' + sIdChild);
        if(addressList.size()>0)
        {
            for(EIV_AddressWrapClass adresswrap: addressList)
            {
                if(adresswrap.Location_ID.equals(this.sIdChild)){ this.addressObj = adresswrap; break; }                    
            }
        }        
        
        PageReference pr = new PageReference('/apex/ES2_EditPage_CREDIT_BUREAU?TopParentID=' + this.sTopParentId + 
                                             '&TopParentName=' + this.sTopParentName + 
                                             '&RequestType=CREDIT_BUREAU' + 
                                             '&OracleAccountName=' + quitaAnd(this.entity.Oracle_Account_Name) +                                              
                                             '&PartyId=' + this.entity.Party_Id + 
                                             '&requestId=' +
                                             '&First_Name=' + vacio.pasnull(this.entity.First_Name ==null ? '':this.entity.First_Name) +                                                 
                                             '&First_Last_Name=' + vacio.pasnull(this.entity.First_Last_Name ==null ? '':quitaAnd(this.entity.First_Last_Name)) +
                                             '&Middle_Name=' + vacio.pasnull(this.entity.Middle_Name ==null ? '':this.entity.Middle_Name) +
                                             //'&First_Last_Name=' + vacio.pasnull(this.entity.First_Last_Name ==null ? '':this.entity.First_Last_Name) +
                                             '&Second_Last_Name=' + vacio.pasnull(this.entity.Second_Last_Name ==null ? '':this.entity.Second_Last_Name) +
                                             '&Outdoor_Number=' + this.addressObj.Outdoor_Number +
                                             '&purpuse=' + this.addressObj.Purpose +
                                             '&Interior_Number=' + this.addressObj.Interior_Number +
                                             '&RFC='+this.entity.RFC+
                                             '&Street='+this.addressObj.Street+
                                             '&County=' + this.addressObj.County +
                                             '&Municipality=' + this.addressObj.Municipality +
                                             '&Country=' + this.addressObj.Country +
                                             '&City=' + this.addressObj.City +
                                             '&Zip_Code=' + this.addressObj.Zip_Code +
                                             '&State=' + vacio.pasnull(this.addressObj.State ==null ? '':+this.addressObj.State)+
                                             '&companyname=' + vacio.pasnull(this.entity.Oracle_Account_Name ==null ? '': quitaAnd(this.entity.Oracle_Account_Name))+
                                             '&entity='+this.entity.Customer_Type
                                            );
        pr.setRedirect(FALSE); //Pasamos el controlador vacio  
        return pr;       
    }      
    public PageReference EditEntity()
    {
        
        //falta logica del guardado
        /*
this.entity.Account_ID = sAccountId;
this.entity.SF_Account_Name = sAccountName;
this.entity.Top_Parent_ID = sTopParentId;
this.entity.Top_Parent_Name = sTopParentName;
this.entity.Party_Id = sPartyId;
*/
        
        /////**
        //Aqui se supone que estamos editando, por lo que ya no es necesario consultar WS, pasamos controlador lleno
        //*////
        System.debug('OEJ 001'+  this.entity.Customer_Type);
        //this.sCustomerType = this.sCustomerType.replace('Read','Edit');
        System.debug('Top Parent Name en el boton de EditEntity:' + this.sTopParentName);
        System.debug('Top Parent Id en el boton de EditEntity:' + this.sTopParentId);
        PageReference pr = new PageReference('/apex/' + vfTypeEntitieEdit(this.entity.Customer_Type) + '?CustomerType=' + this.entity.Customer_Type + '&AccountId=' + this.sAccountId + '&AccountName=' + this.sAccountName + '&TopParentID=' + this.sTopParentId + '&TopParentName=' + this.sTopParentName + '&PartyId=' );
        pr.setRedirect(false); //Pasamos el controlador lleno  
        return pr;        
    } 
    public PageReference editAddress()
    {
        if(addressObj.Country=='MEX')
            getPostalCode(addressObj.Zip_Code);
        PageReference pr = new PageReference('/apex/EIV_AddressEditPage');
        pr.setRedirect(false); //Pasamos el controlador lleno  
        return pr;
    }
    public PageReference editInvoicing()
    {
        PageReference pr = new PageReference('/apex/EIV_InvoicingEditPage');
        pr.setRedirect(false); //Pasamos el controlador lleno  
        return pr;
    }    
    public PageReference editContact()
    {
        PageReference pr = new PageReference('/apex/EIV_ContactEditPage');
        pr.setRedirect(false); //Pasamos el controlador lleno  
        return pr;
    }    
    public PageReference newAddress()
    {
        this.addressObj = new EIV_AddressWrapClass(); 
        this.addressObj.EntityPartyId = this.entity.Party_Id;
        PageReference pr = new PageReference('/apex/EIV_AddressEditPage');
        pr.setRedirect(false); //Pasamos el controlador lleno  
        return pr;
    }      
    public PageReference newContact()
    {
        this.contactObj = new EIV_ContactWrapClass();
        this.contactObj.EntityPartyId = this.entity.Party_Id;
        PageReference pr = new PageReference('/apex/EIV_ContactEditPage');
        pr.setRedirect(false); //Pasamos el controlador lleno  
        return pr;
    }      
    public PageReference newInvoicing()
    {
        this.invoicingObj = new EIV_InvoicingWrapClass(); 
        this.invoicingObj.partySiteId = this.entity.Party_Id;
        PageReference pr = new PageReference('/apex/EIV_InvoicingEditPage');
        pr.setRedirect(false); //Pasamos el controlador lleno  
        return pr;
    }       
    public PageReference cloneAddress()
    {
        addressObj.Location_ID = null;
        if(addressObj.Country=='MEX')
            getPostalCode(addressObj.Zip_Code);
        PageReference pr = new PageReference('/apex/EIV_AddressEditPage');
        pr.setRedirect(false); //Pasamos el controlador lleno  
        return pr;
    }    
    public PageReference cloneContact()
    {
        contactObj.Contact_id = null;
        contactObj.partyContact_Id = null;
        PageReference pr = new PageReference('/apex/EIV_ContactEditPage');
        pr.setRedirect(false); //Pasamos el controlador lleno  
        return pr;
    }      
    public PageReference cloneInvoicing()
    {
        invoicingObj.invoiceId = null;
        PageReference pr = new PageReference('/apex/EIV_InvoicingEditPage');
        pr.setRedirect(false); //Pasamos el controlador lleno  
        return pr;
    }     
    public PageReference saveAddress()
    {
        
        system.debug('OEJ saveAddress 2106OEJ' + this.entity.Customer_Type);
        PageReference pr;        
        //falta logica del guardado
        //primero genero la entidad como JSON
        Map<String, Object> jsonResponse = null;
        jsonResponse = EIV_EntityExtencionCalloutClass.postAddress(addressToJson(),this.sServiceURL);
        if (jsonResponse == null) //Error en ORACLE, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Oracle Server missing'));
            pr = new PageReference('/apex/EIV_AddressEditPage');
            pr.setRedirect(false); //Pasamos el controlador lleno 
        }
        else
        {
            //El resultado tiene status
            Map<String, Object> status = (Map<String, Object>)jsonResponse.get('status');
            //String sAddresIdLocation = (String)jsonResponse.get('locationId');
            System.debug('Received the following JSON response of status OEJ01:' + status);
            //System.debug('Received the following JSON response of sAddresIdLocation OEJ01:' + sAddresIdLocation);
            detail = new EIV_DetailWrapClass();
            this.detail.errorCode =  (String)status.get('code'); //{code=S,N, detail=0, message=0}
            this.detail.description =  (String)status.get('detail');
            this.detail.message =  (String)status.get('message');
            this.sPartyId = (String)jsonResponse.get('partyID');
            if(this.detail.message == 'S') //Exito en el salvado, pasamos a la pagina de lectura de la Entidad y recargamos el controlador
            {
                EM_EntityCP ent = new EM_EntityCP();
                ent.entityCPFromEntityMaster(this.entity.RFC, this.entity.TIN, this.entity.Party_Id, this.sSSO, false);
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,this.detail.description));
                pr = new PageReference('/apex/' + vfTypeEntitieRead(this.entity.Customer_Type) + '?CustomerType=' + this.entity.Customer_Type + '&AccountId=' + this.sAccountId + '&AccountName=' + this.sAccountName + '&TopParentID=' + this.sTopParentId + '&TopParentName=' + this.sTopParentName + '&PartyId=' + this.entity.Party_Id);
                pr.setRedirect(true); //Recargamos el controlador  
                
            }
            else //Error en el salvado, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,this.detail.description));
                //ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'ID Address (locationId) =' + sAddresIdLocation));
                pr = new PageReference('/apex/EIV_AddressEditPage');
                pr.setRedirect(false); //Pasamos el controlador lleno  
            }
            
        }
        return pr;
    }      
    public PageReference saveContact()
    {
        system.debug('OEJ saveContact 2106OEJ' + this.entity.Customer_Type);
        PageReference pr;        
        //falta logica del guardado
        //primero genero la entidad como JSON
        Map<String, Object> jsonResponse = null;
        jsonResponse = EIV_EntityExtencionCalloutClass.postContact(contactToJson(),this.sServiceURL);
        if (jsonResponse == null) //Error en ORACLE, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Oracle Server missing'));
            pr = new PageReference('/apex/EIV_ContactEditPage');
            pr.setRedirect(false); //Pasamos el controlador lleno 
        }
        else
        {
            //El resultado tiene status
            Map<String, Object> status = (Map<String, Object>)jsonResponse.get('status');
            System.debug('Received the following JSON response of status OEJ01:' + status);
            detail = new EIV_DetailWrapClass();
            this.detail.errorCode =  (String)status.get('code'); //{code=S,N, detail=0, message=0}
            this.detail.description =  (String)status.get('detail');
            this.detail.message =  (String)status.get('message');
            if(this.detail.description == 'S') //Exito en el salvado, pasamos a la pagina de lectura de la Entidad y recargamos el controlador
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,this.detail.message));
                pr = new PageReference('/apex/' + vfTypeEntitieRead(this.entity.Customer_Type) + '?CustomerType=' + this.entity.Customer_Type + '&AccountId=' + this.sAccountId + '&AccountName=' + this.sAccountName + '&TopParentID=' + this.sTopParentId + '&TopParentName=' + this.sTopParentName + '&PartyId=' + this.entity.Party_Id);
                pr.setRedirect(true); //Recargamos el controlador  
                
            }
            else //Error en el salvado, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,this.detail.message));
                pr = new PageReference('/apex/EIV_ContactEditPage');
                pr.setRedirect(false); //Pasamos el controlador lleno  
            }
            
        }
        return pr;
    } 
    public void getVirtualAccount()
    {
        System.debug(LoggingLevel.INFO,'Inicia getVirtualAccount');
        system.debug('invoicingObj.EC_Operating_Unit_Name ' + invoicingObj.EC_Operating_Unit_Name);
        string RFCOTIN = string.isNotEmpty(this.entity.RFC) ? this.entity.RFC : this.entity.TIN;
        list<Entity_CP__c> listEntityCP = Data_Access_EntityCP.getEntityCPbyRFCTIN(RFCOTIN);
        Entity_CP__c entityCP = new Entity_CP__c();
        if(listEntityCP.size() > 0){
            entityCP = listEntityCP.get(0);
        }
        String engeniunLegalEntity = null;
        if(invoicingObj.EC_Operating_Unit_Name.contains('397')){        	 
            if(entityCP.Virtual_Account397__c != null){
                invoicingObj.EC_Payment_Account = entityCP.Virtual_Account397__r.Name;
                invoicingObj.EC_CLABE = entityCP.Virtual_Account397__r.CLABE__c;
            } else {
            	engeniunLegalEntity = '397';    
            }
        } else if(invoicingObj.EC_Operating_Unit_Name.contains('798')){            
            if(entityCP.Virtual_Account798__c != null){
            	invoicingObj.EC_Payment_Account = entityCP.Virtual_Account798__r.Name;
                invoicingObj.EC_CLABE = entityCP.Virtual_Account798__r.CLABE__c;    
            } else {
                engeniunLegalEntity = '798';
            }
        } else if(invoicingObj.EC_Operating_Unit_Name.contains('XA7')){            
            if(entityCP.Virtual_AccountXA7__c != null){
            	invoicingObj.EC_Payment_Account = entityCP.Virtual_AccountXA7__r.Name;
                invoicingObj.EC_CLABE = entityCP.Virtual_AccountXA7__r.CLABE__c;    
            } else {
                engeniunLegalEntity = 'XA7';
            }
        }
        if(engeniunLegalEntity != null){
        	Integer count = [SELECT COUNT() FROM Virtual__c where Engeniun_Legal_Entity__c =:engeniunLegalEntity and Entity_CP_id__c = null];
            Integer rand = Math.floor(Math.random() * count).intValue();
            Virtual__c virtualAccount = [SELECT Id, OwnerId, Name, Bank__c, CLABE__c, Entity_CP_id__c, Entity_CP_Name__c, Engeniun_Legal_Entity__c 
                                         FROM Virtual__c 
                                         where Engeniun_Legal_Entity__c =:engeniunLegalEntity 
                                         and Entity_CP_id__c = null LIMIT 1 OFFSET :rand];
            invoicingObj.EC_Payment_Account = virtualAccount.name;
            invoicingObj.EC_CLABE = virtualAccount.CLABE__c;   
            system.debug('virtualAccount ' + virtualAccount);
        }
        
        
    }
    public PageReference saveInvoicing()
    {
        
        system.debug('OEJ saveInvoicing 2106OEJ' + this.entity.Customer_Type);
        PageReference pr;        
        //falta logica del guardado
        //primero genero la entidad como JSON
        Map<String, Object> jsonResponse = null;
        jsonResponse = EIV_EntityExtencionCalloutClass.postInvoicing(InvoicingToJson(),this.sServiceURL);
        if (jsonResponse == null) //Error en ORACLE, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Oracle Server missing'));
            pr = new PageReference('/apex/EIV_InvoicingEditPage');
            pr.setRedirect(false); //Pasamos el controlador lleno 
        }
        else
        {
            //El resultado tiene status
            Map<String, Object> status = (Map<String, Object>)jsonResponse.get('status');
            System.debug('Received the following JSON response of status OEJ01:' + status);
            detail = new EIV_DetailWrapClass();
            this.detail.errorCode =  (String)status.get('code'); //{code=S,N, detail=0, message=0}
            this.detail.description =  (String)status.get('detail');
            this.detail.message =  (String)status.get('message');
            if(this.detail.message == 'S') //Exito en el salvado, pasamos a la pagina de lectura de la Entidad y recargamos el controlador
            {      
                getDetailEntity(this.sPartyId);
                List<string> listJson = EM_UpdateInvoices.UpdateEntity(this.invoicingObj,this.invoicingList, this.addressList,ssso);
        		system.debug('OEJ saveInvoicing 2106OEJ' + this.entity.Customer_Type);
                integer i = 0;
                for(string jsonInvoice : listJson){
                    system.debug('i ' + i);
                    i = i+1;
                    system.debug('jsonInvoice ' + jsonInvoice);
                	jsonResponse = EIV_EntityExtencionCalloutClass.postInvoicing(jsonInvoice,this.sServiceURL);
            		system.debug('jsonResponse ' + jsonResponse);    
                }                 
                EM_EntityCP ent = new EM_EntityCP(); 
       			ent.entityCPFromEntityMaster(this.entity.RFC, this.entity.TIN, this.entity.Party_Id, this.sSSO, true);
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,this.detail.message));
                pr = new PageReference('/apex/' + vfTypeEntitieRead(this.entity.Customer_Type) + '?CustomerType=' + this.entity.Customer_Type + '&AccountId=' + this.sAccountId + '&AccountName=' + this.sAccountName + '&TopParentID=' + this.sTopParentId + '&TopParentName=' + this.sTopParentName + '&PartyId=' + this.entity.Party_Id);
                pr.setRedirect(true); //Recargamos el controlador  
                
            }
            else //Error en el salvado, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,this.detail.message));
                pr = new PageReference('/apex/EIV_InvoicingEditPage');
                pr.setRedirect(false); //Pasamos el controlador lleno  
            }
            
        }        
        return pr;
    }      
    
    public PageReference backToEntity()
    {
        
        //PageReference pr = new PageReference('/apex/' + vfTypeEntitieRead(this.entity.Customer_Type));
        PageReference pr = new PageReference('/apex/' + vfTypeEntitieRead(this.entity.Customer_Type) + '?CustomerType=' + this.entity.Customer_Type + '&AccountId=' + this.sAccountId + '&AccountName=' + this.sAccountName + '&TopParentID=' + this.sTopParentId + '&TopParentName=' + this.sTopParentName + '&PartyId=' + this.sPartyId +  '&TargetMarket=' + this.sTargetMarket);
        //pr.setRedirect(false); //Pasamos el controlador lleno
        if(String.isBlank(this.sPartyId)) //no existe party ID al cual regresar, regresamos a las cuentas
            pr = new PageReference('/' + this.sAccountId);
        pr.setRedirect(true); //recargamos el controlador         
        return pr;
    }           
    
    public PageReference viewAddress()
    {
        system.debug('OEJ sIdChild Antes de recargar la Addres:' + sIdChild);
        if(addressList.size()>0)
        {
            for(EIV_AddressWrapClass adresswrap: addressList)
            {
                if(adresswrap.Location_ID.equals(this.sIdChild))
                {
                    system.debug('OEJ addressObj:' + addressObj);
                    system.debug('OEJ adresswrap:' + adresswrap);
                    this.addressObj = adresswrap;
                    break;
                }                    
            }
        }
        //redirigimos a la pagina de edición de Address
        PageReference pr = new PageReference('/apex/EIV_AddressReadPage');
        pr.setRedirect(false); //Pasamos el controlador lleno  
        return pr; 
    }    
    
    public PageReference viewAML()
    {
        
        //redirigimos a la pagina de edición de AML
        PageReference pr = new PageReference('/apex/ES2_ReadPage_AML?requestId=' + sIdChild + '&PartyId=' + entity.Party_Id);
        pr.setRedirect(true); //Pasamos el controlador vacio 
        return pr; 
    }
    public PageReference deleteDocument()
    {
        
        //agregar la logica del borrado
        //redirigimos nuevamente a la pagina de la entidad
        PageReference pr = new PageReference('/apex/' + vfTypeEntitieRead(this.entity.Customer_Type) + '?CustomerType=' + this.entity.Customer_Type + '&AccountId=' + this.sAccountId + '&AccountName=' + this.sAccountName + '&TopParentID=' + this.sTopParentId + '&TopParentName=' + this.sTopParentName + '&PartyId=' + this.sPartyId +  '&TargetMarket=' + this.sTargetMarket);
        //pr.setRedirect(false); //Pasamos el controlador lleno
        if(String.isBlank(this.sPartyId)) //no existe party ID al cual regresar, regresamos a las cuentas
            pr = new PageReference('/' + this.sAccountId);
        pr.setRedirect(true); //recargamos el controlador         
        return pr;
    }
    
    
    public PageReference viewCRBUREAU()    
    {
        PageReference pr = new PageReference('/apex/ES2_ReadPage_CREDIT_BUREAU?requestId=' +sIdChild +'&PartyId=' +entity.Party_Id);
        pr.setRedirect(true);
        return pr;
    }
    public PageReference viewInvoicing()
    {
        //Buscamos el objeto seleccionado y asignamos al controlador
        if(invoicingList.size()>0)
        {
            for(EIV_InvoicingWrapClass invoicingwrap: invoicingList)
            {
                if(invoicingwrap.p_cust_acct_site_id.equals(this.sIdChild))
                {
                    this.invoicingObj = invoicingwrap;
                    break;
                }                    
            }
        }
        //redirigimos a la pagina de edición de Address
        PageReference pr = new PageReference('/apex/EIV_InvoicingReadPage');
        pr.setRedirect(false); //Pasamos el controlador lleno  
        return pr; 
    }        
    
    public PageReference viewContact()
    {
        //Buscamos el objeto seleccionado y asignamos al controlador
        if(contactList.size()>0)
        {
            for(EIV_ContactWrapClass contactwrap: contactList)
            {
                if(contactwrap.Contact_id.equals(this.sIdChild))
                {
                    this.contactObj = contactwrap;
                    break;
                }                    
            }
        }
        //redirigimos a la pagina de edición de Address
        PageReference pr = new PageReference('/apex/EIV_ContactReadPage');
        pr.setRedirect(false); //Pasamos el controlador lleno  
        return pr; 
    }   
    
    public void searchRequest()
    {
        requestList = new List<ES2_WraperRequest>();
        //getdummyRequest();
        Map<string,object>jsonResponse =null;
        jsonResponse = EIV_EntityExtencionCalloutClass.callBackGetRequestForPartyId(this.sSSO, 'SF', this.sServiceURL, this.entity.Party_Id);
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
    
    
    public void getDetailEntity(String partyIdSeleccionado)
    {
        //Se carga en el controlador la entidad de prueba
        ////partyID=1484&sso=0&applicationCode=0&screen=0, Method=GET]
        //Enviaremos
        //PartyId, pasado pro la URL
        //SSO obtenido de consulta de EmployeeNumber
        //Aplication code, que sera siempre SF
        Map<String, Object> jsonResponse = null;
        jsonResponse = EIV_EntityExtencionCalloutClass.callBackEntityDetail(sSSO, partyIdSeleccionado, 'SF',this.sServiceURL);
        system.debug('jsonResponse ' + jsonResponse);
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
            this.detail.errorCode =  (String)status.get('code'); //{code=0, detail=0, message=0}
            this.detail.description =  (String)status.get('detail');
            this.detail.message =  (String)status.get('message');
            
            
            if(this.detail.description == 'S')
            {
                //Respuesta OK
                //El resultado tiene el detalle de la entidad 
                
                
                //El resultado tiene entityInfo 
                Map<String, Object> entityInfo = (Map<String, Object>)jsonResponse.get('entityInfo');
                System.debug('Received the following JSON response of entityInfo OEJ01:' + entityInfo);
                
                //EntityInfo tiene privilege de la entidad
                Map<String, Object> entityPriv = (Map<String, Object>)entityInfo.get('privilege');
                System.debug('Received the following JSON response of entityPriv OEJ01:' + entityPriv);                
                this.entityprivileges = responseToPrivilegeObj(entityPriv);
                
                //EntityInfo tiene entity que contiene aml, rating, sic, buro
                Map<String, Object> entityDetail = (Map<String, Object>)entityInfo.get('entity');
                System.debug('Received the following JSON response of entity OEJ01:' + entity);
                Map<String, Object> aml = (Map<String, Object>)entityDetail.get('aml');
                System.debug('Received the following JSON response of aml OEJ01:' + aml);
                Map<String, Object> rating = (Map<String, Object>)entityDetail.get('rating');
                System.debug('Received the following JSON response of rating OEJ01:' + rating);
                Map<String, Object> sic = (Map<String, Object>)entityDetail.get('sic');
                System.debug('Received the following JSON response of sic OEJ01:' + sic);
                Map<String, Object> buro = (Map<String, Object>)entityDetail.get('buro');
                System.debug('Received the following JSON response of buro OEJ01:' + buro);            
                
                //EntityInfo tiene contactInfo que contiene contacts que contiene contact
                Map<String, Object> contactInfo = (Map<String, Object>)entityInfo.get('contactInfo');
                System.debug('Received the following JSON response of contactInfo OEJ01:' + contactInfo);
                
                //ContactInfo tiene privilege del contacto
                Map<String, Object> contactPriv = (Map<String, Object>)contactInfo.get('privilege');
                System.debug('Received the following JSON response of contactPriv OEJ01:' + entityPriv);  
                contactPrivileges =  responseToPrivilegeObj(contactPriv);
                
                Map<String, Object> contacts = (Map<String, Object>)contactInfo.get('contacts');
                System.debug('Received the following JSON response of contacts OEJ01:' + contacts);
                if(contacts == null) //no traemos contactos
                {
                    System.debug('Esta entidad no tiene contactos'); 
                }
                else
                {
                    contactList = new List<EIV_ContactWrapClass>();
                    List<Object> con = (List<Object>)contacts.get('contact');
                    for(Object a : con)
                    {
                        Map<String, Object> newCon = (Map<String, Object>) a;
                        contactList.add(responseToContactObj(newCon));
                        
                    }       
                    
                }                
                
                //EntityInfo tiene AdressInfo que tiene Addresses que tiene Address
                Map<String, Object> addressInfo = (Map<String, Object>)entityInfo.get('addressInfo');
                System.debug('Received the following JSON response of addresesInfo OEJ01:' + addressInfo);
                Map<String, Object> addresses = (Map<String, Object>)addressInfo.get('addresses');
                System.debug('Received the following JSON response of addresses OEJ01:' + addresses);
                if(addresses==null)
                {
                    System.debug('Esta entidad no tiene direcciones');
                }
                else
                {
                    addressList = new List<EIV_AddressWrapClass>();
                    List<Object> address = (List<Object>)addresses.get('address');
                    for(Object a : address)
                    {
                        Map<String, Object> newAdd = (Map<String, Object>) a;
                        addressList.add(responseToAddressObj(newAdd));
                        
                    }
                    
                    System.debug('Received the following JSON response of address OEJ01:' + address);
                }
                
                
                //addressInfo tiene privileges 
                Map<String, Object> addressPriv = (Map<String, Object>)addressInfo.get('privilege');
                System.debug('Received the following JSON response of addressPriv OEJ01:' + addressPriv);
                this.addressPrivileges = responseToPrivilegeObj(addressPriv);
                
                //EntityInfo tiene invoiceInfo que tiene Invoices que tiene Invoice
                Map<String, Object> invoiceInfo = (Map<String, Object>)entityInfo.get('invoiceInfo');
                System.debug('Received the following JSON response of invoiceInfo OEJ01:' + invoiceInfo);
                Map<String, Object> invoices = (Map<String, Object>)invoiceInfo.get('invoices');
                System.debug('Received the following JSON response of invoices OEJ01:' + invoices);
                
                if(invoices==null)
                {
                    System.debug('Esta entidad no tiene invoices');
                }
                else
                {
                    
                    invoicingList = new List<EIV_InvoicingWrapClass>();
                    List<Object> invoiceL = (List<Object>)invoices.get('invoice');
                    for(Object a : invoiceL)
                    {
                        Map<String, Object> newInv = (Map<String, Object>) a;
                        invoicingList.add(responseToInvoicingObj(newInv));
                    }
                }
                Map<String, Object> invoicingPriv = (Map<String, Object>)invoiceInfo.get('privilege');
                System.debug('Received the following JSON response of invoicingPriv OEJ01:' + invoicingPriv); 
                this.invoicingPrivileges =  responseToPrivilegeObj(invoicingPriv);
                
                this.entity = responseToEntityObj(entityDetail, aml, rating, sic, buro);
                
                
            }
            else
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,this.detail.message));
            }
        }
    }
    
    public String yesNoToStringBoolean(String sbbool)
    {
        
        
        if( String.isBlank(sbbool) || sbbool == 'NO' )
            return 'false';
        else
            return 'true';            
    }    
    
    public string booleanToString(Boolean bbool)
    {
        
        
        if(bbool!=null &&  bbool)
            return 'true';
        else
            return 'false';            
    }    
    public string booleanToYesNo(Boolean bbool)
    {
        
        
        if(bbool!=null &&  bbool)
            return 'YES';
        else
            return 'NO';            
    }     
    
    
    public EIV_EntityWrapClass responseToEntityObj(Map<String, Object> entityDetail, 
                                                   Map<String, Object> aml, 
                                                   Map<String, Object> rating, 
                                                   Map<String, Object> sic, 
                                                   Map<String, Object> buro)
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
        this.sEconomicGroupIdSelected      = String.valueOf(entityDetail.get('economicGroupId'));
        System.debug('this.sEconomicGroupIdSelected  OEJ:' +this.sEconomicGroupIdSelected );
        etty.Economic_Group_ID             = String.valueOf(entityDetail.get('economicGroupId'));
        etty.Economic_Group_Name           = (String)entityDetail.get('economicGroupName');
        System.debug('OEJ Limited Information--' + entityDetail.get('limitedInformationEntity'));
        etty.Limited_information_entity    = (Boolean)entityDetail.get('limitedInformationEntity');
        etty.Tax_Regime                    = (String)entityDetail.get('taxRegime');
        etty.Foreign_Entity                = booleanToYesNo((Boolean)entityDetail.get('foreignEntity'));
        etty.Nationality                   = (String)entityDetail.get('nationality');
        etty.Oracle_Account_Number         = (String)entityDetail.get('oracleAccountNumber');
        etty.CURP                          = (String)entityDetail.get('curp');
        etty.Prefix                        = (String)entityDetail.get('prefix');
        etty.First_Name                    = (String)entityDetail.get('firstName');
        etty.Middle_Name                   = (String)entityDetail.get('middleName');
        etty.First_Last_Name               = (String)entityDetail.get('firstLastName');
        etty.Second_Last_Name              = (String)entityDetail.get('secondLastName');
        etty.Sales_Representative          = (String)entityDetail.get('salesRepresentative');
        etty.Supplier_Flag                 = booleanToString((Boolean)entityDetail.get('supplierFlag'));
        etty.Legal_Name_sin_denominacion   = (String)entityDetail.get('legalName');
        etty.Company_Legal_Name_termination= (String)entityDetail.get('companyLegalNameTermination');        
        etty.Source_Created_by             = (String)entityDetail.get('sourceCreatedBy');
        etty.Source_Updated_by             = (String)entityDetail.get('sourceUpdatedBy');
        etty.Source_Application_ID         = (String)entityDetail.get('sourceApplicationID');
        //etty.Source_Create_Date          = (String)entityDetail.get('sourceCreateDate');
        //etty.Source_Last_Update_Date     = (String)entityDetail.get('sourceLastUpdateDate');
        etty.Target_Market_Jurisdiction    = (String)aml.get('targetMarketJurisdiction');
        etty.CRR                           = (String)aml.get('ccr');
        etty.CRR_Comments                  = (String)aml.get('crrComments');
        etty.CRR_Override                  = (String)aml.get('ccrOverride');
        etty.Entity_Type                   = (String)aml.get('entityType');
        etty.MRA_ID                        = String.isBlank((String)rating.get('mraId'))?'':(String)rating.get('mraId');
        etty.Bloomberg_ID                  = (String)rating.get('bloombergId');
        etty.HNWI_ID                       = String.isBlank((String)rating.get('hnwiId'))?'':(String)rating.get('hnwiId');
        etty.orRating                      = (String)rating.get('orRating');
        etty.SIC_Code                      = String.valueOf(sic.get('sicCode'));
        //etty.SIC_CodeId                    = (Id)getSicCodeId(etty.SIC_Code);
        this.sicCodeId                     = etty.SIC_CodeId;
        etty.SIC_Description               = (String)sic.get('sicDescription');
        etty.Economic_group_SIC_Code       = String.valueOf(sic.get('economicGroupSicCode'));
        etty.Economic_Group_SIC_Description = (String)sic.get('economicGroupSicDescription');
        etty.Customer_Alias                = (String)buro.get('customerAlias');
        etty.buroFlag                      = booleanToYesNo((Boolean)buro.get('buroFlag'));         
        return etty;       
    }    
    
    
    
    public EIV_AddressWrapClass responseToAddressObj(Map<String, Object> newAdd)
    {
        
        EIV_AddressWrapClass add = new EIV_AddressWrapClass();
        add.Location_ID = String.valueOf(newAdd.get('locationId'));
        add.party_ID = String.valueOf(newAdd.get('partyID'));
        add.Street = (String)newAdd.get('street');
        add.Outdoor_Number = (String)newAdd.get('outdoorNumber');
        add.Interior_Number = (String)newAdd.get('interiorNumber');
        add.County = (String)newAdd.get('county');
        add.Municipality = (String)newAdd.get('municipality');
        add.Country = (String)newAdd.get('country');        
        add.City = (String)newAdd.get('city');
        add.Zip_Code = (String)newAdd.get('zipCode');
        add.State = (String)newAdd.get('state');
        add.Status = (String)newAdd.get('status');
        add.Purpose = (String)newAdd.get('purpose');
        add.Source_Created_by = (String)newAdd.get('sourceCreatedBy');
        add.Source_Updated_by = (String)newAdd.get('sourceUpdatedBy');
        add.Source_Application_ID = (String)newAdd.get('sourceApplicationId');
        //add.Source_Create_Date = Datetime.valueOf(newAdd.get('sourceCreateDate'));
        //add.Source_Last_Update_Date = Datetime.valueOf(newAdd.get('sourceLastUpdateDate'));
        add.s_397 = (String)newAdd.get('_397');
        add.s_789 = (String)newAdd.get('_789');
        add.xa7 = (String)newAdd.get('xa7');
        add.s1u = (String)newAdd.get('s1u');
        add.addressReference = (String)newAdd.get('addressReference');
        add.addressLinesPhonetic = (String)newAdd.get('addressLinesPhonetic');
        add.normalizedAddress = (String)newAdd.get('normalizedAddress');
        return add;       
    }        
    
    public EIV_InvoicingWrapClass responseToInvoicingObj(Map<String, Object> newInv)
    {
        
        EIV_InvoicingWrapClass inv = new EIV_InvoicingWrapClass();
        inv.p_cust_acct_site_id = String.valueOf(newInv.get('custAcctSiteId'));
        inv.EC_Operating_Unit_Name = (String)newInv.get('ecOperatingUnitName');
        inv.EC_Operating_Unit_ID = String.valueOf(newInv.get('ecOperatingUnitId'));
        inv.EC_CLABE = (String)newInv.get('ecClabe');
        inv.EC_Payment_Account = (String)newInv.get('ecPaymentAccount');
        inv.Payment_Method = (String)newInv.get('paymentMethod');
        inv.Billing_Mails = (String)newInv.get('billingMails');
        inv.Source_Created_by = (String)newInv.get('sourceCreatedBy');
        inv.Source_Updated_by = (String)newInv.get('sourceUpdatedBy');
        inv.Source_Application_ID = (String)newInv.get('sourceApplicationId');
        //inv.Source_Create_Date = (String)newInv.get('sourceCreateDate');
        //inv.Source_Last_Update_Date = (String)newInv.get('sourceLastUpdateDate');
        return inv;       
    }        
    
    public EIV_ContactWrapClass responseToContactObj(Map<String, Object> newCont)
    {
        
        EIV_ContactWrapClass cont = new EIV_ContactWrapClass();
        
        cont.Contact_id = String.valueOf((Integer) newCont.get('contactId'));
        cont.party_ID = String.valueOf((Integer)newCont.get('partyID'));
        cont.Prefix = (String)newCont.get('prefix');
        cont.First_Name = (String)newCont.get('firstName');
        cont.First_Last_Name = (String)newCont.get('firstLastName');
        cont.middleName = (String)newCont.get('middleName');
        cont.secondLastName = (String)newCont.get('secondLastName');
        cont.title = (String)newCont.get('title');
        cont.Status = (String)newCont.get('status');
        cont.Country_code = (String)newCont.get('countryCode');
        cont.Area_code = (String)newCont.get('areaCode');
        cont.Phone = (String)newCont.get('phone');
        cont.Phone_number_extension = (String)newCont.get('phoneNumberExtension');
        cont.Mobile = (String)newCont.get('mobile');
        cont.Email = (String)newCont.get('email');
        cont.TypeContact = (String)newCont.get('type');
        cont.Source_Created_by = (String)newCont.get('sourceCreatedBy');
        cont.Source_Created_by = (String)newCont.get('sourceUpdatedBy');
        cont.Source_Created_by = (String)newCont.get('sourceApplicationId');
        //cont.Source_Created_by = (String)newCont.get('sourceCreateDate');
        //cont.Source_Created_by = (String)newCont.get('sourceLastUpdateDate');
        return cont;       
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
    
    
    public String nullToVoid(String text)
    {
        if(String.isBlank(text) )
            text='';
        return text;
    }
    
    public Boolean nullToBoolean(Boolean bbol)
    {
        if(bbol==null )
            return false;
        else
            return bbol;
    }    
    
    public String getCustomerName(String customerType)
    {
        String customerNameText = '';
        if(customerType == 'ORGANIZATION' )
        {
            customerNameText = this.entity.Legal_Name_sin_denominacion + this.entity.Company_Legal_Name_termination;
        }
        else if (customerType == 'INDIVIDUAL' )
        {
            customerNameText = nullToVoid(this.entity.First_Name) + ' ' + 
                nullToVoid(this.entity.Middle_Name) + ' ' + 
                nullToVoid(this.entity.First_Last_Name) + ' ' + 
                nullToVoid(this.entity.Second_Last_Name);
        }
        else
        {
            customerNameText = this.entity.Oracle_Account_Name;
        }
        
        return customerNameText;
    }    
    
    public String entityToJson()
    {
        JSONGenerator gen = JSON.createGenerator(true);    
        gen.writeStartObject();      
        gen.writeFieldName('entity');
        gen.writeStartObject();
        gen.writeStringField('sFaccountID' , sAccountId);
        gen.writeStringField('entityName' , ''); //Se enviara siempre vacio
        gen.writeStringField('entityType' , ''); //Se enviara siempre vacio
        gen.writeStringField('custAccountId' , ''); //Se enviara siempre vacio
        gen.writeStringField('partyID' ,nullToVoid(this.entity.Party_Id ));
        gen.writeStringField('rfc' , (yesNoToStringBoolean(this.entity.Foreign_Entity)=='false')?nullToVoid(this.entity.RFC ):'');
        gen.writeStringField('economicGroupPartyId' , ''); //Se enviara siempre vacio
        gen.writeStringField('customerName' , ''); //Se enviara siempre vacio
        gen.writeStringField('oracleAccountName' , nullToVoid(getCustomerName(this.entity.Customer_Type)));
        gen.writeStringField('customerType' , nullToVoid(this.entity.Customer_Type));
        gen.writeStringField('customerStatus' , ''); //Se enviara siempre vacio
        gen.writeStringField('topParentId' , nullToVoid(sAccountId));
        gen.writeStringField('topParentName' , nullToVoid(sAccountName));
        gen.writeStringField('sfAccountName' , nullToVoid(sAccountName));
        System.debug('this.entity.TIN OEJ:' +this.entity.TIN);
        System.debug('this.entity.TIN OEJ:' +this.entity.Foreign_Entity);
        
        gen.writeStringField('tin' , (yesNoToStringBoolean(this.entity.Foreign_Entity)=='true')?nullToVoid(this.entity.TIN):'');
        //gen.writeStringField('tin' , nullToVoid(this.entity.TIN));
        gen.writeStringField('economicGroupId' , nullToVoid(this.entity.Economic_Group_ID));
        gen.writeStringField('economicGroupName' , nullToVoid(this.entity.Economic_Group_Name));
        gen.writeBooleanField('limitedInformationEntity' ,    nullToBoolean( this.entity.Limited_information_entity)      );
        gen.writeStringField('taxRegime' , nullToVoid(this.entity.Tax_Regime));
        gen.writeStringField('foreignEntity' , yesNoToStringBoolean(this.entity.Foreign_Entity));
        gen.writeStringField('nationality' , nullToVoid(this.entity.Nationality));
        gen.writeStringField('oracleAccountNumber' , ''); //Se enviara siempre vacio
        gen.writeStringField('curp' , nullToVoid(this.entity.CURP));
        gen.writeStringField('prefix' , nullToVoid(this.entity.Prefix));
        gen.writeStringField('firstName' , nullToVoid(this.entity.First_Name));
        gen.writeStringField('middleName' , nullToVoid(this.entity.Middle_Name));
        gen.writeStringField('firstLastName' , nullToVoid(this.entity.First_Last_Name));
        gen.writeStringField('secondLastName' , nullToVoid(this.entity.Second_Last_Name));
        gen.writeStringField('salesRepresentative' , ''); //Se enviara siempre vacio
        gen.writeStringField('supplierFlag' , nullToVoid(this.entity.Supplier_Flag));
        gen.writeStringField('legalName' , nullToVoid(this.entity.Legal_Name_sin_denominacion));
        gen.writeStringField('companyLegalNameTermination' , nullToVoid(this.entity.Company_Legal_Name_termination));
        gen.writeStringField('sourceCreatedBy' , nullToVoid(this.sSSO));
        gen.writeStringField('sourceUpdatedBy' , nullToVoid(this.sSSO));
        gen.writeStringField('sourceApplicationID' , 'SF');
        gen.writeStringField('sourceCreateDate' , nullToVoid(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00')));
        gen.writeStringField('sourceLastUpdateDate' , nullToVoid(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00')));
        gen.writeFieldName('aml');
        gen.writeStartObject();        
        gen.writeStringField('targetMarketJurisdiction' , nullToVoid(this.entity.Target_Market_Jurisdiction  ));  
        gen.writeStringField('ccr' , nullToVoid(this.entity.CRR  ));    
        gen.writeStringField('crrComments' , nullToVoid(this.entity.CRR_Comments  ));    
        gen.writeStringField('ccrOverride' , nullToVoid(this.entity.CRR_Override  ));    
        gen.writeStringField('entityType' , nullToVoid(this.entity.Entity_Type  ));          
        gen.writeEndObject();
        gen.writeFieldName('rating');
        gen.writeStartObject();      
        gen.writeStringField('mraId' , nullToVoid(     ((this.entity.MRA_ID==null)?'':this.entity.MRA_ID)       ));
        gen.writeStringField('bloombergId' , nullToVoid(this.entity.Bloomberg_ID  )); 
        gen.writeStringField('hnwiId' , nullToVoid(     ((this.entity.HNWI_ID==null)?'':this.entity.HNWI_ID)       ));        
        gen.writeEndObject();
        gen.writeFieldName('sic');
        gen.writeStartObject(); 
        gen.writeStringField('sicCode' , nullToVoid(this.entity.SIC_Code  )); 
        gen.writeStringField('sicDescription' , nullToVoid(this.entity.SIC_Description  )); 
        gen.writeStringField('economicGroupSicCode' , nullToVoid(this.entity.Economic_group_SIC_Code  )); 
        gen.writeStringField('economicGroupSicDescription' , nullToVoid(this.entity.Economic_Group_SIC_Description  ));          
        gen.writeEndObject();
        gen.writeFieldName('buro');
        gen.writeStartObject(); 
        gen.writeStringField('customerAlias' , nullToVoid(this.entity.Customer_Alias  ));    
        gen.writeStringField('buroFlag' , nullToVoid(this.entity.buroFlag  ));             
        gen.writeEndObject();     
        gen.writeEndObject();    
        gen.writeEndObject(); 
        String jsonS = gen.getAsString();
        System.debug('Entity General OEJ: '+jsonS);         
        
        return jsonS;
    }
    
    
    public String addressToJson()
    {
        JSONGenerator gen = JSON.createGenerator(true); 
        gen.writeStartObject();      
        gen.writeFieldName('address');
        gen.writeStartObject();      
        gen.writeStringField('locationId' , nullToVoid(this.addressObj.Location_ID));
        gen.writeNumberField('partyID', Integer.valueOf(this.entity.Party_Id) );
        gen.writeStringField('street' , nullToVoid(this.addressObj.Street));
        gen.writeStringField('outdoorNumber' , nullToVoid(this.addressObj.Outdoor_Number));
        gen.writeStringField('interiorNumber' , nullToVoid(this.addressObj.Interior_Number));
        gen.writeStringField('county' , nullToVoid(this.addressObj.County));
        gen.writeStringField('municipality' , nullToVoid(this.addressObj.Municipality));
        gen.writeStringField('country' , nullToVoid(this.addressObj.Country));
        gen.writeStringField('city' , nullToVoid(this.addressObj.City));
        System.debug('nullToVoid(this.addressObj.Zip_Code) OEJ:' + nullToVoid(this.addressObj.Zip_Code));
        System.debug('this.addressObj.Zip_Code) OEJ:' + this.addressObj.Zip_Code);
        gen.writeStringField('zipCode' ,  zipCodeForMex(nullToVoid(this.addressObj.Country), nullToVoid(this.addressObj.Zip_Code))   );
        gen.writeStringField('state' ,  stateForMex(nullToVoid(this.addressObj.Country), nullToVoid(this.addressObj.State))   );
        gen.writeStringField('status'  , ''); //Se enviara siempre vacio
        gen.writeStringField('purpose' , nullToVoid(this.addressObj.Purpose));
        gen.writeStringField('sourceCreatedBy' , nullToVoid(sSSO));
        gen.writeStringField('sourceUpdatedBy' , nullToVoid(sSSO));
        gen.writeStringField('sourceApplicationId' , 'SF');
        gen.writeStringField('sourceCreateDate' , nullToVoid(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00')));
        gen.writeStringField('sourceLastUpdateDate' , nullToVoid(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00')) );
        gen.writeStringField('_397' , 'Y');
        gen.writeStringField('_789' , 'Y');
        gen.writeStringField('xa7' , 'Y');
        gen.writeStringField('s1u' , ''); //Se enviara siempre vacio
        gen.writeStringField('custAccountID' , ''); //Se enviara siempre vacio
        gen.writeStringField('addressReference' , ''); //Se enviara siempre vacio
        gen.writeStringField('addressLinesPhonetic' , ''); //Se enviara siempre vacio        
        gen.writeStringField('normalizedAddress' , ''); //Se enviara siempre vacio
        gen.writeStringField('identifyingAddressFlag' , ''); //Se enviara siempre vacio
        gen.writeEndObject();  
        gen.writeEndObject();
        String jsonS = gen.getAsString();
        System.debug('Address : ---'+jsonS); 
        return jsonS;
    }    
    
    public String contactToJson()
    {
        JSONGenerator gen = JSON.createGenerator(true);    
        gen.writeStartObject();      
        gen.writeFieldName('contact');
        gen.writeStartObject();         
        gen.writeStringField('partyContactId' , ''); //Se enviara siempre vacio
        gen.writeStringField('contactId' , nullToVoid(this.contactObj.Contact_id));
        gen.writeStringField('partyID' , nullToVoid(this.entity.party_ID));
        gen.writeStringField('prefix' , nullToVoid(this.contactObj.Prefix));
        gen.writeStringField('firstName' , nullToVoid(this.contactObj.First_Name));
        gen.writeStringField('middleName' , nullToVoid(this.contactObj.middleName));
        gen.writeStringField('secondLastName' , nullToVoid(this.contactObj.secondLastName));
        gen.writeStringField('firstLastName' , nullToVoid(this.contactObj.First_Last_Name));
        gen.writeStringField('title' , nullToVoid(this.contactObj.title));
        gen.writeStringField('status' , ''); //Se enviara siempre vacio
        gen.writeStringField('countryCode' , nullToVoid(this.contactObj.Country_Code));
        gen.writeStringField('areaCode' , nullToVoid(this.contactObj.Area_Code));
        gen.writeStringField('phone' , nullToVoid(this.contactObj.Phone));
        gen.writeStringField('phoneNumberExtension' , nullToVoid(this.contactObj.Phone_number_extension));
        gen.writeStringField('mobile' , nullToVoid(this.contactObj.Mobile));
        gen.writeStringField('email' , nullToVoid(this.contactObj.Email));
        gen.writeStringField('type' , nullToVoid(this.contactObj.TypeContact));
        gen.writeStringField('sourceCreatedBy' , nullToVoid(sSSO));
        gen.writeStringField('sourceUpdatedBy' , nullToVoid(sSSO));
        gen.writeStringField('sourceApplicationId' ,  'SF');
        gen.writeStringField('sourceCreateDate' , nullToVoid(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00')));
        gen.writeStringField('sourceLastUpdateDate' , nullToVoid(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00')));
        gen.writeEndObject(); 
        gen.writeEndObject();        
        String jsonS = gen.getAsString();
        System.debug('Contact : '+jsonS); 
        return jsonS;
    }        
    
    public String invoicingToJson()
    {
        system.debug('this.invoicingObj.EC_Operating_Unit_Name ' + this.invoicingObj.EC_Operating_Unit_Name);
        JSONGenerator gen = JSON.createGenerator(true);    
        gen.writeStartObject();      
        gen.writeFieldName('invoice');
        gen.writeStartObject(); 
        gen.writeStringField('custAcctSiteId' , nullToVoid(this.invoicingObj.p_cust_acct_site_id));
        gen.writeStringField('partyID' , ''); //Se enviara siempre vacio
        gen.writeStringField('invoiceId' , ''); //Se enviara siempre vacio
        gen.writeStringField('ecOperatingUnitName' , nullToVoid(this.invoicingObj.EC_Operating_Unit_Name));
        gen.writeStringField('ecOperatingUnitId' , ''); //Se enviara siempre vacio
        gen.writeStringField('ecClabe' , nullToVoid(this.invoicingObj.EC_CLABE));
        gen.writeStringField('ecPaymentAccount' , nullToVoid(this.invoicingObj.EC_Payment_Account));
        gen.writeStringField('paymentMethod' , nullToVoid(this.invoicingObj.Payment_Method));
        gen.writeStringField('billingMails' , nullToVoid(this.invoicingObj.Billing_Mails));
        gen.writeStringField('sourceCreatedBy' , nullToVoid(sSSO));
        gen.writeStringField('sourceUpdatedBy' , nullToVoid(sSSO));
        gen.writeStringField('sourceApplicationId' , 'SF');
        gen.writeStringField('sourceCreateDate' , nullToVoid(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00')));
        gen.writeStringField('sourceLastUpdateDate' , nullToVoid(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00')));
        gen.writeEndObject();    
        String jsonS = gen.getAsString();
        System.debug('Contact : '+jsonS); 
        return jsonS;
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
        if(servicio == 'getEntitysFromAccount') jsonResponse = EIV_EntityExtencionCalloutClass.callBackEntitiesOfTopParent(this.sTopParentId, sSSO,this.sServiceURL);
        if(servicio == 'getAllEntitys')
            jsonResponse = EIV_EntityExtencionCalloutClass.callBackllAllEconomicGroup(this.sServiceURL,TopParentIdSeleccionado);
        
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
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,this.detail.message));
            }
            
            
        }
        
    }   
    
    public EIV_PrivilegesWrapClass responseToPrivilegeObj(Map<String, Object> newPriv)
    {
        
        EIV_PrivilegesWrapClass priv = new EIV_PrivilegesWrapClass();
        priv.applicationCode               = (String)newPriv.get('applicationCode');
        priv.applicationName               = (String)newPriv.get('applicationName');
        priv.screen                        = (String)newPriv.get('screen');
        priv.sso                           = (String)newPriv.get('sso');
        priv.setvCrud((String)newPriv.get('vCrud')); 
        System.debug('Object Privileges OEJ:' +priv);
        return priv;               
    }
    
    public String getSicCodeId(String sSicCode)
    {
        
        try{
            TBO002_SIC_code__c sicCodeObj = [Select id, name, TBO002_tx_SIC_industry_description__c, TBO002_ls_SIC_industry__c from TBO002_SIC_code__c where name =:sSicCode][0];
            sSicCode = sicCodeObj.id;
            entity.SIC_Description = sicCodeObj.TBO002_tx_SIC_industry_description__c;
            
        }catch(exception e){
            System.debug('El id del sic code seleccionado no existe OEJ ' + sSicCode);
        }
        
        return sSicCode;
    }
    
    
    public EIV_EntityWrapClass responseToEntityObj(Map<String, Object> entityDetail)
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
        etty.Economic_Group_ID             = String.valueOf((Integer)entityDetail.get('economicGroupId'));
        etty.Economic_Group_Name           = (String)entityDetail.get('economicGroupName');
        etty.Limited_information_entity    = (Boolean)entityDetail.get('limitedInformationEntity');
        etty.Tax_Regime                    = (String)entityDetail.get('taxRegime');
        etty.Foreign_Entity                = booleanToYesNo((Boolean)entityDetail.get('foreignEntity'));
        etty.Nationality                   = (String)entityDetail.get('nationality');
        etty.Oracle_Account_Number         = (String)entityDetail.get('oracleAccountNumber');
        etty.CURP                          = (String)entityDetail.get('curp');
        etty.Prefix                        = (String)entityDetail.get('prefix');
        etty.First_Name                    = (String)entityDetail.get('firstName');
        etty.Middle_Name                   = (String)entityDetail.get('middleName');
        etty.First_Last_Name               = (String)entityDetail.get('firstLastName');
        etty.Second_Last_Name              = (String)entityDetail.get('secondLastName');
        etty.Sales_Representative          = (String)entityDetail.get('salesRepresentative');
        etty.Supplier_Flag                 = booleanToString((Boolean)entityDetail.get('supplierFlag'));
        etty.Legal_Name_sin_denominacion   = (String)entityDetail.get('legalName');
        etty.Company_Legal_Name_termination= (String)entityDetail.get('companyLegalNameTermination');        
        etty.Source_Created_by             = (String)entityDetail.get('sourceCreatedBy');
        etty.Source_Updated_by             = (String)entityDetail.get('sourceUpdatedBy');
        etty.Source_Application_ID         = (String)entityDetail.get('sourceApplicationID');
        //etty.Source_Create_Date          = (String)entityDetail.get('sourceCreateDate');
        //etty.Source_Last_Update_Date     = (String)entityDetail.get('sourceLastUpdateDate');
        etty.vfSNameRead                   = vfTypeEntitieRead(etty.Customer_Type);
        
        return etty;       
    }
    
    public void getdummyRequest()
    {
        requestList = new List<ES2_WraperRequest>();
        documentList = new List<ES2_WraperRequest>();
        comentList = new List<ES2_WraperRequest>();
        
        ES2_WraperRequest request = new ES2_WraperRequest();
        request.pOutRequestType = 'CREDITBUREAU';
        request.pOutRequestStatus = 'In Process';
        request.pOutRequestId = '987220';
        request.pOutPartyId = this.entity.Party_Id;
        requestList.add(request);
        request = new ES2_WraperRequest();
        request.pOutRequestType = 'AML';
        request.pOutRequestStatus = 'Closed';
        request.pOutRequestId = '987221';
        requestList.add(request);   
        request = new ES2_WraperRequest();
        request.pOutRequestType = 'COMENTARIOS';
        request.pOutRequestStatus = 'Este es un comentario con un poco de datos para mostrar como se veria el texto de un comentario, como se puede ver es bastante claro y se ve excelente!!!';
        request.pOutRequestId = '987222';
        comentList.add(request); 
        request = new ES2_WraperRequest();
        request.pOutRequestType = 'COMENTARIOS';
        request.pOutRequestStatus = 'Este es un comentario con un poco de datos para mostrar como se veria el texto de un comentario, como se puede ver es bastante claro y se ve excelente!!!';
        request.pOutRequestId = '987230';
        comentList.add(request); 
        
        request = new ES2_WraperRequest();
        request.pOutRequestType = 'DOCUMENTOS';
        request.pOutRequestStatus = 'Closed';
        request.pOutRequestId = '987223';
        documentList.add(request);  
        request = new ES2_WraperRequest();
        request.pOutRequestType = 'KYCPF';
        request.pOutRequestStatus = 'In Process';
        request.pOutRequestId = '987224';
        requestList.add(request);   
        request = new ES2_WraperRequest();
        request.pOutRequestType = 'KYCPM';
        request.pOutRequestStatus = 'In Process';
        request.pOutRequestId = '987225';
        requestList.add(request); 
        request = new ES2_WraperRequest();        
        request.pOutRequestType = 'NDA';
        request.pOutRequestStatus = 'In Process';
        request.pOutRequestId = '987226';
        requestList.add(request); 
        
    }
    public PageReference viewRequest()
    {
        PageReference pr;
        if(sIdTypeRequest == 'LEGAL ASSESSMENT' && entity.Customer_Type == 'INDIVIDUAL'){
            pr = new PageReference('/apex/ES5_ReadPage_Legal_Assessment_PF?requestId=' + this.sIdChild + '&sso=' + this.sSSO);
        }else if(sIdTypeRequest == 'LEGAL ASSESSMENT' && entity.Customer_Type == 'ORGANIZATION' && entity.Nationality == 'MEX'){
            pr = new PageReference('/apex/ES5_ReadPage_Legal_Assessment_PM?requestId=' + this.sIdChild + '&sso=' + this.sSSO);
        }else if(sIdTypeRequest == 'LEGAL ASSESSMENT' && entity.Customer_Type == 'ORGANIZATION' && entity.Nationality != 'MEX'){
            pr = new PageReference('/apex/ES5_ReadPage_Legal_Assessment_PME?requestId=' + this.sIdChild + '&sso=' + this.sSSO);
        }else{
            String vfp = [Select EIV_tx_parameter__c from EIV_Parameter__c where name =:this.sIdTypeRequest][0].EIV_tx_parameter__c;
        //redirigimos a la pagina de edición de AML
        pr = new PageReference('/apex/' + vfp + '?TopParentID=' + this.sTopParentId + 
                                             '&TopParentName=' + this.sTopParentName + 
                                             '&OracleAccountName=' + this.entity.Oracle_Account_Name +                                              
                                             '&PartyId=' + this.entity.Party_Id +
                                             '&sso=' + this.sSSO +
                                             '&requestId=' + this.sIdChild );
            
        }
        
        pr.setRedirect(true); //Pasamos el controlador vacio 
        return pr; 
    }
    
    @RemoteAction
    public static string downloadDoctos(string docId, string PartyId,string AccountId,string AccountName,string topParentId,string topParentName ){
        String URL_Servicio_Externa = Test.isRunningTest() ? 'https://ecoasdev01.engeniumcapital.com' :  [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='URL_Servicio_Externa'][0].EIV_tx_parameter__c; 
        string KeyEncriptation =Test.isRunningTest() ? '1234567890123456' : [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='KeyEncriptation'][0].EIV_tx_parameter__c; 
        string EncriptationType = Test.isRunningTest() ? 'AES128' :  [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='EncriptationType'][0].EIV_tx_parameter__c; 
        string UrlAppDoctos = Test.isRunningTest() ? 'https://ecoasdev01.engeniumcapital.com' :  [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='UrlAppDoctos'][0].EIV_tx_parameter__c; 
        
        
        Datetime dt = Datetime.now();
        Long l = dt.getTime();
        Long f = l ;
        system.debug(l);
        system.debug(f);
        
        string cddate = string.valueOf(DateTime.newInstance(f));
        
        string backUrl = System.Url.getSalesforceBaseURL().toExternalForm() + '/one/one.app#/alohaRedirect/apex/EIV_EntityReadPageIndividual?PartyId='+ PartyId+ '&AccountId='+ AccountId +'&AccountName='+ AccountName+'&TopParentID='+topParentId+ '&TopParentName='+topParentName;
        
        STRING clearText = 'contentDocId='+ docId + '&backUrl=' +backUrl +'&urlserver='+ URL_Servicio_Externa + '&cddate=' + cddate;
        Blob key = Blob.valueOf(KeyEncriptation);
        Blob textoEncB = Crypto.encryptWithManagedIV(EncriptationType, key, Blob.valueOf(clearText));
        String textoEnc = EncodingUtil.base64Encode(textoEncB);
        string encodedTextAES = UrlAppDoctos + '/xxec_episodioIVDocuments-vcDocuments-context-root/faces/documentDownloadFile.jspx?params=' + textoEnc;
        System.debug(encodedTextAES);
        return encodedTextAES;
    }
    
    
    public string quitaAnd(string s1){
        String regExp = '&';
        String replacement = '|';
        string s2=null;
        if(s1 != null){
            s2 = s1.replaceAll(regExp, replacement);
        }else{
            s2 =s1;
        }
        
        return s2;
    }
}