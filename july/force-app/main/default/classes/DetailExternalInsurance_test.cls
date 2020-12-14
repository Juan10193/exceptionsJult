@IsTest
private class DetailExternalInsurance_test {

    static testMethod void createdInsurancePoliceSuccess() {
        Id idTakedown = DetailExternalInsurance_test.createdTakedown();
        Id idInsuranceToGo = DetailExternalInsurance_test.createdInsuranceToGo(idTakedown);
        Id idInsurancePolice = DetailExternalInsurance_test.createdInsurancePolices(idInsuranceToGo);
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = 'services/apexrest/DetailsExternalInsurance/';
        req.params.put('idInsurance', idInsurancePolice);
        req.httpMethod = 'Get';
        RestContext.request = req;
        RestContext.response = res;
        DetailsExternalInsurance.getDetailExternalInsurance();
    }
    
    static testMethod void createdInsurancePoliceDml() {
        Id idTakedown = DetailExternalInsurance_test.createdTakedown();
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = 'services/apexrest/DetailsExternalInsurance/';
        req.params.put('idInsurance', idTakedown);
        req.httpMethod = 'Get';
        RestContext.request = req;
        RestContext.response = res;
        DetailsExternalInsurance.getDetailExternalInsurance();
    }    
    
    static testMethod void createdInsurancePoliceEmpty() {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = 'services/apexrest/DetailsExternalInsurance/';
        req.params.put('idInsurance', null);
        req.httpMethod = 'Get';
        RestContext.request = req;
        RestContext.response = res;
        DetailsExternalInsurance.getDetailExternalInsurance();
    } 
    
    static testMethod void upsertInsurancePoliceError() {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = 'services/apexrest/DetailsExternalInsurance/';
        req.requestBody = Blob.valueof('{}');
        req.httpMethod = 'PUT';
        RestContext.request = req;
        RestContext.response = res;
        DetailsExternalInsurance.updateDetailExternalInsurance();
    }
    
    static testMethod void upsertInsurancePoliceEmpty() {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = 'services/apexrest/DetailsExternalInsurance/';
        req.requestBody = Blob.valueof('');
        req.httpMethod = 'PUT';
        RestContext.request = req;
        RestContext.response = res;
        DetailsExternalInsurance.updateDetailExternalInsurance();
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
}