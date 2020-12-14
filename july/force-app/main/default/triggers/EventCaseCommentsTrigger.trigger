trigger EventCaseCommentsTrigger on CaseComment (before insert) {
    
    for (CaseComment t: Trigger.new)
    {
        List<Case> caso= [Select id, status from case where id=:t.ParentId];
        //Customer_Service_Log__c log = new Customer_Service_Log__c();
        //log.CAS003_tx_CaseComments__c = t.CommentBody;
        //log.CAS001_rb_CasoId__c = t.ParentId;
        //log.CAS004_rb_usuario__c = t.CreatedById;
        
        
        List<CaseMilestone> cmsToUpdate = [Select cm.Id, cm.IsCompleted,cm.CompletionDate,cm.StartDate,cm.TargetDate,cm.MilestoneType.Name,
                                           cm.IsViolated,cm.TargetResponseInDays,cm.TargetResponseInHrs,cm.TargetResponseInMins,cm.TimeSinceTargetInMins,
                                           cm.TimeRemainingInMins,cm.ElapsedTimeInDays,cm.ElapsedTimeInHrs,cm.ElapsedTimeInMins , cm.caseId
                                           from CaseMilestone cm
                                           where cm.caseId =:t.ParentId						  
                                           and completionDate = null limit 1];
        
        if (cmsToUpdate.isEmpty() == false){ 
            for (CaseMilestone cm : cmsToUpdate){ LogCustomerService.upsertLogSC(cm.caseId, cm.Id , cm.CompletionDate  , cm.StartDate, cm.TargetResponseInMins, cm.MilestoneType.Name, t.CommentBody); }           
            
        }
           
    }
  
}