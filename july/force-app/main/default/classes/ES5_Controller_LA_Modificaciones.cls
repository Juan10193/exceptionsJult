public class ES5_Controller_LA_Modificaciones {
 public ES2_WraperRequest req						{get;set;}
    public string idLimitante 							{get;set;}
    public ES5_wraper_LA_modificacion WModificacion     {get;set;}
    public string idReg 					 {get; set;}
    public date R_Fecha 								{get;set;}
    public date Fecha 									{get;set;}
    
    public boolean IsBackToLegal 						{get;set;}
    public String sServiceURL 							{get;set;}
    public string UrlAppDoctos 							{get;set;}
    public string EncriptationType 						{get;set;}
    public string KeyEncriptation 						{get;set;}
    public string URL_Servicio_Externa 					{get;set;}
    public String sSSO 									{get;set;}
    public string Tipo_Peticion 			{get;set;}
    public boolean editbtn					 {get;set;}
    
    public ES5_Controller_LA_Modificaciones(){
        try{
            System.debug(LoggingLevel.INFO,'Inicia ES5_Controller_LA_Modificaciones');
            this.req = new ES2_WraperRequest();
            this.sServiceURL = Test.isRunningTest() ? 'hola mundo' :[Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='URL_Servicio'][0].EIV_tx_parameter__c; 
            this.UrlAppDoctos = Test.isRunningTest() ? 'https://test.com' :  [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='UrlAppDoctos'][0].EIV_tx_parameter__c; 
            this.EncriptationType = Test.isRunningTest() ? 'https://test.com' :  [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='EncriptationType'][0].EIV_tx_parameter__c; 
            this.KeyEncriptation = Test.isRunningTest() ? 'https://test.com' :  [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='KeyEncriptation'][0].EIV_tx_parameter__c; 
            this.URL_Servicio_Externa = Test.isRunningTest() ? 'https://test.com' :  [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='URL_Servicio_Externa'][0].EIV_tx_parameter__c;
            this.sSSO = Test.isRunningTest() ? '666' : [Select EmployeeNumber From User Where Id = :UserInfo.getUserId()][0].EmployeeNumber;
            this.WModificacion = new ES5_wraper_LA_modificacion(); 
            this.Tipo_Peticion = (String)System.currentPageReference().getParameters().get('Tipo_Peticion');
            this.req.pOutRequestId =  (String)System.currentPageReference().getParameters().get('requestId');
        	this.idReg = (String)System.currentPageReference().getParameters().get('Modificacion_ID');
            
            if ( String.isNotBlank(this.req.pOutRequestId) )
        {
            //es una consulta
            Map<string,object>jsonResponse =null;
            
            //jsonResponse = (Map<string,object>)JSON.deserializeUntyped(ES2_jsonDummy.entitymasterToJson());
            jsonResponse =Test.isRunningTest() ? (Map<string,object>)JSON.deserializeUntyped(ES2_jsonDummy.entitymasterToJson()) :EIV_EntityExtencionCalloutClass.callBackGetRequestDetailsOne(this.sSSO, 'SF', this.sServiceURL, this.req.pOutRequestId);
            system.debug('jsonRespone ' + jsonResponse);
            Map<String, Object> mapRequests = (Map<String, Object>)jsonResponse.get('requests');
           /* if(mapRequests==null)
            {
                System.debug('OEJ: No existen solicitudes requests que revisar');
            }   
            else
            {*/
                ES2_Controller_KWYPMoralFill rellena = new  ES2_Controller_KWYPMoralFill();
                
                list<ES2_WraperRequest> dts = new list<ES2_WraperRequest>();
                dts = Test.isRunningTest() ? new list<ES2_WraperRequest>() : rellena.rellenarHeader(mapRequests);
                if(dts.size()>0)
                { 
                    req = dts[0];
                }
            //}
            if(Tipo_Peticion.equals('NEW')){
                System.debug('Es una petición NEW');
                
        		this.req.LAH.pmoral.modificaciones = new List<ES5_wraper_LA_modificacion>();
            } else if(Tipo_Peticion.equals('EDIT')){
                System.debug('Es una petición EDIT');
                system.debug('idReg ' + idReg);
                this.req.LAH.pmoral.modificaciones = Busca_Modificaciones();
             	//this.req.LAH.pmoral.apoderados = Busca_Apoderado();   
            }/*
            if(System.currentPageReference().getParameters().get('JSON_Request') != null){
                String JSONreq = (String)System.currentPageReference().getParameters().get('JSON_Request');
                this.req = (ES2_WraperRequest) JSON.deserializeStrict(JSONreq, ES2_WraperRequest.class);*/
            yesnobtn();
                this.req.LAH.pOutEntidad = this.req.pOutPartyName;
                if(this.req.LAH.pmoral.modificaciones != null && this.req.LAH.pmoral.modificaciones.size() > 0){
                    //Si se va a modificar una tabla  
                    this.WModificacion = this.req.LAH.pmoral.modificaciones.get(0);
                    this.R_Fecha = String_To_Date(WModificacion.laMMRFecha);
                    this.Fecha = String_To_Date(WModificacion.laMMFecha);                    
                    IsBackToLegal = false;
                } else {
                    this.WModificacion = new ES5_wraper_LA_modificacion();
                    IsBackToLegal = true;
                }
            }
            WModificacion.laMMActiveFlag = 'Y'; // o N
            WModificacion.laMMCreatedBy = sSSO;
            WModificacion.laMMCreationDate = System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00'));
            WModificacion.laMMLastUpdatedBy = sSSO;
            WModificacion.laMMLastUpdateDate = System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00'));
            /*req.pOutCreatedBy = sSSO;
            req.pOutUpdatedBy = sSSO;
            req.pOutRequestedBy = sSSO;*/
            //req.pOutStartDate = System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00'));
            //req.pOutLastUpdateDate = System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00'));
            
            req.pOutActiveFlag = 'Y';
            } catch(System.CalloutException e) {
                    System.debug(LoggingLevel.ERROR,'Ocurrió un error en la consulta del WS');
                    System.debug(LoggingLevel.ERROR,'linia ' + e.getLineNumber());
                    System.debug(LoggingLevel.ERROR,'Mensaje' + e.getMessage());
                        
            }
    }
    //Método para excluir los elementos de la lista y dejar uno solo
    public List<ES5_wraper_LA_modificacion> Busca_Modificaciones(){
        System.debug(LoggingLevel.INFO,'Inicia BuscaLimitante '+ req.LAH.pmoral.modificaciones);
        List<ES5_wraper_LA_modificacion> List_ES5_ES5_wraper_LA_modificacion = new List<ES5_wraper_LA_modificacion>();
        try{
            for(ES5_wraper_LA_modificacion Modificacion : req.LAH.pmoral.modificaciones){
                if(Modificacion.laMModificationId.equals(idReg)){
                    List_ES5_ES5_wraper_LA_modificacion.add(Modificacion);
                    return List_ES5_ES5_wraper_LA_modificacion;               	    
                }            
            }
        } catch(exception e){
            System.debug('Error');
        }
        System.debug(LoggingLevel.WARN,'No se encontró limitante seleccionada');
        return null;        
    }
    public PageReference Redirect_EP_Modificaciones() {        
        System.debug(LoggingLevel.INFO,'Inicia Redirect_New_Limitantes');
        PageReference newPage;
        try{
            String URLR = '/apex/ES5_EditPage_Modificaciones?requestId=' + this.req.pOutRequestId +
                '&Tipo_Peticion=EDIT' +
                '&Modificacion_ID=' + this.idReg;
            System.debug('URLR ' + URLR);
            newPage = new PageReference(URLR);
            newPage.setRedirect(false);            
        }catch(Exception e){
            System.debug(LoggingLevel.ERROR,'Error al enviar JSON ' + e);
        }
        return newPage;
	}
    //BackToLegal
    public PageReference redirect_RP_LA_PM() {        
        PageReference newPage;
        try{
        	String URLR = '/apex/ES5_ReadPage_Legal_Assessment_PM?requestId='+req.pOutRequestId;
         	newPage = new PageReference(URLR);
        	newPage.setRedirect(true);                
        }catch(Exception e){
        	System.debug(LoggingLevel.ERROR,'Error al enviar JSON ' + e);
        }
        return newPage;
	}
    //BackToEntityReadPage
    public PageReference redirect_RP_Modificaciones() {        
        System.debug(LoggingLevel.INFO,'Inicia Redirect_New_Limitantes');
        PageReference newPage;
        try{
            String URLR = '/apex/ES5_ReadPage_Modificaciones?requestId=' + this.req.pOutRequestId +
                '&Tipo_Peticion=EDIT' +
                '&Modificacion_ID=' + this.idReg;
            System.debug('URLR ' + URLR);
            newPage = new PageReference(URLR);
            newPage.setRedirect(false);            
        }catch(Exception e){
            System.debug(LoggingLevel.ERROR,'Error al enviar JSON ' + e);
        }
        return newPage;
	}
    
    //Pendiente función SAVE
    public pageReference Save(){
        Valida_Campos_Vacios();
        PageReference newPage;
        if(Valida_Campos_Vacios()){
        	ES2_controller_POSTjson jsons = new ES2_controller_POSTjson();
            WModificacion.laMMRFecha = Date_Format(this.R_Fecha);
            WModificacion.laMMFecha = Date_Format(this.Fecha);
            system.debug('resultado' + jsons.Post_Modificaciones_EDIT_NEW(this.req.pOutRequestId, WModificacion));
            EIV_EntityExtencionCalloutClass.callBack_Tabla_Modificaciones(jsons.Post_Modificaciones_EDIT_NEW(this.req.pOutRequestId, WModificacion),sServiceURL);
            String URLR = '/apex/ES5_ReadPage_Legal_Assessment_PM?requestId='+req.pOutRequestId;
            newPage = new PageReference(URLR);
            newPage.setRedirect(true);                
        }        
        return newPage;
    }
    public Boolean Valida_Campos_Vacios(){
        System.debug(LoggingLevel.INFO,'Inicia Valida_Campos_Vacios');
        Boolean campos_no_nulos = true;
        if(String.isEmpty(this.WModificacion.laMMReformaTotal)){
        	ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'El campo Reforma total de los estatutos, no puede estar vacío')); 
            campos_no_nulos = false;
        }
        if(String.isEmpty(this.WModificacion.laMMEscritura)){
        	ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'El campo Escritura No., no puede estar vacío'));    
        	campos_no_nulos = false;
        }
        System.debug(LoggingLevel.INFO,'Termina Valida_Campos_Vacios');
        return campos_no_nulos;
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
        } catch(System.CalloutException e) {
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