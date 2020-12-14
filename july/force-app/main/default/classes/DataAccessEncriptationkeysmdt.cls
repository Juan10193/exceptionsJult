/**
 * @File Name          : Data_Access_Encriptationkeys__mdt_cls.cls
 * @Description        : 
 * @Author             : jhernandez@anivia.mx
 * @Group              : 
 * @Last Modified By   : jhernandez@anivia.mx
 * @Last Modified On   : 20/8/2019 2:48:50
 * @Modification Log   : 
 *==============================================================================
 * Ver         Date                     Author      		      Modification
 *==============================================================================
 * 1.0    16/8/2019 9:13:52   jhernandez@anivia.mx     Initial Version
**/
public with sharing class DataAccessEncriptationkeysmdt{
    @AuraEnabled(cacheable = true)
    /**
    * @description
    * @author jhernandez@anivia.mx | 20/8/2019
    * @return EncriptationKeys__mdt
    */
    public static EncriptationKeys__mdt getEncriptationDocumentsV2(){
        EncriptationKeys__mdt enkriptationParams = [SELECT Id, DeveloperName, MasterLabel, Language, NamespacePrefix, 
                                                    Label, QualifiedApiName, EncriptationType__c, EncriptationKey__c 
                                                    FROM EncriptationKeys__mdt where DeveloperName ='componente_documentosv2'][0];

        return enkriptationParams;
    }
}