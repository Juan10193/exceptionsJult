public class ES2_controller_coments {
    public ES2_WraperRequest req {get;set;}
    public list<ES2_WraperRequest> dts {get;set;}    
    public String OracleAccountName {get;set;}
    public String TopParentName {get;set;}
    public String sServiceURL {get;set;}
    public String sSSO {get;set;}
    public String sComment {get;set;}  
    public String dire {get;set;}
    
    public ES2_controller_coments(){
        this.req = new ES2_WraperRequest(); 
        
        this.req.pOutRequestId =  (String)System.currentPageReference().getParameters().get('requestId');
        this.OracleAccountName = (String) System.currentPageReference().getParameters().get('OracleAccountName');
        this.req.pOutPartyId = (String)System.currentPageReference().getParameters().get('PartyId');
        this.dire = (String)System.currentPageReference().getParameters().get('dir');
        this.req.pOutSourceTopParentId = (String)System.currentPageReference().getParameters().get('TopParentID');
        this.TopParentName  = Test.isRunningTest() ? 'thistopParentName' : (String) System.currentPageReference().getParameters().get('TopParentName');
        this.sServiceURL = Test.isRunningTest() ? this.sServiceURL = 'https://test.com' : [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='URL_Servicio'][0].EIV_tx_parameter__c;  
        this.sSSO = Test.isRunningTest() ? this.sSSo = '666' : [Select EmployeeNumber From User Where Id = :UserInfo.getUserId()][0].EmployeeNumber;          
        //es neuva
        Map<string,object>jsonResponse =null;
        jsonResponse = (Map<string,object>)JSON.deserializeUntyped(ES2_jsonDummy.JsonnULO('Com'));
        System.debug('OEJ:' + jsonResponse);
        
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
    }
    public PageReference saveComents()
    {
        //falta logica del guardado
        /////***////
        //
        //Crear Json
        //
        //
        PageReference pr;
        if(sComment != ''){
            
            this.req.pOutRequestId =  Test.isRunningTest() ? this.req.pOutRequestId = 'Id654' : (String)System.currentPageReference().getParameters().get('requestId');
            JSONGenerator gen = JSON.createGenerator(true);
            gen.writeStartObject();
            gen.writeFieldName('requestComment');
            gen.writeStartObject();
            gen.writeStringField('requestId' , this.req.pOutRequestId);
            gen.writeStringField('comSection' , '');
            gen.writeStringField('comComment' , sComment);
            gen.writeStringField('comCreatedBy' ,  this.sSSO);
            gen.writeStringField('comCreationDate' ,  System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00')));
            gen.writeStringField('comUpdatedBy' , this.sSSO);
            gen.writeStringField('comLastUpdateDate' , System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00'))  );
            gen.writeEndObject(); 
            gen.writeEndObject(); 
            String jsonS = gen.getAsString(); 
            system.debug('jsonS OEJ Comment' + jsonS);
            pr = new PageReference('/apex/ES2_EditPage_ADD_COMENTARIOS?requestId=' +  this.req.pOutRequestId );        
            
            
            Map<String, Object> jsonResponse = null;
            jsonResponse = EIV_EntityExtencionCalloutClass.postComments(jsonS, sServiceURL);
            System.debug('jsonResponse OEJ:' + jsonResponse);
            if (jsonResponse == null) //Error en ORACLE, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Oracle Server missing'));
                pr = new PageReference('/apex/ES2_EditPage_ADD_COMENTARIOS');
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
                        pr = new PageReference('/apex/'+page(dire)+'?&requestId='+ this.req.pOutRequestId);
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
            
        }else{
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'campos requeridos con *'));
        }
        return pr;
    }
    
    
    
    public PageReference BackComents()
    {
         this.req.pOutRequestId =  (String)System.currentPageReference().getParameters().get('requestId');
        //falta logica del guardado
        /////***////
        PageReference pr = new PageReference('/apex/'+page(dire)+'?requestId='+  this.req.pOutRequestId);  
        pr.setRedirect(true); //Pasamos el controlador vacio  
        
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
        }else if(ref=='kycpf'){
            res = 'ES2_ReadPage_KWYPersonaFisica';
        }else if(ref=='kycpm'){
            res = 'ES2_ReadPage_KWYPersonaMoral';
        }else if(ref=='EVAL'){
            res = 'ES4_ReadPage_EVAL';
        }else if(ref=='INSURANCE'){
            res = 'ES4_ReadPage_INSURANCE';
        }else if(ref=='RAPID'){
            res = 'ES4_ReadPage_RAPID_TAG';
        }else if(ref=='LAPM'){
            res = 'ES5_ReadPage_Legal_Assessment_PM';
        }else if(ref=='LAPME'){
            res = 'ES5_ReadPage_Legal_Assessment_PME';
        }else if(ref=='LAPF'){
            res = 'ES5_ReadPage_Legal_Assessment_PF';
        }
        
        else {
            res = null;
        }
        return res;
    }
    
}