public with sharing class ButtonSuppliersApproval_cls {
    public class applicationException extends Exception {}

    @AuraEnabled
    public static void submitApproval(String idSupplier) {
        List<Supplier_in_approval__c> lookSuppliers = [SELECT Id, Name FROM Supplier_in_approval__c WHERE TKD_rb_SupplierInApproval__c =: idSupplier];
        set<id> idSuppliers = new set<id>();
        for(Supplier_in_approval__c flag : lookSuppliers) {
            idSuppliers.add(flag.Id);
        }
        TKD_SaveSuppliersORA.saveSuppliers(idSuppliers);
    }
}