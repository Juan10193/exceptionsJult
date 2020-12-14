public class EM_Wrapper_Entity {
    public class EntityMain {
        public EntityInfo entityInfo {get;set;}   
        public Status status {get;set;}
    }
    
    public class EntityInfo {
        public Entity entity {get;set;}	   
        public ContactInfo contactInfo {get;set;}
        public AddressInfo addressInfo {get;set;}
        public InvoiceInfo invoiceInfo {get;set;}
        public Privilege privilege {get;set;}
    }
    
    public class Entity {
        public string sFaccountID {get;set;}
        public string custAccountId {get;set;}
        public integer partyID {get;set;}
        public string rfc {get;set;}
        public string customerType {get;set;}
        public string customerStatus {get;set;}
        public string topParentId {get;set;}
        public string topParentName {get;set;}
        public string sfAccountName {get;set;}
        public string tin {get;set;}
        public string economicGroupId {get;set;}
        public string economicGroupName {get;set;}
        public boolean limitedInformationEntity {get;set;}
        public string taxRegime {get;set;}
        public boolean foreignEntity {get;set;}
        public string nationality {get;set;}
        public string oracleAccountNumber {get;set;}
        public string curp {get;set;}
        public string prefix {get;set;}
        public string firstName {get;set;}
        public string middleName {get;set;}
        public string firstLastName {get;set;}
        public string secondLastName {get;set;}
        public string salesRepresentative {get;set;}
        public boolean supplierFlag {get;set;}
        public string legalName {get;set;}
        public string companyLegalNameTermination {get;set;}
        public string oracleAccountName {get;set;}
        public string sourceCreatedBy {get;set;}
        public string sourceUpdatedBy {get;set;}
        public string sourceApplicationID {get;set;}
        public string sourceCreateDate {get;set;}
        public string sourceLastUpdateDate {get;set;}
        public Aml aml {get;set;}
        public Rating rating {get;set;}
        public Sic sic {get;set;}     
        public Buro buro {get;set;}
    }
    public class Aml {
        public string targetMarketJurisdiction {get;set;}
        public string ccr {get;set;}
        public string crrComments {get;set;}
        public string ccrOverride {get;set;}
        public string entityType {get;set;}        
    }
    public class Rating {
        public string mraId {get;set;}
        public string bloombergId {get;set;}
        public string hnwiId {get;set;}
        public string orRating {get;set;}
        public string transactionDate {get;set;} 
        public string riskClassification {get;set;}         
    }
    public class Sic {
        public string sicCode {get;set;}
        public string sicDescription {get;set;}
        public string economicGroupSicCode {get;set;}
        public string economicGroupSicDescription {get;set;}         
    }
    public class Buro {
        public string customerAlias {get;set;}
        public string buroFlag {get;set;}        
    }
    
 
    public class ContactInfo {
        public Contacts contacts {get;set;}
        public Privilege privilege {get;set;}
    }
    
    public class Contacts{
        public list<Contact> contact {get;set;} 
    }
    
    public class Contact{
        public integer contactId {get;set;}
        public integer partyID {get;set;}
        public string prefix {get;set;}
        public string firstName {get;set;}
        public string middleName {get;set;}
        public string firstLastName {get;set;}
        public string secondLastName {get;set;}
        public string title {get;set;}
        public string status {get;set;}
        public string countryCode {get;set;}
        public string areaCode {get;set;}
        public string phone {get;set;}
        public string phoneNumberExtension {get;set;}
        public string mobile {get;set;}
        public string email {get;set;}
        public string rtype {get;set;}
        public string sourceCreatedBy {get;set;}
        public string sourceUpdatedBy {get;set;}
        public string sourceApplicationId {get;set;}
        public string sourceCreateDate {get;set;}
        public string sourceLastUpdateDate {get;set;}
    }
    
    public class Privilege {
    	public string sso {get;set;}
        public string applicationName {get;set;}
        public string applicationCode {get;set;}
        public string screen {get;set;}
        public string employeeName {get;set;}
        public string vCrud {get;set;}
    }
    public class AddressInfo {
        public Addresses addresses {get;set;}
        public Privilege privilege {get;set;}
    }
    public class Addresses {
        public list<Address> address {get;set;}    
    }
    public class Address {
        public integer locationId {get;set;}
        public integer partyID {get;set;}
        public string street {get;set;}
        public string outdoorNumber {get;set;}
        public string interiorNumber {get;set;} 
        public string county {get;set;}
        public string municipality {get;set;}
        public string country {get;set;}
        public string city {get;set;}        
        public string zipCode {get;set;}
        public string state {get;set;}
        public string status {get;set;}
        public string purpose {get;set;}
        public string sourceCreatedBy {get;set;} 
        public string sourceUpdatedBy {get;set;}
        public string sourceApplicationId {get;set;}
        public string sourceCreateDate {get;set;}
        public string sourceLastUpdateDate {get;set;}
        public string r97 {get;set;}
        public string r89 {get;set;}
        public string xa7 {get;set;}
        public string s1u {get;set;}
        public string addressReference {get;set;}
        public string normalizedAddress {get;set;}
    }
    public class InvoiceInfo {
        public Invoices invoices {get;set;}
        public Privilege privilege {get;set;}
        
    }
    
    public class Invoices{
        public list<Invoice> invoice {get;set;}	    
    }
    
    public class Invoice{
        public integer custAcctSiteId {get;set;}
        public string ecOperatingUnitName {get;set;}
        public integer ecOperatingUnitId {get;Set;}
        public string ecClabe {get;Set;}
        public string ecPaymentAccount {get;set;}
        public string paymentMethod {get;set;}
        public string billingMails {get;set;}
        public string sourceCreatedBy {get;Set;}
        public string sourceUpdatedBy {get;set;}
        public string sourceApplicationId {get;set;}
        public string sourceCreateDate {get;Set;}
        public string sourceLastUpdateDate {get;set;}
    }
    
    public class Status {
        public string code {get;set;}
        public string message {get;set;}
    }
}