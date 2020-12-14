@istest
public class ATCH_tgr_ContentMaster_LEC_test {
    @istest
    static void triggerContentMaster(){
        EIV_Parameter__c parameters = new EIV_Parameter__c();
        parameters.name = 'fecha limite';
        parameters.EIV_tx_parameter__c = '01/12/2018';
        insert parameters;
        Takedown_Invoice__c tkd_invoice = Data_Factory_TakedownInvoice_Test.createOpportunityInvoice('pdf');
        takedownTableDocumentsController_cls.deleteInvoice(tkd_invoice.Id, tkd_invoice.TKD_txt_Document_ID__c);
        
    }

}