global class DetailsExternalInsurance_cls {
	 
    public Insurance_Policy__c insuranceExternal {get; set;}
    public List<DetailsExternalInsurance_cls.FileShare> documentInsurance {get; set;}
    
    public DetailsExternalInsurance_cls(String idInsurance) {
        this.insuranceExternal = [SELECT Id, All_Risk_Covered__c, Broker__c, Broker_Assigned_for_Recovery__c, Cancellation_Date__c, Comments__c, CreatedById, CurrencyIsoCode,
                                  Customer__c, Customer_Name__c, Payment_Type__c, Economic_Group__c, Economic_Group_Name__c, End_of_Validity__c, Coverage_Type__c, Evergreen__c,
                                  Insurance_Coverage__c, External_Status__c, Insurance_carrier__c, Name, Insurance_Policy_Number__c, Insurance_Term__c, Insurance_Type__c, Insurance_VoBo__c,
                                  Invoice_Delivery_Date__c, Invoice_Number__c, Issuing_Costs__c, LastModifiedById, Net_Book_Value__c, Net_Premium__c, Net_Premium_Recovery__c, Notification_Sent__c,
                                  Operation_Unit__c, Paid_Policy__c, Payment_Application_Date__c, Payment_Date__c, Payment_Request_Date__c, Policy_Delivery_Date__c, Policy_Type__c,
                                  Preferred_Beneficiary_Endorsment__c, Previous_Insurance_Policy__c, Quote_Sent__c, Rebate__c, Rebate_UDI_Payback__c, Reference_Number__c, Renovated__c, 
                                  Renovation_Insurance_Type__c, Start_of_Validity__c, Status__c, Sum_Assured__c, Takedown_Currency__c, Total_Premium__c, Asset_Group_Identifier__c, Asset_Group__c,
                                  UDI__c, UDI_Invoiced_To__c, Validity__c, VAT__c, VoBo_Stage__c, RecordTypeName__c
                                  FROM Insurance_Policy__c WHERE id =: idInsurance];
        
        this.documentInsurance = DetailsExternalInsurance_cls.getFiles(idInsurance);
    }
    
    public static DetailsExternalInsurance_cls.Response updateExternalInsurance_cls(String bodyInsurance) {
        DetailsExternalInsurance_cls.Response response = new DetailsExternalInsurance_cls.Response();
        Insurance_Policy__c updateInsurance = new Insurance_Policy__c();
        
        try {
            updateInsurance = (Insurance_Policy__c)JSON.deserialize(bodyInsurance, Insurance_Policy__c.Class);
            upsert updateInsurance;
            response.status = 'Success';
            response.message = 'Records updated / created successfully';
        } catch(DMLException e) {
            System.debug('Error: ' + e.getMessage());
            response.status = 'Fail';
            response.message = 'Error: ' + e.getMessage();
        }
        return response;
    }
    
    public static List<DetailsExternalInsurance_cls.FileShare> getFiles(String idInsurance) {
        List<ContentDocumentLink> feedAttachmentList = new List<ContentDocumentLink>();
        List<DetailsExternalInsurance_cls.FileShare> files = new List<DetailsExternalInsurance_cls.FileShare>();
        
        feedAttachmentList = [SELECT ContentDocumentId, ContentDocument.Title, ContentDocument.FileExtension FROM ContentDocumentLink WHERE LinkedEntityId =: idInsurance];
        for(ContentDocumentLink flag : feedAttachmentList) {
            DetailsExternalInsurance_cls.FileShare fileShare = new DetailsExternalInsurance_cls.FileShare();
            fileShare.idDocument = flag.ContentDocumentId;
            fileShare.nameFile = flag.ContentDocument.Title;
            fileShare.extensionFile = flag.ContentDocument.FileExtension;
            files.add(fileShare);
        }
        return files;
    }
    
    public class FileShare {
        public String idDocument {get; set;}
        public String nameFile {get; set;}
        public String extensionFile {get; set;}
    }
    
    public class Response {
        public String status {get; set;}
        public String message {get; set;}
    }
}