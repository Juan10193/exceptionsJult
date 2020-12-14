public with sharing class DATA_ACCESS_TKDPretollgate1Value_mdt {
    
    public static list<TKD_PreTollgate1_Value__mdt> getValidationsByProduct(string productType){
        if(Schema.sObjectType.TKD_PreTollgate1_Value__mdt.isAccessible()){
            return [SELECT Label FROM TKD_PreTollgate1_Value__mdt where  Product_Type__c =: productType];
        }else{
            system.debug(LoggingLevel.ERROR, 'Error: Insufficient Access to metadata Validations Tollgate 1');
        }
        return null;
    }
}