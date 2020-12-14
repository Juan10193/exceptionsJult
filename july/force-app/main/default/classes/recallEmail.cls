global class recallEmail implements Messaging.InboundEmailHandler  {
    global Messaging.InboundEmailResult handleInboundEmail (Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
        //try{
            //Add your Logic here
            List<Id> newWorkItemIds = new List<Id>();
            for (List<ProcessInstance> pis : [Select (Select Id From Workitems) From ProcessInstance p WHERE p.TargetObjectId = :email.plainTextBody AND p.Status = 'Pending']) {
                system.debug('pis ' + pis);
                for (ProcessInstance pi : pis) {
                    system.debug('pi ' + pi);
                    for (List<ProcessInstanceWorkitem> wis : pi.Workitems) {
                        system.debug('wis ' + wis);
                        for (ProcessInstanceWorkitem wi : wis ) {
                            system.debug('wi ' + wi);
                            newWorkItemIds.add(wi.id);
                        }
                    }           
                }
            }
            Approval.ProcessWorkitemRequest req2 = new Approval.ProcessWorkitemRequest();
            req2.setAction('Removed');
            req2.setComments('Proceso recuperado para delayFunding');
            req2.setWorkitemId(newWorkItemIds[0]);
            Approval.ProcessResult oPR = Approval.process(req2);
            TkdActionsController.submitForApproval(email.plainTextBody);
        /*} catch(Exception e) {
            integer i;
            i = 0;
            i++;
            LMM_CustomLog__c log = new LMM_CustomLog__c();
            log.Lmm_tl_Trace__c = 'e.getCause() ' + e.getCause() + ' e.getLineNumber() ' + e.getLineNumber() + ' e.getMessage() ' + e.getMessage();
            log.Lmm_tl_Trace__c = 'test';
            log.LMM_tx_Aplication_Objetive__c = 'test';
            insert log;
        }*/
        return null;
        
    }
    
}