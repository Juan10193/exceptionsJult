trigger SupplierInApprovalTrigger on Supplier_in_approval__c (before update, after update) {
    new SupplierInApprovalHandler().run();
}