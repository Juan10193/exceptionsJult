@isTest
public class takedownTableInvoicesController_test {
	static testmethod void takedownTableInvoicesController() {
        EIV_Parameter__c parameters = new EIV_Parameter__c();
        parameters.name = 'fecha limite';
        parameters.EIV_tx_parameter__c = '2019-01-01';
        insert parameters;
       Takedown_Invoice__c takedown_Invoice = Data_Factory_TakedownInvoice_Test.createTakedownInvoice('.pdf');
       takedownTableInvoicesController_cls.getDocumentList(takedown_Invoice.TKD_pd_Takedown_CP__c);
    }
}