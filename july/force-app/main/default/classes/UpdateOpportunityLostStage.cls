public class UpdateOpportunityLostStage {
    
    private Map<Id, Opportunity> oldMapOpportunity;
    private List<Opportunity> newListOpportunity;
    
    public UpdateOpportunityLostStage(List<Opportunity> newListOpportunity, Map<Id, Opportunity> oldMapOpportunity){
        this.newListOpportunity = newListOpportunity;
        this.oldMapOpportunity = oldMapOpportunity;        
    }
    
    public void fillLostStageData(){
        for(Opportunity opp : this.newListOpportunity){
            string recordtypeid = string.valueOf(opp.RecordTypeId);
            string devname = Schema.getGlobalDescribe().get('Opportunity').getDescribe().getRecordTypeInfosById().get(recordtypeid).getDeveloperName();
            if(opp.StageName == 'Lost Deal' && oldMapOpportunity.get(opp.id).StageName != 'Lost Deal' && devname !='OPP_LMM')   {
                opp.OPP_fe_Lost_Date__c = Date.today();
                opp.OPP_tx_LostStage__c = oldMapOpportunity.get(opp.id).StageName;    
            } 
        }        
    }
}