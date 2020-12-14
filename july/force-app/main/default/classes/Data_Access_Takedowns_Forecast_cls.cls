/**
 * @File Name          : Data_Access_Takedowns_Forecast_cls.cls
 * @Description        : 
 * @Author             : juandedios.hernandez@engeniumcapital.com
 * @Group              : 
 * @Last Modified By   : juandedios.hernandez@engeniumcapital.com
 * @Last Modified On   : 27/9/2019 10:38:13
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    10/9/2019   juandedios.hernandez@engeniumcapital.com     Initial Version
**/
public with sharing class Data_Access_Takedowns_Forecast_cls {
    
    /**
    * @description 
    * @author juandedios.hernandez@engeniumcapital.com | 23/9/2019 
    * @param recordId 
    * @return TBO021_Takedowns_forecast__c 
    **/
    public static TBO021_Takedowns_forecast__c getForecast(string recordId){
        if (Schema.sObjectType.TBO021_Takedowns_forecast__c.isAccessible()){
            return [SELECT Id, OwnerId, IsDeleted, Name, CurrencyIsoCode, TKD_fm_Opp_Name__c, CreatedDate, 
                                        CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, LastActivityDate,
                                        LastViewedDate, LastReferencedDate, Created_Takedown__c, TBO021_dv_Amount__c, 
                                        TBO021_fh_Delivery_Date__c, TBO021_fh_Funding_Date__c, TBO021_fm_Opportunity_id__c, 
                                        TBO021_ls_Committed__c, TBO021_ls_Invoice_Currency__c, TBO021_ls_Status__c, 
                                        TBO021_rb_Opportunity__c,TBO021_rb_Opportunity__r.OPP_ls_Deal_Category__c,TBO021_rb_Opportunity__r.OPP_ls_Product__c,
                                        TBO021_rb_Opportunity__r.OPP_ls_Financing_Need__c, TBO021_tx_Converted_Tkd_EXTREFID__c, Description__c, 
                                        TBO021_fm_month__c, TBO021_fm_year__c, TBO021_tl_CommercialSupportComments__c, 
                                        Account_Legal_Name__c, Delivery_Date_Q__c, Delivery_Date_Week__c, TBO021_fm_OppRegion__c, 
                                        Opportunity_Stage__c, CLI_chb_Converted__c, CLI_rb_Customer_Name__c, CLI_rb_Takedown_CP__c, 
                                        CLI_fm_Takedown_Stage__c, First_Committed_Date__c, Inside_Sales_Owner__c, Opportunity_Owner__c, 
                                        Deal_Category__c, Progress_Payment_Number__c, Start_of_Lease__c, Status_Comments__c, Next_Steps__c, 
                                        Control_Desk_Comments__c, Funding_Priority__c, Pre_book_Status__c, Annex_Signature_Date__c, 
                                        of_Assets__c, CD_Review_Priority__c, Of_Times_Commited_Date_is_Chaged__c, Closing_Report_Status__c, 
                                        Takedown_Process__c, Exchange_Rate__c, TKD_fm_Account_Id__c	 FROM TBO021_Takedowns_forecast__c where Id=:recordId];
        }
        return null;     
    }

}