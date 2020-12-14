@RestResource (urlMapping='/ClosingMemoCA/v1/*')
global class WS_ClosingMemoCaREST {
    
    @HttpGet
    global static void getClosingMemoByCAId(){
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        res.addHeader('Content-Type', 'application/json;charset=UTF-8');
        try {
            id caId = req.params.get('caId');
            WS_ClosingMemoCaREST_Helper closingMemo = new WS_ClosingMemoCaREST_Helper(caId);
            res.responseBody = Blob.valueOf(JSON.serializePretty(closingMemo, true));
        } catch (System.StringException e) {
            SalesforceError[] errs = new SalesforceError[]{ 
                new SalesforceError('BAD_REQUEST',string.valueOf(e.getMessage()))
            };
            res.statusCode =400;
            res.responseBody = Blob.valueOf(JSON.serialize(errs));
        } catch (System.QueryException e){
            res.statusCode = 404;
            SalesforceError[] errs = new SalesforceError[]{ 
                new SalesforceError('NOT_FOUND', string.valueOf(e.getMessage()))
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