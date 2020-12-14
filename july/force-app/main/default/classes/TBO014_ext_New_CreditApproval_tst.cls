@isTest
public class TBO014_ext_New_CreditApproval_tst {
    public static testMethod void testCancel() {
        test.startTest();
        
        User currentUser = TestDataFactory_tst.createUser('test@engenium.com', 'Generic', 'Sales Rep 1');
        
        System.runAs(currentUser) { 
            Account accnt = TestDataFactory_tst.createAccount();
            
            TBO022_Competitor__c competitor = TestDataFactory_tst.createCompetitor();
            
            Opportunity opp = TestDataFactory_tst.createOpportunity(accnt, currentUser, competitor);
            
            TBO014_Credit_Approval__c creditApproval = new TBO014_Credit_Approval__c();
            
            ApexPages.StandardController sc = new ApexPages.StandardController(creditApproval);
            
            TBO014_ext_New_CreditApproval newCreditApprovalCtrl = new TBO014_ext_New_CreditApproval(sc);

            PageReference newCreditApprovalPg = Page.TBO014_pvf_New_CreditApproval;
            Test.setCurrentPage(newCreditApprovalPg);
            ApexPages.currentPage().getParameters().put('account', accnt.Id);
                        
            PageReference rtrnPage = newCreditApprovalCtrl.btnCancel();
        }
        
        test.stopTest();
    }
    
    public static testMethod void testGetOpps() {
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
            
            update pricing;
            
            opp.StageName = 'Proposal';
            
            update opp;
            
            opp.StageName = 'Proposal Awarded';
            
            update opp;
            
            TBO014_Credit_Approval__c creditApproval = new TBO014_Credit_Approval__c();
            
            PageReference newCreditApprovalPg = Page.TBO014_pvf_New_CreditApproval;
            Test.setCurrentPage(newCreditApprovalPg);
            ApexPages.currentPage().getParameters().put('account', accnt.Id);
            
            ApexPages.StandardController sc = new ApexPages.StandardController(creditApproval);
            
            TBO014_ext_New_CreditApproval newCreditApprovalCtrl = new TBO014_ext_New_CreditApproval(sc);
            
            newCreditApprovalCtrl.selectedOpportunitiesLeft = new List<Id> {opp.Id};
            
            newCreditApprovalCtrl.selectOpportunityClick();
            
            List<SelectOption> selectedOpps = newCreditApprovalCtrl.getSelectedOpportunities();
            
            newCreditApprovalCtrl.selectedOpportunitiesRight = new List<Id> {opp.Id};
            
            newCreditApprovalCtrl.unselectOpportunityClick();
                        
            List<SelectOption> unselectedOpps = newCreditApprovalCtrl.getUnselectedOpportunities();
            
            newCreditApprovalCtrl.selectedOpportunitiesLeft = new List<Id> {opp.Id};
            
            newCreditApprovalCtrl.selectOpportunityClick();
            
            selectedOpps = newCreditApprovalCtrl.getSelectedOpportunities();
            
            newCreditApprovalCtrl.unselectOpportunityClick();
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
            
            update pricing;
            
            opp.StageName = 'Proposal';
            
            update opp;
            
            opp.StageName = 'Proposal Awarded';
            
            update opp;
            
            TBO014_Credit_Approval__c creditApproval = new TBO014_Credit_Approval__c();
            
            PageReference newCreditApprovalPg = Page.TBO014_pvf_New_CreditApproval;
            Test.setCurrentPage(newCreditApprovalPg);
            ApexPages.currentPage().getParameters().put('account', accnt.Id);
            
            ApexPages.StandardController sc = new ApexPages.StandardController(creditApproval);
            
            TBO014_ext_New_CreditApproval newCreditApprovalCtrl = new TBO014_ext_New_CreditApproval(sc);
            
            newCreditApprovalCtrl.selectedOpportunitiesLeft = new List<Id> {opp.Id};
            
            newCreditApprovalCtrl.selectOpportunityClick();
            
            List<SelectOption> selectedOpps = newCreditApprovalCtrl.getSelectedOpportunities();
            
            List<SelectOption> unselectedPricings = newCreditApprovalCtrl.getUnselectedPricings();
            
            newCreditApprovalCtrl.selectedPricingsLeft = new List<Id> {pricing.Id};
            
            newCreditApprovalCtrl.selectPricingClick();
            
            List<SelectOption> selectedPricings = newCreditApprovalCtrl.getSelectedPricings();
            
            newCreditApprovalCtrl.selectedPricingsRight = new List<Id> {pricing.Id};
            
            newCreditApprovalCtrl.unselectPricingClick();
        }
        
        test.stopTest();
    }
    
    public static testMethod void testOpp_Pricing_Exceptions() {
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
            
            update pricing;
            
            opp.StageName = 'Proposal';
            
            update opp;
            
            opp.StageName = 'Proposal Awarded';
            
            update opp;
            
            TBO014_Credit_Approval__c creditApproval = new TBO014_Credit_Approval__c();
            
            PageReference newCreditApprovalPg = Page.TBO014_pvf_New_CreditApproval;
            Test.setCurrentPage(newCreditApprovalPg);
            ApexPages.currentPage().getParameters().put('account', accnt.Id);
            
            ApexPages.StandardController sc = new ApexPages.StandardController(creditApproval);
            
            TBO014_ext_New_CreditApproval newCreditApprovalCtrl = new TBO014_ext_New_CreditApproval(sc);
            
            newCreditApprovalCtrl.btnSave();
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
            
            update pricing;
            
            opp.StageName = 'Proposal';
            
            update opp;
            
            opp.StageName = 'Proposal Awarded';
            
            update opp;
            
            TBO014_Credit_Approval__c creditApproval = new TBO014_Credit_Approval__c();
            
            PageReference newCreditApprovalPg = Page.TBO014_pvf_New_CreditApproval;
            Test.setCurrentPage(newCreditApprovalPg);
            ApexPages.currentPage().getParameters().put('account', accnt.Id);
            
            ApexPages.StandardController sc = new ApexPages.StandardController(creditApproval);
            
            TBO014_ext_New_CreditApproval newCreditApprovalCtrl = new TBO014_ext_New_CreditApproval(sc);
            
            newCreditApprovalCtrl.selectedOpportunitiesLeft = new List<Id> {opp.Id};
            
            newCreditApprovalCtrl.selectOpportunityClick();
            
            List<SelectOption> selectedOpps = newCreditApprovalCtrl.getSelectedOpportunities();
            
            newCreditApprovalCtrl.selectedPricingsLeft = new List<Id> {pricing.Id};
            
            newCreditApprovalCtrl.selectPricingClick();
            
            List<SelectOption> selectedPricings = newCreditApprovalCtrl.getSelectedPricings();
            
            newCreditApprovalCtrl.btnSave();
        }
        
        test.stopTest();
    }
}