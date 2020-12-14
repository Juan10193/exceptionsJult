@Istest
public class TKD_WS_PostSuppliersTest {
    @Istest
    static void postSupplierTest(){
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
        
        string testEndpoint = 'callout:'+ namecred +'/SupplierAPI/v2.0/suppliers';
        string getResponse = 'Data dummy';
        
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseHandler_cls(testEndpoint, getResponse, 'POST', 'application/json', 200));
        TKD_WS_PostSuppliers.postSupplier('body');
    }
}