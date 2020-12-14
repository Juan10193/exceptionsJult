@isTest
public class wk_TesorerySurvey_controller_clsTest {
    
    
     @isTest
    static void getTesoreryTest(){
      	wk_TesoreryTest__c  tesorery = Data_Factory_TesoreryTest_Test.createNewTesoreryTest();
        wk_TesorerySurvey_controller_cls.getTesoreryTest(tesorery.wk_pd_creditApproval__c);
        List<wk_TesoreryTest__c> lstTesorery= [SELECT Id, wk_pd_creditApproval__c, wk_ta_Response1__c, wk_ta_Response2__c, wk_ta_Response3__c, wk_ta_Response4__c, wk_ta_Response5__c, wk_ta_Response6__c, wk_ta_Response7__c, wk_ta_Response8__c FROM wk_TesoreryTest__c WHERE Id =:tesorery.Id];        
		System.assertEquals(1,lstTesorery.size());        
    }
        
    @isTest
    static void getupsertTesoreryTest(){
       wk_TesoreryTest__c  tesorery = Data_Factory_TesoreryTest_Test.createNewTesoreryTest();  
        wk_TesorerySurvey_controller_cls.getupsertTesoreryTest(tesorery);
      	List<wk_TesoreryTest__c> lstTesorery= [SELECT Id, wk_pd_creditApproval__c, wk_ta_Response1__c, wk_ta_Response2__c, wk_ta_Response3__c, wk_ta_Response4__c, wk_ta_Response5__c, wk_ta_Response6__c, wk_ta_Response7__c, wk_ta_Response8__c FROM wk_TesoreryTest__c WHERE Id =:tesorery.Id];              	
        System.assertEquals(1,lstTesorery.size());        
    }
    
    @isTest
    static void getResponsesTest(){
       	wk_TesoreryTest__c  tesorery = Data_Factory_TesoreryTest_Test.createNewTesoreryTest();       
        wk_TesorerySurvey_controller_cls.getResponses(tesorery.wk_pd_creditApproval__c);
      	List<wk_TesoreryTest__c> lstTesorery= [SELECT Id, wk_pd_creditApproval__c, wk_ta_Response1__c, wk_ta_Response2__c, wk_ta_Response3__c, wk_ta_Response4__c, wk_ta_Response5__c, wk_ta_Response6__c, wk_ta_Response7__c, wk_ta_Response8__c FROM wk_TesoreryTest__c WHERE Id =:tesorery.Id];              	        
        System.assertEquals(1,lstTesorery.size());        
    }
    
   
 
}