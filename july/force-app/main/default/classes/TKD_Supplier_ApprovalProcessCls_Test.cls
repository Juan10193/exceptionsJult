@Istest
public class TKD_Supplier_ApprovalProcessCls_Test {
    @testSetup static void setup(){
        //creation of EIV parameters
        list<EIV_Parameter__c> parameters = Test.loadData(EIV_Parameter__c.sobjectType, 'parametrosTest');
        System.assert(parameters.size()>0);
    }
    @Istest static void getStatusSuppInApproval_Test(){
        Takedowns_Contingency_plan__c  tkd = Data_Factory_Takedown_Test.createTakedown('OPERFIN-FIJA', 'Marquillos', 'FAK123HRJ12');
        Supplier_in_approval__c suppInApp = Data_Factory_SupplierInApproval_Test.createNewSupplierInApprovalNoTKD(tkd.Id);
        TKD_Supplier_ApprovalProcessController.getStatusSuppInApproval(suppInApp.TKD_rb_SupplierInApproval__c);
        List<Supplier_in_approval__c> LtsStatusSupp = [SELECT Id,tkd_ls_Stage_AML__c, tkd_ls_Stage_Supplier__c, TKD_tx_Hits__c,TKD_rb_SupplierInApproval__c FROM Supplier_in_approval__c WHERE TKD_rb_SupplierInApproval__c=: suppInApp.TKD_rb_SupplierInApproval__c limit 1];
        System.assertEquals(1,LtsStatusSupp.size());  
    } 
}