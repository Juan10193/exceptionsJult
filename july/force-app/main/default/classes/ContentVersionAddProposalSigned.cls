public class ContentVersionAddProposalSigned {
    private List<ContentVersion> newListContentVersion;
    public ContentVersionAddProposalSigned(List<ContentVersion> newListContentVersion){
        this.newListContentVersion = newListContentVersion;        
    }
    public void searchDate(){
        map<id,ContentVersion> newMapContentVersion = new map<id,ContentVersion>();
        for(ContentVersion attch : this.newListContentVersion){
            newMapContentVersion.put(attch.FirstPublishLocationId, attch);
        }
        list<Opportunity> listOpportunityToUpdate = new list<Opportunity>();
        
        for(Opportunity opp : [SELECT Id, OPP_fh_Proposal_Signed_Received_Date__c FROM Opportunity WHERE Id in :newMapContentVersion.keySet()]){
			if (newMapContentVersion.get(opp.id).PathOnClient.contains('.pdf')) {                
				opp.OPP_fh_Proposal_Signed_Received_Date__c = Date.today();
				listOpportunityToUpdate.add(opp);
			}   
        }
        if (listOpportunityToUpdate.size() > 0) {
                try {
                    update listOpportunityToUpdate;
                }
                catch (Exception exUpdOpp) {
                    System.debug('Error: ' + exUpdOpp.getMessage() + ' (Line: ' + exUpdOpp.getLineNumber() + ')');
                }
            }
       
    }

}