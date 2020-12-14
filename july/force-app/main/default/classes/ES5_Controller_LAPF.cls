public class ES5_Controller_LAPF {
    
    public ES2_WraperRequest req {get;set;}
    public string idReg {get;set;}
    
    public String sSSO 									{get;set;}
    public boolean Ndocbtn								{get;set;}
    public EIV_DetailWrapClass detail {get;set;}
    public Map<string,object>jsonResponse =null;
    
    //para madar datos
    public String sServiceURL 							{get;set;}
    public string UrlAppDoctos {get;set;}
    public string EncriptationType {get;set;}
    public string KeyEncriptation {get;set;}
    public string URL_Servicio_Externa {get;set;}
    
    //para descargar doctos
    public string docId  								{get;set;}
    public string docUrl								{get;set;}
    public string cddate								{get;set;}
    public boolean urlflag								{get;set;}
    public string backUrl								{get;set;}
    public list <string> doctypess {get;Set;}
    public string doctiposString {get;set;}
    //para el "flujo de aprobacion"
    public boolean sendbtn								{get;set;}
    public boolean aceptbtn								{get;set;}
    public boolean cancelbtn							{get;set;}
    public boolean editbtn								{get;set;}
    public boolean aprbtn								{get;set;}
    public boolean rejbtn								{get;set;}
    public boolean reworkbtn							{get;set;}
    public boolean onhdbtn								{get;set;}
    public boolean btentbtn								{get;set;}
    public boolean Ncombtn								{get;set;}
    //para las fechas
    public date laFechaVT								{get;set;}
    public date laFechaN								{get;set;}
    public date laFechaVId								{get;set;}
    public date laFechaR								{ get; set; }
    
    public ES5_Controller_LAPF() {
        System.debug(LoggingLevel.INFO,'Inicia ES5_Controller_LAPF');
        this.req = new ES2_WraperRequest();
        this.req.pOutRequestId =  Test.isRunningTest() ? '1234' :(String)System.currentPageReference().getParameters().get('requestId');
        this.sServiceURL = Test.isRunningTest() ? 'hola mundo' :[Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='URL_Servicio'][0].EIV_tx_parameter__c;
        this.sSSO = Test.isRunningTest() ? '666' : [Select EmployeeNumber From User Where Id = :UserInfo.getUserId()][0].EmployeeNumber;  
        this.UrlAppDoctos = Test.isRunningTest() ? 'https://test.com' :  [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='UrlAppDoctos'][0].EIV_tx_parameter__c; 
        this.EncriptationType = Test.isRunningTest() ? 'AES128' :  [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='EncriptationType'][0].EIV_tx_parameter__c; 
        this.KeyEncriptation = Test.isRunningTest() ? 'https://test.com' :  [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='KeyEncriptation'][0].EIV_tx_parameter__c; 
        this.URL_Servicio_Externa = Test.isRunningTest() ? 'https://test.com' :  [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='URL_Servicio_Externa'][0].EIV_tx_parameter__c;
        
        //this.req.pOutRequestId =  (String)System.currentPageReference().getParameters().get('requestId');
        if ( String.isNotBlank(this.req.pOutRequestId) )
        {
            //es una consulta
           Map<string,object>jsonResponse =null;
            //jsonResponse = (Map<string,object>)JSON.deserializeUntyped(ES2_jsonDummy.entitymasterToJson());
            jsonResponse = Test.isRunningTest() ? new Map<string,object>() : EIV_EntityExtencionCalloutClass.callBackGetRequestDetailsOne(this.sSSO, 'SF', this.sServiceURL, this.req.pOutRequestId);
            //jsonResponse = EIV_EntityExtencionCalloutClass.callBackGetRequestDetailsOne(this.sSSO, 'SF', this.sServiceURL, this.req.pOutRequestId);
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
                if (req.LAH.pfisica != null){
                    this.laFechaR = String_To_Date(req.LAH.pfisica.pOutLABFechaRevision);
                    this.laFechaVT = String_To_Date(req.LAH.pOutValidThrough);
                    this.laFechaN = String_To_Date(req.LAH.pfisica.pOutLAPFDGFechadenacimiento);
                    this.laFechaVId = String_To_Date(req.LAH.pfisica.pOutLAPFDGVigenciaId);
                }
            }
        }
    }
    //aqui empieza la parte de los zip code para edit e inserts
    public string PostalCode;
    public string PostalCodeCD;
    public string PostalCodeDF;
    //public string postalCodeId {get;set;}
    
    public String getPostalCode() {
        
        try{
            System.debug('Codigo Postal consultado OEJ' + PostalCode);
            EIV_PostalCodeCatalog__c postalCodeCatalog = [Select id, EIV_tx_Codigo_Estado__c, EIV_tx_Postal_Code__c from EIV_PostalCodeCatalog__c where EIV_tx_Postal_Code__c =:req.LAH.pfisica.pOutLADSCodigoPostal Limit 1];
            System.debug('Codigo Postal consultado' + postalCodeCatalog);
            //req.LAH.pmoral.pOutLAMDSCodigoPostal = postalCodeCatalog.EIV_tx_Postal_Code__c.leftPad(1, '0') ;
            //req.LAH.pmoral.pOutLAMDSEstado = postalCodeCatalog.EIV_tx_Codigo_Estado__c;
            this.PostalCode = postalCodeCatalog.id;
        }
        Catch(Exception e)
        {
            System.debug('No existe el ID');
        }            
        
        
        return this.PostalCode;
    }
    
    public void setPostalCode(String PostalCode) {
        
        try{
            System.debug('Codigo Postal consultado OEJ' + PostalCode);
            EIV_PostalCodeCatalog__c postalCodeCatalog = [Select id, EIV_tx_Codigo_Estado__c, EIV_tx_Postal_Code__c from EIV_PostalCodeCatalog__c where id =:PostalCode Limit 1];
            System.debug('Codigo Postal consultado' + postalCodeCatalog);
            req.LAH.pfisica.pOutLADSCodigoPostal = postalCodeCatalog.EIV_tx_Postal_Code__c;
            req.LAH.pfisica.pOutLADSEstado = postalCodeCatalog.EIV_tx_Codigo_Estado__c;
            
        }
        Catch(Exception e)
        {
            System.debug('No existe el ID');
        }
        
    }
    
    public String getPostalCodeCD() {
        
        try{
            System.debug('Codigo Postal consultado OEJ' + PostalCodeCD);
            EIV_PostalCodeCatalog__c postalCodeCatalog = [Select id, EIV_tx_Codigo_Estado__c, EIV_tx_Postal_Code__c from EIV_PostalCodeCatalog__c where EIV_tx_Postal_Code__c =:req.LAH.pfisica.pOutLACDCodigoPostal Limit 1];
            System.debug('Codigo Postal consultado' + postalCodeCatalog);
            //req.LAH.pmoral.pOutLAMDSCodigoPostal = postalCodeCatalog.EIV_tx_Postal_Code__c.leftPad(1, '0') ;
            //req.LAH.pmoral.pOutLAMDSEstado = postalCodeCatalog.EIV_tx_Codigo_Estado__c;
            this.PostalCodeCD = postalCodeCatalog.id;
        }
        Catch(Exception e)
        {
            System.debug('No existe el ID');
        }            
        
        
        return this.PostalCodeCD;
    }
    
    public void setPostalCodeCD(String PostalCodeCD) {
        
        try{
            System.debug('Codigo Postal consultado OEJ' + PostalCodeCD);
            EIV_PostalCodeCatalog__c postalCodeCatalog = [Select id, EIV_tx_Codigo_Estado__c, EIV_tx_Postal_Code__c from EIV_PostalCodeCatalog__c where id =:PostalCodeCD Limit 1];
            System.debug('Codigo Postal consultado' + postalCodeCatalog);
            req.LAH.pfisica.pOutLACDCodigoPostal = postalCodeCatalog.EIV_tx_Postal_Code__c;
            req.LAH.pfisica.pOutLAMCDEstado = postalCodeCatalog.EIV_tx_Codigo_Estado__c;
            
        }
        Catch(Exception e)
        {
            System.debug('No existe el ID');
        }
        
    }
    
    public String getPostalCodeDF() {
        
        try{
            System.debug('Codigo Postal consultado OEJ' + PostalCodeDF);
            EIV_PostalCodeCatalog__c postalCodeCatalog = [Select id, EIV_tx_Codigo_Estado__c, EIV_tx_Postal_Code__c from EIV_PostalCodeCatalog__c where EIV_tx_Postal_Code__c =:req.LAH.pfisica.pOutLADFCodigoPostal Limit 1];
            System.debug('Codigo Postal consultado' + postalCodeCatalog);
            //req.LAH.pmoral.pOutLAMDSCodigoPostal = postalCodeCatalog.EIV_tx_Postal_Code__c.leftPad(1, '0') ;
            //req.LAH.pmoral.pOutLAMDSEstado = postalCodeCatalog.EIV_tx_Codigo_Estado__c;
            this.PostalCodeDF = postalCodeCatalog.id;
        }
        Catch(Exception e)
        {
            System.debug('No existe el ID');
        }            
        
        
        return this.PostalCodeDF;
    }
    
    public void setPostalCodeDF(String PostalCodeDF) {
        
        try{
            System.debug('Codigo Postal consultado OEJ' + PostalCodeDF);
            EIV_PostalCodeCatalog__c postalCodeCatalog = [Select id, EIV_tx_Codigo_Estado__c, EIV_tx_Postal_Code__c from EIV_PostalCodeCatalog__c where id =:PostalCodeDF Limit 1];
            System.debug('Codigo Postal consultado' + postalCodeCatalog);
            req.LAH.pfisica.pOutLADFCodigoPostal = postalCodeCatalog.EIV_tx_Postal_Code__c;
            req.LAH.pfisica.pOutLADFEstado = postalCodeCatalog.EIV_tx_Codigo_Estado__c;
            
        }
        Catch(Exception e)
        {
            System.debug('No existe el ID');
        }
        
    }
    public string pais;
    public string paisCD;
    public string paisDF;
    
    public String getpais() {
        
        try{
            System.debug('Pais consultado JDLL' + pais);
            ES5_obj_catalogo_pais__c paisCatalogo = [Select id, ES5_tx_codigo_pais__c, ES5_tx_nombre_pais__c from ES5_obj_catalogo_pais__c where ES5_tx_codigo_pais__c =:req.LAH.pfisica.pOutLADSPais Limit 1];
            System.debug('Codigo Postal consultado' + paisCatalogo);
            //req.LAH.pmoral.pOutLAMDSCodigoPostal = postalCodeCatalog.EIV_tx_Postal_Code__c.leftPad(1, '0') ;
            //req.LAH.pmoral.pOutLAMDSEstado = postalCodeCatalog.EIV_tx_Codigo_Estado__c;
            this.pais = paisCatalogo.ES5_tx_nombre_pais__c;
        }
        Catch(Exception e)
        {
            System.debug('No existe el ID');
        }            
        
        
        return this.pais;
    }
    
    public void setpais(String Pais) {
        
        try{
            System.debug('Codigo Postal consultado OEJ' + Pais);
            ES5_obj_catalogo_pais__c paisCatalogo = [Select id, ES5_tx_codigo_pais__c, ES5_tx_nombre_pais__c from ES5_obj_catalogo_pais__c where id =:Pais Limit 1];
            System.debug('Codigo Postal consultado' + paisCatalogo);
            req.LAH.pfisica.pOutLADSPais = paisCatalogo.ES5_tx_codigo_pais__c;
            
        }
        Catch(Exception e)
        {
            System.debug('No existe el ID');
        }
        
    }
    
    public String getpaisCD() {
        
        try{
            System.debug('Pais consultado JDLL' + paisCD);
            ES5_obj_catalogo_pais__c paisCatalogo = [Select id, ES5_tx_codigo_pais__c, ES5_tx_nombre_pais__c from ES5_obj_catalogo_pais__c where ES5_tx_codigo_pais__c =:req.LAH.pfisica.pOutLACDPais Limit 1];
            System.debug('Codigo Postal consultado' + paisCatalogo);
            //req.LAH.pmoral.pOutLAMDSCodigoPostal = postalCodeCatalog.EIV_tx_Postal_Code__c.leftPad(1, '0') ;
            //req.LAH.pmoral.pOutLAMDSEstado = postalCodeCatalog.EIV_tx_Codigo_Estado__c;
            this.paisCD = paisCatalogo.ES5_tx_nombre_pais__c;
        }
        Catch(Exception e)
        {
            System.debug('No existe el ID');
        }            
        
        
        return this.paisCD;
    }
    
    public void setpaisCD(String PaisCD) {
        
        try{
            System.debug('Codigo Postal consultado OEJ' + PaisCD);
            ES5_obj_catalogo_pais__c paisCatalogo = [Select id, ES5_tx_codigo_pais__c, ES5_tx_nombre_pais__c from ES5_obj_catalogo_pais__c where id =:PaisCD Limit 1];
            System.debug('Codigo Postal consultado' + paisCatalogo);
            req.LAH.pfisica.pOutLACDPais = paisCatalogo.ES5_tx_codigo_pais__c;
            
        }
        Catch(Exception e)
        {
            System.debug('No existe el ID');
        }
        
    }
    
    public String getpaisDF() {
        
        try{
            System.debug('Pais consultado JDLL' + paisDF);
            ES5_obj_catalogo_pais__c paisCatalogo = [Select id, ES5_tx_codigo_pais__c, ES5_tx_nombre_pais__c from ES5_obj_catalogo_pais__c where ES5_tx_codigo_pais__c =:req.LAH.pfisica.pOutLADFPais Limit 1];
            System.debug('Codigo Postal consultado' + paisCatalogo);
            //req.LAH.pmoral.pOutLAMDSCodigoPostal = postalCodeCatalog.EIV_tx_Postal_Code__c.leftPad(1, '0') ;
            //req.LAH.pmoral.pOutLAMDSEstado = postalCodeCatalog.EIV_tx_Codigo_Estado__c;
            this.paisDF = paisCatalogo.ES5_tx_nombre_pais__c;
        }
        Catch(Exception e)
        {
            System.debug('No existe el ID');
        }            
        
        
        return this.paisDF;
    }
    
    public void setpaisDF(String PaisDF) {
        
        try{
            System.debug('Codigo Postal consultado OEJ' + PaisDF);
            ES5_obj_catalogo_pais__c paisCatalogo = [Select id, ES5_tx_codigo_pais__c, ES5_tx_nombre_pais__c from ES5_obj_catalogo_pais__c where id =:PaisDF Limit 1];
            System.debug('Codigo Postal consultado' + paisCatalogo);
            req.LAH.pfisica.pOutLADFPais = paisCatalogo.ES5_tx_codigo_pais__c;
            
        }
        Catch(Exception e)
        {
            System.debug('No existe el ID');
        }
        
    }
    
    /***********************************HELPER****************************************/
    
    //para los campos de fecha
    public Date String_To_Date (String Process_Date){
        System.debug(LoggingLevel.INFO, 'Inicia Formate_Date ' + Process_Date);
        Date Date_Result;
        try{        	
            if(Process_Date != null){
                Date_Result = Date.parse(Process_Date);
                System.debug(LoggingLevel.DEBUG, 'Date_Result ' + Date_Result);                
            }    
        } catch(System.CalloutException e) {
            System.debug(LoggingLevel.ERROR,'Ocurrió un error en la consulta del WS');
            System.debug(LoggingLevel.ERROR,'linia ' + e.getLineNumber());
            System.debug(LoggingLevel.ERROR,'Mensaje' + e.getMessage());
            
        }
        System.debug(LoggingLevel.INFO, 'Termina Formate_Date con datos nulos');
        return Date_Result;
    }
    
    public String Date_Format (Date Process_Date){
        System.debug(LoggingLevel.INFO, 'Inicia Date_Format');
        String Process_String_Date;
        if(Process_Date != null){
            Process_String_Date = String.valueOf(Process_Date.format());
        }
        System.debug(LoggingLevel.INFO, 'Termina Date_Format con datos nulos');
        return Process_String_Date;
    }
    
    //flugo de aprobaciones
    public PageReference saveStatusGeneral(String oldStatus, String sStatus, Boolean deleteAssignedTo) //funcion que manda el cambio del status
    {
        ES2_controller_POSTjson ps = new ES2_controller_POSTjson();
        PageReference pr;
        
        if(sStatus=='CANCELLED BY REQUESTOR'||sStatus=='APPROVED'|| sStatus=='REWORK'){
            req.pOutRequestStatus = sStatus;
            req.pOutEndDate = System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00'));
        }else if(sStatus=='IN PROCESS'){
            req.pOutRequestStatus = sStatus;
            req.pOutAssignedTo = sSSO;
        }else{
            req.pOutRequestStatus = sStatus;
            
        }
        if(deleteAssignedTo)
        {
            req.nameAssignedTo = '';
            req.pOutAssignedTo = '';
        }
        
        req.pOutUpdatedBy = sSSO;
        String sJson = ps.postgeneral('LEGAL ASSESSMENT', req);
        
        Map<string,object> jsonResponse =null;
        
        
        //jsonResponse = (Map<string,object>)JSON.deserializeUntyped(ES2_jsonDummy.entitymasterToJson());
        jsonResponse = EIV_EntityExtencionCalloutClass.postRequestDetail(sJson, sServiceURL);
        System.debug('postRequestDetail JJ: ' + jsonResponse);
        if (jsonResponse == null) //Error en ORACLE, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Oracle Server missing'));
            req.pOutRequestStatus = oldStatus;
            pr = new PageReference('/apex/ES5_ReadPage_Legal_Assessment_PF');
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
                pr = new PageReference('/apex/ES5_ReadPage_Legal_Assessment_PF?requestId=' + req.pOutRequestId);
                pr.setRedirect(true); //Recargamos el controlador  
                
            }
            else //Error en el salvado, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,this.detail.errorCode));
                req.pOutRequestStatus = oldStatus;
                pr = new PageReference('/apex/ES5_ReadPage_Legal_Assessment_PF');
                pr.setRedirect(false); //Pasamos el controlador lleno  
            }
            
        } 
        return pr;
    }
    //
    public boolean cambia(string p){ //funcion que prende y apaga los botones
        if(p == '10000'){
            return true;
        }else{
            return false; 
        }
    }
    
    public void yesnobtn(){ //funcion para leer cada uno de los privilegios del json
        system.debug('lo que me llega de privilage'+ req.privilegeObj);
        integer i = req.privilegeObj.size();
        system.debug('tamaño del arreglo' + i);
        for(integer a=0;a<i;a++){
            if(req.privilegeObj[a].section == 'ON HOLD'){
                onhdbtn = cambia(req.privilegeObj[a].vCrud);
            }
            else if(req.privilegeObj[a].section == 'REWORK'){
                reworkbtn = cambia(req.privilegeObj[a].vCrud);
            }
            else if(req.privilegeObj[a].section == 'CANCELLED BY REQUESTOR'){
                cancelbtn = cambia(req.privilegeObj[a].vCrud);
            }
            else if(req.privilegeObj[a].section == 'PENDING'){
                sendbtn = cambia(req.privilegeObj[a].vCrud);
            }
            else if(req.privilegeObj[a].section == 'IN PROCESS'){
                aceptbtn = cambia(req.privilegeObj[a].vCrud);
            }
            else if(req.privilegeObj[a].section == 'REJECTED'){
                rejbtn = cambia(req.privilegeObj[a].vCrud);
            }
            else if(req.privilegeObj[a].section == 'APPROVED'){
                aprbtn = cambia(req.privilegeObj[a].vCrud);
            }
            else if(req.privilegeObj[a].section == 'EDIT'){
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
    public PageReference send()
    {
       /* string identifica = 'Yes';
        system.debug('lo que me llega de doctype'+ req.DocTypesObj);
        PageReference pr;
        integer i = req.DocTypesObj.size();
        system.debug('size ' +i);
        for(integer a=0;a<i;a++){
            system.debug('prms ' + req.DocTypesObj[a].prm1);
            if(req.DocTypesObj[a].prm1 == 'REQUIRED' && req.DocTypesObj[a].prm1 !='OK'){
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'falta '+ req.DocTypesObj[a].name));
                identifica='No';
            }
        }
        if(identifica!='No'){
            
            pr = saveStatusGeneral(req.pOutRequestStatus, 'PENDING',false );
            
        }
        
        return pr;  */
        
        PageReference pr;
        pr = saveStatusGeneral(req.pOutRequestStatus, 'PENDING', false );
        return pr;
    }
    public PageReference accept()
    {
        
        PageReference pr = saveStatusGeneral(req.pOutRequestStatus, 'IN PROCESS', false );
        return pr;        
    }    
    public PageReference cancel()
    {
        
        PageReference pr = saveStatusGeneral(req.pOutRequestStatus, 'CANCELLED BY REQUESTOR' , false);
        return pr;        
    } 
    
    public PageReference approve()
    {
        PageReference pr ;
        /*if(req.LAH.pfisica.apoderados == null || req.LAH.pfisica.apoderados.size() == 0){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'agrega por lo menos un apoderado para poder continuar'));
            pr = new PageReference('/apex/ES5_ReadPage_Legal_Assessment_PF');
            pr.setRedirect(false); //Pasamos el controlador lleno 
            
            
        }else{*/
            pr = saveStatusGeneral(req.pOutRequestStatus, 'APPROVED', false );
        //}
        return pr;   
    } 
    
    public PageReference onHold()
    {
        PageReference pr = saveStatusGeneral(req.pOutRequestStatus, 'ON HOLD', false );
        return pr;        
    }  
    public PageReference rework()
    {
        PageReference pr = saveStatusGeneral(req.pOutRequestStatus, 'REWORK', false );
        return pr;        
    }  
    
    public PageReference reject()
    {
        PageReference pr = saveStatusGeneral(req.pOutRequestStatus, 'REJECTED', false );
        return pr;        
    }  
    
    public PageReference PrintPDF()
    {
        PageReference pr = saveStatusGeneral(req.pOutRequestStatus, 'PRINT PDF', false );
        return pr;        
    }  
    
    
    
    //Método para excluir los elementos de la lista y dejar uno solo
    public List<ES5_wraper_LA_limitante> Busca_Limitante(){
        System.debug(LoggingLevel.INFO,'Inicia BuscaLimitante ');
        List<ES5_wraper_LA_limitante> List_ES5_wraper_LA_limitante = new List<ES5_wraper_LA_limitante>();
        for(ES5_wraper_LA_limitante limitante : req.LAH.pmoral.limitantes){
            if(limitante.laMLLimatingId.equals(idReg)){
                List_ES5_wraper_LA_limitante.add(limitante);
                return List_ES5_wraper_LA_limitante;               	    
            }            
        }
        System.debug(LoggingLevel.WARN,'No se encontró limitante seleccionada');
        return null;        
    }
    //Método para excluir los elementos de la lista y dejar uno solo
    public List<ES5_wraper_LA_modificacion> Busca_Modificaciones(){
        System.debug(LoggingLevel.INFO,'Inicia BuscaLimitante ');
        List<ES5_wraper_LA_modificacion> List_ES5_ES5_wraper_LA_modificacion = new List<ES5_wraper_LA_modificacion>();
        for(ES5_wraper_LA_modificacion Modificacion : req.LAH.pmoral.modificaciones){
            if(Modificacion.laMModificationId.equals(idReg)){
                List_ES5_ES5_wraper_LA_modificacion.add(Modificacion);
                return List_ES5_ES5_wraper_LA_modificacion;               	    
            }            
        }
        System.debug(LoggingLevel.WARN,'No se encontró limitante seleccionada');
        return null;        
    }
    /***********************************REDIRECT PAGE****************************************/
    //**************************** Limitantes
    public PageReference Redirect_RP_Limitantes() {
        System.debug(LoggingLevel.INFO,'Inicia Redirect_RP_Limitantes');
        System.debug(LoggingLevel.DEBUG,'ID seleccionado ' + idReg);
        PageReference newPage;
        try{
            this.req.LAH.pmoral.limitantes = Busca_Limitante();
            System.debug('this.req.LAH.pmoral.limitantes ' + this.req.LAH.pmoral.limitantes.size());
            String JSON = JSON.serialize(req, true);
            System.debug('JSON ' + JSON);
            String URLR = '/apex/ES5_ReadPage_Limitantes?' +
                'JSON_Request=' + JSON;
            
            System.debug('URLR ' + URLR);
            newPage = new PageReference(URLR);
            newPage.setRedirect(true);
            
        }catch(Exception e){
            System.debug(LoggingLevel.ERROR,'Error al enviar JSON ' + e);
        }
        return newPage;
    }
    public PageReference Redirect_New_Limitantes() {
        System.debug(LoggingLevel.DEBUG,'idReg ' + this.idReg);
        
        PageReference newPage;
        try{
            this.req.LAH.pmoral.limitantes = new List<ES5_wraper_LA_limitante>();
            System.debug('this.req.LAH.pmoral.limitantes ' + this.req.LAH.pmoral.limitantes.size());
            String URLR = '/apex/ES5_EditPage_Limitantes?JSON=' + 
                JSON.serialize(this.req,true);
            System.debug('URLR ' + URLR);
            newPage = new PageReference(URLR);
            newPage.setRedirect(true);
            
        }catch(Exception e){
            System.debug(LoggingLevel.ERROR,'Error al enviar JSON ' + e);
        }
        return newPage;
    }
    //**************************** Modificaciones
    public PageReference Redirect_RP_Modificaciones() {
        System.debug(LoggingLevel.INFO,'Inicia Redirect_RP_Modificaciones');
        System.debug(LoggingLevel.DEBUG,'ID seleccionado ' + idReg);
        PageReference newPage;
        try{
            this.req.LAH.pmoral.modificaciones = Busca_Modificaciones();
            String JSON = JSON.serialize(req, true);
            System.debug('JSON ' + JSON);
            String URLR = '/apex/ES5_ReadPage_Modificaciones?' +
                'JSON_Request=' + JSON;
            
            System.debug('URLR ' + URLR);
            newPage = new PageReference(URLR);
            newPage.setRedirect(true);
            
        }catch(Exception e){
            System.debug(LoggingLevel.ERROR,'Error al enviar JSON ' + e);
        }
        return newPage;
    }
    public PageReference Redirect_New_Modificaciones() {
        System.debug(LoggingLevel.INFO,'Inicia Redirect_RP_Modificaciones');
        PageReference newPage;
        try{
            this.req.LAH.pmoral.modificaciones = new List<ES5_wraper_LA_modificacion>();
            String JSON = JSON.serialize(req, true);
            
            String URLR = '/apex/Redirect_EP_Modificaciones?JSON_Request=' + JSON;
            
            System.debug('URLR ' + URLR);
            newPage = new PageReference(URLR);
            newPage.setRedirect(true);
            
        }catch(Exception e){
            System.debug(LoggingLevel.ERROR,'Error al enviar JSON ' + e);
        }
        return newPage;
    }
    //**************************** Apoderados
    public PageReference viewApoder(){
        
        PageReference pr = new PageReference('/apex/ES5_ReadPage_Apoderados?idReg='+idReg+'&requestId='+req.pOutRequestId);
        pr.setRedirect(false); 
        return pr;        
        
    }
    public PageReference EditPM	(){
        PageReference pr;
        pr = new PageReference('/apex/ES5_EditPage_Legal_Assessment_PM');
        pr.setRedirect(false); //Pasamos el controlador lleno 
        return pr;  
        
    }
    
    public PageReference savePF(){
        //falta logica del guardado
        ES2_controller_POSTjson ps = new ES2_controller_POSTjson();
        PageReference pr;
        req.pOutUpdatedBy = sSSO;
        req.pOutCreatedBy = sSSO;
        req.LAH.pfisica.pOutLABFechaRevision = Date_Format ( this.laFechaR ) ;
        req.LAH.pOutValidThrough = Date_Format(this.laFechaVT);
        req.LAH.pfisica.pOutLAPFDGFechadenacimiento = Date_Format(this.laFechaN);
        req.LAH.pfisica.pOutLAPFDGVigenciaId = Date_Format(this.laFechaVId);
        String sJson = ps.postLA(req,'laPersonaFisica');
        
        system.debug('pOutCreatedBy' + req.pOutCreatedBy);
        
        //jsonResponse = (Map<string,object>)JSON.deserializeUntyped(ES2_jsonDummy.entitymasterToJson());
       /* if(string.isBlank(req.LAH.pfisica.pOutLAPFDGEstadoCivil)||string.isBlank(req.LAH.pfisica.pOutLAPFDGFechadenacimiento)||
           string.isBlank(req.LAH.pfisica.pOutLAPFDGVigenciaId)||string.isBlank(req.LAH.pfisica.pOutLAPFDGLugardenacimiento) ||
           string.isBlank(req.LAH.pfisica.pOutLADSPais) ||string.isBlank(req.LAH.pfisica.pOutLADSColonia) || string.isBlank(req.LAH.pfisica.pOutLADSCodigoPostal) ||
           string.isBlank(req.LAH.pfisica.pOutLADSCalle) || string.isBlank(req.LAH.pfisica.pOutLADSNumExterior) ||string.isBlank(req.LAH.pfisica.pOutLADSCiudad) ||
           string.isBlank(req.LAH.pfisica.pOutLADSMunicipioAlcaldia) ||
           string.isBlank(req.LAH.pfisica.pOutLACDPais)||string.isBlank(req.LAH.pfisica.pOutLACDColonia)||string.isBlank(req.LAH.pfisica.pOutLACDCodigoPostal)||
           string.isBlank(req.LAH.pfisica.pOutLACDCalle)||string.isBlank(req.LAH.pfisica.pOutLAMCDEstado)||string.isBlank(req.LAH.pfisica.pOutLACDNumExterior)||
           string.isBlank(req.LAH.pfisica.pOutLACDCiudad)||string.isBlank(req.LAH.pfisica.pOutLACDMunicipioAlcaldia)||
           string.isBlank(req.LAH.pfisica.pOutLADFMunicipioAlcaldia)||string.isBlank(req.LAH.pfisica.pOutLADFPais)||
           string.isBlank(req.LAH.pfisica.pOutLADFColonia)||string.isBlank(req.LAH.pfisica.pOutLADFCodigoPostal)||string.isBlank(req.LAH.pfisica.pOutLADFCalle)||
           string.isBlank(req.LAH.pfisica.pOutLADFNumExterior)||string.isBlank(req.LAH.pfisica.pOutLADFCiudad)){
               ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'faltan los campos marcados con un *'));
               pr = new PageReference('/apex/ES5_EditPage_Legal_Assessment_PF');
               pr.setRedirect(false); //Pasamos el controlador lleno 
               
           }else */
               
            if (req.LAH.pfisica.pOutLABIncidencias == 'Y' && string.isBlank ( req.LAH.pfisica.pOutLABComentarios )) {
               ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'faltan agregar un comentario de la incidencia del Bil'));
               pr = new PageReference('/apex/ES5_EditPage_Legal_Assessment_PF');
               pr.setRedirect(false); //Pasamos el controlador lleno 
           } else {
               jsonResponse = EIV_EntityExtencionCalloutClass.postLAD(sJson, sServiceURL);
               System.debug('postRequestDetail JJ: ' + jsonResponse);
               if (jsonResponse == null) //Error en ORACLE, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
               {
                   ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Oracle Server missing'));
                   pr = new PageReference('/apex/ES5_EditPage_Legal_Assessment_PF');
                   pr.setRedirect(false); //Pasamos el controlador lleno 
               }
               else
               {
                   //El resultado tiene status
                   Map<String, Object> status = (Map<String, Object>)jsonResponse.get('status');
                   System.debug('Received the following JSON response of status OEJ01:' + status);
                   detail = new EIV_DetailWrapClass();
                   //this.req.pOutRequestId =String.valueOf(jsonResponse.get('requestId'));
                   this.detail.errorCode =  (String)status.get('code'); //{code=S,N, detail=0, message=0}
                   this.detail.description =  (String)status.get('detail');
                   this.detail.message =  (String)status.get('message');
                   if(this.detail.description == 'S') //Exito en el salvado, pasamos a la pagina de lectura de la Entidad y recargamos el controlador
                   {
                       ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,this.detail.message));
                       pr = new PageReference('/apex/ES5_ReadPage_Legal_Assessment_PF?requestId='+ this.req.pOutRequestId);
                       pr.setRedirect(true); //Pasamos el controlador lleno 
                       
                   }
                   else //Error en el salvado, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
                   {
                       ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,this.detail.errorCode));
                       pr = new PageReference('/apex/ES5_EditPage_Legal_Assessment_PF');
                       pr.setRedirect(false); //Pasamos el controlador lleno  
                   }
                   
               } 
           }
        return pr;  
        
    }
    /*****************TABLA DE APODERADOS**************/
    public PageReference Redirect_New_Apoder(){        
        System.debug(LoggingLevel.INFO,'Inicia Redirect_New_Apoder');
        PageReference newPage;
        try{
            String JSON = JSON.serialize(req, true);
            System.debug('JSON ' + JSON);
            String URLR = '/apex/ES5_Editpage_Apoderados?requestId=' + this.req.pOutRequestId +
                '&Tipo_Persona=3' +
                '&Tipo_detalle=A'+
                '&Tipo_Peticion=NEW';            
            System.debug('URLR ' + URLR);
            newPage = new PageReference(URLR);
            newPage.setRedirect(false);            
        }catch(Exception e){
            System.debug(LoggingLevel.ERROR,'Error al enviar JSON ' + e);
        }
        return newPage; 
    }
    public PageReference Redirect_New_limitante(){        
        System.debug(LoggingLevel.INFO,'Inicia Redirect_New_limitante');
        PageReference newPage;
        try{
            String JSON = JSON.serialize(req, true);
            System.debug('JSON ' + JSON);
            String URLR = '/apex/ES5_Editpage_Apoderados?requestId=' + this.req.pOutRequestId +
                '&Tipo_Persona=3' +
                '&Tipo_detalle=L'+
                '&Tipo_Peticion=NEW';            
            System.debug('URLR ' + URLR);
            newPage = new PageReference(URLR);
            newPage.setRedirect(false);            
        }catch(Exception e){
            System.debug(LoggingLevel.ERROR,'Error al enviar JSON ' + e);
        }
        return newPage; 
    }
    public PageReference Redirect_Read_Apoder(){
        
        System.debug(LoggingLevel.INFO,'Inicia Redirect_New_Apoder');
        PageReference newPage;
        try{
            //this.req.LAH.pmoral.apoderados = Busca_Apoderado();
            //String JSON = JSON.serialize(req, true);
            string b;
            integer i = this.req.LAH.pfisica.apoderados.size();
            system.debug('id reg' + idReg);
            for(integer a=0; a < i;a++){
                system.debug('id apode' + req.LAH.pfisica.apoderados[a].laAApoderadoID);
                if(this.req.LAH.pfisica.apoderados[a].laAApoderadoID == this.idReg){
                    if(this.req.LAH.pfisica.apoderados[a].laAEscrituraRevoca == null){
                        b='A';
                    }else{
                        b='L';  
                    }
                }else{
                    system.debug('no se encontro el apoderado/revocado');
                }
            }
            
            // String URLR = '/apex/ES5_Readpage_Apoderados?JSON_Request=' + JSON + '&Tipo_Persona=1';
            String URLR = '/apex/ES5_Readpage_Apoderados?requestId=' + this.req.pOutRequestId +
                '&Tipo_Persona=3' +
                '&Tipo_Peticion=EDIT' +
                '&Tipo_detalle='+ b +
                '&Apoderado_ID=' + this.idReg;
            System.debug('URLR ' + URLR);
            newPage = new PageReference(URLR);
            newPage.setRedirect(true);
            
        }catch(Exception e){
            System.debug(LoggingLevel.ERROR,'Error al enviar JSON ' + e);
        }
        return newPage;        
        
    }
    public PageReference Backtoentity(){
        PageReference pr;
        pr = new PageReference('/apex/EIV_EntityReadPageIndividual?PartyId='+req.pOutPartyId);
        pr.setRedirect(true); //Pasamos el controlador vacio 
        return pr;  
        
    }
    
    public PageReference NewApoder(){
        
        PageReference pr = new PageReference('/apex/ES5_EditPage_Apoderados?requestId='+req.pOutRequestId);
        pr.setRedirect(false); 
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
                                             '&dir=LAPF');
        pr.setRedirect(false); //Pasamos el controlador vacio  
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
            string backUrl = System.Url.getSalesforceBaseURL().toExternalForm() + '/one/one.app#/alohaRedirect/apex/ES5_ReadPage_Legal_Assessment_PF?requestId='+ requestId;
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
        string backUrl = System.Url.getSalesforceBaseURL().toExternalForm() + '/one/one.app#/alohaRedirect/apex/ES5_ReadPage_Legal_Assessment_PF?requestId='+ requestId;
        
        
        
        
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
        
        string backUrl = System.Url.getSalesforceBaseURL().toExternalForm() + '/one/one.app#/alohaRedirect/apex/ES5_ReadPage_Legal_Assessment_PF?requestId='+ RequestId;
        
        STRING clearText = 'contentDocId='+ docId + '&backUrl=' +backUrl +'&urlserver='+ URL_Servicio_Externa + '&cddate=' + cddate;
        Blob key = Blob.valueOf(KeyEncriptation);
        Blob textoEncB = Crypto.encryptWithManagedIV(EncriptationType, key, Blob.valueOf(clearText));
        String textoEnc = EncodingUtil.base64Encode(textoEncB);
        string encodedTextAES = UrlAppDoctos + '/xxec_episodioIVDocuments-vcDocuments-context-root/faces/documentDownloadFile.jspx?params=' + textoEnc;
        System.debug(encodedTextAES);
        return encodedTextAES;
    }
    public PageReference EditPF	(){
        PageReference pr;
        pr = new PageReference('/apex/ES5_EditPage_Legal_Assessment_PF');
        pr.setRedirect(false); //Pasamos el controlador lleno 
        return pr;  
        
    }
    public PageReference Backtola(){
        PageReference pr;
        pr = new PageReference('/apex/ES5_ReadPage_Legal_Assessment_PF?requestId='+ this.req.pOutRequestId);
        pr.setRedirect(true); //Pasamos el controlador vacio 
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
}