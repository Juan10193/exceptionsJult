/**
 * @File Name          : WK_Exporsure_callout.cls
 * @Description        : 
 * @Author             : juandedios.hernandez@engeniumcapital.com
 * @Group              : 
 * @Last Modified By   : juandedios.hernandez@engeniumcapital.com
 * @Last Modified On   : 12/9/2019 13:07:24
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    3/9/2019   juandedios.hernandez@engeniumcapital.com     Initial Version
**/
global class WK_Exporsure_callout {
    
    global static string getExporsure(string EGid){
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        string responde;
        string typeofSandbox = GetSandboxType.getTypeOfSandbox();
        string namecred;
        if (typeofSandbox =='QA') {
            namecred ='getsServiceUrlQa';
        }else if(typeofSandbox =='PROD'){
            namecred = 'getsServiceUrlProd';
        }else{
            namecred ='getsServiceUrl';
        }
        req.setEndpoint('callout:'+namecred +'/EcExposureSbBix/ExposureRs/exposure?economicGroupId=' + EGid);
        req.setMethod('GET');
        req.setTimeout(120000);
        HttpResponse response = h.send(req);
        if (response.getStatusCode() == 200){
            string despues = response.getBody();
             responde = despues.replace('currency', 'curency');
            System.debug('Received JSON Exporsure :' + response.getBody());
        } else {
            
            System.debug(LoggingLevel.WARN,'JSON :' + response.getBody() +
                         'status :' + response.getStatus()+
                        'status code :' + response.getStatusCode());
        }
        return responde;
    }

    global static string getEntsEGroup(string partyId){
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        string responde;
        req.setEndpoint('callout:getsServiceUrl' + '/EcEntityMasterSbDat/AccountSvcRs/entities?economicGroupID=' + PartyId);
        req.setMethod('GET');
        req.setTimeout(120000);
        HttpResponse response = h.send(req);
        if (response.getStatusCode() == 200){
            string despues = response.getBody();
             responde = despues.replace('currency', 'curency');
            System.debug('Received JSON Exporsure :' + response.getBody());
        } else {
            
            System.debug(LoggingLevel.WARN,'JSON :' + response.getBody() +
                         'status :' + response.getStatus()+
                        'status code :' + response.getStatusCode());
        }
        return responde;
    }
}