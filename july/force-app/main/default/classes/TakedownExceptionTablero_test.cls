@IsTest
private class TakedownExceptionTablero_test {

    static testMethod void getDashboard() {
        RestRequest restReq = new RestRequest();
        RestResponse restRes = new RestResponse();
        restReq.requestURI = '/services/apexrest/';
        restReq.httpMethod = 'GET';
        RestContext.request = restReq;
        RestContext.response = restRes;
        
        TakedownExceptionTablero.getExceptionTablero();
    }
}