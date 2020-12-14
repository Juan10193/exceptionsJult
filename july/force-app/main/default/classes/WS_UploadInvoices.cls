/**
 * @description       : 
 * @author            : eduardo.amiens@outlook.com
 * @group             : 
 * @last modified on  : 10-13-2020
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
 * Modifications Log 
 * Ver   Date         Author                       Modification
 * 1.0   10-09-2020   eduardo.amiens@outlook.com   Initial Version
**/

@RestResource(urlMapping='/TakedownInvoics/UploadInvoices/*')
global with sharing class WS_UploadInvoices {
    public virtual class BaseException extends Exception {}
    public class WsException extends BaseException {}

    @HttpPost
    global static void doPost(String recordId, List<WS_UploadInvoicesWrapper> uploadInvoices){
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        res.addHeader('Content-Type', 'application/json;charset=UTF-8');
        try{
            WS_UploadInvoicesHelper uploadInvoicesHelper = new WS_UploadInvoicesHelper(recordId, uploadInvoices);
            uploadInvoicesHelper.uploadInvoicesHelper();
            res.responseBody = Blob.valueOf('{"result":"ok"}');
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
                new SalesforceError('BAD_REQUEST', e.getMessage())
            };
            res.responseBody = Blob.valueOf(JSON.serialize(errs));
        }
    }
}