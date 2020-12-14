/**
 * @File Name          : TKD_ClosingMemoFull.cls
 * @Description        : 
 * @Author             : juandedios.hernandez@engeniumcapital.com
 * @Group              : 
 * @Last Modified By   : juandedios.hernandez@engeniumcapital.com
 * @Last Modified On   : 21/10/2019 12:20:30
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    21/10/2019   juandedios.hernandez@engeniumcapital.com     Initial Version
**/
public without sharing class TKD_ClosingMemoFull {
    /**
    * @description 
    * @author juandedios.hernandez@engeniumcapital.com | 21/10/2019 
    * @param opportunityId 
    * @return Credit_approval_CP__c 
    **/
    @AuraEnabled(cacheable=false)
    public static Credit_approval_CP__c  getCredutApprovalbyOpId(string opportunityId) {
        return Data_Access_CreditApprovalCp_cls.getCreditApprovalbyopId(opportunityId);
    }

    @AuraEnabled(cacheable=false)
    public static SupperTRUMP_Pricing_Quote_Wrapper.query_All_Fields fecthPricingPQ(string pqName){
        return Data_Access_WOS_IST_SP_Pricing_Quote.getAllFieldsByName(pqName);
    }

    @AuraEnabled(cacheable=false)
    public static ES3_obj_Pricing_in_Credit_Approval__c fetchPricingInCA(string pricingInCaId){
        return Data_Access_PricinginCredit_Approval_cls.pricingInCAById(pricingInCaId);
    }

    @AuraEnabled(cacheable=false)
    public static list<ES3_obj_Condition_Service_covenant__c> fetchCovenants(string opportunityId){
        return Data_Access_ConditionServiceCoventant.getCSC(opportunityId);
    }
}