@Istest
public class TKD_siteDetail_ControllerTest {
    @Istest
    static void getDetailSitesTest(){
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
        
        string testEndpoint = '/SupplierAPI/v2.0/suppliers/details?vendorName=' + EncodingUtil.urlEncode( 'Naranjas', 'UTF-8') +'&rfc='+'CUBANA1231RF10' +'&currencyCode='+ '' +'&vatCode=' + ''; 
        String getResponse ='Respuesta dumy';
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseHandler_cls(testEndpoint, getResponse, 'GET', 'application/json', 200));
        TKD_siteDetail_Controller.getDetailSites('1234', 'CUBANA1231RF10', 'Naranjas', '', '');
    }
    
}