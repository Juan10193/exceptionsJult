@istest private class EIV_EntitiesSearchClassTest {
    @testSetup static void Test_Setup() {
        EIV_Parameter__c paramether = new  EIV_Parameter__c();
        paramether.EIV_tx_parameter__c = 'Name';
        paramether.Name='URL_Servicio';
        insert paramether;

    }
    
    @istest static void test_to(){
        Map<String, Object> m = 
            (Map<String, Object>)
            JSON.deserializeUntyped(entityToJson());
        
        
        
        EIV_DetailWrapClass d = new EIV_DetailWrapClass();
        EIV_EntitiesSearchClass r = new EIV_EntitiesSearchClass();
        
        r.detail = d;
        d.message = 'S';
        r.responseToEntityObj(m);
        r.sAccountId='';
        r.searchEntity= false;
        r.searchString='hbgvf';
        r.sSSO='55455645';
        r.sServiceURL='122.1665.44.33/';
        r.sTopParentId='';
        r.vfTypeEntitieRead('Individual');
        r.vfTypeEntitieEdit('Individual');
        r.booleanToString(true);
        r.getListEntities('3434','hngfv');
        r.searchEntity();
        r.responseToEntityObj(m);
        r.searchRequestId='';
        r.searchRootRequestId                 = '1234';
        r.searchRequestType                   = 'Pend';
        r.searchSourceAccountId               = '6542';
        r.searchSourceTopParentId             = '%245';
        r.searchSourceTopParentName           = 'Homia';
        r.searchPartyId                       = '2345';
        r.searchPartyName                     = '';
        r.searchEgPartyId                     = '';
        r.searchEgPartyName                   = '';
        r.searchSourceOpId                    = '';
        r.searchSourceCAId                    = '';
        r.searchStartDate                     = '';
        r.searchEndDate                       = '';
        r.searchRequestStatus                 = '';
        r.searchCreatedBy                     = '';
        r.searchRequestedBy                   = '';
        r.searchAssignedGroup                 = '';
        r.searchAssignedTo                    = '';
        r.searchAssignedDate                  = '';
        r.searchCreationDate                  = '';
        r.searchUpdatedBy                     = '';
        r.searchLastUpdateDate                = '';
        r.searchSolvedBy                      = '';
        r.searchSolvedDate                    = '';
        r.searchSourceApplication             = '';
        r.searchFinantialEntity               = '';
        
        r.searchRequest();
    }
    @istest
    static void test_to_no(){
        EIV_Parameter__c paramether = new  EIV_Parameter__c();
        paramether.EIV_tx_parameter__c = 'Name';
        paramether.Name='URL_Servicio';
        insert paramether;
        Map<String, Object> m = 
            (Map<String, Object>)
            JSON.deserializeUntyped(entityToJson());
        
        EIV_DetailWrapClass d = new EIV_DetailWrapClass();
        EIV_EntitiesSearchClass r = new EIV_EntitiesSearchClass();
        r.detail = d;
        d.message = 'S';
        r.sAccountId='454';
        r.sAccountName='goje';
        r.searchEntity= false;
        r.searchString='hbgvf';
        r.sSSO='55455645';
        r.sServiceURL='http//:www.google.com/';
        r.sTopParentId='4554';
        r.sTopParentName='trtrds';
        r.vfTypeEntitieRead('Organization');
        r.vfTypeEntitieEdit('Organization');
        r.booleanToString(false);
        r.getListEntities('3434','hngfv'); 
        r.responseToEntityObj(m);
        r.requestList        = null;
        r.documentList       = null;
        r.comentList         = null;
    }
    @istest
    static void test_to_nop(){
        Map<String, Object> m = 
            (Map<String, Object>)
            JSON.deserializeUntyped(entityToJson());
        
        EIV_EntitiesSearchClass r = new EIV_EntitiesSearchClass();
        r.sAccountId = '';
        r.sAccountName='';
        r.searchEntity= false;
        r.sSSO='55455645';
        r.sServiceURL='http//:www.google.com/';
        r.sTopParentId='NHGBFV';
        r.sTopParentName='pancho';
        r.vfTypeEntitieRead('EconomicGroup');
        r.vfTypeEntitieEdit('EconomicGroup');
        r.booleanToString(false);
        r.getListEntities('3434','hngfv');
        r.responseToEntityObj(m);
    }
    static String entityToJson()
    {
        JSONGenerator gen = JSON.createGenerator(true);    
        gen.writeStartObject();      
        gen.writeFieldName('entity');
        gen.writeStartObject();
        gen.writeStringField('sFaccountID' , '344545');
        gen.writeStringField('entityName' , ''); //Se enviara siempre vacio
        gen.writeStringField('entityType' , ''); //Se enviara siempre vacio
        gen.writeStringField('custAccountId' , ''); //Se enviara siempre vacio
        gen.writeStringField('partyID' ,'544343');
        gen.writeStringField('rfc' , '565656546');
        gen.writeStringField('economicGroupPartyId' , ''); //Se enviara siempre vacio
        gen.writeStringField('customerName' , ''); //Se enviara siempre vacio
        gen.writeStringField('oracleAccountName' , 'hnbbgh');
        gen.writeStringField('customerType' , 'nnghgh');
        gen.writeStringField('customerStatus' , ''); //Se enviara siempre vacio
        gen.writeStringField('topParentId' , '5344');
        gen.writeStringField('topParentName' , 'hngfbvdc');
        gen.writeStringField('sfAccountName' , 'hnbgvfc');
        gen.writeStringField('tin' , 'yes');
        //gen.writeStringField('tin' , nullToVoid(this.entity.TIN));
        gen.writeStringField('economicGroupId' , '4545');
        gen.writeStringField('economicGroupName' , 'hngbvf');
        gen.writeBooleanField('limitedInformationEntity' , true);
        gen.writeStringField('taxRegime' , 'jmnh');
        gen.writeStringField('foreignEntity' , 'yes');
        gen.writeStringField('nationality' , 'mexican');
        gen.writeStringField('oracleAccountNumber' , ''); //Se enviara siempre vacio
        gen.writeStringField('curp' , 'jdll1234356');
        gen.writeStringField('prefix' , 'lghglk');
        gen.writeStringField('firstName' , 'jhnbjmhn');
        gen.writeStringField('middleName' , 'ukyhkgl');
        gen.writeStringField('firstLastName' , 'mnbvkmjnhbg');
        gen.writeStringField('secondLastName' , 'kjhngbfgf');
        gen.writeStringField('salesRepresentative' , ''); //Se enviara siempre vacio
        gen.writeStringField('supplierFlag' , 'jkfkjgkjf');
        gen.writeStringField('legalName' , 'organization');
        gen.writeStringField('companyLegalNameTermination' , 'nhbgvf');
        gen.writeStringField('sourceCreatedBy' , 'tpoto');
        gen.writeStringField('sourceUpdatedBy' , 'tpoto');
        gen.writeStringField('sourceApplicationID' , 'SF');
        gen.writeStringField('sourceCreateDate' , 'yyyy-MM-dd\'T\'HH:mm:ss.000-00:00');
        gen.writeStringField('sourceLastUpdateDate' , 'yyyy-MM-dd\'T\'HH:mm:ss.000-00:00');
        gen.writeFieldName('aml');
        gen.writeStartObject();        
        gen.writeStringField('targetMarketJurisdiction' , 'kmjnhb');  
        gen.writeStringField('ccr' , '233434');    
        gen.writeStringField('crrComments' , 'mjnhgbv');    
        gen.writeStringField('ccrOverride' , 'jhngb');    
        gen.writeStringField('entityType' , 'fvdc');          
        gen.writeEndObject();
        gen.writeFieldName('rating');
        gen.writeStartObject();      
        gen.writeStringField('mraId' , '4p54656');
        gen.writeStringField('bloombergId' , '454546'); 
        gen.writeStringField('hnwiId' , '5086585689');        
        gen.writeEndObject();
        gen.writeFieldName('sic');
        gen.writeStartObject(); 
        gen.writeStringField('sicCode' , '9645896'); 
        gen.writeStringField('sicDescription' , 'gbfvcdgfbv'); 
        gen.writeStringField('economicGroupSicCode' , '59584589568'); 
        gen.writeStringField('economicGroupSicDescription' , 'gbfvcdgfbv');          
        gen.writeEndObject();
        gen.writeFieldName('buro');
        gen.writeStartObject(); 
        gen.writeStringField('customerAlias' , 'jmhgjmnhbg');    
        gen.writeStringField('buroFlag' , 'jmhgjmnhbg');             
        gen.writeEndObject();     
        gen.writeEndObject();    
        gen.writeEndObject(); 
        String jsonS = gen.getAsString();
        System.debug('Entity General OEJ: '+jsonS);         
        
        return jsonS;
    }
    @istest static void Test_Make_Trash(){
        EIV_EntitiesSearchClass ESC_Null = new EIV_EntitiesSearchClass(null);
    }
    @istest static void Test_Make_Trash_V1(){
        //EIV_EntitiesSearchClass ESC = new EIV_EntitiesSearchClass();
        //Test.setCurrentPageReference(myVfPage);
       
        ApexPages.currentPage().getParameters().put('AccountId','1233455566');
        ApexPages.currentPage().getParameters().put('AccountName','una cuenta');
        ApexPages.currentPage().getParameters().put('TopParentName','test');
        Test.setMock(HttpCalloutMock.class, new MockHttpEntitiesTP());
        EIV_EntitiesSearchClass ESC = new EIV_EntitiesSearchClass();
        
    }
     @istest static void Test_Set_Params(){
        //PageReference myVfPage = Page.EIV_EntitySearchPage;
        //Test.setCurrentPageReference(myVfPage);
       
        ApexPages.currentPage().getParameters().put('AccountId','1233455566');
        ApexPages.currentPage().getParameters().put('AccountName','una cuenta');
        ApexPages.currentPage().getParameters().put('TopParentID','test');
         ApexPages.currentPage().getParameters().put('TopParentName','test');
         Test.setMock(HttpCalloutMock.class, new MockHttpEntitiesTP());
         EIV_EntitiesSearchClass ESC = new EIV_EntitiesSearchClass();

    }
    
    
}