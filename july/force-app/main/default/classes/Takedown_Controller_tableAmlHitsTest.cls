@Istest
private class Takedown_Controller_tableAmlHitsTest {
    
    @testSetup static void setup(){
        //creation of EIV parameters
        list<EIV_Parameter__c> parameters = Test.loadData(EIV_Parameter__c.sobjectType, 'parametrosTest');
        System.assert(parameters.size()>0);
    }
    
    @Istest
    static void updateInformationSuppTest(){
        Takedowns_Contingency_plan__c tkd = Data_Factory_Takedown_Test.createTakedownNowkopp('OPERFIN-FIJA', 'entityCPName', 'entityCPRFCTIN');
        list<Supplier_in_approval__c> suppInapp1 = [Select Id from Supplier_in_approval__c where TKD_rb_SupplierInApproval__c =:tkd.Id];
        delete suppInapp1;
        Supplier_in_approval__c suppInApp = Data_Factory_SupplierInApproval_Test.createNewSupplierInApprovalNoTKD(tkd.id);
        system.debug('SuppInAppIdd: '+ suppInApp.Id);
        Supplier__c supp = Data_Factory_SupplierTest.createSupplier('DELL MEXICO SA DE CV', 'DME9204099R6', suppInApp.Id);
         string sandbox = GetSandboxType.getTypeOfSandbox();
        string namecred;
        
        if(sandbox == 'DEV'){
            namecred = 'getsServiceUrl';
        }
        if(sandbox == 'QA'){
            namecred = 'getsServiceUrlQa';
        }
        if(sandbox =='PROD'){
            namecred = 'getsServiceUrlProd';
        }            
        
        string testEndpoint ='callout:'+ namecred + '/EcAmlSbDat/AmlRs/aml/hits/queries/nameorRfc';
      
        String getResponse ='{"status":{"message":"Success","detail":"S","code":null},"result":{"amlHits":[{"vendorId":5003,"state":"DF","sicCodeDescription":null,"sicCode":null,"rfc":"DME9204099R6","partyId":21082,"hits":"false","hitDescription":null,"entityType":null,"entityName":"DELL MEXICO SA DE CV  100.000%","customerType":"ORGANIZATION","crr":null,"country":"MX"}]}}';
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseHandler_cls(testEndpoint, getResponse, 'GET', 'application/json', 200));
        test.startTest();
        Takedown_Controller_tableAmlHits.updateInformationSupp(tkd.Id);
        test.stopTest();
        Takedown_Controller_tableAmlHits.onSaveSupplierInApproval(tkd.Id);
        Takedown_Controller_tableAmlHits.getSuppliers(tkd.Id);
        Takedown_Controller_tableAmlHits.getAllSupplier(tkd.Id);
        Takedown_Controller_tableAmlHits.getHitsDesc(tkd.Id, supp.Id);
        Takedown_Controller_tableAmlHits.getInvoiceByNameOrRfcSupplier(tkd.Id, 'DME9204099R6');
     
    }
    
     @Istest
    static void updateInformationSuppTest2(){
        Takedowns_Contingency_plan__c tkd = Data_Factory_Takedown_Test.createTakedownNowkopp('OPERFIN-FIJA', 'entityCPName', 'entityCPRFCTIN');
        list<Supplier_in_approval__c> suppInapp1 = [Select Id from Supplier_in_approval__c where TKD_rb_SupplierInApproval__c =:tkd.Id];
        delete suppInapp1;
        Supplier_in_approval__c suppInApp = Data_Factory_SupplierInApproval_Test.createNewSupplierInApprovalNoTKD(tkd.id);
        system.debug('SuppInAppIdd: '+ suppInApp.Id);
        Supplier__c supp = Data_Factory_SupplierTest.createSupplier('DELL MEXICO SA DE CV', 'DME9204099R6', suppInApp.Id);
         string sandbox = GetSandboxType.getTypeOfSandbox();
        string namecred;
        
        if(sandbox == 'DEV'){
            namecred = 'getsServiceUrl';
        }
        if(sandbox == 'QA'){
            namecred = 'getsServiceUrlQa';
        }
        if(sandbox =='PROD'){
            namecred = 'getsServiceUrlProd';
        }            
        
        string testEndpoint ='callout:'+ namecred + '/EcAmlSbDat/AmlRs/aml/hits/queries/nameorRfc';
      
        String getResponse ='{"status":{"message":"Success","detail":"S","code":null},"result":{"amlHits":[{"vendorId":5003,"state":"DF","sicCodeDescription":null,"sicCode":null,"rfc":"DME9204099R6","partyId":21082,"hits":"false","hitDescription":null,"entityType":null,"entityName":"DELL MEXICO SA DE CV  100.000%","customerType":"ORGANIZATION","crr":null,"country":"MX"}]}}';
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseHandler_cls(testEndpoint, getResponse, 'GET', 'application/json', 200));
        test.startTest();
        Takedown_Controller_tableAmlHits.updateInformationSupp(tkd.Id);
        test.stopTest();
         Takedown_Controller_tableAmlHits.onSaveSupplierInApproval(tkd.Id);
        Takedown_Controller_tableAmlHits.validateHitsCheck(tkd.Id, true);
        Takedown_Controller_tableAmlHits.validateHitsCheck2(tkd.Id, true);
        Takedown_Controller_tableAmlHits.validateHitsCheck3(tkd.Id, true);
        Takedown_Controller_tableAmlHits.validateHitsCheck4(tkd.Id, true);
        Takedown_Controller_tableAmlHits.validateHitsCheck5(tkd.Id, true);
        Takedown_Controller_tableAmlHits.validateHitsCheck6(tkd.Id, true);
    }
    
      @Istest
    static void updateInformationSuppTest3(){
        Takedowns_Contingency_plan__c tkd = Data_Factory_Takedown_Test.createTakedownNowkopp('OPERFIN-FIJA', 'entityCPName', 'entityCPRFCTIN');
        list<Supplier_in_approval__c> suppInapp1 = [Select Id from Supplier_in_approval__c where TKD_rb_SupplierInApproval__c =:tkd.Id];
        delete suppInapp1;
        Supplier_in_approval__c suppInApp = Data_Factory_SupplierInApproval_Test.createNewSupplierInApprovalNoTKD(tkd.id);
        system.debug('SuppInAppIdd: '+ suppInApp.Id);
        Supplier__c supp = Data_Factory_SupplierTest.createSupplier('DELL MEXICO SA DE CV', 'DME9204099R6', suppInApp.Id);
         string sandbox = GetSandboxType.getTypeOfSandbox();
        string namecred;
        
        if(sandbox == 'DEV'){
            namecred = 'getsServiceUrl';
        }
        if(sandbox == 'QA'){
            namecred = 'getsServiceUrlQa';
        }
        if(sandbox =='PROD'){
            namecred = 'getsServiceUrlProd';
        }            
        
        string testEndpoint ='callout:'+ namecred + '/EcAmlSbDat/AmlRs/aml/hits/queries/nameorRfc';
      
        String getResponse ='{"status":{"message":"Success","detail":"S","code":null},"result":{"amlHits":[{"vendorId":5003,"state":"DF","sicCodeDescription":null,"sicCode":null,"rfc":"DME9204099R6","partyId":21082,"hits":"false","hitDescription":null,"entityType":null,"entityName":"DELL MEXICO SA DE CV  100.000%","customerType":"ORGANIZATION","crr":null,"country":"MX"}]}}';
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseHandler_cls(testEndpoint, getResponse, 'GET', 'application/json', 200));
        test.startTest();
        Takedown_Controller_tableAmlHits.updateInformationSupp(tkd.Id);
        test.stopTest();
        Takedown_Controller_tableAmlHits.validateHitsCheck7(tkd.Id, true);
        Takedown_Controller_tableAmlHits.validateHitsCheck8(tkd.Id, true);
        Takedown_Controller_tableAmlHits.validateHitsCheck9(tkd.Id, true);
        Takedown_Controller_tableAmlHits.validateHitsCheck10(tkd.Id, true);
        Takedown_Controller_tableAmlHits.validateHitsCheck11(tkd.Id, true);
        Takedown_Controller_tableAmlHits.validateHitsCheck12(tkd.Id, true);
        Takedown_Controller_tableAmlHits.validateHitsCheck13(tkd.Id, true);
        
       
    }
    
      @Istest
    static void updateInformationSuppTest4(){
        Takedowns_Contingency_plan__c tkd = Data_Factory_Takedown_Test.createTakedownNowkopp('OPERFIN-FIJA', 'entityCPName', 'entityCPRFCTIN');
        list<Supplier_in_approval__c> suppInapp1 = [Select Id from Supplier_in_approval__c where TKD_rb_SupplierInApproval__c =:tkd.Id];
        delete suppInapp1;
        Supplier_in_approval__c suppInApp = Data_Factory_SupplierInApproval_Test.createNewSupplierInApprovalNoTKD(tkd.id);
        system.debug('SuppInAppIdd: '+ suppInApp.Id);
        Supplier__c supp = Data_Factory_SupplierTest.createSupplier('DELL MEXICO SA DE CV', 'DME9204099R6', suppInApp.Id);
         string sandbox = GetSandboxType.getTypeOfSandbox();
        string namecred;
        
        if(sandbox == 'DEV'){
            namecred = 'getsServiceUrl';
        }
        if(sandbox == 'QA'){
            namecred = 'getsServiceUrlQa';
        }
        if(sandbox =='PROD'){
            namecred = 'getsServiceUrlProd';
        }            
        
        string testEndpoint ='callout:'+ namecred + '/EcAmlSbDat/AmlRs/aml/hits/queries/nameorRfc';
      
        String getResponse ='{"status":{"message":"Success","detail":"S","code":null},"result":{"amlHits":[{"vendorId":5003,"state":"DF","sicCodeDescription":null,"sicCode":null,"rfc":"DME9204099R6","partyId":21082,"hits":"false","hitDescription":null,"entityType":null,"entityName":"DELL MEXICO SA DE CV  100.000%","customerType":"ORGANIZATION","crr":null,"country":"MX"}]}}';
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseHandler_cls(testEndpoint, getResponse, 'GET', 'application/json', 200));
        test.startTest();
        Takedown_Controller_tableAmlHits.updateInformationSupp(tkd.Id);
        test.stopTest();
        Takedown_Controller_tableAmlHits.validateHitsCheck14(tkd.Id, true);
        Takedown_Controller_tableAmlHits.validateHitsCheck15(tkd.Id, true);
        Takedown_Controller_tableAmlHits.validateHitsCheck16(tkd.Id, true);
        
       
    }
}