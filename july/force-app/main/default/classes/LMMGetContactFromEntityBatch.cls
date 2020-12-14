global class LMMGetContactFromEntityBatch implements Database.Batchable<sObject>,   Database.AllowsCallouts{
    private list<string> listPartyId;
    private string sso;        
    
    global LMMGetContactFromEntityBatch(list<string> listPartyId, string sso){
        this.listPartyId = listPartyId;
        this.sso = sso;
    }
    global Database.QueryLocator start(Database.BatchableContext BC) {
        String query = 'SELECT Id, Name, EM_Party_ID__c, EIV_tx_partyID__c '
           + 'FROM Entity_CP__c where EM_Party_ID__c in :listPartyId';
        return Database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext BC, List<Entity_CP__c> listEntity) {
        system.debug('Inicia consulta ');
        list<LMM_Custom_Contact__c> listLMM_Custom_Contact = new list<LMM_Custom_Contact__c>();
        for(Entity_CP__c Entity_CP : listEntity){
            system.debug('Entity_CP ' + Entity_CP);
            string bodyResponse = EIV_EntityCallout.getEntityBypartyID(Entity_CP.EM_Party_ID__c, this.sso).getBody();
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(bodyResponse);
            Map<string,object> entityInfo = (map<string,object>) results.get('entityInfo');
            Map<string,object> contactInfo = (map<string,object>) entityInfo.get('contactInfo');
            if(contactInfo.get('contacts') != null){
            	Map<string,object> contacts = (map<string,object>) contactInfo.get('contacts');    
                system.debug('hay datos');
                list<Object> listObjContact = (list<Object>) contacts.get('contact');
                for(Object contact : listObjContact){
                    map<String,Object> contactDetail = (map<String,Object>) contact;
                    LMM_Custom_Contact__c customContact = new LMM_Custom_Contact__c();
                    customContact.LMM_tx_Oracle_Id__c = String.valueOf((Integer) contactDetail.get('contactId'));
                    customContact.LMM_tx_Primer_nombre__c = (string) contactDetail.get('firstName'); 
                    customContact.LMM_tx_Segundo_nombre__c = (string) contactDetail.get('middleName'); 
                    customContact.LMM_tx_Apellido_paterno__c = (string) contactDetail.get('firstLastName');
                    customContact.LMM_tx_Apellido_materno__c = (string) contactDetail.get('secondLastName');
                    customContact.LMM_ce_Correo_electronico__c = (string) contactDetail.get('email');
                    customContact.LMM_rb_Entity_CP__c = Entity_CP.id;
                    system.debug('customContact ' + customContact);
                    listLMM_Custom_Contact.add(customContact);
                }
            }
            
            system.debug('contactInfo ' + contactInfo);
            
        }
        Schema.SObjectField LMM_tx_Oracle_Id = LMM_Custom_Contact__c.Fields.LMM_tx_Oracle_Id__c;
		List<Database.UpsertResult> resulOperation = Database.upsert( listLMM_Custom_Contact, LMM_tx_Oracle_Id, false );
        for(Database.UpsertResult result : resulOperation){
            if (result.isSuccess()) {
                // Operation was successful, so get the ID of the record that was processed
                System.debug('Success inserted  ID: ' + result.getId());
            }else {
                // Operation failed, so get all errors                
                for(Database.Error err : result.getErrors()) {
                    System.debug('The following error has occurred.');                    
                    System.debug(err.getStatusCode() + ': ' + err.getMessage());
                    System.debug('fields that affected this error: ' + err.getFields());
                }
            }
        }
        
    }   

    global void finish(Database.BatchableContext BC){    
    }

}