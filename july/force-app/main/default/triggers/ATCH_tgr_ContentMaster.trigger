trigger ATCH_tgr_ContentMaster on Attachment (after insert, before delete) {
    List<Opportunity> oppUdtList = new List<Opportunity>();
    
    if (Trigger.isInsert) {
        
        for (Attachment attch : Trigger.new) {
            Opportunity opp;
            
            try {
                opp = [SELECT Id, OPP_fh_Proposal_Signed_Received_Date__c FROM Opportunity WHERE Id = :attch.ParentId];
            }
            catch (Exception exOpQuery) {
                System.debug('Error: ' + exOpQuery.getMessage() + ' (Line: ' + exOpQuery.getLineNumber() + ')');
            }
            
            if (opp != null) {
                if (attch.Name.contains('.pdf')) {
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
    
    if (Trigger.isDelete) {        
        for (Attachment attch : Trigger.old) {
            
            Opportunity opp;
            
            try {
                opp = [SELECT Id, OPP_fh_Proposal_Signed_Received_Date__c FROM Opportunity WHERE Id = :attch.ParentId];
            }
            catch (Exception exOpQuery) {
                System.debug('Error: ' + exOpQuery.getMessage() + ' (Line: ' + exOpQuery.getLineNumber() + ')');
            }
            
            if (opp != null) {
                if (attch.Name.contains('.pdf')) {
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
    }
}