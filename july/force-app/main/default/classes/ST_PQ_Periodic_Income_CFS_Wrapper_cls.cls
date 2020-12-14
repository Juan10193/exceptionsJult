/**
 * @File Name          : ST_PQ_Periodic_Income_CFS_Wrapper_cls.cls
 * @Description        : 
 * @Author             : eduardo.villegas@engeniumcapital.com
 * @Group              : 
 * @Last Modified By   : eduardo.villegas@engeniumcapital.com
 * @Last Modified On   : 10/10/2019 17:28:21
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    10/10/2019   eduardo.villegas@engeniumcapital.com     Initial Version
**/
public class ST_PQ_Periodic_Income_CFS_Wrapper_cls {
    
    public class query_All_Fields{
        
        //DataType: id
        @AuraEnabled
        public id recordID                  {get;set;}

        //DataType: Currency(12, 2)	
        @AuraEnabled
        public double Amount                {get;set;}
        
        //DataType: Currency(12, 2)
        @AuraEnabled
        public double Balance               {get;set;}

        //DataType: Lookup(User)
        @AuraEnabled
        public id CreatedById               {get;set;}

        //DataType: Picklist
        @AuraEnabled
        public String CurrencyIsoCode       {get;set;}

        //DataType: Text(50)
        @AuraEnabled
        public String Start_Accrual         {get;set;}

        //DataType: Lookup(User)
        @AuraEnabled
        public id LastModifiedById          {get;set;}

        //DataType: Number(6, 0)
        @AuraEnabled
        public Integer Num_Pmts             {get;set;}

        //DataType: Text(50)
        @AuraEnabled
        public String Period                {get;set;}

        //DataType: Master-Detail(Periodic Income)
        @AuraEnabled
        public id Periodic_Income           {get;set;}

        //DataType: Auto Number
        @AuraEnabled
        public String Name                  {get;set;}
        
        //DataType: Percent(4, 4)
        @AuraEnabled
        public double Rate                  {get;set;}
        
        //DataType: Number(6, 0)
        @AuraEnabled
        public double Step                  {get;set;}
        //DataType: Picklist
        @AuraEnabled
        public string Timing                {get;set;}
        //DataType: Text(10)
        @AuraEnabled
        public string End_Accrual           {get;set;}
        //DataType: Text(50)
        @AuraEnabled
        public string Type                  {get;set;}
        
    }

}