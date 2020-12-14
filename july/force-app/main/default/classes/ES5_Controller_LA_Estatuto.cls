public class ES5_Controller_LA_Estatuto {
  
    public ES2_WraperRequest req			 {get; set;}
    public string idReg 					 {get; set;}
    public string URLR						 {get; set;}
    //fechas
    public date laEFecha 					 {get; set;}
    
    public boolean IsBackToLegal 			 {get;set;}
    public string pag 						 {get; set;}
    public string sSSO 						 {get; set;}
    public string sServiceURL 				 {get; set;}
    public ES5_wraper_LA_Estatutos estatutos {get; set;}
    public string Tipo_Peticion 			{get;set;}
    public boolean editbtn					 {get;set;}
    
    public ES5_Controller_LA_Estatuto(){
        System.debug(LoggingLevel.INFO,'Inicia ES5_Controller_LA_Apoderados');
        this.req = new ES2_WraperRequest();
        this.req.pOutRequestId =  Test.isRunningTest() ? '1234' :(String)System.currentPageReference().getParameters().get('requestId');
        this.pag= Test.isRunningTest() ? 'LA' :(String)System.currentPageReference().getParameters().get('pag');
        //this.idReg=  Test.isRunningTest() ? '1' :(String)System.currentPageReference().getParameters().get('idReg');
        this.sServiceURL = Test.isRunningTest() ? 'hola mundo' :[Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='URL_Servicio'][0].EIV_tx_parameter__c; 
        this.sSSO = Test.isRunningTest() ? '666' : [Select EmployeeNumber From User Where Id = :UserInfo.getUserId()][0].EmployeeNumber;  
        this.Tipo_Peticion = Test.isRunningTest() ? 'NEW' :(String)System.currentPageReference().getParameters().get('Tipo_Peticion');
        this.estatutos = new ES5_wraper_LA_Estatutos();
        this.idReg = (String)System.currentPageReference().getParameters().get('Estatuto_ID');
        if ( String.isNotBlank(this.req.pOutRequestId) )
        {
            //es una consulta
            Map<string,object>jsonResponse =null;
            
            //jsonResponse = (Map<string,object>)JSON.deserializeUntyped(ES2_jsonDummy.entitymasterToJson());
            jsonResponse = Test.isRunningTest() ? (Map<string,object>)JSON.deserializeUntyped(ES2_jsonDummy.entitymasterToJson()) :EIV_EntityExtencionCalloutClass.callBackGetRequestDetailsOne(this.sSSO, 'SF', this.sServiceURL, this.req.pOutRequestId);
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
            }
            if(Tipo_Peticion.equals('NEW')){
                System.debug('Es una petición NEW');
                
        		this.req.LAH.pmoralExtranjera.estatutos = new List<ES5_wraper_LA_Estatutos>();
            } else if(Tipo_Peticion.equals('EDIT')){
                System.debug('Es una petición EDIT');
                system.debug('idReg ' + idReg);
                this.req.LAH.pmoralExtranjera.estatutos = Busca_Estatuto();
             	//this.req.LAH.pmoral.apoderados = Busca_Apoderado();   
            }
        /*if(System.currentPageReference().getParameters().get('JSON_Request') != null){
            String JSONreq = (String)System.currentPageReference().getParameters().get('JSON_Request');
            
            System.debug('JSONreq ' + JSONreq);
            this.req = (ES2_WraperRequest) JSON.deserializeStrict(JSONreq, ES2_WraperRequest.class);*/
            yesnobtn();
            this.req.LAH.pOutEntidad = this.req.pOutPartyName;
            if(this.req.LAH.pmoralExtranjera.estatutos != null && this.req.LAH.pmoralExtranjera.estatutos.size() > 0){
                this.estatutos = this.req.LAH.pmoralExtranjera.estatutos.get(0);
                this.IsBackToLegal = false;
            }  else {
            	this.IsBackToLegal = true;    
            }
            if (this.estatutos != null){
                try{
                	this.laEFecha = String_To_Date(this.estatutos.pOutlaEFecha);    
                } catch(Exception e){
                	System.debug(LoggingLevel.DEBUG,'Error en ');    
                }
            }
            estatutos.pOutlaEActiveFlag = 'Y';
            estatutos.pOutlaECreatedBy = sSSO;
            estatutos.pOutlaECreationDate = System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00'));
            estatutos.pOutlaELastUpdatedBy = sSSO;
            estatutos.pOutlaELastUpdateDate = System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00'));
        }
        
    }
    public List<ES5_wraper_LA_Estatutos> Busca_Estatuto(){
        System.debug(LoggingLevel.INFO,'Inicia Busqueda apoderado');
        List<ES5_wraper_LA_Estatutos> List_ES5_wraper_LA_Estatutos = new List<ES5_wraper_LA_Estatutos>();
        for(ES5_wraper_LA_Estatutos estatutos : req.LAH.pmoralExtranjera.estatutos){
            if(estatutos.pOutlaEEstatutoID.equals(idReg)){
                List_ES5_wraper_LA_Estatutos.add(estatutos);
                return List_ES5_wraper_LA_Estatutos;               	    
            }            
        }
        System.debug(LoggingLevel.WARN,'No se encontró Apoderado seleccionada');
        return null;        
    }
    //ReadPage
    public PageReference redirect_RP_Estatutos() {        
        PageReference pr;
        String URLR = '/apex/ES5_ReadPage_Estatutos?requestId=' + this.req.pOutRequestId +
                '&Tipo_Peticion=EDIT' + 
            	'&Estatuto_ID=' + this.idReg;
        pr = new PageReference(URLR);
        pr.setRedirect(true);
        return pr;
	}
    //EditPage
    public PageReference redirect_EP_Estatutos(){
        PageReference pr;
        String URLR = '/apex/ES5_EditPage_Estatutos?requestId=' + this.req.pOutRequestId +
                '&Tipo_Peticion=EDIT' + 
            	'&Estatuto_ID=' + this.idReg;
        pr = new PageReference(URLR);
        pr.setRedirect(true);
        return pr;
    }
     //BackToLegalA
    public PageReference redirect_RP_LA_PME() {        
        PageReference newPage;
        try{
            req.pOutLastUpdateDate = System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00'));
            String URLR = '/apex/ES5_ReadPage_Legal_Assessment_PME?requestId=' + req.pOutRequestId;
            System.debug('URLR ' + URLR);
         	newPage = new PageReference(URLR);
        	newPage.setRedirect(true);
                
        }catch(Exception e){
        	System.debug(LoggingLevel.ERROR,'Error al enviar JSON ' + e);   
    	}
        return newPage;
	}
    public pageReference Save(){
        this.estatutos.pOutlaEFecha = Date_Format(laEFecha); 
        PageReference pr;        
        String URLR;
        ES2_controller_POSTjson jsons = new ES2_controller_POSTjson();
        if(Valida_Campos_Vacios()){
            
        	if(String.isNotEmpty(estatutos.pOutlaEEstatutoID)){            
                EIV_EntityExtencionCalloutClass.callBack_Tabla_Estatutos(jsons.Post_Estatutos_EDIT(this.req.pOutRequestId,this.estatutos),this.sServiceURL);
            } else {
                EIV_EntityExtencionCalloutClass.callBack_Tabla_Estatutos(jsons.Post_Estatutos_NEW(this.req.pOutRequestId,this.estatutos),this.sServiceURL);
            }    
            URLR = '/apex/ES5_ReadPage_Legal_Assessment_PME?requestId=' + req.pOutRequestId;
            System.debug('this.URLR ' + this.URLR);
            pr = new PageReference(URLR);
            pr.setRedirect(true);
        }
        return pr;
    }
    public Boolean Valida_Campos_Vacios(){
        System.debug(LoggingLevel.INFO,'Inicia Valida_Campos_Vacios');
        Boolean campos_no_nulos = true;
        if(String.isEmpty(this.estatutos.pOutlaEEstatuto)){
        	ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'El campo Estatuto, no puede estar vacío')); 
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