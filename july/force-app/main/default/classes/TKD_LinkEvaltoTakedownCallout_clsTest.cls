@Istest
public class TKD_LinkEvaltoTakedownCallout_clsTest {
    @Istest
    static void searchEvalsInOpportunityCalloutTest(){
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
        string testEndpoint = 'callout:'+ namecred + 'cRequestSbDat/SFRequestTypeDetailsRs/sfRequestTypeDetails?requestId=&sourceOpId=' + '1234';
        String getResponse ='Respuesta dumy';
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseHandler_cls(testEndpoint, getResponse, 'GET', 'application/json', 200));
        test.startTest();
        TKD_LinkEvaltoTakedownCallout_cls.searchEvalsInOpportunityCallout('1234');
        test.stopTest();
        
    }
    
    @Istest
    static void searchEvalsInEntitiesTest(){
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
        string testEndpoint = 'callout:'+ namecred + '/EcRequestSbDat/RequestRs/requests?partyId=' + '1234' ;
        String getResponse ='Respuesta dumy';
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseHandler_cls(testEndpoint, getResponse, 'GET', 'application/json', 200));
        test.startTest();
        TKD_LinkEvaltoTakedownCallout_cls.searchEvalsInEntities('1234');
        test.stopTest();
        
    }
    
    @Istest
    static void searchRequestIdTest(){
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
        string testEndpoint = 'callout:'+ namecred + '/EcRequestSbDat/SFRequestTypeDetailsRs/sfRequestTypeDetails?requestId=1234';
        String getResponse ='Respuesta dumy';
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseHandler_cls(testEndpoint, getResponse, 'GET', 'application/json', 200));
        test.startTest();
        TKD_LinkEvaltoTakedownCallout_cls.searchRequestId('123', 'SF', '1234');
        test.stopTest();
        
    }
    
    @Istest
    static void cloneEvalTest(){
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
        string testEndpoint = 'callout:'+ namecred + '/EcRequestSbDat/SFRequestTypeDetailsRs/sfRequestTypeDetails';
        String getResponse ='Respuesta dumy';
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseHandler_cls(testEndpoint, getResponse, 'POST', 'application/json', 200));
        test.startTest();
        TKD_LinkEvaltoTakedownCallout_cls.cloneEval('dummyjsson');
        test.stopTest();
        
    }
    
    @Istest
    static void postCommentEval(){
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
        
        string testEndpoint = 'callout:'+ namecred + '/EcRequestSbDat/SFRequestTypeDetailsRs/sfRequestTypeDetails/comments';
       String getResponse =		'{"requestComment":{"requestId":5321,"comSection":"","comComment":"TAKEDOWN: TD_CP-000008827","comCreatedBy":"223005130","comCreationDate":"2020-03-13T20:19:39-06:00","comUpdatedBy":"223005130","comLastUpdateDate":"2020-03-13T20:19:39-06:00"}}';
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseHandler_cls(testEndpoint, getResponse, 'POST', 'application/json', 200));
         test.startTest();
        TKD_LinkEvaltoTakedownCallout_cls.postEvalComments(getResponse);
        test.stopTest();
    }
}