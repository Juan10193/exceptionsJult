/**
 * @description       : 
 * @author            : eduardo.amiens@outlook.com
 * @group             : 
 * @last modified on  : 07-31-2020
 * @last modified by  : eduardo.amiens@outlook.com
 * Modifications Log 
 * Ver   Date         Author                       Modification
 * 1.0   07-29-2020   eduardo.amiens@outlook.com   Initial Version
**/
public with sharing class lmmKYCPMoralController {
    public lmmKYCPMoralController() {

    }
    @AuraEnabled(cacheable=true)
    public static LMM_KYC__c getKYCRecord(id recordId){
        return [SELECT Id, Name, 
        (SELECT Id, OwnerId, IsDeleted, Name, CurrencyIsoCode, RecordTypeId, CreatedDate, CreatedById, LastModifiedDate, 
        LastModifiedById, SystemModstamp, LMM_tx_Nacionalidad__c, LMM_tx_RFC__c, LMM_pr_Porcentaje_de_participacion__c, 
        LMM_rb_KYC_Composicion_social__c, LMM_rb_KYC_Administracion__c, LMM_rb_KYC_Principales_Funcionarios__c 
        FROM Administracion__r), 
        (SELECT Id, OwnerId, IsDeleted, Name, CurrencyIsoCode, RecordTypeId, CreatedDate, CreatedById, LastModifiedDate, 
        LastModifiedById, SystemModstamp, LMM_tx_Nacionalidad__c, LMM_tx_RFC__c, LMM_pr_Porcentaje_de_participacion__c, 
        LMM_rb_KYC_Composicion_social__c, LMM_rb_KYC_Administracion__c, LMM_rb_KYC_Principales_Funcionarios__c
         FROM ComposicionesSocial__r), 
        (SELECT Id, OwnerId, IsDeleted, Name, CurrencyIsoCode, RecordTypeId, CreatedDate, CreatedById, LastModifiedDate,
         LastModifiedById, SystemModstamp, LMM_tx_Nacionalidad__c, LMM_tx_RFC__c, LMM_pr_Porcentaje_de_participacion__c,
          LMM_rb_KYC_Composicion_social__c, LMM_rb_KYC_Administracion__c, LMM_rb_KYC_Principales_Funcionarios__c 
          FROM PrincipalesFuncionarios__r) FROM LMM_KYC__c where id = :recordId];
    }
    @AuraEnabled(cacheable=false)
    public static void upsertLMM_Persona(list<LMM_Persona__c> listPersona){
        system.debug('listPersona ' + listPersona);
        upsert listPersona;        
    }
}