@Istest
public class Takedown_Callout_SupplierInCATest {
    @Istest
    static void FindSupplierForNameOrRFCTest(){
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
        
        string testEndpoint ='callout:'+ namecred + '/EcAmlSbDat/AmlRs/aml/hits/queries/nameorRfc';
        Takedown_Wrapper_SupplierInCA.responseAmlHits findSupplier = new Takedown_Wrapper_SupplierInCA.responseAmlHits();
        String getResponse = JSON.serialize(findSupplier);
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseHandler_cls(testEndpoint, getResponse, 'GET', 'application/json', 200));
        Takedown_Callout_SupplierInCA.FindSupplierForNameOrRFC(getResponse);
    }
    
    @Istest
    static void detKnownSupplierSearchTest(){
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
        
        string testEndpoint ='callout:'+namecred+'/SupplierAPI/v2.0/suppliers/details?vendorName='+EncodingUtil.urlEncode('SearchByName', 'UTF-8')+'&rfc='+'SearchByRFC';  
        Takedown_Wrapper_DetSearchKnownSuppliers.responseDetSearchKnownSupplier detKnownSupplierSearch = new Takedown_Wrapper_DetSearchKnownSuppliers.responseDetSearchKnownSupplier();
        String getResponse =JSON.serialize(detKnownSupplierSearch);
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseHandler_cls(testEndpoint, getResponse, 'GET', 'application/json', 200));
        Takedown_Callout_SupplierInCA.detKnownSupplierSearch('SearchByRFC', 'SearchByName');
    }
    
    @iSTEST
    static void knownSupplierSearchTest(){
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
        
        String testEndpoint ='callout:'+namecred+'/SupplierAPI/v2.0/suppliers/details?vendorName=' + EncodingUtil.urlEncode('SearchByName', 'UTF-8') +'&rfc='+'SearchByRFC' +'&currencyCode='+ 'SearchByCurrency' +'&vatCode=' + 'SearchByTaxCode'; 
         String getResponse ='Dummy data';
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseHandler_cls(testEndpoint, getResponse, 'GET', 'application/json', 200));
        Takedown_Callout_SupplierInCA.knownSupplierSearch('SearchByRFC', 'SearchByName', 'SearchByCurrency', 'SearchByTaxCode');
    }
    
}