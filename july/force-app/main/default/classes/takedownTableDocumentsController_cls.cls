/**
 * @File Name          : takedownTableDocumentsController_cls.cls
 * @Description        : 
 * @Author             : eduardo.villegas@engeniumcapital.com
 * @Group              : 
 * @Last Modified By   : eduardo.villegas@engeniumcapital.com
 * @Last Modified On   : 22/9/2019 23:13:09
 * @Modification Log   : 
 *==============================================================================
 * Ver         Date                     Author      		      Modification
 *==============================================================================
 * 1.0    10/7/2019 13:32:22   eduardo.villegas@engeniumcapital.com     Initial Version
**/
public with sharing class takedownTableDocumentsController_cls {
    public class applicationException extends Exception {}
    
    /**
    * @description
    * @author eduardo.villegas@engeniumcapital.com | 22/8/2019
    * @param String recordId
    * @return List<Takedown_Invoice__c>
    */
    @AuraEnabled(cacheable=true)
    public static List<Takedown_Invoice__c> getDocumentList(String recordId,List<String> listFilterDocType) {
        system.debug('listFilterDocType ' + listFilterDocType );
        return Data_Access_Takedown_Invoice_cls.getDocumentList(recordId,listFilterDocType);
    }

    
    /**
    * @description
    * @author jhernandez@anivia.mx | 10/7/2019
    * @param string takedownId
    * @param string documentId
    * @return void
    */
    @AuraEnabled(cacheable=false)
    public static void deleteInvoice(string idInvoice, string takedownDocId, boolean blockAB, boolean ButtonUnlockAndApproveShow){
        if(blockAB && ButtonUnlockAndApproveShow == false){
            if(takedownDocId == null){
                throw new applicationException('There is no document to delete');
            }
            DMLO_ContentDocument_cls.deleteTakedownDoc(takedownDocId);
            DMLO_Takedown_Invoice_cls.deleteDocumentFromInvoice(idInvoice);
        } else {
            if(takedownDocId != null)
            DMLO_ContentDocument_cls.deleteTakedownDoc(takedownDocId);
            DMLO_Takedown_Invoice_cls.deleteTakedownInvoice(idInvoice);            
            DMLO_Asset_cls.deletDocument(Data_Access_Assets_cls.getAssetsByTakedownInvoice(idInvoice));        
        }        
    }

    
    /**
    * @description
    * @author jhernandez@anivia.mx | 15/7/2019
    * @param List<Id> invoices
    * @param List<Id> documents
    * @return void
    */
    @AuraEnabled(cacheable=false)
    public static void deleteInvoices (List<Id> invoices, List<Id> documents, boolean blockAB, boolean ButtonUnlockAndApproveShow){
        system.debug('documents ' + documents);
        if(blockAB && ButtonUnlockAndApproveShow == false){
            if(documents == null){
                throw new applicationException('There is no document to delete');
            }
            DMLO_ContentDocument_cls.deleteTakedownDocs(documents);
            DMLO_Takedown_Invoice_cls.deleteDocumentFromInvoices(invoices);
        } else {
            if(documents != null)
            DMLO_ContentDocument_cls.deleteTakedownDocs(documents);
            DMLO_Takedown_Invoice_cls.deleteInvoices(invoices);            
            DMLO_Asset_cls.deletDocument(Data_Access_Assets_cls.getAssetsByTakedownInvoices(invoices));        
        }
        
    } 
    
    
    /**
    * @description
    * @author eduardo.villegas@engeniumcapital.com | 22/8/2019
    * @param string takedownInvoiceId
    * @return List<Asset>
    */
    @AuraEnabled(cacheable=true)
    public static List<Asset> getAssetBreakdown (string takedownInvoiceId){
        return Data_Access_Assets_cls.getAssetsByTakedownInvoice(takedownInvoiceId);
    } 
    
    
    /**
    * @description
    * @author eduardo.villegas@engeniumcapital.com | 22/8/2019
    * @param List<takedownTableDocumentsWrapper_cls.TableElement> listTableElement
    * @return void
    */
    @AuraEnabled(cacheable=false)
    public static void uploadAndValidateInvoices(List<takedownTableDocumentsWrapper_cls.TableElement> listTableElement){
        TakedownTableDocumentsService_cls documentsService = new TakedownTableDocumentsService_cls();        
        documentsService.validateInvoices(listTableElement);
    }
    
    /**
    * @description 
    * @author eduardo.villegas@engeniumcapital.com | 22/9/2019 
    * @param takedownID 
    * @return boolean 
    **/
    @AuraEnabled(cacheable=true)
    public static boolean haveAB(id takedownID){
        return Data_Access_Takedowns_CP_cls.getBooleanIfNotHaveAB(takedownID);
    }

    /**
    * @description 
    * @author eduardo.villegas@engeniumcapital.com | 7/2/2020 
    * @return string 
    **/
    @AuraEnabled(cacheable=true)
    public static string getProfileCurrentUser(){ 
        User userProfile = Data_Access_User_cls.getUser(userinfo.getUserId());  
        return userProfile.Profile.name;
    }
    @AuraEnabled(cacheable=true)
    public static boolean getTakedownVisibilityValidateInvoices(string profileName){ 
        boolean visibleButton = false; 
        list<TKD_Permission_to_Validate_Invoices__mdt> listTKDPermissiontoValidateInvoices = [SELECT Id, DeveloperName, MasterLabel, Language, NamespacePrefix, Label, QualifiedApiName, 
                                                                            TKD_ca_Active__c, TKD_ls_RecordType__c 
                                                                            FROM TKD_Permission_to_Validate_Invoices__mdt 
                                                            where TKD_ca_Active__c = true and Label = :profileName];
        System.debug('listTKDPermissiontoValidateInvoices ' + listTKDPermissiontoValidateInvoices);        
        if(listTKDPermissiontoValidateInvoices.size() > 0){
            visibleButton = true;
        }
        return visibleButton;
    }
    /**
    * @description La lista de metadatos retorna más de 1 si encuentra al usuario actual, esto significa
    *              que el usua tiene permisos para ver el botón se submit to review, por lo tanto
                   el método retorna true para indicar que si tiene permisos 
    * @author eduardo.villegas@engeniumcapital.com | 29/1/2020 
    * @return Takedown_Visibility_Object__mdt 
    **/
    @AuraEnabled(cacheable=true)
    public static boolean getTakedownVisibilityISCSubmit(string profileName){ 
        boolean visibleButton = false; 
        list<TKD_Notify_to_Prebook_setting__mdt> listNotifyToPrebookSetting = [SELECT Id, DeveloperName, MasterLabel, Language, NamespacePrefix, Label, 
                                                            QualifiedApiName, TKD_ca_Active__c, TKD_ls_RecordType__c 
                                                            FROM TKD_Notify_to_Prebook_setting__mdt 
                                                            where TKD_ca_Active__c = true and Label = :profileName];
        System.debug('listNotifyToPrebookSetting ' + listNotifyToPrebookSetting);        
        if(listNotifyToPrebookSetting.size() > 0){
            visibleButton = true;
        }
        return visibleButton;
    }
    
    /**
    * @description 
    * @author eduardo.villegas@engeniumcapital.com | 29/1/2020 
    * @return boolean 
    **/
    @AuraEnabled(cacheable=true)
    public static boolean getTakedownVisibilityBlockAB(string profileName){ 
        boolean visibleButton = false;
        list<TKD_Unlock_AB_setting__mdt> listUnlockABSetting = [SELECT Id, DeveloperName, MasterLabel, Language, NamespacePrefix, Label, 
                                                            QualifiedApiName, TKD_ca_Active__c, TKD_ls_RecordType__c 
                                                            FROM TKD_Unlock_AB_setting__mdt 
                                                            where TKD_ca_Active__c = true and Label = :profileName];
        System.debug('listUnlockABSetting ' + listUnlockABSetting);
        if(listUnlockABSetting.size() > 0){
            visibleButton = true;
        }
        return visibleButton;
    }
    
    
    @AuraEnabled(cacheable=false)
    public static void saveReferenciaFactura(List<Takedown_Invoice__c> rejectInvoice) {
        System.debug(JSON.serialize(rejectInvoice));
        if(rejectInvoice.size()>0) {
            update rejectInvoice;
        }
    }
    
    @AuraEnabled(cacheable=false)
    public static void uploadAndValidateRefactura(List<takedownTableDocumentsWrapper_cls.TableElement> listTableElement){
        TakedownTableDocumentsService_cls documentsService = new TakedownTableDocumentsService_cls();        
        documentsService.validateRefactura(listTableElement);
    }
}