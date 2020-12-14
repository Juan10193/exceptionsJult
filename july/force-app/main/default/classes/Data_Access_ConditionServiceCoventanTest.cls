@Istest
public class Data_Access_ConditionServiceCoventanTest {
    
    @Istest
     static void getCSC(){
        ES3_obj_Condition_Service_covenant__c a = new ES3_obj_Condition_Service_covenant__c();
        insert a;
        Data_Access_ConditionServiceCoventant.getCSC(a.Id);
        Opportunity opp = new Opportunity();
        opp.Amount = 10000;
        opp.Name ='MI OPP';
        opp.RecordTypeId =  Schema.SObjectType.Opportunity.getRecordTypeInfosByDeveloperName().get('OPP_LMM').getRecordTypeId();
        opp.StageName ='Nuevo';
        opp.CloseDate = Date.today();
        insert opp;
        Data_Access_ConditionServiceCoventant.getCSC(opp.Id);
        try{
             Data_Access_ConditionServiceCoventant.getCSC(opp.Id);
        }catch(Exception e){
            system.debug('error');
            system.debug(e);
        }
       
    }

}