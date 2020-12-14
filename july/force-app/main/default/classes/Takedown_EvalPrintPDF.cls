public class Takedown_EvalPrintPDF {
    public virtual class BaseException extends Exception {}
    public class OtherException extends BaseException {}

	@AuraEnabled
    public static void printPdf(string jsonRequest, string sSSO){
        string sServiceURL = Test.isRunningTest() ? 'hola mundo' :[Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='URL_Servicio'][0].EIV_tx_parameter__c;
        EIV_DetailWrapClass detail = new EIV_DetailWrapClass();
        ES2_WraperRequest req = new ES2_WraperRequest();
        Map<String, Object> jsonResponse = (Map<String, Object>) JSON.deserializeUntyped(jsonRequest);
        Map<String, Object> mapRequests = (Map<String, Object>)jsonResponse.get('requests');
        ES2_Controller_KWYPMoralFill rellena = new  ES2_Controller_KWYPMoralFill();
        list<ES2_WraperRequest> dts = new list<ES2_WraperRequest>();
        dts = rellena.rellenarHeader(mapRequests);
        if(dts.size()>0)
        {
            saveStatusGeneral('PRINT PDF', false, dts, detail, req, sSSO, sServiceURL );
        }

        
    }

    public static void saveStatusGeneral( String sStatus, Boolean deleteAssignedTo, List<ES2_WraperRequest> dts, EIV_DetailWrapClass detail, ES2_WraperRequest req, string sSSO, string sServiceURL)
    {   
        req = dts[0];
        ES2_controller_POSTjson ps = new ES2_controller_POSTjson();
        if(sStatus=='CANCELLED BY REQUESTOR'||sStatus=='APPROVED'||sStatus=='REJECTED'||sStatus=='REWORK'){
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
        String sJson = ps.postgeneral('EVAL', req);
        
        Map<string,object> jsonResponse =null;
        
        
        //jsonResponse = (Map<string,object>)JSON.deserializeUntyped(ES2_jsonDummy.entitymasterToJson());
        jsonResponse = EIV_EntityExtencionCalloutClass.postRequestDetail(sJson, sServiceURL);
        System.debug('postRequestDetail JJ: ' + jsonResponse);
        if (jsonResponse == null) //Error en ORACLE, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
        {
            throw new OtherException('Oracle server missing');
        }
        else
        {
            string request;
            request = req.pOutRequestId;
            //El resultado tiene status
            Map<String, Object> status = (Map<String, Object>)jsonResponse.get('status');
            System.debug('Received the following JSON response of status OEJ01:' + status);
            detail = new EIV_DetailWrapClass();
            req.pOutRequestId =String.valueOf(jsonResponse.get('requestId'));
            detail.errorCode =  (String)status.get('code'); //{code=S,N, detail=0, message=0}
            detail.description =  (String)status.get('detail');
            detail.message =  (String)status.get('message');
            if(detail.description == 'S') //Exito en el salvado, pasamos a la pagina de lectura de la Entidad y recargamos el controlador
            {
               system.debug('SEND PDF OK'); 
            }
            else //Error en el salvado, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
            {
                //ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,this.detail.errorCode));
                system.debug('Error al imprimir pdf');
                system.debug(detail.errorCode);
                throw new OtherException('Error al imprimir pdf');
            }
            
        } 
       
    }
}