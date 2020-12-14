@isTest
public class TBO014_tgr_CreditApproval_tst {
    static testMethod void testApprovedStatus () {
        
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
            
            opp.OPP_rb_Credit_Approval__c = creditApproval.Id;
            
            update opp;
            
            pricing.TBO018_rb_Credit_Approval__c = creditApproval.Id;
            
            update pricing;
            
            creditApproval.TBO014_tx_Status__c = 'Submitted';
            
            update creditApproval;
        
            test.startTest();
            
            creditApproval.TBO014_tx_Status__c = 'Approved';
            
            update creditApproval;
        
        	test.stopTest();
        }
    }
    
    static testMethod void testDeclinedStatus () {
        
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
            
            opp.OPP_rb_Credit_Approval__c = creditApproval.Id;
            opp.OPP_ls_Reason_Lost_Level_1__c = 'Risk declined';
            opp.OPP_ls_Reason_Lost_Level_2__c = 'Ability to Execute';
            opp.OPP_ls_Reason_Lost_Level_3__c = 'Ability to Deliver';
            opp.OPP_tx_Lost_Comments__c = 'Test Declined.';
            
            update opp;
            
            pricing.TBO018_rb_Credit_Approval__c = creditApproval.Id;
            
            update pricing;
            
            creditApproval.TBO014_tx_Status__c = 'Submitted';
            
            update creditApproval;
        
            test.startTest();
            
            creditApproval.TBO014_tx_Status__c = 'Declined';
            
            update creditApproval;
        
        	test.stopTest();
        }
    }
    
    static testMethod void testMODApproved_OriginalMODStatus () {
        
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
            
            creditApproval.TBO014_ls_Approval_Category__c = 'MOD';
            creditApproval.TBO014_rb_Credit_Approval_Original__c = originalCreditApproval.Id;
            creditApproval.TBO014_tx_Status__c = 'MOD';
            
            update creditApproval;
            
            opp2.OPP_rb_Credit_Approval__c = creditApproval.Id;
            
            update opp2;
            
            pricing3.TBO018_rb_Credit_Approval__c = creditApproval.Id;
            
            update pricing3;
            
            creditApproval.TBO014_tx_Status__c = 'Submitted';
            
            update creditApproval;
            
        	test.startTest();
            
            creditApproval.TBO014_tx_Status__c = 'Approved';
            
            update creditApproval;
        
        	test.stopTest();
        }
    }
    
    static testMethod void testMODApproved_PartiallyBookedStatus () {
        
        User currentUser = TestDataFactory_tst.createUser('test@engenium.com', 'Administrator', 'Sales Rep 1');
        
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
            
            creditApproval.TBO014_ls_Approval_Category__c = 'MOD';
            creditApproval.TBO014_rb_Credit_Approval_Original__c = originalCreditApproval.Id;
            
            update creditApproval;
            
            opp2.OPP_rb_Credit_Approval__c = creditApproval.Id;
            
            update opp2;
            
            pricing3.TBO018_rb_Credit_Approval__c = creditApproval.Id;
            
            update pricing3;
            
            creditApproval.TBO014_tx_Status__c = 'Submitted';
            
            update creditApproval;
            
            TBO020_Takedowns__c takedown = TestDataFactory_tst.createTakedownForecast(opp, currentUser, 'Funded');
            
            takedown.TBO020_dv_Amount__c = 50;
            
            update takedown;
        	
            test.startTest();
            
            creditApproval.TBO014_tx_Status__c = 'Approved';
            
            update creditApproval;
        
        	test.stopTest();
        }
    }
    
    static testMethod void testMODApproved_FundedStatus () {
        
        User currentUser = TestDataFactory_tst.createUser('test@engenium.com', 'Administrator', 'Sales Rep 1');
        
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
            
            creditApproval.TBO014_ls_Approval_Category__c = 'MOD';
            creditApproval.TBO014_rb_Credit_Approval_Original__c = originalCreditApproval.Id;
            
            update creditApproval;
            
            opp2.OPP_rb_Credit_Approval__c = creditApproval.Id;
            
            update opp2;
            
            pricing3.TBO018_rb_Credit_Approval__c = creditApproval.Id;
            
            update pricing3;
            
            creditApproval.TBO014_tx_Status__c = 'Submitted';
            
            update creditApproval;
            
            TBO020_Takedowns__c takedown = TestDataFactory_tst.createTakedownForecast(opp, currentUser, 'Funded');
            
            takedown.TBO020_dv_Amount__c = 300000000.50;
            
            update takedown;
            
        	test.startTest();
            
            creditApproval.TBO014_tx_Status__c = 'Approved';
            
            update creditApproval;
        
        	test.stopTest();
        }
    }
}