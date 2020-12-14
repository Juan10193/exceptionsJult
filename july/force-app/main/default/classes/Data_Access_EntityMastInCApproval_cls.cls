/**
 * @File Name          : Data_Access_TablaExposureEntitysInCa_cls.cls
 * @Description        : 
 * @Author             : juandedios.hernandez@engeniumcapital.com
 * @Group              : 
 * @Last Modified By   : juandedios.hernandez@engeniumcapital.com
 * @Last Modified On   : 3/9/2019 9:27:58
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    3/9/2019   juandedios.hernandez@engeniumcapital.com     Initial Version
**/
public without sharing class Data_Access_EntityMastInCApproval_cls {
   
    /**
    * @description Utilizado en takedown convert para Obtener los Entities in ca de la Opp Seleccionada
    * @author juandedios.hernandez@engeniumcapital.com | 23/9/2019 
    * @return List<ES2_Obj_EntityMasterInCreditApproval__c> 
    **/
    @AuraEnabled(cacheable=false)
    public static List<ES2_Obj_EntityMasterInCreditApproval__c> entitiesInCaOp(string opportunityId){
        if(Schema.sObjectType.ES2_Obj_EntityMasterInCreditApproval__c.isAccessible()){
            return [SELECT Id, IsDeleted, Name, CurrencyIsoCode, CreatedDate,TKD_txt_RFC__c, CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, LastActivityDate, 
                    ES2_rb_Credit_approval__c, ES2_fm_Desicion_Entity__c, ES2_fm_Entity__c, ES2_fm_Garantor__c, ES2_fm_Obligor__c, ES2_ms_Role__c, 
                    ES2_tx_CostumerType__c, ES2_tx_Oracle_Account_Name__c, ES2_tx_Party_Id__c, ES2_tx_TopParentID__c, ES2_tx_TopParetName__c, ES2_tx_pageVF__c, 
                    ES2_url_Entity_Master__c, ES3_rb_Opportunity__c, ES3_rb_Opportunity_in_Credit_approval_CP__c, ES3_tx_BloombergID__c, ES3_tx_Entity_Name__c, 
                    ES3_tx_HNWI_ID__c, ES3_tx_MRAID__c, ES3_tx_Or_Rating__c, ES3_tx_Risk_Classification__c, ES3_tx_Transaction_Date__c, ES3_txt_CRR_Override__c, 
                    ES3_txt_CRR__c, ES3_txt_SIC_Code__c, ES3_txt_SIC_Description__c, ES2_Resolve_Comment__c, ES2_Unresolved_Items__c, ES2_chk_Adverse_Media__c, 
                    ES2_txt_Hit_Description__c, Status_Color__c FROM ES2_Obj_EntityMasterInCreditApproval__c  where ES3_rb_Opportunity__c =:opportunityId ];
        }else{
            system.debug(LoggingLevel.ERROR, 'Error: Insufficient Access');
        }
        return null;
    }

    @AuraEnabled
    public static List<ES2_Obj_EntityMasterInCreditApproval__c> getEntitiesMasterByCAId(string cAId){
        if(Schema.sObjectType.ES2_Obj_EntityMasterInCreditApproval__c.isAccessible()){
            return [Select IsDeleted, Name, CurrencyIsoCode, CreatedDate,TKD_txt_RFC__c, CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, LastActivityDate, 
                    ES2_rb_Credit_approval__c,ES2_rb_Credit_approval__r.Name, ES2_fm_Desicion_Entity__c, ES2_fm_Entity__c, ES2_fm_Garantor__c, ES2_fm_Obligor__c, ES2_ms_Role__c, 
                    ES2_tx_CostumerType__c, ES2_tx_Oracle_Account_Name__c, ES2_tx_Party_Id__c, ES2_tx_TopParentID__c, ES2_tx_TopParetName__c, ES2_tx_pageVF__c, 
                    ES2_url_Entity_Master__c, ES3_rb_Opportunity__c, ES3_rb_Opportunity_in_Credit_approval_CP__c, ES3_tx_BloombergID__c, ES3_tx_Entity_Name__c, 
                    ES3_tx_HNWI_ID__c, ES3_tx_MRAID__c, ES3_tx_Or_Rating__c, ES3_tx_Risk_Classification__c, ES3_tx_Transaction_Date__c, ES3_txt_CRR_Override__c, 
                    ES3_txt_CRR__c, ES3_txt_SIC_Code__c, ES3_txt_SIC_Description__c, ES2_Resolve_Comment__c, ES2_Unresolved_Items__c, ES2_chk_Adverse_Media__c, 
                    ES2_txt_Hit_Description__c, Status_Color__c
                    FROM ES2_Obj_EntityMasterInCreditApproval__c where ES2_rb_Credit_approval__c =:cAId];
        }else{
            system.debug(LoggingLevel.ERROR, 'Error: Insufficient Access to the object ES2_Obj_EntityMasterInCreditApproval__c');
            return null;
        }
    }

    public static List<ES2_Obj_EntityMasterInCreditApproval__c> getEntitiesInCa(string caId){
        if (!Schema.sObjectType.ES2_Obj_EntityMasterInCreditApproval__c.isAccessible()){
        system.debug(LoggingLevel.ERROR, 'Error: Insufficient Access');
        return null;
        }

        return [Select id, ES3_rb_Opportunity_in_Credit_approval_CP__c, ES3_rb_Opportunity__c, ES2_tx_CostumerType__c,ES2_fm_Entity__c, 
                ES2_url_Entity_Master__c,ES2_tx_Oracle_Account_Name__c, ES2_tx_Party_Id__c, ES2_ms_Role__c,
                ES3_txt_SIC_Code__c, ES3_txt_SIC_Description__c,ES3_txt_CRR__c,ES3_txt_CRR_Override__c,
                ES3_tx_BloombergID__c,ES3_tx_HNWI_ID__c,ES3_tx_MRAID__c,ES3_tx_Or_Rating__c,ES3_tx_Transaction_Date__c
                from ES2_Obj_EntityMasterInCreditApproval__c where ES2_rb_Credit_approval__c =:caId];
    }

}