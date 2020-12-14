@IsTest
public class WS_tokenOauth_REST_test {
    
    static testMethod void getToken() {
        
        RestRequest req = new RestRequest();
        RestResponse res =  new RestResponse();
        WS_tokenOauth_REST getToken = new WS_tokenOauth_REST();
            
        String testU = '{"user" : "testUser" ,"password" : "Test2020"}';
        
        blob key = Blob.valueOf('PruebaTest123456');
		blob iv =  Blob.valueOf('Prueba de IV3579');
		blob textBlob = blob.valueOf(testU);
		blob encryptedData = Crypto.encrypt('AES128', key, iv, textBlob);
        String encodedCipherText = EncodingUtil.base64Encode(encryptedData); 
 
        
        req.requestURI = '/services/apexrest/SFtoken/';
        req.addHeader('Content-Type', 'application/json');
        req.addHeader('parameters', encodedCipherText);
        req.httpMethod = 'GET';
        
        RestContext.request = req;
    	RestContext.response= res;
        
        Test.startTest();
        try {
        	Test.setMock(HttpCalloutMock.class, new WS_tokenOauth_REST_mock());
        	WS_tokenOauth_REST.doGet();
        }catch(Exception e) {
            System.assert(false, 'Exception ' + e);
        }
        test.stopTest();
    }
}