/**
 * @File Name          : superTrumpSelectedController.cls
 * @Description        : 
 * @Author             : eduardo.villegas@engeniumcapital.com
 * @Group              : 
 * @Last Modified By   : eduardo.villegas@engeniumcapital.com
 * @Last Modified On   : 13/9/2019 12:19:31
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    13/9/2019   eduardo.villegas@engeniumcapital.com     Initial Version
**/
public without sharing class Takedown_CA_VS_ST_Controller_cls {
    private final static Integer MAX_RESULTS = 5;
    
    @AuraEnabled(cacheable=true)
    public static Takedown_CA_VS_ST_Table_Wrapper_cls.Table getPricingVSPricing(id recordId) {
        system.debug('recordId ' + recordId);
        Takedown_CA_VS_ST_Table_Service_cls Takedown_CA_VS_ST_Table_Service = new Takedown_CA_VS_ST_Table_Service_cls(recordId);
        system.debug('PricingVSPricing_Service.make_Wrapper_PricingVSPricing() ' + Takedown_CA_VS_ST_Table_Service.make_Wrapper_PricingVSPricing());
        return Takedown_CA_VS_ST_Table_Service.make_Wrapper_PricingVSPricing();
    }
    
	@AuraEnabled(Cacheable=true)
    public static Takedown_CA_VS_ST_Wrapper_cls.CA_VS_ST_Wrapper getPricings(id recordId){
        Takedown_CA_VS_ST_Service_cls Takedown_CA_VS_ST_Service = new Takedown_CA_VS_ST_Service_cls();
        return Takedown_CA_VS_ST_Service.getPricingsAndMakeWrapper(recordID);
    } 
    @AuraEnabled(Cacheable=true)
    public static list<string> getApprovedPricings(string opportunityID){
        list<string> avaiblePricings = new list<string>();
        system.debug('opportunityID ' + opportunityID);
        for(TBO018_Pricing__c pricing : [SELECT Id, Name, TBO018_rb_SuperTRUMP_Pricing_Quote__c, TBO018_tx_Pricing_Status__c, TBO018_fm_Credit_Approval_Status__c, TBO018_rb_Opportunity__c 
             								FROM TBO018_Pricing__c 
                                         	where TBO018_rb_Opportunity__c = :opportunityID and TBO018_tx_Pricing_Status__c = 'Approved']){
			 avaiblePricings.add(pricing.TBO018_rb_SuperTRUMP_Pricing_Quote__c);                                            
        }
        return avaiblePricings;
    }
    @AuraEnabled(Cacheable=true)
    public static List<LookupSearchResult> search(String searchTerm, List<String> selectedIds, List<String> pricingsAvaible) {
        system.debug('pricingsAvaible ' + pricingsAvaible);
        List<LookupSearchResult> results = new List<LookupSearchResult>();
        try{           
        
            // Prepare query paramters
            searchTerm += '*';
    		
            // Execute search query
            List<List<SObject>> searchResults = [FIND :searchTerm IN ALL FIELDS RETURNING
                IST__SuperTRUMP_Pricing_Quote__c (Id, Name, IST__QuoteStatus__c, IST__Description__c, IST__Cost__c, IST__Term__c, IST__Periodicity__c 
                                                  WHERE 
                                                  id NOT IN :selectedIds 
                                                  AND id IN :pricingsAvaible)
                LIMIT :MAX_RESULTS];
    
            // Prepare results           
    
            // Extract Accounts & convert them into LookupSearchResult
            String accountIcon = 'standard:sales_cadence_target';
            IST__SuperTRUMP_Pricing_Quote__c [] pqs = ((List<IST__SuperTRUMP_Pricing_Quote__c>) searchResults[0]);
            system.debug('pqs ' + pqs);
            for (IST__SuperTRUMP_Pricing_Quote__c pq : pqs) {
                results.add(new LookupSearchResult(pq.Id, 'IST__SuperTRUMP_Pricing_Quote__c', accountIcon, pq.Name, pq.IST__Description__c));
            }
        } catch(Exception e){
            System.debug(LoggingLevel.ERROR,'getCause ' + e.getCause());
            System.debug(LoggingLevel.ERROR,'getLineNumber ' + e.getLineNumber());
            System.debug(LoggingLevel.ERROR,'getMessage ' + e.getMessage());
        }

        return results;
    }
    @AuraEnabled(Cacheable=false)
    public static void savePQ(id takedownID, id pqId) {
        system.debug('takedownID ' + takedownID);
        system.debug('pqId ' + pqId);
        Takedowns_Contingency_plan__c takekedownCP = new Takedowns_Contingency_plan__c();
        takekedownCP.id = takedownID;
        takekedownCP.Annex_Pricing_SuperTrump__c = pqId;
        update takekedownCP;        
    }
}