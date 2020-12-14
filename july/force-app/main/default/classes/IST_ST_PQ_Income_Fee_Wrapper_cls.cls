/**
 * @File Name          : IST_ST_PQ_Income_Fee_Wrapper_cls.cls
 * @Description        : 
 * @Author             : eduardo.villegas@engeniumcapital.com
 * @Group              : 
 * @Last Modified By   : eduardo.villegas@engeniumcapital.com
 * @Last Modified On   : 8/10/2019 15:30:41
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    7/10/2019   eduardo.villegas@engeniumcapital.com     Initial Version
**/
public class IST_ST_PQ_Income_Fee_Wrapper_cls {
    public class query_All_Fields{
        //DataType: id
        @AuraEnabled
        public id recordID                  {get;set;}
        
        //DataType: Currency(12, 2)
        @AuraEnabled
        public double IST_Amount	        {get;set;}
        
        //DataType: Number(5, 0)
        @AuraEnabled
        public Integer IST_Calculation_Index{get;set;}
        
        //DataType: Lookup(User)
        @AuraEnabled
        public id CreatedById	            {get;set;}
        
        //DataType: Picklist
        @AuraEnabled
        public String CurrencyIsoCode	    {get;set;}
        
        //DataType: Text(50)
        @AuraEnabled
        public String IST_Description	    {get;set;}
        
        //DataType: Auto Number
        @AuraEnabled
        public String Name	                {get;set;}
        
        //DataType: Lookup(User)
        @AuraEnabled
        public id LastModifiedById	        {get;set;}
        
        //DataType: Date
        @AuraEnabled
        public date IST_Paid_Date	        {get;set;}
        
        //DataType: Percent(6, 4)
        @AuraEnabled
        public double IST_Percent	        {get;set;}
        
        //DataType: Master-Detail(SuperTRUMP Pricing Quote)	
        @AuraEnabled
        public id IST_Pricing_Quote	        {get;set;}
        
        //DataType: Text(255) (External ID)
        @AuraEnabled
        public string IST_stExternalID	    {get;set;}
    }

}