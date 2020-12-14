/**
 * @description       : 
 * @author            : eduardo.amiens@outlook.com
 * @group             : 
 * @last modified on  : 10-21-2020
 * @last modified by  : eduardo.amiens@outlook.com
 * Modifications Log 
 * Ver   Date         Author                       Modification
 * 1.0   09-24-2020   eduardo.amiens@outlook.com   Initial Version
**/
public with sharing class WOA_Create_Custom_AP {
    private Map<Id, Opportunity> newMapOpportunity;

    public WOA_Create_Custom_AP(Map<Id, Opportunity> newMapOpportunity) {
        Id recordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Workout Alivio').getRecordTypeId();
        system.debug('inicia LMM_Opportunity_CB_AP');
        this.newMapOpportunity = new Map<Id, Opportunity>();
        for(Opportunity opp : newMapOpportunity.values()){
            system.debug('opp init ' + opp);
            if(opp.RecordTypeId.equals(recordTypeId)){
                this.newMapOpportunity.put(opp.Id, opp);
            }
        }
        
    }

    public void createRecords(){
            if(!this.newMapOpportunity.isEmpty()){
            list<WKA_Custom_Approval_Process__c> listWKA_Custom_Approval_Process = new list<WKA_Custom_Approval_Process__c>();
            for(id oppId : newMapOpportunity.keySet()){
                listWKA_Custom_Approval_Process.add(generateRecordRisk('Riesgo', oppId));
                listWKA_Custom_Approval_Process.add(generateRecordRisk('AML', oppId));
                listWKA_Custom_Approval_Process.add(generateRecordRisk('Tesoreria', oppId));
                listWKA_Custom_Approval_Process.add(generateRecordRisk('Pricing', oppId));
            }
            insert listWKA_Custom_Approval_Process;
            system.debug('newMapOpportunity ' + newMapOpportunity);
            list<Opportunity> listOpp = new list<Opportunity>();
            for(Opportunity opp : [SELECT Id, Name, WKA_rb_AP_Riesgo__c,
                                    WKA_rb_AP_AML__c, WKA_rb_AP_Tesoreria__c 
                                    FROM Opportunity 
                                    where Id IN : this.newMapOpportunity.keySet()]){
                for(WKA_Custom_Approval_Process__c WKA_Custom_Approval_Process : listWKA_Custom_Approval_Process){
                    if(WKA_Custom_Approval_Process.WOA_rb_Opportunity__c.equals(opp.Id))
                        switch on WKA_Custom_Approval_Process.WKA_ls_Proceso_de_aprobacion__c {
                            when 'Riesgo' {		// when block 1
                                opp.WKA_rb_AP_Riesgo__c = WKA_Custom_Approval_Process.Id;
                            }	
                            when 'AML' {		// when block 2
                                opp.WKA_rb_AP_AML__c = WKA_Custom_Approval_Process.Id;
                            }
                            when 'Tesoreria' {		// when block 3
                                opp.WKA_rb_AP_Tesoreria__c = WKA_Custom_Approval_Process.Id;
                            }
                            when 'Pricing' {
                                opp.WKA_rb_AP_Pricing__c = WKA_Custom_Approval_Process.Id;
                            }
                            when else {		  // default block, optional
                                // code block 4
                            }
                        }                
                }
                listOpp.add(opp);
            }
            system.debug('newUpdateMapOpportunity update ' + listOpp);
            update listOpp;
            system.debug('newUpdateMapOpportunity final ' + listOpp);
            }
    }

    public WKA_Custom_Approval_Process__c generateRecordRisk(string procesoDeAprobacion, Id oppId){
        Id recordTypeId = Schema.SObjectType.WKA_Custom_Approval_Process__c.getRecordTypeInfosByName().get('Opportunity WOA').getRecordTypeId();
        WKA_Custom_Approval_Process__c wKA_Custom_Approval_Process = new WKA_Custom_Approval_Process__c();
        wKA_Custom_Approval_Process.WKA_Stage__c = 'Nuevo';
        wKA_Custom_Approval_Process.WKA_ls_Proceso_de_aprobacion__c = procesoDeAprobacion;
        wKA_Custom_Approval_Process.WOA_rb_Opportunity__c = oppId;
        wKA_Custom_Approval_Process.RecordTypeId = recordTypeId;
        return wKA_Custom_Approval_Process;
    }
}