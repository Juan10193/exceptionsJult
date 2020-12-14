public class OpportunityStageValidation {
    private List<Opportunity> newListOpportunity;
    public Map<Id, Opportunity> newMapOpportunity;
    private Map<Id, Opportunity> oldMapOpportunity;
    private List<TBO018_Pricing__c> lstPricing;
    private map<id,list<TBO018_Pricing__c>> mapPricing;
    
    public OpportunityStageValidation(List<Opportunity> newListOpportunity,  Map<Id, Opportunity> newMapOpportunity, Map<Id, Opportunity> oldMapOpportunity){
        this.newListOpportunity = newListOpportunity;
        this.oldMapOpportunity = oldMapOpportunity;
        this.newMapOpportunity = newMapOpportunity;
        this.mapPricing = new map<id,list<TBO018_Pricing__c>>();
        list<TBO018_Pricing__c> listPricing = new list<TBO018_Pricing__c>();
        list<TBO018_Pricing__c> pricing = [SELECT Id, TBO018_ca_Approved_by_Risk__c, TBO018_ls_Type__c, TBO018_rb_Opportunity__c, TBO018_rb_Opportunity__r.RecordTypeId 
                                           FROM TBO018_Pricing__c
                                           WHERE (TBO018_rb_Opportunity__c IN: newMapOpportunity.keySet()) 
                                           AND (TBO018_ls_Type__c = 'Proposal')
                                           AND (TBO018_tx_Pricing_Status__c = 'Approved')];
        for(TBO018_Pricing__c pricings : pricing){
            string recordtypeid = string.valueOf(pricings.TBO018_rb_Opportunity__r.RecordTypeId);
            string devname = Schema.getGlobalDescribe().get('Opportunity').getDescribe().getRecordTypeInfosById().get(recordtypeid).getDeveloperName();
            
            if(devname !='OPP_LMM'){
                
                if(this.mapPricing.containsKey(pricings.TBO018_rb_Opportunity__c)){
                    listPricing = this.mapPricing.get(pricings.TBO018_rb_Opportunity__c);
                    listPricing.add(pricings); 
                } else {  
                    listPricing.add(pricings);                                       	
                }
                this.mapPricing.put(pricings.TBO018_rb_Opportunity__c, listPricing);          
            }
            
        }
        
    }
    public void proporsalOrApprovedStage(){
        for(Opportunity opp: this.newListOpportunity) {
            string recordtypeid = string.valueOf(opp.RecordTypeId);
            string devname = Schema.getGlobalDescribe().get('Opportunity').getDescribe().getRecordTypeInfosById().get(recordtypeid).getDeveloperName();
            if ((!opp.StageName.equals(this.oldMapOpportunity.get(opp.Id).StageName)) && opp.StageName.equalsignorecase('Proposal') && devname !='OPP_LMM') {
                system.debug('exito ' + this.mapPricing.containsKey(opp.id));
                //si no encuentra pricings, añade el error 
                if(!this.mapPricing.containsKey(opp.id)){
                    opp.addError(system.Label.OpportunityPricingError);    
                } else if(this.mapPricing.get(opp.id).isEmpty()){
                    opp.addError(system.Label.OpportunityPricingError);         
                }
            }
        }
    }
}