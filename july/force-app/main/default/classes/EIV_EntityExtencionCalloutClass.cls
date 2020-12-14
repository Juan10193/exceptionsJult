global class EIV_EntityExtencionCalloutClass 
{
    global EIV_EntityExtencionCalloutClass(ApexPages.StandardController sc) {}
    
    /********************************INICIA CALLOUTS DE TABLAS LA******************************************/
    //WS Tabla limitantes
    @RemoteAction
    global static Map<String, Object> callBack_Tabla_Limitantes(String JSON_Post, String sServiceURL){
        System.debug(LoggingLevel.INFO,'Inicia callBack_Tabla_Limitantes');
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        Map<String, Object> results2;
        Map<String, Object> results = null;
        try {
            request.setEndpoint(sServiceURL + '/EcRequestSbDat/SFRequestTypeDetailsRs/sfRequestTypeDetails/legalAssessments/details/enterprises/limitations');                     
            request.setHeader('Content-Type', 'application/json');
            request.setMethod('POST');
            request.setBody(JSON_Post);
            request.setTimeout(120000);
            
            System.debug('Send the following request from callBack:' + request);
            HttpResponse response = http.send(request);
            System.debug('Received the following response from callBack:' + response);
            if (response.getStatusCode() == 200){
                System.debug(LoggingLevel.DEBUG,'Received the following JSON response of callBack:' + response.getBody());            
            } else {
                System.debug(LoggingLevel.WARN,'Received the following JSON response of callBack:' + response.getBody());
            }
        } catch(Exception e) {
            System.debug(LoggingLevel.ERROR,'Ocurrió un error al consultar el WS ' + e);
            System.debug(LoggingLevel.ERROR,'Line ' + e.getLineNumber());
            System.debug(LoggingLevel.ERROR,'Cause ' + e.getCause());
        }
        System.debug(LoggingLevel.INFO,'Termina callBack_Tabla_Limitantes');
        return results;
    }
    //WS Tabla Modificaciones
    @RemoteAction
    global static Map<String, Object> callBack_Tabla_Modificaciones(String JSON_Post, String sServiceURL)
    {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        Map<String, Object> results2;
        Map<String, Object> results = null;
        try {
  
            request.setEndpoint(sServiceURL + '/EcRequestSbDat/SFRequestTypeDetailsRs/sfRequestTypeDetails/legalAssessments/details/enterprises/modifications');
            request.setHeader('Content-Type', 'application/json');
            request.setMethod('POST');
            request.setTimeout(120000);
            request.setBody(JSON_Post);
            System.debug('Send the following request from callBack:' + request);
            HttpResponse response = http.send(request);
            System.debug('Received the following response from callBack:' + response);
            
            // If the request is successful, parse the JSON response.
            if (response.getStatusCode() == 200){
                // Deserializes the JSON string into collections of primitive data types.
                results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                System.debug('Received the following JSON response of callBack:' + response.getBody());            
            }
        } catch(Exception e) {
            System.debug(LoggingLevel.ERROR,'Ocurrió un error al consultar el WS ' + e);
            System.debug(LoggingLevel.ERROR,'Line ' + e.getLineNumber());
            System.debug(LoggingLevel.ERROR,'Cause ' + e.getCause());
        }
        System.debug(LoggingLevel.INFO,'Termina callBack_Tabla_Limitantes');
        return results;
    }  
    //WS Tabla Apoderados
    @RemoteAction
    global static Map<String, Object> callBack_Tabla_Apoderados(String JSON_Post, String sServiceURL){
        System.debug(LoggingLevel.INFO,'Inicia callBack_Tabla_Apoderados');
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        Map<String, Object> results2;
        Map<String, Object> results = null;
        try {

            request.setEndpoint(sServiceURL + '/EcRequestSbDat/SFRequestTypeDetailsRs/sfRequestTypeDetails/legalAssessments/details/enterprises/attorneys');                     
            request.setHeader('Content-Type', 'application/json');
            request.setMethod('POST');
            request.setBody(JSON_Post);
            request.setTimeout(120000);
            System.debug('Send the following request from callBack:' + request);
            HttpResponse response = http.send(request);
            System.debug('Received the following response from callBack:' + response);
            if (response.getStatusCode() == 200){
                System.debug(LoggingLevel.DEBUG,'Received the following JSON response of callBack:' + response.getBody()); 
                Map<String, Object> m = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
                Map<String, Object> m2 =(Map<String, Object>)m.get('status');
                results = m2;
                
            } else {
                System.debug(LoggingLevel.WARN,'Received the following JSON response of callBack:' + response.getBody());
                
                
            }
        } catch(Exception e) {
            System.debug(LoggingLevel.ERROR,'Ocurrió un error al consultar el WS');
        }
        System.debug(LoggingLevel.INFO,'Termina callBack_Tabla_Apoderados');
        return results;
    }
    //WS Tabla estatutos
    @RemoteAction
    global static Map<String, Object> callBack_Tabla_Estatutos(String JSON_Post, String sServiceURL){
        System.debug(LoggingLevel.INFO,'Inicia callBack_Tabla_Estatutos');
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        Map<String, Object> results2;
        Map<String, Object> results = null;
        try {

            request.setEndpoint(sServiceURL + '/EcRequestSbDat/SFRequestTypeDetailsRs/sfRequestTypeDetails/legalAssessments/details/enterprises/statutes');                     
            request.setHeader('Content-Type', 'application/json');
            request.setMethod('POST');
            request.setBody(JSON_Post);
            request.setTimeout(120000);
            
            System.debug('Send the following request from callBack:' + request);
            HttpResponse response = http.send(request);
            System.debug('Received the following response from callBack:' + response);
            if (response.getStatusCode() == 200){
                System.debug(LoggingLevel.DEBUG,'Received the following JSON response of callBack:' + response.getBody()); 

            } else {
                System.debug(LoggingLevel.WARN,'Received the following JSON response of callBack:' + response.getBody());
            }
        } catch(Exception e) {
            System.debug(LoggingLevel.ERROR,'Ocurrió un error al consultar el WS');
        }
        System.debug(LoggingLevel.INFO,'Termina callBack_Tabla_Estatutos');
        return results;
    }
    /********************************Termina CALLOUTS DE TABLAS LA******************************************/
    
    
    
    
    //@RemoteAction
    global static Map<String, Object> callBackEntitiesOfTopParent(String AccountIdSeleccionado, String sSSO, String sServiceURL)
    {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        Map<String, Object> results2;
        Map<String, Object> results = null;
        try {
  
            //sfAccountID - obtiene las entidades de una cuenta o Top Parent, en nuestro caso sera el Top Parent
            request.setEndpoint(sServiceURL + '/EcEntityMasterSbDat/AccountSvcRs/entities?sfAccountID='+ AccountIdSeleccionado);
            system.debug('request ' + request.getEndpoint());          
            //request.setEndpoint('http://160.34.7.97:7033/EcEntityMasterSbDat/EntityServiceRs/entities/?sFaccountID="345"&partyID=12');
            
            //request.setHeader('Content-Type', 'application/json; charset=utf-8');
            request.setHeader('Accept', 'application/json; charset=utf-8' );
            //request.setTimeout(10000);
            request.setMethod('GET');
            request.setTimeout(120000);
            System.debug('Send the following request from callBackEntitiesOfTopParent:' + request);
            HttpResponse response = http.send(request);
            System.debug('Received the following response from callBackEntitiesOfTopParent:' + response);
            
            // If the request is successful, parse the JSON response.
            if (response.getStatusCode() == 200) 
            {
                // Deserializes the JSON string into collections of primitive data types.
                results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                System.debug('Received the following JSON response of callBackEntitiesOfTopParent OEJ01:' + response.getBody());            
            }
        } catch(System.CalloutException e) { }
        
        

        return results;
    }    
    
    @RemoteAction
    global static Map<String, Object> callBackllAllEconomicGroup(String sServiceURL,String PartyId)
    {
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        Map<String, Object> results2;
        Map<String, Object> results = null;
        if(!Test.isRunningTest()){
        try {        
            //economicGroupID - Obtiene las entidades pertenecientes a un grupo económico
            request.setEndpoint(sServiceURL + '/EcEntityMasterSbDat/AccountSvcRs/entities?economicGroupID=' + PartyId);
            request.setHeader('Accept', 'application/json');
            
            request.setMethod('GET');
            request.setTimeout(120000);
            System.debug('Send the following request from callBackEntitiesOfEconomicGroup:' + request);
            HttpResponse response = http.send(request);
            System.debug('Received the following response from callBackEntitiesOfEconomicGroup:' + response);
            // If the request is successful, parse the JSON response.
            if (response.getStatusCode() == 200) 
            {
                // Deserializes the JSON string into collections of primitive data types.
                results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                System.debug('Received the following JSON response of callBackEntitiesOfEconomicGroup OEJ01:' + response.getBody());            
            }
        } catch(System.CalloutException e) {
            
        }}else{
             results = 
                (Map<String, Object>)
                JSON.deserializeUntyped(EIV_EntityJsonCreateTest.entitymasterToJson());
        }          

        return results;
    }         
    
    @RemoteAction
    global static Map<String, Object> callBackEntitiesOfEconomicGroup(String economicId, String sSSO, String sServiceURL)
    {
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        Map<String, Object> results2;
        Map<String, Object> results = null;
        
        if(!Test.isRunningTest()){
        try {        
            //economicGroupID - Obtiene las entidades pertenecientes a un grupo económico
            request.setEndpoint(sServiceURL + '/EcEntityMasterSbDat/AccountSvcRs/entities/?economicGroupID='+economicId);
            request.setHeader('Accept', 'application/json');
            
            request.setMethod('GET');
            request.setTimeout(120000);
            System.debug('Send the following request from callBackEntitiesOfEconomicGroup:' + request);
            HttpResponse response = http.send(request);
            System.debug('Received the following response from callBackEntitiesOfEconomicGroup:' + response);
            // If the request is successful, parse the JSON response.
            if (response.getStatusCode() == 200) 
            {
                // Deserializes the JSON string into collections of primitive data types.
                results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                System.debug('Received the following JSON response of callBackEntitiesOfEconomicGroup OEJ01:' + response.getBody());            
            }
        } catch(System.CalloutException e) {
            
        } }
        else{
             results = 
                (Map<String, Object>)
                JSON.deserializeUntyped(EIV_EntityJsonCreateTest.entitymasterToJson());
        }

        return results;
    }     
    
    @RemoteAction
    global static Map<String, Object> callBackCreditBureau(String sServiceURL,Map<String,Object> sMap)
    {   
        Http http = new Http();
        string a;
        string b;
        string c;
        string d;
        string h;
        string f;
        HttpRequest request = new HttpRequest();
        Map<String, Object> results2;
        Map<String, Object> results = null;
        try {        
            //economicGroupID - Obtiene las entidades pertenecientes a un grupo económico
            request.setTimeout(120000);

           
                                a= string.valueOf(sMap.get('Entity'));
                                b= string.valueOf(sMap.get('companyName'));
                                c= string.valueOf(sMap.get('name'));
                                d= string.valueOf(sMap.get('sname'));
                                h= string.valueOf(sMap.get('lname'));
                                f= string.valueOf(sMap.get('slname'));
            request.setEndpoint(sServiceURL+'/EcCreditBureauSbBix/CreditBureauSvcRs/creditBureau?requestId=' + sMap.get('requestId') +
                                '&rfc=' + sMap.get('rfc') +
                                cambio(''+a,''+b,''+c,''+d,''+h,''+f)+
                                '&address=' + sMap.get('address')+ 
                                '&ecEntity=' + sMap.get('ecEntity') + 
                                '&letterSigningDate=' + sMap.get('letterSigningDate') + 
                                '&suburb=' + sMap.get('suburb') + 
                                '&zipCode=' + sMap.get('zipCode') + 
                                '&city=' + sMap.get('city') + 
                                '&state=' + sMap.get('state') + 
                                '&autorizationLetter=' + sMap.get('autorizationLetter') + 
                                '&sourceAccountId=' + sMap.get('sourceAccountId') + 
                                '&sourceAccountName=' + sMap.get('sourceAccountName') + 
                                '&sourceTopParentId=' + sMap.get('sourceTopParentId') + 
                                '&sourceTopParentName=' + sMap.get('sourceTopParentName') + 
                                '&partyId=' + sMap.get('partyId') + 
                                '&comment=' + sMap.get('comment') +
                                '&contractNumber=' + sMap.get('contractNumber') + 
                                '&anex=' + sMap.get('anex') + 
                                '&egPartyId=' + sMap.get('egPartyId') + 
                                '&egPartyName=' + sMap.get('egPartyName') +
                                '&sourceOpId=' + sMap.get('sourceOpId') + 
                                '&sourceCAId=' + sMap.get('sourceCAId') + 
                                '&createdBy=' + sMap.get('createdBy') + 
                                '&dummyFlag=' + sMap.get('dummyFlag'));
            request.setHeader('Accept', 'application/json');
            
            request.setMethod('GET');
            System.debug('Send the following CREDIT request from callBackEntitiesOfEconomicGroup:' + request);
            HttpResponse response = http.send(request);
            System.debug('Received the following response from callBackEntitiesOfEconomicGroup:' + response);
            // If the request is successful, parse the JSON response.
            if (response.getStatusCode() == 200) 
            {
                // Deserializes the JSON string into collections of primitive data types.
                results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                System.debug('Received the following JSON response of callBackEntitiesOfEconomicGroup OEJ01:' + response.getBody());            
            }
        } catch(System.CalloutException e) {
            
        }            

        return results;
    }
    public static string cambio (string t,string v,string c,string b,string n,string m){
        String a = '';
        if(t=='INDIVIDUAL'){
            a = '&name=' + c+'&secondName=' + b +'&lastName=' + n +'&secondLastName=' + m;
        }else if(t=='ORGANIZATION'){
            a = '&companyName=' + v;
        }else{
            a = '';
        }
        return a;
    }
    
    @RemoteAction
    global static Map<String, Object> callBackEntityDetail(String sso, String partyId, String app, String sServiceURL)
    {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        Map<String, Object> results2;
        Map<String, Object> results = null;
        
        if(!Test.isRunningTest() || sso == '999999999')
        {
            try {  
                /*
                partyID - obtiene la información de una entidad, ej "13073"; 
                sso - identificador de usuario firmado,ej: "212428161" ;  
                applicationCode - aplicación desde donde se esta llamdno el servicio, en este caso "SF";  
                screen - pantalla de la que necesitamos los permisos para el usuario firmado, ej: " UI_ENTITYMASTER" ; 
                section - sección de los que  necesitamos los permisos para el usuario firmado, ej: "address" 
                */        
                //quest.setEndpoint('http://160.34.7.97:7033/EcEntityMasterSbDat/EntitySvcRs/entities/?partyID=17370&sso=212338620&applicationCode=SF&screen=UI_ENTITYMASTER
                request.setEndpoint(sServiceURL + '/EcEntityMasterSbDat/EntitySvcRs/entities/?partyID=' + partyId + '&sso=' + sso + '&applicationCode=' + app + '&screen=UI_ENTITYMASTER');
                
                request.setHeader('Accept', 'application/json');
                request.setTimeout(120000);
                request.setMethod('GET');
                
                System.debug('Send the following request from callBackEntityDetail:' + request);
                HttpResponse response = http.send(request);
                System.debug('full response lalo:' + response.getBody());
                // If the request is successful, parse the JSON response.
                if (response.getStatusCode() == 200) 
                {
                    // Deserializes the JSON string into collections of primitive data types.
                    results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                    System.debug('Received the following JSON response of callBackEntityDetail OEJ01:' + results);        
                }
            } catch(System.CalloutException e) { }     
        }
        else
        {
            results = 
                (Map<String, Object>)
                JSON.deserializeUntyped(EIV_EntityJsonCreateTest.entitymasterToJson());
        }
        return results;
    }      
       
     @RemoteAction
    global static Map<String, Object> callBackAuditEntity(String partyId, String sServiceURL)
    {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        Map<String, Object> results2;
        Map<String, Object> results = null;
        
        
        
            try {  
                /*
                partyID - obtiene la información de una entidad, ej "13073"; 
                sso - identificador de usuario firmado,ej: "212428161" ;  
                applicationCode - aplicación desde donde se esta llamdno el servicio, en este caso "SF";  
                screen - pantalla de la que necesitamos los permisos para el usuario firmado, ej: " UI_ENTITYMASTER" ; 
                section - sección de los que  necesitamos los permisos para el usuario firmado, ej: "address" 
                */        
                //quest.setEndpoint('http://160.34.7.97:7033/EcEntityMasterSbDat/EntitySvcRs/entities/?partyID=17370&sso=212338620&applicationCode=SF&screen=UI_ENTITYMASTER
                request.setEndpoint(sServiceURL + '/EcRequestSbDat/RequestRs/requests/audits?sourceId=' + partyId + '&sourceCode=Entity%20Master');
                
                request.setHeader('Accept', 'application/json');
                request.setTimeout(120000);
                request.setMethod('GET');
                System.debug('Send the following request from callBackAuditEntity:' + request);
                HttpResponse response = http.send(request);
                System.debug('Received the following response from callBackAuditEntity:' + response);
                // If the request is successful, parse the JSON response.
                if (response.getStatusCode() == 200) 
                {
                    // Deserializes the JSON string into collections of primitive data types.
                    results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                    System.debug('Received the following JSON response of callBackAuditEntity OEJ01:' + results);        
                }
            } catch(System.CalloutException e) { }     
        
        
        return results;
    }    
    @RemoteAction
    global static Map<String, Object> callBackGetRequestDetails(String sso, String app, String sServiceURL, String searchAssignedGroup,
                                                               String searchRequestType, String searchAssignedTo, String searchNameAssignedTo, String searchRequestStatus,
                                                               String searchStartDate, String searchEndDate, String searchRequestedBy,
                                                               String searchPartyName, String searchSourceTopParentName, String searchSourceAccountName, String searchEgPartyName, String searchRequestId, String sSSO)
    {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        Map<String, Object> results2;
        Map<String, Object> results = null;
        
        if(!Test.isRunningTest() || sso == '999999999')
        {
            try {  
                /*
                partyID - obtiene la información de una entidad, ej "13073"; 
                sso - identificador de usuario firmado,ej: "212428161" ;  
                applicationCode - aplicación desde donde se esta llamdno el servicio, en este caso "SF";  
                screen - pantalla de la que necesitamos los permisos para el usuario firmado, ej: " UI_ENTITYMASTER" ; 
                section - sección de los que  necesitamos los permisos para el usuario firmado, ej: "address" 
                */        
                request.setTimeout(120000);
                request.setEndpoint(sServiceURL + '/EcRequestSbDat/RequestRs/requests?' +
                                    'requestId=' + searchRequestId +
                                    '&rootRequestId=' + 
                                    '&requestType=' + searchRequestType + 
                                    '&sourceAccountId=' + 
                                    '&sourceAccountName=' + searchSourceAccountName+
                                    '&sourceTopParentId=' + 
                                    '&sourceTopParentName=' + searchSourceTopParentName + 
                                    '&partyId=' + 
                                    '&partyName=' + searchPartyName + 
                                    '&egPartyId=' + 
                                    '&egPartyName=' + searchEgPartyName + 
                                    '&sourceOpId=' + 
                                    '&sourceCAId=' + 
                                    '&startDate=' + searchStartDate + 
                                    '&endDate=' + searchEndDate + 
                                    '&requestStatus=' + searchRequestStatus + 
                                    '&createdBy=' + 
                                    '&requestedBy=' + searchRequestedBy + 
                                    '&assignedGroup=' + searchAssignedGroup + 
                                    '&nameAssignedTo=' + searchNameAssignedTo +
                                    '&assignedTo=' + searchAssignedTo + 
                                    '&assignedDate=' + 
                                    '&creationDate=' + 
                                    '&updatedBy=' + 
                                    '&lastUpdateDate=' + 
                                    '&solvedBy=' + 
                                    '&solvedDate=' + 
                                    '&sourceApplication=' +
                                    '&finantialEntity=' +
                                    '&sso=' + sSSO);
                
                request.setHeader('Accept', 'application/json');
                
                request.setMethod('GET');
                System.debug('Send the following request from callBackEntityDetail:' + request);
                HttpResponse response = http.send(request);
                System.debug('Received the following response from callBackEntityDetail:' + response);
                // If the request is successful, parse the JSON response.
                if (response.getStatusCode() == 200) 
                {
                    // Deserializes the JSON string into collections of primitive data types.
                    results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                    System.debug('Received the following JSON response of callBackEntityDetail OEJ01:' + results);        
                    
                }
            } catch(System.CalloutException e) {
                
            }     
            
        }
        else
        {
            //results = (Map<String, Object>) 
                //poner la creación de dummy de la request detail
                //JSON.deserializeUntyped(EIV_EntityJsonCreateTest.entitymasterToJson());
        }
        return results;
    }      
    
    @RemoteAction
    global static Map<String, Object> callBackGetRequestDetailsOne(String sso, String app, String sServiceURL, String searchRequestId)
    {
        System.debug(LoggingLevel.INFO,'Inicia callBackGetRequestDetailsOne');
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        Map<String, Object> results2;
        Map<String, Object> results = null;
        
        if(!Test.isRunningTest() || sso == '999999999')
        {
            try {  
                /*
                partyID - obtiene la información de una entidad, ej "13073"; 
                sso - identificador de usuario firmado,ej: "212428161" ;  
                applicationCode - aplicación desde donde se esta llamdno el servicio, en este caso "SF";  
                screen - pantalla de la que necesitamos los permisos para el usuario firmado, ej: " UI_ENTITYMASTER" ; 
                section - sección de los que  necesitamos los permisos para el usuario firmado, ej: "address" 
antes
/EcRequestSbDat/SFRequestTypeDetailsRs/sfRequestTypeDetails?
despues
https://oasdev.engeniumcapital.mx:7035/EcRequestSbDat/RequestRs/requests?requestId=154
                */        
                request.setTimeout(120000);
                request.setEndpoint(sServiceURL + '/EcRequestSbDat/SFRequestTypeDetailsRs/sfRequestTypeDetails?' +
                                    'requestId=' + searchRequestId+
                                   '&sso=' + sso);
                
                request.setHeader('Accept', 'application/json');
                
                request.setMethod('GET');
                System.debug('Send the following request from callBackEntityDetail:' + request);
                HttpResponse response = http.send(request);
                System.debug('Received the following response from callBackEntityDetail:' + response);
                // If the request is successful, parse the JSON response.
                if (response.getStatusCode() == 200) 
                {
                    System.debug(LoggingLevel.DEBUG,'Se obtuvo el siguiente Json' + response.getBody());
                    // Deserializes the JSON string into collections of primitive data types.
                    results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                    System.debug('Received the following JSON response of callBackEntityDetail OEJ01:' + results);        
                    
                }
            } catch(System.CalloutException e) {
                System.debug(LoggingLevel.ERROR,'Ocurrió un error en la consulta del WS');
                System.debug(LoggingLevel.ERROR,'linia ' + e.getLineNumber());
                System.debug(LoggingLevel.ERROR,'Mensaje' + e.getMessage());
                
            }     
            
        }
        else
        {
            //results = (Map<String, Object>) 
                //poner la creación de dummy de la request detail
                results =(Map<String, Object>)JSON.deserializeUntyped(ES2_jsonDummy.entitymasterToJson());
                 /*request.setTimeout(20000);
                request.setEndpoint(sServiceURL + '/EcRequestSbDat/SFRequestTypeDetailsRs/sfRequestTypeDetails?' +
                                    'requestId=' + searchRequestId+
                                   '&sso=' + sso);
                
                request.setHeader('Accept', 'application/json');
                
                request.setMethod('GET');
                System.debug('Send the following request from callBackEntityDetail:' + request);
                HttpResponse response = http.send(request); 
                System.debug('Received the following response from callBackEntityDetail:' + response);
                // If the request is successful, parse the JSON response.
                if (response.getStatusCode() == 200) 
                {
                    // Deserializes the JSON string into collections of primitive data types.
                    results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                    System.debug('Received the following JSON response of callBackEntityDetail OEJ01:' + results);        
                    
                }*/
        }
        return results;
    }      

    @RemoteAction
    global static Map<String, Object> callBackGetRequestForPartyId(String sso, String app, String sServiceURL, String searchPartyId)
    {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        Map<String, Object> results2;
        Map<String, Object> results = null;
        
        if(!Test.isRunningTest() || sso == '999999999')
        {
            try {  
                /*
                partyID - obtiene la información de una entidad, ej "13073"; 
                sso - identificador de usuario firmado,ej: "212428161" ;  
                applicationCode - aplicación desde donde se esta llamdno el servicio, en este caso "SF";  
                screen - pantalla de la que necesitamos los permisos para el usuario firmado, ej: " UI_ENTITYMASTER" ; 
                section - sección de los que  necesitamos los permisos para el usuario firmado, ej: "address" 
                */        
                request.setTimeout(120000);
                //request.setEndpoint(sServiceURL + '/EcRequestSbDat/SFRequestTypeDetailsRs/sfRequestTypeDetails?' +
                //                    'partyId=' + searchPartyId );
                request.setEndpoint(sServiceURL + '/EcRequestSbDat/RequestRs/requests?partyId=' + searchPartyId );
                
                request.setHeader('Accept', 'application/json');
                
                request.setMethod('GET');
                System.debug('Send the following request from callBackEntityDetail:' + request);
                HttpResponse response = http.send(request);
                System.debug('Received the following response from callBackEntityDetail:' + response);
                // If the request is successful, parse the JSON response.
                if (response.getStatusCode() == 200) 
                {
                    // Deserializes the JSON string into collections of primitive data types.
                    results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                    System.debug('Received the following JSON response of callBackEntityDetail OEJ01:' + results);        
                    
                }
            } catch(System.CalloutException e) {
                
            }     
            
        }
        else
        {
            //results = (Map<String, Object>) 
                //poner la creación de dummy de la request detail
                //JSON.deserializeUntyped(EIV_EntityJsonCreateTest.entitymasterToJson());
        }
        return results;
    }      
    
    
    
    @RemoteAction
    global static Map<String, Object> callBackEntitiesSearch(String sSearch, String sSSO, String sServiceURL)
    {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setTimeout(120000);
        Map<String, Object> results2;
        Map<String, Object> results = null;
        sSearch = EncodingUtil.urlEncode(sSearch, 'UTF-8');
        if(!Test.isRunningTest() || sSSO == '999999999')
        {
            try {  
                //rfcName - obtiene las coincidencias de entidades por rfc/nombre del cliente
                request.setEndpoint(sServiceURL + '/EcEntityMasterSbDat/AccountSvcRs/entities?rfcOrName=' + sSearch);
                
                //request.setHeader('Content-Type', 'application/json; charset=utf-8');
                request.setHeader('Accept', 'application/json');
                
                request.setMethod('GET');
                System.debug('Send the following request from callBackEntitiesSearch:' + request);
                HttpResponse response = http.send(request);
                System.debug('Received the following response from callBackEntitiesSearch:' + response);
                // If the request is successful, parse the JSON response.
                if (response.getStatusCode() == 200) 
                {
                    // Deserializes the JSON string into collections of primitive data types.
                    results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                    System.debug('Received the following JSON response of callBackEntitiesSearch OEJ01:' + response.getBody());            
                }
            } catch(System.CalloutException e) {
                
            }
            
            
        }
        else
        {
            results = 
                (Map<String, Object>)
                JSON.deserializeUntyped(EIV_EntityJsonCreateTest.getentityes());            
        }
        
        return results;
    }   
    
    @RemoteAction
    global static Map<String, Object> postEntity(String jsonS, String sServiceURL)
    {        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setTimeout(120000);
        Map<String, Object> results2;
        Map<String, Object> results = null;
        if(!Test.isRunningTest() || sServiceURL == 'http://160.34.7.97:70')
        {
            try {          
                
                request.setEndpoint(sServiceURL + '/EcEntityMasterSbDat/EntitySvcRs/entities');
                
                request.setHeader('Content-Type', 'application/json');        
                request.setMethod('POST');
                request.setBody(jsonS); 
                System.debug('Send the following request from postEntity:' + request);
                HttpResponse response = http.send(request);
                System.debug('Received the following response from postEntity:' + response);
                // If the request is successful, parse the JSON response.
                if (response.getStatusCode() == 200) 
                {
                    // Deserializes the JSON string into collections of primitive data types.
                    results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                    System.debug('Received the following JSON response of postEntity OEJ01:' + response.getBody());            
                }
            } catch(System.CalloutException e) {
                
            }    
        }
        else
        {
                      results = 
                (Map<String, Object>)
                JSON.deserializeUntyped(EIV_EntityJsonCreateTest.entitymasterUpdate());
            
        }
        
        
                      
        
        return results;
    }
    
    @RemoteAction
    global static Map<String, Object> postAddress(String jsonS, String sServiceURL)
    {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setTimeout(120000);
        Map<String, Object> results2;
        Map<String, Object> results = null;
        if(!Test.isRunningTest() || sServiceURL == 'http://160.34.7.97:70' )
        {
            try {          
                request.setEndpoint(sServiceURL + '/EcEntityMasterSbDat/EntitySvcRs/entities/addresses');
                
                request.setHeader('Content-Type', 'application/json');        
                request.setMethod('POST');
                request.setBody(jsonS); 
                System.debug('Send the following request from postAddress:' + request);
                HttpResponse response = http.send(request);
                System.debug('Received the following response from postAddress:' + response);
                // If the request is successful, parse the JSON response.
                if (response.getStatusCode() == 200) 
                {
                    // Deserializes the JSON string into collections of primitive data types.
                    results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                    System.debug('Received the following JSON response of postAddress OEJ01:' + response.getBody());            
                }
            } catch(System.CalloutException e) {
                
            }   
            
        }
        else
        {
            results = 
                (Map<String, Object>)
                JSON.deserializeUntyped(EIV_EntityJsonCreateTest.updateaddress());
            
        }
                         
        
        return results;
    }   
    
    @RemoteAction
    global static Map<String, Object> postContact(String jsonS, String sServiceURL)
    {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setTimeout(120000);
        Map<String, Object> results2;
        Map<String, Object> results = null;
        if(!Test.isRunningTest() || sServiceURL == 'http://160.34.7.97:70')
        {
            try {  
                request.setEndpoint(sServiceURL + '/EcEntityMasterSbDat/EntitySvcRs/entities/contacts');
                
                request.setHeader('Content-Type', 'application/json');        
                request.setMethod('POST');
                request.setBody(jsonS); 
                System.debug('Send the following request from postContact:' + request);
                HttpResponse response = http.send(request);
                System.debug('Received the following response from postContact:' + response);
                // If the request is successful, parse the JSON response.
                if (response.getStatusCode() == 200) 
                {
                    // Deserializes the JSON string into collections of primitive data types.
                    results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                    System.debug('Received the following JSON response of postContact OEJ01:' + response.getBody());            
                }
            } catch(System.CalloutException e) {
                
            }  
        }
        else
        {
            results = 
                (Map<String, Object>)
                JSON.deserializeUntyped(EIV_EntityJsonCreateTest.updatecontact());
        }
                     
        
        return results;
    }   

    @RemoteAction
    global static Map<String, Object> postInvoicing(String jsonS, String sServiceURL)
    {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setTimeout(120000);
        Map<String, Object> results2;
        Map<String, Object> results = null;
        if(!Test.isRunningTest() || sServiceURL == 'http://160.34.7.97:70')
        {
            
            try { 
                request.setEndpoint(sServiceURL + '/EcEntityMasterSbDat/EntitySvcRs/entities/invoices');
                
                request.setHeader('Content-Type', 'application/json');        
                request.setMethod('POST');
                request.setBody(jsonS); 
                System.debug('Send the following request from postInvoicing:' + request);
                HttpResponse response = http.send(request);
                System.debug('Received the following response from postInvoicing:' + response);
                // If the request is successful, parse the JSON response.
                if (response.getStatusCode() == 200) 
                {
                    // Deserializes the JSON string into collections of primitive data types.
                    results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                    System.debug('Received the following JSON response of postInvoicing OEJ01:' + response.getBody());            
                }
            } catch(System.CalloutException e) {
                
            }    
            
        }
        else
        {
            results = 
                (Map<String, Object>)
                JSON.deserializeUntyped(EIV_EntityJsonCreateTest.updateinvoices());
            
            
            
        }
                      
        return results;
    }   
    
    @RemoteAction
    global static Map<String, Object> postAssets(String jsonS, String sServiceURL)
    {
        system.debug('jsonS ' + jsonS);
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setTimeout(120000);
        Map<String, Object> results2;
        Map<String, Object> results = null;
        if(!Test.isRunningTest() || sServiceURL == 'http://160.34.7.97:70')
        {
            
            try { 
                request.setEndpoint(sServiceURL + '/EcRequestSbDat/SFRequestTypeDetailsRs/sfRequestTypeDetails/evals/details/assets');
                
                request.setHeader('Content-Type', 'application/json');        
                request.setMethod('POST');
                request.setTimeout(5000);
                request.setBody(jsonS); 
                System.debug('Send the following request from postAssets:' + request.getBody());
                HttpResponse response = http.send(request);
                System.debug('Received the following response from postAssets:' + response);
                // If the request is successful, parse the JSON response.
                if (response.getStatusCode() == 200) 
                {
                    // Deserializes the JSON string into collections of primitive data types.
                    results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                    System.debug('Received the following JSON response of postAssets OEJ01:' + response.getBody());            
                }
            } catch(System.CalloutException e) {
                
            }    
            
        }
        else
        {
            results = 
                (Map<String, Object>)
                JSON.deserializeUntyped(EIV_EntityJsonCreateTest.updateinvoices());
            
            
            
        }
                      
        return results;
    }
    
    @RemoteAction
    global static Map<String, Object> postValuations(String jsonS, String sServiceURL)
    {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setTimeout(120000);
        Map<String, Object> results2;
        Map<String, Object> results = null;
        if(!Test.isRunningTest() || sServiceURL == 'http://160.34.7.97:70')
        {
            
            try { 
                request.setEndpoint(sServiceURL + '/EcRequestSbDat/SFRequestTypeDetailsRs/sfRequestTypeDetails/evals/details/assets/valuations');
                
                request.setHeader('Content-Type', 'application/json');        
                request.setMethod('POST');
                request.setBody(jsonS); 
                System.debug('Send the following request from postValuations:' + request);
                HttpResponse response = http.send(request);
                System.debug('Received the following response from postValuations:' + response);
                // If the request is successful, parse the JSON response.
                if (response.getStatusCode() == 200) 
                {
                    // Deserializes the JSON string into collections of primitive data types.
                    results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                    System.debug('Received the following JSON response of postValuations OEJ01:' + response.getBody());            
                }
            } catch(System.CalloutException e) {
                
            }    
            
        }
        else
        {
            results = 
                (Map<String, Object>)
                JSON.deserializeUntyped(EIV_EntityJsonCreateTest.updateinvoices());
            
            
            
        }
                      
        return results;
    }
    
    @RemoteAction
    global static Map<String, Object> postendorsement(String jsonS, String sServiceURL)
    {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setTimeout(120000);
        Map<String, Object> results2;
        Map<String, Object> results = null;
        if(!Test.isRunningTest() || sServiceURL == 'http://160.34.7.97:70')
        {
            
            try { 
                request.setEndpoint(sServiceURL + '/EcRequestSbDat/SFRequestTypeDetailsRs/sfRequestTypeDetails/evals/details/assets/endorsements');
                
                request.setHeader('Content-Type', 'application/json');        
                request.setMethod('POST');
                request.setBody(jsonS); 
                System.debug('Send the following request from postValuations:' + request);
                HttpResponse response = http.send(request);
                System.debug('Received the following response from postValuations:' + response);
                // If the request is successful, parse the JSON response.
                if (response.getStatusCode() == 200) 
                {
                    // Deserializes the JSON string into collections of primitive data types.
                    results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                    System.debug('Received the following JSON response of postValuations OEJ01:' + response.getBody());            
                }
            } catch(System.CalloutException e) {
                
            }    
            
        }
        else
        {
            results = 
                (Map<String, Object>)
                JSON.deserializeUntyped(EIV_EntityJsonCreateTest.updateinvoices());
            
            
            
        }
                      
        return results;
    }
    
    @RemoteAction
    global static Map<String, Object> postLAD(String jsonS, String sServiceURL)
    {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setTimeout(120000);
        Map<String, Object> results2;
        Map<String, Object> results = null;
        if(!Test.isRunningTest() || sServiceURL == 'http://160.34.7.97:70')
        {
            
            try { 
                request.setEndpoint(sServiceURL + '/EcRequestSbDat/SFRequestTypeDetailsRs/sfRequestTypeDetails/legalAssessments/details');
                
                request.setHeader('Content-Type', 'application/json');        
                request.setMethod('POST');
                request.setBody(jsonS); 
                System.debug('Send the following request from post legal assessment:' + request);
                HttpResponse response = http.send(request);
                System.debug('Received the following response from legal assessment:' + response);
                // If the request is successful, parse the JSON response.
                if (response.getStatusCode() == 200) 
                {
                    // Deserializes the JSON string into collections of primitive data types.
                    results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                    System.debug('Received the following JSON response of legal assessment OEJ01:' + response.getBody());            
                }
            } catch(System.CalloutException e) {
                
            }    
            
        }
        else
        {
            results = 
                (Map<String, Object>)
                JSON.deserializeUntyped(EIV_EntityJsonCreateTest.updateinvoices());
            
            
            
        }
                      
        return results;
    }
    
    @RemoteAction
    global static Map<String, Object> callBackGetDocumentsInEntity(String sServiceURL, String partyId)
    {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setTimeout(120000);
        Map<String, Object> results2;
        Map<String, Object> results = null;
        try {
  
            //sfAccountID - obtiene las entidades de una cuenta o Top Parent, en nuestro caso sera el Top Parent
            //request.setEndpoint('http://160.34.7.97:7033/EcDocumentSbUtl/DocumentSvsRs/documents?contentDocName=CB__RPT_CB_SOA_20180827&contentDocId=25013');
            request.setEndpoint(sServiceURL + '/EcRequestSbDat/RequestRs/requests/documents?partyId=' + partyId);                     
            
            request.setHeader('Accept', 'application/json');
            //request.setTimeout(10000);
            request.setMethod('GET');
            System.debug('Send the following request from callBackEntitiesOfTopParent:' + request);
            HttpResponse response = http.send(request);
            System.debug('Received the following response from callBackEntitiesOfTopParent:' + response);
            
            // If the request is successful, parse the JSON response.
            if (response.getStatusCode() == 200) 
            {
                // Deserializes the JSON string into collections of primitive data types.
                results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                System.debug('Received the following JSON response of callBackEntitiesOfTopParent OEJ01:' + response.getBody());            
            }
        } catch(System.CalloutException e) {
            
        }
        return results;
    }    
    
    @RemoteAction
    global static Map<String, Object> callBackGetDocument(String sServiceURL, String contentDocId)
    {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        Map<String, Object> results2;
        Map<String, Object> results = null;
        try {
  
            //sfAccountID - obtiene las entidades de una cuenta o Top Parent, en nuestro caso sera el Top Parent
            //request.setEndpoint('http://160.34.7.97:7033/EcDocumentSbUtl/DocumentSvsRs/documents?contentDocName=CB__RPT_CB_SOA_20180827&contentDocId=25013');
            request.setEndpoint(sServiceURL + '/EcDocumentSbUtl/DocumentSvsRs/documents?contentDocId=' + contentDocId);                     
            
            request.setHeader('Accept', 'application/json');
            request.setTimeout(120000);
            request.setMethod('GET');
            System.debug('Send the following request from callBackEntitiesOfTopParent:' + request);
            HttpResponse response = http.send(request);
            System.debug('Received the following response from callBackEntitiesOfTopParent:' + response);
            
            // If the request is successful, parse the JSON response.
            if (response.getStatusCode() == 200) 
            {
                // Deserializes the JSON string into collections of primitive data types.
                results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                System.debug('Received the following JSON response of callBackEntitiesOfTopParent OEJ01:' + response.getBody());            
            }
        } catch(System.CalloutException e) {
            
        }
        return results;
    }
    @RemoteAction
    global static Map<String, Object> postUploadDocument(String sServiceURL, String jsonS)
    {        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        Map<String, Object> results2;
        Map<String, Object> results = null;
        
        
        request.setEndpoint(sServiceURL + '/EcDocumentSbUtl/DocumentSvsRs/documents');
        
        request.setHeader('Content-Type', 'application/json');        
        request.setMethod('POST');
        request.setTimeout(120000);
        request.setBody(jsonS); 
        System.debug('Send the following request from postEntity:' + request);
        HttpResponse response = http.send(request);
        System.debug('Received the following response from postEntity:' + response);
        // If the request is successful, parse the JSON response.
        if (response.getStatusCode() == 200) 
        {
            // Deserializes the JSON string into collections of primitive data types.
            results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            System.debug('Received the following JSON response of postEntity OEJ01:' + response.getBody());            
        }        
        return results;
    }

    @RemoteAction
    global static Map<String, Object> postHitsEntitys(string sServiceURL, String jsonS){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        Map<String, Object> results2;
        Map<String, Object> results = null;

        request.setEndpoint(sServiceURL +'/EcAmlSbDat/AmlRs/aml/hits/queries');
        request.setHeader('Content-Type', 'application/json');
        request.setMethod('POST');
        request.setBody(jsonS);
        request.setTimeout(120000);

        System.debug('Send the following request from postEntity:' + request);
        HttpResponse response = http.send(request);
        System.debug('Received the following response from postEntity:' + response);
        // If the request is successful, parse the JSON response.
        if (response.getStatusCode() == 200) 
        {
            // Deserializes the JSON string into collections of primitive data types.
            results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            System.debug('Received the following JSON response of postEntity OEJ01:' + response.getBody());            
        }        
        return results;

    }    
    
    @RemoteAction
    global static Map<String, Object> postComments(String jsonS, String sServiceURL)
    {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        Map<String, Object> results2;
        Map<String, Object> results = null;
        if(!Test.isRunningTest() || sServiceURL == 'http://160.34.7.97:70')
        {
            
            try { 
                request.setEndpoint(sServiceURL + '/EcRequestSbDat/SFRequestTypeDetailsRs/sfRequestTypeDetails/comments');
                request.setTimeout(120000);
                request.setHeader('Content-Type', 'application/json');        
                request.setMethod('POST');
                request.setBody(jsonS); 
                System.debug('Send the following request from postInvoicing:' + request);
                HttpResponse response = http.send(request);
                System.debug('Received the following response from postComments:' + response);
                // If the request is successful, parse the JSON response.
                if (response.getStatusCode() == 200) 
                {
                    // Deserializes the JSON string into collections of primitive data types.
                    results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                    System.debug('Received the following JSON response of postInvoicing OEJ01:' + response.getBody());            
                }
            } catch(System.CalloutException e) {
                
            }    
            
        }
        else
        {
            results = 
                (Map<String, Object>)
                JSON.deserializeUntyped(EIV_EntityJsonCreateTest.updateinvoices());
            
            
            
        }
                      
        return results;
    }   
    
    @RemoteAction
    global static Map<String, Object> postKYCDetail(String jsonS, String sServiceURL)
    {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        Map<String, Object> results2;
        Map<String, Object> results = null;
        System.debug('jsonS OEJ:' + jsonS);
        if(!Test.isRunningTest() || sServiceURL == 'http://160.34.7.97:70')
        {
            
            try { 
                request.setEndpoint(sServiceURL + '/EcRequestSbDat/SFRequestTypeDetailsRs/sfRequestTypeDetails/kycs/details');
                
                request.setHeader('Content-Type', 'application/json');        
                request.setMethod('POST');
                request.setBody(jsonS); 
                request.setTimeout(120000);
                System.debug('Send the following request from postInvoicing:' + request);
                HttpResponse response = http.send(request);
                System.debug('Received the following response from postInvoicing:' + response);
                // If the request is successful, parse the JSON response.
                if (response.getStatusCode() == 200) 
                {
                    // Deserializes the JSON string into collections of primitive data types.
                    results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                    System.debug('Received the following JSON response of postInvoicing OEJ01:' + response.getBody());            
                }
            } catch(System.CalloutException e) {
                
            }    
            
        }
        else
        {
            /*results = 
                (Map<String, Object>)
                JSON.deserializeUntyped(EIV_EntityJsonCreateTest.updateinvoices());*/
            
            
            
        }
                      
        return results;
    }       
    @RemoteAction
    global static Map<String, Object> postRequestDetail(String jsonS, String sServiceURL)
    {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        Map<String, Object> results2;
        Map<String, Object> results = null;
        if(!Test.isRunningTest() || sServiceURL == 'http://160.34.7.97:70')
        {
            
            try { 
                request.setEndpoint(sServiceURL + '/EcRequestSbDat/SFRequestTypeDetailsRs/sfRequestTypeDetails');
                request.setTimeout(120000);
                request.setHeader('Content-Type', 'application/json');        
                request.setMethod('POST');
                request.setBody(jsonS); 
                System.debug('Send the following request from postRequestDetail:' + request);
                
                HttpResponse response = http.send(request);
                System.debug('Received the following response from postRequestDetail:' + response);
                // If the request is successful, parse the JSON response.
                if (response.getStatusCode() == 200) 
                {
                    // Deserializes the JSON string into collections of primitive data types.
                    results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                    System.debug('Received the following JSON response of postInvoicing OEJ01:' + response.getBody());            
                }
            } catch(System.CalloutException e) {
                
            }    
            
        }
        else
        {
            results =(Map<String, Object>)JSON.deserializeUntyped(ES2_jsonDummy.entitymasterToJson());
 
        }
                      
        return results;
    }
    
    /*global static Map<String, Object> postRequestDetail_SecondDetail(String jsonS, String sServiceURL)
    {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        Map<String, Object> results2;
        Map<String, Object> results = null;
        if(!Test.isRunningTest() || sServiceURL == 'http://160.34.7.97:70')
        {
            
            try { 
                request.setEndpoint(sServiceURL + '/EcRequestSbDat/SFRequestTypeDetailsRs/sfRequestTypeDetails/legalAssessments/details');
                
                request.setHeader('Content-Type', 'application/json');        
                request.setMethod('POST');
                request.setBody(jsonS); 
                System.debug('Send the following request from postRequestDetail:' + request);
                
                HttpResponse response = http.send(request);
                System.debug('Received the following response from postRequestDetail:' + response);
                // If the request is successful, parse the JSON response.
                if (response.getStatusCode() == 200) 
                {
                    // Deserializes the JSON string into collections of primitive data types.
                    results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                    System.debug('Received the following JSON response of postInvoicing OEJ01:' + response.getBody());            
                }
            } catch(System.CalloutException e) {
                
            }    
            
        }
        else
        {
            results =(Map<String, Object>)JSON.deserializeUntyped(ES2_jsonDummy.entitymasterToJson());
 
        }
                      
        return results;
    }*/
}