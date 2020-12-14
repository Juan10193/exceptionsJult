/**
 * @File Name          : Data_Access_SuppliersInTakedown_cls.cls
 * @Description        : 
 * @Author             : jhernandez@anivia.mx
 * @Group              : 
 * @Last Modified By   : jhernandez@anivia.mx
 * @Last Modified On   : 11/27/2019, 2:00:06 AM
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    11/5/2019   jhernandez@anivia.mx     Initial Version
**/
public with sharing class Data_Access_SuppliersInTakedown_cls {

    @AuraEnabled
    public static string idSupplierInApp(string recordId){
        Supplier_in_approval__c ids= null;
        string idInSuppApp = null;
        System.debug('RecordID : IdSuppInApp ' + recordId);
         if(Schema.sObjectType.Supplier_in_approval__c.isAccessible()){
           
                 ids = [  SELECT Id
                              FROM Supplier_in_approval__c
                                    where TKD_rb_SupplierInApproval__c =: recordId ];
                                    System.debug('Ids:::: '+ ids);
            idInSuppApp = ids.Id; 
            
                   System.debug('::: idInSuppApp Mia :::' + idInSuppApp);                 
        }else{
            system.debug(LoggingLevel.ERROR, 'Error: Insufficient Access');
        }
        System.debug('::: idInSuppApp antes :::' + idInSuppApp); 
        return idInSuppApp;

    }    



    @AuraEnabled
    public static List<Supplier__c> supplierInTKD(string idSupp){
        System.debug('RecordID : supplierI why : ' + idSupp);
         if(Schema.sObjectType.Supplier__c.isAccessible()){
            return [SELECT Id,
                           TKD_tx_Vat_Registration_Num__c,
                           Name,
                           TKD_pd_Supplier_in_approval__c  
                           FROM Supplier__c
                                where TKD_pd_Supplier_in_approval__c  =: idSupp ];
        }else{
            system.debug(LoggingLevel.ERROR, 'Error: Insufficient Access');
        }
        return null;

    } 

    @AuraEnabled
    public static List<Supplier__c> generalTKD(string paramRecordId){
        System.debug('general : '+ paramRecordId);
        string id= idSupplierInApp(paramRecordId);
        List<Supplier__c> lstResult = supplierInTKD(id); 
        
        return lstResult;

    }     
    
}