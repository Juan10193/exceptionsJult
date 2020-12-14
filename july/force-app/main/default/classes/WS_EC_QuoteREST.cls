@RestResource (urlMapping='/EcQuote/v1/*')
global class WS_EC_QuoteREST {

  @HttpGet
  global static void getEcQuoteById() {
    RestRequest req = RestContext.request;
    RestResponse res = RestContext.response;
    res.addHeader('Content-Type', 'application/json;charset=UTF-8');
    try {
      id ecQuoteId = req.params.get('ecQuoteId');
      EC_Quote__c ecQuote= WS_EC_QuoteREST_Helper.getEcQuoteById(ecQuoteId);
      res.responseBody = Blob.valueOf(JSON.serializePretty(ecQuote, true));
    }catch (System.StringException e) {
      SalesforceError[] errs = new SalesforceError[]{ 
          new SalesforceError('BAD_REQUEST',string.valueOf(e.getMessage()))
      };
      res.statusCode =400;
      res.responseBody = Blob.valueOf(JSON.serialize(errs));
    } catch (System.QueryException e){
      res.statusCode = 404;
      SalesforceError[] errs = new SalesforceError[]{ 
          new SalesforceError('NOT_FOUND', 'Requested EcQuote not found')
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