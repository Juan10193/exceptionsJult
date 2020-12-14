@isTest
public class lmmExpedienteEstructuraController_test {
    
    @isTest 
    static void getEntidadesDeOportunidad(){
        Id opportunityRecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('LMM').getRecordTypeId();
        Date closeDate = date.newInstance(2020, 04, 08);
        
        Opportunity opp = new Opportunity(Name = 'Venta de elotes', Amount = 500000, CloseDate = closeDate, StageName = 'Nuevo', RecordTypeId = opportunityRecordTypeId);
        insert opp;
        
        Entity_CP__c enttityCP = new Entity_CP__c();
        enttityCP.Name = 'Colegios Militares';
        enttityCP.CPI_tx_RFC_TIN__c = 'GIFH890612HDGLTD04';
        insert enttityCP;
        
        LMM_Entidad_de_oportunidad__c LMM_Entidad_de_oportunidad = new LMM_Entidad_de_oportunidad__c(LMM_pd_Oportunidad__c = opp.id,
                                                                                                     LMM_pd_Entity_CP__c = enttityCP.id);
        insert LMM_Entidad_de_oportunidad;
        lmmExpedienteEstructuraController.getEntidadesDeOportunidad(LMM_Entidad_de_oportunidad.LMM_pd_Oportunidad__c);
    }
    
    @isTest 
    static void AsignEntities(){
        Id opportunityRecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('LMM').getRecordTypeId();
        Date closeDate = date.newInstance(2020, 04, 08);
        
        Opportunity opp = new Opportunity(Name = 'Venta de elotes', CloseDate = closeDate, Amount = 500000, StageName = 'Nuevo', RecordTypeId = opportunityRecordTypeId);
        insert opp;
        
        Entity_CP__c enttityCP = new Entity_CP__c();
        enttityCP.Name = 'Colegios Militares';
        enttityCP.CPI_tx_RFC_TIN__c = 'GIFH890612HDGLTD04';
        enttityCP.EIV_tx_partyID__c  = 'dsdf';
        insert enttityCP;
        
        LMM_Entidad_de_oportunidad__c LMM_Entidad_de_oportunidad = new LMM_Entidad_de_oportunidad__c(LMM_pd_Oportunidad__c = opp.id,
                                                                                                     LMM_pd_Entity_CP__c = enttityCP.id);
        insert LMM_Entidad_de_oportunidad;
        
        list<lmmExpedienteEstructuraWrapper.EntityMasterResponse> listEntityMasterResponse = new list<lmmExpedienteEstructuraWrapper.EntityMasterResponse>();
        lmmExpedienteEstructuraWrapper.EntityMasterResponse EntityMasterResponse = new lmmExpedienteEstructuraWrapper.EntityMasterResponse();
        EntityMasterResponse.partyID = '21694';
        EntityMasterResponse.economicGroupId = '100418';
        EntityMasterResponse.topParentId = '001R000001YspD9I';
        EntityMasterResponse.rfc = 'GIFH890612HDGLTD0';
        EntityMasterResponse.entityName = 'Comida para perros';
        EntityMasterResponse.taxRegime = 'PERSONA MORAL';
        EntityMasterResponse.customerType = 'ORGANIZATION';
        EntityMasterResponse.oracleAccountNumber = '000003212';
        EntityMasterResponse.supplierFlag = 'false';
        listEntityMasterResponse.add(EntityMasterResponse);

        
        lmmExpedienteEstructuraController.AsignEntities(listEntityMasterResponse,opp.id);
    }
    
    @isTest 
    static void validateHits(){
        Id opportunityRecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('LMM').getRecordTypeId();
        Date closeDate = date.newInstance(2020, 04, 08);
        
        Opportunity opp = new Opportunity(Name = 'Venta de elotes', Amount = 500000, CloseDate = closeDate, StageName = 'Nuevo', RecordTypeId = opportunityRecordTypeId);
        insert opp;
        
        Entity_CP__c enttityCP = new Entity_CP__c();
        enttityCP.Name = 'Colegios Militares';
        enttityCP.CPI_tx_RFC_TIN__c = 'GIFH890612HDGLTD04';
        insert enttityCP;
        
        LMM_Entidad_de_oportunidad__c LMM_Entidad_de_oportunidad = new LMM_Entidad_de_oportunidad__c(LMM_pd_Oportunidad__c = opp.id,
                                                                                                     LMM_pd_Entity_CP__c = enttityCP.id);
        insert LMM_Entidad_de_oportunidad;

        lmmExpedienteEstructuraWrapper.EntidadDeOportunidadHits EntidadDeOportunidadHits = new lmmExpedienteEstructuraWrapper.EntidadDeOportunidadHits();
        EntidadDeOportunidadHits.entidadDeOportunidadID = LMM_Entidad_de_oportunidad.id;
        EntidadDeOportunidadHits.request = '{parametros: {parametro: {'
                                    + 'rfc: par.LMM_pd_Entity_CP__r.CPI_tx_RFC_TIN__c,'
                                    + 'name: par.LMM_pd_Entity_CP__r.Name}}}';
        lmmExpedienteEstructuraController.validateHits(EntidadDeOportunidadHits);
    }
    
    @isTest 
    static void entityHitsOnProgress(){
        Id opportunityRecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('LMM').getRecordTypeId();
        Date closeDate = date.newInstance(2020, 04, 08);
        
        Opportunity opp = new Opportunity(Name = 'Venta de elotes', Amount = 500000, CloseDate = closeDate, StageName = 'Nuevo', RecordTypeId = opportunityRecordTypeId);
        insert opp;
        
        Entity_CP__c enttityCP = new Entity_CP__c();
        enttityCP.Name = 'Colegios Militares';
        enttityCP.CPI_tx_RFC_TIN__c = 'GIFH890612HDGLTD04';
        insert enttityCP;
        
        LMM_Entidad_de_oportunidad__c LMM_Entidad_de_oportunidad = new LMM_Entidad_de_oportunidad__c(LMM_pd_Oportunidad__c = opp.id,
                                                                                                     LMM_pd_Entity_CP__c = enttityCP.id);
        insert LMM_Entidad_de_oportunidad;
        list<string> listEntidad_de_oportunidad = new list<string>();
        listEntidad_de_oportunidad.add(LMM_Entidad_de_oportunidad.id);
        lmmExpedienteEstructuraController.entityHitsOnProgress(listEntidad_de_oportunidad);
    }
    
    @isTest 
    static void searchEntitiesInOracle(){
        Test.setMock(HttpCalloutMock.class, new EIV_EntityCalloutMock());
        lmmExpedienteEstructuraController.searchEntitiesInOracle('idAccount345tgfresdfhhj');
        EIV_EntityCallout.getNamedCredential();
    }
    
    @isTest 
    static void getEntitiesByEconomicGroup(){
        Test.setMock(HttpCalloutMock.class, new EIV_EntityCalloutMock());
        lmmExpedienteEstructuraController.getEntitiesByEconomicGroup('idAccount345tgfresdfhhj');
    }
    
    @isTest 
    static void getRequestByPartyID(){
        Test.setMock(HttpCalloutMock.class, new EIV_EntityCalloutMock());
        lmmExpedienteEstructuraController.getRequestByPartyID('idAccount345tgfresdfhhj');
    }
    
    @isTest 
    static void getLMM_lm_RolPKValues(){
        lmmExpedienteEstructuraController.getLMM_lm_RolPKValues();
    }
    @isTest 
    static void getCreditBureauApprovalProcess(){
        Id opportunityRecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('LMM').getRecordTypeId();
        Date closeDate = date.newInstance(2020, 04, 08);
        
        Opportunity opp = new Opportunity(Name = 'Venta de elotes', Amount = 500000, CloseDate = closeDate, StageName = 'Nuevo', RecordTypeId = opportunityRecordTypeId);
        insert opp;
        
        lmmExpedienteEstructuraController.getCreditBureauApprovalProcess(opp.id);
    }
}