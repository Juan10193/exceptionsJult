/**
 * @description       : 
 * @author            : eduardo.amiens@outlook.com
 * @group             : 
 * @last modified on  : 07-20-2020
 * @last modified by  : eduardo.amiens@outlook.com
 * Modifications Log 
 * Ver   Date         Author                       Modification
 * 1.0   07-20-2020   eduardo.amiens@outlook.com   Initial Version
**/
public with sharing class ValidateTDSeguroFinanciado {
    public ValidateTDSeguroFinanciado() {

    }
    public static void addErrors(Map<Id, Takedowns_Contingency_plan__c> tkdwnsSelectedToValidation){
        Id recordTypeId = Schema.SObjectType.Insurance_VoBo__c.getRecordTypeInfosByName().get('Engenium Capital').getRecordTypeId();
        for(Insurance_VoBo__c Insurance_VoBo : [SELECT Id, Name, RecordTypeId, Takedown_CP__c, 
                                                (SELECT id, name, Insurance_Policy_Number__c 
                                                 FROM Insurance_Policies__r) 
                                                FROM Insurance_VoBo__c 
                                                where Takedown_CP__c in :tkdwnsSelectedToValidation.keySet()
                                               and RecordTypeId = :recordTypeId]){
                                                   for(Insurance_Policy__c Insurance_Policy : Insurance_VoBo.Insurance_Policies__r){
                                                       if(string.isEmpty(Insurance_Policy.Insurance_Policy_Number__c)){
                                                        tkdwnsSelectedToValidation.get(Insurance_VoBo.Takedown_CP__c).addError('No puede avanzar a Registry si no cuenta con la Póliza cargada en Insurance To Go');
                                                           
                                                       }
                                                   }
            
        }
    }
}