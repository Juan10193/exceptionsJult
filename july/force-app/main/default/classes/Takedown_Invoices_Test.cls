@istest
private class Takedown_Invoices_Test {
     @testSetup static void setup(){
        //creation of EIV parameters
        list<EIV_Parameter__c> parameters = Test.loadData(EIV_Parameter__c.sobjectType, 'parametrosTest');
        System.assert(parameters.size()>0);
    }
    
	@istest
    static void insertInvoicesTest(){
        Id contentDocId = Data_Factory_TakedownInvoice_Test.getContentDocumentId('pdf');
        list<Id> contentDocIds = new list<Id>();
        contentDocIds.add(contentDocId);
        Takedowns_Contingency_plan__c tkd = [Select id from Takedowns_Contingency_plan__c];
        Takedown_Invoices_cls.insertInvoices(tkd.Id, contentDocIds);
        Takedown_Invoice__c Takedown_Invoice = [select id from Takedown_Invoice__c];
        Takedown_Invoices_cls.InsertDocumentAndUpdateInvoice(Takedown_Invoice.Id, contentDocIds);
        
    }
    /*
    @istest
    static void InsertDocumentAndUpdateInvoice(){
        Id contentDocId = Data_Factory_TakedownInvoice_Test.getContentDocumentId('pdf');
        list<Id> contentDocIds = new list<Id>();
        contentDocIds.add(contentDocId);
        Takedown_Invoice__c Takedown_Invoice = [select id from Takedown_Invoice__c];
        Takedown_Invoices_cls.insertInvoices(tkd.Id, contentDocIds);
        Takedown_Invoices_cls.InsertDocumentAndUpdateInvoice(Takedown_Invoice.Id, contentDocIds);
        
    }*/
}