/**
 * @File Name          : IST_ST_PQ_Rent_Wrapper_cls.cls
 * @Description        : 
 * @Author             : eduardo.villegas@engeniumcapital.com
 * @Group              : 
 * @Last Modified By   : eduardo.villegas@engeniumcapital.com
 * @Last Modified On   : 8/10/2019 15:41:02
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    7/10/2019   eduardo.villegas@engeniumcapital.com     Initial Version
**/
public without sharing class IST_ST_PQ_Rent_Wrapper_cls {
    public class query_All_Fields{
        
        //DataType: id
        @AuraEnabled
        public id recordID                      {get;set;}

        //DataType: Currency(12, 2)
        @AuraEnabled
        public double IST_Advance_Payment       {get;set;}
        
        //DataType: Number(5, 0)
        @AuraEnabled
        public Integer IST_Calculation_Index    {get;set;}

        //DataType: Lookup(User)
        @AuraEnabled
        public id CreatedById                   {get;set;}

        //DataType: Picklist
        @AuraEnabled
        public String CurrencyIsoCode           {get;set;}

        //DataType: Text(50)
        @AuraEnabled
        public String IST_Description           {get;set;}

        //DataType: Lookup(User)
        @AuraEnabled
        public id LastModifiedById              {get;set;}

        //DataType: Number(3, 0)
        @AuraEnabled
        public Integer IST_Num_Payments         {get;set;}

        //DataType: Master-Detail(SuperTRUMP Pricing Quote)
        @AuraEnabled
        public id IST_Pricing_Quote             {get;set;}

        //DataType: Master-Detail(SuperTRUMP Pricing Quote)
        @AuraEnabled
        public Double Quasi_Lease_Rate          {get;set;}
        
        //DataType: Auto Number
        @AuraEnabled
        public String Name                      {get;set;}

        //DataType: Text(255) (External ID)
        @AuraEnabled
        public String IST_stExternalID          {get;set;}
        
        //DataType: Currency(12, 2)
        @AuraEnabled
        public Double IST_Total_Payments        {get;set;}
		
 		//DataType: Relationship child to parent 
        @AuraEnabled
        public List<ST_PQ_Rent_ASS_Wrapper_cls.query_All_Fields> list_ST_PQ_Rent_ASS_Wrapper {get;set;}  
        
        //DataType: Relationship child to parent 
        @AuraEnabled
        public List<ST_PQ_Rent_CFS_Wrapper_cls.query_All_Fields> list_ST_PQ_Rent_CFS_Wrapper {get;set;}  
        
        
    }
}