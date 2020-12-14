@IsTest
private class DetailsInsuranceToGo_test {
	
    static TestMethod void createInsurance() {
        Id idTakedown = DetailsInsuranceToGo_test.createdTakedown();
        Id idInsuranceToGo = DetailsInsuranceToGo_test.createdInsuranceToGo(idTakedown);
        Id idInsurancePolice = DetailsInsuranceToGo_test.createdInsurancePolices(idInsuranceToGo);
        DetailsInsuranceToGo_test.createdDocuments(idInsuranceToGo);
        DetailsInsuranceToGo_test.submitForApproval(idInsuranceToGo);
        new DetailsInsuranceToGo_cls(idTakedown);
    }
    
    static TestMethod void createdAnotherMethods() {
        DetailsInsuranceToGo_cls.Response response = new DetailsInsuranceToGo_cls.Response();
        response.status = 'Test';
        response.message = 'Some Test';
        
        DetailsInsuranceToGo_cls.getFiles('');
    }
    
    public static id createdTakedown() {
        EIV_Parameter__c parameters = new EIV_Parameter__c();
        parameters.name = 'fecha limite';
        parameters.EIV_tx_parameter__c = '01/12/2018';
        insert parameters;
        Takedowns_Contingency_plan__c takedown = Data_Factory_Takedown_Test.createTakedown('OPERFIN-FIJA','CDMX', 'CDMX123456');
        
        return takedown.Id;
    }
    
    public static id createdInsuranceToGo(String idTakedown) {
        Id idRecordInsurance = Schema.SObjectType.Insurance_VoBo__c.getRecordTypeInfosByName().get('External Insurance').getRecordTypeId();
        
        Insurance_VoBo__c insuranceVoBo = new Insurance_VoBo__c();
        InsuranceVoBo.RecordTypeId = idRecordInsurance;
        insuranceVoBo.Insurance_Type__c = 'Customer Insurance with own provider';
        insuranceVoBo.Stage__c = 'T2 VoBO Request';
        insuranceVoBo.Requestor_Comments__c = 'Clase de prueba';
        InsuranceVoBO.Takedown_CP__c = idTakedown;
        insert insuranceVoBo;
        return insuranceVoBo.id;
    }
    
    public static id createdInsurancePolices(String idInsuranceToGo) {
        Id idRecordInsurancePolice = Schema.SObjectType.Insurance_Policy__c.getRecordTypeInfosByName().get('External Insurance - Initial').getRecordTypeId();
    	
        Insurance_Policy__c insurancePolice = new Insurance_Policy__c();
        insurancePolice.RecordTypeId = idRecordInsurancePolice;
        insurancePolice.Insurance_Policy_Number__c = 'TestPolice123';
        insurancePolice.Insurance_carrier__c = 'Afirme';
        insurancePolice.Start_of_Validity__c = Date.newInstance(2020, 09, 9);
        insurancePolice.End_of_Validity__c = Date.newInstance(2020, 09, 30);
        insurancePolice.Preferred_Beneficiary_Endorsment__c = 'Yes';
        insurancePolice.Quote_Sent__c = 'Yes';
        insurancePolice.Broker_Assigned_for_Recovery__c = 'Interesse';
        insurancePolice.Policy_Type__c = '"Empresarial"';
        insurancePolice.Coverage_Type__c = '"Rotura de Maquinaria"';
        insurancePolice.Insurance_VoBo__c = idInsuranceToGo;        
        insert insurancePolice;
        return insurancePolice.Id;
    }
    
    public static void createdDocuments(Id idInsurance) {
        List<ContentDocument> documents = [SELECT Id, Title, LatestPublishedVersionId FROM ContentDocument];
        
        contentVersion content = new ContentVersion();
        content.Title = 'TestPoo';
        content.PathOnClient = 'TestPoo.jpg';
        content.VersionData = Blob.valueOf('Content');
        content.IsMajorVersion = true;
        insert content;
        
        List<ContentDocument> document = [SELECT Id, Title, LatestPublishedVersionId FROM ContentDocument];
        
     	ContentDocumentLink documentContent = new ContentDocumentLink();
        documentContent.LinkedEntityId = idInsurance;
        documentContent.ContentDocumentId = document[0].Id;
        documentContent.ShareType = 'V';
        insert documentContent;
        System.debug(documentContent);
    }
    
    public static void submitForApproval(Id idInsurance) {
        Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
        req.setComments('Submit for Approval');
        req.setObjectId(idInsurance);
        req.setSubmitterId(UserInfo.getUserId());
        Approval.ProcessResult result = Approval.process(req);   
    }
}