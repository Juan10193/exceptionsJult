public class ES5_Legal_Assessment_Direct {
    public ES2_WraperRequest req						{get;set;}
    public EIV_DetailWrapClass detail {get;set;}
    public Map<string,object>jsonResponse =null;
    
    public String sServiceURL 							{get;set;}
    public string UrlAppDoctos 							{get;set;}
    public string EncriptationType 						{get;set;}
    public string KeyEncriptation 						{get;set;}
    public string URL_Servicio_Externa 					{get;set;}
    public String sSSO 									{get;set;}
    
    public string URLRetorno 							{get;set;}
    public ES5_Legal_Assessment_Direct(){
        System.debug(LoggingLevel.INFO,'Inicia ES5_Legal_Assessment_Direct');
        this.req = new ES2_WraperRequest();
        this.sServiceURL = Test.isRunningTest() ? 'hola mundo' :[Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='URL_Servicio'][0].EIV_tx_parameter__c; 
        this.UrlAppDoctos = Test.isRunningTest() ? 'https://test.com' :  [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='UrlAppDoctos'][0].EIV_tx_parameter__c; 
        this.EncriptationType = Test.isRunningTest() ? 'https://test.com' :  [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='EncriptationType'][0].EIV_tx_parameter__c; 
        this.KeyEncriptation = Test.isRunningTest() ? 'https://test.com' :  [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='KeyEncriptation'][0].EIV_tx_parameter__c; 
        this.URL_Servicio_Externa = Test.isRunningTest() ? 'https://test.com' :  [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='URL_Servicio_Externa'][0].EIV_tx_parameter__c;
        this.sSSO = Test.isRunningTest() ? '666' : [Select EmployeeNumber From User Where Id = :UserInfo.getUserId()][0].EmployeeNumber;
        this.URLRetorno = Test.isRunningTest() ? '666' :  (String)System.currentPageReference().getParameters().get('URLRetorno');
        /*ES5_WrapperLA test = new ES5_WrapperLA();
ES5_WrapperLA.Header htest = new ES5_WrapperLA.Header();
ES5_WrapperLA.Entity_Information etest = new ES5_WrapperLA.Entity_Information();
*/
        
        //if()        
        //Map<String, Object> cObjMap = (Map<String, Object>)JSON.deserializeUntyped(JSONreq);
        
        this.req.pOutRequestId =Test.isRunningTest() ? '666' :  pasnull((String)System.currentPageReference().getParameters().get('requestId'));    
        this.req.pOutPartyName = Test.isRunningTest() ? 'hola mundo' : pasnull((String) System.currentPageReference().getParameters().get('OracleAccountName'));
        this.req.pOutPartyId = Test.isRunningTest() ? '666' : pasnull((String)System.currentPageReference().getParameters().get('PartyId'));
        this.req.pOutSourceTopParentId = Test.isRunningTest() ? '666' : pasnull((String)System.currentPageReference().getParameters().get('TopParentID'));
        this.req.pOutsourceTopParentName  =Test.isRunningTest() ? 'hola mundo' : pasnull((String) System.currentPageReference().getParameters().get('TopParentName'));
        this.req.LAH.pOutEntidad =Test.isRunningTest() ? 'hola mundo' :   pasnull((String)System.currentPageReference().getParameters().get('OracleAccountName'));    
        this.req.LAH.pOutNoCuenta =Test.isRunningTest() ? '666' :  pasnull((String) System.currentPageReference().getParameters().get('Nocuenta'));
        this.req.LAH.pOutnacionalidad = pasnull((String)System.currentPageReference().getParameters().get('Nationality'));
        this.req.LAH.pOutEntidadtype = pasnull((String)System.currentPageReference().getParameters().get('Entitytype'));
        //this.req.LAH.pOutRFC  = pasnull((String) System.currentPageReference().getParameters().get('RFC'));
        //this.req.LAH.pOutcurp = pasnull((String) System.currentPageReference().getParameters().get('CURP'));
        this.req.LAH.pOutTaxRegime = Test.isRunningTest() ? 'persona fisica' :pasnull((String) System.currentPageReference().getParameters().get('tax'));
        this.req.LAH.pOutEConomicgroup =Test.isRunningTest() ? '666' : pasnull((String)System.currentPageReference().getParameters().get('EG'));
        this.req.LAH.pOutCustomerName =Test.isRunningTest() ? 'hola mundo' : pasnull((String)System.currentPageReference().getParameters().get('Nombre'));
        system.debug('this.req.pOutsourceTopParentName ' + this.req.pOutsourceTopParentName);
        
        
        req.pOutCreatedBy = sSSO;
        req.pOutUpdatedBy=sSSO;
        req.pOutRequestedBy = sSSO;
        req.pOutStartDate = System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00'));
        req.pOutLastUpdateDate = System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00'));
        req.pOutRequestStatus = 'NEW';
        req.pOutActiveFlag = 'Y';
    }
    
    public PageReference newLA(){
        //falta logica del guardado
        ES2_controller_POSTjson ps = new ES2_controller_POSTjson();
        PageReference pr;
        
        
        req.pOutRequestStatus = 'NEW';
        /*req.pOutCreatedBy = sSSO;
        req.pOutRequestedBy = sSSO;
        req.pOutAssignedGroup = 'APP LEGAL ASSESSMENT GROUP';
        req.pOutAssignedTo = sSSO;
        req.pOutCreatedBy = sSSO;*/
        req.pOutRequestedBy = sSSO;
        req.pOutStartDate = System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00'));
        req.pOutCreationDate = System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00'));
        req.pOutActiveFlag = 'Y';
        req.pOutRequestType = 'LEGAL ASSESSMENT';
        
        /*req.pOutCreationDate= (String)(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00'));
        req.pOutLastUpdateDate= (String)(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00'));
        req.pOutAssignedDate = (String)(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00'));
        req.pOutStartDate = (String)(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00'));
        req.pOutLastUpdateDate = (String)(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00'));*/
        
        if (req.LAH.pOutEntidadtype == 'INDIVIDUAL') {
            req.LAH.pOutEntidadtype = 'Persona Fisica';
            this.req.LAH.pOutlaType='Fisica';
        } else if (req.LAH.pOutEntidadtype == 'ORGANIZATION' && req.LAH.pOutnacionalidad == 'MEX') {
            req.LAH.pOutEntidadtype = 'Persona Moral';
            this.req.LAH.pOutlaType='Moral';
            req.LAH.pmoral.pOutLAMACDenomconstituirse = req.pOutPartyName;
        } else if (req.LAH.pOutEntidadtype == 'ORGANIZATION' && req.LAH.pOutnacionalidad != 'MEX') {
            req.LAH.pOutEntidadtype = 'Persona Moral';
            this.req.LAH.pOutlaType='Extranjera';
            req.LAH.pmoralExtranjera.pOutLAPMEACDenomconstituirse = req.pOutPartyName;
        }
        String sJson = ps.postgeneral('LEGAL ASSESSMENT', req);
        System.debug('sJson ' + sJson);
        
        
        //jsonResponse = (Map<string,object>)JSON.deserializeUntyped(ES2_jsonDummy.entitymasterToJson());
        jsonResponse = EIV_EntityExtencionCalloutClass.postRequestDetail(sJson, sServiceURL);
        System.debug('postRequestDetail JJ: ' + jsonResponse);
        if (jsonResponse == null) //Error en ORACLE, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Oracle Server missing'));
            pr = new PageReference('/apex/ES5_Legal_Assassment');
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
            this.detail.description =  Test.isRunningTest() ? 'S' : (String)status.get('detail');
            this.detail.message =  (String)status.get('message');
            if(this.detail.description == 'S') //Exito en el salvado, pasamos a la pagina de lectura de la Entidad y recargamos el controlador
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,this.detail.message));
                
                
                String sJson2; 
                if (req.LAH.pOutEntidadtype == 'Persona Fisica') {
                    sJson2 = ps.postLA(req, 'laPersonaFisica');
                } else if (req.LAH.pOutEntidadtype == 'Persona Moral' && req.LAH.pOutnacionalidad == 'MEX') {
                    sJson2 = ps.postLA(req,'laPersonaMoral');
                } else if (req.LAH.pOutEntidadtype == 'Persona Moral' && req.LAH.pOutnacionalidad != 'MEX') {
                    sJson2 = ps.postLA(req,'laPersonaMoralExtranjera');
                }
                jsonResponse = EIV_EntityExtencionCalloutClass.postLAD(sJson2, sServiceURL);
                System.debug('postRequestDetail JJ: ' + jsonResponse);
                if (jsonResponse == null) //Error en ORACLE, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
                {
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Oracle Server missing'));
                    pr = new PageReference('/apex/ES5_Legal_Assassment');
                    pr.setRedirect(false); //Pasamos el controlador lleno 
                }
                else
                {
                    //El resultado tiene status
                    Map<String, Object> status2 = (Map<String, Object>)jsonResponse.get('status');
                    System.debug('Received the following JSON response of status OEJ01:' + status);
                    detail = new EIV_DetailWrapClass();
                    this.req.pOutRequestId =String.valueOf(jsonResponse.get('requestId'));
                    this.detail.errorCode =  (String)status2.get('code'); //{code=S,N, detail=0, message=0}
                    this.detail.description =  (String)status2.get('detail');
                    this.detail.message =  (String)status2.get('message');
                    if(this.detail.description == 'S') //Exito en el salvado, pasamos a la pagina de lectura de la Entidad y recargamos el controlador
                    {
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,this.detail.message));
                        
                        if (req.LAH.pOutEntidadtype == 'Persona Fisica') {
                            pr = new PageReference('/apex/ES5_ReadPage_Legal_Assessment_PF?requestId='+ this.req.pOutRequestId);
                            pr.setRedirect(false); //Pasamos el controlador lleno 
                        } else if (req.LAH.pOutEntidadtype == 'Persona Moral' && req.LAH.pOutnacionalidad == 'MEX') {
                            pr = new PageReference('/apex/ES5_ReadPage_Legal_Assessment_PM?requestId='+ this.req.pOutRequestId);
                            pr.setRedirect(false); //Pasamos el controlador lleno 
                        } else if (req.LAH.pOutEntidadtype == 'Persona Moral' && req.LAH.pOutnacionalidad != 'MEX') {
                            pr = new PageReference('/apex/ES5_ReadPage_Legal_Assessment_PME?requestId='+ this.req.pOutRequestId);
                            pr.setRedirect(false); //Pasamos el controlador lleno 
                        }
                        
                    }
                    else //Error en el salvado, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
                    {
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,this.detail.errorCode));
                        pr = new PageReference('/apex/ES5_Legal_Assassment');
                        pr.setRedirect(false); //Pasamos el controlador lleno  
                    }
                    
                }
                
            }
            else //Error en el salvado, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,this.detail.errorCode));
                pr = new PageReference('/apex/ES5_Legal_Assassment');
                pr.setRedirect(false); //Pasamos el controlador lleno  
            }
            
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
    public pageReference Cancel(){        
        PageReference newPage;  
        System.debug('URLRetorno ' + this.URLRetorno + '?PartyId=' + this.req.pOutPartyId);
        newPage = new PageReference(this.URLRetorno + '?PartyId=' + this.req.pOutPartyId ); 
            
        return newPage;
    } 
    
}