public class Takedown_AssetTriggerService_cls {
    
    public void recalculaCostoTotal(Map<Id, Asset> AssetMap){
        set<id> invoiceId = new set<id>();
        for(Asset activo : [SELECT Id, Name, TKD_rb_takedown_Invoice__c FROM Asset WHERE id=:AssetMap.keyset() ALL ROWS]){
            invoiceId.add(activo.TKD_rb_takedown_Invoice__c);
        }
        List<Takedown_Invoice__c> listTakedown_Invoice = new List<Takedown_Invoice__c>();
        map<string,double> mapCurrencyType = new map<string,double>();
        for(CurrencyType cuTy : [SELECT ConversionRate, DecimalPlaces, Id, IsActive, IsCorporate, IsoCode 
                                 FROM CurrencyType where IsActive = true]){
        		mapCurrencyType.put(cuTy.IsoCode,cuTy.ConversionRate);
        }
        for(Takedown_Invoice__c Takedown_Invoice : [SELECT Id, Name, LMM_nu_Total_assets_cost__c, CurrencyIsoCode, (Select Id, Name, TKD_dv_total_cost__c, CurrencyIsoCode from Assets__r) 
             FROM Takedown_Invoice__c WHERE Id in :invoiceId]){
				double total_assets_cost = 0;                 
                 for(Asset activo : Takedown_Invoice.Assets__r){     
                     system.debug('activo ' + activo);
                     if(Takedown_Invoice.CurrencyIsoCode.equals('USD')){
                         if(activo.CurrencyIsoCode.equals('MXN')){
                         	total_assets_cost = total_assets_cost +	(activo.TKD_dv_total_cost__c / mapCurrencyType.get('MXN'));    
                         } else {
                            total_assets_cost = total_assets_cost + activo.TKD_dv_total_cost__c;
                         }
                     	
                     } else if(Takedown_Invoice.CurrencyIsoCode.equals('MXN')){
                         if(activo.CurrencyIsoCode.equals('USD')){
                         	total_assets_cost = total_assets_cost +	(activo.TKD_dv_total_cost__c * mapCurrencyType.get('MXN'));    
                         } else {
                            total_assets_cost = total_assets_cost + activo.TKD_dv_total_cost__c;
                         }
                     }
                 }     
            Takedown_Invoice.LMM_nu_Total_assets_cost__c = total_assets_cost;
			listTakedown_Invoice.add(Takedown_Invoice);                 
        }
        update listTakedown_Invoice;
    }
    
}