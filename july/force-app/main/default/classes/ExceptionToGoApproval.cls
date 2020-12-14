@RestResource (urlMapping='/ExceptionApproval/*')
global class ExceptionToGoApproval {

    @HttpPost
    global static void approvalException(String action, String comment, String idException) {
        RestResponse restRes = RestContext.response;
        ExceptionToGoApproval_cls.Response response = new ExceptionToGoApproval_cls.Response();
        
        if(action != null && comment != null && idException != null) {
            if(action == 'Approve') {
                response = ExceptionToGoApproval_cls.approveRecord(idException, comment);
            }
            else if(action == 'Reject') {
                response = ExceptionToGoApproval_cls.rejectRecord(idException, comment);
            }
            else {
                response.status = 'Fail';
            	response.message = 'Acción invalida';
            }
        }
        else {
            response.status = 'Fail';
            response.message = 'Valide los datos acción: '+action+', comentario: '+comment+' o Id: '+ idException;
        }
        
        restRes.addHeader('Content-Type', 'application/json;charset=UTF-8');
		restRes.responseBody = Blob.valueOf(JSON.serialize(response, true));
    }
}