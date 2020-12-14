/**
 * @File Name          : Data_Access_Entities_Oportunidad.cls
 * @Description        : 
 * @Author             : angel87ambher@gmail.com
 * @Group              : 
 * @Last Modified By   : angel87ambher@gmail.com
 * @Last Modified On   : 1/5/2020 0:07:44
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    1/5/2020   angel87ambher@gmail.com     Initial Version
**/
public with sharing class Data_Access_Entities_Oportunidad {
  
    @AuraEnabled(cacheable=false)
    public static List<LMM_Entidad_de_oportunidad__c> entitiesInOp(string opportunityId){
        if(Schema.sObjectType.LMM_Entidad_de_oportunidad__c.isAccessible()){
            return [SELECT Id,LMM_tl_Bil_Comentarios__c,CreatedById,CurrencyIsoCode,LMM_pd_Entity_CP__c,
            LMM_tx_Entity_Name__c,LMM_ls_Entity_Type__c,LMM_fh_Bil_Fecha_Revision__c,Name,LMM_ls_Hits__c,
            LMM_tl_Hits_Description__c,LMM_ls_Bil_Incidencias__c,LastModifiedById,LMM_pd_Oportunidad__c,
            LMM_tx_RequestId__c,LMM_tx_RFC__c,LMM_lm_Rol__c FROM LMM_Entidad_de_oportunidad__c  where LMM_pd_Oportunidad__c =:opportunityId ];
        }else{
            system.debug(LoggingLevel.ERROR, 'Error: Insufficient Access');
        }
        return null;
    }
}