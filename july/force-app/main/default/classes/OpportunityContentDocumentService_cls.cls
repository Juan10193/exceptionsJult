public class OpportunityContentDocumentService_cls { 
    public List<ContentDocument> oldOppList {get;set;}
    public Map<Id, ContentDocument> oldAssetMap {get;set;}
    
    public OpportunityContentDocumentService_cls(List<ContentDocument> oldOppList, Map<Id, ContentDocument> oldAssetMap){
    	this.oldOppList = oldOppList;     
        this.oldAssetMap = oldAssetMap;
    }
    //Update Opportunity when the content document related has been deleted 
    public void updateOpportunity(){
        List<Opportunity> listOpportunityToUpdate = new List<Opportunity>();
        Map<id,ContentVersion> mapContentVersionByOp = new Map<id,ContentVersion>();
        for(ContentVersion document : Data_Access_ContentVersion.getContentVersionToUpdateOP(this.oldAssetMap.keySet())){
            system.debug(LoggingLevel.INFO,'Test document.FirstPublishLocationId ' + document.FirstPublishLocationId);
            mapContentVersionByOp.put(document.FirstPublishLocationId,document);
        }
        for(Opportunity opp : Data_Access_Opportunity_cls.getOpportunityByContentVersion(mapContentVersionByOp.keySet())){
            if (opp != null) {
                if (mapContentVersionByOp.get(opp.id).PathOnClient.contains('.pdf')) {
                    Opportunity pportunityToUpdate = opp;   
                    pportunityToUpdate.OPP_fh_Proposal_Signed_Received_Date__c = null;
                    pportunityToUpdate.OPP_ca_No_document__c = true;
                    pportunityToUpdate.OPP_tl_Not_Signed_Proposal_Reason__c = 'The proposal document was deleted.';
                    listOpportunityToUpdate.add(pportunityToUpdate);
                }
            }            
        }
        if (listOpportunityToUpdate.size() > 0) {
            DMLO_Opportunity.updateOpportunity(listOpportunityToUpdate);
        }
    }

}