/**
 * @description       : 
 * @author            : eduardo.amiens@outlook.com
 * @group             : 
 * @last modified on  : 10-21-2020
 * @last modified by  : eduardo.amiens@outlook.com
 * Modifications Log 
 * Ver   Date         Author                       Modification
 * 1.0   09-28-2020   eduardo.amiens@outlook.com   Initial Version
**/
public without sharing class wkaCustomAPDetailController {

    @AuraEnabled(cacheable=false)
    public static list<string> submitForApproval(list<string> recordIds){
        list<string> listError = new list<string>();
        for(string recordId : recordIds){
            Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
            req1.setObjectId(recordId);
            Approval.ProcessResult result = Approval.process(req1, false);
            system.debug('result ' + result);
            /*if(result.getErrors() != null)
            for(Database.Error err : result.getErrors()){
                string stackError = 'Fields ' + err.getFields() + ' message ' + err.getMessage() + ' statuscode ' + err.getStatusCode() + '/n';
                listError.add(stackError);
            }*/
        }
        return listError;
    }
}