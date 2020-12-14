global class LMMSendKYCBatch implements Database.Batchable<sObject>{
    private id opportunityId;
    global LMMSendKYCBatch(id opportunityId){
        this.opportunityId = opportunityId;
    }
    global Database.QueryLocator start(Database.BatchableContext BC) {
        String query = 'SELECT Id, Name, LMM_pd_Entity_CP__c, LMM_pd_Oportunidad__c ' 
                + 'FROM LMM_Entidad_de_oportunidad__c where LMM_pd_Oportunidad__c = :opportunityId ';
        return Database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext BC, List<LMM_Entidad_de_oportunidad__c> listLMM_Entidad_de_oportunidad) {
        set<Id> setEntityId = new set<Id>();
        for(LMM_Entidad_de_oportunidad__c LMM_Entidad_de_oportunidad : listLMM_Entidad_de_oportunidad){
                    setEntityId.add(LMM_Entidad_de_oportunidad.LMM_pd_Entity_CP__c);
        }
        map<id,LMM_Custom_Contact__c> mapNewContactKYC = new map<id,LMM_Custom_Contact__c>();
        map<id,LMM_Custom_Contact__c> mapContactKYC = new map<id,LMM_Custom_Contact__c>();
        for(LMM_Custom_Contact__c LMM_Custom_Contact : [SELECT LMM_tx_Primer_nombre__c, LMM_tx_Segundo_nombre__c, LMM_tx_Apellido_paterno__c, LMM_tx_Apellido_materno__c, 
                            LMM_ce_Correo_electronico__c, LMM_tf_Telefono_celular__c, LMM_tx_Oracle_Id__c, LMM_rb_Entity_CP__c, Id, Name,
                            LMM_rb_Entity_CP__r.Name, LMM_rb_Entity_CP__r.EM_Party_ID__c,
                            LMM_rb_KYC__c, LMM_rb_KYC__r.LMM_ls_Estatus__c         
                            FROM LMM_Custom_Contact__c where LMM_rb_Entity_CP__c in :setEntityId]){
                                if(String.isBlank(LMM_Custom_Contact.LMM_rb_KYC__c)){
                                    mapNewContactKYC.put(LMM_Custom_Contact.id,LMM_Custom_Contact);                                	    
                                } else {
                                    mapContactKYC.put(LMM_Custom_Contact.id,LMM_Custom_Contact);
                                }
			                                
        }
        
    }   

    global void finish(Database.BatchableContext BC){    
    }

}