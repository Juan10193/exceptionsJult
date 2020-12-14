@RestResource(urlMapping = '/DetailsExternalInsurance/*')
global class DetailsExternalInsurance {

    @HttpPut
    global static void updateDetailExternalInsurance() {
        RestRequest reqRest = RestContext.Request;
        RestResponse resRest = RestContext.Response;
        String body = reqRest.requestBody.toString();
        
        DetailsExternalInsurance_cls.Response response = new DetailsExternalInsurance_cls.Response();
        if(!String.isBlank(body)) {
            response = DetailsExternalInsurance_cls.updateExternalInsurance_cls(body);
        }
        else {
            response.status = 'Fail';
            response.message = 'Error: body is empty';
        }
        resRest.addHeader('Content-Type', 'application/json;charset=UTF-8');
		resRest.responseBody = Blob.valueOf(JSON.serialize(response, true));
    }
    
    @HttpGet
    global static void getDetailExternalInsurance() {
        RestRequest restReq = RestContext.request;
        RestResponse restRes = RestContext.response;
        String idInsurance = restReq.params.get('idInsurance');        
        DetailsExternalInsurance_cls.Response response = new DetailsExternalInsurance_cls.Response();
        restRes.addHeader('Content-Type', 'application/json;charset=UTF-8');
        
        if(idInsurance != null) {
            try {
				DetailsExternalInsurance_cls insuranceExternal = new DetailsExternalInsurance_cls(idInsurance);
                restRes.responseBody = Blob.valueOf(JSON.serialize(insuranceExternal));
            } catch (Exception e) {
            	response.status = 'Fail';
            	response.message = 'Error: ' + e.getMessage();
                restRes.responseBody = Blob.valueOf(JSON.serialize(response));
            }
        }
        else {
            response.status = 'Fail';
			response.message = 'Error: Param: recordId is not a valid Id';
			restRes.responseBody = Blob.valueOf(JSON.serialize(response));
        }
    }
}