@RestResource(urlMapping='/Supplier__c/*')
global class WS_Supplier_REST {
    
    @HttpGet
    global static void getSupplierById(){
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        res.addHeader('Content-Type', 'application/json;charset=UTF-8');
        string recordId = req.params.get('recordId');

        Supplier__c supplier = WS_Supplier_REST_Helper.getSuppplier(recordId, res);
        Supplier__c supplierWithSites = WS_Supplier_REST_Helper.getSuppplierWithSites(recordId, res);
        List<TKD_Site__c> sites = WS_Supplier_REST_Helper.getSuplierSitesDetails(supplierWithSites);
        string jsonSupplier = WS_Supplier_REST_Helper.generateSupplierDetails(supplier, sites);
        if(supplier!=null){
            res.responseBody = Blob.valueOf(jsonSupplier);
        }
    }
}