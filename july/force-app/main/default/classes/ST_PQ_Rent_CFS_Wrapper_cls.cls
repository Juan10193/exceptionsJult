public class ST_PQ_Rent_CFS_Wrapper_cls {
     public class query_All_Fields{
         
        //DataType: id
        @AuraEnabled
        public id recordID                      {get;set;}
         
        //DataType: Currency(12, 2)
        @AuraEnabled
        public Double Amount {get;set;}
        
        //DataType: Currency(12, 2)
        @AuraEnabled
        public Double Balance {get;set;}
        
        //DataType: Lookup(User)
        @AuraEnabled
        public id CreatedById {get;set;}
        
        //DataType: Picklist
        @AuraEnabled
        public String CurrencyIsoCode {get;set;}
        
        //DataType: Text(10)
        @AuraEnabled
        public String Start_Accrual {get;set;}
        
        //DataType: Lookup(User)
        @AuraEnabled
        public id LastModifiedById {get;set;}
        
        //DataType: Master-Detail(Rent)
        @AuraEnabled
        public id Rent {get;set;}
        
        //DataType: Auto Number
        @AuraEnabled
        public String Name {get;set;}
        
        //DataType: Number(6, 0)
        @AuraEnabled
        public Integer Num_Pmts {get;set;}
        
        //DataType: Text(50)
        @AuraEnabled
        public String Period {get;set;}
        
        //DataType: Percent(6, 6)
        @AuraEnabled
        public double Rate {get;set;}
         
        //DataType: Number(6, 0)
        @AuraEnabled
        public integer Step {get;set;} 
        
        //DataType: Picklist
        @AuraEnabled
        public String Timing {get;set;}
         
        //DataType: Text(10)
        @AuraEnabled
        public String End_Accrual {get;set;}
         
        //DataType: Text(50)
        @AuraEnabled
        public String TypeRent {get;set;}
    }

}