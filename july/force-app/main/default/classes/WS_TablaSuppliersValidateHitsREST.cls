@RestResource(urlMapping='/Supplier_in_approval__c/TableSuppliers/validateHits/*')
global without sharing class WS_TablaSuppliersValidateHitsREST {
    @HttpGet
    global static void doGet(){
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        res.addHeader('Content-Type', 'application/json;charset=UTF-8');
        string recordId = req.params.get('recordId');
        try {
            Takedown_Controller_tableAmlHits.updateInformationSupp(recordId);
            List<Takedown_Supplier_Site> sites = Takedown_Controller_tableAmlHits.getAllSupplierTblAmlHits(recordId);
            res.responseBody = Blob.valueOf(JSON.serialize(sites));
        } catch (System.StringException e) {
            SalesforceError[] errs = new SalesforceError[]{ 
                new SalesforceError('BAD_REQUEST','Param: recordId is not a valid Id')
            };
            res.statusCode =400;
            res.responseBody = Blob.valueOf(JSON.serialize(errs));
        } catch (System.QueryException e){
            res.statusCode = 404;
            SalesforceError[] errs = new SalesforceError[]{ 
                new SalesforceError('NOT_FOUND', 'Requested not found')
            };
            res.responseBody = Blob.valueOf(JSON.serialize(errs));
        } catch(Exception e){
            res.statusCode = 500;
            SalesforceError[] errs = new SalesforceError[]{ 
                new SalesforceError('BAD_REQUEST', e.getStackTraceString())
            };
            res.responseBody = Blob.valueOf(JSON.serialize(errs));
        }
    }
}