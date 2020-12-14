@isTest
public class Data_Access_Takedown_Invoice_test {
	@isTest static void getDocumentList() {
        EIV_Parameter__c parameters = new EIV_Parameter__c();
        parameters.name = 'fecha limite';
        parameters.EIV_tx_parameter__c = '01/12/2018';
        insert parameters;
        Takedown_Invoice__c tkd_invoice = Data_Factory_TakedownInvoice_Test.createTakedownInvoice('xml');
        list<String> listFilterDocType = new list<string>(); 
        listFilterDocType.add('xml');
        Data_Access_Takedown_Invoice_cls.getDocumentList(tkd_invoice.TKD_pd_Takedown_CP__c, listFilterDocType);        
    }
    @isTest static void getDocumentListByTakedownID(){
        EIV_Parameter__c parameters = new EIV_Parameter__c();
        parameters.name = 'fecha limite';
        parameters.EIV_tx_parameter__c = '01/12/2018';
        insert parameters;
        Takedown_Invoice__c tkd_invoice = Data_Factory_TakedownInvoice_Test.createTakedownInvoice('xml');
        list<String> listFilterDocType = new list<string>(); 
        listFilterDocType.add('xml');
        Data_Access_Takedown_Invoice_cls.getDocumentListByTakedownID(tkd_invoice.TKD_pd_Takedown_CP__c);        

    }
    @isTest static void getTakedownToAvoidNoRecords() {
        EIV_Parameter__c parameters = new EIV_Parameter__c();
        parameters.name = 'fecha limite';
        parameters.EIV_tx_parameter__c = '01/12/2018';
        insert parameters;
        Takedown_Invoice__c tkd_invoice = Data_Factory_TakedownInvoice_Test.createTakedownInvoice('xml');
        list<String> listFilterDocType = new list<string>(); 
        listFilterDocType.add('xml');
        set<id> setIds = new set<id>();
        setIds.add(tkd_invoice.TKD_pd_Takedown_CP__c);
        Data_Access_Takedown_Invoice_cls.getTakedownToAvoid(setIds);        
    }
    @isTest static void getTakedownToAvoidRecords() {
        EIV_Parameter__c parameters = new EIV_Parameter__c();
        parameters.name = 'fecha limite';
        parameters.EIV_tx_parameter__c = '01/12/2018';
        insert parameters;
        Takedown_Invoice__c tkd_invoice = Data_Factory_TakedownInvoice_Test.createTakedownInvoice('xml');
        tkd_invoice.TKD_ls_Eng_Status__c = 'action:close';
        tkd_invoice.TKD_ls_SAT_Status__c = 'action:close';   
        update tkd_invoice;
        list<String> listFilterDocType = new list<string>(); 
        listFilterDocType.add('xml');
        set<id> setIds = new set<id>();
        setIds.add(tkd_invoice.TKD_pd_Takedown_CP__c);
        Data_Access_Takedown_Invoice_cls.getTakedownToAvoid(setIds);        
    }
    @isTest static void getTakedownInvoiceById() {
        EIV_Parameter__c parameters = new EIV_Parameter__c();
        parameters.name = 'fecha limite';
        parameters.EIV_tx_parameter__c = '01/12/2018';
        insert parameters;
        Takedown_Invoice__c tkd_invoice = Data_Factory_TakedownInvoice_Test.createTakedownInvoice('xml');
        Data_Access_Takedown_Invoice_cls.getTakedownInvoiceById(tkd_invoice.Id);        
    }
}