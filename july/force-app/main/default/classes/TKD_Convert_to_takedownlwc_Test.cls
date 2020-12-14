@IsTest
public class TKD_Convert_to_takedownlwc_Test {
	@Istest
    static void getForecastTest(){
        Opportunity opp = Data_Factory_Opportunity_Test.createNewOpportunityTypeSales();
        TBO021_Takedowns_forecast__c tkdfcst = Data_Factory_EasyForecast_Test.createForecast(opp.Id);
        TKD_Convert_to_takedownlwc_controller.getForecast(tkdfcst.Id);
        TKD_Convert_to_takedownlwc_controller.getEntitiesInca(opp.Id);
        TKD_Convert_to_takedownlwc_controller.getPricingsInca(opp.Id);
    }
    
    @Istest
    static void fetchOppsTest(){
       Account acc = Data_Factory_Account_Test.createNewAccount('LOPEZ');
        TKD_Convert_to_takedownlwc_controller.fetchOpps(acc.Id);
    }
}