public class Takedown_Wrapper_DetSearchKnownSuppliers {
    
    public class responseDetSearchKnownSupplier{
        @AuraEnabled public Suppliers suppliers;
		@AuraEnabled public Status status;
        
    }
    
    public class Suppliers {
		@AuraEnabled public List<Supplier> supplier					{get; set;}
	}
    
    
    public class Supplier {
		@AuraEnabled public Integer vendorId 						{get; set;}
		@AuraEnabled public String segment1							{get; set;}
		@AuraEnabled public String vendorName						{get; set;}
		@AuraEnabled public String vendorNameAlt					{get; set;}
		@AuraEnabled public String vendorTypeLookupCode				{get; set;}
        @AuraEnabled public String vendorType						{get; set;}
		@AuraEnabled public String vatRegistrationNum 				{get; set;}
		@AuraEnabled public String federalReportableFlag			{get; set;}
		@AuraEnabled public String startDateActive					{get; set;}
        @AuraEnabled public String endDateActive418					{get; set;}
        @AuraEnabled public String offsetTaxFlag419 				{get; set;}
        @AuraEnabled public String autoTaxCalcFlag420 				{get; set;}
        @AuraEnabled public String stateReportableFlag421			{get; set;}
        @AuraEnabled public String niNumber							{get; set;}
		@AuraEnabled public String allowAwtFlag						{get; set;}
		@AuraEnabled public String jgzzFiscalCode					{get; set;}
		@AuraEnabled public String taxReference						{get; set;}
		@AuraEnabled public String organizationTypeLookupCode		{get; set;}
		@AuraEnabled public Integer partyId							{get; set;}
        @AuraEnabled public Integer employeeId						{get; set;}
		@AuraEnabled public String summaryFlag						{get; set;}
		@AuraEnabled public String enabledFlag						{get; set;}
		@AuraEnabled public String oneTimeFlag						{get; set;}
		@AuraEnabled public String invoiceCurrencyCode				{get; set;}
		@AuraEnabled public String paymentCurrencyCode				{get; set;}
        @AuraEnabled public String vatCode				            {get; set;}
		@AuraEnabled public String attributeCategory			    {get; set;}
		@AuraEnabled public String attribute1						{get; set;}
		@AuraEnabled public String attribute2						{get; set;}
		@AuraEnabled public String attribute3						{get; set;}
        @AuraEnabled public String attribute4						{get; set;}
        @AuraEnabled public String attribute5						{get; set;}
        @AuraEnabled public String attribute6						{get; set;}
        @AuraEnabled public String attribute7						{get; set;}
        @AuraEnabled public String attribute8						{get; set;}
        @AuraEnabled public String attribute9						{get; set;}
        @AuraEnabled public String attribute10						{get; set;}
        @AuraEnabled public String attribute11						{get; set;}
        @AuraEnabled public String attribute12						{get; set;}
        @AuraEnabled public String attribute13						{get; set;}
        @AuraEnabled public String attribute14						{get; set;}
        @AuraEnabled public String attribute15						{get; set;}
		@AuraEnabled public String activeFlag						{get; set;}
        @AuraEnabled public String originalSso						{get; set;}
		@AuraEnabled public Sites sites								{get; set;}
	}
    
    public class Sites {
		@AuraEnabled public List<Site> site								{get; set;}
	}
         
    
    public class Site {
		@AuraEnabled public Integer vendorId							{get; set;}
		@AuraEnabled public Integer vendorSiteId						{get; set;}
		@AuraEnabled public String vendorSiteCode						{get; set;}
        @AuraEnabled public String vendorSiteCodeAlt					{get; set;}
        @AuraEnabled public Integer shipToLocationId					{get; set;}
        @AuraEnabled public String shipToLocationName					{get; set;}
		@AuraEnabled public String termsDateBasis						{get; set;}
		@AuraEnabled public Integer acctsPayCodeCombinationId			{get; set;}
		@AuraEnabled public String acctsPayCodeCombination				{get; set;}
		@AuraEnabled public Integer prepayCodeCombinationId				{get; set;}
		@AuraEnabled public String prepayCodeCombination				{get; set;}
		@AuraEnabled public String payGroupLookupCode					{get; set;}
		@AuraEnabled public Integer paymentPriority						{get; set;}
		@AuraEnabled public Integer termId								{get; set;}
		@AuraEnabled public String termName								{get; set;}
		@AuraEnabled public String payDateBasisLookupCode				{get; set;}
		@AuraEnabled public String paymentCurrencyCode					{get; set;}
		@AuraEnabled public Integer orgId								{get; set;}
		@AuraEnabled public String organizationName						{get; set;}
		@AuraEnabled public String allowAwtFlag							{get; set;}
        @AuraEnabled public Integer awtGroupId							{get; set;}
        @AuraEnabled public String awtGroup							    {get; set;}
		@AuraEnabled public String primaryPaySiteFlag					{get; set;}
		@AuraEnabled public String vatCode								{get; set;}
        @AuraEnabled public String vatRegistrationNum					{get; set;}
        @AuraEnabled public String remittanceEmail						{get; set;}
		@AuraEnabled public String offsetTaxFlag						{get; set;}
		@AuraEnabled public String autoTaxCalcFlag						{get; set;}
		@AuraEnabled public String inactiveDate							{get; set;}
        @AuraEnabled public String areaCode								{get; set;}
        @AuraEnabled public String phone								{get; set;}
		@AuraEnabled public String purchasingSiteFlag					{get; set;}
		@AuraEnabled public String rfqOnlySiteFlag						{get; set;}
		@AuraEnabled public String paySiteFlag							{get; set;}
        @AuraEnabled public String emailAddress							{get; set;}
		@AuraEnabled public Integer partySiteId							{get; set;}
        @AuraEnabled public String partySiteName						{get; set;}
		@AuraEnabled public String province								{get; set;}
		@AuraEnabled public String country								{get; set;}
		@AuraEnabled public String addressLine1							{get; set;}
		@AuraEnabled public String addressLine2							{get; set;}
        @AuraEnabled public String addressLine3							{get; set;}
		@AuraEnabled public String addressLine4							{get; set;}
		@AuraEnabled public String city									{get; set;}
		@AuraEnabled public String state								{get; set;}
		@AuraEnabled public String zip									{get; set;}
		@AuraEnabled public  String attributeCategory					{get; set;}
		@AuraEnabled public String attribute1							{get; set;}
        @AuraEnabled public String attribute2							{get; set;}
        @AuraEnabled public String attribute3							{get; set;}
        @AuraEnabled public String attribute4							{get; set;}
        @AuraEnabled public String attribute5							{get; set;}
        @AuraEnabled public String attribute6							{get; set;}
        @AuraEnabled public String attribute7							{get; set;}
        @AuraEnabled public String attribute8							{get; set;}
        @AuraEnabled public String attribute9							{get; set;}
        @AuraEnabled public String attribute10							{get; set;}
        @AuraEnabled public String attribute11							{get; set;}
        @AuraEnabled public String attribute12							{get; set;}
        @AuraEnabled public String attribute13							{get; set;}
		@AuraEnabled public String attribute14							{get; set;}
        @AuraEnabled public String attribute15							{get; set;}
		@AuraEnabled public String activeFlag							{get; set;}
        @AuraEnabled public String defaultPaymentMethodCode				{get; set;}
        @AuraEnabled public String originalSso							{get; set;}
		@AuraEnabled public Accounts accounts							{get; set;}
		@AuraEnabled public Contacts contacts							{get; set;}
        @AuraEnabled public Supplier supplier 							{get;set;}
	}
    public class Accounts {
		@AuraEnabled public List<Account> account						{get; set;}
	}
    
	public class Account {
		@AuraEnabled public Integer vendorId							{get; set;}
		@AuraEnabled public Integer vendorSiteId						{get; set;}
        @AuraEnabled public Integer orgId								{get; set;}
		@AuraEnabled public String bankName								{get; set;}
		@AuraEnabled public String countryCode							{get; set;}
		@AuraEnabled public String bankNumber							{get; set;}
		@AuraEnabled public String branchName							{get; set;}
		@AuraEnabled public String branchType							{get; set;}
		@AuraEnabled public Integer bankAccountId						{get; set;}
		@AuraEnabled public Integer branchId							{get; set;}
		@AuraEnabled public Integer bankId								{get; set;}
		@AuraEnabled public Integer acctOwnerPartyId					{get; set;}
        @AuraEnabled public Integer bankAccountName						{get; set;}
		@AuraEnabled public String bankAccountNum						{get; set;}
		@AuraEnabled public String curency								{get; set;} // currency
        @AuraEnabled public String accCountryCode						{get; set;}
		@AuraEnabled public String startDate							{get; set;}
		@AuraEnabled public String endDate								{get; set;}
		@AuraEnabled public String attributeCategory					{get; set;}
		@AuraEnabled public String attribute1							{get; set;}
		@AuraEnabled public String attribute2							{get; set;}
        @AuraEnabled public String attribute3							{get; set;}
        @AuraEnabled public String attribute4							{get; set;}
        @AuraEnabled public String attribute5							{get; set;}
        @AuraEnabled public String attribute6							{get; set;}
        @AuraEnabled public String attribute7							{get; set;}
        @AuraEnabled public String attribute8							{get; set;}
        @AuraEnabled public String attribute9							{get; set;}
        @AuraEnabled public String attribute10							{get; set;}
        @AuraEnabled public String attribute11							{get; set;}
        @AuraEnabled public String attribute12							{get; set;}
        @AuraEnabled public String attribute13							{get; set;}
        @AuraEnabled public String attribute14							{get; set;}
        @AuraEnabled public String attribute15							{get; set;}
		@AuraEnabled public Integer objectVersionNumber					{get; set;}
		@AuraEnabled public String activeFlag							{get; set;}
        @AuraEnabled public String originalSso							{get; set;}
        @AuraEnabled public Site site 									{get; set;}


	}
    public class Contacts {
		@AuraEnabled public List<Contact> contact						{get; set;}
	}
    
    public class Contact {
		@AuraEnabled public Integer vendorId							{get; set;}
		@AuraEnabled public Integer vendorSiteId						{get; set;}
		@AuraEnabled public Integer vendorContactId						{get; set;}
        @AuraEnabled public Integer orgId						        {get; set;}
		@AuraEnabled public Integer perPartyId							{get; set;}
		@AuraEnabled public Integer relationshipId						{get; set;}
        @AuraEnabled public String relationship						    {get; set;}
		@AuraEnabled public Integer relPartyId							{get; set;}
		@AuraEnabled public Integer partySiteId							{get; set;}
		@AuraEnabled public Integer orgContactId						{get; set;}
		@AuraEnabled public Integer orgPartySiteId						{get; set;}
		@AuraEnabled public String personFirstName						{get; set;}
        @AuraEnabled public String personMiddleName						{get; set;}
		@AuraEnabled public String personLastName						{get; set;}
        @AuraEnabled public String personTitle							{get; set;}
		@AuraEnabled public String inactiveDate							{get; set;}
        @AuraEnabled public String department							{get; set;}
		@AuraEnabled public String areaCode								{get; set;}
		@AuraEnabled public String phone								{get; set;}
		@AuraEnabled public String emailAddress							{get; set;}
        @AuraEnabled public String attributeCategory					{get; set;}
        @AuraEnabled public String attribute1							{get; set;}
        @AuraEnabled public String attribute2							{get; set;}
        @AuraEnabled public String attribute3							{get; set;}
        @AuraEnabled public String attribute4							{get; set;}
        @AuraEnabled public String attribute5							{get; set;}
        @AuraEnabled public String attribute6							{get; set;}
        @AuraEnabled public String attribute7							{get; set;}
        @AuraEnabled public String attribute8							{get; set;}
        @AuraEnabled public String attribute9							{get; set;}
        @AuraEnabled public String attribute10							{get; set;}
        @AuraEnabled public String attribute11							{get; set;}
        @AuraEnabled public String attribute12							{get; set;}
        @AuraEnabled public String attribute13							{get; set;}
        @AuraEnabled public String attribute14							{get; set;}
        @AuraEnabled public String attribute15							{get; set;}
		@AuraEnabled public String activeFlag							{get; set;}
        @AuraEnabled public String originalSso							{get; set;}
        @AuraEnabled public Site site 									{get; set;}
	}

    
    public class Status {
		@AuraEnabled public String code									{get; set;}
		@AuraEnabled public String message								{get; set;}
		@AuraEnabled public String detail								{get; set;}
	}

}