@Istest
public class LMM_TolgateControllerTest {
    
    
    @Istest
    public static void requestToContentTest(){
        string sandbox = GetSandboxType.getTypeOfSandbox();
        string namecred;
        
        if(sandbox == 'DEV'){
            namecred = 'ContentManagmentDev';
        }
        if(sandbox == 'QA'){
            namecred = 'ContentManagmentQA';
        }
        if(sandbox =='PROD'){
            namecred = 'ContentManagmentProd';
        }
        string testEndpoint = 'callout:'+ namecred + '/wcmecapp/files/tollgate' ;
         String getResponse ='Respuesta dumy';
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseHandler_cls(testEndpoint, getResponse, 'POST', 'application/json', 200));
        test.startTest();
        LMM_TolgateController.requestToContent('DatosEncriptadosDumy');
        test.stopTest();
    }
    
     @Istest
    public static void getTokenTest(){
        string sandbox = GetSandboxType.getTypeOfSandbox();
        string namecred;
        
       if(sandbox == 'DEV'){
            namecred = 'ContentManagmentDevToken';
        }
        if(sandbox == 'QA'){
            namecred = 'ContentManagmentQAToken';
        }
        if(sandbox =='PROD'){
            namecred = 'ContentManagmentProdToken';
        }
        string testEndpoint = 'callout:'+ namecred;
         String getResponse ='Respuesta dumy';
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseHandler_cls(testEndpoint, getResponse, 'POST', 'application/json', 200));
        test.startTest();
        LMM_WS_Tollgate_cls.getToken();
        test.stopTest();
    }
    
    @Istest
    Static void validaTollgateTest(){
       Opportunity opp  = new Opportunity();
        opp.Name ='TEST';
        opp.StageName ='Nuevo';
        opp.CloseDate = Date.today();
        opp.amount = 5000;
        opp.RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByDeveloperName().get('OPP_LMM').getRecordTypeId(); 
        Insert opp;
        LMM_TolgateController.validateTollgate(opp.Id);
        
    }
    
    @Istest
    static void unlockRecord(){
        Opportunity opp  = new Opportunity();
        opp.Name ='TEST';
        opp.StageName ='Nuevo';
        opp.CloseDate = Date.today();
        opp.amount = 5000;
        opp.RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByDeveloperName().get('OPP_LMM').getRecordTypeId(); 
        Insert opp;
        LMM_TolgateController.lockRecord(opp.Id, 'Opportunity');
        LMM_TolgateController.unlockRecord(opp.Id, 'Opportunity');
        LMM_TolgateController.updateFieldValidation(opp.Id, 'Opportunity', 'CMS_Documents__c');
    }
}