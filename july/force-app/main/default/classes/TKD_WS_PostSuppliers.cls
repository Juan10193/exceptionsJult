public  class TKD_WS_PostSuppliers {
    public static HttpResponse postSupplier(string body){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
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
        request.setEndpoint('callout:'+ namecred +'/SupplierAPI/v2.0/suppliers'); 
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setBody(body);
        request.setTimeout(120000);
        HttpResponse response = http.send(request);
         if (response.getStatusCode() != 200) {
            System.debug('The status code returned was not expected: ' +
                response.getStatusCode() + ' ' + response.getStatus());
            } else {
                System.debug(response.getBody());
            }
        return response;
         
    }
}