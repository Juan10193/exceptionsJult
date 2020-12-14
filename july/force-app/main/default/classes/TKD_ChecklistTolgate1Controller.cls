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
public without sharing class TKD_ChecklistTolgate1Controller {
   /**
   * @description 
   * @author juandedios.hernandez@engeniumcapital.com | 30/10/2019 
   * @param takedownId RecordId Del Takedown
   * @return lista de legals assesments en el takedown;
   **/
   @AuraEnabled(cacheable=false)
   public static list<Legal_Assessment_In_TD__c> fetchLasInTKD(string takedownId){
      return Data_Access_LegalAssessmentInTD_cls.getLATDbyTDId(takedownId);
   }
    
   /**
   * @description 
   * @author eduardo.villegas@engeniumcapital.com | 30/10/2019 
   * @param takedownId RecordId Del Takedown
   * @return List<Takedown_Invoice__c>
   **/
   @AuraEnabled(cacheable=false)
   public static list<Takedown_Invoice__c> getTakedownInvoices(string takedownId){
       List<String> listFilterDocType = new List<String>{'XML'};
      return Data_Access_Takedown_Invoice_cls.getDocumentList(takedownId,listFilterDocType);
   }
    
    
   @AuraEnabled(cacheable=false)
   public static list<ES2_Obj_EntityMasterInCreditApproval__c> getMasterEntity(string cAId){
       return Data_Access_EntityMastInCApproval_cls.getEntitiesMasterByCAId(cAId); 
   }
   @AuraEnabled(cacheable=false)
   public static list<Supplier_in_approval__c> getSupplierInApprovalStatus(id takedownId){
       return Data_Access_Supplier_in_approval.getSupplierInApprovalByTKDID(takedownId);
   }
   
   @AuraEnabled(cacheable=false)
   public static string requestToContent(string encritpData){
        return  Takedown_WS_Tollgate_cls.searchRequestId(encritpData);
       
   }
    

    @AuraEnabled
    public static list<TKD_PreTollgate1_Value__mdt> getRequiredForPretollgate1(string prodcutType){
        return DATA_ACCESS_TKDPretollgate1Value_mdt.getValidationsByProduct(prodcutType);
    }

    @AuraEnabled(cacheable=false)
    public static void unlockForUpdate(string takedownId){
        list<Takedowns_Contingency_plan__c> takedown = [SELECT Id FROM Takedowns_Contingency_plan__c WHERE Id=:takedownId];
        if(Approval.isLocked(takedownId)){
                system.debug('el registro esta bloqueado');
                Approval.UnlockResult[] unlockedRersults = Approval.unlock(takedown, false);
            for(Approval.UnlockResult  ulr : unlockedRersults) {
                if (ulr.isSuccess()) {
                    //Operation was successful, so get the ID of the record that was processed
                    System.debug('Successfully locked account with ID: ' + ulr.getId());
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
        }else{
            system.debug('El registro no esta bloqueado');
        }
        
    }

    @AuraEnabled(cacheable=false)
    public static void lockForApproval(string takedownId){
        list<Takedowns_Contingency_plan__c> takedown = [SELECT Id FROM Takedowns_Contingency_plan__c WHERE Id=:takedownId];
        Approval.LockResult[] lrList = Approval.lock(takedown, false);
        if(!Approval.isLocked(takedownId)){
            system.debug('el registro no esta bloqueado para unlock');
            for(Approval.LockResult lr : lrList) {
                if (lr.isSuccess()) {
                    // Operation was successful, so get the ID of the record that was processed
                    System.debug('Successfully locked Takedown with ID: ' + lr.getId());
                }
                else {
                    // Operation failed, so get all errors                
                    for(Database.Error err : lr.getErrors()) {
                        System.debug('The following error has occurred.');                    
                        System.debug(err.getStatusCode() + ': ' + err.getMessage());
                        System.debug('Takedowns fields that affected this error: ' + err.getFields());
                    }
                }
            }
        }else{

            System.debug('el registro no esta bloqueado para unlock');
        }
       
    }
    
    @AuraEnabled(cacheable=true)
    public static boolean opportunityValidDate(date opportunityExpirationDate){
        return date.today() < opportunityExpirationDate ? true : false;
    }

    @AuraEnabled(cacheable=false)
    public static void validateSuppDocs(string recordId, boolean validation){
        Takedowns_Contingency_plan__c tkd = [Select Id, TKD_Suppilers_Documents__c from Takedowns_Contingency_plan__c where Id =:recordId][0];
        tkd.TKD_Suppilers_Documents__c = validation;
        update tkd;
    }
}