@Istest
public class Tkd_Wrapper_DetSearchKnownSuppliers_Test {
    @isTest static void responseDetSearchKnownSupplier_Test(){
        Takedown_Wrapper_DetSearchKnownSuppliers.responseDetSearchKnownSupplier response =  new Takedown_Wrapper_DetSearchKnownSuppliers.responseDetSearchKnownSupplier();
        response.suppliers = new Takedown_Wrapper_DetSearchKnownSuppliers.Suppliers();
        response.status = new Takedown_Wrapper_DetSearchKnownSuppliers.Status();
    }
    
    @isTest static void suppliers_Test(){
        Takedown_Wrapper_DetSearchKnownSuppliers.Suppliers suppliers = new  Takedown_Wrapper_DetSearchKnownSuppliers.Suppliers();
        suppliers.supplier = new List<Takedown_Wrapper_DetSearchKnownSuppliers.Supplier>();        
    }
    
    @isTest static void supplier_Test(){
        Takedown_Wrapper_DetSearchKnownSuppliers.Supplier supplier = new Takedown_Wrapper_DetSearchKnownSuppliers.Supplier();
        supplier.vendorId = 107190;
		supplier.segment1 = '13084';
		supplier.vendorName	='SIERRA NORTE TRUCK CENTER SA DE CV';						
		supplier.vendorNameAlt ='SIERRA NORTE TRUCK CENTER SA DE CV';					
		supplier.vendorTypeLookupCode ='ARRENDAMIENTOS -PM';			
        supplier.vendorType	='vendorType';					
		supplier.vatRegistrationNum ='SRE0602021Q6';				
		supplier.federalReportableFlag ='N';		
		supplier.startDateActive ='26-MAR-18';					
        supplier.endDateActive418 ='';			
        supplier.offsetTaxFlag419 =''; 				
        supplier.autoTaxCalcFlag420 ='';			
        supplier.stateReportableFlag421 ='';			
        supplier.niNumber = '';						
		supplier.allowAwtFlag = 'N';				
		supplier.jgzzFiscalCode = 'SRE0602021Q6';				
		supplier.taxReference = 'SRE0602021Q6';					
		supplier.organizationTypeLookupCode = 'PERSONA MORAL';		
		supplier.partyId = 140407;
        supplier.employeeId = 123;
		supplier.summaryFlag = 'N';						
		supplier.enabledFlag = 'Y';					
		supplier.oneTimeFlag = 'N';				
		supplier.invoiceCurrencyCode = 'MXN';		
		supplier.paymentCurrencyCode = 'MXN';			
        supplier.vatCode = 'AP_IVA_16';	            
		supplier.attributeCategory = '';	   
		supplier.attribute1	= '1';					
		supplier.attribute2	= '2';					
		supplier.attribute3	= '3';					
        supplier.attribute4	= '4';					
        supplier.attribute5	= '5';					
        supplier.attribute6	= '6';					
        supplier.attribute7	= '7';					
        supplier.attribute8	= '8';					
        supplier.attribute9	= '9';					
        supplier.attribute10 = '10';					
        supplier.attribute11 = '11';				
        supplier.attribute12 = '12';					
        supplier.attribute13 = '13';					
        supplier.attribute14 = '14';					
        supplier.attribute15 = '15';					
		supplier.activeFlag	= 'Y';					
        supplier.originalSso = 'originalSso';					
		supplier.sites	= new Takedown_Wrapper_DetSearchKnownSuppliers.Sites();				
    }
    
    @isTest static void sites_Test(){
        Takedown_Wrapper_DetSearchKnownSuppliers.Sites sites = new Takedown_Wrapper_DetSearchKnownSuppliers.Sites(); 
        sites.site= new List<Takedown_Wrapper_DetSearchKnownSuppliers.Site>();
    }
    
    @isTest static void site_Test(){
        Takedown_Wrapper_DetSearchKnownSuppliers.Site site = new Takedown_Wrapper_DetSearchKnownSuppliers.Site();
         site.vendorId = 107190;						
		 site.vendorSiteId  = 573556;					
		 site.vendorSiteCode	= 'DMX16-002-0195';					
         site.vendorSiteCodeAlt	= 'DMX16-002-0195';				
         site.shipToLocationId  = 245;					
         site.shipToLocationName= 'SAMARA';					
		 site.termsDateBasis	= 'Invoice';					
		 site.acctsPayCodeCombinationId	 = 45718;		
		 site.acctsPayCodeCombination	= '397-00000-307114002-000-000000-0000';			
		 site.prepayCodeCombinationId  = 6001;				
		 site.prepayCodeCombination	= '397-00000-122101001-000-000000-0000';			
		 site.payGroupLookupCode	= 'ORIGINATION';				
		 site.paymentPriority	 = 99;					
		 site.termId	 = 10011;							
		 site.termName= 'Inmediato';								
		 site.payDateBasisLookupCode	= 'DUE';			
		 site.paymentCurrencyCode	= 'MXN';				
		 site.orgId	 = 223;							
		 site.organizationName = 'UO_397 HOLDING';						
		 site.allowAwtFlag = 'N';							
         site.awtGroupId	 = 123;						
         site.awtGroup = 'Pruebas';							    
		 site.primaryPaySiteFlag	= 'N';				
		 site.vatCode	= 'AP_IVA_16';							
         site.vatRegistrationNum	= 'SRE0602021Q6';				
         site.remittanceEmail	= 'remittanceEmail';					
		 site.offsetTaxFlag = 'Y';					
		 site.autoTaxCalcFlag	= 'Y';					
		 site.inactiveDate	= '4712-12-31';						
         site.areaCode = 'areaCode';								
         site.phone	= '123456789';							
		 site.purchasingSiteFlag	= 'Y';				
		 site.rfqOnlySiteFlag	= 'N';					
		 site.paySiteFlag	= 'Y';						
         site.emailAddress = '';							
		 site.partySiteId  = 126167;							
         site.partySiteName	= '';					
		 site.province = '';								
		 site.country	= 'MX';							
		 site.addressLine1 = 'MIGUEL ALEMAN';						
		 site.addressLine2 = '1000';						
         site.addressLine3	= 'LA TALAVERNA MODULO SOCIAL FOVISSSTE';						
		 site.addressLine4	= 'LA TALAVERNA MODULO SOCIAL FOVISSSTE';						
		 site.city	= 'GUADALUPE';								
		 site.state = 'NL';								
		 site.zip	= '66220';								
		 site.attributeCategory = 'TIPO DE PROVEEDOR';					
		 site.attribute1	= 'DIRECTOS';						
         site.attribute2 = 'pruebas1';							
         site.attribute3	= 'pruebas2';						
         site.attribute4	= 'pruebas3';						
         site.attribute5	= 'pruebas4';						
         site.attribute6	= 'pruebas5';						
         site.attribute7	= 'pruebas6';						
         site.attribute8	= 'pruebas7';						
         site.attribute9	= 'pruebas8';						
         site.attribute10	= 'pruebas9';						
         site.attribute11	= 'pruebas10';						
         site.attribute12	= 'pruebas11';						
         site.attribute13	= 'pruebas12';						
		 site.attribute14	= '300000008544454';						
         site.attribute15	= 'pruebas13';						
		 site.activeFlag	= 'Y';						
         site.defaultPaymentMethodCode = 'pruebas';			
         site.originalSso	= '';						
		 site.Accounts 	= new Takedown_Wrapper_DetSearchKnownSuppliers.Accounts();						
		 site.Contacts 	= new Takedown_Wrapper_DetSearchKnownSuppliers.Contacts();						
         site.Supplier  = new  Takedown_Wrapper_DetSearchKnownSuppliers.Supplier();						
        
    }
    
    
    @isTest static void accounts_Test(){
        Takedown_Wrapper_DetSearchKnownSuppliers.Accounts accounts = new Takedown_Wrapper_DetSearchKnownSuppliers.Accounts();
        accounts.account = new List<Takedown_Wrapper_DetSearchKnownSuppliers.Account>();
        
    }
    
    @isTest static void account_Test(){
        Takedown_Wrapper_DetSearchKnownSuppliers.Account account = new Takedown_Wrapper_DetSearchKnownSuppliers.Account();
         account.vendorId= 107190;								
		 account.vendorSiteId = 573556;							
         account.orgId	= 123;								
		 account.bankName= 'CITIBANAMEX';								
		 account.countryCode	= 'MX';						
		 account.bankNumber	= 'bankNumber';						
		 account.branchName	= 'branchName';						
		 account.branchType	= 'branchType';						
		 account.bankAccountId	= 123;						
		 account.branchId	= 123;							
		 account.bankId	= 123;								
		 account.acctOwnerPartyId	= 123;					
         account.bankAccountName = 123;							
		 account.bankAccountNum	= '002580000122560195';					
		 account.curency	= 'MXN';							
         account.accCountryCode	= 'accCountryCode';					
		 account.startDate	= '2018-10-29';						
		 account.endDate		= '4712-12-31';						
		 account.attributeCategory = 'BANCO INTERMEDIARIO';					
		 account.attribute1	= 'SWIFT';						
		 account.attribute2	= 'BNMXMXMM';						
         account.attribute3	= '';						
         account.attribute4	= '';						
         account.attribute5	= '';						
         account.attribute6	= '';						
         account.attribute7	= '';						
         account.attribute8	= '';						
         account.attribute9	= '';						
         account.attribute10	= '';						
         account.attribute11 = '';							
         account.attribute12	= '';						
         account.attribute13	= '';						
         account.attribute14	= '';						
         account.attribute15	= '';						
		 account.objectVersionNumber = 5;						
		 account.activeFlag	= 'Y';						
         account.originalSso	= '';						
         account.site 	= new Takedown_Wrapper_DetSearchKnownSuppliers.Site() ;								
        
    }
    
    @isTest static void contacts_Test(){
        Takedown_Wrapper_DetSearchKnownSuppliers.Contacts contacts = new Takedown_Wrapper_DetSearchKnownSuppliers.Contacts();
        contacts.contact = new List<Takedown_Wrapper_DetSearchKnownSuppliers.Contact>();                
    }
    
    @isTest static void contact_Test(){
        Takedown_Wrapper_DetSearchKnownSuppliers.Contact contact = new Takedown_Wrapper_DetSearchKnownSuppliers.Contact();
         contact.vendorId= 123;							
		 contact.vendorSiteId= 123;					
		 contact.vendorContactId= 123;						
         contact.orgId= 123;						        
		 contact.perPartyId= 123;							
	     contact.relationshipId	= 123;					
         contact.relationship = '';						    
		 contact.relPartyId	= 123;						
		 contact.partySiteId = 123;							
		 contact.orgContactId= 123;						
		 contact.orgPartySiteId = 123;						
		 contact.personFirstName	= 'Pruebas';					
         contact.personMiddleName = 'MiddPruebas';						
		 contact.personLastName = 'LastPruebas';						
         contact.personTitle	= 'personTitle';						
		 contact.inactiveDate = '';							
         contact.department	= 'department';						
		 contact.areaCode= 'areaCode';								
		 contact.phone	= '123456789';							
		 contact.emailAddress = 'emailAddress';							
         contact.attributeCategory = 'attributeCategory';				
         contact.attribute1	= 'pruebas1';						
         contact.attribute2	= 'pruebas2';						
         contact.attribute3	= 'pruebas3';						
         contact.attribute4	= 'pruebas4';						
         contact.attribute5	= 'pruebas5';						
         contact.attribute6	= 'pruebas6';						
         contact.attribute7	= 'pruebas7';						
         contact.attribute8	= 'pruebas8';						
         contact.attribute9	= 'pruebas9';						
         contact.attribute10	= 'pruebas10';						
         contact.attribute11	= 'pruebas11';						
         contact.attribute12	= 'pruebas12';						
         contact.attribute13	= 'pruebas13';						
         contact.attribute14	= 'pruebas14';						
         contact.attribute15	= 'pruebas15';						
		 contact.activeFlag	= 'Y';						
         contact.originalSso	= 'SSO';						
         contact.site = new Takedown_Wrapper_DetSearchKnownSuppliers.Site();									                
    }
    
    @isTest static void status_Test(){
        Takedown_Wrapper_DetSearchKnownSuppliers.Status status = new Takedown_Wrapper_DetSearchKnownSuppliers.Status();
        status.code='Code';
        status.detail='S';
        status.message='Success';
    }
  

}