public without sharing class InvoiceReject_cls {
    
	@AuraEnabled(cacheable=false)
    public static List<SObject> getReasonReject() {
        List<SObject> rejects = Database.query('SELECT 	Error_version__c, Reason_for_rejection__c FROM Takedown_Invoice_Reject__mdt');
        return rejects;
    }
    
    @AuraEnabled(cacheable=false)
    public static void saveReasonRejects(List<Invoice_process_reject__c> rejects){
        System.debug(JSON.serialize(rejects));
        if(rejects.size()>0){
            insert rejects;
        }
    }
    
    @AuraEnabled(cacheable=false)
    public static void saveAllReasonRejects(String idTakedownCP, String comments, List<Id> ids) {
        List<Takedown_Invoice__c> updateInvoice = [SELECT Id, MC_Rejection_Comments_txt__c, MC_Estatus_Prebook_pl__c, TKD_pd_Takedown_CP__c 
                                                   FROM Takedown_Invoice__c
                                                   WHERE TKD_pd_Takedown_CP__c =: idTakedownCP AND ID NOT IN: ids];
        
        List<Invoice_process_reject__c> listReject = new List<Invoice_process_reject__c>();
        for(Takedown_Invoice__c flag : updateInvoice) {
            Invoice_process_reject__c reject = new Invoice_process_reject__c();
           	reject.Error_version__c = 'Catalogo_1';
            reject.Reason_for_rejection__c = 'Otros';
            reject.Another_reason__c = comments;
            reject.Process_Type__c = 'Takedowns_Contingency_plan__c';
            reject.Takedown_Invoice__c = flag.Id; 
            reject.Takedowns_Contingency_plan__c = flag.TKD_pd_Takedown_CP__c;
			listReject.add(reject);
        }
        
        if(listReject.size() > 0) {
        	insert listReject;
        }
    }
    
    @AuraEnabled(cacheable=false)
    public static void saveReasonRejectInvoice(List<Takedown_Invoice__c> rejectInvoice) {
        System.debug(JSON.serialize(rejectInvoice));
        if(rejectInvoice.size()>0) {
            update rejectInvoice;
        }
    }
    
    @AuraEnabled(cacheable=false)
    public static void updateSuccessInvoice(String idTakedownCP, String error, String comments) {
        List<Takedown_Invoice__c> updateInvoice = [SELECT Id, MC_Rejection_Comments_txt__c, MC_Estatus_Prebook_pl__c 
                                                   FROM Takedown_Invoice__c WHERE MC_Rejection_Comments_txt__c = null AND TKD_pd_Takedown_CP__c =: idTakedownCP AND TKD_txt_Extension__c = 'xml'];
        List<Takedown_Invoice__c> newList = new List<Takedown_Invoice__c>();
        String comment = error == 'all' ? comments : 'Takedown Invoice Success';
        String estatus = error == 'all' ? 'action:close' : 'action:approval';
        
        for(Takedown_Invoice__c flag : updateInvoice) {
            flag.MC_Rejection_Comments_txt__c = comment;
            flag.MC_Estatus_Prebook_pl__c = estatus;
            newList.add(flag);
        }
        
        System.debug('List: '  + newList);
        update updateInvoice;
    }
    
    @AuraEnabled(cacheable=true)
    public static List<Takedown_Invoice__c> getInvoices(String idTakedownCP, String InvoicesName) {
        String invoiceName = '%' + InvoicesName + '%';
        return [SELECT Id, Name, TKD_txt_Extension__c FROM Takedown_Invoice__c WHERE TKD_pd_Takedown_CP__c =: idTakedownCP AND (TKD_txt_Extension__c = 'xml' OR TKD_txt_Extension__c = 'pdf') AND Name like:invoiceName ];
    }
}