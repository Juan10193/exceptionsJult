@Istest
private class Takedown_Controller_modalInvoice_Test {
     @testSetup static void setup(){
        //creation of EIV parameters
        list<EIV_Parameter__c> parameters = Test.loadData(EIV_Parameter__c.sobjectType, 'parametrosTest');
        System.assert(parameters.size()>0);
        
        
    }
    
	@Istest
    static void onSaveInvoiceTest(){
         Takedown_Invoice__c invoice = Data_Factory_TakedownInvoice_Test.createTakedownInvoiceNoBugOP('xml', 'AFINAN-FIJA', 'PAPS', 'RFC102990RC');
        
      list<Takedown_Invoice__c> invoices = new list<Takedown_Invoice__c>();
      invoices.add(invoice);        
      id tkdId = [Select Id from Takedowns_Contingency_plan__c where CPL_rb_Entity_Name_CP__r.Name ='PAPS'][0].Id;
	  Supplier_in_approval__c suppinapp = Data_Factory_SupplierInApproval_Test.createNewSupplierInApprovalNoTKD(tkdId);
      Supplier__c supp = Data_Factory_SupplierTest.createSupplier('vendorName', 'RFC', suppinapp.Id);
      Takedown_Controller_modalInvoice.onSaveInvoice(tkdId, supp.Id, 'RFC', 'vendorName', invoices);
        Takedown_Controller_modalInvoice.updateInvoices('RFC', tkdId);
    }
}