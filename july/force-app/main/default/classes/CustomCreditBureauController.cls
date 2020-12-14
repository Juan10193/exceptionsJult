/**
 * @File Name          : CustomCreditBureauController.cls
 * @Description        : 
 * @Author             : eduardo.amiens@outlook.com
 * @Group              : 
 * @Last Modified By   : eduardo.amiens@outlook.com
 * @Last Modified On   : 5/6/2020 15:58:07
 * @Modification Log   : 
 * Ver       Date            Author                 Modification
 * 1.0    14/5/2020   eduardo.amiens@outlook.com     Initial Version
**/
public class CustomCreditBureauController {
    public virtual class BaseException extends Exception {}
    public class fieldException extends BaseException {}

    
    @AuraEnabled(cacheable=false)
    public static string getEntityBypartyID(string partyID, string employeeNumber){
        //Si el party ID es 0 traerá todos los economic group, si se especifica el partyid traerá todos los entities asociados a un economic group
       string response;
        if(string.isNotEmpty(employeeNumber)){
            response  = EIV_EntityCallout.getEntityBypartyID(partyID,employeeNumber).getBody();
        } else {
            throw new fieldException('El usuario no tiene un SSO asignado, consulte con su administrador');
        }
        return response;      
    }
    @AuraEnabled(cacheable=false)
    public static string createCreditBureau(string jsonRequest){
        string response;
        system.debug('jsonRequest ' + jsonRequest);
        response  = EIV_EntityCallout.createCreditBureau(jsonRequest).getBody();
        return response;      
    }
    @AuraEnabled(cacheable=false)
    public static string getCurrentCreditBureau(string partyId){
        string response;
        system.debug('jsonRequest ' + partyId);
        response  = EIV_EntityCallout.getCurrentCreditBureau(partyId).getBody();
        return response;      
    }

    @AuraEnabled(cacheable=false)
    public static LMM_Credit_Bureau_Approval_Process__c getCreditBureauApprovalProcess(string oppId){
        LMM_Credit_Bureau_Approval_Process__c LMM_Credit_Bureau_Approval_Process = [SELECT Id, Name, LMM_rb_Opportunity__c,
        (select id, name, LMM_ls_Status__c from Requests_Credit_Bureau1__r)
        FROM LMM_Credit_Bureau_Approval_Process__c where LMM_rb_Opportunity__c = :oppId limit 1];
        system.debug('LMM_Credit_Bureau_Approval_Process ' + LMM_Credit_Bureau_Approval_Process);
        return LMM_Credit_Bureau_Approval_Process;      
    }
    @AuraEnabled(cacheable=true)
    public static list<LMM_Request_Credit_Bureau__c> getRequestsCreditBureau(string entityCPId){
        system.debug('entityCPId ' + entityCPId);
        list<LMM_Request_Credit_Bureau__c> LMM_Request_Credit_Bureau = [SELECT Id, 
        LMM_pd_Entity_CP__c, Name, LMM_tl_JSON_Request__c, LMM_ls_Status__c
        FROM LMM_Request_Credit_Bureau__c 
        where LMM_pd_Entity_CP__c = :entityCPId];
        return LMM_Request_Credit_Bureau;      
    }
    @AuraEnabled(cacheable=false)
    public static string getResultssCreditBureau(string jsonParameter){
         //Si el party ID es 0 traerá todos los economic group, si se especifica el partyid traerá todos los entities asociados a un economic group
       string response;
       if(string.isNotEmpty(jsonParameter)){
           response  = EIV_EntityCallout.getCreditBureauStepThree(jsonParameter).getBody();
       } else {
           throw new fieldException('El usuario no tiene un SSO asignado, consulte con su administrador');
       }
       system.debug('response o ' + response);
       return response;        
    }
    /*@AuraEnabled(cacheable=true)
    public static list<LMM_Entidad_Estructura_Settings__mdt> getLMM_Entidad_Estructura_Settings(){
        list<LMM_Entidad_Estructura_Settings__mdt> listLMM_Entidad_Estructura_Settings = [SELECT Id, DeveloperName, MasterLabel, 
        Language, NamespacePrefix, Label, QualifiedApiName, LMM_Number_Value__c, LMM_Description__c 
        FROM LMM_Entidad_Estructura_Settings__mdt]; 
       return listLMM_Entidad_Estructura_Settings;
    }*/

    @AuraEnabled(cacheable = true)
    public static string getUrlDocs(){
        string url;
        string sandbox = GetSandboxType.getTypeOfSandbox();
        if(sandbox =='QA'){
            url  = [SELECT Url__c FROM Urls__mdt where Sanbox__c ='Quality' and Application__c  ='LMM'][0].Url__c;
        }
        
        if(sandbox =='DEV' || sandbox== 'Developer Edition'){
            url  = [SELECT Url__c FROM Urls__mdt where Sanbox__c ='Development' and Application__c  ='LMM'][0].Url__c;
        }
        
        if(sandbox =='PROD'){
            url  = [SELECT Url__c FROM Urls__mdt where Sanbox__c ='Production' and Application__c  ='LMM'][0].Url__c;
        }
        
        return url;
    }
    

}