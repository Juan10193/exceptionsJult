public class SupplierInApprovalHandler extends TriggerHandlerKO  { 
	private Map<Id, Supplier_in_approval__c> newMapSupplierInaApproval;
    private Map<Id, Supplier_in_approval__c> oldMapSupplierInaApproval;
    private List<Supplier_in_approval__c> newListSupplierInaApproval; 
    private List<Supplier_in_approval__c> oldListSupplierInaApproval;
    
    private SupplierInApprovalValidate supplierInAppValidate = new SupplierInApprovalValidate();
    private SupplierInApprovalUnlock lockUnlock = new SupplierInApprovalUnlock();
    
    public list<Id> IdsTOlOCK = new list<Id>();
    
    public SupplierInApprovalHandler(){
        this.newListSupplierInaApproval = Trigger.new;
        this.oldListSupplierInaApproval = Trigger.old;
        this.newMapSupplierInaApproval =(Map<Id, Supplier_in_approval__c>) Trigger.newMap;
        this.oldMapSupplierInaApproval =(Map<Id, Supplier_in_approval__c>) Trigger.oldMap;
    }
    
    
    public override void beforeUpdate() {
        /*this.supplierDocValidation = new SupplierInApprovalDocValidation(this.newListSupplierInaApproval);
        this.supplierDocValidation.supplierValidateDocuments();
        
        this.supplierInvoiceValidation = new SupplierInApprovalInvoiceValidation(this.newListSupplierInaApproval);
        this.supplierInvoiceValidation.supplierValidateInvoice();
        
        this.supplierHitsValidation = new SupplierInApprovalHitsValidation(this.newListSupplierInaApproval);
        this.supplierHitsValidation.supplierValidateHits();*/
    }
    
    public override void afterUpdate() {
        /*for(Supplier_in_approval__c suppInApp:newListSupplierInaApproval){
           for(Supplier_in_approval__c supold: oldListSupplierInaApproval){
               if(suppInApp.tkd_ls_Stage__c =='APPROVED' && (supold.tkd_ls_Stage__c=='IN PROCESS' && supold.Id ==suppInApp.Id)){
                   TKD_SaveSuppliersORA.saveSuppliers(newListSupplierInaApproval, oldListSupplierInaApproval);
               }
           }
        }*/
        
        supplierInAppValidate.isAutoApprovable(newMapSupplierInaApproval, oldMapSupplierInaApproval);
        
        set<id> cominos = new set<id>();
        Supplier_in_approval__c Supplier_in_approval = new Supplier_in_approval__c();
        for(id suppInAppId : this.newMapSupplierInaApproval.keySet()){
            if(this.newMapSupplierInaApproval.get(suppInAppId).tkd_ls_Stage__c.equals('APPROVED') && this.oldMapSupplierInaApproval.get(suppInAppId).tkd_ls_Stage__c.equals('IN PROCESS') && this.newMapSupplierInaApproval.get(suppInAppId).Supplier_sent__c == false) {
                  Supplier_in_approval.id = suppInAppId;
                  Supplier_in_approval.Supplier_sent__c = true; 
                  cominos.add(suppInAppId);
               // TKD_SaveSuppliersORA.saveSuppliers(newListSupplierInaApproval, oldListSupplierInaApproval);
            } 
        }
        system.debug('Ovitos ' + cominos);
        if(Supplier_in_approval.id != null)
        update Supplier_in_approval;
        TKD_SaveSuppliersORA.saveSuppliers(cominos);
		   		
  	}
}