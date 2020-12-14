@Istest
public class Data_Factory_EC_Quote_Test {
	
   public static EC_Quote__c createEcQuoteNoOpp(Decimal montoTotal){
        EC_Quote__c q = new EC_Quote__c();
        q.CurrencyIsoCode ='MXN';
        q.Monto_Total__c =montoTotal;
        insert q;
        return q;
    }
}