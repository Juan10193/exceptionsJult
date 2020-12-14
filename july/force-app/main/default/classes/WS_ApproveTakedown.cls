/**
 * @description       : 
 * @author            : eduardo.amiens@outlook.com
 * @group             : 
 * @last modified on  : 10-08-2020
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
 * Modifications Log 
 * Ver   Date         Author                       Modification
 * 1.0   10-08-2020   eduardo.amiens@outlook.com   Initial Version
**/
@RestResource(urlMapping='/TakedownDETAILS/Approval/*')
global without sharing class WS_ApproveTakedown {
    public virtual class BaseException extends Exception {}
    public class WsException extends BaseException {}

    @HttpPost
    global static void doPost(string recordId, string action, string comments){
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        res.addHeader('Content-Type', 'application/json;charset=UTF-8');
        try{
            WS_ApproveTakedownHelper.approve(recordId, action, comments);
            res.responseBody = Blob.valueOf('{"result":"ok", "action":"' + action + '"}');
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