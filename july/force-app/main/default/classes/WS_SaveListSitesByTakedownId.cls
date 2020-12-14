@RestResource(urlMapping='/Supplier_in_approval__c/TableSuppliers/SaveSites/*')
global without sharing class WS_SaveListSitesByTakedownId {
    @HttpPost
    global static void doPost(string recordId, Supplier__c[] supplierList, TKD_Site__c[] sites, Bank_Account__c[] banckaccounts, Contact[] contacts){
        RestContext.response.addHeader('Content-Type', 'application/json;charset=UTF-8');
        try{
            system.debug(supplierList);
            Takedown_Controller_SupplierInCA.saveListSitess(recordId,supplierList,sites,banckaccounts, contacts);
            RestContext.response.responseBody = Blob.valueOf( '{"result":"success"}' );
        }catch(Exception e){
            SalesforceError[] errs = new SalesforceError[]{ 
                new SalesforceError('BAD_REQUEST',e.getMessage())
            };
            RestContext.response.statusCode =500;
            RestContext.response.responseBody = Blob.valueOf(JSON.serialize(errs));
        }      
    }
}