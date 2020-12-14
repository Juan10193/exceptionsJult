@isTest
public class TBO018_tgr_Pricing_tst {
    @testSetup static void CustomSetting() {
		ReglasAprobacion__c setting = new ReglasAprobacion__c();
        setting.Line_of_Business__c = 'Fleet';
        setting.Min_Economic_ROI_Level_1__c = 0.89; 
        setting.Min_Economic_ROI__c = 0.39;
        setting.SupertrumpTemplate__c = 'Test';
        setting.Target_Economic_ROI__c = 1.39;
        setting.Target_Market__c = 'Corporate';
        setting.Collateral__c =  'Cars,Light trucks,Cars + Maintenance,Light trucks + Maintenance';
        setting.Name ='Fleet2';
        insert setting;
	}
    static testMethod void testInsert_ApprovalType1AllTypes () {
        try{
            test.startTest();
            
            User currentUser = TestDataFactory_tst.createUser('test@engenium.com', 'Generic', 'Sales Rep - México 1');
            
            System.runAs(currentUser) {
                Account accnt = TestDataFactory_tst.createAccount();
                
                accnt.ACC_dv_Sales_Annual_Revenue__c = 200000000;
                
                update accnt;
                
                TBO022_Competitor__c competitor = TestDataFactory_tst.createCompetitor();
                
                Opportunity opp = TestDataFactory_tst.createOpportunity(accnt, currentUser, competitor);
                
                opp.StageName = 'Opportunity Identified';
                
                update opp;
                
                ReglasAprobacion__c regla = TestDataFactory_tst.createReglaApprovacion();
                
                IST__SuperTRUMP_Template__c pricingTemplate = TestDataFactory_tst.createSTPricingTemplate();
                
                IST__SuperTRUMP_Pricing_Quote__c pricingQuote = TestDataFactory_tst.createSTPricingQuote(opp, pricingTemplate);
                system.debug('pricingQuote.Id' + pricingQuote);
            }
            
            test.stopTest();
            }catch(Exception e){
            	System.debug('Error');
        }
    }   
    static testMethod void testInsert_ApprovalType1SpecificType () {
        try{
            
            
            test.startTest();
            
            User currentUser = TestDataFactory_tst.createUser('test@engenium.com', 'Generic', 'Sales Rep - México 1');
            
            System.runAs(currentUser) {
                Account accnt = TestDataFactory_tst.createAccount();
                
                accnt.ACC_dv_Sales_Annual_Revenue__c = 200000000;
                
                update accnt;
                
                TBO022_Competitor__c competitor = TestDataFactory_tst.createCompetitor();
                
                Opportunity opp = TestDataFactory_tst.createOpportunity(accnt, currentUser, competitor);
                
                opp.StageName = 'Opportunity Identified';
                
                update opp;
                
                ReglasAprobacion__c regla = TestDataFactory_tst.createReglaApprovacion();
                
                regla.Line_of_Business__c = 'Equipment';
                regla.Collateral__c = 'Agricultural Equipment';
                
                update regla;
                
                IST__SuperTRUMP_Template__c pricingTemplate = TestDataFactory_tst.createSTPricingTemplate();
                
                IST__SuperTRUMP_Pricing_Quote__c pricingQuote = TestDataFactory_tst.createSTPricingQuote(opp, pricingTemplate);
                
            }
            
            test.stopTest();
    	}catch(Exception e){
            System.debug('Error');
        }
    }
    static testMethod void testUpdate_ApprovalType1SpecificType () {
        try{
            test.startTest();
            
            User currentUser = TestDataFactory_tst.createUser('test@engenium.com', 'Generic', 'Sales Rep - México 1');
            
            System.runAs(currentUser) {
                Account accnt = TestDataFactory_tst.createAccount();
                
                accnt.ACC_dv_Sales_Annual_Revenue__c = 200000000;
                
                update accnt;
                
                TBO022_Competitor__c competitor = TestDataFactory_tst.createCompetitor();
                
                Opportunity opp = TestDataFactory_tst.createOpportunity(accnt, currentUser, competitor);
                
                opp.StageName = 'Opportunity Identified';
                
                update opp;
                
                IST__SuperTRUMP_Template__c pricingTemplate = TestDataFactory_tst.createSTPricingTemplate();
                
                IST__SuperTRUMP_Pricing_Quote__c pricingQuote = TestDataFactory_tst.createSTPricingQuote(opp, pricingTemplate);
                
                ReglasAprobacion__c regla = TestDataFactory_tst.createReglaApprovacion();
            }
            
            test.stopTest();
        }catch(Exception e){
            System.debug('Error');
        }
    }
    /*static testMethod void testValida_Pricing () {
        
        //Inicia creacion de Opps a proporsal awarded y credit approval , opps in ca
        Account acc;
        Opportunity oppa;
        //User us;
        User thisUser = [ select Id from User where Id = :UserInfo.getUserId() ];
        acc =new Account(Name='JuanCuentaa', BillingCity='Mexico', BillingCountry='México',BillingStreet='Escalopentra', BillingPostalCode='01230', BillingState='Ciudad de México');
        insert acc;
        oppa = new Opportunity(Name ='oppa', Amount=20000, StageName='Lead', CloseDate=date.today(),OPP_ls_Line_of_Business__c='Equipment', OPP_ls_Collateral__c='Agricultural Equipment');
        insert oppa;
        Contact con1 = TestDataFactory_tst.createContact();
        OpportunityContactRole cr = new OpportunityContactRole(OpportunityId=oppa.Id, ContactId=con1.Id, IsPrimary=true);
        insert cr;
        IST__SuperTRUMP_Template__c pricingTemplate = TestDataFactory_tst.createSTPricingTemplate();
        IST__SuperTRUMP_Pricing_Quote__c pricingQuote = TestDataFactory_tst.createSTPricingQuote(oppa, pricingTemplate);
        pricingQuote.IST__QuoteStatus__c='Quoted';
        update pricingQuote;
        
        TBO018_Pricing__c pr = TestDataFactory_tst.createPricing(oppa, pricingQuote); 
        pr.TBO018_tx_Pricing_Status__c='Approved';
        //pr.TBO018_ca_Approved_by_Risk__c=true;
        pr.BKL_tx_Rationale_Comment__c = 'hi';
        update pr;
        system.runAs(thisUser){
            
        
        
        
        system.debug('JD QOO:' + pricingQuote.IST__QuoteStatus__c);
        oppa.AccountId =acc.Id;
        oppa.OPP_ls_Region__c='Mexico 1';
        oppa.OwnerId=thisUser.Id;
        //oppa.OPP_rb_Closer__c = uu.Id;
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
        pr.TBO018_rb_Opportunity__c = oppa.id;
        update pr;
        oppa.StageName='Proposal';
        update oppa;
        oppa.StageName='Proposal Awarded';
        //oppa.OPP_rb_Closer__c =thisUser.Id;
        update oppa;
            
           
            
            Id devRecordTypeId = Schema.SObjectType.Credit_approval_CP__c.getRecordTypeInfosByName().get('Credit Approval').getRecordTypeId();
        Credit_approval_CP__c cap = new Credit_approval_CP__c(recordTypeId= devRecordTypeId,CPL_ls_StageName__c='New', CPL_rb_account__c=acc.Id,Risk_Analyst__c=thisUser.Id,Sr_Underwriter__c=thisUser.Id,Inside_Sales__c=thisUser.Id);
        insert cap;
        
        
        Opportunity_in_Credit_approval_CP__c opinc1 = new Opportunity_in_Credit_approval_CP__c( CP_rb_Credit_approval_CP__c=cap.id,CP_rb_Oportunidad__c=oppa.id);
        insert opinc1;
        
        
        ES3_controller_ColsingMemo a = new ES3_controller_ColsingMemo();
        
        a.CAparentId = cap.Id;
        a.backToCA();
        
        ES3_WraperEntityStructure wpins = new ES3_WraperEntityStructure();
        a.cargaEntityEstructure();
        
        cap.CPL_ls_StageName__c='Approved';
        update cap;
        
        
        pr.ES3_Opportunity_Collateral__c = 'Text';                
        update pr;
         ES3_obj_Pricing_in_Credit_Approval__c pri_in_CA = new ES3_obj_Pricing_in_Credit_Approval__c();
        pri_in_CA.ES3_rb_Credit_approval_CP__c = cap.id;
        pri_in_CA.ES3_rb_Pricing__c = pr.id;
        pri_in_CA.ES3_rb_Opportunity_in_Credit_approval_CP__c = opinc1.Id;
        pri_in_CA.ES3_rb_Oportunidad__c = oppa.id;
        insert pri_in_CA;
        pri_in_CA.BKL_txt_EOL_Option__c = 'text';  
        update pri_in_CA;
        }
        
        
    }*/
    static testMethod void testValidaSendForApp () {
        try{
            //Inicia creacion de Opps a proporsal awarded y credit approval , opps in ca
            Account acc;
            Opportunity oppa;
            User us;
            User thisUser = [ select Id from User where Id = :UserInfo.getUserId() ];
            
            System.runAs ( thisUser ) {
                Profile p = [select id from profile where name='Generic'];
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
                update pr;
                system.debug('JD QOO:' + pricingQuote.IST__QuoteStatus__c);
                test.startTest();
                oppa.AccountId =acc.Id;
                oppa.OPP_ls_Region__c='Mexico 1';
                oppa.OwnerId=us.Id;
                //oppa.OPP_rb_Closer__c =us.Id;
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
                oppa.StageName='Proposal';
                
                oppa.Indirect_Vertical__c='Vendor Finance';
                
                update oppa;
                pr.TBO018_rb_Opportunity__c = oppa.id;
                    update pr;
                //oppa.StageName='Proposal';
                //update oppa;
                oppa.StageName='Proposal Awarded';
                update oppa;
                Credit_approval_CP__c cap = new Credit_approval_CP__c(CPL_ls_StageName__c='New', CPL_rb_account__c=acc.Id,Risk_Analyst__c=us.Id,Sr_Underwriter__c=us.Id,Inside_Sales__c=us.Id);
                insert cap;
                Opportunity_in_Credit_approval_CP__c opinc1 = new Opportunity_in_Credit_approval_CP__c( CP_rb_Credit_approval_CP__c=cap.id,CP_rb_Oportunidad__c=oppa.id);
                insert opinc1;
                
                
                ES3_controller_ColsingMemo a = new ES3_controller_ColsingMemo();
                
                a.CAparentId = cap.Id;
                a.cargaOpps();
                a.backToCA();
                
                ES3_WraperEntityStructure wpins = new ES3_WraperEntityStructure();
                a.cargaEntityEstructure();
                ES2_Obj_EntityMasterInCreditApproval__c entty = new ES2_Obj_EntityMasterInCreditApproval__c(
                    Name='lol', 
                    ES3_tx_Risk_Classification__c='lol',
                    ES3_tx_Or_Rating__c='12',
                    ES3_tx_MRAID__c='12',
                    ES3_tx_HNWI_ID__c='12',
                    ES3_tx_BloombergID__c='12',
                    ES3_rb_Opportunity_in_Credit_approval_CP__c = opinc1.Id,
                    ES3_rb_Opportunity__c=oppa.Id,
                    ES2_tx_TopParetName__c='Juan Cuenta',
                    ES2_tx_TopParentID__c='12',
                    ES2_tx_Party_Id__c='12',
                    ES2_tx_pageVF__c='lol',
                    ES2_tx_Oracle_Account_Name__c='lol',
                    ES2_tx_CostumerType__c='lol',
                    ES2_rb_Credit_approval__c=cap.Id,
                    ES2_ms_Role__c ='Legal Depositary',
                    CurrencyIsoCode='USD'
                    
                );
                
                insert entty;
                a.cargaVarsEstructure(entty, wpins);
                a.cargaCAndCEstructure();
                
                cap.CPL_ls_StageName__c='Approved';
                update cap;
                ES3_obj_Pricing_in_Credit_Approval__c pri_in_CA = new ES3_obj_Pricing_in_Credit_Approval__c();
                pri_in_CA.ES3_rb_Credit_approval_CP__c = cap.id;
                pri_in_CA.ES3_rb_Pricing__c = pr.id;
                pri_in_CA.ES3_rb_Opportunity_in_Credit_approval_CP__c = opinc1.Id;
                pri_in_CA.ES3_rb_Oportunidad__c = oppa.id;
                insert pri_in_CA;
                
                cap.CPL_ls_StageName__c='Approved';
                update cap;
                delete pri_in_CA;            test.stopTest();
                
            }
        }catch(Exception e){
            
        }
    }
    static testMethod void testValidaTgrPticing (){
        	//Inicia creacion de Opps a proporsal awarded y credit approval , opps in ca
                
        
        Account acc;
        Opportunity oppa;
        User us;
        User thisUser = [ select Id from User where Id = :UserInfo.getUserId() ];
        
        System.runAs ( thisUser ) {
            Profile p = [select id from profile where name='AML'];
            UserRole r = [Select id from userrole where name='President & CEO'];
            us = new User(alias = 'standt', email='standarduser22@testorg.com', 
                          emailencodingkey='UTF-8', lastname='Testing', 
                          languagelocalekey='en_US', 
                          localesidkey='en_US', profileid = p.Id, userroleid = r.Id,
                          timezonesidkey='America/Los_Angeles', 
                          username='standarduser22@testorg.com');
            acc =new Account(Name='JuanCuentaa',Vertical_Focus__c = 'Transportation Direct', ACC_dv_Sales_Annual_Revenue__c = 20000,
                             BillingCity='Mexico', BillingCountry='México',BillingStreet='Escalopentra', BillingPostalCode='01230', BillingState='Ciudad de México');
            insert acc;
        }
        
        system.runAs(us){
            oppa = new Opportunity(Name ='oppa', Amount=20000, StageName='Lead', CloseDate=date.today(),OPP_ls_Line_of_Business__c='Equipment', OPP_ls_Collateral__c='Agricultural Equipment');
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
            oppa.ROI_approved__c=1.70000;
            oppa.Indirect_Vertical__c='Vendor Finance';
            oppa.OPP_ls_Vendor_Brand__c='Doosan Machine Tools Americas Corp';
            oppa.OPP_ls_Vendor_Distributor__c='Doosan Machine Tools Americas Corp';
            
            insert oppa;
        }
        
        //us = TestDataFactory_tst.createUser('Juan@lol.com', 'Administrator', 'President & CEO');
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
            pr.BKL_tx_Rationale_Comment__c='comment';
            pr.TBO018_nu_ApprovalOrder__c=2.0;
            update pr;
            system.debug('JDLL Approvalorder:' + pr.TBO018_nu_ApprovalOrder__c);
            system.debug('JD QOO:' + pricingQuote.IST__QuoteStatus__c);
            test.startTest();
            
            //update oppa;
            
            oppa.StageName='Proposal';
            update oppa;
            oppa.ROI_approved__c=1.70000;
            oppa.StageName='Proposal Awarded';
            update oppa;
            Id devRecordTypeId = Schema.SObjectType.Credit_approval_CP__c.getRecordTypeInfosByName().get('Credit Approval').getRecordTypeId();
            Credit_approval_CP__c cap = new Credit_approval_CP__c(recordTypeId = devRecordTypeId,CPL_ls_StageName__c='New',ES3_ls_AML_Review_Status__c = 'In Process',ES3_ls_RISK_REVIEW_STATUS__c = 'Pending', CPL_rb_account__c=acc.Id,Risk_Analyst__c=us.Id,Sr_Underwriter__c=us.Id,Inside_Sales__c=us.Id);
            insert cap;
            Opportunity_in_Credit_approval_CP__c opinc1 = new Opportunity_in_Credit_approval_CP__c(	CP_rb_Credit_approval_CP__c=cap.id,CP_rb_Oportunidad__c=oppa.id);
            insert opinc1;
            ES3_obj_Pricing_in_Credit_Approval__c pri_in_CA = new ES3_obj_Pricing_in_Credit_Approval__c();
                pri_in_CA.ES3_rb_Credit_approval_CP__c = cap.id;
                pri_in_CA.ES3_rb_Pricing__c = pr.id;
                pri_in_CA.ES3_rb_Opportunity_in_Credit_approval_CP__c = opinc1.Id;
                pri_in_CA.ES3_rb_Oportunidad__c = oppa.id;
                insert pri_in_CA;
            //TERMINA CONSTRUCCION DEL CA
           	cap.SP3_pl_Credit_Approval_Status__c='Pending';
            cap.ES3_nu_Advance_Payment__c = 23;
            update cap;
            cap.SP3_pl_Credit_Approval_Status__c='Approved';
            cap.ES3_nu_Advance_Payment__c = 24;
            //cap.ES3_ls_EBO__c = 'YES';
            try{
				update cap;                
            
            
                
                //cap.ES3_ls_EBO__c = 'YES';
                cap.ES3_ls_RISK_REVIEW_STATUS__c = 'Approved';
                cap.ES3_ls_AML_Review_Status__c = 'Approved';
                update cap;
            }catch(Exception e){
                System.debug('e ' + e);
            }
            test.stopTest();
        }  
                
            
        
    }
    
     static testMethod void testValidaTgrPticingrationaleBlanck (){
        	//Inicia creacion de Opps a proporsal awarded y credit approval , opps in ca
                
        
        Account acc;
        Opportunity oppa;
        User us;
        User thisUser = [ select Id from User where Id = :UserInfo.getUserId() ];
        
        System.runAs ( thisUser ) {
            Profile p = [select id from profile where name='AML'];
            UserRole r = [Select id from userrole where name='President & CEO'];
            us = new User(alias = 'standt', email='standarduser22@testorg.com', 
                          emailencodingkey='UTF-8', lastname='Testing', 
                          languagelocalekey='en_US', 
                          localesidkey='en_US', profileid = p.Id, userroleid = r.Id,
                          timezonesidkey='America/Los_Angeles', 
                          username='standarduser22@testorg.com');
            acc =new Account(Name='JuanCuentaa',Vertical_Focus__c = 'Transportation Direct', ACC_dv_Sales_Annual_Revenue__c = 20000,
                             BillingCity='Mexico', BillingCountry='México',BillingStreet='Escalopentra', BillingPostalCode='01230', BillingState='Ciudad de México');
            insert acc;
        }
        
        system.runAs(us){
            oppa = new Opportunity(Name ='oppa', Amount=20000, StageName='Lead', CloseDate=date.today(),OPP_ls_Line_of_Business__c='Equipment', OPP_ls_Collateral__c='Agricultural Equipment');
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
            oppa.ROI_approved__c=1.70000;
            oppa.Indirect_Vertical__c='Vendor Finance';
            oppa.OPP_ls_Vendor_Brand__c='Doosan Machine Tools Americas Corp';
            oppa.OPP_ls_Vendor_Distributor__c='Doosan Machine Tools Americas Corp';
            
            insert oppa;
        }
        
        //us = TestDataFactory_tst.createUser('Juan@lol.com', 'Administrator', 'President & CEO');
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
            //pr.BKL_tx_Rationale_Comment__c='comment';
            pr.TBO018_nu_ApprovalOrder__c=2.0;
            try{
            	update pr;
            }catch(exception e){
                system.debug('errror:' + e.getCause());
            }
            
        }
        
    }
    
    static testMethod void testValidaTgrPticingroiBlanck (){
        	//Inicia creacion de Opps a proporsal awarded y credit approval , opps in ca
                
        
        Account acc;
        Opportunity oppa;
        User us;
        User thisUser = [ select Id from User where Id = :UserInfo.getUserId() ];
        
        System.runAs ( thisUser ) {
            Profile p = [select id from profile where name='AML'];
            UserRole r = [Select id from userrole where name='President & CEO'];
            us = new User(alias = 'standt', email='standarduser22@testorg.com', 
                          emailencodingkey='UTF-8', lastname='Testing', 
                          languagelocalekey='en_US', 
                          localesidkey='en_US', profileid = p.Id, userroleid = r.Id,
                          timezonesidkey='America/Los_Angeles', 
                          username='standarduser22@testorg.com');
            acc =new Account(Name='JuanCuentaa',Vertical_Focus__c = 'Transportation Direct', ACC_dv_Sales_Annual_Revenue__c = 20000,
                             BillingCity='Mexico', BillingCountry='México',BillingStreet='Escalopentra', BillingPostalCode='01230', BillingState='Ciudad de México');
            insert acc;
        }
        
        system.runAs(us){
            oppa = new Opportunity(Name ='oppa', Amount=20000, StageName='Lead', CloseDate=date.today(),OPP_ls_Line_of_Business__c='Equipment', OPP_ls_Collateral__c='Agricultural Equipment');
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
            oppa.ROI_approved__c=null;
            oppa.Indirect_Vertical__c='Vendor Finance';
            oppa.OPP_ls_Vendor_Brand__c='Doosan Machine Tools Americas Corp';
            oppa.OPP_ls_Vendor_Distributor__c='Doosan Machine Tools Americas Corp';
            
            insert oppa;
        }
        
        //us = TestDataFactory_tst.createUser('Juan@lol.com', 'Administrator', 'President & CEO');
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
            //pr.BKL_tx_Rationale_Comment__c='comment';
            pr.TBO018_nu_ApprovalOrder__c=2.0;
            try{
            	update pr;
            }catch(exception e){
                system.debug('errror:' + e.getCause());
            }
            
        }
        
    }
    
      static testMethod void testValidaTgrPticingpending (){
        	//Inicia creacion de Opps a proporsal awarded y credit approval , opps in ca
                
        
        Account acc;
        Opportunity oppa;
        User us;
        User thisUser = [ select Id from User where Id = :UserInfo.getUserId() ];
        
        System.runAs ( thisUser ) {
            Profile p = [select id from profile where name='AML'];
            UserRole r = [Select id from userrole where name='President & CEO'];
            us = new User(alias = 'standt', email='standarduser22@testorg.com', 
                          emailencodingkey='UTF-8', lastname='Testing', 
                          languagelocalekey='en_US', 
                          localesidkey='en_US', profileid = p.Id, userroleid = r.Id,
                          timezonesidkey='America/Los_Angeles', 
                          username='standarduser22@testorg.com');
            acc =new Account(Name='JuanCuentaa',Vertical_Focus__c = 'Transportation Direct', ACC_dv_Sales_Annual_Revenue__c = 20000,
                             BillingCity='Mexico', BillingCountry='México',BillingStreet='Escalopentra', BillingPostalCode='01230', BillingState='Ciudad de México');
            insert acc;
        }
        
        system.runAs(us){
            oppa = new Opportunity(Name ='oppa', Amount=20000, StageName='Lead', CloseDate=date.today(),OPP_ls_Line_of_Business__c='Equipment', OPP_ls_Collateral__c='Agricultural Equipment');
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
            oppa.ROI_approved__c=null;
            oppa.Indirect_Vertical__c='Vendor Finance';
            oppa.OPP_ls_Vendor_Brand__c='Doosan Machine Tools Americas Corp';
            oppa.OPP_ls_Vendor_Distributor__c='Doosan Machine Tools Americas Corp';
            
            insert oppa;
        }
        
        //us = TestDataFactory_tst.createUser('Juan@lol.com', 'Administrator', 'President & CEO');
        system.runAs(us){
            Contact con1 = TestDataFactory_tst.createContact();
            OpportunityContactRole cr = new OpportunityContactRole(OpportunityId=oppa.Id, ContactId=con1.Id, IsPrimary=true);
            insert cr;
            IST__SuperTRUMP_Template__c pricingTemplate = TestDataFactory_tst.createSTPricingTemplate();
            IST__SuperTRUMP_Pricing_Quote__c pricingQuote = TestDataFactory_tst.createSTPricingQuote(oppa, pricingTemplate);
            pricingQuote.IST__QuoteStatus__c='Quoted';
            
            update pricingQuote;
       TBO018_Pricing__c pr= TestDataFactory_tst.createPricing(oppa, pricingQuote);

            pr.TBO018_tx_Pricing_Status__c='Pending';
            pr.TBO018_ca_Approved_by_Risk__c=true;
            //pr.BKL_tx_Rationale_Comment__c='comment';
            pr.TBO018_nu_ApprovalOrder__c=2.0;
            try{
            	update pr;
            }catch(exception e){
                system.debug('errror:' + e.getCause());
            }
            
        }
        
    }
}