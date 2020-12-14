public without sharing class Takedown_CA_VS_ST_Service_cls {
    
    public Takedown_CA_VS_ST_Wrapper_cls.CA_VS_ST_Wrapper getPricingsAndMakeWrapper(id recordID){
        Takedowns_Contingency_plan__c takedownCP = Data_Access_WOS_Takedowns_CP_cls.getAllFields(recordID);
        Takedown_CA_VS_ST_Wrapper_cls.CA_VS_ST_Wrapper Takedown_CA_VS_ST_Wrapper = new Takedown_CA_VS_ST_Wrapper_cls.CA_VS_ST_Wrapper();
        Takedown_CA_VS_ST_Wrapper_cls.CA_Wrapper CA_Wrapper = new Takedown_CA_VS_ST_Wrapper_cls.CA_Wrapper();
        CA_Wrapper.creditApprovalId = takedownCP.TKD_rb_Pricin_CA__c;
        CA_Wrapper.creditApprovalName = takedownCP.TKD_rb_Pricin_CA__r.name;
        system.debug('takedownCP.TKD_rb_Pricin_CA__r.ES3_rb_Pricing__r.name ' + takedownCP.TKD_rb_Pricin_CA__r.ES3_fm_Pricing_Super_Trump__c);
       	SupperTRUMP_Pricing_Quote_Wrapper.query_All_Fields Pricing_Quote_CA_Wrapper = Data_Access_WOS_IST_SP_Pricing_Quote.getAllFieldsByName(takedownCP.TKD_rb_Pricin_CA__r.ES3_fm_Pricing_Super_Trump__c);     
        CA_Wrapper.pricingId = Pricing_Quote_CA_Wrapper.recordID;
        CA_Wrapper.pricingName = Pricing_Quote_CA_Wrapper.Name;
        system.debug('takedownCP.Annex_Pricing_SuperTrump__c ' + takedownCP.Annex_Pricing_SuperTrump__c);
        SupperTRUMP_Pricing_Quote_Wrapper.query_All_Fields Pricing_Quote_ST_Wrapper = Data_Access_WOS_IST_SP_Pricing_Quote.getAllFieldsByID(takedownCP.Annex_Pricing_SuperTrump__c);     
        Takedown_CA_VS_ST_Wrapper_cls.ST_Wrapper ST_Wrapper = new Takedown_CA_VS_ST_Wrapper_cls.ST_Wrapper();
        ST_Wrapper.pricingcreditApprovalId = Pricing_Quote_ST_Wrapper.recordID;
        ST_Wrapper.pricingName = Pricing_Quote_ST_Wrapper.Name;
        
        Takedown_CA_VS_ST_Wrapper.cA_Wrapper = CA_Wrapper;
        Takedown_CA_VS_ST_Wrapper.sT_Wrapper = ST_Wrapper;
        system.debug('Takedown_CA_VS_ST_Wrapper ' + Takedown_CA_VS_ST_Wrapper);
        return Takedown_CA_VS_ST_Wrapper;
    }

}