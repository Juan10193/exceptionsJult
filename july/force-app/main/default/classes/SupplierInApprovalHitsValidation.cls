public class SupplierInApprovalHitsValidation {
    private List<Supplier_in_approval__c> newListSupplierInaApproval; 
    
    public SupplierInApprovalHitsValidation(List<Supplier_in_approval__c> newListSupplierInaApproval){
        system.debug(LoggingLevel.INFO, 'se esta ejecutando suppliers');
        this.newListSupplierInaApproval = newListSupplierInaApproval;
    }
    
    public void supplierValidateHits(){
        for(Supplier_in_approval__c sp : newListSupplierInaApproval){
            if(sp.TKD_tx_Hits__c == 'false'){
                 sp.addError('No se ha agregado ningun hit');
            }
        }
    }
}