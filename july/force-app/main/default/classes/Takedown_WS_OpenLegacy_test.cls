@istest
public class Takedown_WS_OpenLegacy_test {
    
    @istest
    static void getToken(){
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('Mock_Data_WS_OL_getToken');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');        
        // Set the mock callout mode
        Test.setMock(HttpCalloutMock.class, mock);
        HTTPResponse res = Takedown_WS_OpenLegacy_cls.getToken();
        system.debug(' res.getBody() ' +  res.getBody());
    }
    @istest
    static void SATValidationOpenLegacy(){
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('Mock_Data_WS_OL_SATValidationOpenLegacy');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');        
        // Set the mock callout mode
        Test.setMock(HttpCalloutMock.class, mock);
        String token = 'e5437155-f0d3-435d-8f2b-a96c79d1c9ef';
        String request = 'hola';
        String id = 'a2Y8A000000aL4xUAE';
        Takedown_WS_OpenLegacy_cls.SATValidationOpenLegacy(token,request,id);
    }
    @istest
    static void FindAssetsByTakedown(){
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('Mock_Data_WS_OL_FindAssetsByTakedown');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');        
        // Set the mock callout mode
        Test.setMock(HttpCalloutMock.class, mock);
        String token = 'e5437155-f0d3-435d-8f2b-a96c79d1c9ef';
        String request = 'hola';
        //Takedown_WS_OpenLegacy_cls.FindAssetsByTakedown(token,request);
    }
    
    @istest
    static void FindAssetsByDocument(){
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('Mock_Data_WS_OL_FindAssetsByTakedown');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');   
        Test.setMock(HttpCalloutMock.class, mock);
        String token = 'e5437155-f0d3-435d-8f2b-a96c79d1c9ef';
        String request = 'hola';
        Takedown_WS_OpenLegacy_cls.FindAssetsByDocument(token,request);
    }
    @istest
    static void getBankAccount(){
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('Mock_Data_WS_OL_FindAssetsByTakedown');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');   
        Test.setMock(HttpCalloutMock.class, mock);
        String token = 'e5437155-f0d3-435d-8f2b-a96c79d1c9ef';
        Takedown_WS_OpenLegacy_cls.getBankAccount(token);
    }
    @istest
    static void otherMethods(){
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('Mock_Data_WS_OL_FindAssetsByTakedown');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');   
        Test.setMock(HttpCalloutMock.class, mock);
        String token = 'e5437155-f0d3-435d-8f2b-a96c79d1c9ef';
        Takedown_WS_OpenLegacy_cls.getNamedCredential();
        Takedown_WS_OpenLegacy_cls.getTokenByNamedCredential();
    }
    @istest
    static void findContracts(){
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('Mock_Data_WS_OL_FindAssetsByTakedown');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');   
        Test.setMock(HttpCalloutMock.class, mock);
        String token = 'e5437155-f0d3-435d-8f2b-a96c79d1c9ef';
        Takedown_WS_OpenLegacy_cls.getNamedCredential();
        String request = 'hola';
        Takedown_WS_OpenLegacy_cls.findContracts(token,request);
    }
    @istest
    static void getNetBookValueXdate(){
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('Mock_Data_WS_OL_FindAssetsByTakedown');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');   
        Test.setMock(HttpCalloutMock.class, mock);
        String token = 'e5437155-f0d3-435d-8f2b-a96c79d1c9ef';
        Takedown_WS_OpenLegacy_cls.getNamedCredential();
        String request = 'hola';
        Takedown_WS_OpenLegacy_cls.getNetBookValueXdate(token,request);
    }
    @istest
    static void requestTerminationQoute(){
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('Mock_Data_WS_OL_FindAssetsByTakedown');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');   
        Test.setMock(HttpCalloutMock.class, mock);
        String token = 'e5437155-f0d3-435d-8f2b-a96c79d1c9ef';
        Takedown_WS_OpenLegacy_cls.getNamedCredential();
        String request = 'hola';
        Takedown_WS_OpenLegacy_cls.requestTerminationQoute(token,request);
    }
    
    
}