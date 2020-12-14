/**
 * @File Name          : CotizadorController_test.cls
 * @Description        : 
 * @Author             : angel87ambher@gmail.com
 * @Group              : 
 * @Last Modified By   : angel87ambher@gmail.com
 * @Last Modified On   : 20/4/2020 21:24:22
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    20/4/2020   angel87ambher@gmail.com     Initial Version
**/
@Istest
public class CotizadorController_test {
    
    @Istest
    static void requestGet(){
        
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
        
        String testEndpoint ='callout:'+namecred+'/prm/api/v3/iniciarCotizacion?ssoid=' + '100000002' + '&key=' + 'LMM'; 
        String getResponse ='Dummy data';
        String userId='1';
        String programId='103';
        String profitTarget='17.25';
        String data='preuebbo';
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseHandler_cls(testEndpoint, getResponse, 'GET', 'application/json', 200));
        CotizadorController.requestGet(testEndpoint);
        CotizadorController.iniciarCotizacion();
        CotizadorController.calcularCotizacion(userId, programId, profitTarget, data);
    
    }
    
    @Istest
    static void getUrl(){
        
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
       // String datas='Dummiesss';
        //String testEndpoint ='callout:'+namecred+'/prm/api/v3/calcularCotizacion?userid=' + '1' + '&programid=' + '102', datas; 
        //Test.setMock(HttpCalloutMock.class, new MockHttpResponseHandler_cls( testEndpoint,'POST', 'Content-Type', 'application/json;charset=UTF-8', 200));
        CotizadorController.getUrl();
    
    }
    
    
    @Istest
    static void saveCotizacionTest(){
        EC_Quote__c a  = New EC_Quote__c();
        a.Correo_eletr_nico__c = 'a@etst.com';
        CotizadorController.saveCotizacion(a);
    }
    

}