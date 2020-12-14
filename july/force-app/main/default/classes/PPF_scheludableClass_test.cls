@isTest
public class PPF_scheludableClass_test {
    @isTest static void executeTesttrue(){
        Account acc;
        Opportunity oppa;
        User us;
        EIV_Parameter__c pa_fecha;
        EIV_Parameter__c pa_min;
        EIV_Parameter__c pa_max;
        Takedowns_Contingency_plan__c take;
        TBO021_Takedowns_forecast__c fore;
        Entity_CP__c entity;
        User thisUser = [ select Id from User where Id = :UserInfo.getUserId() ];
        
        System.runAs ( thisUser ) {
            Profile p = [select id from profile where name='Administrator'];
            UserRole r = [Select id from userrole where name='President & CEO'];
            us = new User(alias = 'standt', email='standarduser22@testorg.com', 
                          emailencodingkey='UTF-8', lastname='Testing', 
                          languagelocalekey='en_US', 
                          USU_ls_Region__c = 'Mexico 1',
                          localesidkey='en_US', profileid = p.Id, userroleid = r.Id,
                          timezonesidkey='America/Los_Angeles', 
                          username='standarduser22@testorg.com');
            acc =new Account(Name='JuanCuentaa', BillingCity='Mexico', BillingCountry='México',BillingStreet='Escalopentra', BillingPostalCode='01230', BillingState='Ciudad de México');
            insert acc;
        }
        
        system.runAs(us){
            entity = new Entity_CP__c(Name='hola1', CPI_tx_RFC_TIN__c='343434534retertre',Mexican_State__c='Ciudad de México');
            insert entity;
            pa_min = new EIV_Parameter__c(Name='PP_Limite_min',
                                     EIV_tx_parameter__c='2.0');
            insert pa_min;
            
            pa_fecha = new EIV_Parameter__c(Name='fecha limite',
                                     EIV_tx_parameter__c='2020-11-01');
            insert pa_fecha;
            
            
            pa_max = new EIV_Parameter__c(Name='PP_Limite_max',
                                     EIV_tx_parameter__c='5.0');
            insert pa_max;
            
            oppa = new Opportunity(Name ='oppa',
                                   Amount=200000,
                                   StageName='Lead',
                                   CPL_dv_Approved_Amount__c=1000000,
                                   CloseDate=date.today(),
                                   OPP_ls_Line_of_Business__c='Equipment',
                                   OPP_ls_Collateral__c='Agricultural Equipment');
            insert oppa;
            fore = new TBO021_Takedowns_forecast__c (TBO021_rb_Opportunity__c=oppa.id,
                                                    TBO021_ls_Committed__c='No',
                                                    TBO021_dv_Amount__c=1,
                                                     CLI_rb_Customer_Name__c=entity.id,
                                                     Progress_Payment_Number__c='1',
                                                     TBO021_ls_Status__c='New',
                                                     Deal_Category__c='	New Origination',
                                                    TBO021_fh_Delivery_Date__c=date.today(),
                                                    TBO021_fh_Funding_Date__c=date.today(),
                                                    TBO021_ls_Invoice_Currency__c='MXN');
            insert fore;
            IST__SuperTRUMP_Template__c pricingTemplate = TestDataFactory_tst.createSTPricingTemplate();
            IST__SuperTRUMP_Pricing_Quote__c pricingQuote = TestDataFactory_tst.createSTPricingQuotePP(oppa, pricingTemplate);
            
            
            take = new Takedowns_Contingency_plan__c (CPL_ls_Stage__c='New',
                                                      CLI_nu_PP_Number__c=1,
                									CPL_ls_Deal_Category__c='Progress Payment',
                                                      
                                                      Financing_Needs__c='CapEx Lines',
                                                      Line_of_Business__c='Equipment',
                                                      CPL_rb_Opp__c=oppa.id,
                                                      CPL_ls_Start_of_leasing__c='No',
                                                      CPL_rb_Entity_Name_CP__c=entity.id,
                                                      TDAmount__c=1,
                                                      CLI_txt_Inside_Sales_Comments__c='hola',
                                                      Contract_Annex_Number__c='tere',
                                                      CPL_ls_Operation_Unit__c='UO_397 HOLDING',
                                                      CPL_nu_TD_Echange_Rate__c=1,
                                                      Annex_Pricing_SuperTrump__c=pricingQuote.id,
                                                      CLI_lsInvoice_Currency__c='MXN',
                                                      CurrencyIsoCode='USD',
                                                      CLI_rb_Inside_sales_owner__c= us.Id,
                                                      Takedowns_forecast__c=fore.id
                                                     );
            insert take;
            //PPF_userClass a = new PPF_userClass();
            //a.actualizarOps();
        }
    }
    
    @isTest static void executeTestfalse(){
        Account acc;
        Opportunity oppa;
        User us;
        EIV_Parameter__c pa_fecha;
        EIV_Parameter__c pa_min;
        EIV_Parameter__c pa_max;
        Takedowns_Contingency_plan__c take;
        TBO021_Takedowns_forecast__c fore;
        Entity_CP__c entity;
        User thisUser = [ select Id from User where Id = :UserInfo.getUserId() ];
        
        System.runAs ( thisUser ) {
            Profile p = [select id from profile where name='Administrator'];
            UserRole r = [Select id from userrole where name='President & CEO'];
            us = new User(alias = 'standt', email='standarduser22@testorg.com', 
                          emailencodingkey='UTF-8', lastname='Testing', 
                          languagelocalekey='en_US', 
                          USU_ls_Region__c = 'Mexico 1',
                          localesidkey='en_US', profileid = p.Id, userroleid = r.Id,
                          timezonesidkey='America/Los_Angeles', 
                          username='standarduser22@testorg.com');
            acc =new Account(Name='JuanCuentaa', BillingCity='Mexico', BillingCountry='México',BillingStreet='Escalopentra', BillingPostalCode='01230', BillingState='Ciudad de México');
            insert acc;
        }
        
        system.runAs(us){
            entity = new Entity_CP__c(Name='hola1', CPI_tx_RFC_TIN__c='343434534retertre',Mexican_State__c='Ciudad de México');
            insert entity;
            pa_min = new EIV_Parameter__c(Name='PP_Limite_min',
                                     EIV_tx_parameter__c='2.0');
            insert pa_min;
            
            pa_fecha = new EIV_Parameter__c(Name='fecha limite',
                                     EIV_tx_parameter__c='2018-11-01');
            insert pa_fecha;
            
            
            pa_max = new EIV_Parameter__c(Name='PP_Limite_max',
                                     EIV_tx_parameter__c='5.0');
            insert pa_max;
            oppa = new Opportunity(Name ='oppa',
                                   Amount=20000000,
                                   StageName='Lead',
                                   CPL_dv_Approved_Amount__c=1000000,
                                   CloseDate=date.today(),
                                   OPP_ls_Line_of_Business__c='Equipment',
                                   OPP_ls_Collateral__c='Agricultural Equipment');
            insert oppa;
            fore = new TBO021_Takedowns_forecast__c (TBO021_rb_Opportunity__c=oppa.id,
                                                    TBO021_ls_Committed__c='No',
                                                    TBO021_dv_Amount__c=1,
                                                     CLI_rb_Customer_Name__c=entity.id,
                                                     Progress_Payment_Number__c='1',
                                                     TBO021_ls_Status__c='New',
                                                     Deal_Category__c='	New Origination',
                                                    TBO021_fh_Delivery_Date__c=date.today(),
                                                    TBO021_fh_Funding_Date__c=date.today(),
                                                    TBO021_ls_Invoice_Currency__c='MXN');
            insert fore;
            IST__SuperTRUMP_Template__c pricingTemplate = TestDataFactory_tst.createSTPricingTemplate();
            IST__SuperTRUMP_Pricing_Quote__c pricingQuote = TestDataFactory_tst.createSTPricingQuotePP(oppa, pricingTemplate);
            
            
            take = new Takedowns_Contingency_plan__c (CPL_ls_Stage__c='New',
                                                      CLI_nu_PP_Number__c=1,
                									CPL_ls_Deal_Category__c='Progress Payment',
                                                      Financing_Needs__c='CapEx Lines',
                                                      Line_of_Business__c='Equipment',
                                                      CPL_rb_Opp__c=oppa.id,
                                                      CPL_ls_Start_of_leasing__c='No',
                                                      CPL_rb_Entity_Name_CP__c=entity.id,
                                                      TDAmount__c=1,
                                                      CLI_txt_Inside_Sales_Comments__c='hola',
                                                      Contract_Annex_Number__c='tere',
                                                      CPL_ls_Operation_Unit__c='UO_397 HOLDING',
                                                      CPL_nu_TD_Echange_Rate__c=1,
                                                      Annex_Pricing_SuperTrump__c=pricingQuote.id,
                                                      CLI_lsInvoice_Currency__c='MXN',
                                                      CurrencyIsoCode='USD',
                                                      //CLI_rb_Inside_sales_owner__c= us.Id,
                                                      Takedowns_forecast__c=fore.id
                                                     );
            insert take;
            
            pricingQuote.IST__Commencement__c =date.valueOf('2018-11-03');
            update pricingQuote;
            take.TDAmount__c=2;
            
            update take;
            //PPF_userClass a = new PPF_userClass();
            //a.actualizarOps();
        }
    }
}