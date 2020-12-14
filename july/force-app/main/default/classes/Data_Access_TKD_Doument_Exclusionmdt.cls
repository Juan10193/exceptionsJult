public with sharing class Data_Access_TKD_Doument_Exclusionmdt {
    
    @AuraEnabled
    public static list<SObject> getDocIds(string product, string financingNeeds, string dealCategory){
        List<SObject> docsIds = 
        Database.query('SELECT Document_ID__c FROM TKD_Doument_Exclusion__mdt WHERE Deal_Category__c !=:dealCategory AND Financed__c !=:financingNeeds AND Product__c !=:product');
        
        return docsIds;
    }
}