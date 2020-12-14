public without sharing class LMM_LinkEvalToOpportunityController {
    
    @AuraEnabled(cacheable = false)
    public static list<LMM_Entidad_de_oportunidad__c> getEntidadesdeLaOpportunidad(Id recordId){
        return Data_Access_LMM_Entidad_de_oportunidad.getEntidadesDeOportunindadByOpp(recordId);
    }
}