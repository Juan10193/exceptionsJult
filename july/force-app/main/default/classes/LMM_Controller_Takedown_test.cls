@isTest
public class LMM_Controller_Takedown_test {
 
          @isTest
        public static void CargaTakedown1(){
        EIV_Parameter__c parameters = new EIV_Parameter__c();
        parameters.name = 'fecha limite';
        parameters.EIV_tx_parameter__c = '01/12/2018';
        insert parameters;
        Takedowns_Contingency_plan__c takedown = Data_Factory_TakedownInvoice_Test.getTakedownWhitInvoice('xml');
        Supplier_in_approval__c suppInApp = new Supplier_in_approval__c();
        suppInApp.tkd_ls_Stage__c='New';
        suppInApp.tkd_ls_Stage_AML__c='New';
        suppInApp.tkd_ls_Stage_Supplier__c='New';
        suppInApp.TKD_rb_SupplierInApproval__c=takedown.Id;
        insert suppInApp;
        Supplier__c sup = new Supplier__c();
        sup.TKD_Monto_Invoice__c=10000;
        sup.TKD_pd_Supplier_in_approval__c = suppInApp.id;
        insert sup;
        TKD_Site__c site = new TKD_Site__c();
        site.Supplier__c = sup.id;
        site.TKD_Vat_code__c = 'AP_IVA_16';
        insert site;
        Takedown_Invoice__c  invoice =new Takedown_Invoice__c();
        invoice.TKD_pd_Takedown_CP__c = takedown.Id;
        invoice.Name = 'Name';
        invoice.LMM_nu_Total_assets_cost__c=70000;
        insert invoice;
        ApexPages.StandardController sc = new ApexPages.StandardController(takedown);
        LMM_Controller_Takedown Tkd = new LMM_Controller_Takedown(sc);
        Tkd.CargaTakedown();
        Tkd.CargaSuppliersTkd();

    }    
}