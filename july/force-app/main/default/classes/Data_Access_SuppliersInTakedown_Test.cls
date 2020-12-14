@isTest
private class Data_Access_SuppliersInTakedown_Test {
    @testSetup static void setup(){
        //creation of EIV parameters
        list<EIV_Parameter__c> parameters = Test.loadData(EIV_Parameter__c.sobjectType, 'parametrosTest');
        System.assert(parameters.size()>0);
    }
    
	@isTest
    public static void idSupplierInApp(){
        Takedowns_Contingency_plan__c tkd = Data_Factory_Takedown_Test.createTakedownNowkopp('OPERFIN-FIJA', 'entityCPName', 'entityCPRFCTIN');
        system.debug('ID DE LOS TKDID: ' + tkd.Id);
        test.startTest();
        try{
            Data_Access_SuppliersInTakedown_cls.idSupplierInApp(tkd.Id);
        }catch(Exception e){
            system.debug(e.getMessage());
            system.debug(e.getCause());
        }
        
        test.stopTest();
    }
    @isTest
    public static void supplierInTKD(){
        Takedowns_Contingency_plan__c  takedown = Data_Factory_Takedown_Test.createTakedownNowkopp('PRESTAMO-FIJA', 'PruebaTest', 'PruebaTestDos');
        Supplier_in_approval__c suppInApp = Data_Factory_SupplierInApproval_Test.createNewSupplierInApprovalNoTKD(takedown.id);
        Data_Access_SuppliersInTakedown_cls.supplierInTKD(suppInApp.id);
    }
    @isTest
    public static void generalTKD(){
        Takedowns_Contingency_plan__c tkd = Data_Factory_Takedown_Test.createTakedownNowkopp('OPERFIN-FIJA', 'entityCPNamae', 'entitysCPRFCTIN');
        Supplier_in_approval__c suppinap = Data_Factory_SupplierInApproval_Test.createNewSupplierInApprovalNoTKD(tkd.Id);
        System.debug('Supplier In Approval Creada: '+ suppinap);
        Supplier__c sup = Data_Factory_SupplierTest.createSupplier('vendorName', 'RFC', suppinap.Id);
        try{
            Data_Access_SuppliersInTakedown_cls.generalTKD(tkd.id);
        }catch(Exception e){
            system.debug(e.getMessage());
        }
    }
}