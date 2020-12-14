public class Supplier_Details_Wrapper {
    public Supplier supplier {get;set;}

    
    public class Supplier {
        public Supplier__c supplierDetails {get;set;}
        public list<TKD_Site__c> sites   {get;set;}
    }
}