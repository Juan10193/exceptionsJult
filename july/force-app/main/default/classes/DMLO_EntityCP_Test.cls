@Istest
private class DMLO_EntityCP_Test {
    //mexican , organization, suppiler true,customerStatus N
    @istest
    public static  EM_Wrapper_Entity.EntityMain getwrapperTestMexican(){
        EM_Wrapper_Entity.Status entityWrapperStatus = new EM_Wrapper_Entity.Status();
        entityWrapperStatus.code = 'Y';
        entityWrapperStatus.message ='S';
        
        EM_Wrapper_Entity.Invoice invoice = new EM_Wrapper_Entity.Invoice();
        invoice.billingMails ='juand_10193@hotmail.com';
        invoice.custAcctSiteId =12312;
        invoice.ecClabe = 'abc123';
        invoice.ecOperatingUnitId = 122;
        invoice.ecOperatingUnitName ='OP UNIT';
        invoice.ecPaymentAccount = 'Payment account';
        invoice.paymentMethod ='TDD';
        invoice.sourceApplicationId ='SF';
        invoice.sourceCreateDate ='12/12/2019';
        invoice.sourceCreatedBy = 'CHUCHO MARTINEZ';
        invoice.sourceLastUpdateDate ='12/12/2019';
        invoice.sourceUpdatedBy = 'Ebenezer';
        
        EM_Wrapper_Entity.Invoices invoices = new  EM_Wrapper_Entity.Invoices();
        list< EM_Wrapper_Entity.Invoice>invoiceList = new list< EM_Wrapper_Entity.Invoice>();
        invoiceList.add(invoice);
        invoices.invoice = invoiceList;
        EM_Wrapper_Entity.Privilege privilege = new EM_Wrapper_Entity.Privilege();
        privilege.applicationCode = 'SF';
        privilege.applicationName ='EntityMaster';
        privilege.employeeName ='Evelio';
        privilege.screen ='UI';
        privilege.sso = '100193';
        privilege.vCrud ='1';
        
        EM_Wrapper_Entity.InvoiceInfo invoiceInfo = new EM_Wrapper_Entity.InvoiceInfo();
        invoiceInfo.invoices = invoices;
        invoiceInfo.privilege = privilege;
        
        EM_Wrapper_Entity.Address address = new EM_Wrapper_Entity.Address();
        address.addressReference ='reference';
        address.city ='DF';
        address.country ='MEX';
        address.county ='county';
        address.interiorNumber ='01';
        address.locationId =123;
        address.municipality ='DF';
        address.normalizedAddress ='Normalized';
        address.outdoorNumber ='12';
        address.partyID =1231;
        address.r89 = 'el erre';
        address.r97 ='97';
        address.s1u ='su1';
        address.sourceApplicationId ='SF';
        address.sourceCreateDate ='12/12/2019';
        address.sourceCreatedBy ='Rosalia';
        address.sourceLastUpdateDate = '12/12/2019';
        address.sourceUpdatedBy ='Rosalia';
        address.state ='DF';
        address.status ='Y';
        address.street ='Street';
        address.xa7 ='xa7';
        address.zipCode ='01230';
        address.purpose ='BILL_TO, SHIP_TO, INSTALL_AT';
        
        EM_Wrapper_Entity.Addresses addresses = new  EM_Wrapper_Entity.Addresses();
        list<EM_Wrapper_Entity.Address> addressList = new list<EM_Wrapper_Entity.Address>();
        addressList.add(address);
        addresses.address = addressList;
        
        EM_Wrapper_Entity.AddressInfo addressInfo = new EM_Wrapper_Entity.AddressInfo();
        addressInfo.addresses = addresses;
        addressInfo.privilege = privilege;
        
        EM_Wrapper_Entity.Contact contact = new EM_Wrapper_Entity.Contact();
        contact.contactId = 123;
        contact.partyID = 123;
        contact.prefix = 'MR.';
        contact.firstName ='MORTHEN';
        contact.middleName ='LILIA';
        contact.firstLastName = 'firstname';
        contact.secondLastName = '24';
        contact.title = 'Title';
        contact.status ='status';
        contact.countryCode ='39';
        contact.areaCode ='12';
        contact.phone ='12';
        contact.phoneNumberExtension ='12';
        contact.mobile ='121';
        contact.email ='exmaple@gmail.com';
        contact.rtype = 'BILLING';
        contact.sourceCreatedBy = '502718854';
        contact.sourceUpdatedBy = '900000023';
        contact.sourceApplicationId ='SALESF FORCE';
        contact.sourceCreateDate ='2019-11-24T00:00:00.000-06:00';
        contact.sourceLastUpdateDate ='2019-11-24T00:00:00.000-06:00';
        
        EM_Wrapper_Entity.Contacts contacts = new EM_Wrapper_Entity.Contacts();
        list<EM_Wrapper_Entity.Contact> contactList = new list<EM_Wrapper_Entity.Contact>();
        contactList.add(contact);
        contacts.contact = contactList;
        EM_Wrapper_Entity.ContactInfo contactInfo = new EM_Wrapper_Entity.ContactInfo();
        contactInfo.contacts = contacts;
        contactInfo.privilege = privilege;
        
        EM_Wrapper_Entity.Buro buro = new EM_Wrapper_Entity.Buro();
        buro.buroFlag ='Y';
        buro.customerAlias ='Alias';
        
        EM_Wrapper_Entity.Sic sic = new EM_Wrapper_Entity.Sic();
        sic.economicGroupSicCode ='122';
        sic.economicGroupSicDescription ='description';
        sic.sicCode ='1111';
        sic.sicDescription ='sicDescription';
        
        EM_Wrapper_Entity.Rating rating = new EM_Wrapper_Entity.Rating();
        rating.bloombergId ='1231';
        rating.hnwiId ='1231';
        rating.mraId ='1231';
        rating.orRating ='1231';
        rating.riskClassification ='clasification';
        rating.transactionDate ='12/12/2019';
        
        EM_Wrapper_Entity.Aml aml = new EM_Wrapper_Entity.Aml();
        aml.ccr ='crr';
        aml.ccrOverride='crroverride';
        aml.crrComments ='comments';
        aml.entityType ='type';
        aml.targetMarketJurisdiction='tarjet';
        
        EM_Wrapper_Entity.Entity entity = new EM_Wrapper_Entity.Entity();
        entity.aml = aml;
        entity.buro = buro;
        entity.companyLegalNameTermination ='SA';
        entity.curp ='curp';
        entity.custAccountId ='123';
        entity.customerStatus ='Y';
        entity.customerType ='ORGANIZACION';
        entity.economicGroupId ='123';
        entity.economicGroupName ='Economi';
        entity.firstLastName ='First';
        entity.firstName ='Firstname';
        entity.foreignEntity =false;
        entity.legalName ='legal Name';
        entity.limitedInformationEntity =false;
        entity.middleName ='middle';
        entity.nationality ='MEX';
        entity.oracleAccountName ='Ora Name';
        entity.oracleAccountNumber ='123';
        entity.partyID =123;
        entity.prefix = 'prefix';
        entity.rating = rating;
        entity.rfc ='rfc';
        entity.salesRepresentative ='sales rep';
        entity.secondLastName ='second last';
        account acc = new account();
        acc.Name ='Name';
        acc.ACC_ls_Country__c ='MEX';
        acc.BillingCountry ='México';
        acc.BillingCountryCode ='MX';
        acc.BillingState ='Ciudad de México';
        acc.BillingCity ='CMX';
        acc.BillingPostalCode ='01230';
        acc.BillingStreet ='street';
        insert acc;
        entity.sFaccountID =acc.Id;
        entity.sfAccountName ='Name';
        entity.sic =sic;
        entity.sourceApplicationID ='Sales Force';
        entity.sourceCreateDate ='12/12/2019';
        entity.sourceCreatedBy ='chucho';
        entity.sourceLastUpdateDate ='12/12/2019';
        entity.sourceUpdatedBy ='chcucho';
        entity.supplierFlag =true;
        entity.taxRegime ='regime';
        entity.tin ='1231';
        entity.topParentId ='1231';
        entity.topParentName ='Topparten';
        
        EM_Wrapper_Entity.EntityInfo  entityInfo = new EM_Wrapper_Entity.EntityInfo();
        entityInfo.addressInfo = addressInfo;
        entityInfo.contactInfo =contactInfo;
        entityInfo.entity = entity;
        entityInfo.invoiceInfo = invoiceInfo;
        entityInfo.privilege = privilege;
        
        EM_Wrapper_Entity.EntityMain main = new EM_Wrapper_Entity.EntityMain();
        main.entityInfo = entityInfo;
        main.status = entityWrapperStatus;
        return main;
    }
    
    
    //foreing , individual, suppiler false,customerStatus Y
    @istest
    public static  EM_Wrapper_Entity.EntityMain getwrapperTestForeing(){
        EM_Wrapper_Entity.Status entityWrapperStatus = new EM_Wrapper_Entity.Status();
        entityWrapperStatus.code = 'Y';
        entityWrapperStatus.message ='S';
        
        EM_Wrapper_Entity.Invoice invoice = new EM_Wrapper_Entity.Invoice();
        invoice.billingMails ='juand_10193@hotmail.com';
        invoice.custAcctSiteId =12312;
        invoice.ecClabe = 'abc123';
        invoice.ecOperatingUnitId = 122;
        invoice.ecOperatingUnitName ='OP UNIT';
        invoice.ecPaymentAccount = 'Payment account';
        invoice.paymentMethod ='TDD';
        invoice.sourceApplicationId ='SF';
        invoice.sourceCreateDate ='12/12/2019';
        invoice.sourceCreatedBy = 'CHUCHO MARTINEZ';
        invoice.sourceLastUpdateDate ='12/12/2019';
        invoice.sourceUpdatedBy = 'Ebenezer';
        
        EM_Wrapper_Entity.Invoices invoices = new  EM_Wrapper_Entity.Invoices();
        list< EM_Wrapper_Entity.Invoice>invoiceList = new list< EM_Wrapper_Entity.Invoice>();
        invoiceList.add(invoice);
        invoices.invoice = invoiceList;
        EM_Wrapper_Entity.Privilege privilege = new EM_Wrapper_Entity.Privilege();
        privilege.applicationCode = 'SF';
        privilege.applicationName ='EntityMaster';
        privilege.employeeName ='Evelio';
        privilege.screen ='UI';
        privilege.sso = '100193';
        privilege.vCrud ='1';
        
        EM_Wrapper_Entity.InvoiceInfo invoiceInfo = new EM_Wrapper_Entity.InvoiceInfo();
        invoiceInfo.invoices = invoices;
        invoiceInfo.privilege = privilege;
        
        EM_Wrapper_Entity.Address address = new EM_Wrapper_Entity.Address();
        address.addressReference ='reference';
        address.city ='DF';
        address.country ='MEX';
        address.county ='county';
        address.interiorNumber ='01';
        address.locationId =123;
        address.municipality ='DF';
        address.normalizedAddress ='Normalized';
        address.outdoorNumber ='12';
        address.partyID =1231;
        address.r89 = 'el erre';
        address.r97 ='97';
        address.s1u ='su1';
        address.sourceApplicationId ='SF';
        address.sourceCreateDate ='12/12/2019';
        address.sourceCreatedBy ='Rosalia';
        address.sourceLastUpdateDate = '12/12/2019';
        address.sourceUpdatedBy ='Rosalia';
        address.state ='DF';
        address.status ='Y';
        address.street ='Street';
        address.xa7 ='xa7';
        address.zipCode ='01230';
        address.purpose ='BILL_TO, SHIP_TO, INSTALL_AT';
        
        EM_Wrapper_Entity.Addresses addresses = new  EM_Wrapper_Entity.Addresses();
        list<EM_Wrapper_Entity.Address> addressList = new list<EM_Wrapper_Entity.Address>();
        addressList.add(address);
        addresses.address = addressList;
        
        EM_Wrapper_Entity.AddressInfo addressInfo = new EM_Wrapper_Entity.AddressInfo();
        addressInfo.addresses = addresses;
        addressInfo.privilege = privilege;
        
        EM_Wrapper_Entity.Contact contact = new EM_Wrapper_Entity.Contact();
        contact.contactId = 123;
        contact.partyID = 123;
        contact.prefix = 'MR.';
        contact.firstName ='MORTHEN';
        contact.middleName ='LILIA';
        contact.firstLastName = 'firstname';
        contact.secondLastName = '24';
        contact.title = 'Title';
        contact.status ='status';
        contact.countryCode ='39';
        contact.areaCode ='12';
        contact.phone ='12';
        contact.phoneNumberExtension ='12';
        contact.mobile ='121';
        contact.email ='exmaple@gmail.com';
        contact.rtype = 'BILLING';
        contact.sourceCreatedBy = '502718854';
        contact.sourceUpdatedBy = '900000023';
        contact.sourceApplicationId ='SALESF FORCE';
        contact.sourceCreateDate ='2019-11-24T00:00:00.000-06:00';
        contact.sourceLastUpdateDate ='2019-11-24T00:00:00.000-06:00';
        
        EM_Wrapper_Entity.Contacts contacts = new EM_Wrapper_Entity.Contacts();
        list<EM_Wrapper_Entity.Contact> contactList = new list<EM_Wrapper_Entity.Contact>();
        contactList.add(contact);
        contacts.contact = contactList;
        EM_Wrapper_Entity.ContactInfo contactInfo = new EM_Wrapper_Entity.ContactInfo();
        contactInfo.contacts = contacts;
        contactInfo.privilege = privilege;
        
        EM_Wrapper_Entity.Buro buro = new EM_Wrapper_Entity.Buro();
        buro.buroFlag ='Y';
        buro.customerAlias ='Alias';
        
        EM_Wrapper_Entity.Sic sic = new EM_Wrapper_Entity.Sic();
        sic.economicGroupSicCode ='122';
        sic.economicGroupSicDescription ='description';
        sic.sicCode ='1111';
        sic.sicDescription ='sicDescription';
        
        EM_Wrapper_Entity.Rating rating = new EM_Wrapper_Entity.Rating();
        rating.bloombergId ='1231';
        rating.hnwiId ='1231';
        rating.mraId ='1231';
        rating.orRating ='1231';
        rating.riskClassification ='clasification';
        rating.transactionDate ='12/12/2019';
        
        EM_Wrapper_Entity.Aml aml = new EM_Wrapper_Entity.Aml();
        aml.ccr ='crr';
        aml.ccrOverride='crroverride';
        aml.crrComments ='comments';
        aml.entityType ='type';
        aml.targetMarketJurisdiction='tarjet';
        
        EM_Wrapper_Entity.Entity entity = new EM_Wrapper_Entity.Entity();
        entity.aml = aml;
        entity.buro = buro;
        entity.companyLegalNameTermination ='SA';
        entity.curp ='curp';
        entity.custAccountId ='123';
        entity.customerStatus ='YES';
        entity.customerType ='INDIVIDUAL';
        entity.economicGroupId ='123';
        entity.economicGroupName ='Economi';
        entity.firstLastName ='First';
        entity.firstName ='Firstname';
        entity.foreignEntity =true;
        entity.legalName ='legal Name';
        entity.limitedInformationEntity =false;
        entity.middleName ='middle';
        entity.nationality ='CAN';
        entity.oracleAccountName ='Ora Name';
        entity.oracleAccountNumber ='123';
        entity.partyID =123;
        entity.prefix = 'prefix';
        entity.rating = rating;
        entity.rfc ='rfc';
        entity.salesRepresentative ='sales rep';
        entity.secondLastName ='second last';
        account acc = new account();
        acc.Name ='Name';
        acc.ACC_ls_Country__c ='MEX';
        acc.BillingCountry ='México';
        acc.BillingCountryCode ='MX';
        acc.BillingState ='Ciudad de México';
        acc.BillingCity ='CMX';
        acc.BillingPostalCode ='01230';
        acc.BillingStreet ='street';
        insert acc;
        entity.sFaccountID =acc.Id;
        entity.sfAccountName ='Name';
        entity.sic =sic;
        entity.sourceApplicationID ='Sales Force';
        entity.sourceCreateDate ='12/12/2019';
        entity.sourceCreatedBy ='chucho';
        entity.sourceLastUpdateDate ='12/12/2019';
        entity.sourceUpdatedBy ='chcucho';
        entity.supplierFlag =false;
        entity.taxRegime ='regime';
        entity.tin ='1231';
        entity.topParentId ='1231';
        entity.topParentName ='Topparten';
        
        EM_Wrapper_Entity.EntityInfo  entityInfo = new EM_Wrapper_Entity.EntityInfo();
        entityInfo.addressInfo = addressInfo;
        entityInfo.contactInfo =contactInfo;
        entityInfo.entity = entity;
        entityInfo.invoiceInfo = invoiceInfo;
        entityInfo.privilege = privilege;
        
        EM_Wrapper_Entity.EntityMain main = new EM_Wrapper_Entity.EntityMain();
        main.entityInfo = entityInfo;
        main.status = entityWrapperStatus;
        return main;
    }
    
    @Istest
    static void createEntitycpFromEntityMTest(){
        EM_Wrapper_Entity.EntityMain entityMaster = new  EM_Wrapper_Entity.EntityMain();
        entityMaster = getwrapperTestMexican();
        DMLO_EntityCP.createEntitycpFromEntityM(entityMaster);
    }
    
    
    @Istest
    static void createEntitycpFromEntityMForeingTest(){
        EM_Wrapper_Entity.EntityMain entityMaster = new  EM_Wrapper_Entity.EntityMain();
        entityMaster = getwrapperTestForeing();
        DMLO_EntityCP.createEntitycpFromEntityM(entityMaster);
    }
    
    @Istest
    static void upsertEntitycpFromEntityMTest(){
        EM_Wrapper_Entity.EntityMain entityMaster = new  EM_Wrapper_Entity.EntityMain();
        entityMaster = getwrapperTestMexican();
        Entity_CP__c entityCP = Data_Factory_EntityCp.createEntityCP('SALADITAS', 'rfc');
        DMLO_EntityCP.upsertEntitycpFromEntityM(entityMaster, entityCP, false);
    }
    
      @Istest
    static void upsertEntitycpFromEntityMForeingTest(){
        EM_Wrapper_Entity.EntityMain entityMaster = new  EM_Wrapper_Entity.EntityMain();
        entityMaster = getwrapperTestForeing();
        Entity_CP__c entityCP = Data_Factory_EntityCp.createEntityCP('SALADITAS', 'tin');
        DMLO_EntityCP.upsertEntitycpFromEntityM(entityMaster, entityCP, false);
    }
}