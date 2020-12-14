@isTest
public class Takedown_CA_VS_ST_Service_Test {
	@isTest
    public static void getPricingsAndMakeWrapper(){
        list<EIV_Parameter__c> parameters = Test.loadData(EIV_Parameter__c.sobjectType, 'parametrosTest');
        Takedowns_Contingency_plan__c Test_TKD = Data_Factory_Takedown_Test.createTakedown('OPERFIN-FIJA','Tolantongo', 'TOLA123456');
        Takedown_CA_VS_ST_Service_cls Test = new Takedown_CA_VS_ST_Service_cls();
        test.getPricingsAndMakeWrapper(Test_TKD.id);
    }
}