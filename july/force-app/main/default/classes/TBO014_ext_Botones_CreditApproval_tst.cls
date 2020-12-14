@isTest
public class TBO014_ext_Botones_CreditApproval_tst {
	public static testMethod void testSubmit() {
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
            
            TBO014_Credit_Approval__c creditApproval = TestDataFactory_tst.createCreditApproval();
            
            opp.OPP_rb_Credit_Approval__c = creditApproval.Id;
            
            update opp;
            
            pricing.TBO018_rb_Credit_Approval__c = creditApproval.Id;
            
            update pricing;
            
            ApexPages.StandardController sc = new ApexPages.StandardController(creditApproval);
            
            TBO014_ext_Botones_CreditApproval creditApprovalButtonsCtrl = new TBO014_ext_Botones_CreditApproval(sc);

            PageReference creditApprovalButtonsPg = Page.TBO014_pvf_Botones_CreditApproval;
            Test.setCurrentPage(creditApprovalButtonsPg);
            
            PageReference rtrnPage = creditApprovalButtonsCtrl.callSubmit();
        }
        
        test.stopTest();
    }
    
	public static testMethod void testSubmitWithException() {
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
            
            TBO014_Credit_Approval__c creditApproval = TestDataFactory_tst.createCreditApproval();
            
            opp.OPP_rb_Credit_Approval__c = creditApproval.Id;
            
            update opp;
            
            pricing.TBO018_rb_Credit_Approval__c = creditApproval.Id;
            
            update pricing;
            
            creditApproval.TBO014_fh_Effective_End_Date__c = null;
            
            ApexPages.StandardController sc = new ApexPages.StandardController(creditApproval);
            
            TBO014_ext_Botones_CreditApproval creditApprovalButtonsCtrl = new TBO014_ext_Botones_CreditApproval(sc);

            PageReference creditApprovalButtonsPg = Page.TBO014_pvf_Botones_CreditApproval;
            Test.setCurrentPage(creditApprovalButtonsPg);
            
            PageReference rtrnPage = creditApprovalButtonsCtrl.callSubmit();
        }
        
        test.stopTest();
    }
    
	public static testMethod void testMACRequest() {
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
            
            TBO014_Credit_Approval__c creditApproval = TestDataFactory_tst.createCreditApproval();
            
            opp.OPP_rb_Credit_Approval__c = creditApproval.Id;
            
            update opp;
            
            pricing.TBO018_rb_Credit_Approval__c = creditApproval.Id;
            
            update pricing;
            
            ApexPages.StandardController sc = new ApexPages.StandardController(creditApproval);
            
            TBO014_ext_Botones_CreditApproval creditApprovalButtonsCtrl = new TBO014_ext_Botones_CreditApproval(sc);

            PageReference creditApprovalButtonsPg = Page.TBO014_pvf_Botones_CreditApproval;
            Test.setCurrentPage(creditApprovalButtonsPg);
            
            PageReference rtrnPage = creditApprovalButtonsCtrl.callMACRequest();
        }
        
        test.stopTest();
    }
    
	public static testMethod void testMODRequest() {
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
            
            TBO014_Credit_Approval__c creditApproval = TestDataFactory_tst.createCreditApproval();
            
            opp.OPP_rb_Credit_Approval__c = creditApproval.Id;
            
            update opp;
            
            pricing.TBO018_rb_Credit_Approval__c = creditApproval.Id;
            
            update pricing;
            
            ApexPages.StandardController sc = new ApexPages.StandardController(creditApproval);
            
            TBO014_ext_Botones_CreditApproval creditApprovalButtonsCtrl = new TBO014_ext_Botones_CreditApproval(sc);

            PageReference creditApprovalButtonsPg = Page.TBO014_pvf_Botones_CreditApproval;
            Test.setCurrentPage(creditApprovalButtonsPg);
            
            PageReference rtrnPage = creditApprovalButtonsCtrl.callMODRequest();
        }
        
        test.stopTest();
    }
}