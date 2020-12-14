public class ST_PQ_Loan_ASS_Wrapper_cls {
    public class query_All_Fields{
        
        //DataType: record id
        @AuraEnabled
        public id recordID {get;set;}
        
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
        public String Amort_Date {get;set;}
        
        //DataType: Currency(12, 2)
        @AuraEnabled
        public double Funding {get;set;}
        
        //DataType: Currency(12, 2)
        @AuraEnabled
        public double Interest {get;set;}
        
        //DataType: Lookup(User)
        @AuraEnabled
        public id LastModifiedById {get;set;}
        
        //DataType: Master-Detail(Loan)
        @AuraEnabled
        public id Loan {get;set;}
        
        //DataType: Auto Number
        @AuraEnabled
        public String Name {get;set;}
        
        //DataType: Currency(12, 2)
        @AuraEnabled
        public double Payment {get;set;}
        
        //DataType: Currency(12, 2)
        @AuraEnabled
        public double Principal {get;set;}
        
        //DataType: Number(6, 0)
        @AuraEnabled
        public integer Step {get;set;}
    }

}