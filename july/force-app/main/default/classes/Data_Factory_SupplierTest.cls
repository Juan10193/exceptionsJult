@Istest
public class Data_Factory_SupplierTest {
    
    public static Supplier__c createSupplier(string vendorName, string RFC, Id supplierInApprovalId){
        Supplier__c supplier = new Supplier__c();
        supplier.TKD_tx_Vendor_Name__c =vendorName;
        supplier.TKD_tx_Vendor_name_alternative__c = vendorName;
        supplier.TKD_tx_Vat_Registration_Num__c = RFC;
        supplier.TKD_pd_Supplier_in_approval__c = supplierInApprovalId;
        insert supplier;
        return supplier;
    }
    
}