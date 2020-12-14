@RestResource(urlMapping='/TakedownInvoics/validate/*')
global without sharing class WS_ValidateTakedownInvoices {
    public virtual class BaseException extends Exception {}
    public class WsException extends BaseException {}

    @HttpPOST
    global static void doPost( list<WS_ValidateInvoicesWrapper> invoices ){
        list<takedownTableDocumentsWrapper_cls.TableElement> elements = new list<takedownTableDocumentsWrapper_cls.TableElement>();

        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        res.addHeader('Content-Type', 'application/json;charset=UTF-8');

        try{
            for (WS_ValidateInvoicesWrapper invoice : invoices) {
                takedownTableDocumentsWrapper_cls.TableElement element = new takedownTableDocumentsWrapper_cls.TableElement();
                element.id = invoice.Id;
                element.name = invoice.name;
                element.TKD_pd_Takedown_CP = invoice.TKD_pd_Takedown_CP;
                element.TKD_txt_Content_Version_ID = invoice.TKD_txt_Content_Version_ID;
                element.TKD_txt_Document_ID = invoice.TKD_txt_Document_ID;
                element.TKD_txt_Extension = invoice.TKD_txt_Extension;
                element.TKD_ls_asset_type = invoice.TKD_ls_asset_type;
                element.AccountId = invoice.AccountId;
                elements.add(element);
            }
            takedownTableDocumentsController_cls.uploadAndValidateInvoices(elements);
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