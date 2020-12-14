@Istest
private class Data_Access_cms_estructuraTest {
     @testSetup static void setup(){
        //creation of EIV parameters
        list<EIV_Parameter__c> parameters = Test.loadData(EIV_Parameter__c.sobjectType, 'parametrosTest');
        System.assert(parameters.size()>0);
    }
	@Istest
    static void getMessageEstructureTest(){
        Opportunity opp  = new Opportunity();
        opp.Name ='TEST';
        opp.StageName ='Nuevo';
        opp.CloseDate = Date.today();
        opp.amount = 50000;
        opp.RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByDeveloperName().get('OPP_LMM').getRecordTypeId(); 
        Insert opp;
        string quey = 'Select LMM_tx_Entity_Name__c,LMM_tx_RFC__c,LMM_ls_Entity_Type__c FROM LMM_Entidad_de_oportunidad__c WHERE LMM_pd_Oportunidad__c =';
        Data_Access_cms_estructura.getMessageEstructure(quey,opp.Id,false,null,'Opportunity');
    }
    
    @Istest
    static void getMessageEstructureTest2(){
        Takedowns_Contingency_plan__c tkd = Data_Factory_Takedown_Test.createTakedown('OPERFIN-FIJA', 'entityCPName', 'entityCPRFCTIN');
        string quey = 'Select LMM_tx_Entity_Name__c,LMM_tx_RFC__c,LMM_ls_Entity_Type__c FROM LMM_Entidad_de_oportunidad__c WHERE LMM_pd_Oportunidad__c=';
        Data_Access_cms_estructura.getMessageEstructure(quey,tkd.Id,true,'CPL_rb_Opp__c','Takedowns_Contingency_plan__c');
    }
}