trigger OppTriggerGeneral on Opportunity (before update) {/*
    for( Opportunity oppNew: Trigger.new)
    {
        for( Opportunity oppOld: Trigger.old)
        {
            System.debug('OEJ*1=' +oppNew.StageName + '****' + oppOld.StageName);
            if(oppNew.StageName == 'Lost Deal' && oppOld.StageName != 'Lost Deal')
            {
                System.debug('OEJ*2=' +oppNew.StageName + '****' + oppOld.StageName);
                oppNew.OPP_fe_Lost_Date__c = Date.today();
                oppNew.OPP_tx_LostStage__c = oppOld.StageName;
                break;                
            }
        }
    }*/
    
}