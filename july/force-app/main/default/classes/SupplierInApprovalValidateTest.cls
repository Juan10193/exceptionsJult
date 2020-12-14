@Istest
public class SupplierInApprovalValidateTest {
	@testSetup static void setup(){
        //creation of EIV parameters
        list<EIV_Parameter__c> parameters = Test.loadData(EIV_Parameter__c.sobjectType, 'parametrosTest');
        System.assert(parameters.size()>0);
    }
    
      @Istest
    static void saveListSitessTest(){
         Takedowns_Contingency_plan__c  tkd = Data_Factory_Takedown_Test.createTakedownNowkopp('AFINAN-FIJA', 'Paps', 'RFC102990RB');
        Supplier_in_approval__c supplierInApproval = Data_Factory_SupplierInApproval_Test.createNewSupplierInApprovalNoTKD(tkd.Id);
        supplierInApproval.TKD_rb_SupplierInApproval__c = tkd.Id;
        update supplierInApproval;
         test.startTest();
        	supplierInApproval.Fecha_Estado_de_Cuenta__c = Date.today();
        	supplierInApproval.Account_statement_date__c = Date.today();
        	supplierInApproval.tkd_ls_Stage_Supplier__c ='IN PROCESS';
        	update supplierInApproval;
         test.stopTest();
        
    }
    
}