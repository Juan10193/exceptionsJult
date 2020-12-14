@RestResource(urlMapping = '/DetailsInsuranceToGo')
global class DetailsInsuranceToGo {
    
	@HttpGet
    global static void getDetailsInsurance() {
        RestRequest restReq = RestContext.request;
        RestResponse restRes = RestContext.response;
        String idTakedwon = restReq.params.get('idTakedown');
        DetailsInsuranceToGo_cls.Response response = new DetailsInsuranceToGo_cls.Response();
        restRes.addHeader('Content-Type', 'application/json;charset=UTF-8');
        
        if(idTakedwon != null) {
            try {
            	DetailsInsuranceToGo_cls isnurance = new DetailsInsuranceToGo_cls(idTakedwon);
                restRes.responseBody = Blob.valueOf(JSON.serialize(isnurance));
            } catch (Exception e) {
                response.status = 'Success';
            	response.message = 'Takedown without Insurance Polices';
                System.debug('Exception: ' + e.getMessage());
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