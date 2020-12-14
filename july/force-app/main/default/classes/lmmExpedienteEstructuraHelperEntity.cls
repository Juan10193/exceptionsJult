/**
 * @File Name          : lmmExpedienteEstructuraHelperEntity.cls
 * @Description        : 
 * @Author             : eduardo.amiens@outlook.com
 * @Group              : 
 * @Last Modified By   : eduardo.amiens@outlook.com
 * @Last Modified On   : 12-02-2020
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    16/4/2020   eduardo.amiens@outlook.com     Initial Version
**/
public with sharing class lmmExpedienteEstructuraHelperEntity {
    public map<string,lmmExpedienteEstructuraWrapper.EntityMasterResponse> mapEntityMasterResponse {get;set;}
    public id opportunityID {get;set;}

    public lmmExpedienteEstructuraHelperEntity(list<lmmExpedienteEstructuraWrapper.EntityMasterResponse> listEntityMasterResponse, id opportunityID) {
        this.mapEntityMasterResponse = new map<string,lmmExpedienteEstructuraWrapper.EntityMasterResponse>();
        for(lmmExpedienteEstructuraWrapper.EntityMasterResponse EntityMasterResponse : listEntityMasterResponse){
            this.mapEntityMasterResponse.put(EntityMasterResponse.rfc,EntityMasterResponse);
        }
        this.opportunityID = opportunityID;
    }
    
    public string makeEntidadOportunidadNuevoEntity(){
        list<lmmExpedienteEstructuraWrapper.EntityMasterResponse> listEntityMasterNuevoEntity = new list<lmmExpedienteEstructuraWrapper.EntityMasterResponse>();
        list<Entity_CP__c> listEntity = new list<Entity_CP__c>();
        set<id> setIdCreatedEntity = new set<id>();
        string errors;
        for(lmmExpedienteEstructuraWrapper.EntityMasterResponse EntityMasterResponse :mapEntityMasterResponse.values()){
            system.debug('Revisión de lmmExpedienteEstructuraWrapper ' + EntityMasterResponse);
            system.debug('Revisión de EntityMasterResponse.partyID ' + EntityMasterResponse.partyID);
            Entity_CP__c Entity_CP = new Entity_CP__c();
            Entity_CP.EM_Party_ID__c             = EntityMasterResponse.partyID;
            system.debug('Revisión de Entity_CP.EIV_tx_partyID__c ' + Entity_CP.EIV_tx_partyID__c);
            Entity_CP.EM_Economic_Group_ID__c       = EntityMasterResponse.economicGroupId;
            Entity_CP.EM_Top_Parent_ID__c           = EntityMasterResponse.topParentId; 
            Entity_CP.CPI_tx_RFC_TIN__c             = EntityMasterResponse.rfc;
            Entity_CP.name                          = EntityMasterResponse.entityName;
            Entity_CP.CPI_ls_TIPO_DE_CLIENTE__c     = EntityMasterResponse.customerType != null ? EntityMasterResponse.customerType.equals('INDIVIDUAL') ? 'PERSONA' : 'ORGANIZATION' : 'ORGANIZATION';
            Entity_CP.CPI_ls_SUPPLIER_FLAG__c       = EntityMasterResponse.supplierFlag != null ? EntityMasterResponse.supplierFlag.equals('false') ? 'No' : 'Yes' : 'No';
            Entity_CP.CPI_tx_OR_Rating__c           = EntityMasterResponse.orRating;
            system.debug('Revisión de Entity_CP ' + Entity_CP);
            listEntity.add(Entity_CP);
            
        }
        
        //upsert listEntity EIV_tx_partyID__c;
        Schema.SObjectField CPI_tx_RFC_TIN = Entity_CP__c.Fields.CPI_tx_RFC_TIN__c;
        List<Database.UpsertResult> resulOperation = Database.upsert(listEntity, CPI_tx_RFC_TIN, false );
        for(Database.UpsertResult result : resulOperation){
            if (result.isSuccess()) {
                // Operation was successful, so get the ID of the record that was processed
                System.debug('Success inserted Entity ID: ' + result.getId());
                setIdCreatedEntity.add(result.getId());
            }else {
                // Operation failed, so get all errors                
                for(Database.Error err : result.getErrors()) {
                    System.debug('The following error has occurred.');  
                    errors = err.getStatusCode() + ': ' + err.getMessage() + '\n';                   
                    System.debug(err.getStatusCode() + ': ' + err.getMessage());
                }
            }    
        }
        makeEntidadOportunidadEntExistente(setIdCreatedEntity);
        return errors;
    }
    
    public void makeEntidadOportunidadEntExistente(set<id> setIdCreatedEntity){
        list<LMM_Entidad_de_oportunidad__c> listLMM_Entidad_de_oportunidad = new list<LMM_Entidad_de_oportunidad__c>();
        for(Entity_CP__c Entity_CP : [SELECT id, name, CPI_tx_RFC_TIN__c, CPI_ls_TIPO_DE_CLIENTE__c FROM Entity_CP__c where id = :setIdCreatedEntity ]){
            LMM_Entidad_de_oportunidad__c LMM_Entidad_de_oportunidad = new LMM_Entidad_de_oportunidad__c();
            LMM_Entidad_de_oportunidad.LMM_pd_Oportunidad__c    = this.opportunityID;
            LMM_Entidad_de_oportunidad.LMM_tx_RFC__c            = Entity_CP.CPI_tx_RFC_TIN__c;
            LMM_Entidad_de_oportunidad.LMM_ls_Entity_Type__c    = Entity_CP.CPI_ls_TIPO_DE_CLIENTE__c != null ? Entity_CP.CPI_ls_TIPO_DE_CLIENTE__c.equals('PERSONA') ? 'INDIVIDUAL' : 'ORGANIZATION' : 'ORGANIZATION';
            LMM_Entidad_de_oportunidad.LMM_pd_Entity_CP__c      = Entity_CP.id;
            LMM_Entidad_de_oportunidad.LMM_tx_Entity_Name__c    = Entity_CP.Name;
            listLMM_Entidad_de_oportunidad.add(LMM_Entidad_de_oportunidad);
        }
        insert listLMM_Entidad_de_oportunidad;
    }

    
}