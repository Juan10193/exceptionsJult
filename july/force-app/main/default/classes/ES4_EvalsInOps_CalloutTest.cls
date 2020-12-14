@isTest
private class ES4_EvalsInOps_CalloutTest {
    @IstEST static void testCallbackGetEvInOps(){
         Test.setMock(HttpCalloutMock.class, new MockHttptestCallbackGetEvInOps());
        string a ='http://160.34.7.97:70';
        string b ='123';
        string c ='44';
         Map<string,object> res =  ES4_EvalsInOps_Callout.CallbackGetEvInOps(a, b, c);
    }
    
    @IsTest static void testgetUrl(){
        ES4_EvalsInOps_Callout.getUrl();
    }
    
    @IsTest static void testgetSSO(){
        ES4_EvalsInOps_Callout.getSSO();
    }
    
    @IsTest static void testgetUrlInstance(){
        ES4_EvalsInOps_Callout.getUrlInstance();
    }
}