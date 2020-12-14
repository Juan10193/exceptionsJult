@isTest
private class EIV_EntityExtendClassBisTest {
    @isTest static void setTestBis(){
        ApexPages.currentPage().getParameters().put('AccountId','374');
        ApexPages.currentPage().getParameters().put('AccountName','una cuenta');
        ApexPages.currentPage().getParameters().put('TopParentID','test');
        ApexPages.currentPage().getParameters().put('TopParentName','1233455566');
        ApexPages.currentPage().getParameters().put('PartyId','una cuenta');
        ApexPages.currentPage().getParameters().put('CustomerType','test');
        ApexPages.currentPage().getParameters().put('TargetMarket','test');
        
        EIV_Parameter__c p = new EIV_Parameter__c();
        p.EIV_tx_parameter__c = 'name';
        p.Name='URL_Servicio';
        insert p;
        
        
        TBO002_SIC_code__c sic01 = new TBO002_SIC_code__c();
        sic01.Name = '59584589568';
        sic01.TBO002_tx_SIC_industry_description__c = 'Description';
        insert sic01;
        
        TBO002_SIC_code__c sic02 = new TBO002_SIC_code__c();
        sic02.Name = '6939';
        sic02.TBO002_tx_SIC_industry_description__c = 'Description';
        insert sic02;
        
        TBO002_SIC_code__c sic = new TBO002_SIC_code__c();
        sic.Name = '999';
        sic.TBO002_tx_SIC_industry_description__c = 'Description';
        insert sic;
        sic.id = [Select id from TBO002_SIC_code__c where name =:'999'][0].id;
        
        EIV_PostalCodeCatalog__c postal = new EIV_PostalCodeCatalog__c();
        postal.Name = 'CP 99999 AGUASCALIENTES';
        postal.EIV_tx_Codigo_Estado__c = '99';
        postal.EIV_tx_Codigo_Pais__c = '1';
        postal.EIV_tx_Postal_Code__c = '99999';
        postal.EVI_tx_Estado_Nombre__c = 'AGUASCALIENTES';
        insert postal;

        
        EIV_EntityExtendClassBis testEntity = new EIV_EntityExtendClassBis();
        
        
        testEntity.setCodeId(sic.id);
        testEntity.getSicCodeId('999');
        testEntity.setPostalCode(postal.id);        
        testEntity.zipCodeForMex('AGD', '99999');
        testEntity.zipCodeForMex('MEX', '99999');
        testEntity.stateForMex('AGD', '99999');
        testEntity.stateForMex('MEX', '99999');
        testEntity.sAccountId='123456789012345678';
        testEntity.sTopParentId='123456789012345678';
        testEntity.SaveEntity();
        testEntity.getCodeId();
        testEntity.getSicCodeDescriptionEntitie();
        testEntity.getSicCodeDescriptionEG();
        testEntity.getPostalCode('99999');
        testEntity.getPostalCode();
        testEntity.Cancel();
        testEntity.NewEntity();
        testEntity.EditEntity();
        testEntity.sIdChild = '6939';
        testEntity.viewAddress();
        testEntity.editAddress();
        testEntity.saveAddress();
        testEntity.sIdChild = '32740';
        testEntity.viewInvoicing();
        testEntity.editInvoicing();
        testEntity.saveInvoicing();
        testEntity.sIdChild = '78438';
        testEntity.viewContact();
        testEntity.editContact();
        testEntity.saveContact();
        testEntity.newAddress();
        testEntity.newContact();
        testEntity.getEGOptions();
        testEntity.newInvoicing();
        testEntity.vfTypeEntitieRead('INDIVIDUAL');
        testEntity.vfTypeEntitieRead('ee');
        testEntity.vfTypeEntitieRead('ORGANIZATION');
        testEntity.vfTypeEntitieEdit('INDIVIDUAL');
        testEntity.vfTypeEntitieEdit('ee');
        testEntity.vfTypeEntitieEdit('ORGANIZATION');
        testEntity.getsEconomicGroupIdSelected();
        testEntity.setsEconomicGroupIdSelected(testEntity.sEconomicGroupIdSelected = null);
        testEntity.getCustomerName('INDIVIDUAL');
        testEntity.getCustomerName('ee');
        testEntity.getCustomerName('ORGANIZATION');
        
        testEntity.sAccountId = '123';
        testEntity.sAccountName='lol';
        testEntity.sTopParentId='123';
        testEntity.sTopParentName='lol';
        testEntity.sPartyId='123';
        
        testEntity.sCustomerType= 'ORGANIZATION';
        testEntity.sTargetMarket='123';
        testEntity.sServiceURL='http://160.34.7.97:7033';
        testEntity.newInvoicing();
        
        
    }
    
    @isTest static void setTestBis2(){
        ApexPages.currentPage().getParameters().put('AccountId','374');
        ApexPages.currentPage().getParameters().put('AccountName','una cuenta');
        ApexPages.currentPage().getParameters().put('TopParentID','');
        ApexPages.currentPage().getParameters().put('TopParentName','1233455566');
        ApexPages.currentPage().getParameters().put('PartyId','unauenta');
        ApexPages.currentPage().getParameters().put('CustomerType','Organi');
        ApexPages.currentPage().getParameters().put('TargetMarket','test');
        
        EIV_Parameter__c p = new EIV_Parameter__c();
        p.EIV_tx_parameter__c = 'name';
        p.Name='URL_Servicio';
        insert p;
        
        
        TBO002_SIC_code__c sic = new TBO002_SIC_code__c();
        sic.Name = '999';
        sic.TBO002_tx_SIC_industry_description__c = 'Description';
        insert sic;
        sic.id = [Select id from TBO002_SIC_code__c where name =:'999'][0].id;
        
        TBO002_SIC_code__c sic01 = new TBO002_SIC_code__c();
        sic01.Name = '59584589568';
        sic01.TBO002_tx_SIC_industry_description__c = 'Description';
        insert sic01;
        
        TBO002_SIC_code__c sic02 = new TBO002_SIC_code__c();
        sic02.Name = '6939';
        sic02.TBO002_tx_SIC_industry_description__c = 'Description';
        insert sic02;
        
        EIV_PostalCodeCatalog__c postal = new EIV_PostalCodeCatalog__c();
        postal.Name = 'CP 99999 AGUASCALIENTES';
        postal.EIV_tx_Codigo_Estado__c = '99';
        postal.EIV_tx_Codigo_Pais__c = '1';
        postal.EIV_tx_Postal_Code__c = '99999';
        postal.EVI_tx_Estado_Nombre__c = 'AGUASCALIENTES';
        insert postal;
        
        EIV_EntityExtendClassBis testEntity = new EIV_EntityExtendClassBis();
        
        testEntity.NewAML();
        testEntity.NewDocument();
        testEntity.NewComment();
        testEntity.NewNDA();
        testEntity.newKYCPF();
        testEntity.newKYCPM();
        testEntity.getdummyRequest();
        
        testEntity.newInvoicing();
        testEntity.cloneInvoicing();
        
        
        testEntity.getsEconomicGroupIdSelected();
        testEntity.getEntitiesFromEconomicGroup();
        testEntity.getCodeId();
        testEntity.getCAsInEntity();
        testEntity.getDocumentListForEntity();
        testEntity.getAuditListForEntity();
        testEntity.setsEconomicGroupIdSelected('s');
        
    }
    
    @isTest static void Call_With_Null_Data(){
        ApexPages.currentPage().getParameters().put('AccountId','374');
        ApexPages.currentPage().getParameters().put('AccountName','una cuenta');
        ApexPages.currentPage().getParameters().put('TopParentID','');
        ApexPages.currentPage().getParameters().put('TopParentName','1233455566');
        ApexPages.currentPage().getParameters().put('PartyId','');
        ApexPages.currentPage().getParameters().put('CustomerType','Individual');
        ApexPages.currentPage().getParameters().put('TargetMarket','test');
        EIV_EntityExtendClassBis bis = new EIV_EntityExtendClassBis();
        bis.settopParentSelected(null);
        
        
    }
    @isTest static void Call_With_Null_DataV2(){
        PageReference pageRef = Page.EIV_EntityReadPageIndividual;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('AccountId','374');
        ApexPages.currentPage().getParameters().put('AccountName','una cuenta');
        ApexPages.currentPage().getParameters().put('TopParentID','1233455566');
        ApexPages.currentPage().getParameters().put('TopParentName','1233455566');
        ApexPages.currentPage().getParameters().put('PartyId','');
        ApexPages.currentPage().getParameters().put('CustomerType','Organi');
        ApexPages.currentPage().getParameters().put('TargetMarket','test');
        EIV_EntityExtendClassBis bis = new EIV_EntityExtendClassBis();
        bis.settopParentSelected(null);    
        ApexPages.currentPage().getParameters().put('CustomerType','');
        bis = new EIV_EntityExtendClassBis();
        List<EIV_AddressWrapClass> LAddress = new List<EIV_AddressWrapClass>();
        LAddress.add(getAddressList());
        LAddress.add(getAddressList());
        bis.addressList = LAddress;
        bis.addressObj = getAddressList();
        bis.NewLA();
        bis.rfcotin();
        bis.NewLAPM();
        bis.NewLAPF();
        bis.NewEVAL();
        bis.newCreditBureau();
        bis.cloneAddress();
        bis.cloneContact();
        bis.backToEntity();
        bis.viewAML();
        bis.viewCRBUREAU();
        bis.yesNoToStringBoolean('NO');
        bis.booleanToString(false);
        bis.booleanToYesNo(true);
        bis.deleteDocument();
        EIV_EntityExtendClassBis.downloadDoctos('docId','PartyId','AccountId','AccountName','topParentId','topParentName' );
    }
    
    @isTest static EIV_AddressWrapClass getAddressList(){
        EIV_AddressWrapClass Test_AddressList = new EIV_AddressWrapClass();        
        datetime Test_DateTime = datetime.now();

        Test_AddressList.Location_ID = 'Test1';
        Test_AddressList.Street = 'Test2';
        Test_AddressList.Outdoor_Number = 'Test3';
        Test_AddressList.Interior_Number = 'Test4';
        Test_AddressList.County = 'Test5';
        Test_AddressList.Municipality = 'Test6';
        Test_AddressList.Country = 'Test7';
        Test_AddressList.City = 'Test8';
        Test_AddressList.Zip_Code = 'Test9';
        Test_AddressList.State = 'Test10';
        Test_AddressList.Status = 'Test11';
        Test_AddressList.Purpose = 'Test12';
        Test_AddressList.party_ID = 'Test13';
        Test_AddressList.Source_Created_by = 'Test14';
        Test_AddressList.Source_Updated_by = 'Test15';
        Test_AddressList.Source_Application_ID = 'Test16';
        Test_AddressList.Source_Create_Date = Test_DateTime;
        Test_AddressList.Source_Last_Update_Date = Test_DateTime;
        Test_AddressList.Oracle_Created_by = 'Test17';
        Test_AddressList.Oracle_Updated_by = 'Test18';
        Test_AddressList.Oracle_Create_Date = Test_DateTime;
        Test_AddressList.Oracle_Last_Update_Date = Test_DateTime;
        Test_AddressList.PostalCodeId = 'Test19';
        Test_AddressList.EntityPartyId = 'Test20';
        Test_AddressList.s_397 = 'Test21';
        Test_AddressList.s_789 = 'Test22';
        Test_AddressList.xa7 = 'Test23';
        Test_AddressList.s1u = 'Test24';
        Test_AddressList.addressReference = 'Test25';
        Test_AddressList.addressLinesPhonetic = 'Test26';
        Test_AddressList.normalizedAddress = 'Test27';
        
            
        
        return Test_AddressList;
    }
    
    
    
    
    
}