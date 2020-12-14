@Istest
private class Data_Access_Site_Test {
     @testSetup static void setup(){
        //creation of EIV parameters
        list<EIV_Parameter__c> parameters = Test.loadData(EIV_Parameter__c.sobjectType, 'parametrosTest');
        System.assert(parameters.size()>0);
    }
    
	@Istest
    static void getSitDataBysupplierInApprovalIDTest(){
        Takedowns_Contingency_plan__c tkd = Data_Factory_Takedown_Test.createTakedownNowkopp('OPERFIN-FIJA', 'entityCPName', 'entityCPRFCTIN');
        Supplier_in_approval__c suppInapp = Data_Factory_SupplierInApproval_Test.createNewSupplierInApprovalNoTKD(tkd.Id);
        Data_Access_Site.getSitDataBysupplierInApprovalID(suppInapp.Id);
    }
    
    @Istest
    static void getSitDataBysupplierTest(){
        Takedowns_Contingency_plan__c tkd = Data_Factory_Takedown_Test.createTakedownNowkopp('OPERFIN-FIJA', 'entityCPName', 'entityCPRFCTIN');
        Supplier_in_approval__c suppInapp = Data_Factory_SupplierInApproval_Test.createNewSupplierInApprovalNoTKD(tkd.Id);
        Supplier__c supp = Data_Factory_SupplierTest.createSupplier('vendorName', 'RFC', suppInapp.Id);
        Data_Access_Site.getSitDataBysupplier(supp.Id);
    }
    
    @Istest
    static void getSiteDataByidTest(){
        Takedowns_Contingency_plan__c tkd = Data_Factory_Takedown_Test.createTakedownNowkopp('OPERFIN-FIJA', 'entityCPName', 'entityCPRFCTIN');
        Supplier_in_approval__c suppInapp = Data_Factory_SupplierInApproval_Test.createNewSupplierInApprovalNoTKD(tkd.Id);
        Supplier__c supp = Data_Factory_SupplierTest.createSupplier('vendorName', 'RFC', suppInapp.Id);
        TKD_Site__c  site = Data_Factory_SiteTest.createSite(tkd, supp.Id);
        Data_Access_Site.getSiteDataByid(site.Id);
    }
    
    @Istest
    static void getSitDataByTakedownTest(){
        Takedowns_Contingency_plan__c tkd = Data_Factory_Takedown_Test.createTakedownNowkopp('OPERFIN-FIJA', 'entityCPName', 'entityCPRFCTIN');
        Supplier_in_approval__c suppInapp = Data_Factory_SupplierInApproval_Test.createNewSupplierInApprovalNoTKD(tkd.Id);
        Supplier__c supp = Data_Factory_SupplierTest.createSupplier('vendorName', 'RFC', suppInapp.Id);
        TKD_Site__c  site = Data_Factory_SiteTest.createSite(tkd, supp.Id);
        try{
        	Data_Access_Site.getSitDataByTakedown(tkd);    
        }
        catch(Exception e){
            system.debug('e ' +  e.getMessage());
        }
    }
}