public with sharing class ConsumeQuoteSeguro_cls {
    
    public String urlService {get; set;}
    public String endPointQuote {get; set;}
    
    public ConsumeQuoteSeguro_cls() {
        urlService = Test.isRunningTest() ? 'Service' : 'callout:' + ConsumeQuoteSeguro_cls.credentialValidation();
        endPointQuote = '/Insurance/api/v1/Interesse/quote/';
    }
    
    //Get connect service
    public static String credentialValidation() {
        string namedCredential;

        switch on GetSandboxType.getTypeOfSandbox() {
            when 'DEV' {		
                namedCredential = 'getsServiceUrl';
            }	
            when 'QA' {		
                namedCredential = 'getsServiceUrlQa';
            }
            when 'PROD' {		
                namedCredential = 'getsServiceUrlProd';
            }
            when 'Developer Edition' {
            	namedCredential = 'getsServiceUrl';
        	}
            when else {		  
                namedCredential = 'getsServiceUrl';
            }
        }
        return namedCredential;
    }
    
    //method for creating quotes
    public static Map<String, Object> createdQuote(String sendJson) {
        
        ConsumeQuoteSeguro_cls info = new ConsumeQuoteSeguro_cls();

        Map<String, Object> dataJson = new Map<String, Object>();
        String strResponse = null;

        //if(!Test.isRunningTest() || info.urlService == 'http://160.34.7.97:70') {
            try {
                HttpRequest httpRequest = new HttpRequest();
                httpRequest.setEndpoint(info.urlService + info.endPointQuote);
                httpRequest.setTimeout(120000);
                httpRequest.setHeader('Content-Type', 'application/json');
                httpRequest.setMethod('POST');
                httpRequest.setBody(sendJson);

                Http http = new Http();
                HttpResponse httpResponse = http.send(httpRequest);

                if(httpResponse.getStatusCode() == 200) {
                    strResponse = httpResponse.getBody();
                } else {
                    throw new CalloutException(httpResponse.getBody());
                }
            } catch (Exception ex) {
                throw ex;
            }

            if(!String.isBlank(strResponse)) {
                dataJson = (Map<String, Object>) System.JSON.deserializeUntyped(strResponse);
            }
            if(!dataJson.isEmpty()) {
                return dataJson;
            } else {
                return null;
            }
        //} 
        /*else {
            return dataJson = (Map<String, Object>) JSON.deserializeUntyped(EIV_EntityJsonCreateTest.updateinvoices());
        }*/
    }
}