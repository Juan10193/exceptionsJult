@RestResource (urlMapping='/PrcingCavsBooking/v1/*')
global class WS_PrcingCavsBooking_REST {
    
    @HttpGet
    global static void getCaPricingVsBooking(){
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        res.addHeader('Content-Type', 'application/json;charset=UTF-8');
        
        try {
            id takedownId = req.params.get('takedownId');
            Takedown_CA_VS_ST_Table_Wrapper_cls.Table tabla = Takedown_CA_VS_ST_Controller_cls.getPricingVSPricing(takedownId);
            string jsonCaVSPricing = JSON.serializePretty(tabla, true);
            res.responseBody = Blob.valueOf(jsonCaVSPricing);
        }catch (System.StringException e) {
            SalesforceError[] errs = new SalesforceError[]{ 
                new SalesforceError('BAD_REQUEST',string.valueOf(e.getMessage()))
            };
            res.statusCode =400;
            res.responseBody = Blob.valueOf(JSON.serialize(errs));
        } catch (System.QueryException e){
            res.statusCode = 404;
            SalesforceError[] errs = new SalesforceError[]{ 
                new SalesforceError('NOT_FOUND', 'Requested Takedown not found')
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