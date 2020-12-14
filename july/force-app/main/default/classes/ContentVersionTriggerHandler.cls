public class ContentVersionTriggerHandler extends TriggerHandlerKO{
    private Map<Id, ContentVersion> newMapContentVersion;
    private Map<Id, ContentVersion> oldMapContentVersion;
    private List<ContentVersion> newListContentVersion; 
    private List<ContentVersion> oldListContentVersion;
	
    private ContentVersionAddProposalSigned contentVersionAddProposalSigned;
    public ContentVersionTriggerHandler(){
    	this.newListContentVersion = Trigger.new;
    }
    public override void afterInsert() {
        contentVersionAddProposalSigned = new ContentVersionAddProposalSigned(this.newListContentVersion);
        contentVersionAddProposalSigned.searchDate();
    }
}