@RestResource(urlMapping='/TakedownInvoics/*')
global without sharing class WS_TakedownInvoices {
    public virtual class BaseException extends Exception {}
    public class WsException extends BaseException {}

    @HttpGet
    global static void getTableInvoices(){
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        res.addHeader('Content-Type', 'application/json;charset=UTF-8');
        string recordId = req.params.get('recordId');

        try {
            List<Takedown_Invoice__c> invoices = Data_Access_Takedown_Invoice_cls.getDocumentListByTakedownID(recordId);
            res.responseBody = Blob.valueOf(JSON.serialize(invoices));
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