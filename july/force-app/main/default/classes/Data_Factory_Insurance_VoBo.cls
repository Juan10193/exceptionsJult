@IsTest
public class Data_Factory_Insurance_VoBo {
    public static Insurance_VoBo__c createInternalInsurance_VoBo(id takedownId){
       Insurance_VoBo__c Insurance_VoBo = new Insurance_VoBo__c();
       Insurance_VoBo.RecordTypeId = Schema.SObjectType.Insurance_VoBo__c.getRecordTypeInfosByName().get('Engenium Capital').getRecordTypeId();
       Insurance_VoBo.Takedown_CP__c = takedownId;
       Insurance_VoBo.Stage__c = 'T1 Quote Request';
       insert Insurance_VoBo;
       return Insurance_VoBo;
    }
    public static Insurance_VoBo__c createExternalInsurance_VoBo(id takedownId){
       Insurance_VoBo__c Insurance_VoBo = new Insurance_VoBo__c();
       Insurance_VoBo.RecordTypeId = Schema.SObjectType.Insurance_VoBo__c.getRecordTypeInfosByName().get('External Insurance').getRecordTypeId();
       Insurance_VoBo.Takedown_CP__c = takedownId; 
       Insurance_VoBo.Stage__c = 'T2 VoBo Request';
       Insurance_VoBo.Insurance_Type__c = 'Customer Insurance with own provider'; 
       insert Insurance_VoBo;
       return Insurance_VoBo;
    }

}