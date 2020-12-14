@Istest
public class Data_Factory_SupplierInApproval_Test {
    
    public static Supplier_in_approval__c createNewSupplierInApprovalNoTKD(Id takedownId){ 
        Supplier_in_approval__c suppInApp = new Supplier_in_approval__c();
        suppInApp.tkd_ls_Stage__c='NEW';
        suppInApp.tkd_ls_Stage_AML__c='NEW';
        suppInApp.tkd_ls_Stage_Supplier__c='NEW';
        suppInApp.TKD_rb_SupplierInApproval__c=takedownId;
        insert suppInApp;
        System.debug('Supplier In Approval Creada: '+ suppInApp);
        return suppInApp;        
    }
   
    
}