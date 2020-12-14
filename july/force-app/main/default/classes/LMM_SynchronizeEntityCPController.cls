/**
 * @File Name          : LMM_SynchronizeEntityCPController.cls
 * @Description        : 
 * @Author             : eduardo.amiens@outlook.com
 * @Group              : 
 * @Last Modified By   : eduardo.amiens@outlook.com
 * @Last Modified On   : 16/6/2020 22:29:38
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    12/6/2020   eduardo.amiens@outlook.com     Initial Version
**/
public with sharing class LMM_SynchronizeEntityCPController {
    public class applicationException extends Exception {}
    
    public static final string Aplication_Objetive = 'LMM_SynchronizeEntityCPController';
    
    @AuraEnabled 
    public static void updateEntityCP(string enitytCPId) {
        system.debug('Update entity cp ' + enitytCPId);
        Entity_CP__c Entity_CP = [SELECT Id, Name, EM_Party_ID__c, EM_Economic_Group_ID__c, EM_Top_Parent_ID__c, CPI_tx_RFC_TIN__c
        FROM Entity_CP__c where Id = :enitytCPId];
        HttpResponse response = EIV_EntityCallout.getEntityByRFCOrName(Entity_CP.CPI_tx_RFC_TIN__c);
        if(response.getStatusCode() == 200){        	
            string bodyResponse = response.getBody();
            system.debug('bodyResponse ' + bodyResponse);
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(bodyResponse);
            system.debug('results ' + results);
            Map<string,object> entityInfo = (map<string,object>) results.get('entityInfo');
            Map<string,object> entities = (map<string,object>) entityInfo.get('entities');
            if(entities != null){
                list<object> listEntity = (list<object>) entities.get('entity');
                string partyID;
                string economicGroupID;
                string topParentID;
        
                for(object objectEntity : listEntity){
                    Map<string,object> entity = (Map<String, object>)objectEntity;
                    system.debug('entity ' + entity);
                    system.debug('partyID ' + entity.get('partyID'));
                    partyID = string.valueOf(entity.get('partyID'));
                    economicGroupID = string.valueOf(entity.get('economicGroupId'));
                    topParentID = string.valueOf(entity.get('topParentId'));            
                }
                Entity_CP.EM_Party_ID__c = partyID;
                Entity_CP.EM_Economic_Group_ID__c = economicGroupID;
                Entity_CP.EM_Top_Parent_ID__c = topParentID;
                update Entity_CP;
        
                system.debug('entities ' + entities);

            }   else {
                throw new applicationException('No se ha encontrado entidad');
            }         
        } else {             
             LMM_CustomLog__c logError = new LMM_CustomLog__c(Lmm_tx_RecordId__c = enitytCPId, 
                                                              Lmm_tl_Trace__c = response.getBody(),
                                                              LMM_tx_Aplication_Objetive__c = LMM_SynchronizeEntityCPController.Aplication_Objetive);
            insert logError;
             throw new applicationException('Ha ocurrido un error en la sincronización, trace: ' + response.getBody());
        }
        
   }
}