/**
* @description       : 
* @author            : eduardo.amiens@outlook.com
* @group             : 
* @last modified on  : 09-02-2020
* @last modified by  : eduardo.amiens@outlook.com
* Modifications Log 
* Ver   Date         Author                       Modification
* 1.0   09-02-2020   eduardo.amiens@outlook.com   Initial Version
**/
public without sharing class tkdActionsWithoutSharing {
    
    @AuraEnabled(cacheable=false)
    public static void updateTakedown(Takedowns_Contingency_plan__c Takedowns_Contingency_plan){
        system.debug('updateTakedown ' + Takedowns_Contingency_plan);
        unlockRecord(Takedowns_Contingency_plan);        
        update Takedowns_Contingency_plan;
        lockRecord(Takedowns_Contingency_plan);
    }
    
    public static void lockRecord(Takedowns_Contingency_plan__c Takedowns_Contingency_plan){
        Approval.LockResult LockResult = Approval.lock(Takedowns_Contingency_plan);
        if (LockResult.isSuccess()) {
            System.debug('Successfully locked record with ID: ' + LockResult.getId());
        } else {              
            for(Database.Error err : LockResult.getErrors()) {
                System.debug('The following error has occurred.');                    
                System.debug(err.getStatusCode() + ': ' + err.getMessage());
                System.debug('Fields that affected this error: ' + err.getFields());
            }
        }
    }
    
    public static void unlockRecord(Takedowns_Contingency_plan__c Takedowns_Contingency_plan){
        Approval.UnlockResult UnlockResult = Approval.unlock(Takedowns_Contingency_plan);        
        if (UnlockResult.isSuccess()) {
            System.debug('Successfully unlocked record with ID: ' + UnlockResult.getId());
        } else {              
            for(Database.Error err : UnlockResult.getErrors()) {
                System.debug('The following error has occurred.');                    
                System.debug(err.getStatusCode() + ': ' + err.getMessage());
                System.debug('Record fields that affected this error: ' + err.getFields());
            }
        }
        
    }
    
    @AuraEnabled(cacheable = false)
    public static void recallApprovalProcess(string recordId){
        EmailServiceApprovalPro approvalProcess = new EmailServiceApprovalPro();
        approvalProcess.recallTkdRegistry(recordId);
    }
}