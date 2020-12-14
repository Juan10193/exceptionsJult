@IsTest
public class takedownTableABFormController_test {
    @isTest
    static void getAssetBreakdown(){
        EIV_Parameter__c parameters = new EIV_Parameter__c();
        parameters.name = 'fecha limite';
        parameters.EIV_tx_parameter__c = '01/12/2018';
        insert parameters;
        List<takedownTableDocumentsWrapper_cls.TableElement> listTableElement = new List<takedownTableDocumentsWrapper_cls.TableElement>();
    	takedownTableDocumentsWrapper_cls.TableElement tableElement = new takedownTableDocumentsWrapper_cls.TableElement();
        Takedown_Invoice__c tkd_invoice = Data_Factory_TakedownInvoice_Test.createTakedownInvoice('xml');
        takedownTableABFormController_cls.getAssetBreakdown(tkd_invoice.id);
    }
    
    @isTest
    static void getTakedownFields(){
        EIV_Parameter__c parameters = new EIV_Parameter__c();
        parameters.name = 'fecha limite';
        parameters.EIV_tx_parameter__c = '01/12/2018';
        insert parameters;
        Takedowns_Contingency_plan__c takedown = Data_Factory_Takedown_Test.createTakedown('AFINAN-FIJA', 'FISHERS', 'FISH1092');
    	takedownTableABFormController_cls.getTakedownFields(takedown.id);
    }

}