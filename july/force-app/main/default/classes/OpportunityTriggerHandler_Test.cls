@isTest
public class OpportunityTriggerHandler_Test {
	@isTest
    public static void OpportunityTriggerHandler(){
        Opportunity opp = Data_Factory_Opportunity_Test.createNewOpportunityTypeSales();
        delete opp;
    }
    
     @Istest
    static void oppts(){
        OpportunityTriggerHandler a = new OpportunityTriggerHandler();
        
    }
    
    @isTest
    public static void OpportunityTriggerHandlerreporte(){
        Opportunity opp = Data_Factory_Opportunity_Test.createNewOpportunityTypeSales();
        opp.RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByDeveloperName().get('OPP_LMM').getRecordTypeId();
        opp.LMM_Reporte_de_Visita_lleno__c =false;
        opp.LMM_Status_Risk__c = null;
        update opp;
        
        opp.LMM_Status_Risk__c ='Pending';
        try{
             update opp;
        }catch(Exception e){
            
        }
       
    }
}