public class Takedown_Wrapper_SearchKnownSuppliers {
   //:::::::: Response :::::::::::::  
    
    public class responseSearchKnownSupplier{ 
        @AuraEnabled public Suppliers suppliers;
		@AuraEnabled public Status status;
    }
    
    public class Suppliers {
		@AuraEnabled public List<Supplier> supplier 	{get; set;}
	}
    
    public class Supplier {
		@AuraEnabled public Integer vendorId				{get; set;}
		@AuraEnabled public String vatRegistrationNum		{get; set;}
		@AuraEnabled public String vendorName				{get; set;}
		@AuraEnabled public String segment1					{get; set;}
		@AuraEnabled public Integer partyId					{get; set;}
		@AuraEnabled public String activeFlag				{get; set;}
		@AuraEnabled public Integer vendorSiteId			{get; set;}
		@AuraEnabled public String vendorSiteCode			{get; set;}
		@AuraEnabled public Integer orgId					{get; set;}
		@AuraEnabled public String organizationName			{get; set;}
		@AuraEnabled public String paymentCurrencyCode		{get; set;}
		@AuraEnabled public String vatCode					{get; set;}
		@AuraEnabled public String siteActiveFlag			{get; set;}
	}
    
   public class Status {
		@AuraEnabled public String code						{get; set;}
		@AuraEnabled public String message					{get; set;}
		@AuraEnabled public String detail					{get; set;}
	}

}