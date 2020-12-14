public class Takedown_CA_VS_ST_Table_Wrapper_cls {
    public class PricingGroup{
        @AuraEnabled
        public SupperTRUMP_Pricing_Quote_Wrapper.query_All_Fields PricingPQ {get;set;} 
        @AuraEnabled
        public SupperTRUMP_Pricing_Quote_Wrapper.query_All_Fields PricingCA {get;set;}
    }    
    public class Table{
        @AuraEnabled
        public List<Row> rows {get;set;}
    }
    public class Row{
    	@AuraEnabled
        public string field {get;set;}
        @AuraEnabled
        public string  dataPricingCA {get;set;}
        @AuraEnabled
        public string  dataPricingST {get;set;}
        @AuraEnabled
        public string  evaluation {get;set;}
        @AuraEnabled
        public string  symbol {get;set;}
        
        
    }
}