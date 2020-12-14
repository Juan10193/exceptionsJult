@isTest
public class TBO014_cvf_Update_CreditApproval_tst {
	public static testMethod void testCancel() {
        
        User currentUser = TestDataFactory_tst.createUser('test@engenium.com', 'Generic', 'Sales Rep 1');
        
        System.runAs(currentUser) { 
            Account accnt = TestDataFactory_tst.createAccount();
            
            TBO022_Competitor__c competitor = TestDataFactory_tst.createCompetitor();
            
            Opportunity opp = TestDataFactory_tst.createOpportunity(accnt, currentUser, competitor);
            
            TBO014_Credit_Approval__c creditApproval = TestDataFactory_tst.createCreditApproval();
            
    		test.startTest();
            
            PageReference updateCreditApprovalPg = new PageReference('/apex/TBO014_pvf_Update_CreditApproval');
            ApexPages.currentPage().getParameters().put('id', creditApproval.Id);
            
            TBO014_cvf_Update_CreditApproval updateCreditApprovalCtrl = new TBO014_cvf_Update_CreditApproval();
                        
            PageReference rtrnPage = updateCreditApprovalCtrl.btnCancel();
        
        	test.stopTest();
        }
    }
    
    public static testMethod void testGetOpps() {
        
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
            
            TBO014_Credit_Approval__c creditApproval = TestDataFactory_tst.createCreditApproval(accnt);
            
    		test.startTest();
            
            PageReference updateCreditApprovalPg = new PageReference('/apex/TBO014_pvf_Update_CreditApproval');
            ApexPages.currentPage().getParameters().put('id', creditApproval.Id);
            
            TBO014_cvf_Update_CreditApproval updateCreditApprovalCtrl = new TBO014_cvf_Update_CreditApproval();
                        
            List<SelectOption> unselectedOpps = updateCreditApprovalCtrl.getUnselectedOpportunities();
            
            updateCreditApprovalCtrl.selectedOpportunitiesLeft = new List<Id> {opp.Id};
            
            updateCreditApprovalCtrl.selectOpportunityClick();
            
            List<SelectOption> selectedOpps = updateCreditApprovalCtrl.getSelectedOpportunities();
            
            updateCreditApprovalCtrl.selectedOpportunitiesRight = new List<Id> {opp.Id};
            
            updateCreditApprovalCtrl.unselectOpportunityClick();
        
        	test.stopTest();
        }
    }
    
    public static testMethod void testGetPricings() {
        
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
            
            TBO014_Credit_Approval__c creditApproval = TestDataFactory_tst.createCreditApproval(accnt);
    	
            test.startTest();
            
            PageReference updateCreditApprovalPg = new PageReference('/apex/TBO014_pvf_Update_CreditApproval');
            ApexPages.currentPage().getParameters().put('id', creditApproval.Id);
            
            TBO014_cvf_Update_CreditApproval updateCreditApprovalCtrl = new TBO014_cvf_Update_CreditApproval();
                        
            List<SelectOption> unselectedOpps = updateCreditApprovalCtrl.getUnselectedOpportunities();
            
            updateCreditApprovalCtrl.selectedOpportunitiesLeft = new List<Id> {opp.Id};
            
            updateCreditApprovalCtrl.selectOpportunityClick();
            
            List<SelectOption> selectedOpps = updateCreditApprovalCtrl.getSelectedOpportunities();
            
            List<SelectOption> unselectedPricings = updateCreditApprovalCtrl.getUnselectedPricings();
            
            updateCreditApprovalCtrl.selectedPricingsLeft = new List<Id> {pricing.Id};
            
            updateCreditApprovalCtrl.selectPricingClick();
            
            List<SelectOption> selectedPricings = updateCreditApprovalCtrl.getSelectedPricings();
            
            updateCreditApprovalCtrl.selectedPricingsRight = new List<Id> {pricing.Id};
            
            updateCreditApprovalCtrl.unselectPricingClick();
        
        	test.stopTest();
        }
    }
    
    public static testMethod void testOpp_Pricing_Exceptions() {
        
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
            
            TBO014_Credit_Approval__c creditApproval = TestDataFactory_tst.createCreditApproval(accnt);
    	
            test.startTest();
            
            PageReference updateCreditApprovalPg = new PageReference('/apex/TBO014_pvf_Update_CreditApproval');
            ApexPages.currentPage().getParameters().put('id', creditApproval.Id);
            
            TBO014_cvf_Update_CreditApproval updateCreditApprovalCtrl = new TBO014_cvf_Update_CreditApproval();
            
            updateCreditApprovalCtrl.btnSave();
        
        	test.stopTest();
        }
    }
    
    public static testMethod void testSave() {
        
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
            
            TBO014_Credit_Approval__c creditApproval = TestDataFactory_tst.createCreditApproval(accnt);
    	
            test.startTest();
            
            PageReference updateCreditApprovalPg = new PageReference('/apex/TBO014_pvf_Update_CreditApproval');
            ApexPages.currentPage().getParameters().put('id', creditApproval.Id);
            
            TBO014_cvf_Update_CreditApproval updateCreditApprovalCtrl = new TBO014_cvf_Update_CreditApproval();
                        
            List<SelectOption> unselectedOpps = updateCreditApprovalCtrl.getUnselectedOpportunities();
            
            updateCreditApprovalCtrl.selectedOpportunitiesLeft = new List<Id> {opp.Id};
            
            updateCreditApprovalCtrl.selectOpportunityClick();
            
            List<SelectOption> selectedOpps = updateCreditApprovalCtrl.getSelectedOpportunities();
            
            List<SelectOption> unselectedPricings = updateCreditApprovalCtrl.getUnselectedPricings();
            
            updateCreditApprovalCtrl.selectedPricingsLeft = new List<Id> {pricing.Id};
            
            updateCreditApprovalCtrl.selectPricingClick();
            
            List<SelectOption> selectedPricings = updateCreditApprovalCtrl.getSelectedPricings();
            
            updateCreditApprovalCtrl.btnSave();
        
        	test.stopTest();
        }
    }
    
    public static testMethod void testSaveWithInfo() {
        
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
            
            Opportunity opp2 = TestDataFactory_tst.createOpportunity(accnt, currentUser, competitor);
            
            opp2.StageName = 'Opportunity Identified';
            
            update opp2;
            
            IST__SuperTRUMP_Pricing_Quote__c pricingQuote2 = TestDataFactory_tst.createSTPricingQuote(opp2, pricingTemplate);
            
            TBO018_Pricing__c pricing2 = [SELECT Id FROM TBO018_Pricing__c WHERE TBO018_rb_SuperTRUMP_Pricing_Quote__c = :pricingQuote2.Id];
            
            pricing2.TBO018_tx_Pricing_Status__c = 'Approved';
            
            update pricing2;
            
            opp2.StageName = 'Proposal';
            
            update opp2;
            
            opp2.StageName = 'Proposal Awarded';
            
            update opp2;
            
            TBO014_Credit_Approval__c creditApproval = TestDataFactory_tst.createCreditApproval(accnt);
            
            opp2.OPP_rb_Credit_Approval__c = creditApproval.Id;
            
            update opp2;
            
            pricing2.TBO018_rb_Credit_Approval__c = creditApproval.Id;
            
            update pricing2;
    	
            test.startTest();
            
            PageReference updateCreditApprovalPg = new PageReference('/apex/TBO014_pvf_Update_CreditApproval');
            ApexPages.currentPage().getParameters().put('id', creditApproval.Id);
            
            TBO014_cvf_Update_CreditApproval updateCreditApprovalCtrl = new TBO014_cvf_Update_CreditApproval();
                        
            List<SelectOption> unselectedOpps = updateCreditApprovalCtrl.getUnselectedOpportunities();
            
            updateCreditApprovalCtrl.selectedOpportunitiesLeft = new List<Id> {opp.Id};
            
            updateCreditApprovalCtrl.selectOpportunityClick();
            
            List<SelectOption> selectedOpps = updateCreditApprovalCtrl.getSelectedOpportunities();
            
            List<SelectOption> unselectedPricings = updateCreditApprovalCtrl.getUnselectedPricings();
            
            updateCreditApprovalCtrl.selectedPricingsLeft = new List<Id> {pricing.Id};
            
            updateCreditApprovalCtrl.selectPricingClick();
            
            List<SelectOption> selectedPricings = updateCreditApprovalCtrl.getSelectedPricings();
            
            updateCreditApprovalCtrl.btnSave();
        
            test.stopTest();
        }
    }
    
    public static testMethod void testOriginalCreditApproval() {
        
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
            
            IST__SuperTRUMP_Pricing_Quote__c pricingQuote2 = TestDataFactory_tst.createSTPricingQuote(opp, pricingTemplate);
            
            TBO018_Pricing__c pricing2 = [SELECT Id FROM TBO018_Pricing__c WHERE TBO018_rb_SuperTRUMP_Pricing_Quote__c = :pricingQuote2.Id];
            
            pricing2.TBO018_tx_Pricing_Status__c = 'Approved';
            
            update pricing2;
            
            opp.StageName = 'Proposal';
            
            update opp;
            
            opp.StageName = 'Proposal Awarded';
            
            update opp;
            
            TBO014_Credit_Approval__c originalCreditApproval = TestDataFactory_tst.createCreditApproval(accnt);
            
            opp.OPP_rb_Credit_Approval__c = originalCreditApproval.Id;
            
            update opp;
            
            pricing.TBO018_rb_Credit_Approval__c = originalCreditApproval.Id;
            
            update pricing;
            
            Opportunity opp2 = TestDataFactory_tst.createOpportunity(accnt, currentUser, competitor);
            
            opp2.StageName = 'Opportunity Identified';
            
            update opp2;
            
            IST__SuperTRUMP_Pricing_Quote__c pricingQuote3 = TestDataFactory_tst.createSTPricingQuote(opp2, pricingTemplate);
            
            TBO018_Pricing__c pricing3 = [SELECT Id FROM TBO018_Pricing__c WHERE TBO018_rb_SuperTRUMP_Pricing_Quote__c = :pricingQuote3.Id];
            
            pricing3.TBO018_tx_Pricing_Status__c = 'Approved';
            
            update pricing3;
            
            opp2.StageName = 'Proposal';
            
            update opp2;
            
            opp2.StageName = 'Proposal Awarded';
            
            update opp2;
            
            TBO014_Credit_Approval__c creditApproval = TestDataFactory_tst.createCreditApproval(accnt);
            
            creditApproval.TBO014_rb_Credit_Approval_Original__c = originalCreditApproval.Id;
            
            update creditApproval;
            
    		test.startTest();
            
            PageReference updateCreditApprovalPg = new PageReference('/apex/TBO014_pvf_Update_CreditApproval');
            ApexPages.currentPage().getParameters().put('id', creditApproval.Id);
            
            TBO014_cvf_Update_CreditApproval updateCreditApprovalCtrl = new TBO014_cvf_Update_CreditApproval();
                        
            List<SelectOption> unselectedOpps = updateCreditApprovalCtrl.getUnselectedOpportunities();
            
            updateCreditApprovalCtrl.selectedOpportunitiesLeft = new List<Id> {opp.Id};
            
            updateCreditApprovalCtrl.selectOpportunityClick();
            
            List<SelectOption> selectedOpps = updateCreditApprovalCtrl.getSelectedOpportunities();
            
            List<SelectOption> unselectedPricings = updateCreditApprovalCtrl.getUnselectedPricings();
            
            updateCreditApprovalCtrl.selectedPricingsLeft = new List<Id> {pricing.Id};
            
            updateCreditApprovalCtrl.selectPricingClick();
            
            List<SelectOption> selectedPricings = updateCreditApprovalCtrl.getSelectedPricings();
            
            updateCreditApprovalCtrl.btnSave();
            
        	test.stopTest();
        }
    }
    
    public static testMethod void testSaveApproved() {
        
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
            
            TBO014_Credit_Approval__c creditApproval = TestDataFactory_tst.createCreditApproval(accnt);
            
            creditApproval.TBO014_tx_Status__c = 'Approved';
            
            update creditApproval;
    	
            test.startTest();
            
            PageReference updateCreditApprovalPg = new PageReference('/apex/TBO014_pvf_Update_CreditApproval');
            ApexPages.currentPage().getParameters().put('id', creditApproval.Id);
            
            TBO014_cvf_Update_CreditApproval updateCreditApprovalCtrl = new TBO014_cvf_Update_CreditApproval();
                        
            List<SelectOption> unselectedOpps = updateCreditApprovalCtrl.getUnselectedOpportunities();
            
            updateCreditApprovalCtrl.selectedOpportunitiesLeft = new List<Id> {opp.Id};
            
            updateCreditApprovalCtrl.selectOpportunityClick();
            
            List<SelectOption> selectedOpps = updateCreditApprovalCtrl.getSelectedOpportunities();
            
            List<SelectOption> unselectedPricings = updateCreditApprovalCtrl.getUnselectedPricings();
            
            updateCreditApprovalCtrl.selectedPricingsLeft = new List<Id> {pricing.Id};
            
            updateCreditApprovalCtrl.selectPricingClick();
            
            List<SelectOption> selectedPricings = updateCreditApprovalCtrl.getSelectedPricings();
            
            updateCreditApprovalCtrl.btnSave();
        
        	test.stopTest();
        }
    }
    
    public static testMethod void testSaveFinal() {
        
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
            
            Opportunity opp2 = TestDataFactory_tst.createOpportunity(accnt, currentUser, competitor);
            
            opp2.StageName = 'Opportunity Identified';
            
            update opp2;
            
            IST__SuperTRUMP_Pricing_Quote__c pricingQuote2 = TestDataFactory_tst.createSTPricingQuote(opp2, pricingTemplate);
            
            TBO018_Pricing__c pricing2 = [SELECT Id FROM TBO018_Pricing__c WHERE TBO018_rb_SuperTRUMP_Pricing_Quote__c = :pricingQuote2.Id];
            
            pricing2.TBO018_tx_Pricing_Status__c = 'Approved';
            
            update pricing2;
            
            opp2.StageName = 'Proposal';
            
            update opp2;
            
            opp2.StageName = 'Proposal Awarded';
            
            update opp2;
            
            TBO014_Credit_Approval__c creditApproval = TestDataFactory_tst.createCreditApproval(accnt);
            
            opp.OPP_rb_Credit_Approval__c = creditApproval.Id;
            
            update opp;
            
            pricing.TBO018_rb_Credit_Approval__c = creditApproval.Id;
            
            update pricing;
            
            opp2.OPP_rb_Credit_Approval__c = creditApproval.Id;
            
            update opp2;
            
            pricing2.TBO018_rb_Credit_Approval__c = creditApproval.Id;
            
            update pricing2;

    		test.startTest();     
            
            PageReference updateCreditApprovalPg = new PageReference('/apex/TBO014_pvf_Update_CreditApproval');
            ApexPages.currentPage().getParameters().put('id', creditApproval.Id);
            
            TBO014_cvf_Update_CreditApproval updateCreditApprovalCtrl = new TBO014_cvf_Update_CreditApproval();
                        
            List<SelectOption> unselectedOpps = updateCreditApprovalCtrl.getUnselectedOpportunities();
            
            updateCreditApprovalCtrl.selectedOpportunitiesRight = new List<Id> {opp2.Id};
            
            updateCreditApprovalCtrl.unselectOpportunityClick();
            
            unselectedOpps = updateCreditApprovalCtrl.getUnselectedOpportunities();
            
            updateCreditApprovalCtrl.btnSave();
        
        	test.stopTest();
        }
    }
}