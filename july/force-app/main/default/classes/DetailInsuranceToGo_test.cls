@IsTest
private class DetailInsuranceToGo_test {

    static testMethod void createdTakedowWithoutInsurance() {
        Id idTakedown = DetailInsuranceToGo_Test.createdTakedown();
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = 'services/apexrest/DetailsInsuranceToGo/';
        req.params.put('idTakedown', idTakedown);
        req.httpMethod = 'Get';
        RestContext.request = req;
        RestContext.response = res;
        DetailsInsuranceToGo.getDetailsInsurance();
    }
    
    static testMethod void createdTakedownWithInsurance() {
        Id idTakedown = DetailInsuranceToGo_Test.createdTakedown();
        Id InsuranceToGo = DetailInsuranceToGo_Test.createdInsuranceToGo(idTakedown);
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = 'services/apexrest/DetailsInsuranceToGo/';
        req.params.put('idTakedown', idTakedown);
        req.httpMethod = 'Get';
        RestContext.request = req;
        RestContext.response = res;
        DetailsInsuranceToGo.getDetailsInsurance();
    }
    
    static testMethod void callWithoutTakedown() {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = 'services/apexrest/DetailsInsuranceToGo/';
        req.params.put('idTakedown', null);
        req.httpMethod = 'Get';
        RestContext.request = req;
        RestContext.response = res;
        DetailsInsuranceToGo.getDetailsInsurance();
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
}