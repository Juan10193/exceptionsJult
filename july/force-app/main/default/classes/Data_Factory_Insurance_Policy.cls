@IsTest
public class Data_Factory_Insurance_Policy {
    public static Insurance_Policy__c createExternalInsurancePolicy(id insuranceVoBoId){
       Insurance_Policy__c Insurance_Policy = new Insurance_Policy__c();
       Insurance_Policy.RecordTypeId = Schema.SObjectType.Insurance_Policy__c.getRecordTypeInfosByName().get('External Insurance - Initial').getRecordTypeId();
       Insurance_Policy.Insurance_VoBo__c = insuranceVoBoId; 
       Insurance_Policy.Insurance_Policy_Number__c = '101024';
       Insurance_Policy.Insurance_carrier__c = 'Acord';
       Insurance_Policy.Start_of_Validity__c = Date.Today();
       Insurance_Policy.End_of_Validity__c = Date.Today() + 1;
       Insurance_Policy.Policy_Type__c = '"Individual Transporte"';
       Insurance_Policy.Coverage_Type__c = '"Contenidos"';
       insert Insurance_Policy;
       return Insurance_Policy;
    }
    public static Insurance_Policy__c createInternalInsurancePolicy(id insuranceVoBoId){
       Insurance_Policy__c Insurance_Policy = new Insurance_Policy__c();
       Insurance_Policy.RecordTypeId = Schema.SObjectType.Insurance_Policy__c.getRecordTypeInfosByName().get('Engenium - Initial').getRecordTypeId();
       Insurance_Policy.Insurance_VoBo__c = insuranceVoBoId; 
       Insurance_Policy.Broker__c = 'Interesse';
       Insurance_Policy.Net_Premium__c = 1;
       Insurance_Policy.Issuing_Costs__c = 1;   
       Insurance_Policy.Rebate__c = 1;
       Insurance_Policy.Insurance_carrier__c = 'AXA';
        Insurance_Policy.Coverage_Type__c = '"Contenidos"';
       insert Insurance_Policy;
       return Insurance_Policy;
    }
    
}