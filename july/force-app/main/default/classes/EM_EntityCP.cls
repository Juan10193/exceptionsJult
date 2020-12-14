public class EM_EntityCP {
    
	
    public void entityCPFromEntityMaster(string rfc, string tin, string partyId, string sso, boolean isUpdatingVA){
        string rfcOrTIN = string.isEmpty(tin)?rfc:tin;
       
        list<Entity_CP__c> entitycpByPartyId = Data_Access_EntityCP.getEntityCPbyPartyId(partyId);
        list<Entity_CP__c> entitycpByRFCorTIN = Data_Access_EntityCP.getEntityCPbyRFCTIN(rfcOrTIN);
        
        if(entitycpByPartyId.isEmpty() && entitycpByRFCorTIN.isEmpty()){
            createNewEntityCP(sso, partyId, 'SF');
        }else if(entitycpByPartyId.isEmpty() && !entitycpByRFCorTIN.isEmpty()){
            string entityCPId = entitycpByRFCorTIN[0].Id;
            updateExistEntityCP(sso, partyId, 'SF', entityCPId, isUpdatingVA);
        }else if(!entitycpByPartyId.isEmpty()){
            string entityCPId = entitycpByPartyId[0].Id;
            updateExistEntityCP(sso, partyId, 'SF', entityCPId, isUpdatingVA);
        }
    }
    
    
    
    @future(callout=true)
    private static void createNewEntityCP(String sso, String partyId, String app){
        string jsonEntity = EM_WS_EntityMaster.getEntityDetail(partyId, sso, app);
     
        EM_Wrapper_Entity.EntityMain entityWrapper = (EM_Wrapper_Entity.EntityMain)JSON.deserialize(jsonEntity.replaceAll('_7|_3', 'r'),EM_Wrapper_Entity.EntityMain.class);
        DMLO_EntityCP.createEntitycpFromEntityM(entityWrapper);
    }
    
    @future(callout=true)
    private static void updateExistEntityCP(String sso, String partyId, String app, string entityCPId, boolean isUpdatingVA){
        string jsonEntity = EM_WS_EntityMaster.getEntityDetail(partyId, sso, app);
        EM_Wrapper_Entity.EntityMain entityWrapper = (EM_Wrapper_Entity.EntityMain)JSON.deserialize(jsonEntity.replaceAll('_7|_3', 'r'),EM_Wrapper_Entity.EntityMain.class);
        system.debug('entityWrapper ' + entityWrapper);
        Entity_CP__c entityCP = Data_Access_EntityCP.getEntityCPbyRecordId(entityCPId)[0];
        DMLO_EntityCP.upsertEntitycpFromEntityM(entityWrapper, entityCP, isUpdatingVA);
    }   
    
}