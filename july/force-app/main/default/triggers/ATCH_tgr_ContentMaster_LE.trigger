trigger ATCH_tgr_ContentMaster_LE on ContentVersion (after insert) {
    /*
    List<Opportunity> oppUdtList = new List<Opportunity>();
    Opportunity opp;
    
    if (Trigger.isInsert) {
        
        for (ContentVersion attch : Trigger.new) {
            System.debug('IsInsert OEJ-' + attch);
            if(attch.FirstPublishLocationId != null)
            {   
                System.debug('IsInsert OEJ- no es null');
                try {
                    opp = [SELECT Id, OPP_fh_Proposal_Signed_Received_Date__c FROM Opportunity WHERE Id = :attch.FirstPublishLocationId];
                }
                catch (Exception exOpQuery) {
                    System.debug('Error: ' + exOpQuery.getMessage() + ' (Line: ' + exOpQuery.getLineNumber() + ')');
                }
                
                if (opp != null) {
                    if (attch.PathOnClient.contains('.pdf')) {
                        opp.OPP_fh_Proposal_Signed_Received_Date__c = Date.today();
                        oppUdtList.add(opp);
                    }
                }
            }
            if (oppUdtList.size() > 0) {
                try {
                    update oppUdtList;
                }
                catch (Exception exUpdOpp) {
                    System.debug('Error: ' + exUpdOpp.getMessage() + ' (Line: ' + exUpdOpp.getLineNumber() + ')');
                }
            }
        }
    }
    */
}