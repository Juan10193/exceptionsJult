@istest
public class AssetTrigger_test {
    @istest
    static void afterInsert(){
        EIV_Parameter__c parameters = new EIV_Parameter__c();
        parameters.name = 'fecha limite';
        parameters.EIV_tx_parameter__c = '01/12/2018';
        insert parameters;
        Takedown_Invoice__c createTakedownInvoice = Data_Factory_TakedownInvoice_Test.createTakedownInvoice('xml');
        Takedowns_Contingency_plan__c tkd = [SELECT Id, Name, Annex_Pricing_SuperTrump__c FROM Takedowns_Contingency_plan__c where id =:createTakedownInvoice.TKD_pd_Takedown_CP__c];
        Account cuenta = Data_Factory_Account_Test.createNewAccount('lalo');
        Data_Factory_Assets_test.createAsset(cuenta.id, tkd.id, createTakedownInvoice.id);
    }
    @istest
    static void afterUpdate(){
        EIV_Parameter__c parameters = new EIV_Parameter__c();
        parameters.name = 'fecha limite';
        parameters.EIV_tx_parameter__c = '01/12/2018';
        insert parameters;
        Takedown_Invoice__c createTakedownInvoice = Data_Factory_TakedownInvoice_Test.createTakedownInvoice('xml');
        Takedowns_Contingency_plan__c tkd = [SELECT Id, Name, Annex_Pricing_SuperTrump__c FROM Takedowns_Contingency_plan__c where id =:createTakedownInvoice.TKD_pd_Takedown_CP__c];
        Account cuenta = Data_Factory_Account_Test.createNewAccount('lalo');
        Asset activo = Data_Factory_Assets_test.createAsset(cuenta.id, tkd.id, createTakedownInvoice.id);
        activo.name = 'other';
        update activo;
    }
    @istest
    static void afterDelete(){
        EIV_Parameter__c parameters = new EIV_Parameter__c();
        parameters.name = 'fecha limite';
        parameters.EIV_tx_parameter__c = '01/12/2018';
        insert parameters;
        Takedown_Invoice__c createTakedownInvoice = Data_Factory_TakedownInvoice_Test.createTakedownInvoice('xml');
        Takedowns_Contingency_plan__c tkd = [SELECT Id, Name, Annex_Pricing_SuperTrump__c FROM Takedowns_Contingency_plan__c where id =:createTakedownInvoice.TKD_pd_Takedown_CP__c];
        Account cuenta = Data_Factory_Account_Test.createNewAccount('lalo');
        Asset activo = Data_Factory_Assets_test.createAsset(cuenta.id, tkd.id, createTakedownInvoice.id);
        activo.name = 'other';
        delete activo;
    }
    @istest
    static void afterUndelete(){
        EIV_Parameter__c parameters = new EIV_Parameter__c();
        parameters.name = 'fecha limite';
        parameters.EIV_tx_parameter__c = '01/12/2018';
        insert parameters;
        Takedown_Invoice__c createTakedownInvoice = Data_Factory_TakedownInvoice_Test.createTakedownInvoice('xml');
        Takedowns_Contingency_plan__c tkd = [SELECT Id, Name, Annex_Pricing_SuperTrump__c FROM Takedowns_Contingency_plan__c where id =:createTakedownInvoice.TKD_pd_Takedown_CP__c];
        Account cuenta = Data_Factory_Account_Test.createNewAccount('lalo');
        Asset activo = Data_Factory_Assets_test.createAsset(cuenta.id, tkd.id, createTakedownInvoice.id);
        activo.name = 'other';
        delete activo;
        undelete activo;
    }
    @istest
    static void updateAssetUSD(){
        EIV_Parameter__c parameters = new EIV_Parameter__c();
        parameters.name = 'fecha limite';
        parameters.EIV_tx_parameter__c = '01/12/2018';
        insert parameters;
        Takedown_Invoice__c createTakedownInvoice = Data_Factory_TakedownInvoice_Test.createTakedownInvoice('xml');
        Takedowns_Contingency_plan__c tkd = [SELECT Id, Name, Annex_Pricing_SuperTrump__c FROM Takedowns_Contingency_plan__c where id =:createTakedownInvoice.TKD_pd_Takedown_CP__c];
        Account cuenta = Data_Factory_Account_Test.createNewAccount('lalo');
        Asset activo = Data_Factory_Assets_test.createAsset(cuenta.id, tkd.id, createTakedownInvoice.id);
        activo.name = 'other';
        activo.CurrencyIsoCode = 'USD';
        activo.TKD_dv_total_cost__c = 5000;
        update activo;
    }
    @istest
    static void updateAssetMXN(){
        EIV_Parameter__c parameters = new EIV_Parameter__c();
        parameters.name = 'fecha limite';
        parameters.EIV_tx_parameter__c = '01/12/2018';
        insert parameters;
        Takedown_Invoice__c createTakedownInvoice = Data_Factory_TakedownInvoice_Test.createTakedownInvoice('xml');
        Takedowns_Contingency_plan__c tkd = [SELECT Id, Name, Annex_Pricing_SuperTrump__c FROM Takedowns_Contingency_plan__c where id =:createTakedownInvoice.TKD_pd_Takedown_CP__c];
        Account cuenta = Data_Factory_Account_Test.createNewAccount('lalo');
        Asset activo = Data_Factory_Assets_test.createAsset(cuenta.id, tkd.id, createTakedownInvoice.id);
        activo.name = 'other';
        activo.CurrencyIsoCode = 'MXN';
        activo.TKD_dv_total_cost__c = 5000;
        update activo;
        activo.CurrencyIsoCode = 'USD';
        activo.TKD_dv_total_cost__c = 5000;
        update activo;
    }

    @istest
    static void updateInvoiceUSDAssetUSD(){
        EIV_Parameter__c parameters = new EIV_Parameter__c();
        parameters.name = 'fecha limite';
        parameters.EIV_tx_parameter__c = '01/12/2018';
        insert parameters;
        Takedown_Invoice__c createTakedownInvoice = Data_Factory_TakedownInvoice_Test.createTakedownInvoice('xml');
        Takedowns_Contingency_plan__c tkd = [SELECT Id, Name, Annex_Pricing_SuperTrump__c FROM Takedowns_Contingency_plan__c where id =:createTakedownInvoice.TKD_pd_Takedown_CP__c];
        Account cuenta = Data_Factory_Account_Test.createNewAccount('lalo');
        Asset activo = Data_Factory_Assets_test.createAsset(cuenta.id, tkd.id, createTakedownInvoice.id);
        createTakedownInvoice.CurrencyIsoCode = 'USD';
        update createTakedownInvoice;
        activo.CurrencyIsoCode = 'USD';
        activo.TKD_dv_total_cost__c = 5000;
        update activo;
    }
    
    @istest
    static void updateInvoiceMXNAssetMXN(){
        EIV_Parameter__c parameters = new EIV_Parameter__c();
        parameters.name = 'fecha limite';
        parameters.EIV_tx_parameter__c = '01/12/2018';
        insert parameters;
        Takedown_Invoice__c createTakedownInvoice = Data_Factory_TakedownInvoice_Test.createTakedownInvoice('xml');
        Takedowns_Contingency_plan__c tkd = [SELECT Id, Name, Annex_Pricing_SuperTrump__c FROM Takedowns_Contingency_plan__c where id =:createTakedownInvoice.TKD_pd_Takedown_CP__c];
        Account cuenta = Data_Factory_Account_Test.createNewAccount('lalo');
        Asset activo = Data_Factory_Assets_test.createAsset(cuenta.id, tkd.id, createTakedownInvoice.id);
        createTakedownInvoice.CurrencyIsoCode = 'MXN';
        update createTakedownInvoice;
        activo.CurrencyIsoCode = 'MXN';
        activo.TKD_dv_total_cost__c = 5000;
        update activo;
    }
    @istest
    static void updateInvoiceMXNAssetUSD(){
        EIV_Parameter__c parameters = new EIV_Parameter__c();
        parameters.name = 'fecha limite';
        parameters.EIV_tx_parameter__c = '01/12/2018';
        insert parameters;
        Takedown_Invoice__c createTakedownInvoice = Data_Factory_TakedownInvoice_Test.createTakedownInvoice('xml');
        Takedowns_Contingency_plan__c tkd = [SELECT Id, Name, Annex_Pricing_SuperTrump__c FROM Takedowns_Contingency_plan__c where id =:createTakedownInvoice.TKD_pd_Takedown_CP__c];
        Account cuenta = Data_Factory_Account_Test.createNewAccount('lalo');
        Asset activo = Data_Factory_Assets_test.createAsset(cuenta.id, tkd.id, createTakedownInvoice.id);
        createTakedownInvoice.CurrencyIsoCode = 'MXN';
        update createTakedownInvoice;
        activo.CurrencyIsoCode = 'USD';
        activo.TKD_dv_total_cost__c = 5000;
        update activo;
    }
}