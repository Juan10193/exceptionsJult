@Istest
public class TKD_PostSuppliersToOracleTest {
    @testSetup static void setup(){
        //creation of EIV parameters
        list<EIV_Parameter__c> parameters = Test.loadData(EIV_Parameter__c.sobjectType, 'parametrosTest');
        System.assert(parameters.size()>0);
        test.startTest();
        Takedowns_Contingency_plan__c  tkd = Data_Factory_Takedown_Test.createTakedownNowkopp('AFINAN-FIJA', 'Papus', 'RFC102990RB');
       
        Supplier_in_approval__c supplierInApproval = Data_Factory_SupplierInApproval_Test.createNewSupplierInApprovalNoTKD(tkd.Id);
        list<Id> suppliersInApprovalIds = new list<Id>();
        suppliersInApprovalIds.add(supplierInApproval.Id);
        
        Supplier__c supplier =  Data_Factory_SupplierTest.createSupplier('Juanchos', 'RFC102912BN10', supplierInApproval.Id); 
        TKD_Site__c site = Data_Factory_SiteTest.createSite(tkd, supplier.Id);
        Bank_Account__c bnkAcc = Data_Factory_BankAccountTest.createBankAccountSite('12356789763528930', 'Dummys Account', site.Id);
        list<Bank_Account__c> bankaccounts = new list<Bank_Account__c>();
        bankaccounts.add(bnkAcc);
        
        Contact con = Data_Factory_ContactSupplier.createSupplierContact('Juanchi', 'Hernandez', site.Id);
        list<Contact> contacts = new list<Contact>();
        contacts.add(con);
        list <Supplier__c> suppliers  = new list<Supplier__c>();
        suppliers.add(supplier);
        list <TKD_Site__c> sites = new list <TKD_Site__c>();
        sites.add(site);
        test.stopTest();
    }
    @Istest
    static void TKD_PostSuppliersToOracleinstanceTest(){
        list<Supplier_in_approval__c> suppliersInAp  = [SELECT Id from Supplier_in_approval__c];
        set<Id>suppliersInApprovalIds = new set<Id>();
        for(Supplier_in_approval__c sup : suppliersInAP){
            Id suppId = sup.Id;
            suppliersInApprovalIds.add(suppId);
        }
        
        string sandbox = GetSandboxType.getTypeOfSandbox();
        string namecred;
        
        if(sandbox == 'DEV'){
            namecred = 'getsServiceUrl';
        }
        if(sandbox == 'QA'){
            namecred = 'getsServiceUrlQa';
        }
        if(sandbox =='PROD'){
            namecred = 'getsServiceUrlProd';
        }            
        string testEndpoint = 'callout:'+ namecred + '/SupplierAPI/v2.0/suppliers';
        String getResponse ='Respuesta dumy';
        test.startTest();
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseHandler_cls(testEndpoint, getResponse, 'POST', 'application/json', 200));
        TKD_PostSuppliersToOracle postsupp = new TKD_PostSuppliersToOracle(suppliersInApprovalIds);
        Database.executeBatch(postsupp);
        test.stopTest();
       
    }
    
}