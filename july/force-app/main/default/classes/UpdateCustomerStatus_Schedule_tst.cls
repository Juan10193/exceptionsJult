@isTest
public with sharing class UpdateCustomerStatus_Schedule_tst {
    private static Account account;
    private static TBO001_AccountClassification__c accountClassification;
    private static User u;
    private static Map<String, String> statusRuleResultMap;
    
    static{
        Profile p = [SELECT Id FROM Profile WHERE Name='Administrator'];
        UserRole r = [SELECT Id FROM UserRole WHERE DeveloperName='Sales_Rep_1'];
         u = new User(Alias = 'standt', Email='standarduser@testorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, UserRoleId = r.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='admin@Enginum.com');
           insert u; 
    }
    
    private static void createData(){
        
        System.runAs(u) { 
            Account topParentAccount = TestDataFactory_tst.createAccount('Test Account 1', '123456');
            
            topParentAccount.ACC_tx_Account_Status__c = 'Active';
            
            update topParentAccount;
            
            Account childAccount = TestDataFactory_tst.createAccount('Account Test 2', '654321');
            
            childAccount.ACC_tx_Account_Status__c = 'Active';
            childAccount.ACC_rb_Top_Parent_Account__c = topParentAccount.Id;
            
            update childAccount;
            
            TBO022_Competitor__c competitor = TestDataFactory_tst.createCompetitor();
            
            Opportunity opp = TestDataFactory_tst.createOpportunity(topParentAccount, u, competitor);
            
            Opportunity opp2 = TestDataFactory_tst.createOpportunity(topParentAccount, u, competitor);
            
            Opportunity opp3 = TestDataFactory_tst.createOpportunity(childAccount, u, competitor);
            
            TBO020_Takedowns__c takedownForecast = TestDataFactory_tst.createTakedownForecast(opp, u, 'Funded');
            
            TBO020_Takedowns__c takedownForecast2 = TestDataFactory_tst.createTakedownForecast(opp, u, 'Funded');
            
            TBO020_Takedowns__c takedownForecast3 = TestDataFactory_tst.createTakedownForecast(opp2, u, 'Funded');
            
            TBO020_Takedowns__c takedownForecast4 = TestDataFactory_tst.createTakedownForecast(opp3, u, 'Funded');
            
            TBO001_AccountClassification__c accClass = TestDataFactory_tst.createAccountClassification(topParentAccount, 'Tier Three');
            
            TBO001_AccountClassification__c accClass2 = TestDataFactory_tst.createAccountClassification(childAccount, 'Tier Three');
            
            statusRuleResultMap = new Map<String, String>();            
            statusRuleResultMap.put('Active', 'Active');
            
        }
    }
    
    private static testmethod void executeBatch(){
        test.startTest();
        
        system.runAs(u){
            createData();
            try{
                
                UpdateCustomerStatus_Schedule schUpdtCS = new UpdateCustomerStatus_Schedule();
                String schTime = '0 0 0 * * ?';
                System.schedule('Update Last Meeting Date', schTime, schUpdtCS);
                
                UpdateCustomerStatus_Batch batch=new UpdateCustomerStatus_Batch(statusRuleResultMap);
                Database.executeBatch(batch);
            }catch(Exception e){
                
            }
        }   
        
        test.stopTest();
    }
}