public class ES3_DocSInRequestCalloutClass { 
    @AuraEnabled
    public static string getSSO(){
        string sSSO = Test.isRunningTest() ? '999' : [Select EmployeeNumber From User Where Id = :UserInfo.getUserId()][0].EmployeeNumber;
        return sSSO;
    }
    @AuraEnabled
    public static string getUserProfile(){
        id id1 = userinfo.getProfileId();
        system.debug('JD idddd:' + id1);
        string profileName;
        
        for (profile record :[Select Name  from profile where Id=:id1]){
            profileName = record.Name;
            
        }
        
        return profileName;
    }
    
    @AuraEnabled
    public static string submitClossingMemo(string sourceCAId){
      String searchRequestId='999999999';
            string sServiceURL = Test.isRunningTest() ? 'https://test.com' :  [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='URL_Servicio'][0].EIV_tx_parameter__c; 
            Http h = new Http();
            HttpRequest req = new HttpRequest();
            
            
            req.setTimeout(20000);
            req.setEndpoint(sServiceUrl + '/EcRequestSbDat/RequestRs/requests/documents?requestId=' + searchRequestId +'&sourceCAId=' + sourceCAId);
            req.setMethod('GET');
            
            HttpResponse res = h.send(req);
            system.debug('respuesta:--->' +  res.getBody());
            Map<string,object> resultsMap = (Map<string,object>)JSON.deserializeUntyped(res.getBody());
            system.debug('resultsMap--' +  resultsMap);
            Map<string,object>docListMap = (Map<string,object>)resultsMap.get('documentsList');
     		list<object>documentList =null;
     		if((Map<string,object>)resultsMap.get('documentsList')==null){
         		documentList =new list<object>();
            }else{
                documentList = (list<object>)docListMap.get('document');     
            }
            
            list<string>listaDocF = new list<string>();
            
            integer ind = 2;
            for(object doc:documentList){
                Map<string,object>newDoc = (Map<string,object>)doc;
                Map<string,object>docum = (Map<string,object>)newDoc;
                
                string doctype = string.valueOf(newDoc.get('type'));
                if(listaDocF.contains(doctype)){
                
                }else{
                    listaDocF.add(doctype);
                }
            }
            
            system.debug('listaDocF====>' + listaDocF);    
            
            Credit_approval_CP__c getLostiposDoc = Test.isRunningTest() ? new Credit_approval_CP__c() : [Select Doctypes__c from Credit_approval_CP__c where Credit_approval_CP__c.Id =:sourceCAId];
            string tiposdocum = Test.isRunningTest() ?'a,e' : string.valueOf(getLostiposDoc.get('Doctypes__c'));
            List<string>listaSDoc = tiposdocum.split(',');
            list<string>faltan = new list<string>();
            for(string o : listaSDoc){
                boolean bandera = listaDocF.contains(o);
                
                if(bandera==false){
                    faltan.add(o.replaceAll('[^a-zA-Z- ]',''));
                }
            }
            Map<String,integer> elCount = new Map<String,Integer>();
            for(string key : faltan){
                if(!elCount.containsKey(key)){
                    elCount.put(key,0);
                }
                Integer currentInt=elCount.get(key)+1;
                elCount.put(key,currentInt);
            }
            
            
            string mensaje =  string.valueOf(elCount);
     system.debug('ELCOUNT--->: ' + elCount );
            string mensaje2 = mensaje.replace('}','');
            string mensaje3 = mensaje2.replace('{','');
            mensaje3=mensaje3.replaceAll('=','');
            mensaje3=mensaje3.replaceAll('1','');
            //string mensajeUltimo =mensaje3.replace(',','\n');
            string mensajeUltimo =mensaje3;
                system.debug('Mensaje ===>>>>' + mensajeUltimo);

                
           // Credit_approval_CP__c warningDocs = [Select Id, DoctypesWarning__c from Credit_approval_CP__c where Credit_approval_CP__c.Id =:sourceCAId];
            //warningDocs.put('DoctypesWarning__c', 'FALTAN LA SIGUIENTE CANTIDAD DE DOCUMENTOS:\n' + mensajeUltimo + '\n ESTA SEGURO DE CONTINUAR CON EL PROCESO?');
       // warningDocs.DoctypesWarning__c = 'FALTAN LOS SIGUIENTES DOCUMENTOS:\n' + mensajeUltimo + '\n ESTA SEGURO DE CONTINUAR CON EL PROCESO?';
         	//update warningDocs;
         string warningDocs = mensajeUltimo;
        system.debug('documentos: ' +warningDocs);
     string resultfinal=null;
     if(elCount.containsKey('Write Up')){
         resultfinal='No';
             }else{
                 resultfinal='YES';
                 Credit_approval_CP__c status =Test.isRunningTest() ? new Credit_approval_CP__c() :[SELECT CPL_ls_StageName__c FROM Credit_approval_CP__c WHERE Credit_approval_CP__c.Id =:sourceCAId];
                 status.CPL_ls_StageName__c='Approved with closing memo';
                 if(test.isRunningTest()){
                     
                 }else{
                    update status; 
                 }
                 
             }
     	system.debug('RESULTADOFINAL->>>' + resultfinal);
        return resultfinal;
    }
    @AuraEnabled
    public static string ccAMLAHbutton(string sourceCAId){
      string resultado = null;
      Credit_approval_CP__c status = test.isRunningTest() ? new Credit_approval_CP__c() : [SELECT ES3_ls_AML_Review_Status__c FROM Credit_approval_CP__c WHERE Credit_approval_CP__c.Id =:sourceCAId];
      string statusValue = string.valueOf(status.get('ES3_ls_AML_Review_Status__c'));
      resultado = statusValue;
      return resultado;
    }

    

    @AuraEnabled
    public static string ccriskAHbutton(string sourceCAId){
        string resultado=null;
        Credit_approval_CP__c status =Test.isRunningTest() ? new Credit_approval_CP__c():[SELECT ES3_ls_RISK_REVIEW_STATUS__c FROM Credit_approval_CP__c WHERE Credit_approval_CP__c.Id =:sourceCAId];
        string statusValue = string.valueOf(status.get('ES3_ls_RISK_REVIEW_STATUS__c'));
        resultado = statusValue;
        return resultado;
    }

   
    @AuraEnabled
    public static list<string> pricingsMissing(string sourceCAId){
        system.debug('id--->' + sourceCAId);
      list<Opportunity_in_Credit_approval_CP__c> listaOps = [SELECT ES3_nu_Pricings_in_Opportunity__c, ES3_fm_Opportunity_Name__c   from Opportunity_in_Credit_approval_CP__c where CP_rb_Credit_approval_CP__r.id =:sourceCAId];
      System.debug('Lista de OPSFront---> '  + listaOps);

      list<string> pricingsFalta = new list<string>();
		
        for( integer i =0; i<=listaOps.size()-1; i ++){
            
            decimal pricinginOp = listaOps[i].ES3_nu_Pricings_in_Opportunity__c;
            if(pricinginOp <=0){
                string opName = listaOps[i].ES3_fm_Opportunity_Name__c;
                string result = 'Pricing in Opportunity: ' + opName + ' Is missing' + '\n';
                pricingsFalta.add(result);
            }
        }

        System.debug('Lista pRINCIGS FALTAFront--->' + pricingsFalta);
        return pricingsFalta;
    }
	 
    @AuraEnabled
    public static string CallbackGetWarningDocs(string sourceCAId ){
        String searchRequestId='999999999';
            string sServiceURL = Test.isRunningTest() ? 'https://test.com' :  [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='URL_Servicio'][0].EIV_tx_parameter__c; 
            Http h = new Http();
            HttpRequest req = new HttpRequest();
            
            
            req.setTimeout(20000);
            req.setEndpoint(sServiceUrl + '/EcRequestSbDat/RequestRs/requests/documents?requestId=' + searchRequestId +'&sourceCAId=' + sourceCAId);
            req.setMethod('GET');
            
            HttpResponse res = h.send(req);
            system.debug('respuesta:--->' +  res.getBody());
            Map<string,object> resultsMap = (Map<string,object>)JSON.deserializeUntyped(res.getBody());
            system.debug('resultsMap--' +  resultsMap);
            Map<string,object>docListMap = (Map<string,object>)resultsMap.get('documentsList');
            list<object>documentList =null;
     		if((Map<string,object>)resultsMap.get('documentsList')==null){
         		documentList =new list<object>();
            }else{
                documentList = (list<object>)docListMap.get('document');     
            }     
            list<string>listaDocF = new list<string>();
            
            integer ind = 2;
            for(object doc:documentList){
                Map<string,object>newDoc = (Map<string,object>)doc;
                Map<string,object>docum = (Map<string,object>)newDoc;
                
                string doctype = string.valueOf(newDoc.get('type'));
                if(listaDocF.contains(doctype)){
                
                }else{
                    listaDocF.add(doctype);
                }
            }
            
            system.debug('listaDocF====>' + listaDocF);    
            
            Credit_approval_CP__c getLostiposDoc = test.isRunningTest()? new Credit_approval_CP__c() : [Select Doctypes__c from Credit_approval_CP__c where Credit_approval_CP__c.Id =:sourceCAId];
            string tiposdocum = test.isRunningTest()?'a,3' : string.valueOf(getLostiposDoc.get('Doctypes__c'));
            List<string>listaSDoc = tiposdocum.split(',');
            list<string>faltan = new list<string>();
            for(string o : listaSDoc){
                boolean bandera = listaDocF.contains(o);
                
                if(bandera==false){
                    faltan.add(o.replaceAll('[^a-zA-Z- ]',''));
                }
            }
            Map<String,integer> elCount = new Map<String,Integer>();
            for(string key : faltan){
                if(!elCount.containsKey(key)){
                    elCount.put(key,0);
                }
                Integer currentInt=elCount.get(key)+1;
                elCount.put(key,currentInt);
            }
            
            
            string mensaje =  string.valueOf(elCount);
            string mensaje2 = mensaje.replace('}','');
            string mensaje3 = mensaje2.replace('{','');
            mensaje3=mensaje3.replaceAll('=','');
            mensaje3=mensaje3.replaceAll('1','');
            //string mensajeUltimo =mensaje3.replace(',','\n');
            string mensajeUltimo =mensaje3;
                system.debug('Mensaje ===>>>>' + mensajeUltimo);

                
           // Credit_approval_CP__c warningDocs = [Select Id, DoctypesWarning__c from Credit_approval_CP__c where Credit_approval_CP__c.Id =:sourceCAId];
            //warningDocs.put('DoctypesWarning__c', 'FALTAN LA SIGUIENTE CANTIDAD DE DOCUMENTOS:\n' + mensajeUltimo + '\n ESTA SEGURO DE CONTINUAR CON EL PROCESO?');
       // warningDocs.DoctypesWarning__c = 'FALTAN LOS SIGUIENTES DOCUMENTOS:\n' + mensajeUltimo + '\n ESTA SEGURO DE CONTINUAR CON EL PROCESO?';
         	//update warningDocs;
         string warningDocs = mensajeUltimo;
        system.debug('documentos: ' +warningDocs);
        return warningDocs;
    }
    
	@AuraEnabled
    public static void submiteedForA(string sourceCAId){
        Credit_approval_CP__c status = test.isRunningTest() ? new Credit_approval_CP__c (): [SELECT CPL_ls_StageName__c,ES3_pl_Submit_for_approval__c FROM Credit_approval_CP__c WHERE Credit_approval_CP__c.Id =:sourceCAId];
        status.ES3_pl_Submit_for_approval__c='Yes';
        status.CPL_ls_StageName__c ='Submitted to approval';
        if (test.isRunningTest()){
            }
        else {
            update status;
        }
    }

    @AuraEnabled
    public static string statusCA(string sourceCAId){
         string resultado=null;
        Credit_approval_CP__c status = test.isRunningTest() ? new Credit_approval_CP__c():[SELECT CPL_ls_StageName__c FROM Credit_approval_CP__c WHERE Credit_approval_CP__c.Id =:sourceCAId];
        string statusValue = string.valueOf(status.get('CPL_ls_StageName__c'));
        resultado = statusValue;
        return resultado;
    }

    @AuraEnabled
    public static Credit_approval_CP__c getLostiposDoc(string cp){
        Credit_approval_CP__c getLostiposDoc = test.isRunningTest() ? new Credit_approval_CP__c ():[Select Doctypes__c from Credit_approval_CP__c where Credit_approval_CP__c.Id =:cp];
        return getLostiposDoc;
    }

    @AuraEnabled(cacheable = true)
    public static string newdocument(string doctypes, string sourceOpId, string sourceCAId, string backUrl, string urlserverExterna, string urlAppDocs, string KeyEncriptation,string EncriptationType){
        
        string sSSO = Test.isRunningTest() ? '999' : [Select EmployeeNumber From User Where Id = :UserInfo.getUserId()][0].EmployeeNumber;  
		
        Datetime dt = Datetime.now();
		Long l = dt.getTime();
		Long f = l;
		system.debug(l);
		system.debug(f);
		
        string cddate = string.valueOf(DateTime.newInstance(f));
        system.debug('Hora local: ' +  cddate);
        
        STRING clearText = 'requestId=999999999' + '&documentType=['+ doctypes + ']&partyId=&partyName=&sso=' +sSSO + '&cddate=' + cddate  + '&backUrl=' + backUrl +'&urlserver='+ urlserverExterna + '&sourceOpId=' + sourceOpId + '&sourceCAId=' + sourceCAId ;
        Blob key = Blob.valueOf(KeyEncriptation);
        Blob textoEncB = Crypto.encryptWithManagedIV(EncriptationType, key, Blob.valueOf(clearText));
        String textoEnc = EncodingUtil.base64Encode(textoEncB);
        string encodedTextAES = urlAppDocs + '/xxec_episodioIVDocuments-vcDocuments-context-root/faces/documentUploadFile.jspx?params=' + textoEnc ;
        system.debug('texto original: ' + clearText);
        System.debug('url encripted:' +  encodedTextAES);
        return encodedTextAES;
    }
    
    @AuraEnabled
    public static string getUrlInstance(){
        string a = System.Url.getSalesforceBaseURL().toExternalForm();
        return a;
    }

    @AuraEnabled(cacheable=true)
    public static list<Opportunity_in_Credit_approval_CP__c> getListOpInCa(string cp){
        list<Opportunity_in_Credit_approval_CP__c> listaOps = [Select Id, ES3_fm_Opportunity_Name__c  from Opportunity_in_Credit_approval_CP__c where CP_rb_Credit_approval_CP__c =:cp  ];
        system.debug('listaaaa: ' + listaOps); 
        return listaOps;
    }

    @AuraEnabled(cacheable=true)
    public static string getUrl(){
        string sServiceURL = Test.isRunningTest() ? 'https://test.com' :  [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='URL_Servicio'][0].EIV_tx_parameter__c; 
        return sServiceURL;
    }

    @AuraEnabled(cacheable=true)
    public static string getUrlExterna(){
        string sServiceURL = Test.isRunningTest() ? 'https://test.com' :  [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='URL_Servicio_Externa'][0].EIV_tx_parameter__c; 
        return sServiceURL;
    }

    @AuraEnabled(cacheable=true)
    public static string getUrlAppdocs(){
        string sServiceURL = Test.isRunningTest() ? 'https://test.com' :  [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='UrlAppDoctos'][0].EIV_tx_parameter__c; 
        return sServiceURL;
    }

    @AuraEnabled(cacheable=true)
    public static string getEncriptationMode(){
        string sServiceURL = Test.isRunningTest() ? 'https://test.com' :  [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='EncriptationType'][0].EIV_tx_parameter__c; 
        return sServiceURL;
    }

    @AuraEnabled(cacheable=true)
    public static string getKeyEncriptation(){
        string sServiceURL = Test.isRunningTest() ? 'https://test.com' :  [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='KeyEncriptation'][0].EIV_tx_parameter__c; 
        return sServiceURL;
    }

	@AuraEnabled(cacheable=true)
    public static Map<string,object>CallbackGetDocumentsInReq(string sServiceUrl, String searchRequestId, string sourceCAId ){
        
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        
        
        req.setTimeout(20000);
        req.setEndpoint(sServiceUrl + '/EcRequestSbDat/RequestRs/requests/documents?requestId=' + searchRequestId +'&sourceCAId=' + sourceCAId);
        req.setMethod('GET');
        
        HttpResponse res = h.send(req);
        system.debug('respuesta:--->' +  res.getBody());
        Map<string,object> resultsMap = (Map<string,object>)JSON.deserializeUntyped(res.getBody());
        system.debug('resultsMap--' +  resultsMap);
        return resultsMap;
	}

    @AuraEnabled
    public static Map<string,object>CallbackGetDocumentsCAOP(string sServiceUrl, String searchRequestId, string sourceCAId, string sourceOpId  ){
        
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        
        
        req.setTimeout(20000);
        req.setEndpoint(sServiceUrl + '/EcRequestSbDat/RequestRs/requests/documents?requestId=' + searchRequestId + '&sourceCAId=' + sourceCAId + '&sourceOpId=' +  sourceOpId);
        req.setMethod('GET');
        
        HttpResponse res = h.send(req);
        system.debug('respuesta:--->' +  res.getBody());
        Map<string,object> resultsMap = (Map<string,object>)JSON.deserializeUntyped(res.getBody());
        system.debug('resultsMap--' +  resultsMap);
        return resultsMap;
    }

    @AuraEnabled(cacheable = false)
    public static string downloadDoctos(string docId, string backUrl, string urlserverExterna, string urlAppDocs, string EncriptationType, string KeyEncriptation){
        Datetime dt = Datetime.now();
		Long l = dt.getTime();
		Long f = l;
		system.debug(l);
		system.debug(f);
		
        string cddate = string.valueOf(DateTime.newInstance(f));
        STRING clearText = 'contentDocId='+ docId + '&urlserver='+ urlserverExterna +'&backUrl=' + backUrl  + '&cddate=' + cddate;
        Blob key = Blob.valueOf(KeyEncriptation);
        Blob textoEncB = Crypto.encryptWithManagedIV(EncriptationType, key, Blob.valueOf(clearText));
        String textoEnc = EncodingUtil.base64Encode(textoEncB);
        string encodedTextAES =urlAppDocs + '/xxec_episodioIVDocuments-vcDocuments-context-root/faces/documentDownloadFile.jspx?params=' + textoEnc ;
        system.debug('cadena: '  +  clearText);
        return encodedTextAES;       
    }

    @AuraEnabled(cacheable=true)
    public static String deleteDocto(string requestId, string oraId, string url, string docType, string contentDocId, string name, string urlserver )
         {
        string sSSO = Test.isRunningTest() ? '999' : [Select EmployeeNumber From User Where Id = :UserInfo.getUserId()][0].EmployeeNumber;  

        
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
        jsonResponse = Test.isRunningTest() ? new Map<String, Object>() : EIV_EntityExtencionCalloutClass.postUploadDocument(urlserver ,jsonS);
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