/**
 * @File Name          : lmmExpedienteEstructuraWrapper.cls
 * @Description        : 
 * @Author             : eduardo.amiens@outlook.com
 * @Group              : 
 * @Last Modified By   : eduardo.amiens@outlook.com
 * @Last Modified On   : 14/5/2020 13:06:30
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    16/4/2020   eduardo.amiens@outlook.com     Initial Version
**/
public with sharing class lmmExpedienteEstructuraWrapper {
    public class EntityMasterResponse{

        @AuraEnabled
        public string  partyID             {get;set;}

        @AuraEnabled
        public string  economicGroupId     {get;set;}

        @AuraEnabled
        public string   topParentId         {get;set;}

        @AuraEnabled
        public string   rfc                 {get;set;}

        @AuraEnabled 
        public string   entityName          {get;set;}

        @AuraEnabled
        public string   taxRegime           {get;set;}

        @AuraEnabled
        public string   customerType        {get;set;}

        @AuraEnabled               
        public string   oracleAccountNumber {get;set;}  //CustomerNumber

        @AuraEnabled
        public string   supplierFlag        {get;set;}
        
        @AuraEnabled
        public string   orRating            {get;set;}

        @AuraEnabled
        public string   mraId               {get;set;}

    }

    public class EntidadDeOportunidadHits {
        @AuraEnabled
        public string entidadDeOportunidadID    {get;set;}
        @AuraEnabled
        public string request                   {get;set;}   
    }
}