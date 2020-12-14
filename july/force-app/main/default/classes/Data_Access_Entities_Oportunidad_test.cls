@Istest
public class Data_Access_Entities_Oportunidad_test {
    
    	@Istest
    	static void entitiesInOp(){
        Opportunity opp = new Opportunity();
        opp.Amount = 10000;
        opp.Name ='MI OPP';
        opp.RecordTypeId =  Schema.SObjectType.Opportunity.getRecordTypeInfosByDeveloperName().get('OPP_LMM').getRecordTypeId();
        opp.StageName ='Nuevo';
        opp.CloseDate = Date.today();
        insert opp;
        Data_Access_Entities_Oportunidad.entitiesInOp(opp.Id);
    }

}