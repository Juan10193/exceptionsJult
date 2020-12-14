@RestResource (urlMapping='/Opportunity/v1/*')
global class WS_OpportunityREST {
  @HttpGet
  global static void getOpportunityByRecordId(){
    RestRequest req = RestContext.request;
    RestResponse res = RestContext.response;
    res.addHeader('Content-Type', 'application/json;charset=UTF-8');
    try {
      id opportunityId = req.params.get('recordId');
      Opportunity opp= WS_OpportunityREST_Helper.getOpportunityWithRelated(opportunityId);
      res.responseBody = Blob.valueOf(JSON.serializePretty(opp, true));
    }catch (System.StringException e) {
      SalesforceError[] errs = new SalesforceError[]{ 
          new SalesforceError('BAD_REQUEST',string.valueOf(e.getMessage()))
      };
      res.statusCode =400;
      res.responseBody = Blob.valueOf(JSON.serialize(errs));
    } catch (System.QueryException e){
      res.statusCode = 404;
      SalesforceError[] errs = new SalesforceError[]{ 
          new SalesforceError('NOT_FOUND', 'Requested Opportunity not found')
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