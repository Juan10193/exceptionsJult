public class EC_QuoteTriggerHandler extends TriggerHandlerKO{
	private Map<Id, EC_Quote__c> newMapECQuote;
    private Map<Id, EC_Quote__c> oldMapECQuote;
    private List<EC_Quote__c> newListECQuote; 
    private List<EC_Quote__c> oldListECQuote;
    
    private LMM_UpdateOpportunityTotalAmount sumAmmountOpp;
    
    public EC_QuoteTriggerHandler (){
        this.newListECQuote = Trigger.new;
        this.oldListECQuote = Trigger.old;
        this.oldMapECQuote = (Map<Id, EC_Quote__c>)Trigger.oldMap;
    }
    
    public override void afterInsert(){
        TriggerHandlerKO.bypass('OpportunityTriggerHandler');
        this.sumAmmountOpp = new LMM_UpdateOpportunityTotalAmount(newListECQuote, oldMapECQuote, oldListECQuote );
        this.sumAmmountOpp.searChOppsToUpdate();
        TriggerHandlerKO.clearBypass('OpportunityTriggerHandler');
    }
    
    public override void afterUpdate(){
        TriggerHandlerKO.bypass('OpportunityTriggerHandler');
        this.sumAmmountOpp = new LMM_UpdateOpportunityTotalAmount(newListECQuote, oldMapECQuote, oldListECQuote );
        this.sumAmmountOpp.searchOppsaFterUpdate();
        TriggerHandlerKO.clearBypass('OpportunityTriggerHandler');
    }
    
    public override void afterDelete(){
        TriggerHandlerKO.bypass('OpportunityTriggerHandler');
        this.sumAmmountOpp = new LMM_UpdateOpportunityTotalAmount(newListECQuote, oldMapECQuote, oldListECQuote );
        this.sumAmmountOpp.searchOppsaFterDelete();
        TriggerHandlerKO.clearBypass('OpportunityTriggerHandler');
    }
}