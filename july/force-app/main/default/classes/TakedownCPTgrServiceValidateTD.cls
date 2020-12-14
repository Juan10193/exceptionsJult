/**
 * @description       : 
 * @author            : eduardo.amiens@outlook.com
 * @group             : 
 * @last modified on  : 07-23-2020
 * @last modified by  : eduardo.amiens@outlook.com
 * Modifications Log 
 * Ver   Date         Author                       Modification
 * 1.0   07-20-2020   eduardo.amiens@outlook.com   Initial Version
**/
//ValidateTDCreditLine
//ValidateTDSeguroFinanciado
//ValidateTDSeguroNoFinanciado
public class TakedownCPTgrServiceValidateTD {
    private Map<Id, Takedowns_Contingency_plan__c> newMapTakedownCP;
    private Map<Id, Takedowns_Contingency_plan__c> oldMapTakedownCP;

    private map<id,list<Insurance_VoBo__c>> mapInsurance;
    private map<id,list<WaiverToGo__c>> mapExceptions;

    public TakedownCPTgrServiceValidateTD(Map<Id, Takedowns_Contingency_plan__c> newMapTakedownCP, Map<Id, Takedowns_Contingency_plan__c> oldMapTakedownCP){
        this.newMapTakedownCP = newMapTakedownCP;        
        this.oldMapTakedownCP = oldMapTakedownCP;
    }
    public void validtateRules(){
        User usuario = [SELECT Id, Name, ProfileId, Profile.Name FROM User where id =:UserInfo.getUserId()];
        
        if(!usuario.Profile.Name.equals('System Administrator')){
            Map<Id, Takedowns_Contingency_plan__c> tkdToValSeguroFinanciado = new Map<Id, Takedowns_Contingency_plan__c>();
            Map<Id, Takedowns_Contingency_plan__c> tkdToValSeguroNoFinanciado = new Map<Id, Takedowns_Contingency_plan__c>();
            for(Takedowns_Contingency_plan__c Takedowns_Contingency_plan : this.newMapTakedownCP.values()){            
                if(string.isNotEmpty(Takedowns_Contingency_plan.TKD_ls_takedown_stage__c) 
                   && Takedowns_Contingency_plan.TKD_ls_takedown_stage__c.equals('Tollgate 2')
                   && !this.oldMapTakedownCP.get(Takedowns_Contingency_plan.Id).TKD_ls_takedown_stage__c.equals('Tollgate 2')){
                    tkdToValSeguroNoFinanciado.put(Takedowns_Contingency_plan.id, Takedowns_Contingency_plan);
                }
                if(string.isNotEmpty(Takedowns_Contingency_plan.TKD_ls_takedown_stage__c) 
                   && Takedowns_Contingency_plan.TKD_ls_takedown_stage__c.equals('Funded')
                   && !this.oldMapTakedownCP.get(Takedowns_Contingency_plan.Id).TKD_ls_takedown_stage__c.equals('Funded')){
                    tkdToValSeguroFinanciado.put(Takedowns_Contingency_plan.id, Takedowns_Contingency_plan);
                }           
            }
            if(!tkdToValSeguroNoFinanciado.isEmpty()){
                tollgate2Validations(tkdToValSeguroNoFinanciado);    
            }
            if(!tkdToValSeguroFinanciado.isEmpty()){
                registryAddErrors(tkdToValSeguroFinanciado);    
            }
    	}
    }
    public void searchExceptions(Map<Id, Takedowns_Contingency_plan__c> mapTakedown){
        map<id,list<WaiverToGo__c>> mapExceptions = new map <id,list<WaiverToGo__c>>();
        for(WaiverToGo__c WaiverToGo : [SELECT Id, Name, Takedown_CP__c, Document_Type__c, Stage__c FROM WaiverToGo__c
        where Takedown_CP__c in :mapTakedown.keySet()]){
            if(mapExceptions.containsKey(WaiverToGo.Takedown_CP__c)){
                list<WaiverToGo__c> listWaiverToGo = mapExceptions.get(WaiverToGo.Takedown_CP__c);
                listWaiverToGo.add(WaiverToGo);
                mapExceptions.put(WaiverToGo.Takedown_CP__c,listWaiverToGo);
            } else {
                list<WaiverToGo__c> listWaiverToGo = new list<WaiverToGo__c>();
                listWaiverToGo.add(WaiverToGo);
                mapExceptions.put(WaiverToGo.Takedown_CP__c,listWaiverToGo);
            } 
        }
        this.mapExceptions = mapExceptions;
    }
    
    public void searchInsurance(Map<Id, Takedowns_Contingency_plan__c> mapTakedown){
        map<id,list<Insurance_VoBo__c>> mapInsurance = new map<id,list<Insurance_VoBo__c>>();  
        for(Insurance_VoBo__c Insurance_VoBo : [SELECT Id, Name, RecordTypeId, Takedown_CP__c, Stage__c, 
                                                (SELECT id, name, Insurance_Policy_Number__c 
                                                FROM Insurance_Policies__r) 
                                                FROM Insurance_VoBo__c 
                                                where Takedown_CP__c in :mapTakedown.keySet()]){
            if(mapInsurance.containsKey(Insurance_VoBo.Takedown_CP__c)){
                list<Insurance_VoBo__c> listInsurance = mapInsurance.get(Insurance_VoBo.Takedown_CP__c);
                listInsurance.add(Insurance_VoBo);
                mapInsurance.put(Insurance_VoBo.Takedown_CP__c,listInsurance);
            } else {
                list<Insurance_VoBo__c> listInsurance = new list<Insurance_VoBo__c>();
                listInsurance.add(Insurance_VoBo);
                mapInsurance.put(Insurance_VoBo.Takedown_CP__c,listInsurance);
            }         
        }  
        this.mapInsurance = mapInsurance;
    }
    public void tollgate2Validations(Map<Id, Takedowns_Contingency_plan__c> mapTakedown){
        searchExceptions(mapTakedown);
        searchInsurance(mapTakedown);
        Id rtIdExternalInsurance = Schema.SObjectType.Insurance_VoBo__c.getRecordTypeInfosByName().get('External Insurance').getRecordTypeId();
        Id rtIdinternalInsurance = Schema.SObjectType.Insurance_VoBo__c.getRecordTypeInfosByName().get('Engenium Capital').getRecordTypeId();
        for(Takedowns_Contingency_plan__c tkd : [SELECT Id, Name,CPL_ls_Deal_Category__c 
                                                 FROM Takedowns_Contingency_plan__c
                                                WHERE id in: mapTakedown.keySet()]){
            Boolean isError = true;
			if(!tkd.CPL_ls_Deal_Category__c.equals('Progress Payment')){                                                    
                if(!tkd.CPL_ls_Deal_Category__c.equals('Progress Payment')){
                    if(this.mapInsurance.containsKey(tkd.id)){
                        for(Insurance_VoBo__c Insurance_VoBo : this.mapInsurance.get(tkd.id)){
                            if(Insurance_VoBo.RecordTypeId.equals(rtIdExternalInsurance)
                            && Insurance_VoBo.Stage__c.equals('T2 VoBo Approved')){
                                isError = false;
                            } else if(Insurance_VoBo.RecordTypeId.equals(rtIdinternalInsurance)){
                                isError = false;
                            }
                        }
                    }
                    if(this.mapExceptions.containsKey(tkd.id)){
                        for(WaiverToGo__c WaiverToGo : this.mapExceptions.get(tkd.id)){
                            if((WaiverToGo.Stage__c.equals('Approved') 
                                || WaiverToGo.Stage__c.equals('Completed'))
                                    && (WaiverToGo.Document_Type__c.equals('Insurance')
                                    || WaiverToGo.Document_Type__c.equals('Insurance CRO'))){
                                isError = false;
                            }
                        }
                    }
                } else {
                    isError = false;
                }
            } else{
                isError = false;
            }
			if(isError){
                mapTakedown.get(tkd.id).addError('No puede avanzar a TG2 si no tiene una excepción de seguro no financiado o si no tiene un VoBo de seguros en Insurance To Go.');                  
            	
            }            
        }    
    }
    public void registryAddErrors(Map<Id, Takedowns_Contingency_plan__c> tkdwnsSelectedToValidation){
        Id recordTypeId = Schema.SObjectType.Insurance_VoBo__c.getRecordTypeInfosByName().get('Engenium Capital').getRecordTypeId();
        for(Insurance_VoBo__c Insurance_VoBo : [SELECT Id, Name, RecordTypeId, Takedown_CP__c, Stage__c, 
                                                (SELECT id, name, Insurance_Policy_Number__c 
                                                 FROM Insurance_Policies__r) 
                                                FROM Insurance_VoBo__c 
                                                where Takedown_CP__c in :tkdwnsSelectedToValidation.keySet()
                                               and RecordTypeId = :recordTypeId]){
			if(!Insurance_VoBo.Stage__c.equals('T2 VoBo Approved')){
            	tkdwnsSelectedToValidation.get(Insurance_VoBo.Takedown_CP__c).addError('No puede avanzar a Funded si no cuenta con una Póliza en aprobada en insurance to go');   
            } else if(Insurance_VoBo.Insurance_Policies__r.isEmpty()){
            	tkdwnsSelectedToValidation.get(Insurance_VoBo.Takedown_CP__c).addError('No puede avanzar a Funded si no cuenta con la Póliza cargada en Insurance To Go');   
            } else {
            	for(Insurance_Policy__c Insurance_Policy : Insurance_VoBo.Insurance_Policies__r){
                	if(string.isEmpty(Insurance_Policy.Insurance_Policy_Number__c)){
                    	tkdwnsSelectedToValidation.get(Insurance_VoBo.Takedown_CP__c).addError('No puede avanzar a Funded si no cuenta con el número de póliza cargado en Insurance To Go');
					}
                }
            }
        }
    }
}