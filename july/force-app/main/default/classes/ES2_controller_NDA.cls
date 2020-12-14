public class ES2_controller_NDA {
    
    public ES2_WraperRequest req 						{get;set;}
    public EIV_DetailWrapClass detail                   {get;set;}
    public String sServiceURL 							{get;set;}
    public string UrlAppDoctos 							{get;set;}
    public string EncriptationType 						{get;set;}
    public string KeyEncriptation 						{get;set;}
    public string URL_Servicio_Externa 					{get;set;}
    public String sSSO 									{get;set;}
    public boolean sendbtn								{get;set;}
    public boolean aceptbtn								{get;set;}
    public boolean onhdbtn								{get;set;}
    public boolean reworkbtn							{get;set;}
    public boolean rejbtn								{get;set;}
    public boolean preaprbtn							{get;set;}
    public boolean aprbtn								{get;set;}
    public boolean Aaprbtn								{get;set;}
    public boolean cancelbtn							{get;set;}
   	public boolean btentitybtn							{get;set;}
    public boolean editbtn								{get;set;}
    public boolean Ncombtn								{get;set;}
    public boolean Ndocbtn								{get;set;}
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
    
    public ES2_controller_NDA(){
        this.req = new ES2_WraperRequest();
        this.req.pOutRequestId =  (String)System.currentPageReference().getParameters().get('requestId'); 
        
        
        this.sServiceURL = Test.isRunningTest() ? 'hola mundo' :[Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='URL_Servicio'][0].EIV_tx_parameter__c; 
        this.UrlAppDoctos = Test.isRunningTest() ? 'https://test.com' :  [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='UrlAppDoctos'][0].EIV_tx_parameter__c; 
        this.EncriptationType = Test.isRunningTest() ? 'https://test.com' :  [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='EncriptationType'][0].EIV_tx_parameter__c; 
        this.KeyEncriptation = Test.isRunningTest() ? 'https://test.com' :  [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='KeyEncriptation'][0].EIV_tx_parameter__c; 
        this.URL_Servicio_Externa = Test.isRunningTest() ? 'https://test.com' :  [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='URL_Servicio_Externa'][0].EIV_tx_parameter__c;
        this.sSSO = Test.isRunningTest() ? '666' : [Select EmployeeNumber From User Where Id = :UserInfo.getUserId()][0].EmployeeNumber;  
        if ( String.isNotBlank(this.req.pOutRequestId) )
        {
            //es una consulta
            Map<string,object>jsonResponse =null;
            
            //jsonResponse = (Map<string,object>)JSON.deserializeUntyped(ES2_jsonDummy.entitymasterToJson());
            jsonResponse = EIV_EntityExtencionCalloutClass.callBackGetRequestDetailsOne(this.sSSO, 'SF', this.sServiceURL, this.req.pOutRequestId);
            Map<String, Object> mapRequests = (Map<String, Object>)jsonResponse.get('requests');
            if(mapRequests==null)
            {
                System.debug('OEJ: No existen solicitudes requests que revisar');
            }   
            else
            {
                ES2_Controller_KWYPMoralFill rellena = new  ES2_Controller_KWYPMoralFill();
                
                list<ES2_WraperRequest> dts = new list<ES2_WraperRequest>();
                dts = rellena.rellenarHeader(mapRequests);
                if(dts.size()>0)
                {
                    req = dts[0];
                }
                system.debug('nda type ' + req.pOutndaType);
                yesnobtn();
                
            }
        }
        else
        {
            // es una nueva
            this.req.pOutRequestId =  (String)System.currentPageReference().getParameters().get('requestId');    
            this.req.pOutPartyName = (String) System.currentPageReference().getParameters().get('OracleAccountName');
            this.req.pOutPartyId = (String)System.currentPageReference().getParameters().get('PartyId');
            this.req.pOutSourceTopParentId = (String)System.currentPageReference().getParameters().get('TopParentID');
            this.req.pOutsourceTopParentName  = (String) System.currentPageReference().getParameters().get('TopParentName');
            
            req.pOutCreatedBy = sSSO;
            req.pOutUpdatedBy=sSSO;
            req.pOutRequestedBy = sSSO;
            req.pOutStartDate = System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00'));
            req.pOutLastUpdateDate = System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00'));
            req.pOutRequestStatus = 'NEW';
            req.pOutActiveFlag = 'Y';
        }
    } 
    public PageReference editNDA()
    {
        //falta logica del guardado
        /////***////
        req.pOutUpdatedBy = sSSO;
        PageReference pr = new PageReference('/apex/ES2_EditPage_NDA');
        pr.setRedirect(false); 
        return pr;        
    }
    
     public PageReference send()
    {
		string identifica ='Yes';
        system.debug('lo que me llega de doctype'+ req.DocTypesObj);
        PageReference pr;
        integer i = req.DocTypesObj.size();
        for(integer a=0;a<i;a++){
            system.debug('prms ' + req.DocTypesObj[a].prm1);
            if(req.DocTypesObj[a].prm1 == 'REQUIRED' && req.DocTypesObj[a].prm1 !='OK'){
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'falta '+ req.DocTypesObj[a].name));
                identifica='No';
            }
            
            if(identifica!='No'){
             
                pr = saveStatusGeneral(req.pOutRequestStatus, 'PENDING' );
            
            }
            
        }
        
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

        PageReference pr = saveStatusGeneral(req.pOutRequestStatus, 'REJECTED' );
        return pr;        
    }  
    public PageReference preApprove()
    {

        PageReference pr = saveStatusGeneral(req.pOutRequestStatus, 'PRE APPROVED' );
        return pr;        
    }      
    public PageReference approve()
    {

        PageReference pr = saveStatusGeneral(req.pOutRequestStatus, 'APPROVED' );
        return pr;        
    }  
    public PageReference cancel()
    {

        PageReference pr = saveStatusGeneral(req.pOutRequestStatus, 'CANCELLED BY REQUESTOR' );
        return pr;        
    }      
    
    public PageReference saveStatusGeneral(String oldStatus, String sStatus)
    {

        
        ES2_controller_POSTjson ps = new ES2_controller_POSTjson();
        PageReference pr;
        
                if(sStatus=='CANCELLED BY REQUESTOR'||sStatus=='APPROVED'||sStatus=='REJECTED'||sStatus=='REWORK'){
            req.pOutRequestStatus = sStatus;
            req.pOutEndDate = System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00'));
                }else if(sStatus=='IN PROCESS'){
                    req.pOutRequestStatus = sStatus;
                    req.pOutAssignedTo = sSSO;
                }else{
            req.pOutRequestStatus = sStatus;
             
        }
        
        req.pOutUpdatedBy = sSSO;
       /* req.pOutCreatedBy = sSSO;
        req.pOutRequestedBy = sSSO;
        req.pOutUpdatedBy = sSSO;
        req.pOutStartDate = System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00'));
        req.pOutCreationDate = System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00'));
        req.pOutLastUpdateDate = System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00'));
        req.pOutRequestStatus = sStatus;
        req.pOutActiveFlag = 'Y'; */
        
        String sJson = ps.postgeneral('NDA', req);
        
        Map<string,object> jsonResponse =null;
        
        
        //jsonResponse = (Map<string,object>)JSON.deserializeUntyped(ES2_jsonDummy.entitymasterToJson());
        jsonResponse = EIV_EntityExtencionCalloutClass.postRequestDetail(sJson, sServiceURL);
        System.debug('postRequestDetail JJ: ' + jsonResponse);
        if (jsonResponse == null) //Error en ORACLE, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Oracle Server missing'));
            req.pOutRequestStatus = oldStatus;
            pr = new PageReference('/apex/ES2_ReadPage_NDA');
            pr.setRedirect(false); //Pasamos el controlador lleno 
        }
        else
        {
            //El resultado tiene status
            Map<String, Object> status = (Map<String, Object>)jsonResponse.get('status');
            System.debug('Received the following JSON response of status OEJ01:' + status);
            detail = new EIV_DetailWrapClass();
            this.req.pOutRequestId =String.valueOf(jsonResponse.get('requestId'));
            this.detail.errorCode =  (String)status.get('code'); //{code=S,N, detail=0, message=0}
            this.detail.description =  (String)status.get('detail');
            this.detail.message =  (String)status.get('message');
            if(this.detail.description == 'S') //Exito en el salvado, pasamos a la pagina de lectura de la Entidad y recargamos el controlador
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,this.detail.message));
                pr = new PageReference('/apex/ES2_ReadPage_NDA?requestId=' + req.pOutRequestId);
                pr.setRedirect(true); //Recargamos el controlador  
                
            }
            else //Error en el salvado, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,this.detail.errorCode));
                req.pOutRequestStatus = oldStatus;
                pr = new PageReference('/apex/ES2_ReadPage_NDA');
                pr.setRedirect(false); //Pasamos el controlador lleno  
            }
            
        } 
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
                Aaprbtn = cambia(req.privilegeObj[a].vCrud);
            }
            else if(req.privilegeObj[a].section == 'CANCELLED BY REQUESTOR'){
                cancelbtn = cambia(req.privilegeObj[a].vCrud);
            }
            else if(req.privilegeObj[a].section == 'WAITING FOR CUSTOMER'){
                btentitybtn = cambia(req.privilegeObj[a].vCrud);
            }else if(req.privilegeObj[a].section == 'EDIT'){
                editbtn = cambia(req.privilegeObj[a].vCrud);
            }else if(req.privilegeObj[a].section == 'NEW DOCUMENT'){
                Ndocbtn = cambia(req.privilegeObj[a].vCrud);
            }else if(req.privilegeObj[a].section == 'NEW COMMENT'){
                Ncombtn = cambia(req.privilegeObj[a].vCrud);
            }else{
                system.debug('no tengo parametros');
            }
        }
    }
    
    
    public PageReference saveNDA()
    {
        //falta logica del guardado
        /////***////
        //
        
        ES2_controller_POSTjson ps = new ES2_controller_POSTjson();
        PageReference pr;
        
        req.pOutCreatedBy = sSSO;
        req.pOutRequestedBy = sSSO;
        req.pOutStartDate = System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00'));
        req.pOutCreationDate = System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00'));
        req.pOutRequestStatus = 'NEW';
        req.pOutActiveFlag = 'Y';
        
        String sJson = ps.postgeneral('NDA', req);
        
        Map<string,object> jsonResponse =null;
           
            //jsonResponse = (Map<string,object>)JSON.deserializeUntyped(ES2_jsonDummy.entitymasterToJson());
        jsonResponse = EIV_EntityExtencionCalloutClass.postRequestDetail(sJson, sServiceURL);
        System.debug('postRequestDetail JJ: ' + jsonResponse);
        if (jsonResponse == null) //Error en ORACLE, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Oracle Server missing'));
            pr = new PageReference('/apex/ES2_EditPage_NDA');
            pr.setRedirect(false); //Pasamos el controlador lleno 
        }
        else
        {
            //El resultado tiene status
            Map<String, Object> status = (Map<String, Object>)jsonResponse.get('status');
            System.debug('Received the following JSON response of status OEJ01:' + status);
            detail = new EIV_DetailWrapClass();
            this.req.pOutRequestId =String.valueOf(jsonResponse.get('requestId'));
            this.detail.errorCode =  (String)status.get('code'); //{code=S,N, detail=0, message=0}
            this.detail.description =  (String)status.get('detail');
            this.detail.message =  (String)status.get('message');
            if(this.detail.description == 'S') //Exito en el salvado, pasamos a la pagina de lectura de la Entidad y recargamos el controlador
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,this.detail.message));
                pr = new PageReference('/apex/ES2_ReadPage_NDA?requestId=' + req.pOutRequestId);
                pr.setRedirect(true); //Recargamos el controlador  
                
            }
            else //Error en el salvado, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,this.detail.errorCode));
                pr = new PageReference('/apex/ES2_EditPage_NDA');
                pr.setRedirect(false); //Pasamos el controlador lleno  
            }
            
        } 
        return pr;
    }
    public PageReference newcoment()
    {
        //falta logica del guardado
        /////***////
        
        PageReference pr = new PageReference('/apex/ES2_EditPage_ADD_COMENTARIOS?TopParentID=' +this.req.pOutsourceTopParentId+ 
                                             '&TopParentName=' + this.req.pOutsourceTopParentName + 
                                             '&OracleAccountName=' + this.req.pOutPartyName +  
                                             '&PartyId='+this.req.pOutPartyId+
                                             '&requestId='+this.req.pOutRequestId +
                                             '&dir=NDA');
        pr.setRedirect(false); //Pasamos el controlador vacio  
        return pr;        
    }

    public PageReference recarga(){
        PageReference pr;
        pr= new PageReference('/apex/ES2_ReadPage_NDA?requestId=' + req.pOutRequestId + '&sso' + sSSO);
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
            string backUrl = System.Url.getSalesforceBaseURL().toExternalForm() + '/one/one.app#/alohaRedirect/apex/ES2_ReadPage_NDA?requestId='+ requestId;
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
        string backUrl = System.Url.getSalesforceBaseURL().toExternalForm() + '/one/one.app#/alohaRedirect/apex/ES2_ReadPage_NDA?requestId='+ requestId;
       

       
		
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
       
        string backUrl = System.Url.getSalesforceBaseURL().toExternalForm() + '/one/one.app#/alohaRedirect/apex/ES2_ReadPage_NDA?requestId='+ RequestId;
        
        STRING clearText = 'contentDocId='+ docId + '&backUrl=' +backUrl +'&urlserver='+ URL_Servicio_Externa + '&cddate=' + cddate;
        Blob key = Blob.valueOf(KeyEncriptation);
        Blob textoEncB = Crypto.encryptWithManagedIV(EncriptationType, key, Blob.valueOf(clearText));
        String textoEnc = EncodingUtil.base64Encode(textoEncB);
        string encodedTextAES = UrlAppDoctos + '/xxec_episodioIVDocuments-vcDocuments-context-root/faces/documentDownloadFile.jspx?params=' + textoEnc;
        System.debug(encodedTextAES);
        return encodedTextAES;
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
            pr = new PageReference('/apex/ES2_EditPage_NDA');
            pr.setRedirect(false);
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'No existe el Party ID de la entidad en Oracle'));
        }           
 
        return pr;        
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