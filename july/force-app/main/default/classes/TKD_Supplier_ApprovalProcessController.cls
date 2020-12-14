/**
 * @File Name          : TKD_Supplier_ApprovalProcessController.cls
 * @Description        : 
 * @Author             : eduardo.villegas@engeniumcapital.com
 * @Group              : 
 * @Last Modified By   : eduardo.villegas@engeniumcapital.com
 * @Last Modified On   : 11/12/2019 11:44:32
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    11/12/2019   eduardo.villegas@engeniumcapital.com     Initial Version
**/
public with sharing class TKD_Supplier_ApprovalProcessController {
    public TKD_Supplier_ApprovalProcessController() {

    }
    @AuraEnabled
    public static Supplier_in_approval__c getStatusSuppInApproval(String recordId){
       System.debug('::::::: getStatusSuppInApproval ::::::: ' + recordId);
       Supplier_in_approval__c statusSupp = [SELECT Id,
                                             	tkd_ls_Stage_AML__c,
                                             	tkd_ls_Stage_Supplier__c,
                                             	TKD_tx_Hits__c, 
                                             	TKD_rb_SupplierInApproval__c
                                             	FROM Supplier_in_approval__c 
                                             	WHERE TKD_rb_SupplierInApproval__c=: recordId limit 1];
        System.debug('::::::: getStatusSuppInApproval Return :::::::' + statusSupp );
        return statusSupp; 
    }  
}