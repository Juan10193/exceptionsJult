public class ES2_Controller_KWYPersonaMoral {
    
    //public ES2_Wraper_AML   AMLObj     {get;set;}
    public ES2_WraperRequest req {get;set;}
    public EIV_DetailWrapClass detail                 {get;set;}
    public String TopParentName {get;set;}
    public String sServiceURL {get;set;}
    public string UrlAppDoctos {get;set;}
    public string EncriptationType {get;set;}
    public string KeyEncriptation {get;set;}
    public string URL_Servicio_Externa {get;set;}
    public String sSSO {get;set;}
    public string RFC {get;set;}
    public string RequestType {get;Set;}
    public string skycDetailType {get;Set;}
    public string OracleAcountName {get;set;}
    
    public String nameDoc 								{get;set;}
    public String idDoc 								{get;set;}
    public String requestIdDoc 							{get;set;} 
    public String partyIdDoc 							{get;set;}
    public string oraId									{get;set;}
    public string docType								{get;set;}

     //para descargar doctos
    public string docId  								{get;set;}
    public string docUrl								{get;set;}
    public string cddate								{get;set;}
    public boolean urlflag								{get;set;}
    public string backUrl								{get;set;}
    public list <string> doctypess {get;Set;}
    public string doctiposString {get;set;}
    
    //para encriptarURl
    public string encodedTextAES									{get;set;}

    //kyc expiracion
    public integer  cdEncuesta                                       {get;set;}
    
    
    //para borrar reg tablas
    public string idReg									{get;set;}
   
    public boolean sendbtn					{get;set;}
    public boolean aceptbtn					{get;set;}
    public boolean onhdbtn					{get;set;}
    public boolean reworkbtn				{get;set;}
    public boolean rejbtn					{get;set;}
    public boolean preaprbtn					{get;set;}
    public boolean aprbtn					{get;set;}
    public boolean cancelbtn				{get;set;}
   	public boolean btentitybtn					{get;set;}
    public boolean editbtn					{get;set;}
    public boolean Ncombtn				{get;set;}
    public boolean Ndocbtn				{get;set;}
    public boolean senddTocustomer    {get;set;}
    public boolean completedByC       {get;set;}
    
    public ES2_wraper_proveedoresRecursos provRecurso {get;set;}
    public ES2_wraper_cuentasbancarias bankT {get;set;}
    public ES2_wraper_composicionsocial capSoc {get;set;}
    public ES2_wraper_accionistaspm accpm {get;set;}
    public ES2_wraper_sociosfideicomisos sfidei {get;set;}
    public ES2_wraper_sociosPF spfisic {get;set;}
    public ES2_Wraper_socioAdminPor sAdmin {get;set;}
    public ES2_wraper_funcionariosPrincipales funcioP {get;set;}
    public ES2_wraper_grupoEmpresarial grupEm {get;set;}
   
    
    public ES2_Controller_KWYPersonaMoral()
    {
        this.req = new ES2_WraperRequest();
        this.req.pOutRequestId = (String)System.currentPageReference().getParameters().get('requestId');    
        this.OracleAcountName = (String) System.currentPageReference().getParameters().get('OracleAccountName');
        this.req.pOutPartyId = (String)System.currentPageReference().getParameters().get('PartyId');
        this.req.pOutSourceTopParentId = (String)System.currentPageReference().getParameters().get('TopParentID');
        this.TopParentName  = (String) System.currentPageReference().getParameters().get('TopParentName');
        this.sServiceURL = Test.isRunningTest() ? 'https://test.com' :  [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='URL_Servicio'][0].EIV_tx_parameter__c; 
        this.UrlAppDoctos = Test.isRunningTest() ? 'https://test.com' :  [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='UrlAppDoctos'][0].EIV_tx_parameter__c; 
        this.EncriptationType = Test.isRunningTest() ? 'AES128' :  [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='EncriptationType'][0].EIV_tx_parameter__c; 
        this.KeyEncriptation = Test.isRunningTest() ? 'https://test.com' :  [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='KeyEncriptation'][0].EIV_tx_parameter__c; 
        this.URL_Servicio_Externa = Test.isRunningTest() ? 'https://test.com' :  [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='URL_Servicio_Externa'][0].EIV_tx_parameter__c;
        this.sSSO = Test.isRunningTest() ? '9999' : [Select EmployeeNumber From User Where Id = :UserInfo.getUserId()][0].EmployeeNumber; 
        this.RequestType =(String) System.currentPageReference().getParameters().get('RequestType');
        this.RFC =(String)System.currentPageReference().getParameters().get('RFC');
        
        if ( String.isNotBlank(this.req.pOutRequestId) )
        {
            //es una consulta
            Map<string,object>jsonResponse =null;
            
            //jsonResponse = (Map<string,object>)JSON.deserializeUntyped(ES2_jsonDummy.entitymasterToJson());
            jsonResponse = Test.isRunningTest() ? new Map<string,object>() : EIV_EntityExtencionCalloutClass.callBackGetRequestDetailsOne(this.sSSO, 'SF', this.sServiceURL, this.req.pOutRequestId);
            Map<String, Object> mapRequests = Test.isRunningTest() ? new Map<String, Object>() : (Map<String, Object>)jsonResponse.get('requests');
            if(mapRequests==null)
            {
                System.debug('OEJ: No existen solicitudes requests que revisar');
            }   
            else
            {
                ES2_Controller_KWYPMoralFill rellena = new  ES2_Controller_KWYPMoralFill();
                
                list<ES2_WraperRequest> dts = new list<ES2_WraperRequest>();
                dts = Test.isRunningTest() ? new list<ES2_WraperRequest>() : rellena.rellenarHeader(mapRequests);
                if(dts.size()>0)
                { req = dts[0]; req.kwypmObj.pOutKYCOrgName=this.req.pOutPartyName;
                }
                
                
                yesnobtn();
                
                
            }
        }
        else if (String.isBlank(this.skycDetailType))
        {
            Map<string,object>jsonResponse =null;
            jsonResponse = (Map<string,object>)JSON.deserializeUntyped(ES2_jsonDummy.JsonnULO('KYC ORGANIZATION'));
            Map<String, Object> mapRequests = (Map<String, Object>)jsonResponse.get('requests');
            
            ES2_Controller_KWYPMoralFill rellena = new  ES2_Controller_KWYPMoralFill();
                
                list<ES2_WraperRequest> dts = new list<ES2_WraperRequest>();
                dts = rellena.rellenarHeader(mapRequests);
                if(dts.size()>0)
                {
                    req = dts[0];
                    req.kwypmObj.datosgObj.GDRFC = this.RFC;
                    this.req.pOutPartyName  = this.OracleAcountName;
                    req.pOutCreatedBy = sSSO;
                    req.pOutRequestedBy = sSSO;
                    req.pOutStartDate = System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00'));
                    req.pOutCreationDate =System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00'));
                    req.pOutRequestStatus = 'IN PROCESS';
                    req.pOutActiveFlag = 'Y';
                    req.kwypmObj.pOutKYCOrgName=this.req.pOutPartyName;
                    req.kwypmObj.datosgObj.kycOrgGDNacionality = (String) System.currentPageReference().getParameters().get('Nationality');
                    req.kwypmObj.datosgObj.GDActivity =(String) System.currentPageReference().getParameters().get('SIC');
                    req.kwypmObj.domiciliopObj.kycOrgAdrStreet = (String) System.currentPageReference().getParameters().get('Calle');
                    req.kwypmObj.domiciliopObj.kycOrgAdrOutNum= (String) System.currentPageReference().getParameters().get('Outnum');
                    req.kwypmObj.domiciliopObj.kycOrgAdrIntNum=  (String) System.currentPageReference().getParameters().get('Intnum');
                    req.kwypmObj.domiciliopObj.kycOrgAdrCounty= (String) System.currentPageReference().getParameters().get('County');
                    req.kwypmObj.domiciliopObj.kycOrgAdrMunicipality= (String) System.currentPageReference().getParameters().get('Municipality');
                    req.kwypmObj.domiciliopObj.kycOrgAdrCity= (String) System.currentPageReference().getParameters().get('City');
                    req.kwypmObj.domiciliopObj.kycOrgAdrState= (String) System.currentPageReference().getParameters().get('Estate');
                    req.kwypmObj.domiciliopObj.kycOrgIntAdrCountry = (String) System.currentPageReference().getParameters().get('Country');
                    req.kwypmObj.domiciliopObj.kycOrgIntAdrZipCode= (String) System.currentPageReference().getParameters().get('Zip'); 
                    
                    this.req.pOutPartyId = (String) System.currentPageReference().getParameters().get('PartyId');
                    this.req.pOutSourceTopParentId = (String) System.currentPageReference().getParameters().get('TopParentId');
                    this.req.pOutSourceTopParentName = (String) System.currentPageReference().getParameters().get('TopParentName');
                    this.req.pOutSourceAccountId = (String) System.currentPageReference().getParameters().get('AccountId');
                }      
        }    
        else
        {
             //Hacemos lo que necesitemos para las paginas pequeñas
            provRecurso = new ES2_wraper_proveedoresRecursos();
            bankT = new ES2_wraper_cuentasbancarias();
            capSoc = new ES2_wraper_composicionsocial();
            accpm = new ES2_wraper_accionistaspm();
            sfidei = new ES2_wraper_sociosfideicomisos();
            spfisic = new ES2_wraper_sociosPF();
            sAdmin = new ES2_Wraper_socioAdminPor();
            funcioP = new ES2_wraper_funcionariosPrincipales();
            grupEm = new ES2_wraper_grupoEmpresarial();
        }
    }
     public PageReference editKYCPMProvider()
    {
        //falta logica del guardado
        /////***////
        
         this.req.pOutRequestId = (String)System.currentPageReference().getParameters().get('requestId');
         PageReference pr = new PageReference('/apex/ES2_KYCcompany_NewProvider?TopParentID'+ this.req.pOutSourceTopParentId + '&PartyId='+ this.req.pOutPartyId +'&requestId='+this.req.pOutRequestId + '&kycDetailType=ORESOURCE');   
        
        
        provRecurso = new ES2_wraper_proveedoresRecursos();
        
        
        pr.setRedirect(false); //Pasamos el controlador vacio  
        return pr;        
    }
    
    
    
     public PageReference saveKYCPMProvider()
    {
        //falta logica del guardado
        /////***////
    
      JSONGenerator gen = JSON.createGenerator(true);    
        gen.writeStartObject();
        	gen.writeFieldName('kycHeader');
        		gen.writeStartObject();
        			gen.writeStringField('requestId', Test.isRunningTest() ? '12' : req.pOutRequestId);
        			gen.writeStringField('kycDetailType', 'ORESOURCE');
                    gen.writeStringField('createdBy', sSSO);
        			gen.writeStringField('creationDate', System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00')));
        			gen.writeStringField('updatedBy', sSSO);
        			gen.writeStringField('lastUpdateDate', System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00')));
        		gen.writeEndObject();
        		gen.writeFieldName('kycDetail');
        		gen.writeStartObject();
        		gen.writeFieldName('organization');
        			gen.writeStartObject();
        				gen.writeFieldName('personaMoralProveedorRecursos');
        					gen.writeStartObject();
        						gen.writeStringField('kycOrgResLegalName',Test.isRunningTest() ? 'Alva SA': provRecurso.pOutKYCOrgResLegalName);
        						gen.writeStringField('kycOrgResCountry',Test.isRunningTest() ?'Mexico' : provRecurso.pOutKYCOrgResCountry);
        						gen.writeStringField('kycOrgResRFC',Test.isRunningTest() ? 'ADSA123' : provRecurso.pOutKYCOrgResRFC);
        						gen.writeStringField('kycOrgResAddress',Test.isRunningTest() ? 'Calle Aldama' : provRecurso.pOutKYCOrgResAddress);
        						gen.writeStringField('kycOrgResFEASerialNo', Test.isRunningTest() ? '0001' : provRecurso.pOutKYCOrgResFEASerialNo);
        					gen.writeEndObject();
        			gen.writeEndObject();
        		gen.writeEndObject();
        
        PageReference pr;
        String jsonS = gen.getAsString();
        
         Map<string,object>jsonResponse=null;
        
        jsonResponse = EIV_EntityExtencionCalloutClass.postKYCDetail(jsonS, sServiceURL); 
        System.debug('postRequestDetail JJ: ' + jsonResponse);
        
         if (jsonResponse == null) //Error en ORACLE, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Oracle Server missing'));
            pr = new PageReference('/apex/ES2_KYCcompany_NewProvider');
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
                pr = new PageReference('/apex/ES2_ReadPage_KWYPersonaMoral?requestId=' + this.req.pOutRequestId );
                pr.setRedirect(true); //Recargamos el controlador  
                
            }
            else //Error en el salvado, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,this.detail.errorCode));
                pr = new PageReference('/apex/ES2_KYCcompany_NewProvider');
                pr.setRedirect(false); //Pasamos el controlador lleno  
            }
            
            
        }    
        return pr;             
        
        
    }
    
    public PageReference deleteProvider(){
         this.req.pOutRequestId = Test.isRunningTest() ? '' : (String)System.currentPageReference().getParameters().get('requestId');
         string creado = this.sSSO;
        this.sSSO = Test.isRunningTest() ? '6666' : [Select EmployeeNumber From User Where Id = :UserInfo.getUserId()][0].EmployeeNumber; 
        
         JSONGenerator gen = JSON.createGenerator(true);    
        gen.writeStartObject();
        	gen.writeFieldName('kycHeader');
        		gen.writeStartObject();
        			gen.writeStringField('requestId', req.pOutRequestId);
        			gen.writeStringField('kycDetailId', idReg);
        			gen.writeStringField('kycDetailType', 'ORESOURCE');
        			gen.writeStringField('activeFlag', 'N');
                    gen.writeStringField('createdBy', creado);
        			gen.writeStringField('creationDate', System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00')));
        			gen.writeStringField('updatedBy', sSSO);
        			gen.writeStringField('lastUpdateDate', System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00')));
        		gen.writeEndObject();
        gen.writeEndObject();
        
         PageReference pr;
        String jsonS = gen.getAsString();
        
         Map<string,object>jsonResponse=null;
        
        jsonResponse = EIV_EntityExtencionCalloutClass.postKYCDetail(jsonS, sServiceURL); 
        System.debug('postRequestDetail JJ: ' + jsonResponse);
        
         if (jsonResponse == null) //Error en ORACLE, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Oracle Server missing'));
            pr = new PageReference('/apex/ES2_ReadPage_KWYPersonaMoral');
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
                pr = new PageReference('/apex/ES2_ReadPage_KWYPersonaMoral?requestId=' + this.req.pOutRequestId);
                pr.setRedirect(true); //Recargamos el controlador  
                
            }
            else //Error en el salvado, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,this.detail.errorCode));
                pr = new PageReference('/apex/ES2_ReadPage_KWYPersonaMoral');
                pr.setRedirect(false); //Pasamos el controlador lleno  
            }
            
            
        }    
        return pr;             
        
        
    }
    
     public PageReference editKYCPMBANCK()
    {
        
        this.req.pOutRequestId = (String)System.currentPageReference().getParameters().get('requestId'); 
        PageReference pr = new PageReference('/apex/ES2_KYCcompany_NewCuentaBancaria?TopParentID='+ this.req.pOutSourceTopParentId + '&PartyId='+ this.req.pOutPartyId +'&requestId='+ req.pOutRequestId + '&kycDetailType=OBANKS');   
        
        
        bankT = new ES2_wraper_cuentasbancarias();
        
        
        pr.setRedirect(false); //Pasamos el controlador vacio  
        return pr;        
    }

    public PageReference saveKYCPMBANCK()
    {	
        JSONGenerator gen = JSON.createGenerator(true);    
        gen.writeStartObject();
        	gen.writeFieldName('kycHeader');
        		gen.writeStartObject();
        			gen.writeStringField('requestId', req.pOutRequestId);
        			gen.writeStringField('kycDetailType', 'OBANKS');
        			gen.writeStringField('activeFlag', 'Y');
                    gen.writeStringField('createdBy', sSSO);
        			gen.writeStringField('creationDate', System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00')));
        			gen.writeStringField('updatedBy', sSSO);
        			gen.writeStringField('lastUpdateDate', System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00')));
        		gen.writeEndObject();
        		gen.writeFieldName('kycDetail');
        		gen.writeStartObject();
        		gen.writeFieldName('organization');
        			gen.writeStartObject();
        				gen.writeFieldName('personaMoralCuentasBancarias');
        					gen.writeStartObject();
        						gen.writeStringField('kycOrgBankName', bankT.pOutKYCOrgBankName);
        						gen.writeStringField('kycOrgBankAccount', bankT.pOutKYCOrgBankAccount);
        						gen.writeStringField('kycOrgBankCountry', bankT.pOutKYCOrgBankCountry);
        					gen.writeEndObject();
        			gen.writeEndObject();
        gen.writeEndObject();
        
         PageReference pr;
        String jsonS = gen.getAsString();
        
         Map<string,object>jsonResponse=null;
        
        jsonResponse = EIV_EntityExtencionCalloutClass.postKYCDetail(jsonS, sServiceURL); 
        System.debug('postRequestDetail JJ: ' + jsonResponse);
        
         if (jsonResponse == null) //Error en ORACLE, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Oracle Server missing'));
            pr = new PageReference('/apex/ES2_KYCcompany_NewCuentaBancaria');
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
            // this.req.pOutRequestId = (string)jsonResponse.get('requestId');
            if(this.detail.description == 'S') //Exito en el salvado, pasamos a la pagina de lectura de la Entidad y recargamos el controlador
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,this.detail.message));
                pr = new PageReference('/apex/ES2_ReadPage_KWYPersonaMoral?requestId=' + this.req.pOutRequestId);
                pr.setRedirect(true); //Recargamos el controlador  
                
            }
            else //Error en el salvado, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,this.detail.errorCode));
                pr = new PageReference('/apex/ES2_KYCcompany_NewCuentaBancaria');
                pr.setRedirect(false); //Pasamos el controlador lleno  
            }
            
            
        }    
        return pr;             
        
        
       
    }
    
    public PageReference deleteBank(){
        this.req.pOutRequestId = Test.isRunningTest() ? '' : (String)System.currentPageReference().getParameters().get('requestId');
         string creado = this.sSSO;
        this.sSSO = Test.isRunningTest() ? '6666' : [Select EmployeeNumber From User Where Id = :UserInfo.getUserId()][0].EmployeeNumber; 

         JSONGenerator gen = JSON.createGenerator(true);    
        gen.writeStartObject();
        	gen.writeFieldName('kycHeader');
        		gen.writeStartObject();
        			gen.writeStringField('requestId', req.pOutRequestId);
        			gen.writeStringField('kycDetailId', idReg);
        			gen.writeStringField('kycDetailType', 'OBANKS');
        			gen.writeStringField('activeFlag', 'N');
                    gen.writeStringField('createdBy', creado);
        			gen.writeStringField('creationDate', System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00')));
        			gen.writeStringField('updatedBy', sSSO);
        			gen.writeStringField('lastUpdateDate', System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00')));
        		gen.writeEndObject();
        	
        gen.writeEndObject();
        
        
        PageReference pr;
        String jsonS = gen.getAsString();
        
         Map<string,object>jsonResponse=null;
        
        jsonResponse = EIV_EntityExtencionCalloutClass.postKYCDetail(jsonS, sServiceURL); 
        System.debug('postRequestDetail JJ: ' + jsonResponse);
        
         if (jsonResponse == null) //Error en ORACLE, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Oracle Server missing'));
            pr = new PageReference('/apex/ES2_ReadPage_KWYPersonaMoral');
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
                pr = new PageReference('/apex/ES2_ReadPage_KWYPersonaMoral?requestId=' + this.req.pOutRequestId);
                pr.setRedirect(true); //Recargamos el controlador  
                
            }
            else //Error en el salvado, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,this.detail.errorCode));
                pr = new PageReference('/apex/ES2_ReadPage_KWYPersonaMoral');
                pr.setRedirect(false); //Pasamos el controlador lleno  
            }
            
            
        }    
        return pr;             
        
        
        
        
        /*PageReference pr = new PageReference('/apex/ES2_ReadPage_KWYPersonaFisica?TopParentID=' + this.req.pOutSourceTopParentId + 
                                             '&TopParentName=' + this.TopParentName + 
                                             '&OracleAccountName=' + this.OracleAccountName +                                              
                                             '&PartyId=' + this.req.pOutPartyId + 
                                             '&requestId='+  this.req.pOutRequestId );*/
        
        
        
    }
    
       public PageReference send()
    {

        PageReference pr = saveStatusGeneral(req.pOutRequestStatus, 'PENDING' );
        return pr;        
    }   
       public PageReference sendToCustomer()
    {
        PageReference pr; 
        cdEncuesta = 604800000;
		urlflag = true;
        Datetime dt = Datetime.now();
		Long l = dt.getTime();
		Long f = l + cdEncuesta;
		system.debug(l);
		system.debug(f);
		
        cddate = string.valueOf(DateTime.newInstance(f));
        system.debug('Hora local: ' +  cddate);
        system.now();
        
        STRING clearText = 'requestId='+ req.pOutRequestId +'&sso=' +sSSO + '&urlserver='+ this.URL_Servicio_Externa;
        system.debug('texto a encriptar: ' + clearText);
        Blob key = Blob.valueOf(this.KeyEncriptation);
        Blob textoEncB = Crypto.encryptWithManagedIV(this.EncriptationType, key, Blob.valueOf(clearText));
        String textoEnc = EncodingUtil.base64Encode(textoEncB);
        encodedTextAES = this.UrlAppDoctos + '/xxec_episodioIVDocuments-vcDocuments-context-root/faces/encuestaSalesForce.jspx?params=' + textoEnc + '&cddate='+cddate;
        

        saveStatusGeneral(req.pOutRequestStatus, 'WAITING FOR CUSTOMER' );

        //se agregar el comentario con la url
        this.req.pOutRequestId =  Test.isRunningTest() ? this.req.pOutRequestId = 'Id654' : (String)System.currentPageReference().getParameters().get('requestId');
            JSONGenerator gen = JSON.createGenerator(true);
            gen.writeStartObject();
            gen.writeFieldName('requestComment');
            gen.writeStartObject();
            gen.writeStringField('requestId' , this.req.pOutRequestId);
            gen.writeStringField('comSection' , '');
            gen.writeStringField('comComment' ,'URL GENERADA: ' + encodedTextAES + ' Expira: ' + cddate);
            gen.writeStringField('comCreatedBy' ,  this.sSSO);
            gen.writeStringField('comCreationDate' ,  System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00')));
            gen.writeStringField('comUpdatedBy' , this.sSSO);
            gen.writeStringField('comLastUpdateDate' , System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00'))  );
            gen.writeEndObject(); 
            gen.writeEndObject(); 
            String jsonS = gen.getAsString();

            Map<String, Object> jsonResponse = null;
            jsonResponse = EIV_EntityExtencionCalloutClass.postComments(jsonS, sServiceURL);
            System.debug('jsonResponse OEJ:' + jsonResponse);
            if (jsonResponse == null) //Error en ORACLE, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Oracle Server missing'));
                pr = new PageReference('/apex/ES2_ReadPage_KWYPersonaMoral');
                pr.setRedirect(false); //Pasamos el controlador lleno 
            }
            else
            {
                //El resultado tiene status
                Map<String, Object> statusCreate = (Map<String, Object>)jsonResponse.get('status');
                System.debug('Received the following JSON response of status OEJ01:' + statusCreate);
                if(statusCreate != null)
                {
                    System.debug('Received the following JSON response of status.code OEJ01:' + (String)statusCreate.get('code'));
                    System.debug('Received the following JSON response of status.message OEJ01:' + (String)statusCreate.get('message'));
                    System.debug('Received the following JSON response of status.detail OEJ01:' + (String)statusCreate.get('detail')); 
                    
                    
                    if((String)statusCreate.get('detail') == 'S' ) //Exito en el salvado, pasamos a la pagina de lectura y recargamos el controlador
                    {
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,(String)statusCreate.get('code')));
                        pr = new PageReference('/apex/ES2_ReadPage_KWYPersonaMoral?&requestId='+ this.req.pOutRequestId);
                        pr.setRedirect(true); //Recargamos el controlador  
                        
                    }
                    else //Error en el salvado, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
                    {
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,(String)statusCreate.get('code')));
                        //pr = new PageReference('/apex/' + vfTypeEntitieEdit(this.entity.Customer_Type));
                        //pr.setRedirect(false); //Pasamos el controlador lleno  
                    }          
                }
            }
            return pr;
        }
       public PageReference completedByCustomer()
    {

        PageReference pr = saveStatusGeneral(req.pOutRequestStatus, 'COMPLETED BY CUSTOMER' );
        return pr;        
    }    

    
    public PageReference accept()
    {

        PageReference pr = saveStatusGeneral(req.pOutRequestStatus, 'IN PROCESS' );
        return pr;        
    }     
    public PageReference onHold()
    {

        PageReference pr = saveStatusGeneral(req.pOutRequestStatus, 'ON HOLD' );
        return pr;        
    }  
    public PageReference rework()
    {

        PageReference pr = saveStatusGeneral(req.pOutRequestStatus, 'REWORK' );
        return pr;        
    }  
    public PageReference reject()
    {
		ES2_controller_POSTjson ps = new ES2_controller_POSTjson();
        req.pOutEndDate = System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00'));
        String sJson = ps.postgeneral('KYC ORGANIZATION', req);
        PageReference pr = saveStatusGeneral(req.pOutRequestStatus, 'REJECTED' );
        return pr;        
    }  
    public PageReference preApprove()
    {

        PageReference pr = saveStatusGeneral(req.pOutRequestStatus, 'COMPLETED BY CUSTOMER' );
        return pr;        
    }      
    public PageReference approve()
    {
		ES2_controller_POSTjson ps = new ES2_controller_POSTjson();
        req.pOutEndDate = System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00'));
        String sJson = ps.postgeneral('KYC ORGANIZATION', req);
        PageReference pr = saveStatusGeneral(req.pOutRequestStatus, 'APPROVED' );
        return pr;        
    }  
    public PageReference cancel()
    {
		ES2_controller_POSTjson ps = new ES2_controller_POSTjson();
        req.pOutEndDate = System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00'));
        String sJson = ps.postgeneral('KYC ORGANIZATION', req);
        
        PageReference pr = saveStatusGeneral(req.pOutRequestStatus, 'CANCELLED BY REQUESTOR' );
        return pr;
		        
    }      
        public PageReference backToEntity()
    {
		//Revisamos que tipo de solicitud es, individual o organización
		//
        EIV_EntityExtendClassBis bis = new EIV_EntityExtendClassBis();
        bis.getDetailEntity( req.pOutPartyId );
        PageReference pr;
        if( String.isNotBlank(bis.entity.Customer_Type)) // Es una entidad valida
        {
            //pr = new PageReference('/apex/ES2_EditPage_NDA');
            pr = new PageReference('/apex/' + bis.vfTypeEntitieRead(bis.entity.Customer_Type) + '?CustomerType=' + bis.entity.Customer_Type + '&AccountId=' + '' + '&AccountName=' + '' + '&TopParentID=' + '' + '&TopParentName=' + '' + '&PartyId=' + req.pOutPartyId +  '&TargetMarket=');
            pr.setRedirect(true);
        }
        else //No existe el party ID
        {
            pr = new PageReference('/apex/ES2_EditPage_KWYPersonaMoral');
            pr.setRedirect(false);
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'No existe el Party ID de la entidad en Oracle'));
        }           
 
        return pr;        
    } 
    
    public PageReference saveStatusGeneral(String oldStatus, String sStatus)
    {
        //falta logica del guardado
        /////***////
        
        ES2_controller_POSTjson ps = new ES2_controller_POSTjson();

        req.pOutRequestStatus = sStatus;
        
        PageReference pr;
        String sJson = ps.postgeneral('KYC ORGANIZATION', req);
        		                       
        Map<string,object>jsonResponse=null;
        
        jsonResponse = EIV_EntityExtencionCalloutClass.postRequestDetail(sJson, sServiceURL); 
        System.debug('postRequestDetail JJ: ' + jsonResponse);
        
        if (jsonResponse == null) //Error en ORACLE, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Oracle Server missing'));
            req.pOutRequestStatus = oldStatus;
            pr = new PageReference('/apex/ES2_ReadPage_KWYPersonaMoral');
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
            this.req.pOutRequestId = string.valueOf( jsonResponse.get('requestId'));
            if(this.detail.description == 'S') //Exito en el salvado, pasamos a la pagina de lectura de la Entidad y recargamos el controlador
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,this.detail.message));
                pr = new PageReference('/apex/ES2_ReadPage_KWYPersonaMoral?requestId=' + this.req.pOutRequestId+ '&OracleAccountName=' +  this.req.pOutPartyName);
                pr.setRedirect(true); //Recargamos el controlador  
                
            }
            else //Error en el salvado, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,this.detail.errorCode));
                req.pOutRequestStatus = oldStatus;
                pr = new PageReference('/apex/ES2_ReadPage_KWYPersonaMoral');
                pr.setRedirect(false); //Pasamos el controlador lleno  
            }
            
            
        }    
        return pr;             
    }              
        
        
    public PageReference saveKYCPMP()
    {
        //falta logica del guardado
        /////***////
        
        ES2_controller_POSTjson ps = new ES2_controller_POSTjson();
        //Valores pó defecto
        
        req.pOutUpdatedBy = sSSO;
        req.pOutAssignedTo =sSSO;
        
        PageReference pr;
        String sJson = ps.postgeneral('KYC ORGANIZATION', req);
        		                       
        Map<string,object>jsonResponse=null;
        
        jsonResponse = EIV_EntityExtencionCalloutClass.postRequestDetail(sJson, sServiceURL); 
        System.debug('postRequestDetail JJ: ' + jsonResponse);
        
        if (jsonResponse == null) //Error en ORACLE, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Oracle Server missing'));
            pr = new PageReference('/apex/ES2_EditPage_KWYPersonaMoral');
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
            this.req.pOutRequestId = string.valueOf( jsonResponse.get('requestId'));
            if(this.detail.description == 'S') //Exito en el salvado, pasamos a la pagina de lectura de la Entidad y recargamos el controlador
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,this.detail.message));
                pr = new PageReference('/apex/ES2_ReadPage_KWYPersonaMoral?requestId=' + this.req.pOutRequestId+ '&OracleAccountName=' +  this.req.pOutPartyName);
                pr.setRedirect(true); //Recargamos el controlador  
                
            }
            else //Error en el salvado, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,this.detail.errorCode));
                pr = new PageReference('/apex/ES2_EditPage_KWYPersonaMoral');
                pr.setRedirect(false); //Pasamos el controlador lleno  
            }
            
            
        }    
        return pr;             
    }      
    
    public PageReference editKYCPM()
    {
        //falta logica del guardado
        /////***////
        
        PageReference pr = new PageReference('/apex/ES2_EditPage_KWYPersonaMoral?TopParentID=' + this.req.pOutSourceTopParentId + 
                                             '&TopParentName=' + this.TopParentName + 
                                             '&OracleAccountName=' + this.req.pOutPartyName  +  
                                             
                                             
                                             '&TopParentID=' + this.req.pOutSourceTopParentId + 
                                             
                                             '&PartyId=' + this.req.pOutPartyId + 
                                             '&requestId='+ this.req.pOutRequestId);
        pr.setRedirect(false); //Pasamos el controlador vacio  
        return pr;        
    }
    
    
    public PageReference editKYCPMCAPITALSOCIAL()
    {	 
         this.req.pOutRequestId = (String)System.currentPageReference().getParameters().get('requestId');
         PageReference pr = new PageReference('/apex/ES2_KYCcompany_NewAccionista?TopParentID'+ this.req.pOutSourceTopParentId + '&PartyId='+ this.req.pOutPartyId +'&requestId='+this.req.pOutRequestId + '&kycDetailType=OPARTNER_ORG');   
        
        
        capSoc = new ES2_wraper_composicionsocial();
        
        
        pr.setRedirect(false); //Pasamos el controlador vacio  
        return pr;        
    }
    
       public PageReference saveKYCPMCAPITALSOCIAL()
    {
        
              JSONGenerator gen = JSON.createGenerator(true);    
        gen.writeStartObject();
        	gen.writeFieldName('kycHeader');
        		gen.writeStartObject();
        			gen.writeStringField('requestId', req.pOutRequestId);
        			gen.writeStringField('kycDetailType', 'OPARTNER');
                    gen.writeStringField('createdBy', sSSO);
        			gen.writeStringField('creationDate', System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00')));
        			gen.writeStringField('updatedBy', sSSO);
        			gen.writeStringField('lastUpdateDate', System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00')));
        		gen.writeEndObject();
        		gen.writeFieldName('kycDetail');
        		gen.writeStartObject();
        		gen.writeFieldName('organization');
        			gen.writeStartObject();
        				gen.writeFieldName('personaMoralCapitalSocial');
        					gen.writeStartObject();
        						gen.writeStringField('kycOrgPartnerLegalName', capSoc.pOutKYCOrgPartnerLegalName);
        						gen.writeStringField('kycOrgPartnerCountry', capSoc.pOutKYCOrgPartnerCountry);
        						gen.writeStringField('kycOrgPartnerRFC', capSoc.pOutKYCOrgPartnerRFC);
        						gen.writeStringField('kycOrgPartnerPorcent', capSoc.pOutKYCOrgPartnerPorcent);
        					gen.writeEndObject();
        			gen.writeEndObject();
        gen.writeEndObject();
        
         PageReference pr;
        String jsonS = gen.getAsString();
        
         Map<string,object>jsonResponse=null;
        
        jsonResponse = EIV_EntityExtencionCalloutClass.postKYCDetail(jsonS, sServiceURL); 
        System.debug('postRequestDetail JJ: ' + jsonResponse);
        
         if (jsonResponse == null) //Error en ORACLE, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Oracle Server missing'));
            pr = new PageReference('/apex/ES2_KYCcompany_NewCuentaBancaria');
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
            // this.req.pOutRequestId = (string)jsonResponse.get('requestId');
            if(this.detail.description == 'S') //Exito en el salvado, pasamos a la pagina de lectura de la Entidad y recargamos el controlador
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,this.detail.message));
                pr = new PageReference('/apex/ES2_ReadPage_KWYPersonaMoral?requestId=' + this.req.pOutRequestId);
                pr.setRedirect(true); //Recargamos el controlador  
                
            }
            else //Error en el salvado, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,this.detail.errorCode));
                pr = new PageReference('/apex/ES2_KYCcompany_NewCuentaBancaria');
                pr.setRedirect(false); //Pasamos el controlador lleno  
            }
            
            
        }    
        return pr;             
        
        
    } 
    
    public PageReference deleteCapitalS(){
         this.req.pOutRequestId = Test.isRunningTest() ? '' : (String)System.currentPageReference().getParameters().get('requestId');
         string creado = this.sSSO;
        this.sSSO = Test.isRunningTest() ? '6666' : [Select EmployeeNumber From User Where Id = :UserInfo.getUserId()][0].EmployeeNumber; 
        
         JSONGenerator gen = JSON.createGenerator(true);    
        gen.writeStartObject();
        	gen.writeFieldName('kycHeader');
        		gen.writeStartObject();
        			gen.writeStringField('requestId', req.pOutRequestId);
        			gen.writeStringField('kycDetailId', idReg);
        			gen.writeStringField('kycDetailType', 'OPARTNER');
        			gen.writeStringField('activeFlag', 'N');
                    gen.writeStringField('createdBy', creado);
        			gen.writeStringField('creationDate', System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00')));
        			gen.writeStringField('updatedBy', sSSO);
        			gen.writeStringField('lastUpdateDate', System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00')));
        		gen.writeEndObject();
        gen.writeEndObject();
        
         PageReference pr;
        String jsonS = gen.getAsString();
        
         Map<string,object>jsonResponse=null;
        
        jsonResponse = EIV_EntityExtencionCalloutClass.postKYCDetail(jsonS, sServiceURL); 
        System.debug('postRequestDetail JJ: ' + jsonResponse);
        
         if (jsonResponse == null) //Error en ORACLE, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Oracle Server missing'));
            pr = new PageReference('/apex/ES2_ReadPage_KWYPersonaMoral');
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
                pr = new PageReference('/apex/ES2_ReadPage_KWYPersonaMoral?requestId=' + this.req.pOutRequestId);
                pr.setRedirect(true); //Recargamos el controlador  
                
            }
            else //Error en el salvado, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,this.detail.errorCode));
                pr = new PageReference('/apex/ES2_ReadPage_KWYPersonaMoral');
                pr.setRedirect(false); //Pasamos el controlador lleno  
            }
            
            
        }    
        return pr;             
        
        
    }
    
     public PageReference editKYCPMAcCM()
    {
       
        this.req.pOutRequestId = (String)System.currentPageReference().getParameters().get('requestId');
        PageReference pr = new PageReference('/apex/ES2_KYCcompany_NewACCMoral?TopParentID=' + this.req.pOutSourceTopParentId + '&PartyId='+ this.req.pOutPartyId +'&requestId='+this.req.pOutRequestId);   
      
        accpm = new ES2_wraper_accionistaspm();  
        
        pr.setRedirect(false); //Pasamos el controlador vacio  
        return pr;        
    }
    
        public PageReference saveACcMral()
    {
       JSONGenerator gen = JSON.createGenerator(true);    
        gen.writeStartObject();
        	gen.writeFieldName('kycHeader');
        		gen.writeStartObject();
        			gen.writeStringField('requestId', req.pOutRequestId);
        			gen.writeStringField('kycDetailType', 'OPARTNER_ORG');
        			gen.writeStringField('activeFlag', 'Y');
                    gen.writeStringField('createdBy', sSSO);
        			gen.writeStringField('creationDate', System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00')));
        			gen.writeStringField('updatedBy', sSSO);
        			gen.writeStringField('lastUpdateDate', System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00')));
        		gen.writeEndObject();
        		gen.writeFieldName('kycDetail');
        		gen.writeStartObject();
        		gen.writeFieldName('organization');
        			gen.writeStartObject();
        				gen.writeFieldName('personaMoralAoSPM');
        					gen.writeStartObject();
        						gen.writeStringField('kycOrgPartnerOrgLegalName', accpm.pOutKYCOrgPartnerOrgLegalName);
        						gen.writeStringField('kycOrgPartnerOrgCountry', accpm.pOutKYCOrgPartnerOrgCountry);
        						gen.writeStringField('kycOrgPartnerOrgRFC', accpm.pOutKYCOrgPartnerOrgRFC);
        						gen.writeStringField('kycOrgPartnerOrgPorcent', accpm.pOutKYCOrgPartnerOrgPorcent);
        					gen.writeEndObject();
        			gen.writeEndObject();
        gen.writeEndObject();
        
         PageReference pr;
        String jsonS = gen.getAsString();
        
         Map<string,object>jsonResponse=null;
        
        jsonResponse = EIV_EntityExtencionCalloutClass.postKYCDetail(jsonS, sServiceURL); 
        System.debug('postRequestDetail JJ: ' + jsonResponse);
        
         if (jsonResponse == null) //Error en ORACLE, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Oracle Server missing'));
            pr = new PageReference('/apex/ES2_KYCcompany_NewACCMoral');
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
            // this.req.pOutRequestId = (string)jsonResponse.get('requestId');
            if(this.detail.description == 'S') //Exito en el salvado, pasamos a la pagina de lectura de la Entidad y recargamos el controlador
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,this.detail.message));
                pr = new PageReference('/apex/ES2_ReadPage_KWYPersonaMoral?requestId=' + this.req.pOutRequestId);
                pr.setRedirect(true); //Recargamos el controlador  
                
            }
            else //Error en el salvado, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,this.detail.errorCode));
                pr = new PageReference('/apex/ES2_KYCcompany_NewACCMoral');
                pr.setRedirect(false); //Pasamos el controlador lleno  
            }
            
            
        }    
        return pr;             
        
        
    } 
    
    public PageReference deleteAccMoral(){
        this.req.pOutRequestId = Test.isRunningTest() ? '' : (String)System.currentPageReference().getParameters().get('requestId');
         string creado = this.sSSO;
        this.sSSO = Test.isRunningTest() ? '6666' : [Select EmployeeNumber From User Where Id = :UserInfo.getUserId()][0].EmployeeNumber; 
        
         JSONGenerator gen = JSON.createGenerator(true);    
        gen.writeStartObject();
        	gen.writeFieldName('kycHeader');
        		gen.writeStartObject();
        			gen.writeStringField('requestId', req.pOutRequestId);
        			gen.writeStringField('kycDetailId', idReg);
        			gen.writeStringField('kycDetailType', 'OPARTNER_ORG');
        			gen.writeStringField('activeFlag', 'N');
                    gen.writeStringField('createdBy', creado);
        			gen.writeStringField('creationDate', System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00')));
        			gen.writeStringField('updatedBy', sSSO);
        			gen.writeStringField('lastUpdateDate', System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00')));
        		gen.writeEndObject();
        gen.writeEndObject();
        
         PageReference pr;
        String jsonS = gen.getAsString();
        
         Map<string,object>jsonResponse=null;
        
        jsonResponse = EIV_EntityExtencionCalloutClass.postKYCDetail(jsonS, sServiceURL); 
        System.debug('postRequestDetail JJ: ' + jsonResponse);
        
         if (jsonResponse == null) //Error en ORACLE, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Oracle Server missing'));
            pr = new PageReference('/apex/ES2_ReadPage_KWYPersonaMoral');
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
                pr = new PageReference('/apex/ES2_ReadPage_KWYPersonaMoral?requestId=' + this.req.pOutRequestId);
                pr.setRedirect(true); //Recargamos el controlador  
                
            }
            else //Error en el salvado, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,this.detail.errorCode));
                pr = new PageReference('/apex/ES2_ReadPage_KWYPersonaMoral');
                pr.setRedirect(false); //Pasamos el controlador lleno  
            }
            
            
        }    
        return pr;             
        
        
    }
    
    public PageReference editKYCPMAcCFIdei()
    {
       
        this.req.pOutRequestId = (String)System.currentPageReference().getParameters().get('requestId');
        PageReference pr = new PageReference('/apex/ES2_KYCcompany_NewAccFideicomisos?TopParentID=' + this.req.pOutSourceTopParentId + '&PartyId='+ this.req.pOutPartyId +'&requestId='+this.req.pOutRequestId);   
        
       
        sfidei = new ES2_wraper_sociosfideicomisos();
        
        
        pr.setRedirect(false); //Pasamos el controlador vacio  
        return pr;        
    }
    
    	public PageReference saveACcFidei()
    {
        JSONGenerator gen = JSON.createGenerator(true);    
        gen.writeStartObject();
        	gen.writeFieldName('kycHeader');
        		gen.writeStartObject();
        			gen.writeStringField('requestId', req.pOutRequestId);
        			gen.writeStringField('kycDetailType', 'OTRUST');
        			gen.writeStringField('activeFlag', 'Y');
                    gen.writeStringField('createdBy', sSSO);
        			gen.writeStringField('creationDate', System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00')));
        			gen.writeStringField('updatedBy', sSSO);
        			gen.writeStringField('lastUpdateDate', System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00')));
        		gen.writeEndObject();
        		gen.writeFieldName('kycDetail');
        		gen.writeStartObject();
        		gen.writeFieldName('organization');
        			gen.writeStartObject();
        				gen.writeFieldName('personaMoralAoSF');
        					gen.writeStartObject();
        						gen.writeStringField('kycOrgTrustLegalName', sfidei.pOutKYCOrgTrustLegalName);
        						gen.writeStringField('kycOrgTrustCountry', sfidei.pOutKYCOrgTrustCountry);
        						gen.writeStringField('kycOrgTrustRFC', sfidei.pOutKYCOrgTrustRFC);
        						gen.writeStringField('kycOrgTrustPersons', sfidei.pOutKYCOrgTrustPersons);
        					gen.writeEndObject();
        			gen.writeEndObject();
        gen.writeEndObject();
        
         PageReference pr;
        String jsonS = gen.getAsString();
        
         Map<string,object>jsonResponse=null;
        
        jsonResponse = EIV_EntityExtencionCalloutClass.postKYCDetail(jsonS, sServiceURL); 
        System.debug('postRequestDetail JJ: ' + jsonResponse);
        
         if (jsonResponse == null) //Error en ORACLE, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Oracle Server missing'));
            pr = new PageReference('/apex/ES2_KYCcompany_NewAccFideicomisos');
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
            // this.req.pOutRequestId = (string)jsonResponse.get('requestId');
            if(this.detail.description == 'S') //Exito en el salvado, pasamos a la pagina de lectura de la Entidad y recargamos el controlador
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,this.detail.message));
                pr = new PageReference('/apex/ES2_ReadPage_KWYPersonaMoral?requestId=' + this.req.pOutRequestId);
                pr.setRedirect(true); //Recargamos el controlador  
                
            }
            else //Error en el salvado, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,this.detail.errorCode));
                pr = new PageReference('/apex/ES2_KYCcompany_NewAccFideicomisos');
                pr.setRedirect(false); //Pasamos el controlador lleno  
            }
            
            
        }    
        return pr;             
                 
    } 
    
    public PageReference deleteAccFidei(){
        this.req.pOutRequestId = Test.isRunningTest() ? '' : (String)System.currentPageReference().getParameters().get('requestId');
         string creado = this.sSSO;
        this.sSSO = Test.isRunningTest() ? '6666' : [Select EmployeeNumber From User Where Id = :UserInfo.getUserId()][0].EmployeeNumber; 
        
         JSONGenerator gen = JSON.createGenerator(true);    
        gen.writeStartObject();
        	gen.writeFieldName('kycHeader');
        		gen.writeStartObject();
        			gen.writeStringField('requestId', req.pOutRequestId);
        			gen.writeStringField('kycDetailId', idReg);
        			gen.writeStringField('kycDetailType', 'OTRUST');
        			gen.writeStringField('activeFlag', 'N');
                    gen.writeStringField('createdBy', creado);
        			gen.writeStringField('creationDate', System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00')));
        			gen.writeStringField('updatedBy', sSSO);
        			gen.writeStringField('lastUpdateDate', System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00')));
        		gen.writeEndObject();
        gen.writeEndObject();
        
         PageReference pr;
        String jsonS = gen.getAsString();
        
         Map<string,object>jsonResponse=null;
        
        jsonResponse = EIV_EntityExtencionCalloutClass.postKYCDetail(jsonS, sServiceURL); 
        System.debug('postRequestDetail JJ: ' + jsonResponse);
        
         if (jsonResponse == null) //Error en ORACLE, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Oracle Server missing'));
            pr = new PageReference('/apex/ES2_ReadPage_KWYPersonaMoral');
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
                pr = new PageReference('/apex/ES2_ReadPage_KWYPersonaMoral?requestId=' + this.req.pOutRequestId);
                pr.setRedirect(true); //Recargamos el controlador  
                
            }
            else //Error en el salvado, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,this.detail.errorCode));
                pr = new PageReference('/apex/ES2_ReadPage_KWYPersonaMoral');
                pr.setRedirect(false); //Pasamos el controlador lleno  
            }
            
            
        }    
        return pr;             
        
        
    }
    
    
     public PageReference editKYCPMAcCFIsic()
    {
        
        this.req.pOutRequestId = (String)System.currentPageReference().getParameters().get('requestId');
        PageReference pr = new PageReference('/apex/ES2_KYCcompany_NewAccPersonasFisicas?TopParentID=' + this.req.pOutSourceTopParentId + '&PartyId='+ this.req.pOutPartyId +'&requestId='+this.req.pOutRequestId);   
        
        spfisic = new ES2_wraper_sociosPF();
        
        
        pr.setRedirect(false); //Pasamos el controlador vacio  
        return pr;        
    }
    
    	public PageReference saveACcFIsic()
    {
          JSONGenerator gen = JSON.createGenerator(true);    
        gen.writeStartObject();
        	gen.writeFieldName('kycHeader');
        		gen.writeStartObject();
        			gen.writeStringField('requestId', req.pOutRequestId);
        			gen.writeStringField('kycDetailType', 'OPARTNER_IND');
        			gen.writeStringField('activeFlag', 'Y');
                    gen.writeStringField('createdBy', sSSO);
        			gen.writeStringField('creationDate', System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00')));
        			gen.writeStringField('updatedBy', sSSO);
        			gen.writeStringField('lastUpdateDate', System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00')));
        		gen.writeEndObject();
        		gen.writeFieldName('kycDetail');
        		gen.writeStartObject();
        		gen.writeFieldName('organization');
        			gen.writeStartObject();
        				gen.writeFieldName('personaMoralAoSPF');
        					gen.writeStartObject();
        						gen.writeStringField('kycOrgPartnerIndLegalName', spfisic.pOutKYCOrgPartnerIndLegalName);
        						gen.writeStringField('kycOrgPartnerIndCountry', spfisic.pOutKYCOrgPartnerIndCountry);
        						gen.writeStringField('kycOrgPartnerIndRFC', spfisic.pOutKYCOrgPartnerIndRFC);
        						gen.writeStringField('kycOrgPartnerIndPorcent', spfisic.pOutKYCOrgPartnerIndPorcent);
        					gen.writeEndObject();
        			gen.writeEndObject();
        gen.writeEndObject();
        
         PageReference pr;
        String jsonS = gen.getAsString();
        
         Map<string,object>jsonResponse=null;
        
        jsonResponse = EIV_EntityExtencionCalloutClass.postKYCDetail(jsonS, sServiceURL); 
        System.debug('postRequestDetail JJ: ' + jsonResponse);
        
         if (jsonResponse == null) //Error en ORACLE, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Oracle Server missing'));
            pr = new PageReference('/apex/ES2_KYCcompany_NewAccPersonasFisicas');
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
            // this.req.pOutRequestId = (string)jsonResponse.get('requestId');
            if(this.detail.description == 'S') //Exito en el salvado, pasamos a la pagina de lectura de la Entidad y recargamos el controlador
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,this.detail.message));
                pr = new PageReference('/apex/ES2_ReadPage_KWYPersonaMoral?requestId=' + this.req.pOutRequestId);
                pr.setRedirect(true); //Recargamos el controlador  
                
            }
            else //Error en el salvado, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,this.detail.errorCode));
                pr = new PageReference('/apex/ES2_KYCcompany_NewAccPersonasFisicas');
                pr.setRedirect(false); //Pasamos el controlador lleno  
            }
            
            
        }    
        return pr;             
                  
    } 
    
     public PageReference deleteAccFisica(){
        this.req.pOutRequestId = Test.isRunningTest() ? '' : (String)System.currentPageReference().getParameters().get('requestId');
         string creado = this.sSSO;
        this.sSSO = Test.isRunningTest() ? '6666' : [Select EmployeeNumber From User Where Id = :UserInfo.getUserId()][0].EmployeeNumber; 
        
         JSONGenerator gen = JSON.createGenerator(true);    
        gen.writeStartObject();
        	gen.writeFieldName('kycHeader');
        		gen.writeStartObject();
        			gen.writeStringField('requestId', req.pOutRequestId);
        			gen.writeStringField('kycDetailId', idReg);
        			gen.writeStringField('kycDetailType', 'OPARTNER_IND');
        			gen.writeStringField('activeFlag', 'N');
                    gen.writeStringField('createdBy', creado);
        			gen.writeStringField('creationDate', System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00')));
        			gen.writeStringField('updatedBy', sSSO);
        			gen.writeStringField('lastUpdateDate', System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00')));
        		gen.writeEndObject();
        gen.writeEndObject();
        
         PageReference pr;
        String jsonS = gen.getAsString();
        
         Map<string,object>jsonResponse=null;
        
        jsonResponse = EIV_EntityExtencionCalloutClass.postKYCDetail(jsonS, sServiceURL); 
        System.debug('postRequestDetail JJ: ' + jsonResponse);
        
         if (jsonResponse == null) //Error en ORACLE, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Oracle Server missing'));
            pr = new PageReference('/apex/ES2_ReadPage_KWYPersonaMoral');
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
                pr = new PageReference('/apex/ES2_ReadPage_KWYPersonaMoral?requestId=' + this.req.pOutRequestId);
                pr.setRedirect(true); //Recargamos el controlador  
                
            }
            else //Error en el salvado, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,this.detail.errorCode));
                pr = new PageReference('/apex/ES2_ReadPage_KWYPersonaMoral');
                pr.setRedirect(false); //Pasamos el controlador lleno  
            }
            
            
        }    
        return pr;             
        
        
    }
    
     public PageReference editKYCPMAAdmins()
    {
        this.req.pOutRequestId = (String)System.currentPageReference().getParameters().get('requestId');        
        PageReference pr = new PageReference('/apex/ES2_KYCcompany_NewMiembrosConsjAdmonAdmU?TopParentID=' + this.req.pOutSourceTopParentId + '&PartyId='+ this.req.pOutPartyId +'&requestId='+this.req.pOutRequestId);   
        
        
        sAdmin = new ES2_Wraper_socioAdminPor();
        
        
        pr.setRedirect(false); //Pasamos el controlador vacio  
        return pr;        
    }
    
    	public PageReference savePMAdmins()
    {
       
       JSONGenerator gen = JSON.createGenerator(true);    
        gen.writeStartObject();
        	gen.writeFieldName('kycHeader');
        		gen.writeStartObject();
        			gen.writeStringField('requestId', req.pOutRequestId);
        			gen.writeStringField('kycDetailType', 'OMANAGER');
        			gen.writeStringField('activeFlag', 'Y');
                    gen.writeStringField('createdBy', sSSO);
        			gen.writeStringField('creationDate', System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00')));
        			gen.writeStringField('updatedBy', sSSO);
        			gen.writeStringField('lastUpdateDate', System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00')));
        		gen.writeEndObject();
        		gen.writeFieldName('kycDetail');
        		gen.writeStartObject();
        		gen.writeFieldName('organization');
        			gen.writeStartObject();
        				gen.writeFieldName('personaMoralSA');
        					gen.writeStartObject();
        						gen.writeStringField('kycOrgBizManagerName', sAdmin.pOutKYCOrgBizManagerName);
        						gen.writeStringField('kycOrgBizManagerTitle', sAdmin.pOutKYCOrgBizManagerTitle);
        						gen.writeStringField('kycOrgBizManagerRFC', sAdmin.pOutKYCOrgBizManagerRFC);
        					gen.writeEndObject();
        			gen.writeEndObject();
        gen.writeEndObject();
        
         PageReference pr;
        String jsonS = gen.getAsString();
        
         Map<string,object>jsonResponse=null;
        
        jsonResponse = EIV_EntityExtencionCalloutClass.postKYCDetail(jsonS, sServiceURL); 
        System.debug('postRequestDetail JJ: ' + jsonResponse);
        
         if (jsonResponse == null) //Error en ORACLE, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Oracle Server missing'));
            pr = new PageReference('/apex/ES2_KYCcompany_NewMiembrosConsjAdmonAdmU');
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
            // this.req.pOutRequestId = (string)jsonResponse.get('requestId');
            if(this.detail.description == 'S') //Exito en el salvado, pasamos a la pagina de lectura de la Entidad y recargamos el controlador
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,this.detail.message));
                pr = new PageReference('/apex/ES2_ReadPage_KWYPersonaMoral?requestId=' + this.req.pOutRequestId);
                pr.setRedirect(true); //Recargamos el controlador  
                
            }
            else //Error en el salvado, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,this.detail.errorCode));
                pr = new PageReference('/apex/ES2_KYCcompany_NewMiembrosConsjAdmonAdmU');
                pr.setRedirect(false); //Pasamos el controlador lleno  
            }
            
            
        }    
        return pr;             
                  
    } 
    
    public PageReference deleteManagerOrg(){
        this.req.pOutRequestId = Test.isRunningTest() ? '' : (String)System.currentPageReference().getParameters().get('requestId');
         string creado = this.sSSO;
        this.sSSO = Test.isRunningTest() ? '6666' : [Select EmployeeNumber From User Where Id = :UserInfo.getUserId()][0].EmployeeNumber; 
        
         JSONGenerator gen = JSON.createGenerator(true);    
        gen.writeStartObject();
        	gen.writeFieldName('kycHeader');
        		gen.writeStartObject();
        			gen.writeStringField('requestId', req.pOutRequestId);
        			gen.writeStringField('kycDetailId', idReg);
        			gen.writeStringField('kycDetailType', 'OMANAGER');
        			gen.writeStringField('activeFlag', 'N');
                    gen.writeStringField('createdBy', creado);
        			gen.writeStringField('creationDate', System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00')));
        			gen.writeStringField('updatedBy', sSSO);
        			gen.writeStringField('lastUpdateDate', System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00')));
        		gen.writeEndObject();
        gen.writeEndObject();
        
         PageReference pr;
        String jsonS = gen.getAsString();
        
         Map<string,object>jsonResponse=null;
        
        jsonResponse = EIV_EntityExtencionCalloutClass.postKYCDetail(jsonS, sServiceURL); 
        System.debug('postRequestDetail JJ: ' + jsonResponse);
        
         if (jsonResponse == null) //Error en ORACLE, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Oracle Server missing'));
            pr = new PageReference('/apex/ES2_ReadPage_KWYPersonaMoral');
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
                pr = new PageReference('/apex/ES2_ReadPage_KWYPersonaMoral?requestId=' + this.req.pOutRequestId);
                pr.setRedirect(true); //Recargamos el controlador  
                
            }
            else //Error en el salvado, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,this.detail.errorCode));
                pr = new PageReference('/apex/ES2_ReadPage_KWYPersonaMoral');
                pr.setRedirect(false); //Pasamos el controlador lleno  
            }
            
            
        }    
        return pr;             
        
        
    }
    
     public PageReference editKYCPMFunciP()
    {
       
        this.req.pOutRequestId = (String)System.currentPageReference().getParameters().get('requestId');        
        PageReference pr = new PageReference('/apex/ES2_KYCcompany_NewFuncioPrincipales?TopParentID=' + this.req.pOutSourceTopParentId + '&PartyId='+ this.req.pOutPartyId +'&requestId='+this.req.pOutRequestId);   
         
         funcioP = new ES2_wraper_funcionariosPrincipales();
        
        pr.setRedirect(false); //Pasamos el controlador vacio  
        return pr;        
    }
    
    
    	public PageReference savePMFuncioP()
    {
        JSONGenerator gen = JSON.createGenerator(true);    
        gen.writeStartObject();
        	gen.writeFieldName('kycHeader');
        		gen.writeStartObject();
        			gen.writeStringField('requestId', req.pOutRequestId);
        			gen.writeStringField('kycDetailType', 'OMAIN');
       				gen.writeStringField('activeFlag', 'Y');
                    gen.writeStringField('createdBy', sSSO);
        			gen.writeStringField('creationDate', System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00')));
        			gen.writeStringField('updatedBy', sSSO);
        			gen.writeStringField('lastUpdateDate', System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00')));
        		gen.writeEndObject();
        		gen.writeFieldName('kycDetail');
        		gen.writeStartObject();
        		gen.writeFieldName('organization');
        			gen.writeStartObject();
        				gen.writeFieldName('personaMoralFP');
        					gen.writeStartObject();
        						gen.writeStringField('kycOrgBizMainName', funcioP.pOutKYCOrgBizMainTitle);
        						gen.writeStringField('kycOrgBizMainTitle', funcioP.pOutKYCOrgBizMainName);
        						gen.writeStringField('kycOrgBizMainRFC', funcioP.pOutKYCOrgBizMainRFC);
        					gen.writeEndObject();
        			gen.writeEndObject();
        gen.writeEndObject();
        
         PageReference pr;
        String jsonS = gen.getAsString();
        
         Map<string,object>jsonResponse=null;
        
        jsonResponse = EIV_EntityExtencionCalloutClass.postKYCDetail(jsonS, sServiceURL); 
        System.debug('postRequestDetail JJ: ' + jsonResponse);
        
         if (jsonResponse == null) //Error en ORACLE, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Oracle Server missing'));
            pr = new PageReference('/apex/ES2_KYCcompany_NewFuncioPrincipales');
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
            // this.req.pOutRequestId = (string)jsonResponse.get('requestId');
            if(this.detail.description == 'S') //Exito en el salvado, pasamos a la pagina de lectura de la Entidad y recargamos el controlador
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,this.detail.message));
                pr = new PageReference('/apex/ES2_ReadPage_KWYPersonaMoral?requestId=' + this.req.pOutRequestId);
                pr.setRedirect(true); //Recargamos el controlador  
                
            }
            else //Error en el salvado, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,this.detail.errorCode));
                pr = new PageReference('/apex/ES2_KYCcompany_NewFuncioPrincipales');
                pr.setRedirect(false); //Pasamos el controlador lleno  
            }
            
            
        }    
        return pr;             
                    
    } 
    
     public PageReference deleteFuncionarioPrin(){
        this.req.pOutRequestId = Test.isRunningTest() ? '' : (String)System.currentPageReference().getParameters().get('requestId');
         string creado = this.sSSO;
        this.sSSO = Test.isRunningTest() ? '6666' : [Select EmployeeNumber From User Where Id = :UserInfo.getUserId()][0].EmployeeNumber; 
        
         JSONGenerator gen = JSON.createGenerator(true);    
        gen.writeStartObject();
        	gen.writeFieldName('kycHeader');
        		gen.writeStartObject();
        			gen.writeStringField('requestId', req.pOutRequestId);
        			gen.writeStringField('kycDetailId', idReg);
        			gen.writeStringField('kycDetailType', 'OMAIN');
        			gen.writeStringField('activeFlag', 'N');
                    gen.writeStringField('createdBy', creado);
        			gen.writeStringField('creationDate', System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00')));
        			gen.writeStringField('updatedBy', sSSO);
        			gen.writeStringField('lastUpdateDate', System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00')));
        		gen.writeEndObject();
        gen.writeEndObject();
        
         PageReference pr;
        String jsonS = gen.getAsString();
        
         Map<string,object>jsonResponse=null;
        
        jsonResponse = EIV_EntityExtencionCalloutClass.postKYCDetail(jsonS, sServiceURL); 
        System.debug('postRequestDetail JJ: ' + jsonResponse);
        
         if (jsonResponse == null) //Error en ORACLE, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Oracle Server missing'));
            pr = new PageReference('/apex/ES2_ReadPage_KWYPersonaMoral');
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
                pr = new PageReference('/apex/ES2_ReadPage_KWYPersonaMoral?requestId=' + this.req.pOutRequestId);
                pr.setRedirect(true); //Recargamos el controlador  
                
            }
            else //Error en el salvado, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,this.detail.errorCode));
                pr = new PageReference('/apex/ES2_ReadPage_KWYPersonaMoral');
                pr.setRedirect(false); //Pasamos el controlador lleno  
            }
            
            
        }    
        return pr;             
        
        
    }
    
    
    
      public PageReference editKYCPMConsorcio()
    {
        this.req.pOutRequestId = (String)System.currentPageReference().getParameters().get('requestId');        
        PageReference pr = new PageReference('/apex/ES2_KYCcompany_NewGrupoEmpresarialoCon?TopParentID=' + this.req.pOutSourceTopParentId + '&PartyId='+ this.req.pOutPartyId +'&requestId='+this.req.pOutRequestId);   
        
        grupEm = new ES2_wraper_grupoEmpresarial();
        
       
        
        pr.setRedirect(false); //Pasamos el controlador vacio  
        return pr;        
    }
    
    
     	public PageReference savePMconsorcio()
    {
        JSONGenerator gen = JSON.createGenerator(true);    
        gen.writeStartObject();
        	gen.writeFieldName('kycHeader');
        		gen.writeStartObject();
        			gen.writeStringField('requestId', req.pOutRequestId);
        			gen.writeStringField('kycDetailType', 'OCORPORATION');
        			gen.writeStringField('activeFlag', 'Y');
                    gen.writeStringField('createdBy', sSSO);
        			gen.writeStringField('creationDate', System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00')));
        			gen.writeStringField('updatedBy', sSSO);
        			gen.writeStringField('lastUpdateDate', System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00')));
        		gen.writeEndObject();
        		gen.writeFieldName('kycDetail');
        		gen.writeStartObject();
        		gen.writeFieldName('organization');
        			gen.writeStartObject();
        				gen.writeFieldName('personaMoralGE');
        					gen.writeStartObject();
        						gen.writeStringField('kycOrgCorpLegalName', grupEm.pOutKYCOrgCorpLegalName);
        						gen.writeStringField('kycOrgCorpCountry', grupEm.pOutKYCOrgCorpCountry);
        						gen.writeStringField('kycOrgCorpAddress', grupEm.pOutKYCOrgCorpAddress);
        						gen.writeStringField('kycOrgCorpObjective', grupEm.pOutKYCOrgCorpObjective);
        						gen.writeStringField('kycOrgCorpPercent', grupEm.pOutKYCOrgCorpPercent);
        					gen.writeEndObject();
        			gen.writeEndObject();
        gen.writeEndObject();
        
         PageReference pr;
        String jsonS = gen.getAsString();
        
         Map<string,object>jsonResponse=null;
        
        jsonResponse = EIV_EntityExtencionCalloutClass.postKYCDetail(jsonS, sServiceURL); 
        System.debug('postRequestDetail JJ: ' + jsonResponse);
        
         if (jsonResponse == null) //Error en ORACLE, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Oracle Server missing'));
            pr = new PageReference('/apex/ES2_KYCcompany_NewGrupoEmpresarialoCon');
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
            // this.req.pOutRequestId = (string)jsonResponse.get('requestId');
            if(this.detail.description == 'S') //Exito en el salvado, pasamos a la pagina de lectura de la Entidad y recargamos el controlador
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,this.detail.message));
                pr = new PageReference('/apex/ES2_ReadPage_KWYPersonaMoral?requestId=' + this.req.pOutRequestId);
                pr.setRedirect(true); //Recargamos el controlador  
                
            }
            else //Error en el salvado, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,this.detail.errorCode));
                pr = new PageReference('/apex/ES2_KYCcompany_NewGrupoEmpresarialoCon');
                pr.setRedirect(false); //Pasamos el controlador lleno  
            }
            
            
        }    
        return pr;             
                    
    } 
   
    public PageReference deleteConsorcio(){
        this.req.pOutRequestId = Test.isRunningTest() ? '' : (String)System.currentPageReference().getParameters().get('requestId');
         string creado = this.sSSO;
        this.sSSO = Test.isRunningTest() ? '6666' : [Select EmployeeNumber From User Where Id = :UserInfo.getUserId()][0].EmployeeNumber; 
        
         JSONGenerator gen = JSON.createGenerator(true);    
        gen.writeStartObject();
        	gen.writeFieldName('kycHeader');
        		gen.writeStartObject();
        			gen.writeStringField('requestId', req.pOutRequestId);
        			gen.writeStringField('kycDetailId', idReg);
        			gen.writeStringField('kycDetailType', 'OCORPORATION');
        			gen.writeStringField('activeFlag', 'N');
                    gen.writeStringField('createdBy', creado);
        			gen.writeStringField('creationDate', System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00')));
        			gen.writeStringField('updatedBy', sSSO);
        			gen.writeStringField('lastUpdateDate', System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00')));
        		gen.writeEndObject();
        gen.writeEndObject();
        
         PageReference pr;
        String jsonS = gen.getAsString();
        
         Map<string,object>jsonResponse=null;
        
        jsonResponse = EIV_EntityExtencionCalloutClass.postKYCDetail(jsonS, sServiceURL); 
        System.debug('postRequestDetail JJ: ' + jsonResponse);
        
         if (jsonResponse == null) //Error en ORACLE, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Oracle Server missing'));
            pr = new PageReference('/apex/ES2_ReadPage_KWYPersonaMoral');
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
                pr = new PageReference('/apex/ES2_ReadPage_KWYPersonaMoral?requestId=' + this.req.pOutRequestId);
                pr.setRedirect(true); //Recargamos el controlador  
                
            }
            else //Error en el salvado, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,this.detail.errorCode));
                pr = new PageReference('/apex/ES2_ReadPage_KWYPersonaMoral');
                pr.setRedirect(false); //Pasamos el controlador lleno  
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
    public PageReference newcoment()
    {
        //falta logica del guardado
        /////***////
        
        PageReference pr = new PageReference('/apex/ES2_EditPage_ADD_COMENTARIOS?TopParentID=' + this.req.pOutSourceTopParentId + 
                                             '&TopParentName=' + this.TopParentName + 
                                             '&PartyId='+this.req.pOutPartyId+
                                             '&OracleAccountName=' + this.req.pOutPartyName  +
                                             '&requestId=' + this.req.pOutRequestId +
                                             '&dir=kycpm');
        pr.setRedirect(false); //Pasamos el controlador vacio  
        return pr;        
    }
    
    public PageReference printPDF()
    {

        PageReference pr = saveStatusGeneral(req.pOutRequestStatus, 'PRINT PDF' );
        return pr;        
    }   
    
  public PageReference recarga(){
        PageReference pr;
        pr= new PageReference('/apex/ES2_ReadPage_KWYPersonaMoral?requestId=' + req.pOutRequestId + '&sso' + sSSO);
        pr.setRedirect(true);
        return pr;
    }

    @RemoteAction
    public static string deleteDocument(string requestIdDoc, string oraId,string docUrl,string docType,string docId,string nameDoc, string requestId)
    {
        System.debug('ids------->' + requestIdDoc +' '+ oraId+ ' ' + docUrl+ ' '+ docType + ' '+ docId + ' ' + nameDoc);
        //ES2_Controller_DOCUMENTOS controller = new ES2_Controller_DOCUMENTOS();
        
        //String resultado = controller.DeleteDocs(req.pOutPartyId , requestIdDoc, nameDoc, idDoc);
        //String resultado = Test.isRunningTest() ? 'vacio' : controller.DeleteDocs(req.pOutPartyId, requestIdDoc, nameDoc, idDoc, req.pOutSourceAccountId , req.pOutSourceTopParentId ,req.pOutSourceTopParentName, req.pOutPartyName, req.pOutEGPartyId, req.pOutEGPartyName);
        string resultado = ES2_Controller_DOCUMENTOS.deleteDoc(requestIdDoc, oraId, docUrl, docType, docId, nameDoc);
        system.debug('recibimos OEJ ' + resultado);
        string a='';
        
        //Error en ORACLE, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
        if (resultado.contains('ERROR')) 
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,resultado));
             a='ERROR';
        }
        else
        {
            string backUrl = System.Url.getSalesforceBaseURL().toExternalForm() + '/one/one.app#/alohaRedirect/apex/ES2_ReadPage_KWYPersonaMoral?requestId='+ requestId;
            //ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,this.detail.message));
            //pr = new PageReference('/apex/ES2_ReadPage_KWYPersonaFisica?requestId=' + req.pOutRequestId + '&sso' + sSSO);
            a=backUrl;
        } 
        return a;
    }
    

    @RemoteAction  
    public static string  newdocument(string DocTypesObj, string requestId, string partyId, String pOutEGPartyName,string sso)
    {
        
        String URL_Servicio_Externa = Test.isRunningTest() ? 'https://test.com' :  [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='URL_Servicio_Externa'][0].EIV_tx_parameter__c; 
        string KeyEncriptation =Test.isRunningTest() ? 'https://test.com' : [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='KeyEncriptation'][0].EIV_tx_parameter__c; 
        string EncriptationType = Test.isRunningTest() ? 'AES128' :  [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='EncriptationType'][0].EIV_tx_parameter__c; 
        string UrlAppDoctos = Test.isRunningTest() ? 'https://test.com' :  [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='UrlAppDoctos'][0].EIV_tx_parameter__c; 
        string backUrl = System.Url.getSalesforceBaseURL().toExternalForm() + '/one/one.app#/alohaRedirect/apex/ES2_ReadPage_KWYPersonaMoral?requestId='+ requestId;
       

       
		
        Datetime dt = Datetime.now();
		Long l = dt.getTime();
		Long f = l ;
		system.debug(l);
		system.debug(f);
		
        string cddate = string.valueOf(DateTime.newInstance(f));
        system.debug('Hora local: ' +  cddate);
        

        STRING clearText = 'requestId='+ requestId + '&documentType=['+DocTypesObj +']&partyId='+ partyId + '&partyName=' + pOutEGPartyName + '&sso=' +sso + '&urlserver='+ URL_Servicio_Externa + '&backUrl=' +backUrl + '&cddate=' + cddate;
        System.debug('url sin enc-----><'+ clearText);
        Blob key = Blob.valueOf(KeyEncriptation);
        Blob textoEncB = Crypto.encryptWithManagedIV(EncriptationType, key, Blob.valueOf(clearText));
        String textoEnc = EncodingUtil.base64Encode(textoEncB);
        string encodedTextAES = UrlAppDoctos + '/xxec_episodioIVDocuments-vcDocuments-context-root/faces/documentUploadFile.jspx?params=' + textoEnc ;
        return encodedTextAES;
    }

    @RemoteAction
    public static string downloadDoctos(string docId, string RequestId){
     	String URL_Servicio_Externa = Test.isRunningTest() ? 'https://test.com' :  [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='URL_Servicio_Externa'][0].EIV_tx_parameter__c; 
        string KeyEncriptation =Test.isRunningTest() ? 'https://test.com' : [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='KeyEncriptation'][0].EIV_tx_parameter__c; 
        string EncriptationType = Test.isRunningTest() ? 'AES128' :  [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='EncriptationType'][0].EIV_tx_parameter__c; 
        string UrlAppDoctos = Test.isRunningTest() ? 'https://test.com' :  [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='UrlAppDoctos'][0].EIV_tx_parameter__c; 
          

        Datetime dt = Datetime.now();
		Long l = dt.getTime();
		Long f = l ;
		system.debug(l);
		system.debug(f);
		
        string cddate = string.valueOf(DateTime.newInstance(f));
       
        string backUrl = System.Url.getSalesforceBaseURL().toExternalForm() + '/one/one.app#/alohaRedirect/apex/ES2_ReadPage_KWYPersonaMoarl?requestId='+ RequestId;
        
        STRING clearText = 'contentDocId='+ docId + '&backUrl=' +backUrl +'&urlserver='+ URL_Servicio_Externa + '&cddate=' + cddate;
        Blob key = Blob.valueOf(KeyEncriptation);
        Blob textoEncB = Crypto.encryptWithManagedIV(EncriptationType, key, Blob.valueOf(clearText));
        String textoEnc = EncodingUtil.base64Encode(textoEncB);
        string encodedTextAES = UrlAppDoctos + '/xxec_episodioIVDocuments-vcDocuments-context-root/faces/documentDownloadFile.jspx?params=' + textoEnc;
        System.debug(encodedTextAES);
        return encodedTextAES;
    }
    
     //public PageReference backToEntity()
    //{
        
        //PageReference pr = new PageReference('/apex/' + vfTypeEntitieRead(this.entity.Customer_Type));
       // PageReference pr = new PageReference('/apex/' + vfTypeEntitieRead(this.Customer_Type) + '?CustomerType=' + this.Customer_Type + '&AccountId=' + this.sAccountId + '&AccountName=' + this.sAccountName + '&TopParentID=' + this.sTopParentId + '&TopParentName=' + this.sTopParentName + '&PartyId=' + this.PartyId +  '&TargetMarket=' + this.sTargetMarket);
        //system.debug('OEJ looog:' + 'CMT: '+this.Customer_Type + 'ACID: ' +this.sAccountId + 'ACNM: ' + this.sAccountName + 'TopParentID: ' +  this.sTopParentId + 'PartyId: ' + this.KWYPMROBJ.pOutPartyId + 'TargetMarket: ' + this.sTargetMarket );
        //pr.setRedirect(false); //Pasamos el controlador lleno
        //if(String.isBlank(this.KWYPMROBJ.pOutPartyId)) //no existe party ID al cual regresar, regresamos a las cuentas
          //  pr = new PageReference('/' + this.sAccountId);
       // pr.setRedirect(false); //recargamos el controlador         
        //return pr;
              
    public  PageReference CancelTable()
    {
       PageReference pr = new PageReference('/apex/ES2_ReadPage_KWYPersonaMoral?requestId=' + this.req.pOutRequestId);
                pr.setRedirect(true); //Recargamos el controlador  
        return pr;
    }
    
   
     public boolean cambia(string p){
        if(p == '10000'){
            return true;
        }else{
            return false; 
        }
    }
    public void yesnobtn(){
        /*public boolean sendbtn					{get;set;}
    public boolean aceptbtn					{get;set;}
    public boolean onhdbtn					{get;set;}
    public boolean reworkbtn				{get;set;}
    public boolean rejbtn					{get;set;}
    public boolean preaprbtn					{get;set;}
    public boolean aprbtn					{get;set;}
    public boolean cancelbtn				{get;set;}
   	public boolean btentitybtn					{get;set;}
    public boolean editbtn					{get;set;}
    public boolean Ncombtn				{get;set;}
    public boolean Ndocbtn				{get;set;}*/
        system.debug('lo que me llega de privilage'+ req.privilegeObj);
        integer i = req.privilegeObj.size();
        system.debug('tamaño del arreglo' + i);
        for(integer a=0;a<i;a++){
            if(req.privilegeObj[a].section == 'PENDING'){
                sendbtn = cambia(req.privilegeObj[a].vCrud);
            }
            else if(req.privilegeObj[a].section == 'IN PROCESS'){
                aceptbtn = cambia(req.privilegeObj[a].vCrud);
            }
            else if(req.privilegeObj[a].section == 'ON HOLD'){
                onhdbtn = cambia(req.privilegeObj[a].vCrud);
            }
            else if(req.privilegeObj[a].section == 'REWORK'){
                reworkbtn = cambia(req.privilegeObj[a].vCrud);
            }
            else if(req.privilegeObj[a].section == 'REJECTED'){
                rejbtn = cambia(req.privilegeObj[a].vCrud);
            }
            else if(req.privilegeObj[a].section == 'PRE APPROVED'){
                preaprbtn = cambia(req.privilegeObj[a].vCrud);
            }
            else if(req.privilegeObj[a].section == 'APPROVED'){
               aprbtn = cambia(req.privilegeObj[a].vCrud);
            }
            else if(req.privilegeObj[a].section == 'AUTO APPROVED'){
                reworkbtn = cambia(req.privilegeObj[a].vCrud);
            }
            else if(req.privilegeObj[a].section == 'CANCELLED BY REQUESTOR'){
                cancelbtn = cambia(req.privilegeObj[a].vCrud);
            }
            else if(this.req.privilegeObj[a].section == 'WAITING FOR CUSTOMER'){
                senddTocustomer = cambia(req.privilegeObj[a].vCrud);
            }else if(req.privilegeObj[a].section == 'EDIT'){
                editbtn = cambia(req.privilegeObj[a].vCrud);
            }else if(req.privilegeObj[a].section == 'NEW DOCUMENT'){
                Ndocbtn = cambia(req.privilegeObj[a].vCrud);
            }else if(req.privilegeObj[a].section == 'NEW COMMENT'){
                Ncombtn = cambia(req.privilegeObj[a].vCrud);
            }else if(req.privilegeObj[a].section == 'COMPLETED BY CUSTOMER'){
                completedByC = cambia(req.privilegeObj[a].vCrud);
            }else{
                system.debug('no tengo parametros');
            }
        }
    }
    
    public boolean passvalue(string a){
        if(a == 'Y'){
            return true;
        }else{
            return false;
        }
    } 
    
    

     public void doctypesList(){
        this.doctypess = new list<string>();
        for(integer i=0; i<=req.DocTypesObj.size()-1; i++){
            string docname = req.DocTypesObj[i].name;
            
            
            doctypess.add(docname);
            
            
        }
        
        
        doctiposString =string.join(doctypess, (','));   
    }

    public void passUrlback(){
        backUrl = ApexPages.currentPage().getParameters().get('one');
        
    }
 }