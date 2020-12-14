@istest
public class Data_Factory_EasyForecast_Test {
    public static TBO021_Takedowns_forecast__c createForecast(Id opportunityId){
        TBO021_Takedowns_forecast__c forecast = new TBO021_Takedowns_forecast__c();
        forecast.TBO021_rb_Opportunity__c = opportunityId;
        forecast.TBO021_dv_Amount__c = 100;
        forecast.TBO021_ls_Committed__c = 'Yes';
        forecast.TBO021_fh_Delivery_Date__c = Date.today();
        forecast.TBO021_fh_Funding_Date__c = Date.today();
        forecast.TBO021_ls_Invoice_Currency__c ='MXN';
        forecast.TKD_dv_Term__c = 64;
        insert forecast;
        return forecast;
    }
 }