@isTest
public class TBO020_cvf_NewTakedown_tst {
    public static testMethod void testCancel() {
        test.startTest();
        
        User currentUser = TestDataFactory_tst.createUser('test@engenium.com', 'Generic', 'Sales Rep 1');
        
        System.runAs(currentUser) { 
            Account accnt = TestDataFactory_tst.createAccount();
            
            TBO022_Competitor__c competitor = TestDataFactory_tst.createCompetitor();
            
            Opportunity opp = TestDataFactory_tst.createOpportunity(accnt, currentUser, competitor);
            
            PageReference newTakedownPg = new PageReference('/apex/TBO020_pvf_NewTakedown');
            ApexPages.currentPage().getParameters().put('id', opp.Id);
            
            TBO020_cvf_NewTakedown newTakedownCtrl = new TBO020_cvf_NewTakedown();
                        
            PageReference rtrnPage = newTakedownCtrl.btnCancel();
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
            
            PageReference newTakedownPg = new PageReference('/apex/TBO020_pvf_NewTakedown');
            ApexPages.currentPage().getParameters().put('id', opp.Id);
            
            TBO020_cvf_NewTakedown newTakedownCtrl = new TBO020_cvf_NewTakedown();
                        
            newTakedownCtrl.selectedPricingsLeft = new List<Id> {pricing.Id};
            newTakedownCtrl.selectedPricingsRight = new List<Id>();
            
            newTakedownCtrl.selectPricingClick();
            
            List<SelectOption> selectedPricings = newTakedownCtrl.getSelectedPricings();
            
            newTakedownCtrl.selectedPricingsRight = new List<Id> {pricing.Id};
            
            newTakedownCtrl.unselectPricingClick();
            
            List<SelectOption> unselectedPricings = newTakedownCtrl.getUnselectedPricings();
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
            
            PageReference newTakedownPg = new PageReference('/apex/TBO020_pvf_NewTakedown');
            ApexPages.currentPage().getParameters().put('id', opp.Id);
            
            TBO020_cvf_NewTakedown newTakedownCtrl = new TBO020_cvf_NewTakedown();
                        
            newTakedownCtrl.selectedPricingsLeft = new List<Id> {pricing.Id};
            newTakedownCtrl.selectedPricingsRight = new List<Id>();
            
            newTakedownCtrl.selectPricingClick();
            
            List<SelectOption> selectedPricings = newTakedownCtrl.getSelectedPricings();
            
            PageReference rtrnPage = newTakedownCtrl.btnSave();
        }
        
        test.stopTest();
    }
}