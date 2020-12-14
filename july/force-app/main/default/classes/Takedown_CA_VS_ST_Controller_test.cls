@isTest
public class Takedown_CA_VS_ST_Controller_test {
    @testSetup 
    static void setup() {
        list<EIV_Parameter__c> parameters = Test.loadData(EIV_Parameter__c.sobjectType, 'parametrosTest');
        Data_Factory_Takedown_Test.createTakedown('AFINAN-VAR', 'Lalo','ODFR9001144F5');  
        
    }
    static testmethod void getPricingVSPricing() {
        Takedowns_Contingency_plan__c tkd_CP = [Select id From Takedowns_Contingency_plan__c limit 1];
		Takedown_CA_VS_ST_Controller_cls.getPricingVSPricing(tkd_CP.id);
    }
    static testmethod void getPricings() {
        Takedowns_Contingency_plan__c tkd_CP = [Select id From Takedowns_Contingency_plan__c limit 1];
		Takedown_CA_VS_ST_Controller_cls.getPricings(tkd_CP.id);
    }
    static testmethod void getApprovedPricings() {
        Opportunity opp = [Select id From Opportunity limit 1];
        TBO018_Pricing__c pri = [SELECT Id, Name, TBO018_rb_SuperTRUMP_Pricing_Quote__c, TBO018_tx_Pricing_Status__c, TBO018_fm_Credit_Approval_Status__c, TBO018_rb_Opportunity__c 
             								FROM TBO018_Pricing__c]; 
        pri.TBO018_tx_Pricing_Status__c = 'Approved';
        update pri;
        
        System.debug('pri ' + pri);
		Takedown_CA_VS_ST_Controller_cls.getApprovedPricings(opp.id);
    }
    static testmethod void nullSearch() {
        IST__SuperTRUMP_Pricing_Quote__c pq = [SELECT id, name from IST__SuperTRUMP_Pricing_Quote__c];
		Takedown_CA_VS_ST_Controller_cls.search(pq.name,null,null);
    }
    static testmethod void notNullSearch() {
        IST__SuperTRUMP_Pricing_Quote__c pq = [SELECT id, name from IST__SuperTRUMP_Pricing_Quote__c];
        List<string> selectedIds = new List<string>();
        List<string> pricingsAvaible = new List<string>();
        pricingsAvaible.add(pq.id);
        
        System.debug('pq ' + pq);
		Takedown_CA_VS_ST_Controller_cls.search(pq.name,selectedIds,pricingsAvaible);
    }
    static testmethod void savePQ() {
        Takedowns_Contingency_plan__c tkd_CP = [Select id, Annex_Pricing_SuperTrump__c From Takedowns_Contingency_plan__c limit 1];
        IST__SuperTRUMP_Pricing_Quote__c pq = [SELECT id, name from IST__SuperTRUMP_Pricing_Quote__c limit 1];
        tkd_CP.Annex_Pricing_SuperTrump__c = null;
        update tkd_CP;
		Takedown_CA_VS_ST_Controller_cls.savePQ(tkd_CP.id,pq.id);
    }
    

}