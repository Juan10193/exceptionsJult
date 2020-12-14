public class milestoneUtils {
    
    public static void completeMilestone(List<Id> caseIds, String milestoneName, DateTime complDate) {
    	
		List<CaseMilestone> cmsToUpdate = [select cm.Id, cm.IsCompleted,cm.CompletionDate,cm.StartDate,cm.TargetDate,cm.MilestoneType.Name,
				cm.IsViolated,cm.TargetResponseInDays,cm.TargetResponseInHrs,cm.TargetResponseInMins,cm.TimeSinceTargetInMins,
				cm.TimeRemainingInMins,cm.ElapsedTimeInDays,cm.ElapsedTimeInHrs,cm.ElapsedTimeInMins, cm.caseId
						   from CaseMilestone cm
						   where cm.caseId in :caseIds
						   and cm.MilestoneType.Name=:milestoneName
						   and completionDate = null limit 1];
		if (cmsToUpdate.isEmpty() == false){			for (CaseMilestone cm : cmsToUpdate){ cm.completionDate = complDate; LogCustomerService.upsertLogSC(cm.caseId, cm.Id , cm.CompletionDate  , cm.StartDate, cm.TargetResponseInMins, cm.MilestoneType.Name, '');   }			update cmsToUpdate;		} // end if
	}
}