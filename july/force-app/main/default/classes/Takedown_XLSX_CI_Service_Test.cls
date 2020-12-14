@isTest
public class Takedown_XLSX_CI_Service_Test {
	@isTest
    public static void makeContractImport_Test(){
        list<EIV_Parameter__c> parameters = Test.loadData(EIV_Parameter__c.sobjectType, 'parametrosTest');
        Takedowns_Contingency_plan__c takedown = Data_Factory_Takedown_Test.createTakedown('OPERFIN-FIJA','CDMX', 'CDMX123456');
        Takedown_XLSX_CI_Service_cls Test = new Takedown_XLSX_CI_Service_cls();
        Test.makeContractImport(takedown.Id);
    }
}