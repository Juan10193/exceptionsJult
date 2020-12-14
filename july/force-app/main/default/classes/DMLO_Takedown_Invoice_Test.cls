@Istest
private class DMLO_Takedown_Invoice_Test {
    @testSetup static void setup(){
        //creation of EIV parameters
        list<EIV_Parameter__c> parameters = Test.loadData(EIV_Parameter__c.sobjectType, 'parametrosTest');
        System.assert(parameters.size()>0);
    }
    
    @istest
    static void blanConstructor(){
        DMLO_Takedown_Invoice_cls  DMLO_TakedownInvoice = new DMLO_Takedown_Invoice_cls();
    }
    
	@Istest
    static void deleteTakedownInvoiceTest(){
       Takedown_Invoice__c invoice = Data_Factory_TakedownInvoice_Test.createTakedownInvoice('pdf');
       DMLO_Takedown_Invoice_cls.deleteTakedownInvoice(invoice.Id);
    }
    
    @Istest
    static void deleteInvoicesTest(){
        Takedown_Invoice__c invoice = Data_Factory_TakedownInvoice_Test.createTakedownInvoice('pdf');
        list<Id> invoices = new list<Id>();
        invoices.add(invoice.Id);
       	DMLO_Takedown_Invoice_cls.deleteInvoices(invoices);
    }
    
    @istest
    static void upsertInvoicesTest(){
        Takedown_Invoice__c invoice = Data_Factory_TakedownInvoice_Test.createTakedownInvoice('pdf');
        list<Takedown_Invoice__c> invoices = new list<Takedown_Invoice__c>();
        invoices.add(invoice);
       	DMLO_Takedown_Invoice_cls.upsertInvoices(invoices);
    }
    
     @istest
    static void upsertInvoicesFailTest(){
        Takedown_Invoice__c invoice = new Takedown_Invoice__c();
        list<Takedown_Invoice__c> invoices = new list<Takedown_Invoice__c>();
        invoices.add(invoice);
       	DMLO_Takedown_Invoice_cls.upsertInvoices(invoices);
    }
}