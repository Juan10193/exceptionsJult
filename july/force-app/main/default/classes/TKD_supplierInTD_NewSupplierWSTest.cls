@Istest
public class TKD_supplierInTD_NewSupplierWSTest {
	@Istest
    static void getNamedCredentialTest(){
       string namedCredential;
        switch on GetSandboxType.getTypeOfSandbox() {
            when 'DEV' {		
                namedCredential = 'TKD_Supplier_Dev';
            }	
            when 'QA' {		
                namedCredential = 'TKD_Supplier_QA';
            }
            when 'PROD' {		
                namedCredential = 'TKD_Supplier_Prod';
            }
            when else {		  
                namedCredential = 'OLInvoicesDev';
            }
        }
       string testEndpoint = 'callout:'+ namedCredential +'/SupplierAPI/v2.0/suppliers';
       string getResponse = 'Data dummy';
      Test.setMock(HttpCalloutMock.class, new MockHttpResponseHandler_cls(testEndpoint, getResponse, 'POST', 'application/json', 200));
      TKD_supplierInTD_NewSupplierWS.postSupplier('JSONDummy');
    }
}