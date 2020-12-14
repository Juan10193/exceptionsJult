public class EM_WS_EntityMaster {
    public static string getEntityDetail(string partyId, string sso, string app ){
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

        request.setEndpoint('callout:'+ namecred + '/EcEntityMasterSbDat/EntitySvcRs/entities/?partyID=' + partyId + '&sso=' + sso + '&applicationCode='+ app  + '&screen=UI_ENTITYMASTER' );
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
}