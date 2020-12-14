public class ContentVersionAlt {
	@AuraEnabled        
    
    public static List<ContentDocument> getContentVersions(string sourceCAID) {
        
        
        list<ContentDocumentLink> doctosIDs = [select ContentDocumentId  from ContentDocumentLink where LinkedEntityId=:sourceCAID];
        
        list<string>documentosiD = new list<string>();
        SYSTEM.debug('JD doctosIds: ' + doctosIDs);  
       
        for(integer i=0; i<=doctosIDs.size()-1 ; i++){
            
            string laid = string.valueOf(doctosIDs[i].get('ContentDocumentId'));
            documentosiD.add(laid);
        }
      
        list<ContentDocument>documentosObj = [select Title, Description, FileType, 	CreatedDate  from ContentDocument where id IN : documentosiD];
    return documentosObj;
    }
    
}