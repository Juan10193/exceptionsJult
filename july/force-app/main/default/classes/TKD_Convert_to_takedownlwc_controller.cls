/**
 * @File Name          : TKD_Convert_to_takedownlwc_controller.cls
 * @Description        : 
 * @Author             : jhernandez@anivia.mx
 * @Group              : 
 * @Last Modified By   : juandedios.hernandez@engeniumcapital.com
 * @Last Modified On   : 24/9/2019 16:13:53
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    11/9/2019   jhernandez@anivia.mx     Initial Version
**/
public without sharing class TKD_Convert_to_takedownlwc_controller {
   @AuraEnabled(cacheable=true)
   /**
   * @description Obtiene el registro del takedown forecast
   * @author jhernandez@anivia.mx | 11/9/2019 
   * @param recordId 
   * @return TBO021_Takedowns_forecast__c 
   **/
   public static TBO021_Takedowns_forecast__c getForecast(string recordId){
       TBO021_Takedowns_forecast__c forecast = Data_Access_Takedowns_Forecast_cls.getForecast(recordId);
       return forecast;
   }


    /**
    * @description retorna las opportunidades de la cuenta seleccionada con linea de credito vigente
    * @author juandedios.hernandez@engeniumcapital.com | 24/9/2019 
    * @param accountId 
    * @return List<Opportunity> 
    **/
    @AuraEnabled(cacheable=true)
    public static List < Opportunity > fetchOpps(string accountId) {
        //String searchKey ='%' + searchKeyWord + '%';
        // Create a Dynamic SOQL Query For Fetch Record List with LIMIT 5   
        list<Opportunity> opp =  [select id, Name, OPP_ls_Deal_Category__c, OPP_ls_Financing_Need__c, OPP_ls_Product__c  from  Opportunity  where AccountId =:accountId 
                                    AND (StageName !='New') AND(Id IN(Select IST__Opportunity__c from IST__SuperTRUMP_Pricing_Quote__c
                                    ))
                                    order by createdDate DESC limit 100];
                                   /* AND (CPL_fm_Final_Balance__c > 0) AND(StageName ='Backlog with fundings' 
                                    OR(StageName='Backlog') OR(StageName='Booked'))
                                    order by createdDate DESC limit 100]*/

        return opp;
    }



    /**
    * @description retorna los entities en credit approval de la opportunidad para la busqueda de customer name
    * @author juandedios.hernandez@engeniumcapital.com | 24/9/2019 
    * @param opportunityId 
    * @return list<ES2_Obj_EntityMasterInCreditApproval__c> 
    **/
    @AuraEnabled(cacheable=false)
    public static list<ES2_Obj_EntityMasterInCreditApproval__c> getEntitiesInca(string opportunityId){
        return Data_Access_EntityMastInCApproval_cls.entitiesInCaOp(opportunityId);
    }

    /**
    * @description retorna los pricings en credit approval de la opportunidad seleccionada
    * @author juandedios.hernandez@engeniumcapital.com | 24/9/2019 
    * @param opportunityId 
    * @return List<ES3_obj_Pricing_in_Credit_Approval__c> 
    **/
    @AuraEnabled
    public static List<ES3_obj_Pricing_in_Credit_Approval__c> getPricingsInca(string opportunityId){
        return Data_Access_PricinginCredit_Approval_cls.pricingsInCa(opportunityId);
    }
    
}