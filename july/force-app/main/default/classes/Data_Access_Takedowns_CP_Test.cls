@Istest
private class Data_Access_Takedowns_CP_Test {
     @testSetup static void setup(){
        //creation of EIV parameters
        list<EIV_Parameter__c> parameters = Test.loadData(EIV_Parameter__c.sobjectType, 'parametrosTest');
        System.assert(parameters.size()>0);
    }
    
    @Istest
    public static void getAllFieldsByID(){
        list<EIV_Parameter__c> parameters = Test.loadData(EIV_Parameter__c.sobjectType, 'parametrosTest');
        Takedowns_Contingency_plan__c takedown = Data_Factory_Takedown_Test.createTakedown('OPERFIN-FIJA','Tolantongo', 'TOLA123456'); 
        Data_Access_Takedowns_CP_cls.getAllFieldsByID(takedown.id);
    }
    
	@Istest
    public static void getAllFieldsBulkRecordsTest(){
        list<EIV_Parameter__c> parameters = Test.loadData(EIV_Parameter__c.sobjectType, 'parametrosTest');
        Takedowns_Contingency_plan__c takedown = Data_Factory_Takedown_Test.createTakedown('OPERFIN-FIJA','Tolantongo', 'TOLA123456'); 
        set<Id> takedowns = new set<Id>();
        takedowns.add(takedown.id);
        Data_Access_Takedowns_CP_cls.getAllFieldsBulkRecords(takedowns);
    }
    
    @Istest
    static void getAssetsByTakedownTest(){
        Takedowns_Contingency_plan__c takedown = Data_Factory_Takedown_Test.createTakedown('OPERFIN-FIJA','Tolantongo', 'TOLA123456'); 
        set<Id> takedowns = new set<Id>();
        takedowns.add(takedown.Id);
      	Data_Access_Takedowns_CP_cls.getAssetsByTakedown(takedowns);
    }
    
     @Istest
    static void getBooleanIfNotHaveABTest(){
        Takedowns_Contingency_plan__c takedown =  Data_Factory_TakedownInvoice_Test.getTakedownWhitInvoice('pdf');
      	Data_Access_Takedowns_CP_cls.getBooleanIfNotHaveAB(takedown.Id);
        
    }
    
    
}