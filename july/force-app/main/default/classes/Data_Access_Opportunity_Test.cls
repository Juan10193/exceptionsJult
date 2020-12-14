@isTest
public class Data_Access_Opportunity_Test {
    @isTest static void getOpportunityByContentVersion_Test(){
        Data_Access_Opportunity_cls Ejemplo = new Data_Access_Opportunity_cls();
        Profile p = [SELECT Id FROM Profile WHERE Name='Administrator']; 
        User u = new User(Alias = 'standt', Email='standarduser@testorgkl.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@testorgkl.com.test.eng');
        System.runAs(u) {
            System.debug('Current User: ' + UserInfo.getUserName());
            System.debug('Current Profile: ' + UserInfo.getProfileId()); 
            Opportunity opp = Data_Factory_Opportunity_Test.createNewOpportunityTypeWK();
        	System.debug('Oportunidad creada: '+ opp);
        	set<id> setIds = new set<id>();
        	setIds.add(opp.Id);
        	Data_Access_Opportunity_cls.getOpportunityByContentVersion(setIds); 
        }
    }
    @isTest static void getFundedDateByAccountID(){
        Data_Access_Opportunity_cls Ejemplo = new Data_Access_Opportunity_cls();
        Profile p = [SELECT Id FROM Profile WHERE Name='Administrator']; 
        User u = new User(Alias = 'standt', Email='standarduser@testorgkl.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@testorgkl.com.test.eng');
        System.runAs(u) {
            System.debug('Current User: ' + UserInfo.getUserName());
            System.debug('Current Profile: ' + UserInfo.getProfileId()); 
            Opportunity opp = Data_Factory_Opportunity_Test.createNewOpportunityTypeSales();
        	System.debug('Oportunidad creada: '+ opp);
        	set<id> setIds = new set<id>();
        	setIds.add(opp.AccountId);
        	Data_Access_Opportunity_cls.getFundedDateByAccountID(setIds); 
        }
    }
    @isTest static void getOpportunityById_Test(){
        Profile p = [SELECT Id FROM Profile WHERE Name='Administrator']; 
        User u = new User(Alias = 'standt', Email='standarduser@testorgkl.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@testorgkl.com.test.eng');
        System.runAs(u) {
            System.debug('Current User: ' + UserInfo.getUserName());
            System.debug('Current Profile: ' + UserInfo.getProfileId()); 
            Opportunity opp = Data_Factory_Opportunity_Test.createNewOpportunityTypeWK();
        	System.debug('Oportunidad creada: '+ opp);
        	opp = Data_Access_Opportunity_cls.getOpportunityById(opp.Id); 
        }
    }
    @isTest static void getOpportunityBySetOppId(){
        Data_Access_Opportunity_cls Ejemplo = new Data_Access_Opportunity_cls();
        Profile p = [SELECT Id FROM Profile WHERE Name='Administrator']; 
        User u = new User(Alias = 'standt', Email='standarduser@testorgkl.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@testorgkl.com.test.eng');
        System.runAs(u) {
            System.debug('Current User: ' + UserInfo.getUserName());
            System.debug('Current Profile: ' + UserInfo.getProfileId()); 
            Opportunity opp = Data_Factory_Opportunity_Test.createNewOpportunityTypeWK();
        	System.debug('Oportunidad creada: '+ opp);
        	set<id> setIds = new set<id>();
        	setIds.add(opp.Id);
        	Data_Access_Opportunity_cls.getOpportunityBySetOppId(setIds); 
        }
    }
    @isTest static void getOpportunityById(){
        Data_Access_Opportunity_cls Ejemplo = new Data_Access_Opportunity_cls();
        Profile p = [SELECT Id FROM Profile WHERE Name='Administrator']; 
        User u = new User(Alias = 'standt', Email='standarduser@testorgkl.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@testorgkl.com.test.eng');
        System.runAs(u) {
            System.debug('Current User: ' + UserInfo.getUserName());
            System.debug('Current Profile: ' + UserInfo.getProfileId()); 
            Opportunity opp = Data_Factory_Opportunity_Test.createNewOpportunityTypeWK();
        	Data_Access_Opportunity_cls.getOpportunityById(opp.Id); 
        }
    }
    @isTest static void getOpportunityById_NotAccess_Test(){
        Profile p = [SELECT Id FROM Profile WHERE Name='Generic']; 
        User u = new User(Alias = 'standt', Email='standarduser@testorgkl.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@testorgkl.com.test.eng');
        System.runAs(u) {
            System.debug('Current User: ' + UserInfo.getUserName());
            System.debug('Current Profile: ' + UserInfo.getProfileId()); 
            Opportunity opp = Data_Factory_Opportunity_Test.createNewOpportunityTypeWK();
        	System.debug('Oportinidad creada: '+ opp);
            opp.Id = null;
            insert opp;
        	opp = Data_Access_Opportunity_cls.getOpportunityById(opp.Id);
        }
    }
}