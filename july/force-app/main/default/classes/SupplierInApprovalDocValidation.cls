public class SupplierInApprovalDocValidation {
    private List<Supplier_in_approval__c> newListSupplierInaApproval; 
    
    public SupplierInApprovalDocValidation(List<Supplier_in_approval__c> newListSupplierInaApproval){
        this.newListSupplierInaApproval = newListSupplierInaApproval;
    }
    
    public void supplierValidateDocuments(){
        for(Supplier_in_approval__c sp : newListSupplierInaApproval){
            if(sp.TKD_Documments_Validation__c == false){
                sp.addError('No se ha agregado ningún Documento');
            }
        }
    }
}