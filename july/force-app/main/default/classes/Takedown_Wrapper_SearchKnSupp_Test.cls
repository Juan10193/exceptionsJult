@isTest
public class Takedown_Wrapper_SearchKnSupp_Test { 
    @isTest
    public static void responseSearchKnownSupplier(){
        Takedown_Wrapper_SearchKnownSuppliers.responseSearchKnownSupplier Test_RSKSupp = new Takedown_Wrapper_SearchKnownSuppliers.responseSearchKnownSupplier();
		Takedown_Wrapper_SearchKnownSuppliers.Suppliers Test_SuppS = new Takedown_Wrapper_SearchKnownSuppliers.Suppliers();
        Takedown_Wrapper_SearchKnownSuppliers.Status Test_Sta = new Takedown_Wrapper_SearchKnownSuppliers.Status();
        Test_RSKSupp.status = Test_Sta;
        Test_RSKSupp.suppliers = Test_SuppS;
    }
    @isTest
    public static void Suppliers(){
        Takedown_Wrapper_SearchKnownSuppliers.Suppliers Test_SuppS = new Takedown_Wrapper_SearchKnownSuppliers.Suppliers();
		Test_SuppS.supplier = new list <Takedown_Wrapper_SearchKnownSuppliers.Supplier>();
    }
    @isTest
    public static void Supplier(){        
        Takedown_Wrapper_SearchKnownSuppliers.Supplier Test_Supp = new Takedown_Wrapper_SearchKnownSuppliers.Supplier();
		Test_Supp.vendorId = 350534;
		Test_Supp.vatRegistrationNum = '3423131';
        Test_Supp.vendorSiteId = 948219;
		Test_Supp.vendorName = 'Comercial';
		Test_Supp.segment1 = 'Segqd212';
		Test_Supp.partyId = 321094;
		Test_Supp.activeFlag = 'True';
		Test_Supp.vendorSiteCode = '324452';
		Test_Supp.orgId = 954382;
		Test_Supp.organizationName = 'Engen Capital';
		Test_Supp.paymentCurrencyCode = '482303';
		Test_Supp.vatCode = '094302';
		Test_Supp.siteActiveFlag = 'True';
    }
    @isTest
    public static void Status(){        
        Takedown_Wrapper_SearchKnownSuppliers.Status Test_Sta = new Takedown_Wrapper_SearchKnownSuppliers.Status();
		Test_Sta.code = '503001110';
		Test_Sta.message = 'Test de prueba :)';
		Test_Sta.detail = 'Para que pase la clase con el test';
    }
}