public without sharing class WS_ApproveTakedownHelper {
    public virtual class BaseException extends Exception {}
    public class WsException extends BaseException {}
    
    public static void approve( string recordId, string action, string comments){
        list<Id>newWorkItemIds =Data_Access_Supplier_in_approval.getitemApprovaciones(recordId);
        if(newWorkItemIds.size()>0){
            Approval.ProcessWorkitemRequest req2 = new Approval.ProcessWorkitemRequest();
        
            req2.setComments(comments);
            req2.setAction(action);
            req2.setNextApproverIds(new Id[] {UserInfo.getUserId()});
     
            // Use the ID from the newly created item to specify the item to be worked
            req2.setWorkitemId(newWorkItemIds.get(0));
     
            // Submit the request for approval
            Approval.ProcessResult result2 =  Approval.process(req2);
     
            // Verify the results
            System.assert(result2.isSuccess(), 'Result Status:'+result2.isSuccess());
     
           
        }else{
            throw new WsException('No hay aprovaciones pendientes');
        }  
    }
}