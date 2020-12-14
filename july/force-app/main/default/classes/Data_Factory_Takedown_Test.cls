@IsTest
public class Data_Factory_Takedown_Test {
   public static Takedowns_Contingency_plan__c createTakedown(string productType, string entityCPName, string entityCPRFCTIN){
       Opportunity opp = Data_Factory_Opportunity_Test.createNewOpportunityTypeWK();
       TBO021_Takedowns_forecast__c forecast = Data_Factory_EasyForecast_Test.createForecast(opp.Id);
       IST__SuperTRUMP_Template__c template = TestDataFactory_tst.createSTPricingTemplate();
       IST__SuperTRUMP_Pricing_Quote__c pq = TestDataFactory_tst.createSTPricingQuote(opp,template);
       Test.startTest();
       Entity_CP__c entitycp = Data_Factory_EntityCp.createEntityCP(entityCPName, entityCPRFCTIN );
       Takedowns_Contingency_plan__c takedown = new Takedowns_Contingency_plan__c();
       takedown.CPL_ls_Stage__c = 'New';
       takedown.CPL_rb_Entity_Name_CP__c =entitycp.Id;
       takedown.Takedowns_forecast__c = forecast.Id;
       takedown.Annex_Pricing_SuperTrump__c = pq.Id;
       takedown.TKD_ls_takedown_stage__c ='Converted';
       takedown.CPL_ls_Deal_Category__c ='Refi';
       takedown.Financing_Needs__c ='CapEx Lines';
       takedown.CPL_rb_Opp__c = opp.Id;
       takedown.TDAmount__c =1.00;
       takedown.Contract_Annex_Number__c= '13213124';
       takedown.Invoice_Exchange_Rate__c =19.147400;
       takedown.CPL_ls_Operation_Unit__c ='	UO_397 HOLDING';
       takedown.CLI_lsInvoice_Currency__c ='MXN';
       takedown.CPL_ls_Product__c =productType;
       insert takedown;
       Test.stopTest();
       system.debug('Takedwon creado:' + takedown.Id);
       return takedown;
   }
    public static Takedowns_Contingency_plan__c createTakedownToValidateInvoices(string productType, string entityCPName, string entityCPRFCTIN){
       Opportunity opp = Data_Factory_Opportunity_Test.createNewOpportunityTypeWK();
       TBO021_Takedowns_forecast__c forecast = Data_Factory_EasyForecast_Test.createForecast(opp.Id);
       IST__SuperTRUMP_Template__c template = TestDataFactory_tst.createSTPricingTemplate();
       IST__SuperTRUMP_Pricing_Quote__c pq = TestDataFactory_tst.createSTPricingQuote(opp,template);
       
       Entity_CP__c entitycp = Data_Factory_EntityCp.createEntityCP(entityCPName, entityCPRFCTIN );
       Takedowns_Contingency_plan__c takedown = new Takedowns_Contingency_plan__c();
       takedown.CPL_ls_Stage__c = 'New';
       takedown.CPL_rb_Entity_Name_CP__c =entitycp.Id;
       takedown.Takedowns_forecast__c = forecast.Id;
       takedown.Annex_Pricing_SuperTrump__c = pq.Id;
       takedown.TKD_ls_takedown_stage__c ='Converted';
       takedown.CPL_ls_Deal_Category__c ='Refi';
       takedown.Financing_Needs__c ='CapEx Lines';
       takedown.CPL_rb_Opp__c = opp.Id;
       takedown.TDAmount__c =1.00;
       takedown.Contract_Annex_Number__c= '13213124';
       takedown.Invoice_Exchange_Rate__c =19.147400;
       takedown.CPL_ls_Operation_Unit__c ='	UO_397 HOLDING';
       takedown.CLI_lsInvoice_Currency__c ='MXN';
       takedown.CPL_ls_Product__c =productType;
       insert takedown;
       system.debug('Takedwon creado:' + takedown.Id);
       return takedown;
   }
    
    
    public static Takedowns_Contingency_plan__c createTakedownNowkoppStart(string productType, string entityCPName, string entityCPRFCTIN){
        Test.startTest();
       Opportunity opp = Data_Factory_Opportunity_Test.createNewOpportunityTypeSales();
       TBO021_Takedowns_forecast__c forecast = Data_Factory_EasyForecast_Test.createForecast(opp.Id);
       IST__SuperTRUMP_Template__c template = TestDataFactory_tst.createSTPricingTemplate();
       IST__SuperTRUMP_Pricing_Quote__c pq = TestDataFactory_tst.createSTPricingQuote(opp,template);
       Entity_CP__c entitycp = Data_Factory_EntityCp.createEntityCP(entityCPName, entityCPRFCTIN );
       Takedowns_Contingency_plan__c takedown = new Takedowns_Contingency_plan__c();
       takedown.CPL_ls_Stage__c = 'New';
       takedown.CPL_rb_Entity_Name_CP__c =entitycp.Id;
       takedown.Takedowns_forecast__c = forecast.Id;
       takedown.Annex_Pricing_SuperTrump__c = pq.Id;
       takedown.TKD_ls_takedown_stage__c ='Converted';
       takedown.CPL_ls_Deal_Category__c ='Refi';
       takedown.Financing_Needs__c ='CapEx Lines';
       takedown.CPL_rb_Opp__c = opp.Id;
       takedown.TDAmount__c =1.00;
       takedown.Contract_Annex_Number__c= '13213124';
       takedown.Invoice_Exchange_Rate__c =19.147400;
       takedown.CPL_ls_Operation_Unit__c ='	UO_397 HOLDING';
       takedown.CLI_lsInvoice_Currency__c ='MXN';
       takedown.CPL_ls_Product__c =productType;
       insert takedown;
       system.debug('Takedwon creado:' + takedown.Id);
        test.stopTest();
       return takedown;
   }
    
    public static Takedowns_Contingency_plan__c createTakedownNowkopp(string productType, string entityCPName, string entityCPRFCTIN){
       
       Opportunity opp = Data_Factory_Opportunity_Test.createNewOpportunityTypeSales();
       TBO021_Takedowns_forecast__c forecast = Data_Factory_EasyForecast_Test.createForecast(opp.Id);
       IST__SuperTRUMP_Template__c template = TestDataFactory_tst.createSTPricingTemplate();
       IST__SuperTRUMP_Pricing_Quote__c pq = TestDataFactory_tst.createSTPricingQuote(opp,template);
       Entity_CP__c entitycp = Data_Factory_EntityCp.createEntityCP(entityCPName, entityCPRFCTIN );
       Takedowns_Contingency_plan__c takedown = new Takedowns_Contingency_plan__c();
       takedown.CPL_ls_Stage__c = 'New';
       takedown.CPL_rb_Entity_Name_CP__c =entitycp.Id;
       takedown.Takedowns_forecast__c = forecast.Id;
       takedown.Annex_Pricing_SuperTrump__c = pq.Id;
       takedown.TKD_ls_takedown_stage__c ='Converted';
       takedown.CPL_ls_Deal_Category__c ='Refi';
       takedown.Financing_Needs__c ='CapEx Lines';
       takedown.CPL_rb_Opp__c = opp.Id;
       takedown.TDAmount__c =1.00;
       takedown.Contract_Annex_Number__c= '13213124';
       takedown.Invoice_Exchange_Rate__c =19.147400;
       takedown.CPL_ls_Operation_Unit__c ='	UO_397 HOLDING';
       takedown.CLI_lsInvoice_Currency__c ='MXN';
       takedown.CPL_ls_Product__c =productType;
       insert takedown;
       system.debug('Takedwon creado:' + takedown.Id);
      
       return takedown;
   }
    
    
   /* public static Takedowns_Contingency_plan__c createTakedown(string productType, string entityCPName, string entityCPRFCTIN){
       Opportunity opp = Data_Factory_Opportunity_Test.createNewOpportunityTypeWK();
       TBO021_Takedowns_forecast__c forecast = Data_Factory_EasyForecast_Test.createForecast(opp.Id);
       IST__SuperTRUMP_Template__c template = TestDataFactory_tst.createSTPricingTemplate();
       IST__SuperTRUMP_Pricing_Quote__c pq = TestDataFactory_tst.createSTPricingQuote(opp,template);
       Test.startTest();
       Entity_CP__c entitycp = Data_Factory_EntityCp.createEntityCP(entityCPName, entityCPRFCTIN );
       Takedowns_Contingency_plan__c takedown = new Takedowns_Contingency_plan__c();
       takedown.CPL_ls_Stage__c = 'New';
       takedown.CPL_rb_Entity_Name_CP__c =entitycp.Id;
       takedown.Takedowns_forecast__c = forecast.Id;
       takedown.Annex_Pricing_SuperTrump__c = pq.Id;
       takedown.TKD_ls_takedown_stage__c ='Converted';
       takedown.CPL_ls_Deal_Category__c ='Refi';
       takedown.Financing_Needs__c ='CapEx Lines';
       takedown.CPL_rb_Opp__c = opp.Id;
       takedown.TDAmount__c =1.00;
       takedown.Contract_Annex_Number__c= '13213124';
       takedown.Invoice_Exchange_Rate__c =19.147400;
       takedown.CPL_ls_Operation_Unit__c ='	UO_397 HOLDING';
       takedown.CLI_lsInvoice_Currency__c ='MXN';
       takedown.CPL_ls_Product__c =productType;
       insert takedown;
       Test.stopTest();
       system.debug('Takedwon creado:' + takedown.Id);
       return takedown;
   }*/
    
    
    public static Takedowns_Contingency_plan__c createTakedownNowkoppForApproval(string productType, string entityCPName, string entityCPRFCTIN){
       Opportunity opp = Data_Factory_Opportunity_Test.createNewOpportunityTypeSales();
       TBO021_Takedowns_forecast__c forecast = Data_Factory_EasyForecast_Test.createForecast(opp.Id);
       IST__SuperTRUMP_Template__c template = TestDataFactory_tst.createSTPricingTemplate();
       IST__SuperTRUMP_Pricing_Quote__c pq = TestDataFactory_tst.createSTPricingQuote(opp,template);
       Entity_CP__c entitycp = Data_Factory_EntityCp.createEntityCP(entityCPName, entityCPRFCTIN );
       Takedowns_Contingency_plan__c takedown = new Takedowns_Contingency_plan__c();
       takedown.TKD_ls_takedown_stage__c ='Tollgate 1';
       takedown.CPL_rb_Entity_Name_CP__c =entitycp.Id;
       takedown.Takedowns_forecast__c = forecast.Id;
       takedown.Annex_Pricing_SuperTrump__c = pq.Id;
       takedown.CPL_ls_Deal_Category__c ='Refi';
       takedown.Financing_Needs__c ='CapEx Lines';
       takedown.CPL_rb_Opp__c = opp.Id;
       takedown.TDAmount__c =1.00;
       takedown.Contract_Annex_Number__c= '13213124';
       takedown.Invoice_Exchange_Rate__c =19.147400;
       takedown.CPL_ls_Operation_Unit__c ='	UO_397 HOLDING';
       takedown.CLI_lsInvoice_Currency__c ='MXN';
       takedown.CPL_ls_Product__c =productType;
       insert takedown;
       system.debug('Takedwon creado:' + takedown.Id);
       return takedown;
   }
    
    public static Takedowns_Contingency_plan__c createTakedownNowkoppProgress(string productType, string entityCPName, string entityCPRFCTIN){
       
       Opportunity opp = Data_Factory_Opportunity_Test.createNewOpportunityTypeSales();
       TBO021_Takedowns_forecast__c forecast = Data_Factory_EasyForecast_Test.createForecast(opp.Id);
       IST__SuperTRUMP_Template__c template = TestDataFactory_tst.createSTPricingTemplate();
       IST__SuperTRUMP_Pricing_Quote__c pq = TestDataFactory_tst.createSTPricingQuote(opp,template);
       Entity_CP__c entitycp = Data_Factory_EntityCp.createEntityCP(entityCPName, entityCPRFCTIN );
       Takedowns_Contingency_plan__c takedown = new Takedowns_Contingency_plan__c();
       takedown.CPL_ls_Stage__c = 'New';
       takedown.CPL_rb_Entity_Name_CP__c =entitycp.Id;
       takedown.Takedowns_forecast__c = forecast.Id;
       takedown.Annex_Pricing_SuperTrump__c = pq.Id;
       takedown.TKD_ls_takedown_stage__c ='Converted';
       takedown.CPL_ls_Deal_Category__c ='Progress Payment';
       takedown.Financing_Needs__c ='CapEx Lines';
       takedown.CPL_rb_Opp__c = opp.Id;
       takedown.TDAmount__c =1.00;
       takedown.Contract_Annex_Number__c= '13213124';
       takedown.Invoice_Exchange_Rate__c =19.147400;
       takedown.CPL_ls_Operation_Unit__c ='	UO_397 HOLDING';
       takedown.CLI_lsInvoice_Currency__c ='MXN';
       takedown.CPL_ls_Product__c =productType;
       takedown.CPL_ls_Start_of_leasing__c ='Yes';
       takedown.CLI_nu_PP_Number__c =1;
       insert takedown;
       system.debug('Takedwon creado:' + takedown.Id);
      
       return takedown;
   }
    
   public static Takedowns_Contingency_plan__c createTKDLMM(){
        test.startTest();
        Account acc = Data_Factory_Account_Test.createNewAccount('Account de prueba');
        Opportunity opp = Data_Factory_Opportunity_Test.createNewOpportunityTypeLMM();
        Takedowns_Contingency_plan__c Takedowns_Contingency_plan = new Takedowns_Contingency_plan__c();
        Takedowns_Contingency_plan.CPL_ls_Deal_Category__c = 'Not new origination';
        Takedowns_Contingency_plan.Financing_Needs__c = 'CapEx Lines';
        Takedowns_Contingency_plan.CPL_rb_Opp__c = opp.id;
        Takedowns_Contingency_plan.CLI_rb_Inside_Sales_Owner__c = UserInfo.getUserId();
        Takedowns_Contingency_plan.TDAmount__c = 1;
        Takedowns_Contingency_plan.CPL_nu_TD_Echange_Rate__c = 19.147400;
        Takedowns_Contingency_plan.CPL_ls_Operation_Unit__c = 'UO_397 HOLDING';
        Takedowns_Contingency_plan.CPL_ls_Product__c = 'OPERFIN-FIJA';
        Takedowns_Contingency_plan.Contract_Annex_Number__c = '1';
        Takedowns_Contingency_plan.CLI_lsInvoice_Currency__c = 'USD';
        Takedowns_Contingency_plan.RecordTypeId = Schema.SObjectType.Takedowns_Contingency_plan__c.getRecordTypeInfosByName().get('Takedown LMM').getRecordTypeId();
        insert Takedowns_Contingency_plan;
        test.stopTest();
        return Takedowns_Contingency_plan;
    }
    
    
    
}