@isTest
public class LWC_StreamingApiController_Test {
    @isTest static void getSessionId_Test(){
        Profile p = [SELECT Id FROM Profile WHERE Name='Administrator']; 
        User u = new User(Alias = 'standt', Email='standarduser@testorgkl.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@testorgkl.com.test.eng');
        System.runAs(u) {
            System.debug('Current User: ' + UserInfo.getUserName());
            System.debug('Current Profile: ' + UserInfo.getProfileId()); 
            System.debug('Ejemplo: '+ UserInfo.getSessionId()); 
        }
        LWC_StreamingApiController.getSessionId();
    }
}