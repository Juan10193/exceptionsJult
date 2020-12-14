@RestResource(urlMapping='/TakedownInvoics/DownloadInvoices/*')
global without sharing class WS_DonwloadAlltakedownInvoices {
    public virtual class BaseException extends Exception {}
    public class WsException extends BaseException {}

    @HttpGet
    global static void getTableInvoices(){
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        res.addHeader('Content-Type', 'application/json;charset=UTF-8');

       
        try {
            list<string> contentVersionIds =  req.params.get('contentVersionIds').split(',');
            List<ContentVersion> documents = [Select Id, Title, FileExtension,  VersionData from ContentVersion where Id IN:contentVersionIds];
            list<baseContent> docs = new list<baseContent>();
            for (ContentVersion doc: documents) {
                baseContent base = new baseContent();
                base.Id = doc.Id;
                base.base64 = doc.VersionData;
                base.title = doc.Title;
                base.extension = doc.FileExtension;
                docs.add(base);
            }
            res.responseBody = Blob.valueOf(JSON.serialize(docs));
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

    class baseContent{
        public string Id {get;Set;}
        public string title {get;set;}
        public string extension {get;set;}
        public Blob base64 {get;set;}
    }
}