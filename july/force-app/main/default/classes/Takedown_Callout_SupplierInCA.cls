public with sharing class Takedown_Callout_SupplierInCA {
    
    // AML HITS
    public static Takedown_Wrapper_SupplierInCA.responseAmlHits FindSupplierForNameOrRFC(String jsonRequest){
        system.debug('jsonRequest--' + jsonRequest);
        Takedown_Wrapper_SupplierInCA.responseAmlHits findSupplier = new Takedown_Wrapper_SupplierInCA.responseAmlHits();
        Http http = new Http();        
        HttpRequest request = new HttpRequest();
        string sandbox = GetSandboxType.getTypeOfSandbox();
        string namecred;

        if(sandbox == 'DEV'){
            namecred = 'getsServiceUrl';//getsServiceUrl
        }
        if(sandbox == 'QA'){
            namecred = 'getsServiceUrlQa';
        }
        if(sandbox =='PROD'){
            namecred = 'getsServiceUrlProd';
        }   
        if(sandbox =='Developer Edition'){
            namecred = 'ContentManagmentDevToken';
        }
        request.setEndpoint('callout:'+namecred);
        string endpoint = request.getEndpoint() +'/EcAmlSbDat/AmlRs/aml/hits/queries/nameorRfc';
        request.setEndpoint(endpoint);
		request.setHeader('Content-Type', 'application/json;charset=UTF-8'); 
        request.setMethod('POST');
        request.setBody(jsonRequest);
        request.setTimeout(120000);
        HttpResponse response = http.send(request);
        if (response.getStatusCode() == 200) {
            findSupplier = (Takedown_Wrapper_SupplierInCA.responseAmlHits)JSON.deserialize(response.getBody(), Takedown_Wrapper_SupplierInCA.responseAmlHits.class); // Jsonstring is the above JSON
        	System.debug('response.getBody() ' + response.getBody());
        } else{
            System.debug(LoggingLevel.ERROR,'StatusCode: ' + response.getStatusCode());
            System.debug(LoggingLevel.ERROR,'Body: ' + response.getBody());
        }
        return findSupplier;
    }
    
    
    // servicio consulta general known Supplier
    public static string knownSupplierSearch(String SearchByRFC,String SearchByName, String SearchByCurrency, String SearchByTaxCode){        
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
        if(sandbox =='Developer Edition'){
            namecred = 'ContentManagmentDevToken';
        }
        request.setEndpoint('callout:'+ namecred);  
        string endpoint = request.getEndpoint() + '/SupplierAPI/v2.0/suppliers/details?vendorName=' + EncodingUtil.urlEncode(SearchByName, 'UTF-8') +'&rfc='+SearchByRFC +'&currencyCode='+ SearchByCurrency +'&vatCode=' + SearchByTaxCode; 
        request.setEndpoint(endpoint);
        request.setMethod('GET');    
        request.setTimeout(120000);
        HttpResponse response = http.send(request);
        if (response.getStatusCode() == 200) {
            //string despues = response.getBody();
            //responde = despues.replace('currency', 'curency');
        	System.debug('response.getBody() ' + response.getBody());
            return response.getBody();
        } else {
            
            System.debug(LoggingLevel.WARN,'JSON :' + response.getBody() +
                         'status :' + response.getStatus()+
                         'status code :' + response.getStatusCode());
            return response.getBody();
        }
    }
    
    //Servicio consulta detalle known Supplier por Name y RFC
    public static Takedown_Wrapper_DetSearchKnownSuppliers.responseDetSearchKnownSupplier detKnownSupplierSearch(String SearchByRFC,String SearchByName){        
        Takedown_Wrapper_DetSearchKnownSuppliers.responseDetSearchKnownSupplier detKnownSupplierSearch = new Takedown_Wrapper_DetSearchKnownSuppliers.responseDetSearchKnownSupplier();
        Http http = new Http();
        HttpRequest request = new HttpRequest();       
        string responde;
        string typeofSandbox = GetSandboxType.getTypeOfSandbox();
        string namecred;
        if(typeofSandbox == 'DEV'){
            namecred = 'getsServiceUrl';
        }
        if(typeofSandbox == 'QA'){
            namecred = 'getsServiceUrlQa';
        }
        if(typeofSandbox =='PROD'){
            namecred = 'getsServiceUrlProd';
        } 
        if(typeofSandbox =='Developer Edition'){
            namecred = 'ContentManagmentDevToken';
        }
        if(Test.isRunningTest()){   
            request.setEndpoint('https://apps.engeniumcapital.com/knowSuppliers');   
        } else {
           	request.setEndpoint('callout:'+namecred+'/SupplierAPI/v2.0/suppliers/details?vendorName='+EncodingUtil.urlEncode(SearchByName, 'UTF-8')+'&rfc='+SearchByRFC);
        }                        
        request.setMethod('GET');
        request.setTimeout(120000);
        HttpResponse response = http.send(request);
        if (response.getStatusCode() == 200) {
            string despues = response.getBody();
            responde = despues.replace('currency', 'curency');
            detKnownSupplierSearch = (Takedown_Wrapper_DetSearchKnownSuppliers.responseDetSearchKnownSupplier)JSON.deserialize(responde, Takedown_Wrapper_DetSearchKnownSuppliers.responseDetSearchKnownSupplier.class);
        	System.debug('response.getBody() ' + response.getBody());
            System.debug('responde:::: ' + responde);
        } else {
            
            System.debug(LoggingLevel.WARN,'JSON :' + response.getBody() +
                         'status :' + response.getStatus()+
                         'status code :' + response.getStatusCode());
        }
        return detKnownSupplierSearch;	
    }
}