/**
 * @File Name          : TkdActionsController.cls
 * @Description        : 
 * @Author             : eduardo.amiens@outlook.com
 * @Group              : 
 * @Last Modified By   : eduardo.villegas@engeniumcapital.com
 * @Last Modified On   : 09-03-2020
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    31/10/2019   angel87ambher@gmail.com     Initial Version
**/
public with sharing class TkdActionsController {
	
    /**
    * @description Logica para la accion de cada boton para los procesos de aprovacion
    * @author juandedios.hernandez@engeniumcapital.com | 26/11/2019 
    * @param takedownId 
    * @param action 
    * @param comment 
    * @return void 
    **/
    @AuraEnabled(cacheable=false)
    public static void processApproval(string recordId, string action, string comment) {
        // First, get the IDs for the WorkItems 
        List<Id> newWorkItemIds = new List<Id>();
        for (List<ProcessInstance> pis : [Select (Select Id From Workitems) From ProcessInstance p WHERE p.TargetObjectId = :recordId AND p.Status = 'Pending']) {
            for (ProcessInstance pi : pis) {
                for (List<ProcessInstanceWorkitem> wis : pi.Workitems) {
                    for (ProcessInstanceWorkitem wi : wis ) {
                        newWorkItemIds.add(wi.id);
                    }
                }           
            }
        }
        string longComments;
        if(string.isNotEmpty(comment))
        if(comment.length() >= 4000){ 
            longComments = comment;           
            string shortComments;
            system.debug('Los comentarios son demasiado grandes para el approval process');
            shortComments = comment.left(3500);
            shortComments = shortComments + '\n====================================\n';
            shortComments = shortComments + 'The comments are so long, please enter the record to see the details '; 
            comment = shortComments;            
        }
         // Instantiate the new ProcessWorkitemRequest object and populate it
        Approval.ProcessWorkitemRequest req2 = new Approval.ProcessWorkitemRequest();
         if (action =='Approve') {
            req2.setComments(comment);
            req2.setAction('Approve');
        } else if(action =='Reject') {
            req2.setComments(comment);
            req2.setAction('Reject');
        }else{
            req2.setAction('Removed');
            req2.setComments(comment);
        }
        req2.setNextApproverIds(new Id[] {UserInfo.getUserId()});
         // Use the ID from the newly created item to specify the item to be worked
         if(newWorkItemIds.size()>0){
            Id ProcessInstanceWorkitemId = TkdActionsVisibilityController.getWorkingItemByUserId(newWorkItemIds);
            req2.setWorkitemId(ProcessInstanceWorkitemId);
            // Submit the request for approval
            Approval.ProcessResult result2 =  Approval.process(req2);
            if(string.isNotEmpty(longComments)){
                system.debug('result2.getEntityId() ' + result2.getEntityId());
                system.debug('getInstanceId() ' + result2.getInstanceId());
                system.debug('getInstanceStatus() ' + result2.getInstanceStatus());
                system.debug('getNewWorkitemIds() ' + result2.getNewWorkitemIds());
                list<ProcessInstanceStep> listProInsStep = [SELECT Id, ProcessInstanceId, StepStatus, OriginalActorId, ActorId, Comments, 
                StepNodeId, ElapsedTimeInDays, ElapsedTimeInHours, ElapsedTimeInMinutes, CreatedDate, 
                CreatedById, SystemModstamp FROM ProcessInstanceStep 
                where ProcessInstanceId = :result2.getInstanceId() and Comments != null];
                list<ProcessInstanceStepComment__c> listProcessInstanceStepComment = new list<ProcessInstanceStepComment__c>();
                for(ProcessInstanceStep proInsStep : listProInsStep){
                    system.debug('proInsStep ' + proInsStep);
                    ProcessInstanceStepComment__c ProcessInstanceStepComment = new ProcessInstanceStepComment__c();
                    ProcessInstanceStepComment.ProcessInstanceWorkitemId__c = proInsStep.Id;
                    ProcessInstanceStepComment.Long_Comments__c = longComments;
                    ProcessInstanceStepComment.Actual_Approver__c = proInsStep.ActorId;
                    listProcessInstanceStepComment.add(ProcessInstanceStepComment);
                }
                insert listProcessInstanceStepComment;
                system.debug('ProcessInstanceStepComment ' + listProcessInstanceStepComment);
            }
        } 
    }

    /**
    * @description  Visibilidad para el front approval buttons para takedown
    * @author juandedios.hernandez@engeniumcapital.com | 26/11/2019 
    * @param takedownId 
    * @param stage 
    * @return Boolean 
    **/
    @AuraEnabled(cacheable=false)
    public static Boolean handleVisibilityBtns(string recordId){
        Boolean isVissible =false;
        List<Id> newWorkItemIds = new List<Id>();
        for (List<ProcessInstance> pis : [Select (Select Id From Workitems) From ProcessInstance p WHERE p.TargetObjectId = :recordId AND p.Status = 'Pending']) {
            for (ProcessInstance pi : pis) {
                for (List<ProcessInstanceWorkitem> wis : pi.Workitems) {
                    for (ProcessInstanceWorkitem wi : wis ) {
                        newWorkItemIds.add(wi.id);
                    }
                }           
            }
        }
 
        if(newWorkItemIds.size()>0){
            isVissible = TkdActionsVisibilityController.getVisibility(newWorkItemIds);   
        }else {
            isVissible = false;
        }

        return isVissible;
    }

    @AuraEnabled(cacheable = false)
    public static void submitForApproval(string recordId){
        // Create an approval request for registry
        system.debug('El objectId:'+ recordId);
        Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
        req1.setObjectId(recordId);

        // Submit the approval request for registry
        Approval.ProcessResult result = Approval.process(req1);

        // Verify the result
        System.assert(result.isSuccess());

        System.assertEquals('Pending', result.getInstanceStatus(), 'Instance Status'+result.getInstanceStatus());
    }
    @AuraEnabled(cacheable=false)
    public static list<string> getFieldsName(string sobjectApiName){
        Schema.SObjectType convertType = Schema.getGlobalDescribe().get(sobjectApiName);
        List<Schema.SObjectType> objects = new List<Schema.SObjectType>{ convertType};
        list<string>sobjectNames = new list<string>();

        for(Schema.SObjectType objType: objects){
            for(Schema.SObjectField fld: objType.getDescribe().fields.getMap().values()){
                
                System.debug('API Field Name =  '+fld.getDescribe().getName());
                sobjectNames.add(fld.getDescribe().getName());
            }
        }

        return sobjectNames;
    }
}