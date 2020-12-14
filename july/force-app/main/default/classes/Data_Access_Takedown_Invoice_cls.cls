/**
 * @File Name          : Data_Access_Takedown_Invoice_cls.cls
 * @Description        : 
 * @Author             : eduardo.villegas@engeniumcapital.com
 * @Group              : 
 * @Last Modified By   : eduardo.villegas@engeniumcapital.com
 * @Last Modified On   : 28/10/2019 22:15:20
 * @Modification Log   : 
 *==============================================================================
 * Ver         Date                     Author      		      Modification
 *==============================================================================
 * 1.0    10/7/2019 9:52:27   jvillegas@freewayconsulting.com     Initial Version
**/

public with sharing class Data_Access_Takedown_Invoice_cls {
    public class applicationException extends Exception {}
    /**
    * @description
    * @author jvillegas@freewayconsulting.com | 10/7/2019
    * @param String recordId
    * @return List<Takedown_Invoice__c>
    */
    public static List<Takedown_Invoice__c> getDocumentList(String recordId,List<String> listFilterDocType){
        List<Takedown_Invoice__c> listTakedownInvoices = new List<Takedown_Invoice__c>();
        if (Schema.sObjectType.Takedown_Invoice__c.isAccessible()){
            for(Takedown_Invoice__c takedownInvoice : [SELECT TKD_pd_Takedown_CP__c, TKD_txt_Content_Version_ID__c, TKD_txt_Document_ID__c, TKD_txt_Extension__c, 
                    TKD_tl_SAT_message__c, TKD_tl_Eng_message__c, TKD_ls_SAT_Status__c, TKD_ls_Eng_Status__c, Name, Id, 
                    TKD_pd_Takedown_CP__r.TKD_ls_asset_type__c, TKD_pd_Takedown_CP__r.CPL_rb_Opp__r.AccountId 
                    FROM Takedown_Invoice__c 
                    where TKD_pd_Takedown_CP__c = :recordId and TKD_txt_Extension__c in :listFilterDocType]){
                listTakedownInvoices.add(takedownInvoice);
            }
        }
        return listTakedownInvoices;
    }
    /**
    * @description
    * @author jvillegas@freewayconsulting.com | 10/7/2019
    * @param String recordId
    * @return List<Takedown_Invoice__c>
    */
    public static List<Takedown_Invoice__c> getDocumentListByTakedownID(String recordId){
        List<Takedown_Invoice__c> listTakedownInvoices = new List<Takedown_Invoice__c>();
        if (Schema.sObjectType.Takedown_Invoice__c.isAccessible()){
            for(Takedown_Invoice__c takedownInvoice : [SELECT TKD_pd_Takedown_CP__c, TKD_txt_Content_Version_ID__c, TKD_txt_Document_ID__c, TKD_txt_Extension__c, 
                    TKD_tl_SAT_message__c, TKD_tl_Eng_message__c, TKD_ls_SAT_Status__c, TKD_ls_Eng_Status__c, Name, Id, 
                    TKD_pd_Takedown_CP__r.TKD_ls_asset_type__c, TKD_pd_Takedown_CP__r.CPL_rb_Opp__r.AccountId, MC_Rejection_Comments_txt__c, MC_Estatus_Prebook_pl__c, MC_ck_refactura__c
                    FROM Takedown_Invoice__c 
                    where TKD_pd_Takedown_CP__c = :recordId AND MC_ck_refactura__c = False]){
                listTakedownInvoices.add(takedownInvoice);
            }
        }
        return listTakedownInvoices;
    }
    
    /**
    * @description 
    * @author eduardo.villegas@engeniumcapital.com | 28/10/2019 
    * @param set<id> setIds 
    * @return set<id> 
    **/
    public static set<id> getTakedownToAvoid(set<id> setIds){
        string approvalStatus = 'action:approval';
        string closeStatus = 'action:close';
        
        set<id> setAvoidTakedown = new set<id>();
       	if(Schema.sObjectType.Takedowns_Contingency_plan__c.isAccessible()){
            for(Takedown_Invoice__c takedown : [SELECT TKD_ls_SAT_Status__c, TKD_ls_Eng_Status__c, Id 
                                                          FROM Takedown_Invoice__c 
                                                          where TKD_pd_Takedown_CP__c in :setIds 
                                                and ((TKD_ls_SAT_Status__c = :approvalStatus or TKD_ls_SAT_Status__c = :closeStatus) 
                                                     and (TKD_ls_Eng_Status__c = :approvalStatus or TKD_ls_Eng_Status__c = :closeStatus))]){
                                                              setAvoidTakedown.add(takedown.id);                                                    
                
            }
        }
        return setAvoidTakedown;
    }
    public static Takedown_Invoice__c getTakedownInvoiceById(id recordId){
        Takedown_Invoice__c takedownInvoice = new Takedown_Invoice__c();
        if (Schema.sObjectType.Takedown_Invoice__c.isAccessible()){
            for(Takedown_Invoice__c Takedown_Invoice : [SELECT Id, IsDeleted, Name, CurrencyIsoCode, CreatedDate, CreatedById, LastModifiedDate, 

                    TKD_txt_RFC__c, TKD_tx_Supplier_name__c, TKD_txt_Content_Version_ID__c, TKD_txt_Document_ID__c, 
                    TKD_txt_Extension__c, TKD_tl_SAT_message__c, TKD_tl_Eng_message__c, TKD_ls_SAT_Status__c, 
                    TKD_ls_Eng_Status__c, /*TKD_rb_Supplier__c,*/ TKD_tx_Tax_code__c 
                    FROM Takedown_Invoice__c 
                    where id = :recordId]){
                takedownInvoice = Takedown_Invoice;
            }
        }
        return takedownInvoice;
    }
    /**
    * @description
    * @author eduardo.villegas@engeniumcapital.com | 22/8/2019
    * @param id takedownInvoiceId
    * @return List<Asset>
    */
    public static List<Takedown_Invoice__c> getInvoicesBySuplierID(list<id> setSupplierID){
        List<Takedown_Invoice__c> listTakedown_Invoice = new List<Takedown_Invoice__c>();
        if(Schema.sObjectType.Asset.isAccessible()){
            listTakedown_Invoice = [SELECT TKD_pd_Takedown_CP__c, TKD_txt_RFC__c, TKD_tx_Supplier_name__c, TKD_txt_Content_Version_ID__c, 
                                  TKD_txt_Document_ID__c, TKD_txt_Extension__c, TKD_tl_SAT_message__c, TKD_tl_Eng_message__c, 
                                  TKD_ls_SAT_Status__c, TKD_ls_Eng_Status__c, TKD_tx_Tax_code__c, Tkd_rb_Alternative_supplier__c, TKD_rb_Supplier__c, Id,
                                  Name, MC_Rejection_Comments_txt__c, MC_Estatus_Prebook_pl__c ,(SELECT id, name FROM Assets__r)
                                  FROM Takedown_Invoice__c where TKD_rb_Supplier__c in :setSupplierID];
        }else{
            //system.debug('Error: User is unauthorized to access the Asset object');
            throw new applicationException('Error: User is unauthorized to access the Asset object');
        }
        return listTakedown_Invoice;
    }
    
    public static List<Takedown_Invoice__c> getDocumentsRefacturacion(String recordId){
        List<Takedown_Invoice__c> listTakedownInvoices = new List<Takedown_Invoice__c>();
        if (Schema.sObjectType.Takedown_Invoice__c.isAccessible()){
            for(Takedown_Invoice__c takedownInvoice : [SELECT TKD_pd_Takedown_CP__c, TKD_txt_Content_Version_ID__c, TKD_txt_Document_ID__c, TKD_txt_Extension__c, 
                    TKD_tl_SAT_message__c, TKD_tl_Eng_message__c, TKD_ls_SAT_Status__c, TKD_ls_Eng_Status__c, Name, Id, LMM_nu_Total_assets_cost__c, CurrencyIsoCode, test__c, 
                    TKD_pd_Takedown_CP__r.TKD_ls_asset_type__c, TKD_pd_Takedown_CP__r.CPL_rb_Opp__r.AccountId, MC_Rejection_Comments_txt__c, MC_Estatus_Prebook_pl__c, MC_ck_refactura__c,
                    TKD_txt_refactura_message__c, TKD_pk_Refactura_status__c
                    FROM Takedown_Invoice__c 
                    where TKD_pd_Takedown_CP__c = :recordId AND MC_ck_refactura__c = True]){
                listTakedownInvoices.add(takedownInvoice);
            }
        }
        return listTakedownInvoices;
    }
    
}