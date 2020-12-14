public class Takedown_Controller_NewSupplierInCA {

    public static Takedown_Wrapper_NewSupplierInCA.Request_Parameters SearchSupplierForNameOrRFC (String jsonRequest){
        system.debug('jsonRequest--' + jsonRequest);
        Takedown_Wrapper_NewSupplierInCA.Request_Parameters SearchSupplier = new Takedown_Wrapper_NewSupplierInCA.Request_Parameters();
        Http http = new Http();        
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:postInformationNewSupplier');
		request.setHeader('Content-Type', 'application/json;charset=UTF-8'); 
        request.setMethod('POST');
        request.setBody(jsonRequest);
        request.setTimeout(120000);
        HttpResponse response = http.send(request);
        if (response.getStatusCode() == 200) {
            SearchSupplier = (Takedown_Wrapper_NewSupplierInCA.Request_Parameters)JSON.deserialize(response.getBody(), Takedown_Wrapper_NewSupplierInCA.Request_Parameters.class); // Jsonstring is the above JSON
        	//System.debug('response.getBody() ' + response.getBody());
        }
        return SearchSupplier;
    }
}