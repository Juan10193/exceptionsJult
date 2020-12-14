@isTest
public class tkdBankAccountDetailController_Test {
    @isTest
    static void getSupplierWithSites(){
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('Mock_Data_WS_OL_FindAssetsByTakedown');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');   
        Test.setMock(HttpCalloutMock.class, mock);
        tkdBankAccountDetailController.getTKD_Bank_Account();
    }

}