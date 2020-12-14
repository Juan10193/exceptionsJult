public with sharing class takedownTableInvoicesController_cls {
    
    @AuraEnabled(cacheable=true)
    public static List<Takedown_Invoice__c> getDocumentList(String recordId) {
        System.debug('recordId ' + recordId);
        return Data_Access_Takedown_Invoice_cls.getDocumentListByTakedownID(recordId);
    }
    
    @AuraEnabled(cacheable=true)
    public static List<Takedown_Invoice__c> getDocumentsRefacturacion(String recordId) {
        return Data_Access_Takedown_Invoice_cls.getDocumentsRefacturacion(recordId);
    }
}