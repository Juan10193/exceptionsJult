@Istest
private class Data_Access_ContentVersion_Test {
     @testSetup static void setup(){
        //creation of EIV parameters
        list<EIV_Parameter__c> parameters = Test.loadData(EIV_Parameter__c.sobjectType, 'parametrosTest');
        System.assert(parameters.size()>0);
    }
    
	@Istest
    static void getInvoicesTakedownTest(){
        Data_Access_ContentVersion contentVer = new Data_Access_ContentVersion();
        Data_Factory_TakedownInvoice_Test.createTakedownInvoice('pdf');
       
        ContentVersion version=[SELECT VersionData, Title, PathOnClient, LastModifiedDate, LastModifiedById, IsMajorVersion, Id, FileType, 
                            FileExtension, CreatedDate, CreatedById, ContentSize, ContentModifiedDate, ContentModifiedById, 
                            ContentLocation, ContentDocumentId, ContentBodyId, Checksum 
                  FROM ContentVersion][0];
        list<Id>contentVersionIds = new list<Id>();
        
       Data_Access_ContentVersion.getInvoicesTakedown(contentVersionIds);
    }
    
    @Istest
    static void getInvoicesTakedownByIDTest(){
        Takedown_Invoice__c invoice =  Data_Factory_TakedownInvoice_Test.createTakedownInvoice('pdf');
        set<Id> invoiceIds = new set<Id>();
        Data_Access_ContentVersion.getInvoicesTakedownByID(invoiceIds);
    }
    
     @Istest
    static void getContentVersionToUpdateOPTest(){
        Data_Factory_TakedownInvoice_Test.createTakedownInvoice('pdf');
        ContentVersion version = [SELECT Id, ContentDocumentId, FirstPublishLocationId, PathOnClient 
                                  FROM ContentVersion][0];
        set<Id>contentVersionIds = new set<Id>();
        contentVersionIds.add(version.Id);
        Data_Access_ContentVersion.getContentVersionToUpdateOP(contentVersionIds);
        
    }
   
}