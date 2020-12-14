/**
 * @File Name          : Data_Access_ContentVersion.cls
 * @Description        : 
 * @Author             : ChangeMeIn@UserSettingsUnder.SFDoc
 * @Group              : 
 * @Last Modified By   : eduardo.amiens@outlook.com
 * @Last Modified On   : 30/7/2019 18:33:42
 * @Modification Log   : 
 *==============================================================================
 * Ver         Date                     Author      		      Modification
 *==============================================================================
 * 1.0    9/7/2019 23:34:45   ChangeMeIn@UserSettingsUnder.SFDoc     Initial Version
**/
public with sharing class Data_Access_ContentVersion {

    public Data_Access_ContentVersion (){
        
    }
    
    /**
    * @description
    * @author jhernandez@anivia.mx | 9/7/2019
    * @param list<string> contentDocumentIds
    * @return list<ContentVersion>
    */
    public static list<ContentVersion> getInvoicesTakedown(list<string> contentDocumentIds){
        list<ContentVersion>version = new List<ContentVersion>();
        if(Schema.sObjectType.ContentVersion.isAccessible()){
            version=[SELECT VersionData, Title, PathOnClient, LastModifiedDate, LastModifiedById, IsMajorVersion, Id, FileType, 
                            FileExtension, CreatedDate, CreatedById, ContentSize, ContentModifiedDate, ContentModifiedById, 
                            ContentLocation, ContentDocumentId, ContentBodyId, Checksum 
                            FROM ContentVersion
                                     where ContentDocumentId in :contentDocumentIds];
        }else{
            system.debug('Error: User is unauthorized to access the ContentVersion');
        }
        return version;
    }
    public static list<ContentVersion> getInvoicesTakedownByID(set<id> setIds){
        list<ContentVersion>version = new List<ContentVersion>();
        if(Schema.sObjectType.ContentVersion.isAccessible()){
            version=[SELECT VersionData, Title, PathOnClient, LastModifiedDate, LastModifiedById, IsMajorVersion, Id, FileType, 
                            FileExtension, CreatedDate, CreatedById, ContentSize, ContentModifiedDate, ContentModifiedById, 
                            ContentLocation, ContentDocumentId, ContentBodyId, Checksum 
                            FROM ContentVersion
                                     where id in :setIds];
        }else{
            system.debug('Error: User is unauthorized to access the ContentVersion');
        }
        return version;
    }
    //Get content version to use the data for the trigger ATCH_tgr_ContentMaster_LEC, we need to get the specific document id that doesnt have FirstPublishLocationId
    public static list<ContentVersion> getContentVersionToUpdateOP(set<id> setIds){
        list<ContentVersion>version = new List<ContentVersion>();
        if(Schema.sObjectType.ContentVersion.isAccessible()){
            version = [SELECT Id, ContentDocumentId, FirstPublishLocationId, PathOnClient 
                     	FROM ContentVersion 
                     	WHERE ContentDocumentId in :setIds 
                     	and FirstPublishLocationId != null];
        }else{
            system.debug('Error: User is unauthorized to access the ContentVersion');
        }
        return version;
    }

}