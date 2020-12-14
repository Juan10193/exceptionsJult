global class ExceptionToGoApproval_cls {
	
    public static Response approveRecord(Id idException, String comments) {
		Approval.ProcessWorkitemRequest req = new Approval.ProcessWorkitemRequest();
        Response response = new Response();        
		req.setComments(comments);
		req.setAction('Approve');

        Id pItem = itemsId(idException);
        if(pItem == null ) {
            response.status = 'Fail';
            response.message = 'Sin proceso de aprovación';
            return response;
        }
        else {        
            req.setWorkitemId(pItem);
            Approval.ProcessResult result = Approval.process(req);
            response.status = 'Success';
            response.message = 'Aprobación generada con éxito.';
            return response;
        }
 	}
    
    public static Response rejectRecord(Id idException, String comments) {
		Approval.ProcessWorkitemRequest req = new Approval.ProcessWorkitemRequest();
        Response response = new Response();
		req.setComments(comments);
		req.setAction('Reject');

        Id pItem = itemsId(idException);
        if(pItem == null ) {
            response.status = 'Fail';
            response.message = 'Sin proceso de aprovación';
            return response;
        }
        else {        
            req.setWorkitemId(pItem);
            Approval.ProcessResult result = Approval.process(req);
            response.status = 'Success';
            response.message = 'Reject generado con éxito.';
            return response;
        }
 	}
    
    public static Id itemsId(Id idException){
        Id itemsId = null;
        for(ProcessInstanceWorkitem workItem  : [Select p.Id from ProcessInstanceWorkitem p where p.ProcessInstance.TargetObjectId =: idException LIMIT 1]){
            itemsId  =  workItem.Id;
        }
        return itemsId;
    }
    
    public class Response {
        public String status {get; set;}
        public String message {get; set;}
    }
}