public class TKD_supplierInTD_NewSupplierWS {
    private static string getNamedCredential(){
        string namedCredential;
        switch on GetSandboxType.getTypeOfSandbox() {
            when 'DEV' {		
                namedCredential = 'TKD_Supplier_Dev';
            }	
            when 'QA' {		
                namedCredential = 'TKD_Supplier_QA';
            }
            when 'PROD' {		
                namedCredential = 'TKD_Supplier_Prod';
            }
            when else {		  
                namedCredential = 'OLInvoicesDev';
            }
        }
        return namedCredential;
    }
    public static void postSupplier(String JSON){
        system.debug(LoggingLevel.INFO, 'Inicia postSupplier');
        Takedown_Wrapper_SATVal_OL_cls.SATValResponse SATValResponse = new Takedown_Wrapper_SATVal_OL_cls.SATValResponse();
        Http http = new Http();        
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:' + getNamedCredential() + '/SupplierAPI/v2.0/suppliers');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json');
        request.setBody(JSON);
        request.setTimeout(Global_SetUp.setup_TimeOut);
        HttpResponse response;
        try{
        	response = http.send(request);    
        } catch(Exception e){
            system.debug(LoggingLevel.ERROR,'Exception ' + e);   
        }
        if (response.getStatusCode() == 200) {
        	System.debug('response.getBody() ' + response.getBody());
        } else{            
            System.debug(LoggingLevel.ERROR,'StatusCode: ' + response.getStatusCode());
            System.debug(LoggingLevel.ERROR,'Body: ' + response.getBody());
        }
    }

}