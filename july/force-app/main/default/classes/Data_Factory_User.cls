@IStest
public class Data_Factory_User {
	public static User createNewUser(){
        User u = new User(
             ProfileId = [SELECT Id FROM Profile WHERE Name = 'Administrator'].Id,
             LastName = 'MonoDePruebas',
             Email = 'mono@pruebas.com',
             Username = 'mono@pruebas.com' + System.currentTimeMillis(),
             CompanyName = 'Engen',
             Title = 'Ingeniero',
             Alias = 'alias',
             TimeZoneSidKey = 'America/Los_Angeles',
             EmailEncodingKey = 'UTF-8',
             LanguageLocaleKey = 'en_US',
             LocaleSidKey = 'en_US',
             UserRoleId = [SELECT Id, Name FROM UserRole where name  = 'Chief Operations Officer'].Id
        );
        insert u;
        return u;
    }
    public static User createInsuranceNewUser(){
        User u = new User(
             ProfileId = [SELECT Id FROM Profile WHERE Name = 'Insurance'].Id,
             LastName = 'MonoDePruebas',
             Email = 'mono@pruebas.com',
             Username = 'mono@pruebas.com' + System.currentTimeMillis(),
             CompanyName = 'Engen',
             Title = 'Ingeniero',
             Alias = 'alias',
             TimeZoneSidKey = 'America/Los_Angeles',
             EmailEncodingKey = 'UTF-8',
             LanguageLocaleKey = 'en_US',
             LocaleSidKey = 'en_US',
             UserRoleId = [SELECT Id, Name FROM UserRole where name  = 'Chief Operations Officer'].Id
        );
        insert u;
        return u;
    }
    
}