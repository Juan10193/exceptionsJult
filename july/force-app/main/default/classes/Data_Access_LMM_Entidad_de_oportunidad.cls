/**
 * @File Name          : Data_Access_LMM_Entidad_de_oportunidad.cls
 * @Description        : 
 * @Author             : eduardo.amiens@outlook.com
 * @Group              : 
 * @Last Modified By   : eduardo.amiens@outlook.com
 * @Last Modified On   : 14/5/2020 15:37:03
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    14/4/2020   eduardo.amiens@outlook.com     Initial Version
**/
public with sharing class Data_Access_LMM_Entidad_de_oportunidad {
    
    /**
    * @description 
    * @author eduardo.amiens@outlook.com | 14/4/2020 
    * @param idOportunidad s
    * @return list<LMM_Entidad_de_oportunidad__c> 
    **/
    public static list<LMM_Entidad_de_oportunidad__c> getEntidadesDeOportunindadByOpp(id idOportunidad){
        list<LMM_Entidad_de_oportunidad__c> listLMM_Entidad_de_oportunidad = new list<LMM_Entidad_de_oportunidad__c>();
        listLMM_Entidad_de_oportunidad = [SELECT Id, IsDeleted, Name, CreatedDate, CreatedById, LastModifiedDate, 
                                            LastModifiedById, SystemModstamp, LMM_tx_Entity_Name__c, LastActivityDate, LMM_pd_Oportunidad__c, 
                                            LMM_pd_Entity_CP__c, LMM_lm_Rol__c, LMM_ls_Hits__c, LMM_ls_Bil_Incidencias__c, 
                                            LMM_pd_Entity_CP__r.CPI_tx_RFC_TIN__c, LMM_pd_Entity_CP__r.name, 
                                            LMM_tl_Hits_Description__c, LMM_pd_Entity_CP__r.EIV_tx_partyID__c, LMM_pd_Entity_CP__r.EM_Party_ID__c
                                            FROM LMM_Entidad_de_oportunidad__c where LMM_pd_Oportunidad__c = :idOportunidad];
        return listLMM_Entidad_de_oportunidad;
    }
}