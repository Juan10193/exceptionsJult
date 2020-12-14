public with sharing class Data_Access_Supplier_in_approval {
    public static List<Supplier_in_approval__c> getSupplierInApprovalByTKDID(String recordId){
        List<Supplier_in_approval__c> listSupplier_in_approval = new List<Supplier_in_approval__c>();
        if (Schema.sObjectType.Supplier_in_approval__c.isAccessible()){
            for(Supplier_in_approval__c Supplier_in_approval : [SELECT Id, Name, TKD_Documments_Validation__c, TKD_rb_SupplierInApproval__c, TKD_tx_Hits__c, 
                                                       TKD_tx_IdSupplier__c, tkd_ls_Stage_AML__c, tkd_ls_Stage_Supplier__c, tkd_ls_Stage__c, TKD_re_Total_suppliers__c 
                                                       FROM Supplier_in_approval__c 
                    									where TKD_rb_SupplierInApproval__c = :recordId]){
                listSupplier_in_approval.add(Supplier_in_approval);
            }
        }
        return listSupplier_in_approval;
    }


    public static Supplier_in_approval__c getSupplierInApprovalWithSuppliersById(string recordId){
        Supplier_in_approval__c supplierInApproval = [SELECT Id, OwnerId, Owner.Name,CreatedBy.Name,LastModifiedBy.Name, IsDeleted, Name, 
        CurrencyIsoCode, LastActivityDate, LastViewedDate, LastReferencedDate, TKD_rb_SupplierInApproval__r.Name,
        TKD_Documments_Validation__c, TKD_Validation_Hits__c, 
        TKD_ca_Invoices_with_suppliers__c, TKD_rb_SupplierInApproval__c, 
        TKD_tx_Hits__c, TKD_tx_IdSupplier__c, tkd_ls_Stage_AML__c, 
        tkd_ls_Stage_Supplier__c, tkd_ls_Stage__c, TKD_re_Total_suppliers__c, Days_To_AMAG_Approval__c, 
        Days_To_AML_Approval__c, Supplier_sent__c, Suppliers_Approval_Times_Rejected__c, Suppliers_Approval_AMAG__c, 
        Suppliers_Approval_AML__c, Suppliers_Submit_for_Approval_ISC_Date__c, Time_Formula__c, Tiempo_Inicial__c, 
        Tiempo_Final__c,Dias_aprobado__c,tkd_Auto_approve_suppliers__c,Account_statement_date__c,Fecha_Estado_de_Cuenta__c,Last_Approved_supplier_date__c  FROM Supplier_in_approval__c WHERE Id=:recordId LIMIT 1];
        return supplierInApproval;
    }

    public static list<Id> getitemApprovaciones(string recordId){
        List<Id> newWorkItemIds = new List<Id>();
        for (List<ProcessInstance> pis :[Select (Select Id From Workitems) From ProcessInstance p WHERE p.TargetObjectId = :recordId AND p.Status = 'Pending']){
            for (ProcessInstance pi : pis) {
                for (List<ProcessInstanceWorkitem> wis : pi.Workitems) {
                    for (ProcessInstanceWorkitem wi : wis ) {
                        newWorkItemIds.add(wi.id);
                    }
                }           
            }
        }
        return newWorkItemIds;
    }
}