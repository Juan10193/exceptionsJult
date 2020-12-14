@IsTest
private class InvoiceReject_test {

    static testMethod void getInvoiceReject() {
        InvoiceReject_cls.getReasonReject();
    }
    
    static testMethod void createdInvoiceReject() {
       	List<Invoice_process_reject__c> addInvoiceRejetc = InvoiceReject_test.invoiceReject();
        InvoiceReject_cls.saveReasonRejects(addInvoiceRejetc);
    }
    
    static testMethod void requestInvoices() {
        Id idTakedown = InvoiceReject_test.createdTakedownCP();
    	String invoiceName = 'Test';
        InvoiceReject_cls.getInvoices(idTakedown, invoiceName);
    }
    
    static testMethod void insertRejectInvoice() {
        List<Takedown_Invoice__c> listInvoiceRject =  InvoiceReject_test.createdTakedownWithInvoice(); 
        InvoiceReject_cls.saveReasonRejectInvoice(listInvoiceRject);
    }
    
    static testMethod void insertSuccessRejectInvoiceTakedown() {
        Takedowns_Contingency_plan__c takedonwInvoice = InvoiceReject_test.createdTakedownCPwithInvoice();
        String error = 'all';
        String comments = 'Test records';
        InvoiceReject_cls.updateSuccessInvoice(takedonwInvoice.Id, error, comments);
    }
    
    static testMethod void insertRejectInvoiceInvoices() {
        Takedowns_Contingency_plan__c takedonwInvoice = InvoiceReject_test.createdTakedownCPwithInvoice();
        List<Id> ids = new List<Id>(); 
        String comments = 'Test records';
        InvoiceReject_cls.saveAllReasonRejects(takedonwInvoice.Id, comments, ids);
    }
    
    public static List<Invoice_process_reject__c> invoiceReject() {
        List<Invoice_process_reject__c> listInvoiceReject = new List<Invoice_process_reject__c>();
        Id idTakedown = InvoiceReject_test.createdTakedownCP();
        
        Invoice_process_reject__c inReject = new Invoice_process_reject__c();
        inReject.Error_version__c = 'Catalogo_1';
        inreject.Reason_for_rejection__c = 'Serie y Folio';
        inReject.Another_reason__c = 'Test invoice reject';
        inReject.Process_Type__c = 'Takedowns_Contingency_plan__c';
        inReject.Takedowns_Contingency_plan__c = idTakedown;
        listInvoiceReject.add(inReject);
        
        return listInvoiceReject;
    }
    
    public static id createdTakedownCP() {
        EIV_Parameter__c parameters = new EIV_Parameter__c();
        parameters.name = 'fecha limite';
        parameters.EIV_tx_parameter__c = '01/12/2018';
        insert parameters;
        Takedowns_Contingency_plan__c takedown = Data_Factory_Takedown_Test.createTakedown('OPERFIN-FIJA','CDMX', 'CDMX123456');
        
        return takedown.Id;
	}
    
    public static List<Takedown_Invoice__c> createdTakedownWithInvoice() {
        EIV_Parameter__c parameters = new EIV_Parameter__c();
        parameters.name = 'fecha limite';
        parameters.EIV_tx_parameter__c = '01/12/2018';
        insert parameters;
        
        List<Takedown_Invoice__c> listTakedownInvoice = new List<Takedown_Invoice__c>();
        listTakedownInvoice.add(Data_Factory_TakedownInvoice_Test.createTakedownInvoice('xml'));
        return listTakedownInvoice;
    }
    
    public static Takedowns_Contingency_plan__c createdTakedownCPwithInvoice() {
        EIV_Parameter__c parameters = new EIV_Parameter__c();
        parameters.name = 'fecha limite';
        parameters.EIV_tx_parameter__c = '01/12/2018';
        insert parameters;
        
        Takedowns_Contingency_plan__c takedownCPInvoice = Data_Factory_TakedownInvoice_Test.getTakedownWhitInvoice('xml');
        return takedownCPInvoice;
    }
}