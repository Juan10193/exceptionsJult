@isTest
private class EIV_EntityExtencionCalloutClassTest {
    @isTest static void testentitiesOfTopParent(){
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new MockHttpEntitiesTP());
        
        // Call method to test.
        // This causes a fake response to be sent
        // from the class that implements HttpCalloutMock. 
        String a = '345';
        String b = '123';
        String c = 'http://160.34.7.97:7033';
        Map<string,object> res = EIV_EntityExtencionCalloutClass.callBackEntitiesOfTopParent(b, a, c);
        
        
        // Verify response received contains fake values
        System.debug(res);
        // String contentType = res.;
        //System.assert(contentType == 'application/json');
        //String actualValue = res.getBody();
        //String expectedValue = '{"example":"test"}';
        //System.assertEquals(actualValue, expectedValue);
        //System.assertEquals(200, res.getStatusCode());
    }
    
    
    @isTest static void testcallBackCreditBureau(){
        Test.setMock(HttpCalloutMock.class, new MockHttpcallBackcallBackCreditBureau());
        String sServiceURL= 'http://160.34.7.97:7033'; 
        Map<String, Object> supermap = new Map<String, Object>();
        
        supermap.put('sSSO','dummy');
        supermap.put('requestId','dummy');
        supermap.put('rfc','dummy');
        supermap.put('name','dummy');
        supermap.put('sname','dummy');
        supermap.put('lname','dummy');
        supermap.put('slname','dummy');
        supermap.put('address','dummy'+'dummy'+'dummy');
        supermap.put('ecEntity','dummy');
        supermap.put('letterSigningDate','dummy');
        supermap.put('suburb','dummy');
        supermap.put('zipCode','dummy');
        supermap.put('city','dummy');
        supermap.put('state','dummy');
        supermap.put('autorizationLetter', 'dummy');
        supermap.put('sourceAccountId','dummy');
        supermap.put('sourceAccountName','sourceAccountName' );
        supermap.put('sourceTopParentId','dummy');
        supermap.put('sourceTopParentName','dummy' );
        supermap.put('partyId','dummy');
        supermap.put('partyName','dummy');
        supermap.put('comment','dummy');
        supermap.put('contractNumber','contractNumber' );
        supermap.put('anex','anex');
        supermap.put('egPartyId','dummy');
        supermap.put('egPartyName','dummy');
        supermap.put('sourceOpId','dummy');
        supermap.put('sourceCAId','dummy');
        supermap.put('createdBy','dummy');
        supermap.put('dummyFlag','dummy');
        supermap.put('county','dummy');
        supermap.put('Entity','dummy');
        Map<string,object> res = EIV_EntityExtencionCalloutClass.callBackCreditBureau(sServiceURL,supermap);
        
        
        
    }
    
    @isTest static void testcallBackCreditBureauNo(){
        Test.setMock(HttpCalloutMock.class, new MockHttpcallBackcallBackCreditBureauNo());
        String sServiceURL= 'http://160.34.7.97:7033'; 
        Map<String, Object> supermap = new Map<String, Object>();
        
        supermap.put('sSSO','dummy');
        supermap.put('requestId','dummy');
        supermap.put('rfc','dummy');
        supermap.put('companyName','dummy');
        supermap.put('address','dummy'+'dummy'+'dummy');
        supermap.put('ecEntity','dummy');
        supermap.put('letterSigningDate','dummy');
        supermap.put('suburb','dummy');
        supermap.put('zipCode','dummy');
        supermap.put('city','dummy');
        supermap.put('state','dummy');
        supermap.put('autorizationLetter', 'dummy');
        supermap.put('sourceAccountId','dummy');
        supermap.put('sourceAccountName','sourceAccountName' );
        supermap.put('sourceTopParentId','dummy');
        supermap.put('sourceTopParentName','dummy' );
        supermap.put('partyId','dummy');
        supermap.put('partyName','dummy');
        supermap.put('comment','dummy');
        supermap.put('contractNumber','contractNumber' );
        supermap.put('anex','anex');
        supermap.put('egPartyId','dummy');
        supermap.put('egPartyName','dummy');
        supermap.put('sourceOpId','dummy');
        supermap.put('sourceCAId','dummy');
        supermap.put('createdBy','dummy');
        supermap.put('dummyFlag','dummy');
        supermap.put('county','dummy');
        supermap.put('Entity','dummy');
        Map<string,object> res = EIV_EntityExtencionCalloutClass.callBackCreditBureau(sServiceURL,supermap );
    }   
    
    
    @isTest static void testcallBackGetRequestDetails(){
        Test.setMock(HttpCalloutMock.class, new MockHttpcallBackGetRequestDetails());
        String sso= '999999999';
        String app= 'Data dummy';
        String sServiceURL= 'Data dummy';
        String searchAssignedGroup= 'Data dummy';
        String searchRequestType= 'Data dummy';
        String searchAssignedTo= 'Data dummy';
        String searchRequestStatus= 'Data dummy';
        String searchStartDate= 'Data dummy';
        String searchEndDate= 'Data dummy';
        String searchSourceAccountName='Data dummy';
        String searchNameAssignedTo = 'Data dummy';
        String searchRequestedBy= 'Data dummy'; 
        String searchPartyName= 'Data dummy';
        String searchSourceTopParentName= 'Data dummy';
        String searchEgPartyName= 'Data dummy';
        String searchRequestId= 'Data dummy';
        String sSSO= 'Data dummy';
        Map<String,object> res = EIV_EntityExtencionCalloutClass.callBackGetRequestDetails(sso, app, sServiceURL, searchAssignedGroup, searchRequestType, searchAssignedTo, searchNameAssignedTo, searchRequestStatus,searchStartDate,searchEndDate, searchRequestedBy, searchPartyName, searchSourceTopParentName, searchSourceAccountName, searchEgPartyName, searchRequestId, sSSO);
        
    }
    
    @isTest static void testcallBackGetRequestDetailsReturn(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        String sso= '999999999';
        String app= 'Data dummy';
        String sServiceURL= 'Data dummy';
        String searchAssignedGroup= 'Data dummy';
        String searchRequestType= 'Data dummy';
        String searchAssignedTo= 'Data dummy';
        String searchRequestStatus= 'Data dummy';
        String searchStartDate= 'Data dummy';
        String searchEndDate= 'Data dummy';
        String searchSourceAccountName='Data dummy';
        String searchNameAssignedTo = 'Data dummy';
        String searchRequestedBy= 'Data dummy'; 
        String searchPartyName= 'Data dummy';
        String searchSourceTopParentName= 'Data dummy';
        String searchEgPartyName= 'Data dummy';
        String searchRequestId= 'Data dummy';
        String sSSO= 'Data dummy';
        Map<String,object> res = EIV_EntityExtencionCalloutClass.callBackGetRequestDetails(sso, app, sServiceURL, searchAssignedGroup, searchRequestType, searchAssignedTo, searchNameAssignedTo, searchRequestStatus,searchStartDate,searchEndDate, searchRequestedBy, searchPartyName, searchSourceTopParentName, searchSourceAccountName, searchEgPartyName, searchRequestId, sSSO);
        
    }
    
    @isTest static void testCalloutcallBackllAllEconomicGroup() {
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        
        
        // Call method to test.
        // This causes a fake response to be sent
        // from the class that implements HttpCalloutMock. 
        String a = '345';
        String b = '123';
        String c = 'http://160.34.7.97:7033';
        Map<string,object> res = EIV_EntityExtencionCalloutClass.callBackllAllEconomicGroup(c,b);
        
        
        // Verify response received contains fake values
        System.debug(res);
        // String contentType = res.;
        //System.assert(contentType == 'application/json');
        //String actualValue = res.getBody();
        //String expectedValue = '{"example":"test"}';
        //System.assertEquals(actualValue, expectedValue);
        //System.assertEquals(200, res.getStatusCode());
    }
    
    @isTest static void testcallBackEntitiesOfEconomicGroup() {
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGeneratorEntitiesEg());
        
        // Call method to test.
        // This causes a fake response to be sent
        // from the class that implements HttpCalloutMock. 
        String a = '123';
        String b = '123';
        String c = 'http://160.34.7.97:7033';
        Map<string,object> res = EIV_EntityExtencionCalloutClass.callBackEntitiesOfEconomicGroup(a, b, c);
        
        
        // Verify response received contains fake values
        System.debug(res.size());
        // String contentType = res.;
        //System.assert(contentType == 'application/json');
        //String actualValue = res.getBody();
        //String expectedValue = '{"example":"test"}';
        //System.assertEquals(actualValue, expectedValue);
        //System.assertEquals(200, res.getStatusCode());
    }
    
    @isTest static void testcallBackEntitieDetail() {
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new MockHttpEntityDetail());
        
        // Call method to test.
        // This causes a fake response to be sent
        // from the class that implements HttpCalloutMock. 
        String a = '999999999';
        String b = '123';
        String c = 'http://160.34.7.97:7033';
        String d = 'SF';
        Map<string,object> res = EIV_EntityExtencionCalloutClass.callBackEntityDetail(a, b, d, c);
        
        
        // Verify response received contains fake values
        System.debug(res.size());
        // String contentType = res.;
        //System.assert(contentType == 'application/json');
        //String actualValue = res.getBody();
        //String expectedValue = '{"example":"test"}';
        //System.assertEquals(actualValue, expectedValue);
        //System.assertEquals(200, res.getStatusCode());
    }
    
    @isTest static void testcallBackEntityDetailElse(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        String sso= 'Data dummy';
        String app= 'Data dummy';
        String sServiceURL= 'Data dummy';
        String partyId= 'Data dummy';
        Map<String,object> res = EIV_EntityExtencionCalloutClass.callBackEntityDetail(sso, partyId, app, sServiceURL);
    }
    
    @isTest static void testcallBackEntitiesSearch() {
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new MockHttpEntitiesSearch());
        
        // Call method to test.
        // This causes a fake response to be sent
        // from the class that implements HttpCalloutMock. 
        String a = '999999999';
        String b = '123';
        String c = 'http://160.34.7.97:7033';
        String d = 'JDLLL951218';
        Map<string,object> res = EIV_EntityExtencionCalloutClass.callBackEntitiesSearch(d, a, c);
        
        
        // Verify response received contains fake values
        System.debug(res.size());
        // String contentType = res.;
        //System.assert(contentType == 'application/json');
        //String actualValue = res.getBody();
        //String expectedValue = '{"example":"test"}';
        //System.assertEquals(actualValue, expectedValue);
        //System.assertEquals(200, res.getStatusCode());
    }
    
    @isTest static void testcallBackEntitiesSearchElse(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        String sSearch= 'Data dummy';
        String sSSO= 'Data dummy';
        String sServiceURL= 'Data dummy';
        Map<String,object> res = EIV_EntityExtencionCalloutClass.callBackEntitiesSearch(sSearch, sSSO, sServiceURL);
    }
    
    @isTest static void testcallBackPostEntity() {
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new MockHttpPostEntity());
        
        // Call method to test.
        // This causes a fake response to be sent
        // from the class that implements HttpCalloutMock. 
        String a = '123';
        String b = '123';
        String c = 'http://160.34.7.97:70';
        String d = 'JDLLL951218';
        Map<string,object> res = EIV_EntityExtencionCalloutClass.postEntity(a,c);
        
        
        // Verify response received contains fake values
        System.debug(res.size());
        // String contentType = res.;
        //System.assert(contentType == 'application/json');
        //String actualValue = res.getBody();
        //String expectedValue = '{"example":"test"}';
        //System.assertEquals(actualValue, expectedValue);
        //System.assertEquals(200, res.getStatusCode());
    }
    
    @isTest static void testpostEntityElse(){
        Test.setMock(HttpCalloutMock.class, new MockHttpPostEntity());
        String jsonS= 'Data dummy';
        String sServiceURL= 'http://160.34.7.97:70';
        Map<String,object> res = EIV_EntityExtencionCalloutClass.postEntity(jsonS, sServiceURL);
    }
    
    @isTest static void testcallBackpostAddress() {
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new MockHttpPostAddress());
        
        // Call method to test.
        // This causes a fake response to be sent
        // from the class that implements HttpCalloutMock. 
        String a = '123';
        String b = '123';
        String c = 'http://160.34.7.97:7033';
        String d = 'JDLLL951218';
        Map<string,object> res = EIV_EntityExtencionCalloutClass.postAddress(a, c);
        
        
        // Verify response received contains fake values
        System.debug(res.size());
        // String contentType = res.;
        //System.assert(contentType == 'application/json');
        //String actualValue = res.getBody();
        //String expectedValue = '{"example":"test"}';
        //System.assertEquals(actualValue, expectedValue);
        //System.assertEquals(200, res.getStatusCode());
    }
    
    @isTest static void testpostAddressElse(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        String jsonS= 'Data dummy';
        String sServiceURL= 'Data dummy';
        Map<String,object> res = EIV_EntityExtencionCalloutClass.postAddress(jsonS, sServiceURL);
    }
    
    @isTest static void testcallBackpostContact() {
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new MockHttpPostContact());
        
        // Call method to test.
        // This causes a fake response to be sent
        // from the class that implements HttpCalloutMock. 
        String a = '123';
        String b = '123';
        String c = 'http://160.34.7.97:7033';
        String d = 'JDLLL951218';
        Map<string,object> res = EIV_EntityExtencionCalloutClass.postContact(a, c);
        
        
        // Verify response received contains fake values
        System.debug(res.size());
        // String contentType = res.;
        //System.assert(contentType == 'application/json');
        //String actualValue = res.getBody();
        //String expectedValue = '{"example":"test"}';
        //System.assertEquals(actualValue, expectedValue);
        //System.assertEquals(200, res.getStatusCode());
    }
    
    @isTest static void testpostContactElse(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        String jsonS= 'Data dummy';
        String sServiceURL= 'http://160.34.7.97:7033';
        Map<String,object> res = EIV_EntityExtencionCalloutClass.postContact(jsonS, sServiceURL);
    }
    
    
    @isTest static void testcallBackpostAssets() {
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new MockHttpPostAssets());
        
        string a = 'Data dummy';
        string b ='http://160.34.7.97:70';
        Map<String,object> res = EIV_EntityExtencionCalloutClass.postAssets(a, b);
    }
    
    @isTest static void testcallBackpostValuations() {
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new MockHttpPostValuations());
        
        string a = 'Data dummy';
        string b ='http://160.34.7.97:70';
        Map<String,object> res = EIV_EntityExtencionCalloutClass.postValuations(a, b);
    }
    
    @isTest static void testcallBackpostEndorsement() {
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new MockHttpPostendorsement());
        
        string a = 'Data dummy';
        string b ='http://160.34.7.97:70';
        Map<String,object> res = EIV_EntityExtencionCalloutClass.postendorsement(a,b);
    }
    
    @isTest static void testcallBackpostInvoicing() {
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new MockHttpPostInvoicing());
        
        // Call method to test.
        // This causes a fake response to be sent
        // from the class that implements HttpCalloutMock. 
        String a = '123';
        String b = '123';
        String c = 'http://160.34.7.97:7033';
        String d = 'JDLLL951218';
        Map<string,object> res = EIV_EntityExtencionCalloutClass.postInvoicing(a, c);
        
        
        // Verify response received contains fake values
        System.debug(res.size());
        // String contentType = res.;
        //System.assert(contentType == 'application/json');
        //String actualValue = res.getBody();
        //String expectedValue = '{"example":"test"}';
        //System.assertEquals(actualValue, expectedValue);
        //System.assertEquals(200, res.getStatusCode());
    }
    
    @isTest static void testpostInvoicingElse(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        String jsonS= 'Data dummy';
        String sServiceURL= 'http://160.34.7.97:7033';
        Map<String,object> res = EIV_EntityExtencionCalloutClass.postInvoicing(jsonS, sServiceURL);
    }
    
    @isTest static void testcallBackGetDocument(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGeneratorGetDocuments());
        String sServiceURL = 'http://160.34.7.97:7033';
        String contentDocId = 'Datadummy';
        Map<String,object> res = EIV_EntityExtencionCalloutClass.callBackGetDocument(sServiceURL, contentDocId);
    }
    
    @isTest static void testcallBackGetRequestForPartyId(){
        Test.setMock(HttpCalloutMock.class, new MockHttpcallBackcGeRequestForParty());
        String sso= '999999999';
        String app= 'SF';
        String sServiceURL= 'http://160.34.7.97:7033';
        String searchPartyId= '123';
        
        Map<String,object> res = EIV_EntityExtencionCalloutClass.callBackGetRequestForPartyId(sso, app, sServiceURL, searchPartyId);
    }
    
    @isTest static void testcallBackGetRequestForPartyIdReturn(){
        Test.setMock(HttpCalloutMock.class, new MockHttpGetRequestForPartyIdReturn());
        String sso= '999999999';
        String app= 'SF';
        String sServiceURL= 'http://160.34.7.97:7033';
        String searchPartyId= '123';
        
        Map<String,object> res = EIV_EntityExtencionCalloutClass.callBackGetRequestForPartyId(sso, app, sServiceURL, searchPartyId);
    }
    
    @isTest static void testcallBackGetRequestDetailsOne(){
        Test.setMock(HttpCalloutMock.class, new MockHttpcallBackGetRequestDetailsOne());
        String sso= '999999999';
        String app= 'Data dummy';
        String sServiceURL= 'http://160.34.7.97:7033';
        String searchRequestId;
        
        Map<String,object> res = EIV_EntityExtencionCalloutClass.callBackGetRequestDetailsOne(sso, app, sServiceURL, searchRequestId);
    }
    
    @isTest static void testcallBackGetRequestDetailsOneReturn(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        String sso= 'Data dummy';
        String app= 'Data dummy';
        String sServiceURL= 'http://160.34.7.97:7033';
        String searchRequestId = '123';
        
        Map<String,object> res = EIV_EntityExtencionCalloutClass.callBackGetRequestDetailsOne(sso, app, sServiceURL, searchRequestId);
    }
    
    @isTest static void testpostUploadDocument(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGeneratorPost());
        String sServiceURL= 'Data dummy';
        String jsonS= 'Data dummy';
        
        Map<String,object> res = EIV_EntityExtencionCalloutClass.postUploadDocument(sServiceURL, jsonS);
    }
    
    @isTest static void testpostComments(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGeneratorPost());
        String jsonS= 'Data dummy';
        String sServiceURL= 'http://160.34.7.97:7033';
        
        Map<String,object> res = EIV_EntityExtencionCalloutClass.postComments(jsonS, sServiceURL);
    }
    
    @isTest static void testpostCommentsElse(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGeneratorPost());
        String jsonS= 'Data dummy';
        String sServiceURL= 'http://160.34.7.97:70';
        
        Map<String,object> res = EIV_EntityExtencionCalloutClass.postComments(jsonS, sServiceURL);
    }
    
    @isTest static void testpostKYCDetail(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGeneratorPost());
        String jsonS= 'Data dummy';
        String sServiceURL= 'http://160.34.7.97:7033';
        
        EIV_EntityExtencionCalloutClass.postKYCDetail(jsonS, sServiceURL);
    }
    
    @isTest static void testpostKYCDetailElse(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        String jsonS= 'Data dummy';
        String sServiceURL= 'http://160.34.7.97:7033';
        
        Map<String,object> res = EIV_EntityExtencionCalloutClass.postKYCDetail(jsonS, sServiceURL);
    }
    
    @isTest static void testpostRequestDetail(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGeneratorPost());
        String jsonS = 'Data dummy';
        String sServiceURL = 'http://160.34.7.97:7033';
        
        Map<String,object> res = EIV_EntityExtencionCalloutClass.postRequestDetail(jsonS, sServiceURL);
    }
    
    @isTest static void testpostRequestDetailElse(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        String jsonS = 'Data dummy';
        String sServiceURL = 'http://160.34.7.97:7033';
        
        Map<String,object> res = EIV_EntityExtencionCalloutClass.postRequestDetail(jsonS, sServiceURL);
    }
    
    @isTest static void testcallBackGetDocumentsInEntity(){
        Test.setMock(HttpCalloutMock.class, new MockHttpGetDocumentsInEntity());
        String sServiceURL= 'Data dummy';
        String jsonS= 'Data dummy';
        
        Map<String,object> res = EIV_EntityExtencionCalloutClass.callBackGetDocumentsInEntity(sServiceURL, 'partyId');
    }
    
    @isTest static void testcallBackAuditEntity(){
        Test.setMock(HttpCalloutMock.class, new MockGttpcallBackAuditEntity());
        String sServiceURL= 'Data dummy';
        String jsonS= 'Data dummy';
        
        Map<String,object> res = EIV_EntityExtencionCalloutClass.callBackAuditEntity('partyId', sServiceURL);
    }
    @istest
    static void testcallback_limitantes(){
        Test.setMock(HttpCalloutMock.class, new Mockhttptabla_limitantes_post());
        String sServiceURL= 'http://160.34.7.97:7033';
        String jsonS= 'hola';
        EIV_EntityExtencionCalloutClass.callBack_Tabla_Limitantes(jsonS,sServiceURL);
    }
    @istest
    static void testcallback_limitantes_error(){
        Test.setMock(HttpCalloutMock.class, new MockhttpTabla_limitantes_Error());
        String sServiceURL= 'http://160.34.7.97:7033';
        String jsonS= 'hola';
        EIV_EntityExtencionCalloutClass.callBack_Tabla_Limitantes(jsonS,sServiceURL);
    }
    @istest
    static void testcallback_modificaciones(){
        Test.setMock(HttpCalloutMock.class, new Mockhttptabla_Modificacion());
        String sServiceURL= 'http://160.34.7.97:7033';
        String jsonS= 'hola';
        EIV_EntityExtencionCalloutClass.callBack_Tabla_Modificaciones(jsonS,sServiceURL);
    }
    @istest
    static void testcallback_estatutos(){
        Test.setMock(HttpCalloutMock.class, new Mockhttptabla_estatutos());
        String sServiceURL= 'http://160.34.7.97:7033';
        String jsonS= 'hola';
        EIV_EntityExtencionCalloutClass.callBack_Tabla_Estatutos(jsonS,sServiceURL);
    }
    @istest
    static void testcallback_apoderados(){
        Test.setMock(HttpCalloutMock.class, new Mockhttptabla_Apoderados());
        String sServiceURL= 'http://160.34.7.97:7033';
        String jsonS= 'hola';
        EIV_EntityExtencionCalloutClass.callBack_Tabla_Apoderados(jsonS,sServiceURL);
    }
    @isTest 
    static void testcallBackpostLAD() {
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new MockHttpPostLAD());
        
        string a = 'Data dummy';
        string b ='http://160.34.7.97:70';
        EIV_EntityExtencionCalloutClass.postLAD(a, b);
    }
    
    /*@isTest 
    static void testcallBackpostla() {
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new MockHttpPostLAD());
        
        string a = 'Data dummy';
        string b ='http://160.34.7.97:70';
        EIV_EntityExtencionCalloutClass.postRequestDetail_SecondDetail(a, b);
    }*/
    
}