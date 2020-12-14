/**
 * @File Name          : ST_PQ_Periodic_Expense_Wrapper_cls.cls
 * @Description        : 
 * @Author             : eduardo.villegas@engeniumcapital.com
 * @Group              : 
 * @Last Modified By   : eduardo.villegas@engeniumcapital.com
 * @Last Modified On   : 10/10/2019 17:16:21
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    8/10/2019   eduardo.villegas@engeniumcapital.com     Initial Version
**/
public with sharing class ST_PQ_Periodic_Expense_Wrapper_cls {
    public class query_All_Fields{
        
        //DataType: id
        @AuraEnabled
        public id recordID                  {get;set;}

        //DataType: Checkbox
        @AuraEnabled
        public boolean Active               {get;set;}
        
        //DataType: Currency(12, 2)
        @AuraEnabled
        public double Average_Payment       {get;set;}

        //DataType: Lookup(User)
        @AuraEnabled
        public id CreatedById               {get;set;}

        //DataType: Picklist
        @AuraEnabled
        public String CurrencyIsoCode       {get;set;}

        //DataType: Text(50)
        @AuraEnabled
        public String Description           {get;set;}

        //DataType: Lookup(User)
        @AuraEnabled
        public id LastModifiedById          {get;set;}

        //DataType: Number(6, 0)
        @AuraEnabled
        public Integer Num_Payments         {get;set;}

        //DataType: Auto Number
        @AuraEnabled
        public String Name                  {get;set;}

        //DataType: Text(50)
        @AuraEnabled
        public String Periodicity           {get;set;}

        //DataType: Text(255) (External ID)
        @AuraEnabled
        public String stExternalID          {get;set;}
        
        //DataType: Date
        @AuraEnabled
        public date Start_Date              {get;set;}
        
        //DataType: Date
        @AuraEnabled
        public id Pricing_Quote             {get;set;}

        //DataType: Relationship child to parent 
        @AuraEnabled
        public list<ST_PQ_Periodic_Expense_CFS_Wrapper_cls.query_All_Fields> ST_PQ_Periodic_Expense_CFS_Wrapper {get;set;}
        
    }
}