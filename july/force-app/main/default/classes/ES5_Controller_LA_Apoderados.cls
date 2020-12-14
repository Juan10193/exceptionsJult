public class ES5_Controller_LA_Apoderados {
    
    public ES2_WraperRequest req			 {get; set;}
    public string idReg 					 {get; set;}
    public string URLR						 {get; set;}
    //fechas
    public date laAFecha 					 {get; set;}
    public date laAvigid 					 {get; set;}
    public date laAFechaRegistro 			 {get; set;}
    public date laAFechaNacimiento 			 {get; set;}
    public date laAFechaRevoca 				 {get; set;}
    public boolean IsBackToLegal 			 {get; set;}
    public boolean editbtn					 {get;set;}
    public boolean aprbtn								{get;set;}
    public string pag 						 {get; set;}
    public string sSSO 						 {get; set;}
    public string sServiceURL 				 {get; set;}
    public ES5_wraper_LA_apoderados APO 	 {get; set;}
    //1 persona moral
    //2 persona moral extrangera
    //3 persona física
    public string Tipo_Persona 				 {get; set;}
    public Map<string,object>jsonResponse =null;
        public EIV_DetailWrapClass detail {get;set;}
    public string Tipo_Peticion 			{get;set;}
    //public string Apoderado_ID				{get;set;}
    public string Nac;
    public string Tipo_detalle				{get;set;} 
    
    public ES5_Controller_LA_Apoderados(){
        System.debug(LoggingLevel.INFO,'Inicia ES5_Controller_LA_Apoderados');
        this.req = new ES2_WraperRequest();
        this.req.pOutRequestId =  Test.isRunningTest() ? '1111' :(String)System.currentPageReference().getParameters().get('requestId');
        this.pag= Test.isRunningTest() ? 'LA' :(String)System.currentPageReference().getParameters().get('pag');
        //this.idReg=  Test.isRunningTest() ? '1' :(String)System.currentPageReference().getParameters().get('idReg');
        this.sServiceURL = Test.isRunningTest() ? 'http://160.34.7.97:7033' :[Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='URL_Servicio'][0].EIV_tx_parameter__c; 
        this.sSSO = Test.isRunningTest() ? '666' : [Select EmployeeNumber From User Where Id = :UserInfo.getUserId()][0].EmployeeNumber;  
        this.APO = new ES5_wraper_LA_apoderados();
        this.Tipo_Persona = (String)System.currentPageReference().getParameters().get('Tipo_Persona');
        this.Tipo_Peticion = (String)System.currentPageReference().getParameters().get('Tipo_Peticion');
        this.Tipo_detalle = (String)System.currentPageReference().getParameters().get('Tipo_detalle');
        this.idReg = Test.isRunningTest() ? 'NEW' :(String)System.currentPageReference().getParameters().get('Apoderado_ID');
        system.debug('Tipo_Persona ' + Tipo_Persona);
        if ( String.isNotBlank(this.req.pOutRequestId) )
        {
            //es una consulta
            Map<string,object>jsonResponse =null;
            
            //jsonResponse = (Map<string,object>)JSON.deserializeUntyped(ES2_jsonDummy.entitymasterToJson());
            jsonResponse = Test.isRunningTest() ? (Map<string,object>)JSON.deserializeUntyped(ES2_jsonDummy.entitymasterToJson()) :EIV_EntityExtencionCalloutClass.callBackGetRequestDetailsOne(this.sSSO, 'SF', this.sServiceURL, this.req.pOutRequestId);
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
            }
            if(Tipo_Peticion.equals('NEW')){
                System.debug('Es una petición NEW');
                this.req.LAH.pmoral.apoderados = new List<ES5_wraper_LA_apoderados>();
                this.req.LAH.pmoralExtranjera.apoderados = new List<ES5_wraper_LA_apoderados>();
                this.req.LAH.pfisica.apoderados = new List<ES5_wraper_LA_apoderados>();
            } else if(Tipo_Peticion.equals('EDIT')){
                System.debug('Es una petición EDIT');
             	this.req.LAH.pmoral.apoderados = Busca_Apoderado(this.req.LAH.pmoral.apoderados);
                this.req.LAH.pmoralExtranjera.apoderados = Busca_Apoderado(this.req.LAH.pmoralExtranjera.apoderados);
                this.req.LAH.pfisica.apoderados = Busca_Apoderado(this.req.LAH.pfisica.apoderados);
            }
        
    	
    
    
    ///
        //if(System.currentPageReference().getParameters().get('JSON_Request') != null){
           // String JSONreq = (String)System.currentPageReference().getParameters().get('JSON_Request');
            
            //System.debug('JSONreq ' + JSONreq);
            //this.req = (ES2_WraperRequest) JSON.deserializeStrict(JSONreq, ES2_WraperRequest.class);
            yesnobtn();
            this.req.LAH.pOutEntidad = this.req.pOutPartyName;
            system.debug('this.req.LAH ' + this.req.LAH);
            if(this.req.LAH.pfisica != null && Tipo_Persona.equals('3')){
                System.debug(LoggingLevel.DEBUG,'Es persona física');
                this.URLR = '/apex/ES5_ReadPage_Legal_Assessment_PF?requestId=';
                if(this.req.LAH.pfisica.apoderados != null && this.req.LAH.pfisica.apoderados.size() > 0){                	
                    this.APO = this.req.LAH.pfisica.apoderados.get(0);
                    IsBackToLegal = false;    
                } else {
                	IsBackToLegal = true;    
                }
            } else if(this.req.LAH.pmoral != null && Tipo_Persona.equals('1')){
                System.debug(LoggingLevel.DEBUG,'Es persona moral');
                this.URLR = '/apex/ES5_ReadPage_Legal_Assessment_PM?requestId=';
                if(this.req.LAH.pmoral.apoderados != null && this.req.LAH.pmoral.apoderados.size() > 0){
                    System.debug(LoggingLevel.DEBUG,'Es persona moral');                    
                    this.APO = this.req.LAH.pmoral.apoderados.get(0);
                    IsBackToLegal = false;
                } else {
                	IsBackToLegal = true;    
                }
            } else if(this.req.LAH.pmoralExtranjera != null && Tipo_Persona.equals('2')){
                System.debug(LoggingLevel.DEBUG,'Es persona moral extranjera');
                this.URLR = '/apex/ES5_ReadPage_Legal_Assessment_PME?requestId=';
                if(this.req.LAH.pmoralExtranjera.apoderados != null && this.req.LAH.pmoralExtranjera.apoderados.size() > 0){
                    System.debug(LoggingLevel.DEBUG,'Es persona moral extranjera');                    
                    this.APO = this.req.LAH.pmoralExtranjera.apoderados.get(0);
                    IsBackToLegal = false;
                } else {
                    IsBackToLegal = true;    
                }
            }
            System.debug('this.URLR ' + this.URLR);
            if (APO != null){
                try{
                    this.laAvigid = String_To_Date(APO.laAPOtros);
                	this.laAFecha = String_To_Date(APO.laAFecha);
                    this.laAFechaRegistro = String_To_Date(APO.laAFechaRegistro);
                    this.laAFechaNacimiento = String_To_Date(APO.laAFechaNacimiento);
                    this.laAFechaRevoca = String_To_Date(APO.laAFechaRevoca);    
                } catch(Exception e){
                	System.debug(LoggingLevel.DEBUG,'Error en ');    
                }
            }
            
            this.APO.laAActiveFlag = 'Y';
            this.APO.laACreatedBy = sSSO;
            this.APO.laACreationDate = System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00'));
            this.APO.laALastUpdatedBy = sSSO;
            this.APO.laALastUpdateDate = System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00'));
        	this.APO.laANameCreatedBy = sSSO;
            this.APO.laANameUpdatedBy = sSSO;
            
       /* } else{
            System.debug('Datos nulos');
        }*/
            } else {
            System.debug('Petición nula');
        }
        
    }
    public List<ES5_wraper_LA_apoderados> Busca_Apoderado(List<ES5_wraper_LA_apoderados> List_Wraper_Apoderados){
        System.debug(LoggingLevel.INFO,'Inicia Busqueda apoderado');
        List<ES5_wraper_LA_apoderados> List_ES5_wraper_LA_apoderados = new List<ES5_wraper_LA_apoderados>();
        try{        	
            for(ES5_wraper_LA_apoderados Apoderados : List_Wraper_Apoderados){
                if(Apoderados.laAApoderadoID.equals(idReg)){
                    List_ES5_wraper_LA_apoderados.add(Apoderados);
                    System.debug(LoggingLevel.DEBUG,'Se ha encontrado el apoderado');
                    return List_ES5_wraper_LA_apoderados;               	    
                }            
            }    
        }catch(Exception e){
            System.debug(LoggingLevel.ERROR,'Ocurrió un error al buscar el apoderado');
        }        
        System.debug(LoggingLevel.WARN,'No se encontró Apoderado seleccionada');
        return null;        
    }
    public String getNac() {
        
        try{
            System.debug('Pais consultado JDLL' + Nac);
            ES5_obj_catalogo_pais__c paisCatalogo = [Select id, ES5_tx_codigo_pais__c, ES5_tx_nombre_pais__c from ES5_obj_catalogo_pais__c where ES5_tx_codigo_pais__c =:APO.laANacionalidad Limit 1];
            System.debug('Codigo Postal consultado' + paisCatalogo);
            //req.LAH.pmoral.pOutLAMDSCodigoPostal = postalCodeCatalog.EIV_tx_Postal_Code__c.leftPad(1, '0') ;
            //req.LAH.pmoral.pOutLAMDSEstado = postalCodeCatalog.EIV_tx_Codigo_Estado__c;
            this.Nac = paisCatalogo.ES5_tx_nombre_pais__c;
        }
        Catch(Exception e)
        {
            System.debug('No existe el ID');
        }            
        
        
        return this.Nac;
    }
    
    public void setNac(String Nac) {
        
        try{
            System.debug('Codigo Postal consultado OEJ' + Nac);
            ES5_obj_catalogo_pais__c paisCatalogo = [Select id, ES5_tx_codigo_pais__c, ES5_tx_nombre_pais__c from ES5_obj_catalogo_pais__c where id =:Nac Limit 1];
            System.debug('Codigo Postal consultado' + paisCatalogo);
            APO.laANacionalidad = paisCatalogo.ES5_tx_codigo_pais__c;
            
        }
        Catch(Exception e)
        {
            System.debug('No existe el ID');
        }
        
    }
    public PageReference redirect_RP_LA() {        
        PageReference newPage;
        try{
        	this.URLR += req.pOutRequestId;
            System.debug('this.URLR ' + this.URLR );
         	newPage = new PageReference(URLR);
        	newPage.setRedirect(true);                
        }catch(Exception e){
        	System.debug(LoggingLevel.ERROR,'Error al enviar JSON ' + e);
        }
        return newPage;
	}
    public PageReference redirect_EP_Apoderados(){
        System.debug(LoggingLevel.INFO,'Inicia Redirect_New_Apoder');
        PageReference newPage;
        try{
            String URLR = '/apex/ES5_Editpage_Apoderados?requestId=' + this.req.pOutRequestId +
                '&Tipo_Persona=' + this.Tipo_Persona +
                '&Tipo_Peticion=EDIT' +
                '&Tipo_detalle=T' +
                '&Apoderado_ID=' + this.idReg;
            System.debug('URLR ' + URLR);
            newPage = new PageReference(URLR);
            newPage.setRedirect(true);
            
        }catch(Exception e){
            System.debug(LoggingLevel.ERROR,'Error al enviar JSON ' + e);
        }
        return newPage;
    }
     //BackToEntityReadPage
    public PageReference redirect_RP_Apoderados() {        
        System.debug(LoggingLevel.INFO,'Inicia Redirect_New_Apoder');
        PageReference newPage;
        try{
            String URLR = '/apex/ES5_Readpage_Apoderados?requestId=' + this.req.pOutRequestId +
                '&Tipo_Persona=' + Tipo_Persona +
                '&Tipo_Peticion=EDIT' +
                '&Tipo_detalle=' + this.Tipo_detalle +
                '&Apoderado_ID=' + this.idReg;
            System.debug('URLR ' + URLR);
            newPage = new PageReference(URLR);
            newPage.setRedirect(true);
            
        }catch(Exception e){
            System.debug(LoggingLevel.ERROR,'Error al enviar JSON ' + e);
        }
        return newPage;  
	}
    public pageReference Save(){        
        PageReference newPage;  
        string result;
        getFechas();
        if(Valida_Campos_Vacios()){
            ES2_controller_POSTjson jsons = new ES2_controller_POSTjson();
            system.debug('APO.  ' + APO);
            if(!String.isNotEmpty(APO.laAApoderadoID)){
                //Valida si es una nueva limitante
                System.debug(LoggingLevel.INFO,'Inicias WS Nuevo apoderado');
                jsonResponse = EIV_EntityExtencionCalloutClass.callBack_Tabla_Apoderados(jsons.Post_Apoderados_NEW(this.req.pOutRequestId, APO),this.sServiceURL); 
                detail = new EIV_DetailWrapClass();
                //this.req.pOutRequestId =String.valueOf(jsonResponse.get('requestId'));
                this.detail.errorCode =  (String)jsonResponse.get('code'); //{code=S,N, detail=0, message=0}
                this.detail.description =  (String)jsonResponse.get('detail');
                this.detail.message =  (String)jsonResponse.get('message');
                if(this.detail.description == 'F') //Exito en el salvado, pasamos a la pagina de lectura de la Entidad y recargamos el controlador
                {
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,this.detail.errorCode));
                    newPage = new PageReference('/apex/ES5_EditPage_Apoderados');
            		newPage.setRedirect(false);
                }else
                {
                    this.URLR += req.pOutRequestId;
            System.debug('this.URLR ' + this.URLR);
            newPage = new PageReference(URLR);
            newPage.setRedirect(true); 
                }
                
                
            } else {
                //Valida si es una modificacion de limitante
                System.debug(LoggingLevel.INFO,'Inicias WS Modifica apoderado');
                EIV_EntityExtencionCalloutClass.callBack_Tabla_Apoderados(jsons.Post_Apoderados_NEW(this.req.pOutRequestId, APO),this.sServiceURL);
                this.URLR += req.pOutRequestId;
            System.debug('this.URLR ' + this.URLR);
            newPage = new PageReference(URLR);
            newPage.setRedirect(true);
            }
               
        }        
        return newPage;
    }
    public Boolean Valida_Campos_Vacios(){
        System.debug(LoggingLevel.INFO,'Inicia Valida_Campos_Vacios');
        Boolean campos_no_nulos = true;
        if(String.isEmpty(this.APO.laANombreFacultado)){
        	ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'El campo Nombre del facultado, no puede estar vacío')); 
            campos_no_nulos = false;
        }
     
        if(String.isEmpty(this.APO.laAEscrituraNum) && this.Tipo_detalle.equals('A')){
        	ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'El campo Escritura no, no puede estar vacío'));    
        	campos_no_nulos = false;
        }
        //if(this.APO.laAActosDominio.equals('R') || this.APO.laATitulosCredito.equals('R') || this.APO.laAActosAdministrativos.equals('R') || this.APO.laAPleitosCobranza.equals('R')){
        if(this.Tipo_detalle.equals('T')){
            if((this.APO.laAActosDominio.equals('R') || this.APO.laATitulosCredito.equals('R') || this.APO.laAActosAdministrativos.equals('R') || this.APO.laAPleitosCobranza.equals('R')) && String.isEmpty(this.APO.laAEscrituraRevoca)){
            	ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'El campo Nombre escritura revocada, no puede estar vacío'));    
        		campos_no_nulos = false;    
            }
            if((this.APO.laAActosDominio.equals('R') || this.APO.laATitulosCredito.equals('R') || this.APO.laAActosAdministrativos.equals('R') || this.APO.laAPleitosCobranza.equals('R')) && String.isEmpty(this.APO.laAFechaRevoca)){
            	ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'El campo Fecha revocada, no puede estar vacío'));    
        		campos_no_nulos = false;    
            }
            
        }
        
        System.debug(LoggingLevel.INFO,'Termina Valida_Campos_Vacios');
        return campos_no_nulos;
    }
    public void getFechas(){
        if(laAFecha != null){   
            APO.laAFecha = Date_Format(laAFecha); 
        }
        if(laAFechaRegistro != null){
        	APO.laAFechaRegistro = Date_Format(laAFechaRegistro);     
        }
        if(laAFechaNacimiento != null){
        	APO.laAFechaNacimiento = Date_Format(laAFechaNacimiento);    
        }
        if(laAFechaRevoca != null){
        	APO.laAFechaRevoca = Date_Format(laAFechaRevoca);     
        }
        if(laAvigid != null){
        	APO.laAPOtros = Date_Format(laAvigid);
        }
        
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
    
    public Date String_To_Date (String Process_Date){
        System.debug(LoggingLevel.INFO, 'Inicia Formate_Date ' + Process_Date);
        Date Date_Result;
        try{        	
            if(Process_Date != null){
                Date_Result = Date.parse(Process_Date);
				System.debug(LoggingLevel.DEBUG, 'Date_Result ' + Date_Result);                
            }    
        } catch(Exception e) {
        	System.debug(LoggingLevel.ERROR,'Ocurrió un error en la consulta del WS');
            System.debug(LoggingLevel.ERROR,'linia ' + e.getLineNumber());
           	System.debug(LoggingLevel.ERROR,'Mensaje' + e.getMessage());
                
        }
        System.debug(LoggingLevel.INFO, 'Termina Formate_Date con datos nulos');
        return Date_Result;
    }
    public void yesnobtn(){ //funcion para leer cada uno de los privilegios del json
        system.debug('lo que me llega de privilage'+ req.privilegeObj);
        integer i = req.privilegeObj.size();
        system.debug('tamaño del arreglo' + i);
        for(integer a=0;a<i;a++){
            if(req.privilegeObj[a].section == 'EDIT'){
                editbtn = cambia(req.privilegeObj[a].vCrud);
            } else if(req.privilegeObj[a].section == 'APPROVED'){
                aprbtn = cambia(req.privilegeObj[a].vCrud);
            }else{
                system.debug('no tengo parametros');
            }
        }
    }
    public boolean cambia(string p){ //funcion que prende y apaga los botones
        if(p == '10000'){
            return true;
        }else{
            return false; 
        }
    }
}