@Istest
private class CMS_Controller_Test {
    
    @ISTEST
    static void getUserFieldsTest(){
        CMS_Controller.getUserFields();
        Opportunity opp  = new Opportunity();
        opp.Name ='TEST';
        opp.StageName ='Nuevo';
        opp.CloseDate = Date.today();
        opp.amount = 50000;
        opp.RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByDeveloperName().get('OPP_LMM').getRecordTypeId(); 
        Insert opp;
        CMS_Controller.getRecordNameById(opp.Id, 'Opportunity');
    }
}