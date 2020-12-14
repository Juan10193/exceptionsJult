@isTest
public class Takedown_Controller_NewSupplierInCA_Test {
	@isTest
    public static void Takedown_Controller_NewSupplierInCA(){
        string stringResponse = '{"access_token":"0bd709f8-049a-406a-98ca-b46a70ced19c","token_type":"bearer","expires_in":299,"scope":"test"}';
        String testEndpoint = 'https://apps.engeniumcapital.com:18080/uaa/oauth/token';
        string json = 'SSASS';
          Test.setMock(HttpCalloutMock.class, new MockHttpResponseHandler_cls(testEndpoint,stringResponse , 'GET', 'application/json', 200));
        Takedown_Controller_NewSupplierInCA.SearchSupplierForNameOrRFC(json);
      
        
    }
}