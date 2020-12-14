@IsTest
private class ES2_Controller_EntityMasterInCATest {
    
    @Istest
    static void ES3_controller_Enttit(){
        //Inicia creacion de Opps a proporsal awarded y credit approval , opps in ca
        Account acc;
        Opportunity oppa;
        User us;
        User thisUser = [ select Id from User where Id = :UserInfo.getUserId() ];
        
        System.runAs ( thisUser ) {
           us = TestDataFactory_tst.createUser('Juan@lol.com', 'Administrator', 'President & CEO');
        }
        system.runAs(us){
            acc = TestDataFactory_tst.createAccount();
            TBO022_Competitor__c comp = TestDataFactory_tst.createCompetitor();
            oppa = TestDataFactory_tst.createOpportunity(acc, us, comp);
            Contact con1 = TestDataFactory_tst.createContact();
            OpportunityContactRole cr = new OpportunityContactRole(OpportunityId=oppa.Id, ContactId=con1.Id, IsPrimary=true);
            insert cr;
            IST__SuperTRUMP_Template__c pricingTemplate = TestDataFactory_tst.createSTPricingTemplate();
            IST__SuperTRUMP_Pricing_Quote__c pricingQuote = TestDataFactory_tst.createSTPricingQuote(oppa, pricingTemplate);
            pricingQuote.IST__QuoteStatus__c='Quoted';
            
            update pricingQuote;
            TBO018_Pricing__c pr= TestDataFactory_tst.createPricing(oppa, pricingQuote);
            pr.BKL_tx_Rationale_Comment__c = 'dfnvijndfovnadfv';
            pr.TBO018_tx_Pricing_Status__c='Approved';
            pr.TBO018_ca_Approved_by_Risk__c=true;
            update pr;
            system.debug('JD QOO:' + pricingQuote.IST__QuoteStatus__c);
            
            oppa.AccountId =acc.Id;
            oppa.OPP_ls_Region__c='Mexico 1';
            //oppa.OwnerId=us.Id;
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
            //oppa.StageName='Opportunity Identified';
            oppa.StageName='Proposal Awarded';
            
            oppa.Indirect_Vertical__c='Vendor Finance';
            oppa.OPP_ls_Vendor_Brand__c='Doosan Machine Tools Americas Corp';
            oppa.OPP_ls_Vendor_Distributor__c='Doosan Machine Tools Americas Corp';
            /*oppa.Indirect_Partner_Brand__c='Industrial';
            oppa.QLIK_ls_Vendor_Branch__c='SITSA CDMX';
            oppa.QLIK_ls_Vendor_Sales_Rep__c='Christopher Garcia';*/
            
            update oppa;
            
            oppa.StageName='Proposal';
            //update oppa;
            oppa.StageName='Proposal Awarded';
            //update oppa;
            Credit_approval_CP__c cap = new Credit_approval_CP__c(CPL_ls_StageName__c='New', CPL_rb_account__c=acc.Id,Risk_Analyst__c=us.Id,Sr_Underwriter__c=us.Id,Inside_Sales__c=us.Id);
            insert cap;
            Opportunity_in_Credit_approval_CP__c opinc1 = new Opportunity_in_Credit_approval_CP__c(	CP_rb_Credit_approval_CP__c=cap.id,CP_rb_Oportunidad__c=oppa.id);
            insert opinc1;
            
            ES3_controller_ColsingMemo a = new ES3_controller_ColsingMemo();
            
            //List<ES2_Obj_EntityMasterInCreditApproval__c>ls = Test.loadData(ES2_Obj_EntityMasterInCreditApproval__c.sobjectType, 'EttyInCaSR');
            
            a.CAparentId = cap.Id;
            a.cargaOpps();
            a.backToCA();
            
            ES3_WraperEntityStructure wpins = new ES3_WraperEntityStructure();
            a.cargaEntityEstructure();
            Test.startTest();
            ES2_Obj_EntityMasterInCreditApproval__c entty = new ES2_Obj_EntityMasterInCreditApproval__c(
                Name='lol',	
                ES3_tx_Risk_Classification__c='lol',
                ES3_tx_Or_Rating__c='12',
                ES3_tx_MRAID__c='12',
                ES3_tx_HNWI_ID__c='12',
                ES3_tx_BloombergID__c='12',
                ES3_rb_Opportunity_in_Credit_approval_CP__c	= opinc1.Id,
                ES3_rb_Opportunity__c=oppa.Id,
                ES2_tx_TopParetName__c='Juan Cuenta',
                ES2_tx_TopParentID__c='12',
                ES2_tx_Party_Id__c='12',
                ES2_tx_pageVF__c='lol',
                ES2_tx_Oracle_Account_Name__c='lol',
                ES2_tx_CostumerType__c='lol',
                ES2_rb_Credit_approval__c=cap.Id,
                ES2_ms_Role__c ='Obligor',
                CurrencyIsoCode='USD'
            );
            
            insert entty;
            a.cargaVarsEstructure(entty, wpins);
            a.cargaCAndCEstructure();
            ApexPages.StandardController stdcon2 =new ApexPages.StandardController(entty);
            
            ES2_Controller_EntityMasterInCreditApvl EnttyIncea = new ES2_Controller_EntityMasterInCreditApvl(stdcon2);
            //EnttyIncea.getOpportunitiesInCA();
            EnttyIncea.setsOpportunityIdSelected(oppa.Id);
            EnttyIncea.getsOpportunityIdSelected();
            list<ES2_Controller_EntityMasterInCreditApvl> lsents = new list<ES2_Controller_EntityMasterInCreditApvl>();
           
            EIV_EntityWrapClass  Entwrap = new EIV_EntityWrapClass();
            list<EIV_EntityWrapClass> lswrap = new list<EIV_EntityWrapClass>();
            Entwrap.Account_ID ='12';
            Entwrap.Bloomberg_ID='12';
            Entwrap.buroFlag='Yes';
            Entwrap.Company_Legal_Name_termination='lol';
            Entwrap.CRR='lol';
            Entwrap.CRR_Comments='lol';
            Entwrap.CRR_Override='lol';
            Entwrap.CURP='HEDJ0110HSPVRN05';
            Entwrap.Cust_AccountId='12';
            Entwrap.Customer_Alias='AS';
            Entwrap.Customer_Name='Juancho';
            Entwrap.Customer_Name='Juan';
            Entwrap.Customer_Status='Lead';
            Entwrap.Customer_Type='ECONOMIC GROUP';
            Entwrap.Economic_Group_ID='12';
            Entwrap.Economic_Group_Name='Juan';
            Entwrap.Economic_group_SIC_Code='999';
            Entwrap.Economic_group_SIC_CodeId='12';
            Entwrap.Economic_Group_SIC_Description='metales';
            Entwrap.EconomicGroupPartyId='12';
            Entwrap.Entity_Type='Individual';
            Entwrap.entityName='Sales';
            Entwrap.First_Last_Name='Joson';
            Entwrap.First_Name='jACO';
            Entwrap.Foreign_Entity='No';
            Entwrap.HNWI_ID='lol';
            Entwrap.Legal_Name_sin_denominacion='aasda';
            Entwrap.Limited_information_entity=true;
            Entwrap.Middle_Name='Mac';
            Entwrap.MRA_ID='12';
            Entwrap.Nationality='Mex';
            Entwrap.Oracle_Account_Name='as';
            Entwrap.Oracle_Account_Number='12312';
            Entwrap.Oracle_Create_Date= date.today();
           	Entwrap.Oracle_Updated_by='Jise';
            Entwrap.orRating='12';
            Entwrap.Party_Id='12';
            Entwrap.Prefix='magna';
            Entwrap.RFC='ADASDHJASDJ';
            Entwrap.riskClassification='no';
            Entwrap.Sales_Representative='lol';
            Entwrap.Second_Last_Name='Json';
            Entwrap.SF_Account_Name='Maria';
            Entwrap.SIC_Code='123';
            Entwrap.SIC_CodeId='12';
            Entwrap.SIC_CodeIndustry='metal';
            Entwrap.SIC_Description='maritimos';
            Entwrap.Source_Application_ID='SF';
            Entwrap.Source_Create_Date=date.today();
            Entwrap.Source_Created_by='Lol';
            Entwrap.Supplier_Flag='Y';
            Entwrap.Target_Market_Jurisdiction='lol';
            Entwrap.Tax_Regime='asdasd';
            Entwrap.TIN='12312312';
            Entwrap.Top_Parent_ID='12';
            Entwrap.Top_Parent_Name='josejose';
            lswrap.add(Entwrap);
            EnttyIncea.entities=lswrap;
           
           
            Test.setMock(HttpCalloutMock.class, new MockHttpEntitiesTP());
             EnttyIncea.setsEntityMasterIdSelected(entty.Id);
              EnttyIncea.getEGOptions();
             EnttyIncea.sTopParentId ='345';
            EnttyIncea.sSSO='123';
            EnttyIncea.sServiceURL='http://160.34.7.97:7033';
            EnttyIncea.entity =Entwrap;
            EnttyIncea.sEconomicGroupIdSelected ='Entwrap';
            EnttyIncea.sEntityMasterIdSelected ='Entwrap';
            EnttyIncea.sOpportunityIdSelected ='Entwrap';
             Test.setMock(HttpCalloutMock.class, new MockHttpcallBackcGeRequestForParty());
            EnttyIncea.searchRequest();
            //TERMINA CONSTRUCCION DEL CA
            EnttyIncea.getOpportunitiesInCA();
            EnttyIncea.UpdateChangeRoll();
        }
        Test.stopTest();
    }
    
    @Istest
    static void ES3_controller_entt2(){
        //Inicia creacion de Opps a proporsal awarded y credit approval , opps in ca
        Account acc;
        Opportunity oppa;
        User us;
        User thisUser = [ select Id from User where Id = :UserInfo.getUserId() ];
        
        System.runAs ( thisUser ) {
			us = TestDataFactory_tst.createUser('Juan@lol.com', 'Administrator', 'President & CEO');
        }
        system.runAs(us){
            acc = TestDataFactory_tst.createAccount();
            TBO022_Competitor__c comp = TestDataFactory_tst.createCompetitor();
            oppa = TestDataFactory_tst.createOpportunity(acc, us, comp);
            Contact con1 = TestDataFactory_tst.createContact();
            OpportunityContactRole cr = new OpportunityContactRole(OpportunityId=oppa.Id, ContactId=con1.Id, IsPrimary=true);
            insert cr;
            IST__SuperTRUMP_Template__c pricingTemplate = TestDataFactory_tst.createSTPricingTemplate();
            IST__SuperTRUMP_Pricing_Quote__c pricingQuote = TestDataFactory_tst.createSTPricingQuote(oppa, pricingTemplate);
            pricingQuote.IST__QuoteStatus__c='Quoted';
            
            update pricingQuote;
            TBO018_Pricing__c pr= TestDataFactory_tst.createPricing(oppa, pricingQuote);
            pr.BKL_tx_Rationale_Comment__c = 'dfnvijndfovnadfv';
            pr.TBO018_tx_Pricing_Status__c='Approved';
            pr.TBO018_ca_Approved_by_Risk__c=true;
            update pr;
            system.debug('JD QOO:' + pricingQuote.IST__QuoteStatus__c);
            
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
            //oppa.StageName='Opportunity Identified';
            oppa.StageName='Proposal Awarded';
            oppa.Indirect_Vertical__c='Vendor Finance';
            oppa.OPP_ls_Vendor_Brand__c='Doosan Machine Tools Americas Corp';
            oppa.OPP_ls_Vendor_Distributor__c='Doosan Machine Tools Americas Corp';
            /*oppa.Indirect_Partner_Brand__c='Industrial';
            oppa.QLIK_ls_Vendor_Branch__c='SITSA CDMX';
            oppa.QLIK_ls_Vendor_Sales_Rep__c='Christopher Garcia';*/
            
            update oppa;
            
            oppa.StageName='Proposal';
            //update oppa;
            oppa.StageName='Proposal Awarded';
            //update oppa;
            Credit_approval_CP__c cap = new Credit_approval_CP__c(CPL_ls_StageName__c='New', CPL_rb_account__c=acc.Id,Risk_Analyst__c=us.Id,Sr_Underwriter__c=us.Id,Inside_Sales__c=us.Id);
            insert cap;
            Opportunity_in_Credit_approval_CP__c opinc1 = new Opportunity_in_Credit_approval_CP__c(	CP_rb_Credit_approval_CP__c=cap.id,CP_rb_Oportunidad__c=oppa.id);
            insert opinc1;
            
            ES3_controller_ColsingMemo a = new ES3_controller_ColsingMemo();
            
            //List<ES2_Obj_EntityMasterInCreditApproval__c>ls = Test.loadData(ES2_Obj_EntityMasterInCreditApproval__c.sobjectType, 'EttyInCaSR');
            
            a.CAparentId = cap.Id;
            a.cargaOpps();
            a.backToCA();
            
            ES3_WraperEntityStructure wpins = new ES3_WraperEntityStructure();
            a.cargaEntityEstructure();
            Test.startTest();
            ES2_Obj_EntityMasterInCreditApproval__c entty = new ES2_Obj_EntityMasterInCreditApproval__c(
                Name='lol',	
                ES3_tx_Risk_Classification__c='lol',
                ES3_tx_Or_Rating__c='12',
                ES3_tx_MRAID__c='12',
                ES3_tx_HNWI_ID__c='12',
                ES3_tx_BloombergID__c='12',
                ES3_rb_Opportunity_in_Credit_approval_CP__c	= opinc1.Id,
                ES3_rb_Opportunity__c=oppa.Id,
                ES2_tx_TopParetName__c='Juan Cuenta',
                ES2_tx_TopParentID__c='12',
                ES2_tx_Party_Id__c='12',
                ES2_tx_pageVF__c='lol',
                ES2_tx_Oracle_Account_Name__c='lol',
                ES2_tx_CostumerType__c='lol',
                ES2_rb_Credit_approval__c=cap.Id,
                ES2_ms_Role__c ='Obligor',
                CurrencyIsoCode='USD'    
            );
            
            insert entty;
            a.cargaVarsEstructure(entty, wpins);
            a.cargaCAndCEstructure();
            
            ApexPages.StandardController stdcon2 =new ApexPages.StandardController(entty);
            ES2_Controller_EntityMasterInCreditApvl EnttyIncea = new ES2_Controller_EntityMasterInCreditApvl();
            
            //insert entty;
            //a.cargaVarsEstructure(entty, wpins);
            //a.cargaCAndCEstructure();
            //ApexPages.StandardController stdcon2 =new ApexPages.StandardController(entty);
            EnttyIncea = new ES2_Controller_EntityMasterInCreditApvl(stdcon2);
            
            //EnttyIncea.getOpportunitiesInCA();
            EnttyIncea.setsOpportunityIdSelected(oppa.Id);
            EnttyIncea.getsOpportunityIdSelected();
            EnttyIncea.backToCa();
            Map<string,object>entityDetail = new Map<string,object>();
            Map <string,object>sic = new Map<string,object>();
            Map<string,object>aml = new Map<string,object>();
            Map<string,object>rating = new Map<string,object>();
            
            EnttyIncea.responseToEntityObj(entityDetail, sic, aml, rating);
            cap.ES3_tx_Risk_Economic_Group_Id__c='12';
            update cap;
            EnttyIncea.CA = cap;
            system.debug('JD: RISK ' + EnttyIncea.CA.ES3_tx_Risk_Economic_Group_Id__c);
            EnttyIncea.sTopParentId ='345';
            EnttyIncea.sSSO='123';
            EnttyIncea.sServiceURL='http://160.34.7.97:7033';
            Test.setMock(HttpCalloutMock.class, new MockHttpEntitiesTP());
            //Test.setMock(HttpCalloutMock.class, new MockHttpcallBackGetRequestDetails());
           	EnttyIncea.getEMOptions();
            cap.ES3_tx_Risk_Economic_Group_Id__c='';
            update cap;
            EnttyIncea.vfTypeEntitieRead('INDIVIDUAL');
            EnttyIncea.vfTypeEntitieRead('Organization');
            EnttyIncea.vfTypeEntitieRead('LOL');
            EnttyIncea.urlValue='lol';
            EnttyIncea.sEconomicGroupIdSelected = '123';
            EnttyIncea.sEntityMasterIdSelected = '123';
            EnttyIncea.sOpportunityIdSelected = '123';
            
            
            EIV_EntityWrapClass  Entwrap = new EIV_EntityWrapClass();
            Entwrap.Account_ID ='12';
            Entwrap.Bloomberg_ID='12';
            Entwrap.buroFlag='Yes';
            Entwrap.Company_Legal_Name_termination='lol';
            Entwrap.CRR='lol';
            Entwrap.CRR_Comments='lol';
            Entwrap.CRR_Override='lol';
            Entwrap.CURP='HEDJ0110HSPVRN05';
            Entwrap.Cust_AccountId='12';
            Entwrap.Customer_Alias='AS';
            Entwrap.Customer_Name='Juancho';
            Entwrap.Customer_Name='Juan';
            Entwrap.Customer_Status='Lead';
            Entwrap.Customer_Type='ECONOMIC GROUP';
            Entwrap.Economic_Group_ID='12';
            Entwrap.Economic_Group_Name='Juan';
            Entwrap.Economic_group_SIC_Code='999';
            Entwrap.Economic_group_SIC_CodeId='12';
            Entwrap.Economic_Group_SIC_Description='metales';
            Entwrap.EconomicGroupPartyId='12';
            Entwrap.Entity_Type='Individual';
            Entwrap.entityName='Sales';
            Entwrap.First_Last_Name='Joson';
            Entwrap.First_Name='jACO';
            Entwrap.Foreign_Entity='No';
            Entwrap.HNWI_ID='lol';
            Entwrap.Legal_Name_sin_denominacion='aasda';
            Entwrap.Limited_information_entity=true;
            Entwrap.Middle_Name='Mac';
            Entwrap.MRA_ID='12';
            Entwrap.Nationality='Mex';
            Entwrap.Oracle_Account_Name='as';
            Entwrap.Oracle_Account_Number='12312';
            Entwrap.Oracle_Create_Date= date.today();
           	Entwrap.Oracle_Updated_by='Jise';
            Entwrap.orRating='12';
            Entwrap.Party_Id='12';
            Entwrap.Prefix='magna';
            Entwrap.RFC='ADASDHJASDJ';
            Entwrap.riskClassification='no';
            Entwrap.Sales_Representative='lol';
            Entwrap.Second_Last_Name='Json';
            Entwrap.SF_Account_Name='Maria';
            Entwrap.SIC_Code='123';
            Entwrap.SIC_CodeId='12';
            Entwrap.SIC_CodeIndustry='metal';
            Entwrap.SIC_Description='maritimos';
            Entwrap.Source_Application_ID='SF';
            Entwrap.Source_Create_Date=date.today();
            Entwrap.Source_Created_by='Lol';
            Entwrap.Supplier_Flag='Y';
            Entwrap.Target_Market_Jurisdiction='lol';
            Entwrap.Tax_Regime='asdasd';
            Entwrap.TIN='12312312';
            Entwrap.Top_Parent_ID='12';
            Entwrap.Top_Parent_Name='josejose';
            EnttyIncea.entity = Entwrap;
            
            //TERMINA CONSTRUCCION DEL CA
            
            
             Credit_approval_CP__c CAtoUpdate = new Credit_approval_CP__c(ES3_tx_Risk_Economic_Group_Id__c = 'test',
                                                                     CPI_tx_Risk_Economic_Group__c = 'test',
                                                                     CPI_rb_SIC_code__c = null,
                                                                     ES3_TX_MRA_ID__c = 'test',
                                                                     ES3_tx_Bloomberg_ID__c = 'test',
                                                                     ES3_TX_HNWI_ID__c = 'test',
                                                                          CPI_rb_OR_rating__c = null);
            insert CAtoUpdate;
            //CAtoUpdate.CA.Id = 
            EnttyIncea.sIdChild = entty.id;
            EnttyIncea.getsEconomicGroupIdSelected();
            EnttyIncea.DeleteEconomicGroup();
            EnttyIncea.CA.Id = CAtoUpdate.id;
            //EnttyIncea.DeleteEntity();
            EnttyIncea.refreshEntitiesFunction();
            EnttyIncea.refreshEntities();
            EnttyIncea.refreshEconomicGroup();
            EnttyIncea.SaveEconomicGroup();
            EnttyIncea.SaveData();
            
            EnttyIncea.getsEntityMasterIdSelected();
            EnttyIncea.sEconomicGroup = 'Saludos';
            EnttyIncea.detail = new EIV_DetailWrapClass();
            EnttyIncea.entities.add(Entwrap);
            EnttyIncea.setsEconomicGroupIdSelected('12');
            EnttyIncea.DeleteEntity();
            
            Test.setMock(HttpCalloutMock.class, new MockHttpcallBackGetRequestDetails());
            enttyIncea.getListEntities('12', 'getOneEntity');
            ES2_Controller_EntityMasterInCreditApvl.enttityCaDom();
            
        }
        Test.stopTest();
    }
    @Istest
    static void Call_Null_Data(){
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
                          username='standarduser22@testorg.com',
                          EmployeeNumber='123456');
            acc =new Account(Name='JuanCuentaa', BillingCity='Mexico', BillingCountry='México',BillingStreet='Escalopentra', BillingPostalCode='01230', BillingState='Ciudad de México');
            insert acc;
        }
        
        system.runAs(us){
            oppa = new Opportunity(Name ='oppa', Amount=20000, StageName='Lead', CloseDate=date.today(),OPP_ls_Line_of_Business__c='Equipment', OPP_ls_Collateral__c='Agricultural Equipment');
            insert oppa;
        }
        
        us = TestDataFactory_tst.createUser('Juan@lol.com', 'Administrator', 'President & CEO');
        us.EmployeeNumber ='123456';
        update us;
        system.runAs(us){
            Contact con1 = TestDataFactory_tst.createContact();
            OpportunityContactRole cr = new OpportunityContactRole(OpportunityId=oppa.Id, ContactId=con1.Id, IsPrimary=true);
            insert cr;
            IST__SuperTRUMP_Template__c pricingTemplate = TestDataFactory_tst.createSTPricingTemplate();
            IST__SuperTRUMP_Pricing_Quote__c pricingQuote = TestDataFactory_tst.createSTPricingQuote(oppa, pricingTemplate);
            pricingQuote.IST__QuoteStatus__c='Quoted';
            
            update pricingQuote;
            TBO018_Pricing__c pr= TestDataFactory_tst.createPricing(oppa, pricingQuote);
            pr.BKL_tx_Rationale_Comment__c = 'dfnvijndfovnadfv';
            pr.TBO018_tx_Pricing_Status__c='Approved';
            pr.TBO018_ca_Approved_by_Risk__c=true;
            update pr;
            system.debug('JD QOO:' + pricingQuote.IST__QuoteStatus__c);
            
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
            //oppa.StageName='Opportunity Identified';
            oppa.StageName='Proposal Awarded';
            oppa.Indirect_Vertical__c='Vendor Finance';
            oppa.OPP_ls_Vendor_Brand__c='Doosan Machine Tools Americas Corp';
            oppa.OPP_ls_Vendor_Distributor__c='Doosan Machine Tools Americas Corp';
            /*oppa.Indirect_Partner_Brand__c='Industrial';
            oppa.QLIK_ls_Vendor_Branch__c='SITSA CDMX';
            oppa.QLIK_ls_Vendor_Sales_Rep__c='Christopher Garcia';*/
            
            update oppa;
            
            oppa.StageName='Proposal';
            //update oppa;
            oppa.StageName='Proposal Awarded';
            //update oppa;
            Credit_approval_CP__c cap = new Credit_approval_CP__c(CPL_ls_StageName__c='New', CPL_rb_account__c=acc.Id,Risk_Analyst__c=us.Id,Sr_Underwriter__c=us.Id,Inside_Sales__c=us.Id);
            insert cap;
            Opportunity_in_Credit_approval_CP__c opinc1 = new Opportunity_in_Credit_approval_CP__c(	CP_rb_Credit_approval_CP__c=cap.id,CP_rb_Oportunidad__c=oppa.id);
            insert opinc1;
            
            ES2_Obj_EntityMasterInCreditApproval__c entty = new ES2_Obj_EntityMasterInCreditApproval__c(
                Name='lol',	
                ES3_tx_Risk_Classification__c='lol',
                ES3_tx_Or_Rating__c='12',
                ES3_tx_MRAID__c='12',
                ES3_tx_HNWI_ID__c='12',
                ES3_tx_BloombergID__c='12',
                ES3_rb_Opportunity_in_Credit_approval_CP__c	= opinc1.Id,
                ES3_rb_Opportunity__c=oppa.Id,
                ES2_tx_TopParetName__c='Juan Cuenta',
                ES2_tx_TopParentID__c='12',
                ES2_tx_Party_Id__c='12',
                ES2_tx_pageVF__c='lol',
                ES2_tx_Oracle_Account_Name__c='lol',
                ES2_tx_CostumerType__c='lol',
                ES2_rb_Credit_approval__c=cap.Id,
                ES2_ms_Role__c ='Obligor',
                CurrencyIsoCode='USD'           
            );
            
            insert entty;
            Test.startTest();
            ApexPages.StandardController stdcon2 =new ApexPages.StandardController(entty);
            ES2_Controller_EntityMasterInCreditApvl EnttyIncea = new ES2_Controller_EntityMasterInCreditApvl(stdcon2);
            update entty;
            Test.stopTest();
    }
    }
}