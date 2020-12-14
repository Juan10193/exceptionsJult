/**
 * @File Name          : Data_Access_ConditionServiceCoventant.cls
 * @Description        : 
 * @Author             : angel87ambher@gmail.com
 * @Group              : 
 * @Last Modified By   : angel87ambher@gmail.com
 * @Last Modified On   : 12/6/2020 0:23:30
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    12/6/2020   angel87ambher@gmail.com     Initial Version
**/
public with sharing class Data_Access_ConditionServiceCoventant {
    
    @AuraEnabled
    public static list<ES3_obj_Condition_Service_covenant__c> getCSC(string opportunityId){
        list<ES3_obj_Condition_Service_covenant__c> scc = [Select Id, OwnerId, IsDeleted, Name, CurrencyIsoCode, RecordTypeId, RecordType.Name, CreatedDate, CreatedById, ES3_rb_Opportunity_in_Credit_approval_CP__c, 
                   ES3_rb_Credit_approval_CP__c, ES3_rb_Oportunidad__c, ES3_lst_Services__c, ES3_lst_Condition__c, ES3_lst_Covenant_Cuantitativo__c, 
                   ES3_txt_Service_Comments__c, ES3_TXT_Description__c, ES3_TXT_Threshold__c, ES3_lt_Status__c, ES3_LT_Min_Max__c, ES3_TX_Other__c, ES3_LST_Review__c, 
                   ES3_LST_Applies_To__c, ES3_LST_Covenant_Cualitativo__c, ES3_lt_Timing__c, ES3_DATE_Date__c, ES3_rb_Entity__c,
                   ES3_rb_Entity__r.Id, ES3_rb_Entity__r.IsDeleted, ES3_rb_Entity__r.Name, ES3_rb_Entity__r.CurrencyIsoCode, ES3_rb_Entity__r.CreatedDate, 
                   ES3_rb_Entity__r.CreatedById, ES3_rb_Entity__r.ES2_rb_Credit_approval__c, ES3_rb_Entity__r.ES2_fm_Desicion_Entity__c, ES3_rb_Entity__r.ES2_fm_Entity__c, 
                   ES3_rb_Entity__r.ES2_fm_Garantor__c, ES3_rb_Entity__r.ES2_fm_Obligor__c, ES3_rb_Entity__r.ES2_ms_Role__c, ES3_rb_Entity__r.ES2_tx_CostumerType__c, 
                   ES3_rb_Entity__r.ES2_tx_Oracle_Account_Name__c, ES3_rb_Entity__r.ES2_tx_Party_Id__c, ES3_rb_Entity__r.ES2_tx_TopParentID__c, 
                   ES3_rb_Entity__r.ES2_tx_TopParetName__c, ES3_rb_Entity__r.ES2_tx_pageVF__c, ES3_rb_Entity__r.ES2_url_Entity_Master__c, ES3_rb_Entity__r.ES3_rb_Opportunity__c, 
                   ES3_rb_Entity__r.ES3_rb_Opportunity_in_Credit_approval_CP__c, ES3_tx_Coments__c, ES3_LT_Timing_Cualitativo__c, ES3_LT_Timing_Cuantitativo__c
                   FROM ES3_obj_Condition_Service_covenant__c   
                   where ES3_rb_Oportunidad__c =: opportunityId];
        return scc;
    }
}