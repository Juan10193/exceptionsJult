@isTest
public class OPP_tgr_StagesValidations_tst {
    static testMethod void testOppStages () {
        
        
        
        User currentUser = TestDataFactory_tst.createUser('test@engenium.com', 'Generic', 'Sales Rep 1');
        
        System.runAs(currentUser) {    
           	account acc = TestDataFactory_tst.createSimpleAccount(TestDataFactory_tst.createSICcode().id);
            contact cont = TestDataFactory_tst.createContact(acc);   
            
            
            TBO022_Competitor__c competitor = TestDataFactory_tst.createCompetitor();
            
            Opportunity opp = TestDataFactory_tst.createOpportunity(acc, currentUser, competitor);
            TestDataFactory_tst.createOpportunityContactRole(opp,cont);
            opp.StageName = 'proposal';
            try{
            	update opp;    
            }catch(Exception e){
                
            }
            
    
            IST__SuperTRUMP_Template__c pricingTemplate = TestDataFactory_tst.createSTPricingTemplate();
            
            IST__SuperTRUMP_Pricing_Quote__c pricingQuote = TestDataFactory_tst.createSTPricingQuote(opp, pricingTemplate);
            system.debug('pricingQuote ' + pricingQuote);
            TBO018_Pricing__c pricing = [SELECT Id FROM TBO018_Pricing__c WHERE TBO018_rb_SuperTRUMP_Pricing_Quote__c = :pricingQuote.Id];
            
            pricing.TBO018_tx_Pricing_Status__c = 'Approved';
            
            update pricing;
            test.startTest();
            opp.StageName = 'Proposal';
            
            update opp;
            
            opp.StageName = 'Proposal Awarded';
            
            update opp;
            
            TBO014_Credit_Approval__c creditApproval = TestDataFactory_tst.createCreditApproval();
            
            opp.OPP_rb_Credit_Approval__c = creditApproval.Id;
            
            update opp;
            
            pricing.TBO018_rb_Credit_Approval__c = creditApproval.Id;
            
            update pricing;
            
            opp.Amount = 1000;  
            
            update opp;
			test.stopTest();
        }
        
        
    }
    
    static testMethod void testFundedOpp () {
        
        User currentUser = TestDataFactory_tst.createUser('test@engenium.com', 'Administrator', 'Sales Rep 1');
        
        System.runAs(currentUser) {    
            
            account acc = TestDataFactory_tst.createSimpleAccount(TestDataFactory_tst.createSICcode().id);
            contact cont = TestDataFactory_tst.createContact(acc);   
            
            
            TBO022_Competitor__c competitor = TestDataFactory_tst.createCompetitor();
            
            Opportunity opp = TestDataFactory_tst.createOpportunity(acc, currentUser, competitor);
            TestDataFactory_tst.createOpportunityContactRole(opp,cont);
            
            opp.StageName = 'Opportunity Identified';
            
            update opp;
    
            IST__SuperTRUMP_Template__c pricingTemplate = TestDataFactory_tst.createSTPricingTemplate();
            
            IST__SuperTRUMP_Pricing_Quote__c pricingQuote = TestDataFactory_tst.createSTPricingQuote(opp, pricingTemplate);
			system.debug('pricingQuote ' + pricingQuote);            
            TBO018_Pricing__c pricing = [SELECT Id FROM TBO018_Pricing__c WHERE TBO018_rb_SuperTRUMP_Pricing_Quote__c = :pricingQuote.Id];
            
           	pricing.TBO018_tx_Pricing_Status__c = 'Approved';
           	update pricing;
            
            opp.StageName = 'Proposal';
            
            update opp;
            
            opp.StageName = 'Proposal Awarded';
            
            update opp;
            test.startTest();
            TBO020_Takedowns__c tkd = TestDataFactory_tst.createTakedownForecast(opp, currentUser, 'Funded');
            
            opp.StageName = 'Funded';
            opp.OPP_fh_Funded_Date__c = Date.today();
            
            
            update opp;
            
            delete pricing;
            
            delete pricingQuote;
            
            delete opp;
            test.stopTest();

        }
        
        
    }
}