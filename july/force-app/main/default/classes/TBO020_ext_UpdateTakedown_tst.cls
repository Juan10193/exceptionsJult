@isTest
public class TBO020_ext_UpdateTakedown_tst {
    public static testMethod void testCancel() {
        test.startTest();
        
        User currentUser = TestDataFactory_tst.createUser('test@engenium.com', 'Generic', 'Sales Rep 1');
        
        System.runAs(currentUser) { 
            Account accnt = TestDataFactory_tst.createAccount();
            
            TBO022_Competitor__c competitor = TestDataFactory_tst.createCompetitor();
            
            Opportunity opp = TestDataFactory_tst.createOpportunity(accnt, currentUser, competitor);
            
            TBO020_Takedowns__c takedown = TestDataFactory_tst.createTakedownForecast(opp, currentUser, 'New');
            
            ApexPages.StandardController sc = new ApexPages.StandardController(takedown);
            
            TBO020_ext_UpdateTakedown updateTakedownCtrl = new TBO020_ext_UpdateTakedown(sc);

            PageReference updateTakedownPg = Page.TBO020_pvf_UpdateTakedown;
            Test.setCurrentPage(updateTakedownPg);
                        
            PageReference rtrnPage = updateTakedownCtrl.btnCancel();
        }
        
        test.stopTest();
    }
    
    public static testMethod void testGetPricings() {
        test.startTest();
        
        User currentUser = TestDataFactory_tst.createUser('test@engenium.com', 'Generic', 'Sales Rep 1');
        
        System.runAs(currentUser) { 
            Account accnt = TestDataFactory_tst.createAccount();
            
            TBO022_Competitor__c competitor = TestDataFactory_tst.createCompetitor();
            
            Opportunity opp = TestDataFactory_tst.createOpportunity(accnt, currentUser, competitor);
            
            opp.StageName = 'Opportunity Identified';
            
            update opp;
            
            IST__SuperTRUMP_Template__c pricingTemplate = TestDataFactory_tst.createSTPricingTemplate();
            
            IST__SuperTRUMP_Pricing_Quote__c pricingQuote = TestDataFactory_tst.createSTPricingQuote(opp, pricingTemplate);
            
            TBO018_Pricing__c pricing = [SELECT Id FROM TBO018_Pricing__c WHERE TBO018_rb_SuperTRUMP_Pricing_Quote__c = :pricingQuote.Id];
            
            pricing.TBO018_tx_Pricing_Status__c = 'Approved';
            pricing.TBO018_ls_Type__c = 'Booking';
            
            update pricing;
            
            TBO020_Takedowns__c takedown = TestDataFactory_tst.createTakedownForecast(opp, currentUser, 'New');
            
            ApexPages.StandardController sc = new ApexPages.StandardController(takedown);
            
            TBO020_ext_UpdateTakedown updateTakedownCtrl = new TBO020_ext_UpdateTakedown(sc);

            PageReference updateTakedownPg = Page.TBO020_pvf_UpdateTakedown;
            Test.setCurrentPage(updateTakedownPg);
                        
            updateTakedownCtrl.selectedPricingsLeft = new List<Id> {pricing.Id};
            updateTakedownCtrl.selectedPricingsRight = new List<Id>();
            
            updateTakedownCtrl.selectPricingClick();
            
            List<SelectOption> selectedPricings = updateTakedownCtrl.getSelectedPricings();
            
            updateTakedownCtrl.selectedPricingsRight = new List<Id> {pricing.Id};
            
            updateTakedownCtrl.unselectPricingClick();
            
            List<SelectOption> unselectedPricings = updateTakedownCtrl.getUnselectedPricings();
        }
        
        test.stopTest();
    }
    
    
    
    public static testMethod void testSave() {
        test.startTest();
        
        User currentUser = TestDataFactory_tst.createUser('test@engenium.com', 'Generic', 'Sales Rep 1');
        
        System.runAs(currentUser) { 
            Account accnt = TestDataFactory_tst.createAccount();
            
            TBO022_Competitor__c competitor = TestDataFactory_tst.createCompetitor();
            
            Opportunity opp = TestDataFactory_tst.createOpportunity(accnt, currentUser, competitor);
            
            opp.StageName = 'Opportunity Identified';
            
            update opp;
            
            IST__SuperTRUMP_Template__c pricingTemplate = TestDataFactory_tst.createSTPricingTemplate();
            
            IST__SuperTRUMP_Pricing_Quote__c pricingQuote = TestDataFactory_tst.createSTPricingQuote(opp, pricingTemplate);
            
            TBO018_Pricing__c pricing = [SELECT Id FROM TBO018_Pricing__c WHERE TBO018_rb_SuperTRUMP_Pricing_Quote__c = :pricingQuote.Id];
            
            pricing.TBO018_tx_Pricing_Status__c = 'Approved';
            pricing.TBO018_ls_Type__c = 'Booking';
            
            update pricing;
            
            TBO020_Takedowns__c takedown = TestDataFactory_tst.createTakedownForecast(opp, currentUser, 'New');
            
            ApexPages.StandardController sc = new ApexPages.StandardController(takedown);
            
            TBO020_ext_UpdateTakedown updateTakedownCtrl = new TBO020_ext_UpdateTakedown(sc);

            PageReference updateTakedownPg = Page.TBO020_pvf_UpdateTakedown;
            Test.setCurrentPage(updateTakedownPg);
            
            updateTakedownCtrl.selectedPricingsLeft = new List<Id> {pricing.Id};
            updateTakedownCtrl.selectedPricingsRight = new List<Id>();
            
            updateTakedownCtrl.selectPricingClick();
            
            List<SelectOption> selectedPricings = updateTakedownCtrl.getSelectedPricings();
            
            PageReference rtrnPage = updateTakedownCtrl.btnSave();
        }
        
        test.stopTest();
    }
}