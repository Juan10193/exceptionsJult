/**
 * @File Name          : takedownTableABFormController_cls.cls
 * @Description        : 
 * @Author             : eduardo.villegas@engeniumcapital.com
 * @Group              : 
 * @Last Modified By   : eduardo.amiens@outlook.com
 * @Last Modified On   : 2/3/2020 1:00:51
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    28/10/2019   eduardo.villegas@engeniumcapital.com     Initial Version
**/
public with sharing class takedownTableABFormController_cls {
    /**
    * @description
    * @author eduardo.villegas@engeniumcapital.com | 22/8/2019
    * @param string takedownInvoiceId
    * @return List<Asset>
    */
    @AuraEnabled(cacheable=true)
    public static List<Asset> getAssetBreakdown(string takedownInvoiceId){
        List<Asset> listAsset = new List<Asset>();
        if(takedownInvoiceId != null){
            listAsset = Data_Access_Assets_cls.getAssetsByTakedownInvoice(takedownInvoiceId);
        }
        return listAsset;
    } 
    /**
    * @description 
    * @author eduardo.villegas@engeniumcapital.com | 18/2/2020 
    * @param takedownid 
    * @return string 
    **/
    @AuraEnabled(cacheable=true)
    public static Takedowns_Contingency_plan__c getTakedownFields(string takedownid){
        return Data_Access_Takedowns_CP_cls.getAllFieldsByID(takedownid);
    }

    
}