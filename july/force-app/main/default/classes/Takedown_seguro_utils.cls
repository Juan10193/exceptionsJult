@Istest
public class Takedown_seguro_utils {
    
	public static Takedowns_Contingency_plan__c[] createTakeDownEval(Integer numberTakedown){
        String productType = 'AFINAN-FIJA'; 
        String entityCPName = 'FISHERS';
        String entityCPRFCTIN = 'FISH1092';
        
    	Opportunity opp = Data_Factory_Opportunity_Test.createNewOpportunityTypeWK();
       	TBO021_Takedowns_forecast__c forecast = Data_Factory_EasyForecast_Test.createForecast(opp.Id);
       	IST__SuperTRUMP_Template__c template = TestDataFactory_tst.createSTPricingTemplate();
       	IST__SuperTRUMP_Pricing_Quote__c pq = TestDataFactory_tst.createSTPricingQuote(opp,template);
       
       	Entity_CP__c entitycp = Data_Factory_EntityCp.createEntityCP(entityCPName, entityCPRFCTIN );
        
        Takedowns_Contingency_plan__c[] takedowsCPs = new Takedowns_Contingency_plan__c[] {};
       	
		for(Integer i=0; i < numberTakedown; i++) {
			takedowsCPs.add(
            	new Takedowns_Contingency_plan__c(
                	TKD_ls_takedown_stage__c ='Tollgate 1',
                   	Takedowns_forecast__c = forecast.Id,
       				Annex_Pricing_SuperTrump__c = pq.Id,
                    CPL_rb_Entity_Name_CP__c =entitycp.Id,
       				CPL_ls_Deal_Category__c ='Refi',
       				Financing_Needs__c ='CapEx Lines',
       				CPL_rb_Opp__c = opp.Id,
      				TDAmount__c =1.00,
       				Contract_Annex_Number__c= '13213124',
       				Invoice_Exchange_Rate__c =19.147400,
       				CPL_ls_Operation_Unit__c ='	UO_397 HOLDING',
       				CLI_lsInvoice_Currency__c ='MXN',
       				CPL_ls_Product__c =productType
                )
            );
		}
     	
        insert takedowsCPs;
        
        return takedowsCPs;
    }
}