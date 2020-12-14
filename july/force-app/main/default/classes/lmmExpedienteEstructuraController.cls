/**
 * @File Name          : lmmExpedienteEstructuraController.cls
 * @Description        : 
 * @Author             : eduardo.amiens@outlook.com
 * @Group              : 
 * @Last Modified By   : eduardo.amiens@outlook.com
 * @Last Modified On   : 09-24-2020
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    14/4/2020   eduardo.amiens@outlook.com     Initial Version
**/
public with sharing class lmmExpedienteEstructuraController {
    
    public virtual class BaseException extends Exception {}
    public class fieldException extends BaseException {}

    /**
    * @description 
    * @author eduardo.amiens@outlook.com | 14/4/2020 
    * @param idOportunidad 
    * @return void 
    **/
    @AuraEnabled(cacheable=true)
    public static list<LMM_Entidad_de_oportunidad__c> getEntidadesDeOportunidad(id idOportunidad){
        return Data_Access_LMM_Entidad_de_oportunidad.getEntidadesDeOportunindadByOpp(idOportunidad);
    }
    
    @AuraEnabled(cacheable=false)
    public static string AsignEntities(list<lmmExpedienteEstructuraWrapper.EntityMasterResponse> listEntityMasterResponse, id opportunityID){
        System.debug('listEntityMasterResponse ' + listEntityMasterResponse);
        System.debug('opportunityID ' + opportunityID);
        lmmExpedienteEstructuraHelperEntity helperEntity = new lmmExpedienteEstructuraHelperEntity(listEntityMasterResponse,opportunityID);
        return helperEntity.makeEntidadOportunidadNuevoEntity();  
    }

    @AuraEnabled(cacheable=false)
    public static void validateHits(lmmExpedienteEstructuraWrapper.EntidadDeOportunidadHits EntidadDeOportunidadHits){
        System.debug('request ' + EntidadDeOportunidadHits);
        Takedown_Wrapper_SupplierInCA.responseAmlHits responseAmlHits;
        if(test.isRunningTest()){            
            responseAmlHits = Takedown_Wrapper_SupplierInCA_fillTest.fillResponse();
        } else {
        	responseAmlHits = Takedown_Callout_SupplierInCA.FindSupplierForNameOrRFC(EntidadDeOportunidadHits.request);    
        }        
        list<LMM_Entidad_de_oportunidad__c> LMM_Entidad_de_oportunidadToUpdate = new list<LMM_Entidad_de_oportunidad__c>();              
        List<SelectOption> options = new List<SelectOption>();        
        
        if(responseAmlHits.result.amlHits.size() > 0){
            Takedown_Wrapper_SupplierInCA.AmlHits AmlHits = responseAmlHits.result.amlHits.get(0);
            LMM_Entidad_de_oportunidad__c LMM_Entidad_de_oportunidad = new LMM_Entidad_de_oportunidad__c();
            LMM_Entidad_de_oportunidad.LMM_ls_Hits__c = AmlHits.hits.equals('false') ? 'action:approval' : 'action:close';
            LMM_Entidad_de_oportunidad.LMM_tl_Hits_Description__c = string.isNotEmpty(AmlHits.hitDescription) ? AmlHits.hitDescription : '';
            LMM_Entidad_de_oportunidad.id = EntidadDeOportunidadHits.entidadDeOportunidadID;  
            update LMM_Entidad_de_oportunidad;    
        }          
    }
    @AuraEnabled(cacheable=false)
    public static boolean entityHitsOnProgress(list<string> entidadOportunidadIds){
        System.debug('entidadOportunidadIds ' + entidadOportunidadIds);      
        list<LMM_Entidad_de_oportunidad__c> LMM_Entidad_de_oportunidadToUpdate = new list<LMM_Entidad_de_oportunidad__c>();   
        for(string idEO : entidadOportunidadIds) {
            LMM_Entidad_de_oportunidad__c LMM_Entidad_de_oportunidad = new LMM_Entidad_de_oportunidad__c();
            LMM_Entidad_de_oportunidad.id = idEO;
            LMM_Entidad_de_oportunidad.LMM_ls_Hits__c = 'action:change_record_type';
            LMM_Entidad_de_oportunidad.LMM_tl_Hits_Description__c = '';
            LMM_Entidad_de_oportunidadToUpdate.add(LMM_Entidad_de_oportunidad);
        }
        update LMM_Entidad_de_oportunidadToUpdate;    
        return true;
    }

    @AuraEnabled(cacheable=false)
    public static string searchEntitiesInOracle(string sfAccountID){
        sfAccountID = sfAccountID != null ? String.valueOf(sfAccountID).substring(0, 15) : sfAccountID;
        string response  = EIV_EntityCallout.getEntitiesByAccountID(sfAccountID).getBody();
        return response;         
    }
    
    @AuraEnabled(cacheable=false)
    public static string getEntitiesByEconomicGroup(string partyID){
        //Si el party ID es 0 traerá todos los economic group, si se especifica el partyid traerá todos los entities asociados a un economic group
        string response  = EIV_EntityCallout.getEntitiesByEconomicGroup(partyID).getBody();
        return response;      
    }
    @AuraEnabled(cacheable=false)
    public static string getRequestByPartyID(string partyID){
        //Si el party ID es 0 traerá todos los economic group, si se especifica el partyid traerá todos los entities asociados a un economic group
        string response  = EIV_EntityCallout.getRequestByPartyID(partyID).getBody();
        return response;      
    }
    @AuraEnabled(cacheable=false)
    public static void updateContactsFromEntity(list<string> listPartyId){
        User u = [select id, EmployeeNumber from user where id=:userinfo.getuserid()];
        if(string.isNotEmpty(u.EmployeeNumber)){
            LMMGetContactFromEntityBatch batchRequest = new LMMGetContactFromEntityBatch(listPartyId, u.EmployeeNumber);
            database.executeBatch(batchRequest, 50);
        } else {
            throw new fieldException('El usuario no tiene un SSO asignado, consulte con su administrador');
        }
        
              
    }
    
    @AuraEnabled(cacheable=true)
    public static LMM_Credit_Bureau_Approval_Process__c getCreditBureauApprovalProcess(string oppId){
        LMM_Credit_Bureau_Approval_Process__c LMM_Credit_Bureau_Approval_Process = [SELECT Id, Name, LMM_rb_Opportunity__c
        FROM LMM_Credit_Bureau_Approval_Process__c where LMM_rb_Opportunity__c = :oppId limit 1];
        return LMM_Credit_Bureau_Approval_Process;      
    }

    @AuraEnabled(cacheable=true)
    public static list<valueLabel> getLMM_lm_RolPKValues(){
        Schema.DescribeSObjectResult objSchema = LMM_Entidad_de_oportunidad__c.sObjectType.getDescribe();
        Map<String, Schema.SObjectField> fieldMap = objSchema.fields.getmap();
        List<Schema.Picklistentry> fld = fieldmap.get('LMM_lm_Rol__c').getDescribe().getpicklistValues();
        System.debug('fld ' + fld);
        list<valueLabel> pickList = new list<valueLabel>();
        for(Schema.Picklistentry pl : fld)
        {
            valueLabel vl = new valueLabel();
            vl.label = pl.getLabel();
            vl.value = pl.getValue();
            pickList.add(vl);
        }
        System.debug('pickList' + pickList);
        return pickList;
    }
    
    public class valueLabel {
        @AuraEnabled
        public string label {get;set;}
        @AuraEnabled
        public string value {get;set;}
    }
    

}