public with sharing class Util_cls {
	/*static variables para el manejo de los triggers*/
	public static boolean updateCreditApp=true;
	
    public static String obtieneMensajeReglaValidacion(Exception e) {
        String VALIDATION_RULE_STRING = 'FIELD_CUSTOM_VALIDATION_EXCEPTION';
        String FIELD_INTEGRITY_EXCEPTION = 'FIELD_INTEGRITY_EXCEPTION';
        String DUPLICATE_DEVELOPER_NAME = 'DUPLICATE_DEVELOPER_NAME';    
        
        String mensaje = e.getMessage();
        
        if (e.getMessage().contains(VALIDATION_RULE_STRING)) {
          mensaje = e.getMessage().substring(e.getMessage().indexOf(VALIDATION_RULE_STRING)); 
          //return mensaje.substring(mensaje.indexOf(',')+2,mensaje.lastIndexOf(':'));
        }
        if (e.getMessage().contains(FIELD_INTEGRITY_EXCEPTION)) {
          mensaje = e.getMessage().substring(e.getMessage().indexOf(FIELD_INTEGRITY_EXCEPTION)); 
          //return mensaje.substring(mensaje.indexOf(',')+2,mensaje.lastIndexOf(':'));
        } 
        if (e.getMessage().contains(DUPLICATE_DEVELOPER_NAME)) {
          mensaje = e.getMessage().substring(e.getMessage().indexOf(DUPLICATE_DEVELOPER_NAME)); 
          //return mensaje.substring(mensaje.indexOf(',')+2,mensaje.lastIndexOf(':'));
        }                
            
        //mensaje = mensaje.substring(mensaje.indexOf(',')+2,mensaje.lastIndexOf(':'));
        mensaje = mensaje.replace('&quot;', '"');
        mensaje += ' (Line: ' + e.getLineNumber() + ').'; 
        
        //return e.getMessage();
        return mensaje;
   }
    
    public static void calculateAmounts(TBO014_Credit_Approval__c creditApproval, Set<Id> oppIdList) {
        Decimal amountMXN = 0;
        Decimal amountUSD = 0;
        Decimal totalUSD = 0;
        
        AggregateResult resultadoMontosMXN = [SELECT SUM(Amount) Amount FROM Opportunity WHERE Id IN :oppIdList AND CurrencyIsoCode = 'MXN'];
    	AggregateResult resultadoMontosUSD = [SELECT SUM(Amount) Amount FROM Opportunity WHERE Id IN :oppIdList AND CurrencyIsoCode = 'USD']; 
        
        if ((resultadoMontosMXN != null) || (resultadoMontosUSD != null)) {
            
            if (resultadoMontosMXN != null) {
                if (((Decimal)resultadoMontosMXN.get('Amount')) > 0) 
                    amountMXN = (Decimal)resultadoMontosMXN.get('Amount');
            }
            
            if (resultadoMontosUSD != null) {
                if (((Decimal)resultadoMontosUSD.get('Amount')) > 0)
                    amountUSD = (Decimal)resultadoMontosUSD.get('Amount');
            }
                
            Decimal usdCurrencyRate = [SELECT ConversionRate FROM CurrencyType WHERE IsActive=TRUE AND IsoCode='MXN'].ConversionRate;
            
            totalUSD = amountUSD + amountMXN;
            
            creditApproval.TBO014_un_Amount_MXN__c = amountMXN * usdCurrencyRate;
            creditApproval.TBO014_un_Amount_USD__c = amountUSD;
            creditApproval.TBO014_un_Total_Amount_USD_Converted__c = totalUSD;
        }
    }
    
    public static void getFinancingNeeds(TBO014_Credit_Approval__c creditApproval, Set<Id> oppIdList) {
        String financingNeeds = '';
        
        List<AggregateResult> financingNeedsResult;
        
        try {
        	financingNeedsResult = [SELECT OPP_ls_Financing_Need__c FinancingNeed FROM Opportunity WHERE Id IN :oppIdList AND OPP_ls_Financing_Need__c <> null GROUP BY OPP_ls_Financing_Need__c ORDER BY OPP_ls_Financing_Need__c];
        }
        catch (Exception exGetFN) {
            System.debug('Error: ' + exGetFN.getMessage() + ' (Line: ' + exGetFN.getLineNumber() + ').');
        }
        
        System.debug('Listado de Financing Needs: ' + financingNeedsResult);
            
        if (financingNeedsResult != null) {
            for (AggregateResult result : financingNeedsResult) {
            	financingNeeds += ((String) result.get('FinancingNeed')) + ', ';
            }
        }
        
        if (String.isNotEmpty(financingNeeds)) {
            financingNeeds = financingNeeds.removeEnd(', ');
        }
        
        System.debug('Listado de Financing Needs: ' + financingNeeds);
        
        creditApproval.TBO014_tx_Approval_Type__c = financingNeeds;
    }
}