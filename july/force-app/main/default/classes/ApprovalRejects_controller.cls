public without sharing class ApprovalRejects_controller {
    @AuraEnabled(cacheable=false)
    public static list<SObject> getRejects(string sobjectName){

        string  customMeta = sobjectName.remove('__c');
        string customMetaGood = customMeta + '_Appr__mdt';

        system.debug('Custom meta: ' + customMetaGood);
        
        list<SObject> rejects = Database.query('SELECT 	Error_Type__c, Subtype_Error__c FROM ' + customMetaGood);

        system.debug(rejects);
        return rejects;
    }

    @AuraEnabled(cacheable=false)
    public static void saveRejects(List<Approval_Process_Reject__c> rejects){
        if(rejects.size()>0){
            insert rejects;
        }
    }
}