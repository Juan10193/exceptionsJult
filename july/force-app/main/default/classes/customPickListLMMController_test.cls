@isTest
public class customPickListLMMController_test {
    @isTest
    static void getRequestByPartyID(){
        Test.setMock(HttpCalloutMock.class, new EIV_EntityCalloutMock());
        customPickListLMMController.getRequestByPartyID('34561');
    }
    @isTest
    static void getRequestByRequestID(){
        Test.setMock(HttpCalloutMock.class, new EIV_EntityCalloutMock());
        customPickListLMMController.getRequestByRequestID('34561');
    }

}