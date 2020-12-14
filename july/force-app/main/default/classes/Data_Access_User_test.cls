@istest
public class Data_Access_User_test {
    @istest
    static void getNullUser(){
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        User u = new User(Alias = 'standt', Email='standarduser@testorgkl.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@testorgkl.com.test.eng');

        System.runAs(u) {
            User usuario = Data_Access_User_cls.getUser(null);
        }        
    }
    @istest
    static void getUser(){
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        User u = new User(Alias = 'standt', Email='standarduser@testorgkl.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@testorgkl.com.test.eng');

        System.runAs(u) {
            User usuario = Data_Access_User_cls.getUser(u.id);
        }
        
    }
    
    @istest
    static void getWithOutUser(){
        Profile p = [SELECT Id FROM Profile WHERE Name='Chatter External User']; 
        User u = new User(Alias = 'standt', Email='standarduser@testorgkl.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@testorgkl.com.test.eng');

        System.runAs(u) {
            User usuario = Data_Access_User_cls.getUser(u.id);
        }
    }

}