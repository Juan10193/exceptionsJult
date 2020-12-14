public class SupplierInApprovalInvoiceValidation {
    private List<Supplier_in_approval__c> newListSupplierInaApproval; 
    
    public SupplierInApprovalInvoiceValidation(List<Supplier_in_approval__c> newListSupplierInaApproval){
        this.newListSupplierInaApproval = newListSupplierInaApproval;
    }
    
    public void supplierValidateInvoice(){
        for(Supplier_in_approval__c sp : newListSupplierInaApproval){
            if(sp.TKD_ca_Invoices_with_suppliers__c == false){
                 sp.addError('No se ha agregado ninguna factura');
            }
        }
    }
}