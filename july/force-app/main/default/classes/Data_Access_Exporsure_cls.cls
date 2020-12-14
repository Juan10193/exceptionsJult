/**
 * @File Name          : Data_Access_Exporsure_cls.cls
 * @Description        : 
 * @Author             : juandedios.hernandez@engeniumcapital.com
 * @Group              : 
 * @Last Modified By   : juandedios.hernandez@engeniumcapital.com
 * @Last Modified On   : 12/9/2019 13:57:41
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    3/9/2019   juandedios.hernandez@engeniumcapital.com     Initial Version
**/
public with sharing class Data_Access_Exporsure_cls {
    public static list<WK_Exporsure__c> getLinkedExporsures(Decimal economicId){
        List<WK_Exporsure__c> getLinkedExporsures = [SELECT Id,Wk_Added__c, IsDeleted, Name, CurrencyIsoCode, CreatedDate, CreatedById,
                                                     LastModifiedDate, LastModifiedById, SystemModstamp, 
                                                     WK_nu_partyId__c, WK_party_name__c, 
                                                     WK_economicGroupId__c, WK_economicGroupName__c, WK_oracleAccountNumber__c, 
                                                     WK_contractNumber__c, WK_currency__c, WK_contractOec__c, WK_exposure__c, 
                                                     WK_open_Items_Ar__c, WK_days_Due_Ar__c, WK_open_Items_Dlq__c, WK_days_Due_Dlq__c, 
                                                     vertical__c, WK_nbv__c 
                                                     FROM WK_Exporsure__c
                                                     WHERE WK_economicGroupId__c =:economicId ];
        return getLinkedExporsures;
    }

    public static WK_Exporsure__c getExposure(string contractNumber){
        WK_Exporsure__c exposure =[select Id, WK_contractNumber__c, Name, WK_party_name__c 
                                    from WK_Exporsure__c where WK_contractNumber__c =:contractNumber ];
        return exposure;
    }

    public static list<WK_Exporsure__c> getExposuresByIds(list<string> ids){
        list<WK_Exporsure__c> exposures =[select Id, WK_contractNumber__c, Name, WK_party_name__c 
                                    from WK_Exporsure__c where Id IN:ids ];
        return exposures;
    }
}