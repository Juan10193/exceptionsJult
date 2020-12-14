/**
 * @File Name          : ST_PQ_SSDeposit_Wrapper_cls.cls
 * @Description        : 
 * @Author             : eduardo.villegas@engeniumcapital.com
 * @Group              : 
 * @Last Modified By   : eduardo.villegas@engeniumcapital.com
 * @Last Modified On   : 8/10/2019 17:06:19
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    8/10/2019   eduardo.villegas@engeniumcapital.com     Initial Version
**/
public with sharing class ST_PQ_SSDeposit_Wrapper_cls {
    public class query_All_Fields{
        
        //DataType: id
        @AuraEnabled
        public id recordID                  {get;set;}

        //DataType: Currency(12, 2)
        @AuraEnabled
        public double Amount                {get;set;}

        //DataType: Lookup(User)
        @AuraEnabled
        public id CreatedById               {get;set;}
        
        //DataType: Picklist
        @AuraEnabled
        public String CurrencyIsoCode       {get;set;}

        //DataType: Lookup(User)
        @AuraEnabled
        public id LastModifiedById          {get;set;}

        //DataType: date
        @AuraEnabled
        public date Received                {get;set;}

        //DataType: date
        @AuraEnabled
        public date Returned                {get;set;}

        //DataType: Auto Number
        @AuraEnabled
        public String Name                  {get;set;}

        //DataType: Text(255) (External ID)
        @AuraEnabled
        public String stExternalID          {get;set;}

        //DataType: Master-Detail(SuperTRUMP Pricing Quote)
        @AuraEnabled
        public id Pricing_Quote             {get;set;}
    }
}