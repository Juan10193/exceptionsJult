@isTest
public class Takedown_WS_OpenLegacy_helper_Test {
    
    @isTest
    static void getNamedCredential(){
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('Mock_Data_WS_OL_getToken');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');        
        // Set the mock callout mode
        Test.setMock(HttpCalloutMock.class, mock);
        Takedown_WS_OpenLegacy_cls.getNamedCredential();
        
    }
    
    
    @isTest
    static void getTokenByNamedCredential(){
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('Mock_Data_WS_OL_getToken');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');        
        // Set the mock callout mode
        Test.setMock(HttpCalloutMock.class, mock);
        Takedown_WS_OpenLegacy_cls.getTokenByNamedCredential();
    }
    
    @istest
    static void setErrorResponse(){
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('Mock_Data_WS_OL_setErrorResponse');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');        
        // Set the mock callout mode
        Test.setMock(HttpCalloutMock.class, mock);
        String code = 'e5437155-f0d3-435d-8f2b-a96c79d1c9ef';
        String message = 'hola';
        Takedown_WS_OpenLegacy_helper_cls.setErrorResponse(code,message);
    }
    
    @isTest
    static void getJsonByStaticResource(){
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('Mock_Data_WS_OL_getJsonByStaticResource');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');        
        // Set the mock callout mode
        Test.setMock(HttpCalloutMock.class, mock);
        String  name= 'name';
        String message = 'hola';
        // Takedown_WS_OpenLegacy_helper_cls.getJsonByStaticResource(name,message);
    }
    @isTest
    static void execute_Token(){
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('Mock_Data_WS_OL_getToken');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');        
        // Set the mock callout mode
        Test.setMock(HttpCalloutMock.class, mock);
        Takedown_WS_OpenLegacy_helper_cls.execute_Token();
    }
    
}