@IsTest
public class Data_Factory_WaiverToGo {
    public static WaiverToGo__c createWaiver(id takedownId){
       WaiverToGo__c WaiverToGo = new WaiverToGo__c();
       //WaiverToGo.RecordTypeId = Schema.SObjectType.WaiverToGo__c.getRecordTypeInfosByName().get('#ExceptionToGo').getRecordTypeId();
       WaiverToGo.Takedown_CP__c = takedownId;
       WaiverToGo.Document_Type__c = 'Anti money laundry (AML)'; 
       WaiverToGo.Stage__c = 'New';
       WaiverToGo.Reason_for_Exception__c = 'Incomplete AML revision (this only applies for document generation, never for funding)';
       WaiverToGo.Commitment_Date__c = Date.Today();
       insert WaiverToGo;
       return WaiverToGo;
    }

}