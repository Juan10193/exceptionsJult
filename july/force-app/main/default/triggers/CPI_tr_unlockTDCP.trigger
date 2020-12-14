trigger CPI_tr_unlockTDCP on Takedowns_Contingency_plan__c (before update) {
    
    for(Integer i=0; i<trigger.new.size(); i++)
    {
        if(trigger.new[i].CPL_ls_Stage__c != trigger.old[i].CPL_ls_Stage__c)
        {
            if(trigger.new[i].CPL_ls_Stage__c == 'Ready to send to the approval of Tollgate 1')
            {
                Approval.unlock(trigger.new[i].id);
            }
            
        }
    }

}