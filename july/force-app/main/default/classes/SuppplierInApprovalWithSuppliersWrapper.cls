public class SuppplierInApprovalWithSuppliersWrapper {
    
    public  SupplierInApprovalDetails supplierInApproval {get;set; }

    public class SupplierInApprovalDetails {
        public Supplier_in_approval__c supplierInApprovalInfo {get;set;}
        public list <Supplier_Details_Wrapper> suppliers {get;set;}
    }
}