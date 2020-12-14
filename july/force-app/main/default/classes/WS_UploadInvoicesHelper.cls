/**
 * @description       : 
 * @author            : eduardo.amiens@outlook.com
 * @group             : 
 * @last modified on  : 10-13-2020
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
 * Modifications Log 
 * Ver   Date         Author                       Modification
 * 1.0   10-09-2020   eduardo.amiens@outlook.com   Initial Version
**/
public with sharing class WS_UploadInvoicesHelper {
    
    public String recordId {get;set;} 
    public List<WS_UploadInvoicesWrapper> listWS_UploadInvoicesWrapper {get;set;}

    public WS_UploadInvoicesHelper(String recordId, List<WS_UploadInvoicesWrapper> listWS_UploadInvoicesWrapper){
        this.recordId = recordId;
        this.listWS_UploadInvoicesWrapper = listWS_UploadInvoicesWrapper;
    }

    public void uploadInvoicesHelper() {
        list<ContentVersion> listContentVersion = new list<ContentVersion>();
        for(WS_UploadInvoicesWrapper UploadInvoicesWrapper: listWS_UploadInvoicesWrapper){
            system.debug('EL WRAPPER INVOICES');
            system.debug(UploadInvoicesWrapper);
            ContentVersion cv = new ContentVersion(); 
            cv.ContentLocation = 'S';  
            Blob fileABlob = EncodingUtil.base64Decode(UploadInvoicesWrapper.base64Dcument);   
            //File is generated but there is nothing in it  
            cv.VersionData = fileABlob;
            cv.PathOnClient = UploadInvoicesWrapper.title + '.' + UploadInvoicesWrapper.extension;  
            cv.FirstPublishLocationId = this.recordId;
            listContentVersion.add(cv);
        }
        insert listContentVersion;
        list<string> contentversionIds = new list<string>();
        for(ContentVersion cv : listContentVersion){
            contentversionIds.add(cv.Id);
        }

        list<string> contentDocsIds = new list<string>();
        for (ContentVersion version : [SELECT ContentDocumentId FROM ContentVersion WHERE Id IN:contentversionIds]) {
            contentDocsIds.add(version.ContentDocumentId);
        }

        Takedown_Invoices_cls.insertInvoices(this.recordId,contentDocsIds);

    }
}