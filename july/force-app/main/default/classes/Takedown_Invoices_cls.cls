/**
 * @File Name          : takedown_Invoices_cls.cls
 * @Description        : 
 * @Author             : jhernandez@anivia.mx
 * @Group              : 
 * @Last Modified By   : eduardo.villegas@engeniumcapital.com
 * @Last Modified On   : 23/12/2019 14:40:21
 * @Modification Log   : 
 *==============================================================================
 * Ver         Date                     Author      		      Modification
 *==============================================================================
 * 1.0    9/7/2019 23:50:34   jhernandez@anivia.mx     Initial Version
**/
public with sharing class Takedown_Invoices_cls {
    
    
    /**
    * @description
    * @author jhernandez@anivia.mx | 9/7/2019
    * @param string recordId
    * @param list<string> contentDocumentIds
    * @return void
    */
    @AuraEnabled(cacheable=false)
    public static void insertInvoices(string recordId, list<string> contentDocumentIds){
        list<ContentVersion>version= Data_Access_ContentVersion.getInvoicesTakedown(contentDocumentIds);

        list<Takedown_Invoice__c> tinvoices = new list<Takedown_Invoice__c>();
        for(ContentVersion item: version){
            Takedown_Invoice__c invoice = new Takedown_Invoice__c();
            invoice.TKD_txt_Content_Version_ID__c = item.Id;
            invoice.TKD_txt_Extension__c = item.FileExtension;
            //invoice.TKD_ls_Status__c = 'In Salesforce';
            invoice.TKD_pd_Takedown_CP__c = recordId;
            invoice.Name = item.Title;
            invoice.TKD_txt_Document_ID__c = item.ContentDocumentId;
            invoice.TKD_ls_SAT_Status__c = getDocumentStatus(item.FileExtension);
            invoice.TKD_ls_Eng_Status__c = getDocumentStatus(item.FileExtension);
            tinvoices.add(invoice); 
        }
        if(Schema.sObjectType.Takedown_Invoice__c.isCreateable()){
            insert tinvoices;
            System.debug('se insertron');
        }else{
            System.debug('Error: User is unauthorized to modify the Takedown_Invoice__c Object');
        }
    }
    @AuraEnabled(cacheable=false)
    public static void InsertDocumentAndUpdateInvoice(string recordId, list<string> contentDocumentIds){
        list<ContentVersion>version= Data_Access_ContentVersion.getInvoicesTakedown(contentDocumentIds);

        Takedown_Invoice__c invoice = new Takedown_Invoice__c();
        for(ContentVersion item: version){            
            invoice.id = recordId;
            invoice.TKD_txt_Content_Version_ID__c = item.Id;
            invoice.TKD_txt_Extension__c = item.FileExtension;            
            invoice.Name = item.Title;
            invoice.TKD_txt_Document_ID__c = item.ContentDocumentId;
            invoice.TKD_ls_SAT_Status__c = getDocumentStatus(item.FileExtension);
            invoice.TKD_ls_Eng_Status__c = getDocumentStatus(item.FileExtension);
            invoice.TKD_tl_SAT_message__c = '';
            invoice.TKD_tl_Eng_message__c = '';
        }
        if(Schema.sObjectType.Takedown_Invoice__c.isUpdateable()){
            update invoice;
            System.debug('se actualizaron');
        }else{
            System.debug('Error: User is unauthorized to modify the Takedown_Invoice__c Object');
        }
    }
    public static String getDocumentStatus(String fileExtension){
        String documentStatus;
        switch on fileExtension {
            when 'pdf' {		// when block 1
                documentStatus = null;
            }
            when else {		  // default block, optional
                documentStatus = 'action:priority';
            }
        }
        return documentStatus;
        
    }

 

}