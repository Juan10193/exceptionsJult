/**
 * @File Name          : DMLO_Takedown_Invoice_cls.cls
 * @Description        : 
 * @Author             : jhernandez@anivia.mx
 * @Group              : 
 * @Last Modified By   : jhernandez@anivia.mx
 * @Last Modified On   : 15/7/2019 17:06:17
 * @Modification Log   : 
 *==============================================================================
 * Ver         Date                     Author      		      Modification
 *==============================================================================
 * 1.0    10/7/2019 12:58:35   jhernandez@anivia.mx     Initial Version
**/
public with sharing class DMLO_Takedown_Invoice_cls {
    public DMLO_Takedown_Invoice_cls() {

    }

    /**
    * @description
    * @author jhernandez@anivia.mx | 15/7/2019
    * @param string idInvoice
    * @return void
    */
    public static void deleteTakedownInvoice (string idInvoice){
        system.debug(LoggingLevel.INFO,'Inicia deleteTakedownInvoice');
        Takedown_Invoice__c invoice = new Takedown_Invoice__c ();
        invoice.Id = idInvoice;

        //if(Schema.sObjectType.Takedown_Invoice__c.isDeletable()){
            //delete invoice;
        //}
        Database.DeleteResult deleteRecordResult = Database.delete(invoice, false);
       	if (deleteRecordResult.isSuccess()) {
            // Operation was successful, so get the ID of the record that was processed
        	System.debug('Successfully deleted Asset');
        } else {
                // Operation failed, so get all errors                
        	for(Database.Error e : deleteRecordResult.getErrors()) {
            	System.debug(LoggingLevel.ERROR,'e.getStatusCode() ' + e.getStatusCode());
                System.debug(LoggingLevel.ERROR,'e.getFields() ' + e.getFields());
                System.debug(LoggingLevel.ERROR,'e.getMessage() ' + e.getMessage());
            }
       	}            
    }

    /**
    * @description
    * @author jhernandez@anivia.mx | 15/7/2019
    * @param set<Id> invoiceIds
    * @return void
    */
    public static void deleteInvoices (List<Id> invoiceIds){
        system.debug(LoggingLevel.INFO,'Inicia deleteInvoices');
        List<Takedown_Invoice__c> invoices = new List<Takedown_Invoice__c>();
        for (Id item : invoiceIds) {
            Takedown_Invoice__c invoice = new Takedown_Invoice__c();
            invoice.Id = item;
            invoices.add(invoice);
        }
		/*
        if(Schema.sObjectType.Takedown_Invoice__c.isDeletable()){
            delete invoices;
        }*/
        Database.DeleteResult[] deleteList = Database.delete(invoices, false);
        String errors;
        for(Database.DeleteResult result : deleteList){
        	if (result.isSuccess()) {
            // Operation was successful, so get the ID of the record that was processed
        	System.debug('Successfully deleted invoices');
            } else {
                // Operation failed, so get all errors                
                for(Database.Error e : result.getErrors()) {
                    System.debug(LoggingLevel.ERROR,'e.getStatusCode() ' + e.getStatusCode());
                    System.debug(LoggingLevel.ERROR,'e.getFields() ' + e.getFields());
                    System.debug(LoggingLevel.ERROR,'e.getMessage() ' + e.getMessage());
                }
            }    
        }
    }
    public static void deleteDocumentFromInvoices (List<Id> invoiceIds){
        system.debug(LoggingLevel.INFO,'Inicia deleteDocumentFromInvoices');
        List<Takedown_Invoice__c> invoices = new List<Takedown_Invoice__c>();
        for (Id item : invoiceIds) {
            Takedown_Invoice__c invoice = new Takedown_Invoice__c();
            invoice.Id = item;
            invoice.TKD_tl_Eng_message__c = 'The document has been deleted, please upload the new version';
            invoice.TKD_ls_Eng_Status__c = 'action:canvas';
            invoice.TKD_txt_Extension__c = '';
            invoice.TKD_tl_SAT_message__c = 'The document has been deleted, please upload the new version';
            invoice.TKD_ls_SAT_Status__c = 'action:canvas';
            invoice.TKD_txt_Document_ID__c = '';
        invoice.TKD_txt_Content_Version_ID__c = '';
            invoices.add(invoice);
        }

        if(Schema.sObjectType.Takedown_Invoice__c.isUpdateable()){
            update invoices;
        }
    }
    public static void deleteDocumentFromInvoice (Id invoiceId){
        system.debug(LoggingLevel.INFO,'Inicia deleteDocumentFromInvoice');
        List<Takedown_Invoice__c> invoices = new List<Takedown_Invoice__c>();
        Takedown_Invoice__c invoice = new Takedown_Invoice__c();
        invoice.Id = invoiceId;
        invoice.TKD_tl_Eng_message__c = 'The document has been deleted, please upload the new version';
        invoice.TKD_ls_Eng_Status__c = 'action:canvas';
        invoice.TKD_txt_Extension__c = '';
        invoice.TKD_tl_SAT_message__c = 'The document has been deleted, please upload the new version';
        invoice.TKD_ls_SAT_Status__c = 'action:canvas';        
        invoice.TKD_txt_Document_ID__c = '';
        invoice.TKD_txt_Content_Version_ID__c = '';
        if(Schema.sObjectType.Takedown_Invoice__c.isUpdateable()){
            update invoice;
        }
    }
    public static void upsertInvoices (List<Takedown_Invoice__c> documentsInProcess){
        system.debug(LoggingLevel.INFO,'Inicia upsertInvoices');
        List<Database.UpsertResult> resulOperation = Database.upsert(documentsInProcess,  false );
        for(Database.UpsertResult result : resulOperation){
        	if (result.isSuccess()) {
        		// Operation was successful, so get the ID of the record that was processed
                System.debug('Successfully inserted Asset. Asset ID: ' + result.getId());
            }else {
            	// Operation failed, so get all errors                
                for(Database.Error err : result.getErrors()) {
                	System.debug('The following error has occurred.');                    
                    System.debug(err.getStatusCode() + ': ' + err.getMessage());
                    System.debug('Account fields that affected this error: ' + err.getFields());
                }
            }    
        }        
    }
}