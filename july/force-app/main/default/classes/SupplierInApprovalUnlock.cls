public without sharing class SupplierInApprovalUnlock {
    @AuraEnabled(cacheable=false)
    public static void unlockforAccountStatement(id suppInAppId, Datetime fecha ){
    
        if(Approval.isLocked(suppInAppId)){
            Approval.UnlockResult unlock = Approval.unlock(suppInAppId);
            Supplier_in_approval__c supp = [SELECT id, Account_statement_date__c  from Supplier_in_approval__c WHERE id=:suppInAppId LIMIT 1];
            supp.Account_statement_date__c = fecha;
            update supp;
            lockforAccountStatement(suppInAppId);
        }
    }
        
    @AuraEnabled(cacheable=false)
    public static void lockforAccountStatement(id suppInAppId ){
        if(!Approval.isLocked(suppInAppId)){
            Approval.LockResult lock = Approval.lock(suppInAppId);
        }
    }

    @AuraEnabled(cacheable=false)
    public static void unlockGeneral(id suppInAppId){
        if(Approval.isLocked(suppInAppId)){
            Approval.UnlockResult unlock = Approval.unlock(suppInAppId);
        }
    }
}