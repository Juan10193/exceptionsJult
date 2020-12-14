@isTest
public class Test_opp_ToBacklogWithFundings {
    static testMethod void testTriggerSumTakedowns() {
        test.startTest();
        User currentUser = TestDataFactory_tst.createUser('test@engenium.com', 'Administrator', 'Sales Rep 1');
        
        System.runAs(currentUser) {
            
            Account accnt = TestDataFactory_tst.createAccount();            
            accnt.ACC_dv_Sales_Annual_Revenue__c = 200000000;            
            update accnt;            
            TBO022_Competitor__c competitor = TestDataFactory_tst.createCompetitor();            
            Opportunity opp = TestDataFactory_tst.createOpportunity(accnt, currentUser, competitor);            
            opp.StageName = 'Backlog';          
            update opp;
            
            TBO020_Takedowns__c td = new TBO020_Takedowns__c();
            td.TBO020_pd_Opportunity__c = opp.id;
            td.TBO020_ls_Opportunity_from_Vendor__c = 'No';
            td.TBO020_ls_Opportunity_from_Broker__c = 'No';
            td.TBO020_tx_Status__c = 'Funded';
            insert td;
            
            //Pruebas Spring 1
            
            Opportunity oppp = TestDataFactory_tst.createOpportunity(accnt, currentUser, competitor); 
            IST__SuperTRUMP_Template__c template = TestDataFactory_tst.createSTPricingTemplate();
            IST__SuperTRUMP_Pricing_Quote__c quote = TestDataFactory_tst.createSTPricingQuote(oppp,template );
            TBO018_Pricing__c pricing = TestDataFactory_tst.createPricing(oppp, quote);
            pricing.TBO018_tx_Pricing_Status__c = 'Approved';
            update pricing;  
            
            oppp.StageName = 'Proposal';
            update oppp;
            oppp.StageName = 'Proposal Awarded';
            update oppp;
            
            Credit_approval_CP__c ca = new Credit_approval_CP__c();
            ca.CPL_rb_account__c = accnt.id;
            ca.Type_of_credit_approval__c = 'New';
            ca.CurrencyIsoCode = 'USD';
            insert ca;
            
            //opp.StageName = 'Proposal Awarded'; 
            //update opp;
            
            Opportunity_in_Credit_approval_CP__c oppInCa = new Opportunity_in_Credit_approval_CP__c();
            oppInCa.CP_rb_Credit_approval_CP__c = ca.id;
            oppInCa.CP_rb_Oportunidad__c = oppp.id;
            insert oppInCa;
            
            ca.CPL_ls_StageName__c = 'In Process';
            update ca;
            
            ca.CPL_ls_StageName__c = 'Approved';
            update ca;                                                           
            ca.CPI_ck_FueAprobado__c = true;
            update ca;            
            
            ca.CPI_ck_FueAprobado__c = false;
            ca.CPL_ls_StageName__c = 'Declined';
            ca.CPI_ls_Reason_Lost_Level_1__c = 'Customer Declined';
            ca.CPI_ls_Reason_Lost_Level_2__c = 'Ability to Execute';
            ca.CPI_ls_Reason_Lost_Level_3__c = 'Ability to Deliver';
            ca.CPI_rb_Competitor__c = competitor.id;
            ca.CPI_tx_Lost_Comments__c = 'un comentario';
            update ca;
            ca.CPL_ls_StageName__c = 'Withdrawn';
            update ca;
            
            Takedowns_Contingency_plan__c tdCP = new Takedowns_Contingency_plan__c();
            tdCP.CPL_rb_Opp__c = oppp.id;
            tdCP.TDAmount__c = Decimal.valueOf('1');
            tdCP.CurrencyIsoCode = 'USD';            
            tdcp.CPL_ls_Operation_Unit__c = 'UO_397 HOLDING';
            tdcp.CPL_ls_Product__c = 'OPERFIN-FIJA';
            tdcp.CPL_ls_Stage__c = 'New';
            tdCP.CPL_lsm_Documents_for_Tollgate_1__c = 'Anexo';
            tdCP.CPL_lsm_Documents_for_Tollgate_2__c = 'Anexo';
            insert tdCP;
            tdcp.CPL_ls_Stage__c = 'Ready to send to the approval of Tollgate 1';
            update tdCP;
            
            
        }
    }
}