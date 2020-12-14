@isTest
public class Data_Access_Supplier_Test {
	@isTest
    public static void getSuppliersAndSitesByid(){
        EIV_Parameter__c parameters = new EIV_Parameter__c();
        parameters.name = 'fecha limite';
        parameters.EIV_tx_parameter__c = '01/12/2018';
        insert parameters;
        Takedowns_Contingency_plan__c takedown = Data_Factory_TakedownInvoice_Test.getTakedownWhitInvoice('xml');
        Supplier_in_approval__c suppInApp = new Supplier_in_approval__c();
        suppInApp.tkd_ls_Stage__c='NEW';
        suppInApp.tkd_ls_Stage_AML__c='NEW';
        suppInApp.tkd_ls_Stage_Supplier__c='NEW';
        suppInApp.TKD_rb_SupplierInApproval__c=takedown.Id;
        insert suppInApp;
        System.debug('Supplier In Approval Creada: '+ suppInApp);
        Supplier__c sup = new Supplier__c();
        sup.TKD_pd_Supplier_in_approval__c = suppInApp.id;
        insert sup;
        TKD_Site__c site = new TKD_Site__c();
        site.Supplier__c = sup.id;
        site.TKD_Vat_code__c = 'AP_IVA_16';
        insert site;
        list<id> setIds = new list<id>();
       	setIds.add(takedown.Id);
        set<id> setIdss = new set<id>();
       	setIdss.add(takedown.Id);
        Data_Access_Supplier.getSuppliersAndSitesByid(takedown.id);
        Data_Access_Supplier.getSuppliersAndSitesBySuppid(sup.Id);
        Data_Access_Supplier.getSuppliersAndSitesBySuppIds(setIdss);
    } 
    
}