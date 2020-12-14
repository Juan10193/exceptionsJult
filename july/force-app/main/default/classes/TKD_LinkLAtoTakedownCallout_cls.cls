/**
 * @File Name          : TKD_LinkLAtoTakedownCallout_cls.cls
 * @Description        : Clase Callout para Consulta de servicio y muestra de datos del front lwc
 * @Author             : juandedios.hernandez@engeniumcapital.com
 * @Group              : LWC TKD LA
 * @Last Modified By   : juandedios.hernandez@engeniumcapital.com
 * @Last Modified On   : 16/10/2019 0:17:10
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    16/10/2019   juandedios.hernandez@engeniumcapital.com     Initial Version
**/
public with sharing class TKD_LinkLAtoTakedownCallout_cls {
    
    /**
    * @description Consulta del Servicio Requests De Entity Master
    * @author juandedios.hernandez@engeniumcapital.com | 16/10/2019 
    * @param string partyId 
    * @return string Legals Assestments de la Entidad
    **/
    @AuraEnabled(cacheable=false)
    public static string searchLAsInEntity(string partyId){
        Http http = new Http();
        HttpRequest  request  = new HttpRequest();
        string sandbox = GetSandboxType.getTypeOfSandbox();
        string namecred;

        if(sandbox == 'DEV'){
            namecred = 'getsServiceUrl';
        }
        if(sandbox == 'QA'){
            namecred = 'getsServiceUrlQa';
        }
        if(sandbox =='PROD'){
            namecred = 'getsServiceUrlProd';
        }

        request.setEndpoint('callout:'+ namecred + '/EcRequestSbDat/SFRequestTypeDetailsRs/sfRequestTypeDetails?partyId=' + partyId);
        request.setMethod('GET');
        request.setTimeout(120000);
        HttpResponse response = http.send(request);
        if(response.getStatusCode() == 200){
            System.debug('response.getBody() ' + response.getBody());
            return response.getBody();
        }else{
            System.debug(LoggingLevel.ERROR,'StatusCode: ' + response.getStatusCode());
            System.debug(LoggingLevel.ERROR,'Body: ' + response.getBody());
            return response.getBody();
        }

    }

    @AuraEnabled(cacheable=false)
    public static string searchRequestId(String requestId){
        Http http = new Http();
        HttpRequest  request  = new HttpRequest();
        string sandbox = GetSandboxType.getTypeOfSandbox();
        string namecred;

        if(sandbox == 'DEV'){
            namecred = 'getsServiceUrl';
        }
        if(sandbox == 'QA'){
            namecred = 'getsServiceUrlQa';
        }
        if(sandbox =='PROD'){
            namecred = 'getsServiceUrlProd';
        }

        request.setEndpoint('callout:'+ namecred + '/EcRequestSbDat/SFRequestTypeDetailsRs/sfRequestTypeDetails?requestId=' + requestId );
        request.setMethod('GET');
        request.setTimeout(120000);
        HttpResponse response = http.send(request);
        if(response.getStatusCode() == 200){
            System.debug('response.getBody() ' + response.getBody());
            return response.getBody();
        }else{
            System.debug(LoggingLevel.ERROR,'StatusCode: ' + response.getStatusCode());
            System.debug(LoggingLevel.ERROR,'Body: ' + response.getBody());
            return response.getBody();
        }
    }

    @AuraEnabled(cacheable=false)
    public static list<ES2_Obj_EntityMasterInCreditApproval__c> getEntitiesInCa(string cAId){
        return Data_Access_EntityMastInCApproval_cls.getEntitiesMasterByCAId(cAId);
    }

    @AuraEnabled(cacheable=false)
    public static list<Legal_Assessment_In_TD__c> fetchLASINTD(string takedownId){
        return Data_Access_LegalAssessmentInTD_cls.getLATDbyTDId(takedownId);
    }
}