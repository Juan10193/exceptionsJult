/**
 * @File Name          : APInstanceStepCommentController.cls
 * @Description        : 
 * @Author             : eduardo.amiens@outlook.com
 * @Group              : 
 * @Last Modified By   : eduardo.amiens@outlook.com
 * @Last Modified On   : 4/6/2020 17:08:44
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    4/6/2020   eduardo.amiens@outlook.com     Initial Version
**/
public with sharing class APInstanceStepCommentController {
    @AuraEnabled(cacheable=true)
    public static ProcessInstanceStepComment__c getApprovalProccessInstanceStepComment(id proccessInstanceStepId){
        return [SELECT Id, OwnerId, IsDeleted, Name, CurrencyIsoCode, CreatedDate, CreatedById, LastModifiedDate, 
        LastModifiedById, SystemModstamp, LastActivityDate, Long_Comments__c, ProcessInstanceWorkitemId__c, Actual_Approver__c 
        FROM ProcessInstanceStepComment__c where ProcessInstanceWorkitemId__c = :proccessInstanceStepId limit 1];
    }
}