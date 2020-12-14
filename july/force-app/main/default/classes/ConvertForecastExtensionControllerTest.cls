@Istest
private class ConvertForecastExtensionControllerTest {
    
    @iSTEST
    static void convertTest(){
        Takedowns_Contingency_plan__c a = new Takedowns_Contingency_plan__c();
        ApexPages.StandardController stdcontroller =new ApexPages.StandardController(a);
        ConvertForecastExtensionController forecast = new ConvertForecastExtensionController(stdcontroller);
     	forecast.converted='1';
		forecast.NewRecord();
        forecast.back();
        forecast.UserName ='Lol';
        
    }
    
    
}