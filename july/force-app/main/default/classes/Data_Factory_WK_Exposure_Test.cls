/**
 * @File Name          : Data_Factory_WK_Exposure_Test.cls
 * @Description        : 
 * @Author             : juandedios.hernandez@engeniumcapital.com
 * @Group              : 
 * @Last Modified By   : juandedios.hernandez@engeniumcapital.com
 * @Last Modified On   : 30/9/2019 22:11:28
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    30/9/2019   juandedios.hernandez@engeniumcapital.com     Initial Version
**/
@Istest
public  class Data_Factory_WK_Exposure_Test {
    public static WK_Exporsure__c createNewExposure( Double economicId, String econmGrpName){
        WK_Exporsure__c exposure = new WK_Exporsure__c();
        exposure.WK_economicGroupId__c =economicId;
        exposure.WK_economicGroupName__c=econmGrpName;
        exposure.Contract_Number__c ='12313';
        //---
        exposure.WK_party_name__c='';
        //exposure.WK_economicGroupName__c= exposure.WK_economicGroupName__c;
        exposure.WK_oracleAccountNumber__c= '';
        //exposure.Contract_Number__c= exposure.Contract_Number__c;
        exposure.WK_currency__c= '';
        exposure.Name= '';
        exposure.WK_contractOec__c= 1.4;
        exposure.WK_exposure__c= '';
        exposure.WK_nbv__c= 1.5;
        exposure.WK_open_Items_Ar__c= 1.6;
        exposure.WK_days_Due_Ar__c= 1.7; 
        exposure.WK_open_Items_Dlq__c= 1.8;
        exposure.WK_days_Due_Dlq__c= 1.9;
        exposure.vertical__c= '';
        //---
        insert exposure;
        return exposure;
    }
}