public class AssetTriggerHandler_cls extends TriggerHandlerKO{
    private Map<Id, Asset> newMapAsset;
    private Map<Id, Asset> oldMapAsset;
    private List<Asset> newListAsset; 
    private List<Asset> oldListAsset;
    
    private Takedown_AssetTriggerService_cls takedown_Service;
    
    public AssetTriggerHandler_cls() {
    	this.newMapAsset = (Map<Id, Asset>) Trigger.newMap;
        this.oldMapAsset = (Map<Id, Asset>) Trigger.oldMap;
        takedown_Service = new Takedown_AssetTriggerService_cls();
    }
    public override void afterUpdate() {
    	takedown_Service.recalculaCostoTotal(this.newMapAsset);
  	}
    public override void afterInsert() {
    	takedown_Service.recalculaCostoTotal(this.newMapAsset);
  	}
    public override void afterDelete() {
    	takedown_Service.recalculaCostoTotal(this.oldMapAsset);
  	}
    public override void afterUndelete() {
    	takedown_Service.recalculaCostoTotal(this.newMapAsset);
  	}    
}