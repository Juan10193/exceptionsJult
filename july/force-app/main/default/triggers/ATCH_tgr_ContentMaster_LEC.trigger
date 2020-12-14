trigger ATCH_tgr_ContentMaster_LEC on ContentDocument (before delete) {
    new ContentDocumentTriggerHandler_cls().run();
    /*---->censurado por usar malas prácticas
    List<Opportunity> oppUdtList = new List<Opportunity>();
    Opportunity opp;
	ContentVersion attchV;   
    if (Trigger.isDelete) {        
        for (ContentDocument attch : Trigger.old) {
            System.debug('IsDelete OEJ-');
            
            
            System.debug('IsInsert OEJ- es null');
            try {
                attchV = [SELECT Id, ContentDocumentId, FirstPublishLocationId, PathOnClient FROM ContentVersion WHERE ContentDocumentId = :attch.Id and FirstPublishLocationId != null ];
                opp = [SELECT Id, OPP_fh_Proposal_Signed_Received_Date__c FROM Opportunity WHERE Id = :attchV.FirstPublishLocationId];
            }
            catch (Exception exOpQuery) {
                System.debug('Error: ' + exOpQuery.getMessage() + ' (Line: ' + exOpQuery.getLineNumber() + ')');
            }
            if (opp != null) {
                if (attchV.PathOnClient.contains('.pdf')) {
                    opp.OPP_fh_Proposal_Signed_Received_Date__c = null;
                    opp.OPP_ca_No_document__c = true;
                    opp.OPP_tl_Not_Signed_Proposal_Reason__c = 'The proposal document was deleted.';
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
    }*/
}