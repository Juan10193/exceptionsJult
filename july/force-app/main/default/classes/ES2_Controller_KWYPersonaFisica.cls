public class ES2_Controller_KWYPersonaFisica {
   
    //public ES2_Wraper_AML   AMLObj     {get;set;}
    public ES2_WraperRequest req {get;set;}
    public EIV_DetailWrapClass detail                 {get;set;}
    public String OracleAccountName {get;set;}
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
    public string customertype {get;set;}
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
    
    //para borrar registros tabla
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
    
    
    public ES2_wraper_proveedorRecurso provRecurso {get;Set;}
    
    public ES2_Controller_KWYPersonaFisica()
    {
        this.req = new ES2_WraperRequest();
        this.req.pOutRequestId = Test.isRunningTest() ? '' : (String)System.currentPageReference().getParameters().get('requestId');    
        this.OracleAccountName = (String) System.currentPageReference().getParameters().get('OracleAccountName');
        this.req.pOutPartyId = Test.isRunningTest() ? 'PartyId' : (String)System.currentPageReference().getParameters().get('PartyId');
        this.req.pOutSourceTopParentId = (String)System.currentPageReference().getParameters().get('TopParentID');
        this.TopParentName  = (String) System.currentPageReference().getParameters().get('TopParentName');
        this.sServiceURL = Test.isRunningTest() ? 'https://test.com' :  [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='URL_Servicio'][0].EIV_tx_parameter__c;
         this.UrlAppDoctos = Test.isRunningTest() ? 'https://test.com' :  [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='UrlAppDoctos'][0].EIV_tx_parameter__c; 
        this.EncriptationType = Test.isRunningTest() ? 'AES128' :  [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='EncriptationType'][0].EIV_tx_parameter__c; 
        this.KeyEncriptation = Test.isRunningTest() ? 'https://test.com' :  [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='KeyEncriptation'][0].EIV_tx_parameter__c; 
        this.URL_Servicio_Externa = Test.isRunningTest() ? 'https://test.com' :  [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='URL_Servicio_Externa'][0].EIV_tx_parameter__c; 
        this.sSSO = [Select EmployeeNumber From User Where Id = :UserInfo.getUserId()][0].EmployeeNumber; 
        this.RequestType =(String) System.currentPageReference().getParameters().get('RequestType');
        this.skycDetailType = Test.isRunningTest() ? '' : (String) System.currentPageReference().getParameters().get('kycDetailType');
        this.RFC =(String)System.currentPageReference().getParameters().get('RFC');
        this.customertype = (String)System.currentPageReference().getParameters().get('CustomerType');
        if ( String.isNotBlank(this.req.pOutRequestId) && String.isBlank(this.skycDetailType) )
        {
            //es una consulta
            Map<string,object>jsonResponse =null;
            
            //jsonResponse = (Map<string,object>)JSON.deserializeUntyped(ES2_jsonDummy.entitymasterToJson());
            jsonResponse = EIV_EntityExtencionCalloutClass.callBackGetRequestDetailsOne(this.sSSO, 'SF', this.sServiceURL, this.req.pOutRequestId);
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
                {
                    req = dts[0];
                    
                }
                
                yesnobtn();
                
                
                
            }
        }
        else if (String.isBlank(this.skycDetailType))
        {
            Map<string,object>jsonResponse =null;
            jsonResponse = (Map<string,object>)JSON.deserializeUntyped(ES2_jsonDummy.JsonnULO('KYC Individual'));
            Map<String, Object> mapRequests = (Map<String, Object>)jsonResponse.get('requests');
            
            ES2_Controller_KWYPMoralFill rellena = new  ES2_Controller_KWYPMoralFill();
                
                list<ES2_WraperRequest> dts = new list<ES2_WraperRequest>();
                dts = rellena.rellenarHeader(mapRequests);
                if(dts.size()>0)
                {
                    req = dts[0];
                    req.kwypfObj.datosObj.GDRFC = this.RFC;
                    req.pOutPartyName  = this.OracleAccountName;
                    req.pOutCreatedBy = sSSO;
                    req.pOutRequestedBy = sSSO;
                    req.pOutStartDate = System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00'));
                    req.pOutCreationDate =System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00'));
                    req.pOutRequestStatus = 'IN PROCESS';
                    req.pOutActiveFlag = 'Y';
                    req.kwypfObj.pOutKYCIndName= this.req.pOutPartyName;
                    req.kwypfObj.datosObj.GDNacionalities = (String) System.currentPageReference().getParameters().get('Nationality');
                    req.kwypfObj.dominioObj.pOutKYCIndAdrStreet = (String) System.currentPageReference().getParameters().get('Calle');
                    req.kwypfObj.dominioObj.pOutKYCIndAdrOutNum = (String) System.currentPageReference().getParameters().get('Outnum');
                    req.kwypfObj.dominioObj.pOutKYCIndAdrIntNum = (String) System.currentPageReference().getParameters().get('Intnum');
                    req.kwypfObj.dominioObj.pOutKYCIndAdrCounty = (String) System.currentPageReference().getParameters().get('County');
                    req.kwypfObj.dominioObj.pOutKYCIndAdrMunicipality = (String) System.currentPageReference().getParameters().get('Municipality');
                    req.kwypfObj.dominioObj.pOutKYCIndAdrCity = (String) System.currentPageReference().getParameters().get('City');
                    req.kwypfObj.dominioObj.pOutKYCIndAdrState = (String) System.currentPageReference().getParameters().get('Estate');
                    req.kwypfObj.dominioObj.pOutKYCIndAdrCountry = (String) System.currentPageReference().getParameters().get('Country');
                    req.kwypfObj.dominioObj.pOutKYCIndIntAdrZipCode = (String) System.currentPageReference().getParameters().get('Zip');
                    
                    this.req.pOutPartyId = Test.isRunningTest() ? 'PartyId' : (String) System.currentPageReference().getParameters().get('PartyId');
                    this.req.pOutSourceTopParentId = Test.isRunningTest() ? 'TopParentId' : (String) System.currentPageReference().getParameters().get('TopParentId');
                    this.req.pOutSourceTopParentName = Test.isRunningTest() ? 'TopParentName' : (String) System.currentPageReference().getParameters().get('TopParentName');
                    this.req.pOutSourceAccountId = Test.isRunningTest() ? 'AccountId' : (String) System.currentPageReference().getParameters().get('AccountId');


                }
                
        } 
        else
        {
            //Hacemos lo que necesitemos para las paginas pequeñas
            provRecurso = new ES2_wraper_proveedorRecurso();
            
        }
    }



    public PageReference recarga(){
        PageReference pr;
        pr= new PageReference('/apex/ES2_ReadPage_KWYPersonaFisica?requestId=' + req.pOutRequestId + '&sso' + sSSO);
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
            string backUrl = System.Url.getSalesforceBaseURL().toExternalForm() + '/one/one.app#/alohaRedirect/apex/ES2_ReadPage_KWYPersonaFisica?requestId='+ requestId;
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
        string backUrl = System.Url.getSalesforceBaseURL().toExternalForm() + '/one/one.app#/alohaRedirect/apex/ES2_ReadPage_KWYPersonaFisica?requestId='+ requestId;
       

       
		
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
       
        string backUrl = System.Url.getSalesforceBaseURL().toExternalForm() + '/one/one.app#/alohaRedirect/apex/ES2_ReadPage_KWYPersonaFisica?requestId='+ RequestId;
        
        STRING clearText = 'contentDocId='+ docId + '&backUrl=' +backUrl +'&urlserver='+ URL_Servicio_Externa + '&cddate=' + cddate;
        Blob key = Blob.valueOf(KeyEncriptation);
        Blob textoEncB = Crypto.encryptWithManagedIV(EncriptationType, key, Blob.valueOf(clearText));
        String textoEnc = EncodingUtil.base64Encode(textoEncB);
        string encodedTextAES = UrlAppDoctos + '/xxec_episodioIVDocuments-vcDocuments-context-root/faces/documentDownloadFile.jspx?params=' + textoEnc;
        System.debug(encodedTextAES);
        return encodedTextAES;
    }
    
    public PageReference newKYCPFrovider()
    {
        
        this.req.pOutRequestId= (String)System.currentPageReference().getParameters().get('requestId');
        PageReference pr = new PageReference('/apex/ES2_KYC_Person_NewProvider?TopParentID='+ this.req.pOutSourceTopParentId + '&PartyId='+ this.req.pOutPartyId +'&requestId='+this.req.pOutRequestId + '&kycDetailType=IRESOURCE');   

        
        provRecurso = new ES2_wraper_proveedorRecurso();
        
        
        pr.setRedirect(false); //Pasamos el controlador vacio  
        return pr;        
    }
    
    public PageReference printPDF()
    {

        PageReference pr = saveStatusGeneral(req.pOutRequestStatus, 'PRINT PDF' );
        return pr;        
    }   
    
   public PageReference saveKYCPF()
    {
         ES2_controller_POSTjson ps = new ES2_controller_POSTjson();
        //Valores pó defecto
        req.pOutUpdatedBy = sSSO;
        req.pOutAssignedTo =sSSO;
        PageReference pr;
        String sJson = ps.postgeneral('KYC INDIVIDUAL', req);
        
         Map<string,object>jsonResponse=null;
        
        jsonResponse = EIV_EntityExtencionCalloutClass.postRequestDetail(sJson, sServiceURL); 
        System.debug('postRequestDetail JJ: ' + jsonResponse);
        
        if (jsonResponse == null) //Error en ORACLE, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Oracle Server missing'));
            pr = new PageReference('/apex/ES2_EditPage_KWYPersonaFisica');
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
            this.req.pOutRequestId = string.valueOf(jsonResponse.get('requestId'));
            if(this.detail.description == 'S') //Exito en el salvado, pasamos a la pagina de lectura de la Entidad y recargamos el controlador
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,this.detail.message));
                pr = new PageReference('/apex/ES2_ReadPage_KWYPersonaFisica?requestId=' + this.req.pOutRequestId + '&OracleAccountName=' + this.req.pOutPartyName + '&PartyId=' + this.req.pOutPartyId + '&TopParentName=' + this.req.pOutSourceTopParentName);
                pr.setRedirect(true); //Recargamos el controlador  
                
            }
            else //Error en el salvado, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,this.detail.errorCode));
                pr = new PageReference('/apex/ES2_EditPage_KWYPersonaFisica');
                pr.setRedirect(false); //Pasamos el controlador lleno  
            }
            
            
        }    
        return pr;             
       
    }
    public PageReference editKYCPF()
    {
        
        PageReference pr = new PageReference('/apex/ES2_EditPage_KWYPersonaFisica?TopParentID=' + this.req.pOutSourceTopParentId + 
                                             '&TopParentName=' + this.TopParentName + 
                                             '&OracleAccountName=' + this.OracleAccountName +                                              
                                             '&PartyId=' + this.req.pOutPartyId + 
                                             '&requestId='+  this.req.pOutRequestId);
        pr.setRedirect(false); //Pasamos el controlador vacio  
        return pr;        
    }      
    
    public PageReference saveProvider()
    {
      	this.req.pOutRequestId = Test.isRunningTest() ? '' : (String)System.currentPageReference().getParameters().get('requestId');
        this.sSSO = Test.isRunningTest() ? '6666' : [Select EmployeeNumber From User Where Id = :UserInfo.getUserId()][0].EmployeeNumber; 

        JSONGenerator gen = JSON.createGenerator(true);    
        gen.writeStartObject();
        	gen.writeFieldName('kycHeader');
        		gen.writeStartObject();
        			gen.writeStringField('requestId', req.pOutRequestId);
        			//gen.writeStringField('kycDetailId',req.)
        			gen.writeStringField('kycDetailType', 'IRESOURCE');
        			gen.writeStringField('activeFlag', 'Y');
                    gen.writeStringField('createdBy', sSSO);
        			gen.writeStringField('creationDate', System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00')));
        			gen.writeStringField('updatedBy', sSSO);
        			gen.writeStringField('lastUpdateDate', System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00')));
        		gen.writeEndObject();
        	gen.writeFieldName('kycDetail');
        		gen.writeStartObject();
        		gen.writeFieldName('individual');
        			gen.writeStartObject();
        				gen.writeFieldName('personaFisicaProveedorRecursos');
        					gen.writeStartObject();
        						gen.writeStringField('kycIndResLegalName', provRecurso.pOutKYCIndResLegalName);
        						gen.writeStringField('kycIndResCountry', provRecurso.pOutKYCIndResCountry);
        						gen.writeStringField('kycIndResRFC', provRecurso.pOutKYCIndResRFC);
        						gen.writeStringField('kycIndResAddress', provRecurso.pOutKYCIndResAddress);
        						gen.writeStringField('kycIndResFEASerialNo',provRecurso.pOutKYCIndResFEASerialNo);
        					gen.writeEndObject();
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
            pr = new PageReference('/apex/ES2_KYC_Person_NewProvider');
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
                pr = new PageReference('/apex/ES2_ReadPage_KWYPersonaFisica?requestId=' + this.req.pOutRequestId);
                pr.setRedirect(true); //Recargamos el controlador  
                
            }
            else //Error en el salvado, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,this.detail.errorCode));
                pr = new PageReference('/apex/ES2_KYC_Person_NewProvider');
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
    
    public PageReference deleteProvider(){
        this.req.pOutRequestId =Test.isRunningTest() ?'12': (String)System.currentPageReference().getParameters().get('requestId');
        this.sSSO = Test.isRunningTest() ? '6666' : [Select EmployeeNumber From User Where Id = :UserInfo.getUserId()][0].EmployeeNumber; 

        JSONGenerator gen = JSON.createGenerator(true);    
        gen.writeStartObject();
        	gen.writeFieldName('kycHeader');
        		gen.writeStartObject();
        			gen.writeStringField('requestId', req.pOutRequestId);
        			gen.writeStringField('kycDetailId', idReg);
        			gen.writeStringField('kycDetailType', 'IRESOURCE');
        			gen.writeStringField('activeFlag', 'N');
                    gen.writeStringField('createdBy', sSSO);
        			gen.writeStringField('creationDate', System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00')));
        			gen.writeStringField('updatedBy', sSSO);
        			gen.writeStringField('lastUpdateDate', System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00')));
        		gen.writeEndObject();
        	/*gen.writeFieldName('kycDetail');
        		gen.writeStartObject();
        		gen.writeFieldName('individual');
        			gen.writeStartObject();
        				gen.writeFieldName('personaFisicaProveedorRecursos');
        					gen.writeStartObject();
        						gen.writeStringField('kycIndResLegalName', provRecurso.pOutKYCIndResLegalName);
        						gen.writeStringField('kycIndResCountry', provRecurso.pOutKYCIndResCountry);
        						gen.writeStringField('kycIndResRFC', provRecurso.pOutKYCIndResRFC);
        						gen.writeStringField('kycIndResAddress', provRecurso.pOutKYCIndResAddress);
        						gen.writeStringField('kycIndResFEASerialNo',provRecurso.pOutKYCIndResFEASerialNo);
        					gen.writeEndObject();
        			gen.writeEndObject();
        		gen.writeEndObject();*/
        gen.writeEndObject();
        
        
        PageReference pr;
        String jsonS = gen.getAsString();
        
         Map<string,object>jsonResponse=null;
        
        jsonResponse = EIV_EntityExtencionCalloutClass.postKYCDetail(jsonS, sServiceURL); 
        System.debug('postRequestDetail JJ: ' + jsonResponse);
        
         if (jsonResponse == null) //Error en ORACLE, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Oracle Server missing'));
            pr = new PageReference('/apex/ES2_ReadPage_KWYPersonaFisica');
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
                pr = new PageReference('/apex/ES2_ReadPage_KWYPersonaFisica?requestId=' + this.req.pOutRequestId);
                pr.setRedirect(true); //Recargamos el controlador  
                
            }
            else //Error en el salvado, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,this.detail.errorCode));
                pr = new PageReference('/apex/ES2_ReadPage_KWYPersonaFisica');
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
        
        STRING clearText = 'requestId='+ req.pOutRequestId +'&sso=' +sSSO + '&urlserver='+ this.URL_Servicio_Externa + '&cddate='+cddate;
        system.debug('texto a encriptar: ' + clearText);
        Blob key = Blob.valueOf(this.KeyEncriptation);
        Blob textoEncB = Crypto.encryptWithManagedIV(this.EncriptationType, key, Blob.valueOf(clearText));
        String textoEnc = EncodingUtil.base64Encode(textoEncB);
        encodedTextAES = this.UrlAppDoctos + '/xxec_episodioIVDocuments-vcDocuments-context-root/faces/encuestaSalesForce.jspx?params=' + textoEnc ;

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
                pr = new PageReference('/apex/ES2_ReadPage_KWYPersonaFisica');
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
                        pr = new PageReference('/apex/ES2_ReadPage_KWYPersonaFisica?&requestId='+ this.req.pOutRequestId);
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
        String sJson = ps.postgeneral('KYC INDIVIDUAL', req);
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
        String sJson = ps.postgeneral('KYC INDIVIDUAL', req);
        PageReference pr = saveStatusGeneral(req.pOutRequestStatus, 'APPROVED' );
        return pr;        
    }  
    public PageReference cancel()
    {
		ES2_controller_POSTjson ps = new ES2_controller_POSTjson();
        req.pOutEndDate = System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00'));
        String sJson = ps.postgeneral('KYC INDIVIDUAL', req);
        
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
            pr = new PageReference('/apex/ES2_EditPage_KWYPersonaFisica');
            pr.setRedirect(false);
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'No existe el Party ID de la entidad en Oracle'));
        }           
 
        return pr;        
    }
    
     public String vfTypeEntitieRead(String entityType){ 
        String vfStringName = '';
        if(entityType == 'Individual' || entityType == 'EIV_EntityReadPageIndividual' || entityType == 'INDIVIDUAL' )
        {
            vfStringName = 'EIV_EntityReadPageIndividual';
        } else if (entityType == 'Organization' || entityType == 'EIV_EntityReadPageOrganization' || entityType == 'ORGANIZATION')
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
                                             '&OracleAccountName=' + this.OracleAccountName +
                                             '&requestId=' + this.req.pOutRequestId +
                                             '&dir=kycpf');
        pr.setRedirect(false); //Pasamos el controlador vacio  
        return pr;        
    }
    
   
   
    
    public  PageReference CancelTable()
    {
       PageReference pr = new PageReference('/apex/ES2_ReadPage_KWYPersonaMoral?requestId=' + this.req.pOutRequestId);
                pr.setRedirect(true); //Recargamos el controlador  
        return pr;
    }
    
    public PageReference saveStatusGeneral(String oldStatus, String sStatus)
    {
        //falta logica del guardado
        /////***////
        
        ES2_controller_POSTjson ps = new ES2_controller_POSTjson();

        req.pOutRequestStatus = sStatus;
        
        PageReference pr;
        String sJson = ps.postgeneral('KYC INDIVIDUAL', req);
        		                       
        Map<string,object>jsonResponse=null;
        
        jsonResponse = EIV_EntityExtencionCalloutClass.postRequestDetail(sJson, sServiceURL); 
        System.debug('postRequestDetail JJ: ' + jsonResponse);
        
        if (jsonResponse == null) //Error en ORACLE, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Oracle Server missing'));
            req.pOutRequestStatus = oldStatus;
            pr = new PageReference('/apex/ES2_ReadPage_KWYPersonaFisica');
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
                pr = new PageReference('/apex/ES2_ReadPage_KWYPersonaFisica?requestId=' + this.req.pOutRequestId+ '&OracleAccountName=' +  this.req.pOutPartyName);
                pr.setRedirect(true); //Recargamos el controlador  
                
            }
            else //Error en el salvado, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,this.detail.errorCode));
                req.pOutRequestStatus = oldStatus;
                pr = new PageReference('/apex/ES2_ReadPage_KWYPersonaFisica');
                pr.setRedirect(false); //Pasamos el controlador lleno  
            }
            
            
        }    
        return pr;             
    }              
        
public boolean cambia(string p){
        if(p == '10000'){ return true; }else{ return false; }
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
            if(req.privilegeObj[a].section == 'PENDING'){ sendbtn = cambia(req.privilegeObj[a].vCrud); }
            else if(req.privilegeObj[a].section == 'IN PROCESS'){ aceptbtn = cambia(req.privilegeObj[a].vCrud);}
            else if(req.privilegeObj[a].section == 'ON HOLD'){ onhdbtn = cambia(req.privilegeObj[a].vCrud); }
            else if(req.privilegeObj[a].section == 'REWORK'){ reworkbtn = cambia(req.privilegeObj[a].vCrud);}
            else if(req.privilegeObj[a].section == 'REJECTED'){ rejbtn = cambia(req.privilegeObj[a].vCrud); }
            else if(req.privilegeObj[a].section == 'PRE APPROVED'){ preaprbtn = cambia(req.privilegeObj[a].vCrud);}
            else if(req.privilegeObj[a].section == 'APPROVED'){ aprbtn = cambia(req.privilegeObj[a].vCrud);}
            else if(req.privilegeObj[a].section == 'AUTO APPROVED'){ reworkbtn = cambia(req.privilegeObj[a].vCrud); }
            else if(req.privilegeObj[a].section == 'CANCELLED BY REQUESTOR'){ cancelbtn = cambia(req.privilegeObj[a].vCrud);}
            else if(this.req.privilegeObj[a].section == 'WAITING FOR CUSTOMER'){ senddTocustomer = cambia(req.privilegeObj[a].vCrud);}
            else if(req.privilegeObj[a].section == 'EDIT'){ editbtn = cambia(req.privilegeObj[a].vCrud);}
            else if(req.privilegeObj[a].section == 'NEW DOCUMENT'){ Ndocbtn = cambia(req.privilegeObj[a].vCrud);}
            else if(req.privilegeObj[a].section == 'NEW COMMENT'){ Ncombtn = cambia(req.privilegeObj[a].vCrud);}
            else if(req.privilegeObj[a].section == 'COMPLETED BY CUSTOMER'){ completedByC = cambia(req.privilegeObj[a].vCrud);
            }else{ system.debug('no tengo parametros');}
        }
    }
    
    public boolean passvalue(string a){
        if(a == 'Y'){
            return true;
        } else{ return false; }
    } 
    
   
    

    public void passUrlback(){
        backUrl = ApexPages.currentPage().getParameters().get('one');
        
    }

    public void doctypesList(){
        this.doctypess = new list<string>();
        for(integer i=0; i<=req.DocTypesObj.size()-1; i++){
            string docname = req.DocTypesObj[i].name;
            
            
            doctypess.add(docname);
            
            
        }
        
        
        doctiposString =string.join(doctypess, (','));
        System.debug('doctos--->' + doctiposString);   
    }

}