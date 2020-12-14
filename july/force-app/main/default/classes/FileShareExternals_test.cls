@IsTest
private class FileShareExternals_test {

    static testMethod void callMethodFileExternal() {
        RestRequest restReq = new RestRequest();
        RestResponse restRes = new RestResponse();
        restReq.requestURI = 'services/apexrest/FileShareExternal/';
        restReq.httpMethod = 'GET';
        restReq.addHeader('idDocumentLink', '0691F000000t2O7QAI');
        restReq.addHeader('auth', 'Authorization: Bearer 00D1F000000A11j!AQYAQBGCXAmedSKo');
        RestContext.request = restReq;
        RestContext.response = restRes;
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new FileShareExternals_mock());
        FileShareExternal.getFileShare();
        test.stopTest();
    }
}