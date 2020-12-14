public  class TKD_siteDetail_Controller {
    
    @AuraEnabled
    public static string getDetailSites(string recordId, string SearchByRFC , string SearchByName, string SearchByCurrency , string SearchByTaxCode ){
        return Takedown_Controller_SupplierInCA.getKnownSupplier(recordId, SearchByRFC, SearchByName, SearchByCurrency, SearchByTaxCode);
    }

}