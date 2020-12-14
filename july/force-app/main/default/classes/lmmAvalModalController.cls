public without sharing class lmmAvalModalController {
    
    @AuraEnabled(Cacheable=true)
    public static list<LMM_Entidad_de_oportunidad__c> getEntidades(string recordId){
        list<LMM_Entidad_de_oportunidad__c> ents = [Select Id, LMM_tx_Entity_Name__c, Is_Aval__c from LMM_Entidad_de_oportunidad__c where LMM_pd_Oportunidad__c =:recordId];
        return ents;
    }

    @AuraEnabled(Cacheable= false)
    public static list<LMM_Entidad_de_oportunidad__c> getAvales(string recordId){
        list<LMM_Entidad_de_oportunidad__c> ents = [Select Id, LMM_tx_Entity_Name__c, Is_Aval__c from LMM_Entidad_de_oportunidad__c where LMM_pd_Oportunidad__c =:recordId AND Is_Aval__c =true];
        return ents;
    }
}