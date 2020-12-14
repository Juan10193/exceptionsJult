@IsTest
public class Takedown_utils {
    public static Takedowns_Contingency_plan__c createdTakedownOrg(String productType, String entityCPName, String entityCPRFCTIN) {
        Opportunity idOpportunity = Takedown_info_util.createOpportunity();
        TBO002_SIC_code__c idSICCode = Takedown_info_util.createSICCode();
        Account idCuenta = Takedown_info_util.createAccount(idSICCode.Id);
        Catalogo_Colaterals__c idColateral = Takedown_info_util.createCollaterals();
        
        TBO021_Takedowns_forecast__c forecast = Data_Factory_EasyForecast_Test.createForecast(idOpportunity.Id);
		IST__SuperTRUMP_Template__c template = TestDataFactory_tst.createSTPricingTemplate();
		IST__SuperTRUMP_Pricing_Quote__c pq = TestDataFactory_tst.createSTPricingQuote(idOpportunity,template);
        Entity_CP__c entitycp = Data_Factory_EntityCp.createEntityCP(entityCPName, entityCPRFCTIN );
        LMM_Entidad_de_oportunidad__c LMM_Entidad_de_oportunidad = new LMM_Entidad_de_oportunidad__c(LMM_pd_Oportunidad__c = idOpportunity.Id,
                                                                                                     LMM_pd_Entity_CP__c = entitycp.Id, 
                                                                                                     LMM_ls_Entity_Type__c = 'ORGANIZATION');
        insert LMM_Entidad_de_oportunidad;
        
        Id recordTypeID = Schema.SObjectType.Takedowns_Contingency_plan__c.getRecordTypeInfosByName().get('Takedown LMM').getRecordTypeId();
        Takedowns_Contingency_plan__c takedownCP = new Takedowns_Contingency_plan__c();
		takedownCP.CPL_ls_Stage__c = 'New';
		takedownCP.CPL_rb_Entity_Name_CP__c =entitycp.Id;
		takedownCP.Takedowns_forecast__c = forecast.Id;
		takedownCP.Annex_Pricing_SuperTrump__c = pq.Id;
		takedownCP.TKD_ls_takedown_stage__c ='Converted';
		takedownCP.CPL_ls_Deal_Category__c ='Refi';
		takedownCP.Financing_Needs__c ='CapEx Lines';
		takedownCP.CPL_rb_Opp__c = idOpportunity.Id;
		takedownCP.TDAmount__c =1.00;
		takedownCP.Contract_Annex_Number__c= '13213124';
		takedownCP.Invoice_Exchange_Rate__c =19.147400;
		takedownCP.CPL_ls_Operation_Unit__c ='	UO_397 HOLDING';
		takedownCP.CLI_lsInvoice_Currency__c ='MXN';
		takedownCP.CPL_ls_Product__c =productType;
        takedownCP.RecordTypeId = recordTypeID;
		insert takedownCP;
        
        Takedown_info_util.createAsset(idCuenta.Id, idColateral.Id, takedownCP.Id);
        
        return takedownCP;
    }
    
    public static Takedowns_Contingency_plan__c createdTakedownInd(String productType, String entityCPName, String entityCPRFCTIN) {
        Opportunity idOpportunity = Takedown_info_util.createOpportunity();
        TBO002_SIC_code__c idSICCode = Takedown_info_util.createSICCode();
        Account idCuenta = Takedown_info_util.createAccount(idSICCode.Id);
        Catalogo_Colaterals__c idColateral = Takedown_info_util.createCollaterals();
        
        TBO021_Takedowns_forecast__c forecast = Data_Factory_EasyForecast_Test.createForecast(idOpportunity.Id);
		IST__SuperTRUMP_Template__c template = TestDataFactory_tst.createSTPricingTemplate();
		IST__SuperTRUMP_Pricing_Quote__c pq = TestDataFactory_tst.createSTPricingQuote(idOpportunity,template);
        Entity_CP__c entitycp = Data_Factory_EntityCp.createEntityCP(entityCPName, entityCPRFCTIN );
        LMM_Entidad_de_oportunidad__c LMM_Entidad_de_oportunidad = new LMM_Entidad_de_oportunidad__c(LMM_pd_Oportunidad__c = idOpportunity.Id,
                                                                                                     LMM_pd_Entity_CP__c = entitycp.Id, 
                                                                                                     LMM_ls_Entity_Type__c = 'INDIVIDUAL');
        insert LMM_Entidad_de_oportunidad;
        
        Id recordTypeID = Schema.SObjectType.Takedowns_Contingency_plan__c.getRecordTypeInfosByName().get('Takedown LMM').getRecordTypeId();
        Takedowns_Contingency_plan__c takedownCP = new Takedowns_Contingency_plan__c();
		takedownCP.CPL_ls_Stage__c = 'New';
		takedownCP.CPL_rb_Entity_Name_CP__c =entitycp.Id;
		takedownCP.Takedowns_forecast__c = forecast.Id;
		takedownCP.Annex_Pricing_SuperTrump__c = pq.Id;
		takedownCP.TKD_ls_takedown_stage__c ='Converted';
		takedownCP.CPL_ls_Deal_Category__c ='Refi';
		takedownCP.Financing_Needs__c ='CapEx Lines';
		takedownCP.CPL_rb_Opp__c = idOpportunity.Id;
		takedownCP.TDAmount__c =1.00;
		takedownCP.Contract_Annex_Number__c= '13213124';
		takedownCP.Invoice_Exchange_Rate__c =19.147400;
		takedownCP.CPL_ls_Operation_Unit__c ='	UO_397 HOLDING';
		takedownCP.CLI_lsInvoice_Currency__c ='MXN';
		takedownCP.CPL_ls_Product__c =productType;
        takedownCP.RecordTypeId = recordTypeID;
		insert takedownCP;
        
        Takedown_info_util.createAsset(idCuenta.Id, idColateral.Id, takedownCP.Id);
        
        return takedownCP;
    }
    
    public static Takedowns_Contingency_plan__c createdTakedownOldOrg(String productType, String entityCPName, String entityCPRFCTIN) {
        Opportunity idOpportunity = Takedown_info_util.createOpportunityOld();
        TBO002_SIC_code__c idSICCode = Takedown_info_util.createSICCode();
        Account idCuenta = Takedown_info_util.createAccount(idSICCode.Id);
        Catalogo_Colaterals__c idColateral = Takedown_info_util.createCollaterals();
        Credit_approval_CP__c creditApproval = Takedown_info_util.createApproval(idCuenta.Id);
        ES2_Obj_EntityMasterInCreditApproval__c entityMasterCredit = Takedown_info_util.createCreditAndApprove(creditApproval.Id, idOpportunity.Id);
        
        TBO021_Takedowns_forecast__c forecast = Data_Factory_EasyForecast_Test.createForecast(idOpportunity.Id);
		IST__SuperTRUMP_Template__c template = TestDataFactory_tst.createSTPricingTemplate();
		IST__SuperTRUMP_Pricing_Quote__c pq = TestDataFactory_tst.createSTPricingQuote(idOpportunity,template);
        Entity_CP__c entitycp = Data_Factory_EntityCp.createEntityCP(entityCPName, entityCPRFCTIN );

        Id recordTypeID = Schema.SObjectType.Takedowns_Contingency_plan__c.getRecordTypeInfosByName().get('Takedown').getRecordTypeId();
        Takedowns_Contingency_plan__c takedownCP = new Takedowns_Contingency_plan__c();
		takedownCP.CPL_ls_Stage__c = 'New';
		takedownCP.CPL_rb_Entity_Name_CP__c =entitycp.Id;
		takedownCP.Takedowns_forecast__c = forecast.Id;
		takedownCP.Annex_Pricing_SuperTrump__c = pq.Id;
		takedownCP.TKD_ls_takedown_stage__c ='Converted';
		takedownCP.CPL_ls_Deal_Category__c ='Refi';
		takedownCP.Financing_Needs__c ='CapEx Lines';
		takedownCP.CPL_rb_Opp__c = idOpportunity.Id;
		takedownCP.TDAmount__c =1.00;
		takedownCP.Contract_Annex_Number__c= '13213124';
		takedownCP.Invoice_Exchange_Rate__c =19.147400;
		takedownCP.CPL_ls_Operation_Unit__c ='	UO_397 HOLDING';
		takedownCP.CLI_lsInvoice_Currency__c ='MXN';
		takedownCP.CPL_ls_Product__c =productType;
        takedownCP.RecordTypeId = recordTypeID;
		insert takedownCP;
        
        Takedown_info_util.createAsset(idCuenta.Id, idColateral.Id, takedownCP.Id);
        
        return takedownCP;
    }
    
    public static Takedowns_Contingency_plan__c createdTakedownOldInd(String productType, String entityCPName, String entityCPRFCTIN) {
        Opportunity idOpportunity = Takedown_info_util.createOpportunityOld();
        TBO002_SIC_code__c idSICCode = Takedown_info_util.createSICCode();
        Account idCuenta = Takedown_info_util.createAccount(idSICCode.Id);
        Catalogo_Colaterals__c idColateral = Takedown_info_util.createCollaterals();
        Credit_approval_CP__c creditApproval = Takedown_info_util.createApproval(idCuenta.Id);
        ES2_Obj_EntityMasterInCreditApproval__c entityMasterCredit = Takedown_info_util.createCreditAndApproveInd(creditApproval.Id, idOpportunity.Id);
        
        TBO021_Takedowns_forecast__c forecast = Data_Factory_EasyForecast_Test.createForecast(idOpportunity.Id);
		IST__SuperTRUMP_Template__c template = TestDataFactory_tst.createSTPricingTemplate();
		IST__SuperTRUMP_Pricing_Quote__c pq = TestDataFactory_tst.createSTPricingQuote(idOpportunity,template);
        Entity_CP__c entitycp = Data_Factory_EntityCp.createEntityCP(entityCPName, entityCPRFCTIN );

        Id recordTypeID = Schema.SObjectType.Takedowns_Contingency_plan__c.getRecordTypeInfosByName().get('Takedown').getRecordTypeId();
        Takedowns_Contingency_plan__c takedownCP = new Takedowns_Contingency_plan__c();
		takedownCP.CPL_ls_Stage__c = 'New';
		takedownCP.CPL_rb_Entity_Name_CP__c =entitycp.Id;
		takedownCP.Takedowns_forecast__c = forecast.Id;
		takedownCP.Annex_Pricing_SuperTrump__c = pq.Id;
		takedownCP.TKD_ls_takedown_stage__c ='Converted';
		takedownCP.CPL_ls_Deal_Category__c ='Refi';
		takedownCP.Financing_Needs__c ='CapEx Lines';
		takedownCP.CPL_rb_Opp__c = idOpportunity.Id;
		takedownCP.TDAmount__c =1.00;
		takedownCP.Contract_Annex_Number__c= '13213124';
		takedownCP.Invoice_Exchange_Rate__c =19.147400;
		takedownCP.CPL_ls_Operation_Unit__c ='	UO_397 HOLDING';
		takedownCP.CLI_lsInvoice_Currency__c ='MXN';
		takedownCP.CPL_ls_Product__c =productType;
        takedownCP.RecordTypeId = recordTypeID;
		insert takedownCP;
        
        Takedown_info_util.createAsset(idCuenta.Id, idColateral.Id, takedownCP.Id);
        
        return takedownCP;
    }
}