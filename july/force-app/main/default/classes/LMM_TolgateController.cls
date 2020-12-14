/**
 * @File Name          : TKD_ChecklistTolgate1Controller.cls
 * @Description        : Controlador para LWC DEL TOLGATE 1 CHECKLIST
 * @Author             : juandedios.hernandez@engeniumcapital.com
 * @Group              : LWC TKD
 * @Last Modified By   : juandedios.hernandez@engeniumcapital.com
 * @Last Modified On   : 30/10/2019 12:36:27
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    30/10/2019   juandedios.hernandez@engeniumcapital.com     Initial Version
**/
public without sharing class LMM_TolgateController {

   
   @AuraEnabled(cacheable=false)
   public static string requestToContent(string encritpData){
        return  LMM_WS_Tollgate_cls.searchRequestId(encritpData);
       
   }

   @AuraEnabled(cacheable=false)
   public static void validateTollgate(string recordId){
      system.debug('MERMELADA: ' + recordId);
      Id idtoUpdate = Id.valueOf(recordId);
      Sobject obj = idtoUpdate.getSObjectType().newSObject(idtoUpdate);
      obj.put('CMS_Documents__c', true);
      update obj;
   }


   @AuraEnabled(cacheable=false)
   public static Boolean unlockRecord(string recordId, string objectApiName){
      string query = 'Select id  FROM ' + objectApiName + ' WHERE Id=' + '\'' + recordId + '\'';
      system.debug('query para desbloquear: ' + query);
      List<SObject> objeto = Database.query(query);
      if(objeto.size()>0){
         if(Approval.isLocked(recordId)){
            system.debug('el registro esta bloqueado');
            Approval.UnlockResult[] unlockedRersults = Approval.unlock(objeto, false);
            for(Approval.UnlockResult  ulr : unlockedRersults) {
               if (ulr.isSuccess()) {
                   //Operation was successful, so get the ID of the record that was processed
                   System.debug('Successfully unloked record with ID: ' + ulr.getId());
               }
               else {
                   //Operation failed, so get all errors                
                   for(Database.Error err : ulr.getErrors()) {
                       System.debug('The following error has occurred.');                    
                       System.debug(err.getStatusCode() + ': ' + err.getMessage());
                       System.debug('Case fields that affected this error: ' + err.getFields());
                   }
               }
           }
           return true;
         }else{
            system.debug('El registro no esta bloqueado');
            return false;
         }
      }

      return false;
   }

   @AuraEnabled(cacheable=false)
   public static Boolean lockRecord(string recordId, string objectApiName){
      string query = 'Select id  FROM '  + objectApiName + ' WHERE Id=' + '\'' + recordId + '\'';
     
      List<SObject> objeto = Database.query(query);
      if(objeto.size()>0){
         if(!Approval.isLocked(recordId)){
            system.debug('el registro no esta bloqueado');
            Approval.LockResult[] lockedRersults = Approval.lock(objeto, false);
            for(Approval.LockResult  ulr : lockedRersults) {
               if (ulr.isSuccess()) {
                   //Operation was successful, so get the ID of the record that was processed
                   System.debug('Successfully locked record with ID: ' + ulr.getId());
               }
               else {
                   //Operation failed, so get all errors                
                   for(Database.Error err : ulr.getErrors()) {
                       System.debug('The following error has occurred.');                    
                       System.debug(err.getStatusCode() + ': ' + err.getMessage());
                       System.debug('Case fields that affected this error: ' + err.getFields());
                   }
               }
           }
           return true;
         }else{
            system.debug('El registro ya  esta bloqueado');
            return false;
         }
      }
      return false;
   }

   @AuraEnabled(cacheable=false)
   public static void updateFieldValidation(string recordId, string objectApiName, string fieldtoUpdate){
      string query = 'Select Id, '+ fieldtoUpdate + ' FROM' + ' ' + objectApiName + ' WHERE Id=' + '\'' + recordId + '\'';
      List<SObject> objeto = Database.query(query);
      if(objeto.size()>0){
         objeto.get(0).put(fieldtoUpdate, true);
         Schema.SObjectType sObjectType = objeto.getSObjectType();
         String listType = 'List<' + sObjectType + '>';
         List<SObject> castRecords = (List<SObject>)Type.forName(listType).newInstance();
         castRecords.addAll(objeto);
         System.debug('castrecords');
         system.debug(castRecords);
         update castRecords;
      }

   }

}