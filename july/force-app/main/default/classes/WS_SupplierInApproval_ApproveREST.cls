@RestResource(urlMapping='/WS_SupplierInApproval_ApproveREST/v1/*')
global  class WS_SupplierInApproval_ApproveREST {

    @HttpPost
    global static void doPost(string recordId, string tkd_ls_Stage_Supplier, string tkd_ls_Stage_AML, string comments){
        RestContext.response.addHeader('Content-Type', 'application/json;charset=UTF-8'); 
        try{
            WS_SupplierInApproval_ApproveHelper approve = new WS_SupplierInApproval_ApproveHelper(recordId,tkd_ls_Stage_Supplier, tkd_ls_Stage_AML, comments);
            Supplier_in_approval__c supplierInApproval=Data_Access_Supplier_in_approval.getSupplierInApprovalWithSuppliersById(recordId);
            RestContext.response.responseBody = Blob.valueOf( JSON.serialize(supplierInApproval) );
        }catch(Exception e){
            SalesforceError[] errs = new SalesforceError[]{ 
                new SalesforceError('BAD_REQUEST',e.getMessage())
            };
            RestContext.response.statusCode =500;
            RestContext.response.responseBody = Blob.valueOf(JSON.serialize(errs));
        }      
    }
}