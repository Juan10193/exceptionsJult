@RestResource(urlMapping='/TakedownInvoics/DeleteInvoices/*')
global without sharing class WS_DeleteTakedownInvoices {
    public virtual class BaseException extends Exception {}
    public class WsException extends BaseException {}

    @HTTPPost
    global static void deleteInvoices(List<Id> invoices, List<Id> documents, boolean blockAB, boolean ButtonUnlockAndApproveShow){
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        res.addHeader('Content-Type', 'application/json;charset=UTF-8');
        try {
            takedownTableDocumentsController_cls.deleteInvoices(invoices,documents, blockAB, ButtonUnlockAndApproveShow);
            res.responseBody = Blob.valueOf('{"result":"ok"}');
        } catch (System.StringException e) {
            SalesforceError[] errs = new SalesforceError[]{ 
                new SalesforceError('BAD_REQUEST', e.getMessage())
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