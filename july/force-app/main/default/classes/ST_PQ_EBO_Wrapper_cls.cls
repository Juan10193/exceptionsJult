public class ST_PQ_EBO_Wrapper_cls {
    public class query_All_Fields{
        
        //DataType: id
        @AuraEnabled
        public id recordID {get;set;}
        
        //DataType: Checkbox
        @AuraEnabled
        public boolean Active {get;set;}
        
        //DataType: Currency(12, 2)
        @AuraEnabled
        public Double Amount {get;set;}
        
        //DataType: Text(50)
        @AuraEnabled
        public String Based_on {get;set;}
        
        //DataType: Picklist
        @AuraEnabled
        public id CreatedById {get;set;}
        
        //DataType: Lookup(User)
        @AuraEnabled
        public string CurrencyIsoCode {get;set;}
        
        //DataType: Date
        @AuraEnabled
        public Date EBO_Date {get;set;}
        
        //DataType: Auto Number
        @AuraEnabled
        public String Name {get;set;}
        
        //DataType: Currency(12, 2)	
        @AuraEnabled
        public Double FMV {get;set;}
        
        //DataType: Lookup(User)
        @AuraEnabled
        public id LastModifiedById {get;set;}
        
        //DataType: Percent(4, 4)
        @AuraEnabled
        public Double Premium {get;set;}
        
        //DataType: Text(255) (External ID)
        @AuraEnabled
        public String stExternalID {get;set;}
         
        //DataType: Master-Detail(SuperTRUMP Pricing Quote)
        @AuraEnabled
        public id Pricing_Quote {get;set;} 
        
        //DataType: Number(5, 4)
        @AuraEnabled
        public Double Term {get;set;}
    }

}