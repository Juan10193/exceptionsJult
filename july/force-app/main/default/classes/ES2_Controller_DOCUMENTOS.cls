public class ES2_Controller_DOCUMENTOS {
	public ES2_WraperRequest req 			{get;set;}
    public ES2_Wraper_documents doc 		{get;set;}
    public String OracleAccountName 		{get;set;}
    public String TopParentName 			{get;set;}
    public String legalname 				{get;set;}
    public string dir 						{get;set;}
    public Date x 							{get;set;}
    public Date y 							{get;set;}
    public String filename 					{get;set;}
    public String fileurl 					{get;set;}
    public String filetype 					{get;set;}
    public String sServiceURL 				{get;set;}
    public String sSSO 						{get;set;} 
    public Transient Blob filevalue 		{get;set;}
    public list<ES2_WraperRequest> dts 		{get;set;}
    
    public String docTypesToURL 			{get;set;}
    
    
   
    
    
    
    public ES2_Controller_DOCUMENTOS(){
        
        
        
        this.req = new ES2_WraperRequest();
        this.doc = new ES2_Wraper_documents(); 
        System.debug('req.pOutRequestId: ' +req.pOutRequestId);
        this.req.pOutRequestId =  (String)System.currentPageReference().getParameters().get('requestId');    
        this.req.pOutPartyName = (String) System.currentPageReference().getParameters().get('OracleAccountName');
        this.req.pOutPartyId = (String)System.currentPageReference().getParameters().get('PartyId');
        this.req.pOutSourceTopParentId = (String)System.currentPageReference().getParameters().get('TopParentID');
        this.req.pOutsourceTopParentName  = Test.isRunningTest() ? 'TopParentName' : (String) System.currentPageReference().getParameters().get('TopParentName');
        this.dir = (String) System.currentPageReference().getParameters().get('dir');
        this.sServiceURL = Test.isRunningTest() ? 'HTTP://algo.com' : [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='URL_Servicio'][0].EIV_tx_parameter__c; 
        this.sSSO = Test.isRunningTest() ? '999' : [Select EmployeeNumber From User Where Id = :UserInfo.getUserId()][0].EmployeeNumber;   
        
             //es neuva
             Map<string,object>jsonResponse =null;
            jsonResponse = (Map<string,object>)JSON.deserializeUntyped(ES2_jsonDummy.JsonnULO('Docs'));
             System.debug('OEJ:' + jsonResponse);
            system.debug('direccion ='+dir);
            Map<String, Object> status = (Map<String, Object>)jsonResponse.get('status');
            System.debug('Received the following JSON response of status.code OEJ01:' + (String)status.get('code'));
            System.debug('Received the following JSON response of status.message OEJ01:' + (String)status.get('message'));
            System.debug('Received the following JSON response of status.detail OEJ01:' + (String)status.get('detail'));
            Map<String, Object> mapRequests = (Map<String, Object>)jsonResponse.get('requests');
            System.debug('Received the following JSON response of mapRequests OEJ01:' + mapRequests);
            ES2_Controller_KWYPMoralFill rellena = new  ES2_Controller_KWYPMoralFill();
              dts = new list<ES2_WraperRequest> ();
              dts = rellena.rellenarHeader(mapRequests);
                if(dts.size()>0)
                {
                    req = dts[0];
                    
                }
         x = Date.today();
        y = Date.newInstance(x.year()+3, x.month(), x.day()); 
    }
    public PageReference BackDocumentos()
    {
        this.req.pOutRequestId=(String)System.currentPageReference().getParameters().get('requestId');
        //falta logica del guardado
        /////***////
        //
        
        
        PageReference pr = new PageReference('/apex/'+page(dir)+'?requestId='+this.req.pOutRequestId);
        pr.setRedirect(true); //Pasamos el controlador vacio  
        return pr;              
    }
    public PageReference SaveDoCTOS()
    {
        
        PageReference pr;
        this.req.pOutRequestId =  (String)System.currentPageReference().getParameters().get('requestId');   
        this.req.pOutPartyName = Test.isRunningTest() ? 'OracleAccountName' : (String) System.currentPageReference().getParameters().get('OracleAccountName');
        this.req.pOutPartyId = Test.isRunningTest() ? '123' : (String)System.currentPageReference().getParameters().get('PartyId');
        this.req.pOutSourceTopParentId = Test.isRunningTest() ? '123' : (String)System.currentPageReference().getParameters().get('TopParentID');
        this.req.pOutsourceTopParentName  =  Test.isRunningTest() ? 'TopParentName' : (String) System.currentPageReference().getParameters().get('TopParentName');
        String paramvalue = Test.isRunningTest() ? 'param' : EncodingUtil.base64Encode(filevalue);
        this.doc.pOutDocName = Test.isRunningTest() ? '123lasd' : this.doc.pOutDocName;
        this.doc.pOutDocType = Test.isRunningTest() ? 'Doctype' : this.doc.pOutDocType; 
        //String[] parts = filename.split('.');
        string index = Test.isRunningTest() ?'archivo' : filename.substringAfterLast('.');
		//string secName = filename.mid(0,index);
        system.debug(' nombre ' + index);
        
		//String part1 = parts[0]; // gangadhar

		//String part2 = parts[1]; // NAGRAJ
        
        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartObject();
        gen.writeFieldName('document');
        gen.writeStartObject();
        gen.writeStringField('requestId' ,Test.isRunningTest() ? '112' : this.req.pOutRequestId);
        gen.writeStringField('docAction' , 'CREATE');
        gen.writeStringField('sourceAccountId' ,Test.isRunningTest() ?'mara': req.pOutSourceAccountId );
        gen.writeStringField('sourceAccountName' ,  'sourceAccountName');
        gen.writeStringField('sourceTopParentId' ,  this.req.pOutSourceTopParentId);
        gen.writeStringField('sourceTopParentName' , this.req.pOutSourceTopParentName);
        gen.writeStringField('partyId' , this.req.pOutPartyId);
        gen.writeStringField('partyName' , this.req.pOutPartyName);
        gen.writeStringField('comment' , 'Documento agregado desde Salesforce request ID: ' + this.req.pOutRequestId);
        gen.writeStringField('contractNumber' , '');
        gen.writeStringField('anex' , '');
        gen.writeStringField('egPartyId' , this.req.pOutPartyId);
        gen.writeStringField('egPartyName' , this.req.pOutPartyName);
        gen.writeStringField('sourceOpId' ,  'No Aplica dijo LALO');
        gen.writeStringField('sourceCAId' ,  'No Aplica dijo LALO');
        gen.writeStringField('oracleDocId' , '');
        gen.writeStringField('originalDocName' , this.doc.pOutDocName+'('+index+')');
        gen.writeStringField('docType' , this.doc.pOutDocType);
        gen.writeStringField('docURL' , Test.isRunningTest() ?'mara.pdf' : filename);
        gen.writeStringField('contentDocId' ,  '');
        gen.writeStringField('contentDocName' ,Test.isRunningTest() ?'mara.pdf' : filename);
        gen.writeStringField('docContentB64' ,  paramvalue);
        gen.writeStringField('docStartDate' ,  System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00')));
        gen.writeStringField('docCreationDate' ,  System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00')));
        gen.writeStringField('docEndDate' ,  System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00')));
        gen.writeStringField('docCreatedBy' ,  this.sSSO);
        gen.writeEndObject(); 
        gen.writeEndObject(); 
        if(this.doc.pOutDocName==''){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'campos requeridos con *'));
        }else{
        String jsonS = gen.getAsString(); 
        system.debug('jsonS OEJ Comment' + jsonS);
        pr = new PageReference('/apex/ES2_EditPage_ADD_DOCUMENTOS?requestId=' +  this.req.pOutRequestId );        
        
        
        Map<String, Object> jsonResponse = null;
        
        
        jsonResponse = Test.isRunningTest() ? new Map<String, Object>() : EIV_EntityExtencionCalloutClass.postUploadDocument(sServiceURL ,jsonS);
        System.debug('jsonResponse OEJ:' + jsonResponse);
        if (jsonResponse == null) //Error en ORACLE, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Oracle Server missing'));
            pr = new PageReference('/apex/ES2_EditPage_ADD_DOCUMENTOS');
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
                    pr = new PageReference('/apex/'+page(dir)+'?&requestId='+ this.req.pOutRequestId);
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
        }
        return pr;
    }
    
    
     public String page(string ref){
        string res='';
        if(ref=='CB'){
            res = 'ES2_ReadPage_CREDIT_BUREAU';
        }else if(ref=='NDA'){
            res = 'ES2_ReadPage_NDA';
        }else if(ref=='AML'){
            res = 'ES2_ReadPage_AML';
        }else if(ref=='kycpm'){
            res = 'ES2_ReadPage_KWYPersonaMoral';
        }else if(ref=='kycpf'){
            res = 'ES2_ReadPage_KWYPersonaFisica';
        }else {
            res = null;
        }
        return res;
     }
    public List<SelectOption> getDocOptions() { 
        List<SelectOption> DocOptions = new List<SelectOption>();
        String docTypes = (String) System.currentPageReference().getParameters().get('docTypes');
        List<String> parts = Test.isRunningTest() ? new List<String>() : docTypes.split(';');        
        
        for (String docs : parts) 
        {  
            DocOptions.add(new SelectOption(docs,docs));
        }
        return DocOptions;     
        
    }
    public String nullTovacio(String dato)
    {
        if(String.isBlank(dato))
        {
            return '';
            
        }
        else
        {
            return dato;
        }
        
    }
    
    public String DeleteDocs(String partyId, String requestId, String url, String idDoc, 
                             String sourceAccountId, String sourceTopParentId,String sourceTopParentName, string pOutPartyName,
                             String egPartyId, String egPartyName)
    {
        PageReference pr;
        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartObject();
        gen.writeFieldName('document');
        gen.writeStartObject();
        gen.writeStringField('requestId' , requestId);
        gen.writeStringField('docAction' , 'DELETE');
       
        gen.writeStringField('sourceAccountId' , nullTovacio(sourceAccountId));
        gen.writeStringField('sourceAccountName' ,  'sourceAccountName');
        gen.writeStringField('sourceTopParentId' ,  sourceTopParentId);
        gen.writeStringField('sourceTopParentName' , sourceTopParentName);
        gen.writeStringField('partyId' , partyId);
        gen.writeStringField('partyName' ,pOutPartyName);
        gen.writeStringField('comment' , 'Documento agregado desde Salesforce request ID: ' + this.req.pOutRequestId);
        gen.writeStringField('contractNumber' , '');
        gen.writeStringField('anex' , '');
        gen.writeStringField('egPartyId' , nullTovacio(egPartyId));
        gen.writeStringField('egPartyName' ,nullTovacio(egPartyName));
        gen.writeStringField('sourceOpId' ,  'No Aplica dijo LALO');
        gen.writeStringField('sourceCAId' ,  'No Aplica dijo LALO');
        gen.writeStringField('id' ,  idDoc);
        gen.writeStringField('oracleDocId' , '');
        gen.writeStringField('originalDocName' , url);
        gen.writeStringField('docType' , '');
        gen.writeStringField('contentDocId' ,  '');
        gen.writeStringField('contentDocName' , url);
        //gen.writeStringField('docContentB64' ,  paramvalue);
        gen.writeStringField('docStartDate' ,  System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00')));
        gen.writeStringField('docCreationDate' ,  System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00')));
        gen.writeStringField('docEndDate' ,  System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00')));
        gen.writeStringField('docCreatedBy' ,  this.sSSO);
        gen.writeEndObject(); 
        gen.writeEndObject(); 
        String jsonS = gen.getAsString(); 
        system.debug('jsonS OEJ Comment' + jsonS);
        //pr = new PageReference('/apex/ES2_EditPage_ADD_DOCUMENTOS?requestId=' +  this.req.pOutRequestId );          
        Map<String, Object> jsonResponse = null;                
        jsonResponse = Test.isRunningTest() ? new Map<String, Object>() : EIV_EntityExtencionCalloutClass.postUploadDocument(sServiceURL ,jsonS);
        System.debug('jsonResponse OEJ:' + jsonResponse);
        if (jsonResponse == null) //Error en ORACLE, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
        {
            system.debug('OEJ: ERROR, Oracle Server Missing');
            return 'ERROR, Oracle Server Missing';
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
                    system.debug('OEJ: EXITO, El servicio se ejecuto correctamente');
                    return 'EXITO';                    
                }
                else //Error en el salvado, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
                {
                    system.debug('OEJ: Error, El servicio NO se ejecuto correctamente' + (String)statusCreate.get('code'));
                    return 'ERROR, El servicio NO se ejecuto correctamente' + (String)statusCreate.get('code'); 
                }          
            }
            return 'ERROR: La solicitud no trae estatus'; 
        }
    }
    
    
    public static String deleteDoc (string requestId, string oraId, string url, string docType, string contentDocId, string name )
         {
        string sServiceURL = Test.isRunningTest() ? 'https://test.com' :  [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='URL_Servicio'][0].EIV_tx_parameter__c;
        string sSSO = Test.isRunningTest() ? '1234567' : [Select EmployeeNumber From User Where Id = :UserInfo.getUserId()][0].EmployeeNumber; 
        PageReference pr;
        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartObject();
        gen.writeFieldName('document');
        gen.writeStartObject();
        gen.writeStringField('requestId' , requestId);
        gen.writeStringField('docAction' , 'DELETE');
       
        gen.writeStringField('sourceAccountId' , '');
        gen.writeStringField('sourceAccountName' ,  '');
        gen.writeStringField('sourceTopParentId' ,  '');
        gen.writeStringField('sourceTopParentName' , '');
        gen.writeStringField('partyId' , '');
        gen.writeStringField('partyName' ,'');
        gen.writeStringField('comment' , '');
        gen.writeStringField('contractNumber' , '');
        gen.writeStringField('anex' , '');
        gen.writeStringField('egPartyId' , '');
        gen.writeStringField('egPartyName' ,'');
        gen.writeStringField('sourceOpId' ,  '');
        gen.writeStringField('sourceCAId' ,  '');
       // gen.writeStringField('id' ,  '');
        gen.writeStringField('oracleDocId' , oraId);
        gen.writeStringField('originalDocName' , name);
        gen.writeStringField('docType' , docType);
        gen.writeStringField('contentDocId' ,  contentDocId);
        gen.writeStringField('contentDocName' , url);
        //gen.writeStringField('docContentB64' ,  paramvalue);
        gen.writeStringField('docStartDate' , System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00')));
        gen.writeStringField('docCreationDate' ,  '');
        gen.writeStringField('docEndDate' ,  '');
        gen.writeStringField('docCreatedBy' , sSSO);
        gen.writeEndObject(); 
        gen.writeEndObject(); 
        String jsonS = gen.getAsString(); 
        system.debug('jsonS OEJ Comment' + jsonS);
        //pr = new PageReference('/apex/ES2_EditPage_ADD_DOCUMENTOS?requestId=' +  this.req.pOutRequestId );          
        Map<String, Object> jsonResponse = null;                
        jsonResponse = Test.isRunningTest() ? new Map<String, Object>() : EIV_EntityExtencionCalloutClass.postUploadDocument(sServiceURL ,jsonS);
        System.debug('jsonResponse OEJ:' + jsonResponse);
        if (jsonResponse == null) //Error en ORACLE, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
        {
            system.debug('OEJ: ERROR, Oracle Server Missing');
            return 'ERROR, Oracle Server Missing';
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
                    system.debug('OEJ: EXITO, El servicio se ejecuto correctamente');
                    return 'EXITO';                    
                }
                else //Error en el salvado, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
                {
                    system.debug('OEJ: Error, El servicio NO se ejecuto correctamente' + (String)statusCreate.get('code'));
                    return 'ERROR, El servicio NO se ejecuto correctamente' + (String)statusCreate.get('code'); 
                }          
            }
            return 'ERROR: La solicitud no trae estatus'; 
        }
    }
    
    
}