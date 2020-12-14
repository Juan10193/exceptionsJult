@isTest
public class TKD_LinkLAtoTakedownCallout_Test {
     @testSetup static void setup(){
        //creation of EIV parameters
        list<EIV_Parameter__c> parameters = Test.loadData(EIV_Parameter__c.sobjectType, 'parametrosTest');
        System.assert(parameters.size()>0);
    }

	@isTest
    public static void  fetchLASINTD(){
        Takedowns_Contingency_plan__c takedown = Data_Factory_Takedown_Test.createTakedownNowkopp('OPERFIN-FIJA', 'entityCPName', 'entityCPRFCTIN'); 
        TKD_LinkLAtoTakedownCallout_cls.fetchLASINTD(takedown.Id);
    }
}