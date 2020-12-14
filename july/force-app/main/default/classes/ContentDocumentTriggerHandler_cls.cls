public class ContentDocumentTriggerHandler_cls extends TriggerHandlerKO{
	private Map<Id, ContentDocument> newContentDocumentMap;
    private Map<Id, ContentDocument> oldContentDocumentMap;
    private List<ContentDocument> newContentDocumentList;
    private List<ContentDocument> oldContentDocumentList;
    
    private OpportunityContentDocumentService_cls OpportunityContentDocumentService; 
    
    public ContentDocumentTriggerHandler_cls() {
    	this.oldContentDocumentList = (List<ContentDocument>) Trigger.old;
        this.oldContentDocumentMap = (Map<Id, ContentDocument>) Trigger.oldMap;
        OpportunityContentDocumentService = new OpportunityContentDocumentService_cls(this.oldContentDocumentList, this.oldContentDocumentMap);
    }
    public override void beforeDelete() {
        OpportunityContentDocumentService.updateOpportunity();        
  	}
}