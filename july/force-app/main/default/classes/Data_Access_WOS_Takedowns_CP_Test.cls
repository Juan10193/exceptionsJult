@isTest
public class Data_Access_WOS_Takedowns_CP_Test {
    @isTest static void Data_Access_Takedown_CP() {
        list<EIV_Parameter__c> parameters = Test.loadData(EIV_Parameter__c.sobjectType, 'parametrosTest');
        Takedowns_Contingency_plan__c Takedown_CP =Data_Factory_Takedown_Test.createTakedown('AFINAN-FIJA', 'EJEMPLO', 'EJEMPLO1111');
        Takedown_CP = Data_Access_WOS_Takedowns_CP_cls.getAllFields(Takedown_CP.Id);
    }
}