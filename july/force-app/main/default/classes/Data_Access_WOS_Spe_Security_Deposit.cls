public without sharing class Data_Access_WOS_Spe_Security_Deposit {
    public static List<ST_PQ_Specified_Security_Deposit__c> getSpe_Security_Deposit(id PQID){
        List<ST_PQ_Specified_Security_Deposit__c> list_Security_Deposit = new List<ST_PQ_Specified_Security_Deposit__c>();
            for(ST_PQ_Specified_Security_Deposit__c Security_Deposit : [SELECT Id, IsDeleted, Name, CurrencyIsoCode, CreatedDate, 
                                                                 CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, 
                                                                 LastActivityDate, Pricing_Quote__c, Amount__c, Received__c, Returned__c, 
                                                                 stExternalID__c 
                                                                 FROM ST_PQ_Specified_Security_Deposit__c  
                                                         where Pricing_Quote__c = :PQID]){
                list_Security_Deposit.add(Security_Deposit); 

            }
        return list_Security_Deposit;
    }

}