global class DetailsInsuranceToGo_cls {

    public Insurance_VoBo__c insuranceToGo {get; set;}
    public list<DetailsInsuranceToGo_cls.ApprovalHistory> approvalHistory {get; set;}
    public List<Insurance_Policy__c> insurancePoliceRelated {get; set;}
    public List<DetailsInsuranceToGo_cls.FileShare> documentInsurance {get; set;}
    
    public DetailsInsuranceToGo_cls(String idInsurance) {
        this.insuranceToGo = [SELECT Id, Name, InsurancePolicies__c, ExceptionToGo__c, Archivo_Prueba__c, Broker__c, Broker_Breakdown_Status__c, Control_Desk_Analyst__c, CreatedBy.Name,
                              CurrencyIsoCode, Customer__c, Financed__c, UDI__c, Generated_Interests__c, Insurance_Carrier__c, Insurance_Type__c, Issuing_Costs__c, LastModifiedBy.Name, 
                              Line_of_Business__c, Manager__c, Net_Premium__c, Operation_Unit__c, Originator__c, Rebate__c, Region__c, Requestor_Comments__c, Stage__c, Takedown_Amount__c, 
                              Takedown_CP__c, Takedown_CP__r.Name, Takedown_Currency__c, Term__c, Validity__c 
                              FROM Insurance_VoBo__c WHERE Takedown_CP__c =: idInsurance LIMIT 1];
        this.insurancePoliceRelated = [SELECT Id, Name, RecordTypeId, Insurance_Policy_Number__c, Insurance_carrier__c, Start_of_Validity__c, End_of_Validity__c, Asset_Group_Identifier__c
                                       FROM Insurance_Policy__c WHERE Insurance_VoBo__c =: this.insuranceToGo.Id];
        this.documentInsurance = getFiles(this.insuranceToGo.Id);
        this.approvalHistory = getApprovalHistory(this.insuranceToGo.Id);
    }
        
    public static List<DetailsInsuranceToGo_cls.FileShare> getFiles(String idInsurance) {
        List<ContentDocumentLink> feedAttachmentList = new List<ContentDocumentLink>();
        List<DetailsInsuranceToGo_cls.FileShare> files = new List<DetailsInsuranceToGo_cls.FileShare>();
        
        feedAttachmentList = [SELECT ContentDocumentId, ContentDocument.Title, ContentDocument.FileExtension FROM ContentDocumentLink WHERE LinkedEntityId =: idInsurance];
        for(ContentDocumentLink flag : feedAttachmentList) {
            DetailsInsuranceToGo_cls.FileShare fileShare = new DetailsInsuranceToGo_cls.FileShare();
            fileShare.idDocument = flag.ContentDocumentId;
            fileShare.nameFile = flag.ContentDocument.Title;
            fileShare.extensionFile = flag.ContentDocument.FileExtension;
            files.add(fileShare);
        }
        return files;
    }
    
    public static List<DetailsInsuranceToGo_cls.ApprovalHistory> getApprovalHistory(String idInsurance) {
    	List<Id> idProcessInstance = new List<Id>();
        List<DetailsInsuranceToGo_cls.ApprovalHistory> approvalHistory = new List<DetailsInsuranceToGo_cls.ApprovalHistory>();
        
		for(Insurance_VoBo__c wber : [SELECT Id, (SELECT ID FROM ProcessInstances ORDER BY CreatedDate DESC) FROM Insurance_VoBo__c WHERE Id =: idInsurance]) {
            for(ProcessInstance pi : wber.ProcessInstances) {
                idProcessInstance.add(pi.Id);
            }
        }
        
        for (ProcessInstance pi : [SELECT TargetObjectId, LastActorId, LastActor.Name,
                                   (SELECT Id, CreatedDate,ActorId, Actor.Name, OriginalActor.Name, Comments, StepStatus, ProcessInstanceId FROM StepsAndWorkitems WHERE StepStatus != 'NoResponse' Order BY ID DESC), 
                                   (SELECT Id, StepStatus, Comments FROM Steps ORDER BY CreatedDate DESC LIMIT 1 ) 
                                   FROM ProcessInstance WHERE Id IN : idProcessInstance ORDER BY CreatedDate DESC]) {
            if(pi.StepsAndWorkitems.size() > 0) {
                for(ProcessInstanceHistory pih :pi.StepsAndWorkitems) {
                    DetailsInsuranceToGo_cls.ApprovalHistory approvalHistories = new DetailsInsuranceToGo_cls.ApprovalHistory();
                    approvalHistories.status = pih.StepStatus;
                    approvalHistories.actor = pih.Actor.Name;
                    approvalHistories.dates = pih.CreatedDate.format('yyyy-MM-dd\'T\'HH:mm:ss','America/Mexico_City'); 
                    approvalHistories.comentarios = pih.Comments;
                    approvalHistory.add(approvalHistories);
                }
            }
        }
        return approvalHistory;
    }
    
    public class FileShare {
        public String idDocument {get; set;}
        public String nameFile {get; set;}
        public String extensionFile {get; set;}
    }    
        
	public class ApprovalHistory {
        public String status {get; set;}
        public String actor {get; set;}
        public String dates {get; set;}
        public String comentarios {get; set;}
    }

    public class Response {
        public String status {get; set;}
        public String message {get; set;}
    }
}