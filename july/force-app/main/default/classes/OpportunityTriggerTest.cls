@isTest
public class OpportunityTriggerTest {
    @testSetup static void testSetUp() {
        Data_Factory_User.createNewUser();
        user usu = [Select id, UserRoleId, profile.name, name from user where id = :UserInfo.getUserId()];
        UserRole usRol = [SELECT Id, Name FROM UserRole where name  = 'Chief Operations Officer'];
        //profile pro = [SELECT Name, Id FROM Profile where name = 'Administrator'];
        usu.UserRoleId = usRol.id;
        //usu.ProfileId = pro.id;        
        update usu;

	}
    static testmethod void updateAmountCA() {        
        Opportunity opp = Data_Factory_Opportunity_Test.createNewOpportunityTypeSalesWithOldCA();
        opp.Amount = 200000;
          update opp;  
    }
    static testmethod void updateAccountAfterDelete() {        
        Opportunity opp = Data_Factory_Opportunity_Test.createNewOpportunityFunded();
        User u = [Select id, name from user where email = 'mono@pruebas.com'];
        System.runAs(u) {
        	opp.StageName='Funded';
            update opp;  
            delete opp;
        }
        
    }
    static testmethod void UpdateOpportunityLostStage() {        
        Opportunity opp = Data_Factory_Opportunity_Test.createNewOpportunityFunded();
        User u = [Select id, name from user where email = 'mono@pruebas.com'];
        TBO022_Competitor__c competitor = new TBO022_Competitor__c(
            name = 'testCompetitor',
            TBO022_ls_Type__c = 'Captive'
        );
        insert competitor;
        System.runAs(u) {
            opp.StageName='Funded';            
            update opp;  
            opp.OPP_tx_Lost_Comments__c = 'losted';
        	opp.StageName='Lost Deal';
            opp.OPP_ls_Reason_Lost_Level_1__c = 'Customer Declined';
            opp.OPP_ls_Reason_Lost_Level_2__c = 'Ability to Execute';
            opp.OPP_ls_Reason_Lost_Level_3__c = 'Ability to Deliver';
            opp.OPP_rb_Competitor__c = competitor.id;
            update opp;  
        }
        
    }
    @IsTest
    static void validatePricingTest(){
       //Inicia creacion de Opps a proporsal awarded y credit approval , opps in ca
        Account acc;
        Opportunity oppa;
        User us;
        User thisUser = [ select Id from User where Id = :UserInfo.getUserId() ];
        
     System.runAs ( thisUser ) {
            Profile p = [select id from profile where name='Administrator'];
            UserRole r = [Select id from userrole where name='President & CEO'];
            us = new User(alias = 'standt', email='standarduser22@testorg.com', 
                          emailencodingkey='UTF-8', lastname='Testing', 
                          languagelocalekey='en_US', 
                          localesidkey='en_US', profileid = p.Id, userroleid = r.Id,
                          timezonesidkey='America/Los_Angeles', 
                          username='standarduser22@testorg.com');
            acc =new Account(Name='JuanCuentaa', BillingCity='Mexico', BillingCountry='México',BillingStreet='Escalopentra', BillingPostalCode='01230', BillingState='Ciudad de México');
            insert acc;
        }
        
        system.runAs(us){
            oppa = new Opportunity(Name ='oppa', Amount=20000, StageName='Lead', CloseDate=date.today(),OPP_ls_Line_of_Business__c='Equipment', OPP_ls_Collateral__c='Agricultural Equipment');
            insert oppa;
        }
        
        us = TestDataFactory_tst.createUser('Juan@lol.com', 'Administrator', 'President & CEO');
        system.runAs(us){
            Contact con1 = TestDataFactory_tst.createContact();
            OpportunityContactRole cr = new OpportunityContactRole(OpportunityId=oppa.Id, ContactId=con1.Id, IsPrimary=true);
            insert cr;
            IST__SuperTRUMP_Template__c pricingTemplate = TestDataFactory_tst.createSTPricingTemplate();
            IST__SuperTRUMP_Pricing_Quote__c pricingQuote = TestDataFactory_tst.createSTPricingQuote(oppa, pricingTemplate);
            pricingQuote.IST__QuoteStatus__c='Quoted';
            
            update pricingQuote;
            TBO018_Pricing__c pr= TestDataFactory_tst.createPricing(oppa, pricingQuote);
            pr.TBO018_tx_Pricing_Status__c='Approved';
            pr.TBO018_ca_Approved_by_Risk__c=true;
            pr.BKL_tx_Rationale_Comment__c='lol';
            update pr;
            system.debug('JD QOO:' + pricingQuote.IST__QuoteStatus__c);
            test.startTest();
            oppa.AccountId =acc.Id;
            oppa.OPP_ls_Region__c='Mexico 1';
            oppa.OwnerId=us.Id;
            oppa.OPP_rb_Closer__c =us.Id;
            oppa.OPP_tx_Opportunity_Comments__c='lol';
            oppa.OPP_tl_CommercialSupportComments__c='lolx2';
            oppa.OPP_ls_Product__c ='Term Loan';
            oppa.OPP_ls_Financing_Need__c='CapEx Lines';
            oppa.OPP_ls_Deal_Category__c='New Origination';
            oppa.OPP_ls_Line_of_Business__c='Equipment';
            oppa.OPP_ls_Equipment_Import_Required__c='No';
            oppa.OPP_ls_Equipment_Condition__c='New';
            oppa.OPP_lm_Additional_Services__c='Rapid Tag - Transportation';
            oppa.OPP_ls_Insurance_Type__c='Engenium Capital Financed';
            oppa.Insurance_Manager_Comments__c='lolx3';
            oppa.CPIS2_tx_Collateral_Description__c='lolx4';
            oppa.Reason_Engenium_Insurance_Lost__c='Higher Engenium premium price';
            oppa.OPP_ls_Opportunity_from_Vendor__c='Yes';
            oppa.OPP_ls_Vendor_Fee_Commision__c='Yes';
            oppa.OPP_pr_Vendor_Fee_Commision__c=10;
            oppa.OPP_ls_Vendor_Rates_Subsides__c='No support';
            oppa.OPP_ls_Vendor_Risk_Support__c='No support';
            oppa.OPP_ls_Collateral__c ='Co-generation';
            oppa.OPP_ls_Opportunity_from_Broker__c='Yes';
            oppa.OPP_ls_Broker_Fee_Commision__c='Yes';
            oppa.OPP_ls_Broker_name__c='AAA Servicios De Intermediación Financiera';
            oppa.OPP_pr_Broker_Fee_Commision__c=10;
            oppa.OPP_ls_Shared_Opportunity__c='Yes';
            TBO022_Competitor__c comp1= TestDataFactory_tst.createCompetitor();
            oppa.OPP_rb_Competitor__c=comp1.Id;
            oppa.OPP_un_Competitor_Term_Months__c=3;
            oppa.OPP_ls_Competitor_Is_the_main_lender__c='Yes';
            oppa.OPP_un_Competitor_Spread_bps__c=1;
            oppa.OPP_ls_Competitor_Product__c='Term Loan';
            oppa.OPP_un_Spread_Diff_vs_Competitor_in_bps__c=1;
            oppa.OPP_ls_Competitor_Floating_Fixed__c='Floating';
            oppa.OPP_tl_Competitor_comments__c='LOLXuunshingo';
            oppa.OPP_ls_Competitor_Index__c='10 Yr. Swaps';
            oppa.OPP_ls_Reason_Won_Level_1__c='Ability to Execute';
            oppa.OPP_fh_Proposal_Signed_Received_Date__c=date.today();
            oppa.OPP_ls_Reason_Won_Level_2__c='Ability to Deliver';
            oppa.OPP_ca_No_document__c=false; 
            oppa.OPP_tl_Won_Comments__c='lolyamecastre';
            oppa.OPP_tl_Not_Signed_Proposal_Reason__c='';
            oppa.OPP_ls_Reason_Lost_Level_1__c='Customer Declined';
            oppa.OPP_tx_LostStage__c='asd';
            oppa.OPP_ls_Reason_Lost_Level_2__c='Cash';
            oppa.OPP_fe_Lost_Date__c=date.today();
            oppa.OPP_ls_Reason_Lost_Level_3__c='Paid Cash / Cash Rich';
            oppa.OPP_tx_Lost_Comments__c='ultimopinshicomentario';
            oppa.StageName='Opportunity Identified';
            
            oppa.Indirect_Vertical__c='Vendor Finance';
            
            update oppa;
            
            oppa.StageName='Proposal';
            update oppa;
            oppa.StageName='Proposal Awarded';
            update oppa;
            Credit_approval_CP__c cap = new Credit_approval_CP__c(CPL_ls_StageName__c='New', CPL_rb_account__c=acc.Id,Risk_Analyst__c=us.Id,Sr_Underwriter__c=us.Id,Inside_Sales__c=us.Id);
            insert cap;
            Opportunity_in_Credit_approval_CP__c opinc1 = new Opportunity_in_Credit_approval_CP__c(	CP_rb_Credit_approval_CP__c=cap.id,CP_rb_Oportunidad__c=oppa.id);
            insert opinc1;
            //TERMINA CONSTRUCCION DEL CA
            ES3_ValidaPricingInCreditApproval.validatePricing(cap.Id, true);
            ES3_ValidaPricingInCreditApproval.getButtonsCA(cap.id);
            set<id> oppID = new set<id>();
            oppID.add(oppa.id);
            Data_Access_Opportunity_cls.getOpportunityByContentVersion(oppID);
            Data_Access_Opportunity_cls.getOpportunityById(oppa.id);
            test.stopTest();
        }       		
        
    }
    
    

}