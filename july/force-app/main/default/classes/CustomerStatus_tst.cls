@isTest
public class CustomerStatus_tst {
    @isTest(SeeAllData=true)
    public static void testActive() {
        List<TBO001_AccountClassification__c> accountClassificationList;
        
        try {
            accountClassificationList = [SELECT Id, TBO001_ls_Customer_Status__c, TBO001_ls_Line_of_Business__c, TBO001_tx_Customer_Since__c, TBO001_rb_Account__c FROM TBO001_AccountClassification__c WHERE TBO001_rb_Account__r.ACC_tx_Account_Status__c = 'Active' LIMIT 2000];
        }
        catch (Exception exACList) {
            System.debug('Error: ' + exACList.getMessage() + ' (Line: ' + exACList.getLineNumber() + ').');
        }   
        
        test.startTest();         
        
        CustomerStatus_cls accClassCustomerStatus = new CustomerStatus_cls(accountClassificationList);
        
        accClassCustomerStatus.setAccountClassificationStatusFromList();
        
        test.stopTest();
    }
    
    @isTest(SeeAllData=true)
    public static void testNewCustomer() {
        List<TBO001_AccountClassification__c> accountClassificationList;
        
        try {
            accountClassificationList = [SELECT Id, TBO001_ls_Customer_Status__c, TBO001_ls_Line_of_Business__c, TBO001_tx_Customer_Since__c, TBO001_rb_Account__c FROM TBO001_AccountClassification__c WHERE TBO001_rb_Account__r.ACC_tx_Account_Status__c LIKE 'New Customer%' LIMIT 2000];
        }
        catch (Exception exACList) {
            System.debug('Error: ' + exACList.getMessage() + ' (Line: ' + exACList.getLineNumber() + ').');
        }   
        
        test.startTest();         
        
        CustomerStatus_cls accClassCustomerStatus = new CustomerStatus_cls(accountClassificationList);
        
        accClassCustomerStatus.setAccountClassificationStatusFromList();
        
        test.stopTest();
    }
    
    @isTest(SeeAllData=true)
    public static void testDormant() {
        List<TBO001_AccountClassification__c> accountClassificationList;
        
        try {
            accountClassificationList = [SELECT Id, TBO001_ls_Customer_Status__c, TBO001_ls_Line_of_Business__c, TBO001_tx_Customer_Since__c, TBO001_rb_Account__c FROM TBO001_AccountClassification__c WHERE TBO001_rb_Account__r.ACC_tx_Account_Status__c = 'Dormant' LIMIT 2000];
        }
        catch (Exception exACList) {
            System.debug('Error: ' + exACList.getMessage() + ' (Line: ' + exACList.getLineNumber() + ').');
        }   
        
        test.startTest();         
        
        CustomerStatus_cls accClassCustomerStatus = new CustomerStatus_cls(accountClassificationList);
        
        accClassCustomerStatus.setAccountClassificationStatusFromList();
        
        test.stopTest();
    }
    
    @isTest(SeeAllData=true)
    public static void testReactivated() {
        List<TBO001_AccountClassification__c> accountClassificationList;
        
        try {
            accountClassificationList = [SELECT Id, TBO001_ls_Customer_Status__c, TBO001_ls_Line_of_Business__c, TBO001_tx_Customer_Since__c, TBO001_rb_Account__c FROM TBO001_AccountClassification__c WHERE TBO001_rb_Account__r.ACC_tx_Account_Status__c = 'Reactivated' LIMIT 2000];
        }
        catch (Exception exACList) {
            System.debug('Error: ' + exACList.getMessage() + ' (Line: ' + exACList.getLineNumber() + ').');
        }   
        
        test.startTest();         
        
        CustomerStatus_cls accClassCustomerStatus = new CustomerStatus_cls(accountClassificationList);
        
        accClassCustomerStatus.setAccountClassificationStatusFromList();
        
        test.stopTest();
    }
    
    @isTest(SeeAllData=true)
    public static void testRecovered() {
        List<TBO001_AccountClassification__c> accountClassificationList;
        
        try {
            accountClassificationList = [SELECT Id, TBO001_ls_Customer_Status__c, TBO001_ls_Line_of_Business__c, TBO001_tx_Customer_Since__c, TBO001_rb_Account__c FROM TBO001_AccountClassification__c WHERE TBO001_rb_Account__r.ACC_tx_Account_Status__c = 'Recovered' LIMIT 2000];
        }
        catch (Exception exACList) {
            System.debug('Error: ' + exACList.getMessage() + ' (Line: ' + exACList.getLineNumber() + ').');
        }   
        
        test.startTest();         
        
        CustomerStatus_cls accClassCustomerStatus = new CustomerStatus_cls(accountClassificationList);
        
        accClassCustomerStatus.setAccountClassificationStatusFromList();
        
        test.stopTest();
    }
    
    @isTest(SeeAllData=true)
    public static void testLost() {
        List<TBO001_AccountClassification__c> accountClassificationList;
        
        try {
            accountClassificationList = [SELECT Id, TBO001_ls_Customer_Status__c, TBO001_ls_Line_of_Business__c, TBO001_tx_Customer_Since__c, TBO001_rb_Account__c FROM TBO001_AccountClassification__c WHERE TBO001_rb_Account__r.ACC_tx_Account_Status__c = 'Lost' LIMIT 2000];
        }
        catch (Exception exACList) {
            System.debug('Error: ' + exACList.getMessage() + ' (Line: ' + exACList.getLineNumber() + ').');
        }   
        
        test.startTest();         
        
        CustomerStatus_cls accClassCustomerStatus = new CustomerStatus_cls(accountClassificationList);
        
        accClassCustomerStatus.setAccountClassificationStatusFromList();
        
        test.stopTest();
    }
    
    @isTest(SeeAllData=true)
    public static void testProspect() {
        List<TBO001_AccountClassification__c> accountClassificationList;
        
        try {
            accountClassificationList = [SELECT Id, TBO001_ls_Customer_Status__c, TBO001_ls_Line_of_Business__c, TBO001_tx_Customer_Since__c, TBO001_rb_Account__c FROM TBO001_AccountClassification__c WHERE TBO001_rb_Account__r.ACC_tx_Account_Status__c = 'Prospect' LIMIT 2000];
        }
        catch (Exception exACList) {
            System.debug('Error: ' + exACList.getMessage() + ' (Line: ' + exACList.getLineNumber() + ').');
        }   
        
        test.startTest();         
        
        CustomerStatus_cls accClassCustomerStatus = new CustomerStatus_cls(accountClassificationList);
        
        accClassCustomerStatus.setAccountClassificationStatusFromList();
        
        test.stopTest();
    }
    
    /**
    public static testMethod void testNoOpps() {
        User currentUser = TestDataFactory_tst.createUser('test@engenium.com', 'Generic', 'Sales Rep - México 1');
        
        System.runAs(currentUser) {
            Account topParentAccnt = TestDataFactory_tst.createAccount('Top Parent Account', '654321');
            
            Account accnt = TestDataFactory_tst.createAccount(topParentAccnt.Id);
            
            test.startTest();
            
            TBO001_AccountClassification__c accClass = TestDataFactory_tst.createAccountClassification(accnt, 'Tier One');
            
            test.stopTest(); 
        }
    }
    
    public static testMethod void testWithOpp() {
        User currentUser = TestDataFactory_tst.createUser('test@engenium.com', 'Generic', 'Sales Rep - México 1');
        
        System.runAs(currentUser) {
            Account topParentAccnt = TestDataFactory_tst.createAccount('Top Parent Account', '654321');
            
            Account accnt = TestDataFactory_tst.createAccount(topParentAccnt.Id);
            
            TBO022_Competitor__c competitor = TestDataFactory_tst.createCompetitor();
            
            Opportunity topParentOpp = TestDataFactory_tst.createOpportunity(topParentAccnt, currentUser, competitor);
            
            Opportunity opp = TestDataFactory_tst.createOpportunity(accnt, currentUser, competitor);
            
            TBO001_AccountClassification__c topParentAccClass = TestDataFactory_tst.createAccountClassification(topParentAccnt, 'Tier One');
            
            TBO001_AccountClassification__c accClass = TestDataFactory_tst.createAccountClassification(accnt, 'Tier One');
            
            test.startTest();
            
            //accClass.TBO001_ls_Line_of_Business__c = 'Technology';
            
            //update accClass;
            
            //accClass.TBO001_ls_Line_of_Business__c = 'Fleet';
            
            //update accClass;
            
            //accClass.TBO001_ls_Line_of_Business__c = 'Real Estate';
            
           	//update accClass;
            
            CustomerStatus_cls customerStatus = new CustomerStatus_cls(new List<TBO001_AccountClassification__c> {topParentAccClass, accClass});
            
            customerStatus.setAccountClassificationStatusFromList();
            
            test.stopTest();
        }
    }
    
    public static testMethod void testWithOpp_LBTechnology() {
        User currentUser = TestDataFactory_tst.createUser('test@engenium.com', 'Generic', 'Sales Rep - México 1', 'Technology');
        
        System.runAs(currentUser) {
            Account topParentAccnt = TestDataFactory_tst.createAccount('Top Parent Account', '654321');
            
            Account accnt = TestDataFactory_tst.createAccount(topParentAccnt.Id);
            
            TBO022_Competitor__c competitor = TestDataFactory_tst.createCompetitor();
            
            Opportunity topParentOpp = TestDataFactory_tst.createOpportunity(topParentAccnt, currentUser, competitor);
            
            TBO020_Takedowns__c topParentNewTakedown = TestDataFactory_tst.createTakedownForecast(topParentOpp, currentUser, 'Funded');
            
            Date topParentDeliveryDate = topParentNewTakedown.TBO020_fh_Delivery_Date__c;
            topParentDeliveryDate = topParentDeliveryDate.addDays(-5);
            
            topParentNewTakedown.TBO020_fh_Delivery_Date__c = topParentDeliveryDate;
            
            update topParentNewTakedown;
            
            TBO020_Takedowns__c topParentFundedTakedown = TestDataFactory_tst.createTakedownForecast(topParentOpp, currentUser, 'Funded');
            
            Opportunity opp = TestDataFactory_tst.createOpportunity(accnt, currentUser, competitor);
            
            opp.OPP_ls_Line_of_Business__c = 'Technology';
            
            update opp;
            
            TBO020_Takedowns__c newTakedown = TestDataFactory_tst.createTakedownForecast(opp, currentUser, 'Funded');
            
            Date deliveryDate = newTakedown.TBO020_fh_Delivery_Date__c;
            deliveryDate = deliveryDate.addDays(-5);
            
            newTakedown.TBO020_fh_Delivery_Date__c = deliveryDate;
            
            update newTakedown;
            
            TBO001_AccountClassification__c accClass = TestDataFactory_tst.createAccountClassification(accnt, 'Tier One', 'Technology'); 
            
            test.startTest();
            
            CustomerStatus_cls customerStatus = new CustomerStatus_cls(new List<TBO001_AccountClassification__c> {accClass});
            
            customerStatus.setAccountClassificationStatusFromList();
            
            test.stopTest();
        }
    }
    
    public static testMethod void testWithOpp_LBFleet() {
        User currentUser = TestDataFactory_tst.createUser('test@engenium.com', 'Generic', 'Sales Rep - México 1', 'Fleet');
        
        System.runAs(currentUser) {
            Account topParentAccnt = TestDataFactory_tst.createAccount('Top Parent Account', '654321');
            
            Account accnt = TestDataFactory_tst.createAccount(topParentAccnt.Id);
            
            TBO022_Competitor__c competitor = TestDataFactory_tst.createCompetitor();
            
            Opportunity topParentOpp = TestDataFactory_tst.createOpportunity(topParentAccnt, currentUser, competitor);
            
            TBO020_Takedowns__c topParentNewTakedown = TestDataFactory_tst.createTakedownForecast(topParentOpp, currentUser, 'Funded');
            
            Date topParentDeliveryDate = topParentNewTakedown.TBO020_fh_Delivery_Date__c;
            topParentDeliveryDate = topParentDeliveryDate.addDays(-5);
            
            topParentNewTakedown.TBO020_fh_Delivery_Date__c = topParentDeliveryDate;
            
            update topParentNewTakedown;
            
            TBO020_Takedowns__c topParentFundedTakedown = TestDataFactory_tst.createTakedownForecast(topParentOpp, currentUser, 'Funded');
            
            Opportunity opp = TestDataFactory_tst.createOpportunity(accnt, currentUser, competitor);
            
            opp.OPP_ls_Line_of_Business__c = 'Fleet';
            
            update opp;
            
            TBO020_Takedowns__c newTakedown = TestDataFactory_tst.createTakedownForecast(opp, currentUser, 'Funded');
            
            Date deliveryDate = newTakedown.TBO020_fh_Delivery_Date__c;
            deliveryDate = deliveryDate.addDays(-5);
            
            newTakedown.TBO020_fh_Delivery_Date__c = deliveryDate;
            
            update newTakedown;
            
            TBO001_AccountClassification__c accClass = TestDataFactory_tst.createAccountClassification(accnt, 'Tier One', 'Fleet'); 
            
            test.startTest();
            
            CustomerStatus_cls customerStatus = new CustomerStatus_cls(new List<TBO001_AccountClassification__c> {accClass});
            
            customerStatus.setAccountClassificationStatusFromList();
            
            test.stopTest();
        }
    }
    
    public static testMethod void testWithOpp_LBRealEstate() {
        User currentUser = TestDataFactory_tst.createUser('test@engenium.com', 'Generic', 'Sales Rep - México 1', 'Real Estate');
        
        System.runAs(currentUser) {
            Account topParentAccnt = TestDataFactory_tst.createAccount('Top Parent Account', '654321');
            
            Account accnt = TestDataFactory_tst.createAccount(topParentAccnt.Id);
            
            TBO022_Competitor__c competitor = TestDataFactory_tst.createCompetitor();
            
            Opportunity topParentOpp = TestDataFactory_tst.createOpportunity(topParentAccnt, currentUser, competitor);
            
            TBO020_Takedowns__c topParentNewTakedown = TestDataFactory_tst.createTakedownForecast(topParentOpp, currentUser, 'Funded');
            
            Date topParentDeliveryDate = topParentNewTakedown.TBO020_fh_Delivery_Date__c;
            topParentDeliveryDate = topParentDeliveryDate.addDays(-5);
            
            topParentNewTakedown.TBO020_fh_Delivery_Date__c = topParentDeliveryDate;
            
            update topParentNewTakedown;
            
            TBO020_Takedowns__c topParentFundedTakedown = TestDataFactory_tst.createTakedownForecast(topParentOpp, currentUser, 'Funded');
            
            Opportunity opp = TestDataFactory_tst.createOpportunity(accnt, currentUser, competitor);
            
            opp.OPP_ls_Line_of_Business__c = 'Real Estate';
            
            update opp;
            
            TBO020_Takedowns__c newTakedown = TestDataFactory_tst.createTakedownForecast(opp, currentUser, 'Funded');
            
            Date deliveryDate = newTakedown.TBO020_fh_Delivery_Date__c;
            deliveryDate = deliveryDate.addDays(-5);
            
            newTakedown.TBO020_fh_Delivery_Date__c = deliveryDate;
            
            update newTakedown;
            
            TBO001_AccountClassification__c accClass = TestDataFactory_tst.createAccountClassification(accnt, 'Tier One', 'Real Estate'); 
            
            test.startTest();
            
            CustomerStatus_cls customerStatus = new CustomerStatus_cls(new List<TBO001_AccountClassification__c> {accClass});
            
            customerStatus.setAccountClassificationStatusFromList();
            
            test.stopTest();
        }
    }
    
    public static testMethod void testWithOpp_MultipleAccounts() {
        User currentUser = TestDataFactory_tst.createUser('test@engenium.com', 'Generic', 'Sales Rep - México 1');
        
        System.runAs(currentUser) {
            Account topParentAccnt = TestDataFactory_tst.createAccount('Top Parent Account', '654321');
            
            Account accnt1 = TestDataFactory_tst.createAccount(topParentAccnt.Id);
            Account accnt2 = TestDataFactory_tst.createAccount(topParentAccnt.Id, 'Account Test 2', '642135');
            
            TBO022_Competitor__c competitor = TestDataFactory_tst.createCompetitor();
            
            Opportunity topParentOpp = TestDataFactory_tst.createOpportunity(topParentAccnt, currentUser, competitor);
            
            TBO020_Takedowns__c topParentNewTakedown = TestDataFactory_tst.createTakedownForecast(topParentOpp, currentUser, 'Funded');
            
            Date topParentDeliveryDate = topParentNewTakedown.TBO020_fh_Delivery_Date__c;
            topParentDeliveryDate = topParentDeliveryDate.addDays(-5);
            
            topParentNewTakedown.TBO020_fh_Delivery_Date__c = topParentDeliveryDate;
            
            update topParentNewTakedown;
            
            TBO020_Takedowns__c topParentFundedTakedown = TestDataFactory_tst.createTakedownForecast(topParentOpp, currentUser, 'Funded');
            
            Opportunity opp1 = TestDataFactory_tst.createOpportunity(accnt1, currentUser, competitor);
            
            Opportunity opp2 = TestDataFactory_tst.createOpportunity(accnt2, currentUser, competitor);
            
            TBO020_Takedowns__c newTakedown1 = TestDataFactory_tst.createTakedownForecast(opp1, currentUser, 'Funded');
            
            Date deliveryDate1 = newTakedown1.TBO020_fh_Delivery_Date__c;
            deliveryDate1 = deliveryDate1.addDays(-5);
            
            newTakedown1.TBO020_fh_Delivery_Date__c = deliveryDate1;
            
            update newTakedown1;
            
            TBO020_Takedowns__c newTakedown2 = TestDataFactory_tst.createTakedownForecast(opp2, currentUser, 'Funded');
            
            Date deliveryDate2 = newTakedown2.TBO020_fh_Delivery_Date__c;
            deliveryDate2 = deliveryDate2.addDays(-5);
            
            newTakedown2.TBO020_fh_Delivery_Date__c = deliveryDate2;
            
            update newTakedown2;
            
            List<Account> accntList = new List<Account> {accnt1, accnt2};
            
            List<TBO001_AccountClassification__c> accClassList = TestDataFactory_tst.createAccountClassificationList(accntList, 'Tier One');
            
            test.startTest();
            
            CustomerStatus_cls customerStatus = new CustomerStatus_cls(accClassList);
            
            customerStatus.setAccountClassificationStatusFromList();
            
            test.stopTest();
        }
    }
    
    public static testMethod void testWithOpp_ActiveAccount() {
        User currentUser = TestDataFactory_tst.createUser('test@engenium.com', 'Generic', 'Sales Rep - México 1');
        
        System.runAs(currentUser) {
            Account topParentAccnt = TestDataFactory_tst.createAccount('Top Parent Account', '654321');
            
            Account accnt = TestDataFactory_tst.createAccount(topParentAccnt.Id);
            
            TBO022_Competitor__c competitor = TestDataFactory_tst.createCompetitor();
            
            Opportunity topParentOpp = TestDataFactory_tst.createOpportunity(topParentAccnt, currentUser, competitor);
            
            TBO020_Takedowns__c topParentNewTakedown = TestDataFactory_tst.createTakedownForecast(topParentOpp, currentUser, 'Funded');
            
            Date topParentDeliveryDate = topParentNewTakedown.TBO020_fh_Delivery_Date__c;
            topParentDeliveryDate = topParentDeliveryDate.addDays(-5);
            
            topParentNewTakedown.TBO020_fh_Delivery_Date__c = topParentDeliveryDate;
            
            update topParentNewTakedown;
            
            TBO020_Takedowns__c topParentFundedTakedown = TestDataFactory_tst.createTakedownForecast(topParentOpp, currentUser, 'Funded');
            
            Opportunity opp = TestDataFactory_tst.createOpportunity(accnt, currentUser, competitor);
            
            TBO020_Takedowns__c newTakedown = TestDataFactory_tst.createTakedownForecast(opp, currentUser, 'Funded');
            
            Date deliveryDate = newTakedown.TBO020_fh_Delivery_Date__c;
            deliveryDate = deliveryDate.addMonths(-11);
            
            newTakedown.TBO020_fh_Delivery_Date__c = deliveryDate;
            
            update newTakedown;
            
            TBO001_AccountClassification__c accClass1 = TestDataFactory_tst.createAccountClassification(accnt, 'Tier One'); 
            
            TBO001_AccountClassification__c accClass2 = TestDataFactory_tst.createAccountClassification(accnt, 'Tier One'); 
            
            test.startTest();
            
            CustomerStatus_cls customerStatus = new CustomerStatus_cls(new List<TBO001_AccountClassification__c> {accClass1, accClass2});
            
            customerStatus.setAccountClassificationStatusFromList();
            
            accClass2.TBO001_ls_Line_of_Business__c = 'Technology'; 
            
            update accClass2;
            
            customerStatus = new CustomerStatus_cls(new List<TBO001_AccountClassification__c> {accClass1, accClass2});
            
            customerStatus.setAccountClassificationStatusFromList();
            
            test.stopTest();
        }
    }
    
    public static testMethod void testWithOpp_NewCustomerToECAccount() {
        User currentUser = TestDataFactory_tst.createUser('test@engenium.com', 'Generic', 'Sales Rep - México 1');
        
        System.runAs(currentUser) {
            Account topParentAccnt = TestDataFactory_tst.createAccount('Top Parent Account', '654321');
            
            Account accnt = TestDataFactory_tst.createAccount(topParentAccnt.Id);
            
            TBO022_Competitor__c competitor = TestDataFactory_tst.createCompetitor();
            
            Opportunity topParentOpp = TestDataFactory_tst.createOpportunity(topParentAccnt, currentUser, competitor);
            
            TBO020_Takedowns__c topParentNewTakedown = TestDataFactory_tst.createTakedownForecast(topParentOpp, currentUser, 'Funded');
            
            Date topParentDeliveryDate = topParentNewTakedown.TBO020_fh_Delivery_Date__c;
            topParentDeliveryDate = topParentDeliveryDate.addDays(-5);
            
            topParentNewTakedown.TBO020_fh_Delivery_Date__c = topParentDeliveryDate;
            
            update topParentNewTakedown;
            
            TBO020_Takedowns__c topParentFundedTakedown = TestDataFactory_tst.createTakedownForecast(topParentOpp, currentUser, 'Funded');
            
            Opportunity opp = TestDataFactory_tst.createOpportunity(accnt, currentUser, competitor);
            
            TBO020_Takedowns__c newTakedown = TestDataFactory_tst.createTakedownForecast(opp, currentUser, 'Funded');
            
            Date deliveryDate = newTakedown.TBO020_fh_Delivery_Date__c;
            deliveryDate = deliveryDate.addDays(-5);
            
            newTakedown.TBO020_fh_Delivery_Date__c = deliveryDate;
            
            update newTakedown;
            
            TBO001_AccountClassification__c accClass1 = TestDataFactory_tst.createAccountClassification(accnt, 'Tier One'); 
            
            TBO001_AccountClassification__c accClass2 = TestDataFactory_tst.createAccountClassification(accnt, 'Tier One'); 
            
            test.startTest();
            
            CustomerStatus_cls customerStatus = new CustomerStatus_cls(new List<TBO001_AccountClassification__c> {accClass1, accClass2});
            
            customerStatus.setAccountClassificationStatusFromList();
            
            accClass2.TBO001_ls_Line_of_Business__c = 'Technology'; 
            
            update accClass2;
            
            customerStatus = new CustomerStatus_cls(new List<TBO001_AccountClassification__c> {accClass1, accClass2});
            
            customerStatus.setAccountClassificationStatusFromList();
            
            test.stopTest();
        }
    }
    
	public static testMethod void testWithOpp_NewCustomerAccount() {
        User currentUser = TestDataFactory_tst.createUser('test@engenium.com', 'Generic', 'Sales Rep - México 1');
        
        System.runAs(currentUser) {
            Account topParentAccnt = TestDataFactory_tst.createAccount('Top Parent Account', '654321');
            
            Account accnt = TestDataFactory_tst.createAccount(topParentAccnt.Id);
            
            TBO022_Competitor__c competitor = TestDataFactory_tst.createCompetitor();
            
            Opportunity topParentOpp = TestDataFactory_tst.createOpportunity(topParentAccnt, currentUser, competitor);
            
            TBO020_Takedowns__c topParentNewTakedown = TestDataFactory_tst.createTakedownForecast(topParentOpp, currentUser, 'Funded');
            
            Opportunity opp = TestDataFactory_tst.createOpportunity(accnt, currentUser, competitor);
            
            TBO020_Takedowns__c newTakedown = TestDataFactory_tst.createTakedownForecast(opp, currentUser, 'Funded');
            
            Date deliveryDate = newTakedown.TBO020_fh_Delivery_Date__c;
            deliveryDate = deliveryDate.addMonths(-37);
            
            newTakedown.TBO020_fh_Delivery_Date__c = deliveryDate;
            
            update newTakedown;
            
            TBO020_Takedowns__c fundedTakedown = TestDataFactory_tst.createTakedownForecast(opp, currentUser, 'Funded');
            
            TBO001_AccountClassification__c accClass1 = TestDataFactory_tst.createAccountClassification(accnt, 'Tier One');
            
            TBO001_AccountClassification__c accClass2 = TestDataFactory_tst.createAccountClassification(accnt, 'Tier One'); 
            
            test.startTest();
            
            CustomerStatus_cls customerStatus = new CustomerStatus_cls(new List<TBO001_AccountClassification__c> {accClass1, accClass2});
            
            customerStatus.setAccountClassificationStatusFromList();
            
            accClass2.TBO001_ls_Line_of_Business__c = 'Technology'; 
            
            update accClass2;
            
            customerStatus = new CustomerStatus_cls(new List<TBO001_AccountClassification__c> {accClass1, accClass2});
            
            customerStatus.setAccountClassificationStatusFromList();
            
            test.stopTest();
        }
    }
    
    public static testMethod void testWithOpp_LostAccount() {
        User currentUser = TestDataFactory_tst.createUser('test@engenium.com', 'Generic', 'Sales Rep - México 1');
        
        System.runAs(currentUser) {
            Account topParentAccnt = TestDataFactory_tst.createAccount('Top Parent Account', '654321');
            
            Account accnt = TestDataFactory_tst.createAccount(topParentAccnt.Id);
            
            accnt.ACC_un_Capex_Exposure__c = 0;
            accnt.ACC_un_Fleet_Exposure__c = 0;
            accnt.ACC_un_Technology_Exposure__c = 0;
            accnt.ACC_un_Total_Exposure__c = 0;
            
            update accnt;
            
            TBO022_Competitor__c competitor = TestDataFactory_tst.createCompetitor();
            
            Opportunity topParentOpp = TestDataFactory_tst.createOpportunity(topParentAccnt, currentUser, competitor);
            
            TBO020_Takedowns__c topParentNewTakedown = TestDataFactory_tst.createTakedownForecast(topParentOpp, currentUser, 'Funded');
            
            Opportunity opp = TestDataFactory_tst.createOpportunity(accnt, currentUser, competitor);
            
            TBO020_Takedowns__c newTakedown = TestDataFactory_tst.createTakedownForecast(opp, currentUser, 'Funded');
            
            Date deliveryDate = newTakedown.TBO020_fh_Delivery_Date__c;
            deliveryDate = deliveryDate.addMonths(-37);
            
            newTakedown.TBO020_fh_Delivery_Date__c = deliveryDate;
            
            update newTakedown;
            
            TBO020_Takedowns__c fundedTakedown = TestDataFactory_tst.createTakedownForecast(opp, currentUser, 'Funded');
            
            TBO001_AccountClassification__c accClass1 = TestDataFactory_tst.createAccountClassification(accnt, 'Tier One');
            
            TBO001_AccountClassification__c accClass2 = TestDataFactory_tst.createAccountClassification(accnt, 'Tier One'); 
            
            test.startTest();
            
            CustomerStatus_cls customerStatus = new CustomerStatus_cls(new List<TBO001_AccountClassification__c> {accClass1, accClass2});
            
            customerStatus.setAccountClassificationStatusFromList();
            
            accClass2.TBO001_ls_Line_of_Business__c = 'Technology'; 
            
            update accClass2;
            
            customerStatus = new CustomerStatus_cls(new List<TBO001_AccountClassification__c> {accClass1, accClass2});
            
            customerStatus.setAccountClassificationStatusFromList();
            
            test.stopTest();
        }
    }

    public static testMethod void testWithOpp_DormantAccount() {
        User currentUser = TestDataFactory_tst.createUser('test@engenium.com', 'Generic', 'Sales Rep - México 1');
        
        System.runAs(currentUser) {
            Account topParentAccnt = TestDataFactory_tst.createAccount('Top Parent Account', '654321');
            
            Account accnt = TestDataFactory_tst.createAccount(topParentAccnt.Id);
            
            accnt.ACC_tx_Account_Status__c = 'Dormant';
            
            update accnt;
            
            TBO022_Competitor__c competitor = TestDataFactory_tst.createCompetitor();
            
            Opportunity topParentOpp = TestDataFactory_tst.createOpportunity(topParentAccnt, currentUser, competitor);
            
            TBO020_Takedowns__c topParentNewTakedown = TestDataFactory_tst.createTakedownForecast(topParentOpp, currentUser, 'Funded');
            
            Opportunity opp = TestDataFactory_tst.createOpportunity(accnt, currentUser, competitor);
            
            TBO020_Takedowns__c newTakedown = TestDataFactory_tst.createTakedownForecast(opp, currentUser, 'Funded');
            
            Date deliveryDate = newTakedown.TBO020_fh_Delivery_Date__c;
            deliveryDate = deliveryDate.addMonths(-36);
            
            newTakedown.TBO020_fh_Delivery_Date__c = deliveryDate;
            
            update newTakedown;
            
            TBO020_Takedowns__c fundedTakedown = TestDataFactory_tst.createTakedownForecast(opp, currentUser, 'Funded');
            
            Date lastdeliveryDate = fundedTakedown.TBO020_fh_Delivery_Date__c;
            lastdeliveryDate = lastdeliveryDate.addMonths(-13);
            
            fundedTakedown.TBO020_fh_Delivery_Date__c = lastdeliveryDate;
            
            update fundedTakedown;
            
            TBO001_AccountClassification__c accClass1 = TestDataFactory_tst.createAccountClassification(accnt, 'Tier One'); 
            
            TBO001_AccountClassification__c accClass2 = TestDataFactory_tst.createAccountClassification(accnt, 'Tier One'); 
            
            test.startTest();
            
            CustomerStatus_cls customerStatus = new CustomerStatus_cls(new List<TBO001_AccountClassification__c> {accClass1, accClass2});
            
            customerStatus.setAccountClassificationStatusFromList();
            
            accClass2.TBO001_ls_Line_of_Business__c = 'Technology'; 
            
            update accClass2; 
            
            customerStatus = new CustomerStatus_cls(new List<TBO001_AccountClassification__c> {accClass1, accClass2});
            
            customerStatus.setAccountClassificationStatusFromList();            
            
            test.stopTest();
        }
    }
    
    public static testMethod void testWithOpp_RecoveredAccount() {
        User currentUser = TestDataFactory_tst.createUser('test@engenium.com', 'Generic', 'Sales Rep - México 1');
        
        System.runAs(currentUser) {
            Account topParentAccnt = TestDataFactory_tst.createAccount('Top Parent Account', '654321');
            
            Account accnt = TestDataFactory_tst.createAccount(topParentAccnt.Id);
            
            accnt.ACC_un_Capex_Exposure__c = 0;
            accnt.ACC_un_Fleet_Exposure__c = 0;
            accnt.ACC_un_Technology_Exposure__c = 0;
            accnt.ACC_un_Total_Exposure__c = 0;
            
            update accnt;
            
            TBO022_Competitor__c competitor = TestDataFactory_tst.createCompetitor();
            
            Opportunity topParentOpp = TestDataFactory_tst.createOpportunity(topParentAccnt, currentUser, competitor);
            
            TBO020_Takedowns__c topParentNewTakedown = TestDataFactory_tst.createTakedownForecast(topParentOpp, currentUser, 'Funded');
            
            Opportunity opp = TestDataFactory_tst.createOpportunity(accnt, currentUser, competitor);
            
            TBO020_Takedowns__c newTakedown = TestDataFactory_tst.createTakedownForecast(opp, currentUser, 'Funded');
            
            Date deliveryDate = newTakedown.TBO020_fh_Delivery_Date__c;
            deliveryDate = deliveryDate.addMonths(-35);
            
            newTakedown.TBO020_fh_Delivery_Date__c = deliveryDate;
            
            update newTakedown;
            
            TBO020_Takedowns__c fundedTakedown = TestDataFactory_tst.createTakedownForecast(opp, currentUser, 'Funded');
            
            fundedTakedown.TBO020_fh_Delivery_Date__c = Date.today();
            
            update fundedTakedown;
            
            TBO001_AccountClassification__c accClass1 = TestDataFactory_tst.createAccountClassification(accnt, 'Tier One'); 
            
            TBO001_AccountClassification__c accClass2 = TestDataFactory_tst.createAccountClassification(accnt, 'Tier One'); 
            
            test.startTest(); 
            
            CustomerStatus_cls customerStatus = new CustomerStatus_cls(new List<TBO001_AccountClassification__c> {accClass1, accClass2});
            
            customerStatus.setAccountClassificationStatusFromList();
            
            accnt.ACC_un_Capex_Exposure__c = 100;
            
            update accnt;
            
            accClass2.TBO001_ls_Region__c = 'Mexico 2';
            
            update accClass2;
            
            customerStatus = new CustomerStatus_cls(new List<TBO001_AccountClassification__c> {accClass1, accClass2});
            
            customerStatus.setAccountClassificationStatusFromList();
            
            test.stopTest();
        }
    }

    public static testMethod void testWithOpp_ReactivatedAccount() {
        User currentUser = TestDataFactory_tst.createUser('test@engenium.com', 'Generic', 'Sales Rep - México 1');
        
        System.runAs(currentUser) {
            Account topParentAccnt = TestDataFactory_tst.createAccount('Top Parent Account', '654321');
            
            Account accnt = TestDataFactory_tst.createAccount(topParentAccnt.Id);
            
            accnt.ACC_tx_Account_Status__c = 'Dormant';
            
            update accnt;
            
            TBO022_Competitor__c competitor = TestDataFactory_tst.createCompetitor();
            
            Opportunity topParentOpp = TestDataFactory_tst.createOpportunity(topParentAccnt, currentUser, competitor);
            
            TBO020_Takedowns__c topParentNewTakedown = TestDataFactory_tst.createTakedownForecast(topParentOpp, currentUser, 'Funded');
            
            Opportunity opp = TestDataFactory_tst.createOpportunity(accnt, currentUser, competitor);
            
            TBO020_Takedowns__c newTakedown = TestDataFactory_tst.createTakedownForecast(opp, currentUser, 'Funded');
            
            Date deliveryDate = newTakedown.TBO020_fh_Delivery_Date__c;
            deliveryDate = deliveryDate.addMonths(-36);
            
            newTakedown.TBO020_fh_Delivery_Date__c = deliveryDate;
            
            update newTakedown;
            
            TBO020_Takedowns__c fundedTakedown = TestDataFactory_tst.createTakedownForecast(opp, currentUser, 'Funded');
            
            Date lastdeliveryDate = fundedTakedown.TBO020_fh_Delivery_Date__c;
            lastdeliveryDate = lastdeliveryDate.addMonths(-13);
            
            fundedTakedown.TBO020_fh_Delivery_Date__c = lastdeliveryDate;
            
            update fundedTakedown;
            
            TBO001_AccountClassification__c accClass1 = TestDataFactory_tst.createAccountClassification(accnt, 'Tier One'); 
            
            TBO001_AccountClassification__c accClass2 = TestDataFactory_tst.createAccountClassification(accnt, 'Tier One'); 
            
            test.startTest();
            
            CustomerStatus_cls customerStatus = new CustomerStatus_cls(new List<TBO001_AccountClassification__c> {accClass1, accClass2});
            
            customerStatus.setAccountClassificationStatusFromList();
            
            accClass2.TBO001_ls_Line_of_Business__c = 'Technology'; 
            
            update accClass2; 
            
            customerStatus = new CustomerStatus_cls(new List<TBO001_AccountClassification__c> {accClass1, accClass2});
            
            customerStatus.setAccountClassificationStatusFromList();
            
            test.stopTest();
        }
    }

    public static testMethod void testWithOpp_ActiveTopAccount() {
        User currentUser = TestDataFactory_tst.createUser('test@engenium.com', 'Generic', 'Sales Rep - México 1');
        
        System.runAs(currentUser) {
            Account topParentAccnt = TestDataFactory_tst.createAccount('Top Parent Account', '654321');
            
            Account accnt = TestDataFactory_tst.createAccount(topParentAccnt.Id);
            
            TBO022_Competitor__c competitor = TestDataFactory_tst.createCompetitor();
            
            Opportunity topParentOpp = TestDataFactory_tst.createOpportunity(topParentAccnt, currentUser, competitor);
            
            TBO020_Takedowns__c topParentNewTakedown = TestDataFactory_tst.createTakedownForecast(topParentOpp, currentUser, 'Funded');
            
            Date topParentDeliveryDate = topParentNewTakedown.TBO020_fh_Delivery_Date__c;
            topParentDeliveryDate = topParentDeliveryDate.addMonths(-11);
            
            topParentNewTakedown.TBO020_fh_Delivery_Date__c = topParentDeliveryDate;
            
            update topParentNewTakedown;
            
            TBO001_AccountClassification__c accClass1 = TestDataFactory_tst.createAccountClassification(topParentAccnt, 'Tier One'); 
            
            TBO001_AccountClassification__c accClass2 = TestDataFactory_tst.createAccountClassification(topParentAccnt, 'Tier One'); 
            
            accClass2.TBO001_ls_Line_of_Business__c = 'Technology';
            
            update accClass2;
            
            test.startTest();
            
            CustomerStatus_cls customerStatus = new CustomerStatus_cls(new List<TBO001_AccountClassification__c> {accClass1, accClass2});
            
            customerStatus.setAccountClassificationStatusFromList();
            
            accnt.ACC_un_Total_Exposure__c = 100;
            
            update accnt;
            
            customerStatus = new CustomerStatus_cls(new List<TBO001_AccountClassification__c> {accClass1, accClass2});
            
            customerStatus.setAccountClassificationStatusFromList();
            
            test.stopTest();
        }
    }
    
    public static testMethod void testWithOpp_NewCustomerToECTopAccount() {
        User currentUser = TestDataFactory_tst.createUser('test@engenium.com', 'Generic', 'Sales Rep - México 1');
        
        System.runAs(currentUser) {
            Account topParentAccnt = TestDataFactory_tst.createAccount('Top Parent Account', '654321');
            
            Account accnt = TestDataFactory_tst.createAccount(topParentAccnt.Id);
            
            TBO022_Competitor__c competitor = TestDataFactory_tst.createCompetitor();
            
            Opportunity topParentOpp = TestDataFactory_tst.createOpportunity(topParentAccnt, currentUser, competitor);
            
            TBO020_Takedowns__c topParentNewTakedown = TestDataFactory_tst.createTakedownForecast(topParentOpp, currentUser, 'Funded');
            
            Date topParentDeliveryDate = topParentNewTakedown.TBO020_fh_Delivery_Date__c;
            topParentDeliveryDate = topParentDeliveryDate.addDays(-5);
            
            topParentNewTakedown.TBO020_fh_Delivery_Date__c = topParentDeliveryDate;
            
            update topParentNewTakedown;
            
            TBO001_AccountClassification__c accClass1 = TestDataFactory_tst.createAccountClassification(topParentAccnt, 'Tier One'); 
            
            TBO001_AccountClassification__c accClass2 = TestDataFactory_tst.createAccountClassification(topParentAccnt, 'Tier One'); 
            
            accClass2.TBO001_ls_Line_of_Business__c = 'Technology';
            
            update accClass2;
            
            test.startTest();
            
            CustomerStatus_cls customerStatus = new CustomerStatus_cls(new List<TBO001_AccountClassification__c> {accClass1, accClass2});
            
            customerStatus.setAccountClassificationStatusFromList();
            
            accnt.ACC_un_Total_Exposure__c = 100;
            
            update accnt;
            
            customerStatus = new CustomerStatus_cls(new List<TBO001_AccountClassification__c> {accClass1, accClass2});
            
            customerStatus.setAccountClassificationStatusFromList();
            
            test.stopTest();
        }
    }
    
    public static testMethod void testWithOpp_NewCustomerTopAccount() {
        User currentUser = TestDataFactory_tst.createUser('test@engenium.com', 'Generic', 'Sales Rep - México 1');
        
        System.runAs(currentUser) {
            Account topParentAccnt = TestDataFactory_tst.createAccount('Top Parent Account', '654321');
            
            Account accnt = TestDataFactory_tst.createAccount(topParentAccnt.Id);
            
            TBO022_Competitor__c competitor = TestDataFactory_tst.createCompetitor();
            
            Opportunity topParentOpp = TestDataFactory_tst.createOpportunity(topParentAccnt, currentUser, competitor);
            
            TBO020_Takedowns__c topParentNewTakedown = TestDataFactory_tst.createTakedownForecast(topParentOpp, currentUser, 'Funded');
            
            Date topParentDeliveryDate = topParentNewTakedown.TBO020_fh_Delivery_Date__c;
            topParentDeliveryDate = topParentDeliveryDate.addMonths(-37);
            
            topParentNewTakedown.TBO020_fh_Delivery_Date__c = topParentDeliveryDate;
            
            update topParentNewTakedown;
            
            TBO020_Takedowns__c fundedTakedown = TestDataFactory_tst.createTakedownForecast(topParentOpp, currentUser, 'Funded');
                        
            TBO001_AccountClassification__c accClass1 = TestDataFactory_tst.createAccountClassification(topParentAccnt, 'Tier One');
            
            TBO001_AccountClassification__c accClass2 = TestDataFactory_tst.createAccountClassification(topParentAccnt, 'Tier One'); 
            
            accClass2.TBO001_ls_Line_of_Business__c = 'Technology'; 
            
            update accClass2;
            
            test.startTest();
            
            CustomerStatus_cls customerStatus = new CustomerStatus_cls(new List<TBO001_AccountClassification__c> {accClass1, accClass2});
            
            customerStatus.setAccountClassificationStatusFromList();
            
            accnt.ACC_un_Total_Exposure__c = 100;
            
            update accnt;
            
            customerStatus = new CustomerStatus_cls(new List<TBO001_AccountClassification__c> {accClass1, accClass2});
            
            customerStatus.setAccountClassificationStatusFromList();
            
            test.stopTest();
        }
    }

    public static testMethod void testWithOpp_LostTopAccount() {
        User currentUser = TestDataFactory_tst.createUser('test@engenium.com', 'Generic', 'Sales Rep - México 1');
        
        System.runAs(currentUser) {
            Account topParentAccnt = TestDataFactory_tst.createAccount('Top Parent Account', '654321');
            
            topParentAccnt.ACC_un_Capex_Exposure__c = 0;
            topParentAccnt.ACC_un_Fleet_Exposure__c = 0;
            topParentAccnt.ACC_un_Technology_Exposure__c = 0;
            topParentAccnt.ACC_un_Total_Exposure__c = 0;
            
            update topParentAccnt;
            
            Account accnt = TestDataFactory_tst.createAccount(topParentAccnt.Id);
            
            TBO022_Competitor__c competitor = TestDataFactory_tst.createCompetitor();
            
            Opportunity topParentOpp = TestDataFactory_tst.createOpportunity(topParentAccnt, currentUser, competitor);
            
            TBO020_Takedowns__c topParentNewTakedown = TestDataFactory_tst.createTakedownForecast(topParentOpp, currentUser, 'Funded');
            
            Date topParentDeliveryDate = topParentNewTakedown.TBO020_fh_Delivery_Date__c;
            topParentDeliveryDate = topParentDeliveryDate.addMonths(-37);
            
            topParentNewTakedown.TBO020_fh_Delivery_Date__c = topParentDeliveryDate;
            
            update topParentNewTakedown;
            
            TBO020_Takedowns__c topParentFundedTakedown = TestDataFactory_tst.createTakedownForecast(topParentOpp, currentUser, 'Funded');
            
            TBO001_AccountClassification__c accClass1 = TestDataFactory_tst.createAccountClassification(topParentAccnt, 'Tier One');
            
            TBO001_AccountClassification__c accClass2 = TestDataFactory_tst.createAccountClassification(topParentAccnt, 'Tier One'); 
            
            accClass2.TBO001_ls_Line_of_Business__c = 'Technology'; 
            
            update accClass2;
            
            test.startTest();
            
            CustomerStatus_cls customerStatus = new CustomerStatus_cls(new List<TBO001_AccountClassification__c> {accClass1, accClass2});
            
            customerStatus.setAccountClassificationStatusFromList();
            
            accnt.ACC_un_Total_Exposure__c = 100;
            
            update accnt;
            
            customerStatus = new CustomerStatus_cls(new List<TBO001_AccountClassification__c> {accClass1, accClass2});
            
            customerStatus.setAccountClassificationStatusFromList();
            
            test.stopTest();
        }
    }
    
    public static testMethod void testWithOpp_DormantTopAccount() {
        User currentUser = TestDataFactory_tst.createUser('test@engenium.com', 'Generic', 'Sales Rep - México 1');
        
        System.runAs(currentUser) {
            Account topParentAccnt = TestDataFactory_tst.createAccount('Top Parent Account', '654321');
            
            Account accnt = TestDataFactory_tst.createAccount(topParentAccnt.Id);
            
            accnt.ACC_tx_Account_Status__c = 'Dormant';
            
            update accnt;
            
            TBO022_Competitor__c competitor = TestDataFactory_tst.createCompetitor();
            
            Opportunity topParentOpp = TestDataFactory_tst.createOpportunity(topParentAccnt, currentUser, competitor);
            
            TBO020_Takedowns__c topParentNewTakedown = TestDataFactory_tst.createTakedownForecast(topParentOpp, currentUser, 'Funded');
            
            Date topParentDeliveryDate = topParentNewTakedown.TBO020_fh_Delivery_Date__c;
            topParentDeliveryDate = topParentDeliveryDate.addMonths(-36);
            
            topParentNewTakedown.TBO020_fh_Delivery_Date__c = topParentDeliveryDate;
            
            update topParentNewTakedown;
            
            TBO020_Takedowns__c topParentFundedTakedown = TestDataFactory_tst.createTakedownForecast(topParentOpp, currentUser, 'Funded');
            
            Date topParentLastdeliveryDate = topParentFundedTakedown.TBO020_fh_Delivery_Date__c;
            topParentLastdeliveryDate = topParentLastdeliveryDate.addMonths(-13);
            
            topParentFundedTakedown.TBO020_fh_Delivery_Date__c = topParentLastdeliveryDate;
            
            update topParentFundedTakedown;
            
            TBO001_AccountClassification__c accClass1 = TestDataFactory_tst.createAccountClassification(topParentAccnt, 'Tier One'); 
            
            TBO001_AccountClassification__c accClass2 = TestDataFactory_tst.createAccountClassification(topParentAccnt, 'Tier One'); 
            
            accClass2.TBO001_ls_Line_of_Business__c = 'Technology'; 
            
            update accClass2; 
            
            test.startTest();
            
            CustomerStatus_cls customerStatus = new CustomerStatus_cls(new List<TBO001_AccountClassification__c> {accClass1, accClass2});
            
            customerStatus.setAccountClassificationStatusFromList();
            
            accnt.ACC_un_Total_Exposure__c = 100;
            
            update accnt;
            
            customerStatus = new CustomerStatus_cls(new List<TBO001_AccountClassification__c> {accClass1, accClass2});
            
            customerStatus.setAccountClassificationStatusFromList();
            
            test.stopTest();
        }
    }
	
    public static testMethod void testWithOpp_RecoveredTopAccount() {
        User currentUser = TestDataFactory_tst.createUser('test@engenium.com', 'Generic', 'Sales Rep - México 1');
        
        System.runAs(currentUser) {
            Account topParentAccnt = TestDataFactory_tst.createAccount('Top Parent Account', '654321');
            
            topParentAccnt.ACC_un_Capex_Exposure__c = 0;
            topParentAccnt.ACC_un_Fleet_Exposure__c = 0;
            topParentAccnt.ACC_un_Technology_Exposure__c = 0;
            topParentAccnt.ACC_un_Total_Exposure__c = 0;
            
            update topParentAccnt;
            
            Account accnt = TestDataFactory_tst.createAccount(topParentAccnt.Id);
            
            TBO022_Competitor__c competitor = TestDataFactory_tst.createCompetitor();
            
            Opportunity topParentOpp = TestDataFactory_tst.createOpportunity(topParentAccnt, currentUser, competitor);
            
            TBO020_Takedowns__c topParentNewTakedown = TestDataFactory_tst.createTakedownForecast(topParentOpp, currentUser, 'Funded');
            
            Date topParentDeliveryDate = topParentNewTakedown.TBO020_fh_Delivery_Date__c;
            topParentDeliveryDate = topParentDeliveryDate.addMonths(-35);
            
            topParentNewTakedown.TBO020_fh_Delivery_Date__c = topParentDeliveryDate;
            
            update topParentNewTakedown;
            
            TBO020_Takedowns__c topParentFundedTakedown = TestDataFactory_tst.createTakedownForecast(topParentOpp, currentUser, 'Funded');
            
            topParentFundedTakedown.TBO020_fh_Delivery_Date__c = Date.today();
            
            update topParentFundedTakedown;
            
            TBO001_AccountClassification__c accClass1 = TestDataFactory_tst.createAccountClassification(topParentAccnt, 'Tier One'); 
            
            TBO001_AccountClassification__c accClass2 = TestDataFactory_tst.createAccountClassification(topParentAccnt, 'Tier One');  
            
            topParentAccnt.ACC_un_Capex_Exposure__c = 100;
            
            update topParentAccnt;
            
            test.startTest();
            
            CustomerStatus_cls customerStatus = new CustomerStatus_cls(new List<TBO001_AccountClassification__c> {accClass1, accClass2});
            
            customerStatus.setAccountClassificationStatusFromList();
            
            accClass2.TBO001_ls_Region__c = 'Mexico 2';
            
            update accClass2;
            
            customerStatus = new CustomerStatus_cls(new List<TBO001_AccountClassification__c> {accClass1, accClass2});
            
            customerStatus.setAccountClassificationStatusFromList();
            
            accnt.ACC_un_Total_Exposure__c = 100;
            
            update accnt;
            
            customerStatus = new CustomerStatus_cls(new List<TBO001_AccountClassification__c> {accClass1, accClass2});
            
            customerStatus.setAccountClassificationStatusFromList();
            
            test.stopTest();
        }
    }
    
    public static testMethod void testWithOpp_ReactivatedTopAccount() {
        User currentUser = TestDataFactory_tst.createUser('test@engenium.com', 'Generic', 'Sales Rep - México 1');
        
        System.runAs(currentUser) {
            Account topParentAccnt = TestDataFactory_tst.createAccount('Top Parent Account', '654321');
            
            topParentAccnt.ACC_tx_Account_Status__c = 'Dormant';
            
            update topParentAccnt;
            
            Account accnt = TestDataFactory_tst.createAccount(topParentAccnt.Id);
            
            TBO022_Competitor__c competitor = TestDataFactory_tst.createCompetitor();
            
            Opportunity topParentOpp = TestDataFactory_tst.createOpportunity(topParentAccnt, currentUser, competitor);
            
            TBO020_Takedowns__c topParentNewTakedown = TestDataFactory_tst.createTakedownForecast(topParentOpp, currentUser, 'Funded');
            
            Date topParentDeliveryDate = topParentNewTakedown.TBO020_fh_Delivery_Date__c;
            topParentDeliveryDate = topParentDeliveryDate.addMonths(-36);
            
            topParentNewTakedown.TBO020_fh_Delivery_Date__c = topParentDeliveryDate;
            
            update topParentNewTakedown;
            
            TBO020_Takedowns__c topParentFundedTakedown = TestDataFactory_tst.createTakedownForecast(topParentOpp, currentUser, 'Funded');
            
            Date topParentLastdeliveryDate = topParentFundedTakedown.TBO020_fh_Delivery_Date__c;
            topParentLastdeliveryDate = topParentLastdeliveryDate.addMonths(-13);
            
            topParentFundedTakedown.TBO020_fh_Delivery_Date__c = topParentLastdeliveryDate;
            
            update topParentFundedTakedown;
            
            TBO001_AccountClassification__c accClass1 = TestDataFactory_tst.createAccountClassification(topParentAccnt, 'Tier One'); 
            
            TBO001_AccountClassification__c accClass2 = TestDataFactory_tst.createAccountClassification(topParentAccnt, 'Tier One'); 
            
            accClass2.TBO001_ls_Line_of_Business__c = 'Technology'; 
            
            update accClass2; 
            
            test.startTest();
            
            CustomerStatus_cls customerStatus = new CustomerStatus_cls(new List<TBO001_AccountClassification__c> {accClass1, accClass2});
            
            customerStatus.setAccountClassificationStatusFromList();
            
            accnt.ACC_un_Total_Exposure__c = 100;
            
            update accnt;
            
            customerStatus = new CustomerStatus_cls(new List<TBO001_AccountClassification__c> {accClass1, accClass2});
            
            customerStatus.setAccountClassificationStatusFromList();
            
            test.stopTest();
        }
    }
	*/
}