@isTest 
public class LMM_SynchronizeEntityCPController_Test {
    @istest static void updateEntityCPNoResponse(){
        Test.setMock(HttpCalloutMock.class, new EIV_EntityCalloutGeneralMock.badResponse());
        Entity_CP__c Entity_CP = Data_Factory_EntityCp.createEntityCP('name', 'rfcTin');
        test.startTest();
        try{
            LMM_SynchronizeEntityCPController.updateEntityCP(Entity_CP.id);
        }catch(Exception e){
            System.debug('Error en la respuesta ' + e.getStackTraceString());
        }        
        test.stopTest();
    }
    @istest static void updateEntityCP(){
        Test.setMock(HttpCalloutMock.class, new EIV_EntityCalloutGeneralMock.responseEntityMaster());
        Entity_CP__c Entity_CP = Data_Factory_EntityCp.createEntityCP('name', 'rfcTin');
        test.startTest();
        LMM_SynchronizeEntityCPController.updateEntityCP(Entity_CP.id);
        test.stopTest();
    }
        @istest static void EntityNotFound(){
        Test.setMock(HttpCalloutMock.class, new EIV_EntityCalloutGeneralMock.responseEntityNotFound());
        Entity_CP__c Entity_CP = Data_Factory_EntityCp.createEntityCP('name', 'rfcTin');
        test.startTest();
        try{
            LMM_SynchronizeEntityCPController.updateEntityCP(Entity_CP.id);
        }catch(Exception e){
            System.debug('Error en la respuesta ' + e.getStackTraceString());
        }   
        test.stopTest();
    }
}