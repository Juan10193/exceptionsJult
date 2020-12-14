/**
 * @File Name          : Data_Access_LegalAssessmentInTD_cls.cls
 * @Description        : 
 * @Author             : juandedios.hernandez@engeniumcapital.com
 * @Group              : 
 * @Last Modified By   : juandedios.hernandez@engeniumcapital.com
 * @Last Modified On   : 30/10/2019 12:31:51
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    30/10/2019   juandedios.hernandez@engeniumcapital.com     Initial Version
**/
public with sharing class Data_Access_LegalAssessmentInTD_cls {

    /**
    * @description Metodo para retornar LAS IN TKD por medio del Id del takedown
    * @author juandedios.hernandez@engeniumcapital.com | 30/10/2019 
    * @param takedownId El ID del takedown
    * @return List<Legal_Assessment_In_TD__c> 
    **/
    public static List<Legal_Assessment_In_TD__c > getLATDbyTDId(string takedownId){
        if(Schema.sObjectType.Legal_Assessment_In_TD__c.isAccessible()){
            return [SELECT Id, Name, TKD_rb_Takedown_CP__c, TKD_rb_Takedown_CP__r.Name, 
                    TKD_tx_RequestId__c, TKD_fm_EntityUrl__c, CreatedBy.FirstName, CreatedBy.LastName
                    FROM Legal_Assessment_In_TD__c Where TKD_rb_Takedown_CP__c =: takedownId];
        }else{
            system.debug(LoggingLevel.ERROR, 'Error: Insufficient Access to the object Legal_Assessment_In_TD__c');
            return null;
        }
    }
}