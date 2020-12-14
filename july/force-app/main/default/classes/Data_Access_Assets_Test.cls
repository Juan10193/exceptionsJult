@isTest
public class Data_Access_Assets_Test {
    @isTest static void getAssetsByTakedownInvoice(){
        EIV_Parameter__c parameters = new EIV_Parameter__c();
        parameters.name = 'fecha limite';
        parameters.EIV_tx_parameter__c = '29/12/2019';
        insert parameters;
        Takedown_Invoice__c TD_invoice = Data_Factory_TakedownInvoice_Test.createTakedownInvoice('xml');
        list<id> setIds = new list<id>();
       	setIds.add(TD_Invoice.Id);
        Data_Access_Assets_cls.getAssetsByTakedownInvoice(TD_Invoice.Id);
    }
    @isTest static void  getAssetsByTakedownId(){
        list<EIV_Parameter__c> parameters = Test.loadData(EIV_Parameter__c.sobjectType, 'parametrosTest');
        Takedowns_Contingency_plan__c Takedown_CP =Data_Factory_Takedown_Test.createTakedown('AFINAN-FIJA', 'EJEMPLO', 'EJEMPLO1111');
        list<id> setIds = new list<id>();
       	setIds.add(Takedown_CP.Id);
        Data_Access_Assets_cls.getAssetsByTakedownId(Takedown_CP.Id);
    }
    @isTest static void getAssetsByTakedownInvoices(){
        EIV_Parameter__c parameters = new EIV_Parameter__c();
        parameters.name = 'fecha limite';
        parameters.EIV_tx_parameter__c = '29/12/2019';
        insert parameters;
        Takedown_Invoice__c TD_invoice = Data_Factory_TakedownInvoice_Test.createTakedownInvoice('xml');
        list<id> setIds = new list<id>();
       	setIds.add(TD_invoice.Id);
        Data_Access_Assets_cls.getAssetsByTakedownInvoices(setIds);
    }
}