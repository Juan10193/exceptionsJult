public class ES2_Controller_CREDIT_BUREAU {
    public ES2_WraperRequest req 			{get;set;}
    public String OracleAccountName 		{get;set;}
    public String legalname 				{get;set;}
    public boolean sendbtn					{get;set;}
    public boolean sendtoCBbtn				{get;set;}
    public boolean aceptbtn					{get;set;}
    public boolean onhdbtn					{get;set;}
    public boolean reworkbtn				{get;set;}
    public boolean rejbtn					{get;set;}
    public boolean preaprbtn				{get;set;}
    public boolean aprbtn					{get;set;}
    public boolean txtrjectr				{get;set;}
    public boolean cancelbtn				{get;set;}
    public boolean btentitybtn				{get;set;}
    public boolean editbtn					{get;set;}
    public boolean Ncombtn					{get;set;}
    public boolean Ndocbtn					{get;set;}
    public EIV_DetailWrapClass detail       {get;set;}
    public String sServiceURL 				{get;set;}
    public string UrlAppDoctos {get;set;}
    public string EncriptationType {get;set;}
    public string KeyEncriptation {get;set;}
    public string URL_Servicio_Externa {get;set;}
    public String sSSO 						{get;set;}
    public list<ES2_WraperRequest> dts 		{get;set;}
    
    public String nameDoc 					{get;set;}
    public String idDoc 					{get;set;}
    public String requestIdDoc 				{get;set;}
    public String partyIdDoc 				{get;set;}
    
    public string oraId						{get;set;}
    public string docType					{get;set;}
    
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

    //fecha de nuevo content
    public Datetime fechaContent                              {get;set;}
    public Datetime startfecha                                {get;set;}
    public User usuario {get;set;}
    public string proceso {get;set;}
    public Boolean lightn {get;set;}
    public Boolean visual {get;Set;}
    
    Map<string,object>jsonResponse =null;
    
    public ES2_Controller_CREDIT_BUREAU(){
        string userId = UserInfo.getUserId();
        this.usuario = [Select Name, EmployeeNumber from User where Id =:userId LIMIT 1];
        this.req = new ES2_WraperRequest();
        this.req.pOutRequestId =  (String)System.currentPageReference().getParameters().get('requestId');    
        this.req.pOutPartyName = (String) System.currentPageReference().getParameters().get('OracleAccountName');
        this.req.pOutPartyId = (String)System.currentPageReference().getParameters().get('PartyId');
        this.req.pOutSourceTopParentId = (String)System.currentPageReference().getParameters().get('TopParentID');
        this.req.pOutsourceTopParentName  = (String) System.currentPageReference().getParameters().get('TopParentName');
        this.req.CreditBureauObj.cbName = (String)System.currentPageReference().getParameters().get('First_Name');
        this.sServiceURL = [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='URL_Servicio'][0].EIV_tx_parameter__c; 
        string contentDateLightning = [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='ContentEntityMaster'][0].EIV_tx_parameter__c;
        this.fechaContent = DateTime.valueOfGmt(contentDateLightning.replaceAll('/','-'));
        
        this.UrlAppDoctos = Test.isRunningTest() ? 'https://test.com' :  [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='UrlAppDoctos'][0].EIV_tx_parameter__c; 
        this.EncriptationType = Test.isRunningTest() ? 'AES128' :  [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='EncriptationType'][0].EIV_tx_parameter__c; 
        this.KeyEncriptation = Test.isRunningTest() ? 'https://test.com' :  [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='KeyEncriptation'][0].EIV_tx_parameter__c; 
        this.URL_Servicio_Externa = Test.isRunningTest() ? 'https://test.com' :  [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='URL_Servicio_Externa'][0].EIV_tx_parameter__c;
        this.sSSO = [Select EmployeeNumber From User Where Id = :UserInfo.getUserId()][0].EmployeeNumber;  
        system.debug('variables que resive ' + this.req.CreditBureauObj.City+' '+this.req.CreditBureauObj.Country+' '+this.req.CreditBureauObj.municipality);
        System.debug('this.req.pOutRequestId '+this.req.pOutRequestId);
        if ( String.isNotBlank(this.req.pOutRequestId) ){
            //es una consulta
            
            //jsonResponse = (Map<string,object>)JSON.deserializeUntyped(ES2_jsonDummy.entitymasterToJson());
            jsonResponse = EIV_EntityExtencionCalloutClass.callBackGetRequestDetailsOne(this.sSSO, 'SF', this.sServiceURL, this.req.pOutRequestId);
            System.debug('jsonResponse Hector '+jsonResponse);
            System.debug('jsonResponse Hector '+(Map<String, Object>)jsonResponse.get('requests'));
            Map<String, Object> mapRequests = (Map<String, Object>)jsonResponse.get('requests');
            System.debug('jsonResponse Hector '+mapRequests);
            if(mapRequests==null){
                System.debug('OEJ: No existen solicitudes requests que revisar');
            }   
            else{
                ES2_Controller_KWYPMoralFill rellena = new  ES2_Controller_KWYPMoralFill();
                dts = new list<ES2_WraperRequest>();
                dts = rellena.rellenarHeader(mapRequests);
                if(dts.size()>0){
                    req = dts[0];
                    this.startfecha =Datetime.valueOfGmt(this.req.pOutStartDate.replaceALL('T',' '));
                    if(this.req.CreditBureauObj.cbCustomerType =='ORGANIZATION'){
                        this.proceso = 'BURO_CREDITO_PERSONA_MORAL';
                    }else if(this.req.CreditBureauObj.cbCustomerType =='INDIVIDUAL'){
                        this.proceso ='BURO_CREDITO_PERSONA_FISICA';
                    }

                    if(this.startfecha < this.fechaContent){
                        this.lightn = false;
                        this.visual = true;
                    }else{
                        this.lightn = true;
                        this.visual = false;
                    }
                }  
                yesnobtn();
                actioncamp(req.pOutRequestStatus);
                system.debug('btn'+editbtn);
                
            }
            
        }
        else{
            
            req.pOutCreatedBy = sSSO;
            req.pOutRequestedBy = sSSO;
            req.pOutStartDate = System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00'));
            req.pOutCreationDate = System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00'));
            req.pOutRequestStatus = 'NEW';
            actioncamp(req.pOutRequestStatus);
            req.pOutActiveFlag = 'Y';
            req.CreditBureauObj.cbAPIRequestor = sSSO;
            //legalname = req.CreditBureauObj.CBLegalPartyId + ' ' +req.CreditBureauObj.CBLegalPartyAlias;
            this.req.pOutRequestId =  (String)System.currentPageReference().getParameters().get('requestId');  
            this.req.pOutsourceTopParentName  = passnull((String) System.currentPageReference().getParameters().get('TopParentName'));
            this.req.pOutPartyId= (String) System.currentPageReference().getParameters().get('PartyId');
            this.req.pOutPartyName = passnull(Test.isRunningTest() ? 'a&' : quitaAnd((String) System.currentPageReference().getParameters().get('OracleAccountName')));
            this.req.CreditBureauObj.City = passnull((String)System.currentPageReference().getParameters().get('City'));
            this.req.CreditBureauObj.Country = passnull((String)System.currentPageReference().getParameters().get('Country'));
            this.req.CreditBureauObj.Suburb = passnull((String)System.currentPageReference().getParameters().get('County'));
            this.req.CreditBureauObj.municipality = passnull((String)System.currentPageReference().getParameters().get('Municipality'));
            this.req.CreditBureauObj.ZipCode = passnull((String)System.currentPageReference().getParameters().get('Zip_Code'));
            this.req.CreditBureauObj.State = passnull((String)System.currentPageReference().getParameters().get('State'));
            this.req.CreditBureauObj.outnum = passnull((String)System.currentPageReference().getParameters().get('Outdoor_Number'));
            this.req.CreditBureauObj.intnum = passnull((String)System.currentPageReference().getParameters().get('Interior_Number'));
            this.req.CreditBureauObj.RFC = passnull((String)System.currentPageReference().getParameters().get('RFC'));
            this.req.CreditBureauObj.Street=passnull((string)System.currentPageReference().getParameters().get('Street'));
            this.req.CreditBureauObj.CompanyName=passnull(Test.isRunningTest() ? 'a&' :quitaAnd((string)System.currentPageReference().getParameters().get('companyname')));
            this.req.CreditBureauObj.LetterSigningDate = Date.today();
            this.req.CreditBureauObj.cbCustomerType=passnull((string)System.currentPageReference().getParameters().get('entity'));
            this.req.CreditBureauObj.Address=passnull((string)System.currentPageReference().getParameters().get('purpuse'));
            this.req.CreditBureauObj.cbName = passnull((String)System.currentPageReference().getParameters().get('First_Name'));
            this.req.CreditBureauObj.cbSecondName = passnull((String)System.currentPageReference().getParameters().get('Middle_Name'));
            this.req.CreditBureauObj.cbLastName = passnull(Test.isRunningTest() ? 'a&' :quitaAnd((String)System.currentPageReference().getParameters().get('First_Last_Name')));
            this.req.CreditBureauObj.cbSecondLastName = passnull((String)System.currentPageReference().getParameters().get('Second_Last_Name'));
            //this.req.CreditBureauObj.Alias=this.req.CreditBureauObj.cbName+' '+this.req.CreditBureauObj.cbSecondName+' '+this.req.CreditBureauObj.cbLastName+' '+this.req.CreditBureauObj.cbSecondLastName;
            system.debug('variables que resive ' + this.req.CreditBureauObj.City+' '+this.req.CreditBureauObj.Country+' '+this.req.CreditBureauObj.municipality);
            
        }
    }
    public string passnull(String dato){
        if(dato!='null'){
            return dato;
        }else{
            return '';
        }
    }
    public PageReference editCB()
    {
        //falta logica del guardado
        /////***////
        
        req.pOutUpdatedBy = sSSO;
        PageReference pr = new PageReference('/apex/ES2_EditPage_CREDIT_BUREAU');
        pr.setRedirect(false); 
        return pr;        
    }      
    
    public PageReference saveCB()
    {
        ES2_controller_POSTjson ps = new ES2_controller_POSTjson();
        PageReference pr;
        if(req.CreditBureauObj.CBLegalPartyAlias=='' && req.CreditBureauObj.AutorizationLetter =='YES' || req.CreditBureauObj.LetterSigningPlace=='' && req.CreditBureauObj.AutorizationLetter =='YES' || req.CreditBureauObj.LetterSigningDate==null && req.CreditBureauObj.AutorizationLetter =='YES')
        {	String sJson = ps.postgeneral('CREDIT BUREAU', req);
         ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'faltan los campos marcados con un *'));	
         pr = new PageReference('/apex/ES2_EditPage_CREDIT_BUREAU');	
         pr.setRedirect(false); //Pasamos el controlador lleno	
        }else{
            String sJson = ps.postgeneral('CREDIT BUREAU', req);
            system.debug('POST CREDITBUREAU');
            system.debug(sJson);
            //jsonResponse = (Map<string,object>)JSON.deserializeUntyped(ES2_jsonDummy.entitymasterToJson());
            jsonResponse = EIV_EntityExtencionCalloutClass.postRequestDetail(sJson, sServiceURL);
            System.debug('postRequestDetail JJ: ' + jsonResponse);
            if (jsonResponse == null) //Error en ORACLE, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Oracle Server missing'));
                pr = new PageReference('/apex/ES2_EditPage_CREDIT_BUREAU');
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
                    pr = new PageReference('/apex/ES2_ReadPage_CREDIT_BUREAU?requestId=' + this.req.pOutRequestId);
                    pr.setRedirect(true); //Recargamos el controlador  
                    
                }
                else //Error en el salvado, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
                {
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,this.detail.errorCode));
                    pr = new PageReference('/apex/ES2_EditPage_CREDIT_BUREAU');
                    pr.setRedirect(false); //Pasamos el controlador lleno  
                }
                
            }
        }	return pr;	
    }   
    public boolean actioncamp(string data){
        txtrjectr=false;
        if(data=='IN PROCESS'){
            txtrjectr=false;
        }else{
            txtrjectr=true;
            
            
        }
        return txtrjectr; 
    }
    public string fecha(String data)
    {   
        system.debug('fecha que llega ' + data);
        if(data!=null) 
        { 
            String data2 =data.remove('/');
            system.debug('fecha que se va' + data2);
            return EncodingUtil.urlEncode(data2, 'UTF-8');  
        } else 
        { 
            return Datetime.now().format('DDMMYYYY');
        } 
    }
    
    public string ECEntity(string a){
        switch on a {
            when '397' {
                return 'EngencapHolding';
            }
            when '798' {
                return 'EngencapFin';
            }
            when 'XA7' {
                return 'Engencap';
            }
            when else {
                return 'Error ';
            }
        }
    }
    
    public string eToUrl(String data)
    {   
        system.debug('dato que llega '+data );
        if(data!=null) 
        { 
            
            
            return EncodingUtil.urlEncode(data, 'UTF-8');  
        } else 
        { 
            return '';
        } 
    }
    
    public string yesno(string e){	
        if(e=='YES'){	
            return 'S';	
        }else if(e=='NO'){	
            return 'N';	
        }else{	
            return '';	
        }	
    }	
    public String formatDate(Date dateToday)	
    {	
        if( String.valueOf(dateToday)==null )	
        {	
            dateToday = Date.today();	
        }	
        String sMonth = String.valueof(dateToday.month());	
        String sDay = String.valueof(dateToday.day());	
        if(sMonth.length()==1){	
            sMonth = '0' + sMonth;	
        }	
        if(sDay.length()==1){	
            sDay = '0' + sDay;
        }
        String sToday = sDay + sMonth + String.valueof(dateToday.year());
        return sToday;
    }
    public PageReference sendToCreditBureau()
    {
        string identifica = 'Yes';
        if(this.startfecha < this.fechaContent){
            system.debug('LA FECHA ES MENOR');
            system.debug('lo que me llega de doctype'+ req.DocTypesObj);
            integer i = req.DocTypesObj.size();
            system.debug('size ' +i);
            for(integer a=0;a<i;a++){
                system.debug('prms ' + req.DocTypesObj[a].prm1);
                if(req.DocTypesObj[a].prm1 == 'REQUIRED' && req.DocTypesObj[a].prm1 !='OK'){
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'falta '+ req.DocTypesObj[a].name));
                    identifica='No';
                }
            }
        }else{
            system.debug('LA FECHA ES MAYOR O IGUAL');
            string datos = '{"userId":"'+this.usuario.EmployeeNumber +'",'+'"userName":"'+this.usuario.Name +'",'+ '"typeProcessCode":"'+this.proceso+'",'+'"processFKId":"'+this.req.pOutRequestId+'",'+'"identifiers":[]'+'}';
            system.debug(datos);
            string tollgates =TKD_ChecklistTolgate1Controller.requestToContent(datos);
            system.debug(tollgates);
            EntityMaster_Documents_TollgateWrapper tollgate =(EntityMaster_Documents_TollgateWrapper) JSON.deserialize(tollgates, EntityMaster_Documents_TollgateWrapper.class);
            for (EntityMaster_Documents_TollgateWrapper.Processfile process : tollgate.identifiers[0].processFiles) {
                if(process.required == 1 && process.isValid ==0){
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'falta '+ process.typeDocumentName));
                    identifica='No';
                }
            }
        }
       
        String sCBDummyFlag = [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='CBDummyFlag'][0].EIV_tx_parameter__c; 
        PageReference pr;
        if(identifica!='No'){
            //jsonResponse = (Map<string,object>)JSON.deserializeUntyped(ES2_jsonDummy.entitymasterToJson());
            
            Map<String, Object> supermap = new Map<String, Object>();
            
            supermap.put('sSSO',sSSO);
            supermap.put('requestId',req.pOutRequestId);
            supermap.put('rfc',req.CreditBureauObj.RFC);
            supermap.put('companyName',eToUrl(req.CreditBureauObj.Alias));
            supermap.put('name',eToUrl(req.CreditBureauObj.cbName));
            supermap.put('sname',eToUrl(req.CreditBureauObj.cbSecondName));
            supermap.put('lname',eToUrl(req.CreditBureauObj.cbLastName));
            supermap.put('slname',eToUrl(req.CreditBureauObj.cbSecondLastName));
            supermap.put('address',eToUrl(req.CreditBureauObj.Street+' '+eToUrl(req.CreditBureauObj.intnum)+' '+eToUrl(req.CreditBureauObj.outnum)));
            supermap.put('ecEntity',eToUrl(ECEntity(req.CreditBureauObj.ECEntity)));
            supermap.put('letterSigningDate',formatDate(req.CreditBureauObj.LetterSigningDate));
            supermap.put('suburb',eToUrl(req.CreditBureauObj.Suburb));
            supermap.put('zipCode',req.CreditBureauObj.ZipCode);
            supermap.put('city',eToUrl(req.CreditBureauObj.Municipality));
            supermap.put('state',eToUrl(req.CreditBureauObj.State));
            supermap.put('autorizationLetter', yesno(req.CreditBureauObj.AutorizationLetter) );
            supermap.put('sourceAccountId',eToUrl(req.pOutSourceAccountId));
            supermap.put('sourceAccountName','sourceAccountName' );
            supermap.put('sourceTopParentId',eToUrl(req.pOutSourceTopParentId));
            supermap.put('sourceTopParentName',eToUrl(req.pOutSourceTopParentName) );
            supermap.put('partyId',eToUrl(req.pOutPartyId));
            supermap.put('partyName',req.pOutPartyName);
            supermap.put('comment',eToUrl('Credit Bureau Solicitado desde Salesforce'));
            supermap.put('contractNumber','contractNumber' );
            supermap.put('anex','anex');
            supermap.put('egPartyId',eToUrl(req.pOutEGPartyId));
            supermap.put('egPartyName',eToUrl(req.pOutEGPartyName));
            supermap.put('sourceOpId',eToUrl(req.pOutSourceOpId));
            supermap.put('sourceCAId',eToUrl(req.pOutSourceCAId));
            supermap.put('createdBy',eToUrl(req.pOutCreatedBy));
            supermap.put('dummyFlag',sCBDummyFlag);
            supermap.put('county',req.CreditBureauObj.Suburb);
            supermap.put('Entity',req.CreditBureauObj.cbCustomerType);
            
            
            jsonResponse = EIV_EntityExtencionCalloutClass.callBackCreditBureau(sServiceURL,supermap);
            System.debug('get ( que es post ) para Credit Bureau: ' + jsonResponse);
            if (jsonResponse == null) //Error en ORACLE, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Oracle Server missing'));
                pr = new PageReference('/apex/ES2_ReadPage_CREDIT_BUREAU');
                pr.setRedirect(false); //Pasamos el controlador lleno 
            }
            else
            {
                //El resultado tiene status
                Map<String, Object> CB = (Map<String, Object>)jsonResponse.get('creditBureau');
                
                Map<String, Object> status = (Map<String, Object>)jsonResponse.get('status');
                System.debug('Received the following JSON response of status OEJ01:' + status);
                detail = new EIV_DetailWrapClass();
                this.detail.errorCode =  (String)status.get('code'); //{code=S,N, detail=0, message=0}
                this.detail.description =  (String)status.get('detail');
                this.detail.message =  (String)status.get('message');
                
                
                if(this.detail.description == 'S') //Exito en el salvado, pasamos a la pagina de lectura de la Entidad y recargamos el controlador
                {
                    this.req.CreditBureauObj.cbTransactionId= (String)CB.get('transactionId');
                    //ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,this.detail.message)); 
                    saveCB();
                    
                    pr = new PageReference('/apex/ES2_ReadPage_CREDIT_BUREAU');
                    pr.setRedirect(false); //NO recargamos el controlador 
                    
                }
                else //Error en el salvado, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
                {
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,this.detail.errorCode));
                    pr = new PageReference('/apex/ES2_ReadPage_CREDIT_BUREAU');
                    pr.setRedirect(false); //Pasamos el controlador lleno  
                }
                
            } 
            
        }
        
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
            pr = new PageReference('/apex/ES2_EditPage_CREDIT_BUREAU');
            pr.setRedirect(false);
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'No existe el Party ID de la entidad en Oracle'));
        }           
        
        return pr;        
    } 
    
    public PageReference newcoment()
    {
        //falta logica del guardado
        /////***////
        
        PageReference pr = new PageReference('/apex/ES2_EditPage_ADD_COMENTARIOS?TopParentID=' + +this.req.pOutsourceTopParentId+ 
                                             '&TopParentName=' + this.req.pOutsourceTopParentName + 
                                             '&OracleAccountName=' + this.req.pOutPartyName +  
                                             '&PartyId='+this.req.pOutPartyId+
                                             '&requestId='+this.req.pOutRequestId +
                                             '&dir=CB');
        pr.setRedirect(false); //Pasamos el controlador vacio  
        return pr;        
    }
    
    public PageReference recarga(){
        PageReference pr;
        pr= new PageReference('/apex/ES2_ReadPage_CREDIT_BUREAU?requestId=' + req.pOutRequestId + '&sso' + sSSO);
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
            string backUrl = System.Url.getSalesforceBaseURL().toExternalForm() + '/one/one.app#/alohaRedirect/apex/ES2_ReadPage_CREDIT_BUREAU?requestId='+ requestId;
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
        string backUrl = System.Url.getSalesforceBaseURL().toExternalForm() + '/one/one.app#/alohaRedirect/apex/ES2_ReadPage_CREDIT_BUREAU?requestId='+ requestId;
        
        
        
        
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
        
        string backUrl = System.Url.getSalesforceBaseURL().toExternalForm() + '/one/one.app#/alohaRedirect/apex/ES2_ReadPage_CREDIT_BUREAU?requestId='+ RequestId;
        
        STRING clearText = 'contentDocId='+ docId + '&backUrl=' +backUrl +'&urlserver='+ URL_Servicio_Externa + '&cddate=' + cddate;
        Blob key = Blob.valueOf(KeyEncriptation);
        Blob textoEncB = Crypto.encryptWithManagedIV(EncriptationType, key, Blob.valueOf(clearText));
        String textoEnc = EncodingUtil.base64Encode(textoEncB);
        string encodedTextAES = UrlAppDoctos + '/xxec_episodioIVDocuments-vcDocuments-context-root/faces/documentDownloadFile.jspx?params=' + textoEnc;
        System.debug(encodedTextAES);
        return encodedTextAES;
    }
    
    public string entities(string p){
        string res;
        if(p=='ind'){
            res = 'individual';
        }else if(p=='org'){
            res = 'organizacion';
        }else{
            res ='null';
        }
        return res;
    }    
    public PageReference send()
    {
        string identifica = 'Yes';
        system.debug('lo que me llega de doctype'+ req.DocTypesObj);
        PageReference pr;
        integer i = req.DocTypesObj.size();
        system.debug('size ' +i);
        if(this.startfecha < this.fechaContent  ){
            system.debug('LA FECHA ES MENOR');
            for(integer a=0;a<i;a++){
                system.debug('prms ' + req.DocTypesObj[a].prm1);
                if(req.DocTypesObj[a].prm1 == 'REQUIRED' && req.DocTypesObj[a].prm1 !='OK'){
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'falta '+ req.DocTypesObj[a].name));
                    identifica='No';
                }
            }
        }else{
            system.debug('LA FECHA ES mayor o igual');
            string datos = '{"userId":"'+this.usuario.EmployeeNumber +'",'+'"userName":"'+this.usuario.Name +'",'+ '"typeProcessCode":"'+this.proceso+'",'+'"processFKId":"'+this.req.pOutRequestId+'",'+'"identifiers":[]'+'}';
            system.debug(datos);
            string tollgates =TKD_ChecklistTolgate1Controller.requestToContent(datos);
            system.debug(tollgates);
            EntityMaster_Documents_TollgateWrapper tollgate =(EntityMaster_Documents_TollgateWrapper) JSON.deserialize(tollgates, EntityMaster_Documents_TollgateWrapper.class);
            for (EntityMaster_Documents_TollgateWrapper.Processfile process : tollgate.identifiers[0].processFiles) {
                if(process.required == 1 && process.isValid ==0){
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'falta '+ process.typeDocumentName));
                    identifica='No';
                }
            }
        }
      
        if(identifica!='No'){
            
            pr = saveStatusGeneral(req.pOutRequestStatus, 'PENDING','' );
            
        }
        
        return pr; 
    }
    
    public PageReference edit()
    {
        
        PageReference pr = saveStatusGeneral(req.pOutRequestStatus, 'EDIT','' );
        return pr;        
    }  
    
    public PageReference accept()
    {
        
        PageReference pr = saveStatusGeneral(req.pOutRequestStatus, 'IN PROCESS','' );
        return pr;        
    }     
    public PageReference onHold()
    {
        
        PageReference pr = saveStatusGeneral(req.pOutRequestStatus, 'ON HOLD','' );
        return pr;        
    }  
    public PageReference rework()
    {
        
        PageReference pr = saveStatusGeneral(req.pOutRequestStatus, 'REWORK','' );
        return pr;        
    }  
    public PageReference reject()
    {
        
        PageReference pr = saveStatusGeneral(req.pOutRequestStatus, 'REJECTED','' );
        return pr;        
    }  
    /*public PageReference preApprove()
{

PageReference pr = saveStatusGeneral(req.pOutRequestStatus, 'PRE APPROVED','' );
return pr;        
}*/
    public PageReference approve()
    {
        
        PageReference pr = saveStatusGeneral(req.pOutRequestStatus, 'APPROVED','' );
        return pr;        
    }  
    public PageReference cancel()
    {
        
        PageReference pr = saveStatusGeneral(req.pOutRequestStatus, 'CANCELLED BY REQUESTOR','' );
        return pr;        
    }      
    
    public PageReference saveStatusGeneral(String oldStatus, String sStatus, String dummyF)
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
        
        
        String sJson = ps.postgeneral('CREDIT BUREAU', req);
        
        //jsonResponse = (Map<string,object>)JSON.deserializeUntyped(ES2_jsonDummy.entitymasterToJson());
        jsonResponse = EIV_EntityExtencionCalloutClass.postRequestDetail(sJson, sServiceURL);
        System.debug('postRequestDetail JJ: ' + jsonResponse);
        if (jsonResponse == null) //Error en ORACLE, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Oracle Server missing'));
            req.pOutRequestStatus = oldStatus;
            pr = new PageReference('/apex/ES2_ReadPage_CREDIT_BUREAU');
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
                pr = new PageReference('/apex/ES2_ReadPage_CREDIT_BUREAU?requestId=' + this.req.pOutRequestId);
                pr.setRedirect(true); //Recargamos el controlador  
                
            }
            else //Error en el salvado, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,this.detail.errorCode));
                req.pOutRequestStatus = oldStatus;
                pr = new PageReference('/apex/ES2_ReadPage_CREDIT_BUREAU');
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
            else if(req.privilegeObj[a].section == 'SEND TO BURO'){
                sendtoCBbtn = cambia(req.privilegeObj[a].vCrud);
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
                //reworkbtn = cambia(req.privilegeObj[a].vCrud);
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
    
    public string quitaAnd(string s2){
        string regExp2 ='\\|';
        string replacement2 = '&';
        string S3 = s2.replaceAll(regExp2, replacement2);
        return s3;
    }
}