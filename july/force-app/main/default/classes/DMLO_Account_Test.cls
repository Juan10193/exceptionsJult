@isTest
public class DMLO_Account_Test {
    @isTest
    static void deletDocument(){
        EIV_Parameter__c parameters = new EIV_Parameter__c();
        parameters.name = 'fecha limite';
        parameters.EIV_tx_parameter__c = '01/12/2018';
        insert parameters;
        Takedown_Invoice__c createTakedownInvoice = Data_Factory_TakedownInvoice_Test.createTakedownInvoice('xml');
        Takedowns_Contingency_plan__c tkd = [SELECT Id, Name, Annex_Pricing_SuperTrump__c FROM Takedowns_Contingency_plan__c where id =:createTakedownInvoice.TKD_pd_Takedown_CP__c];
        Account cuenta = Data_Factory_Account_Test.createNewAccount('lalo');
       //	asset activo = Data_Factory_Assets_test.createAsset(cuenta.id, tkd.id, createTakedownInvoice.id);
        List<Account> listAccount = new List<Account>();
        listAccount.add(cuenta);
        DMLO_Account.deletDocument(listAccount);
    }

}