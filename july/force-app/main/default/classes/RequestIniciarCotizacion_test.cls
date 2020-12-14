@Istest
public class RequestIniciarCotizacion_test {
    @istest
    static void getUser(){
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User' or Name ='Usuario estándar']; 
        User u = new User(Alias = 'standt', Email='standarduser@testorgkl.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@testorgkl.com.test.eng');
            test.startTest();
        System.runAs(u) {
            User usuario = RequestIniciarCotizacion.getUser(u.id);
            
            
        }
        test.stopTest();
        
    }
    
    
  	@Istest
    static void RequestIniciarCotizaciontest(){
        RequestIniciarCotizacion crequn = new RequestIniciarCotizacion('12323', '123123');
        
    }
    

}