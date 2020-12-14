@RestResource (urlMapping='/ClosingMemoTakedown/v1/*')
global class WS_ClosingMemoTakedown_REST {
    
    @HttpGet
    global static void getClosingMemoTakedown (){
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        res.addHeader('Content-Type', 'application/json;charset=UTF-8');

        try {
            Id opportunityId = req.params.get('opportunityId');
            string pricingPQName = req.params.get('pricingPQName');
            Id pricingInCaId = req.params.get('pricingInCaId');
            WS_ClosingMemoTakedown_REST_Helper closingMemoHelper = new WS_ClosingMemoTakedown_REST_Helper(opportunityId, pricingPQName, pricingInCaId);
            Wrapper_ClosingMemoTakedown_REST closingMemo = closingMemoHelper.getClosingMemo();
            string jsonClosingMemo = JSON.serializePretty(closingMemo, true);
            res.responseBody = Blob.valueOf(jsonClosingMemo);
        }catch (System.StringException e) {
            SalesforceError[] errs = new SalesforceError[]{ 
                new SalesforceError('BAD_REQUEST',string.valueOf(e.getMessage()))
            };
            res.statusCode =400;
            res.responseBody = Blob.valueOf(JSON.serialize(errs));
        } catch (System.QueryException e){
            res.statusCode = 404;
            SalesforceError[] errs = new SalesforceError[]{ 
                new SalesforceError('NOT_FOUND', 'Requested ClosingMemo not found')
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