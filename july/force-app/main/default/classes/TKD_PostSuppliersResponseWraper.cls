public class TKD_PostSuppliersResponseWraper {
    public class ResponsePostSuppliers{
        public string supplierId {get;set;}
    	public string partyId {get;set;}
        public Status status {get;set;}
        public string supplierSFID {get;Set;}
    }
    
    public class Status{
        public string code {get;set;}
        public string message {get;set;}
        public string detail {get;set;}
    }
    
    
}