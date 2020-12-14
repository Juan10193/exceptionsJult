/**
 * @File Name          : DMLO_ContentDocument_cls.cls
 * @Description        : 
 * @Author             : jhernandez@anivia.mx
 * @Group              : 
 * @Last Modified By   : jhernandez@anivia.mx
 * @Last Modified On   : 15/7/2019 17:23:33
 * @Modification Log   : 
 *==============================================================================
 * Ver         Date                     Author      		      Modification
 *==============================================================================
 * 1.0    15/7/2019 8:47:46   jhernandez@anivia.mx     Initial Version
**/
public without sharing class DMLO_ContentDocument_cls {
    /**
    * @description
    * @author jhernandez@anivia.mx | 15/7/2019
    * @param string takedownDocId
    * @return void
    */
    public static void deleteTakedownDoc(string takedownDocId){
        ContentDocument doc = new ContentDocument();
        doc.Id =takedownDocId;
       // if(Schema.sObjectType.ContentDocument.isDeletable()){
            //Delete doc;
        //}
        Database.DeleteResult deleteRecordResult = Database.delete(doc, false);
       	if (deleteRecordResult.isSuccess()) {
            // Operation was successful, so get the ID of the record that was processed
        	System.debug('Successfully deleted contentDocument');
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
    * @param List<Id> takedownIds
    * @return void
    */
    public static void deleteTakedownDocs(List<Id>takedownIds){
        List<ContentDocument> documents = new List<ContentDocument>();
        for(Id doc : takedownIds) {
            if(doc != null){
            	ContentDocument cont = new ContentDocument();
            cont.Id = doc;
            documents.add(cont);    
            }
            
        }

        Database.DeleteResult[] deleteList = Database.delete(documents, true);
        String errors;
        for(Database.DeleteResult result : deleteList){
        	if (result.isSuccess()) {
            // Operation was successful, so get the ID of the record that was processed
        	System.debug('Successfully deleted Asset');
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
}