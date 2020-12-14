/**
 * @File Name          : ST_PQ_TV_Schedule_Step_Wrapper_cls.cls
 * @Description        : 
 * @Author             : eduardo.villegas@engeniumcapital.com
 * @Group              : 
 * @Last Modified By   : eduardo.villegas@engeniumcapital.com
 * @Last Modified On   : 8/10/2019 17:17:57
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    8/10/2019   eduardo.villegas@engeniumcapital.com     Initial Version
**/
public class ST_PQ_TV_Schedule_Step_Wrapper_cls {
    public class query_All_Fields{

        //DataType: id
        @AuraEnabled
        public id recordID                              {get;set;}

        //DataType: Currency(12, 2)
        @AuraEnabled
        public Double Advance_Debt_Service              {get;set;}
        
        //DataType: Currency(12, 2)
        @AuraEnabled
        public Double Advance_Rent                      {get;set;}
        
        //DataType: Currency(12, 2)
        @AuraEnabled
        public Double Arrears_Debt_Service              {get;set;}
        
        //DataType: Currency(12, 2)
        @AuraEnabled
        public Double Arrears_Rent                      {get;set;}
        
        //DataType: Lookup(User)
        @AuraEnabled
        public id CreatedById                           {get;set;}
        
        //DataType: Picklist
        @AuraEnabled
        public String CurrencyIsoCode                   {get;set;}
        
        //DataType: Text(10)
        @AuraEnabled
        public String TV_Date                           {get;set;}
        
        //DataType: Lookup(User)
        @AuraEnabled
        public id LastModifiedById                      {get;set;}
        
        //DataType: Number(6, 0)
        @AuraEnabled
        public Integer Number_of_Payments_Scheduled     {get;set;}
        
        //DataType: Master-Detail(SuperTRUMP Pricing Quote)	
        @AuraEnabled
        public id Quote                                 {get;set;}
        
        //DataType: Currency(12, 2)
        @AuraEnabled
        public Double Termination_Value_Amount          {get;set;}
         
        //DataType: Percent(4, 4)
        @AuraEnabled
        public Double Termination_Value_Percent         {get;set;} 
        
        //DataType: Currency(12, 2)
        @AuraEnabled
        public Double Total_Due_On_Termination          {get;set;}
         
        //DataType: Text(10)
        @AuraEnabled
        public String Name                              {get;set;}
    }

}