@isTest
public class CreditBureauApprovalProcess_TriggerTest {
    @isTest 
    static void getApproveCreditBureauApprovalProcess(){
        Data_Factory_Opportunity_Test.createNewOpportunityTypeLMM();
        LMM_Credit_Bureau_Approval_Process__c LMM_Credit_Bureau_Approval_Process = [SELECT Id, Name, LMM_ls_Stage__c, LMM_rb_Opportunity__c FROM LMM_Credit_Bureau_Approval_Process__c limit 1];
    	LMM_Request_Credit_Bureau__c LMM_Request_Credit_Bureau = new LMM_Request_Credit_Bureau__c();
        LMM_Request_Credit_Bureau.Name = '23243';
        LMM_Request_Credit_Bureau.LMM_ls_Status__c = 'NEW';
        LMM_Request_Credit_Bureau.LMM_tl_JSON_Request__c = '';
        LMM_Request_Credit_Bureau.LMM_pd_Entity_CP__c = Data_Factory_EntityCp.createEntityCP('TestEntityCP', 'rfcTin').id;
        LMM_Request_Credit_Bureau.LMM_rb_Credit_Bureau_Approval_Process__c = LMM_Credit_Bureau_Approval_Process.id;
        insert LMM_Request_Credit_Bureau;
        
        Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
        req1.setComments('Submitting request for approval.');
        req1.setObjectId(LMM_Credit_Bureau_Approval_Process.id);

        // Submit on behalf of a specific submitter
        req1.setSubmitterId(UserInfo.getUserId()); 

        // Submit the record to specific process and skip the criteria evaluation
        req1.setProcessDefinitionNameOrId('Credit_Bureau_Approval_Processes');
        req1.setSkipEntryCriteria(true);

        // Submit the approval request for the account
        Approval.ProcessResult result = Approval.process(req1);
        test.startTest();
        //Class used for Approving Record
         Approval.ProcessWorkitemRequest req = new Approval.ProcessWorkitemRequest();
         req.setComments('Approving request for Opportunity');
         
         //Approve or Reject Record
         req.setAction('Approve');
         
         //Getting Work Item Id
         ProcessInstanceWorkitem pItem = [Select Id from ProcessInstanceWorkitem 
         where ProcessInstance.TargetObjectId =: LMM_Credit_Bureau_Approval_Process.id];
        
         req.setWorkitemId(pItem.Id);
         // Submit the request for approval
		 result = Approval.process(req);
        test.stopTest();
    }
    @isTest 
    static void getRejectCreditBureauApprovalProcess(){
        Data_Factory_Opportunity_Test.createNewOpportunityTypeLMM();
        LMM_Credit_Bureau_Approval_Process__c LMM_Credit_Bureau_Approval_Process = [SELECT Id, Name, LMM_ls_Stage__c, LMM_rb_Opportunity__c FROM LMM_Credit_Bureau_Approval_Process__c limit 1];
    	LMM_Request_Credit_Bureau__c LMM_Request_Credit_Bureau = new LMM_Request_Credit_Bureau__c();
        LMM_Request_Credit_Bureau.Name = '23243';
        LMM_Request_Credit_Bureau.LMM_ls_Status__c = 'NEW';
        LMM_Request_Credit_Bureau.LMM_tl_JSON_Request__c = '';
        LMM_Request_Credit_Bureau.LMM_pd_Entity_CP__c = Data_Factory_EntityCp.createEntityCP('TestEntityCP', 'rfcTin').id;
        LMM_Request_Credit_Bureau.LMM_rb_Credit_Bureau_Approval_Process__c = LMM_Credit_Bureau_Approval_Process.id;
        insert LMM_Request_Credit_Bureau;
        
        Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
        req1.setComments('Submitting request for approval.');
        req1.setObjectId(LMM_Credit_Bureau_Approval_Process.id);

        // Submit on behalf of a specific submitter
        req1.setSubmitterId(UserInfo.getUserId()); 

        // Submit the record to specific process and skip the criteria evaluation
        req1.setProcessDefinitionNameOrId('Credit_Bureau_Approval_Processes');
        req1.setSkipEntryCriteria(true);

        // Submit the approval request for the account
        Approval.ProcessResult result = Approval.process(req1);
        test.startTest();
        //Class used for Approving Record
         Approval.ProcessWorkitemRequest req = new Approval.ProcessWorkitemRequest();
         req.setComments('Approving request for Opportunity');
         
         //Approve or Reject Record
         req.setAction('Reject');
         
         //Getting Work Item Id
         ProcessInstanceWorkitem pItem = [Select Id from ProcessInstanceWorkitem 
         where ProcessInstance.TargetObjectId =: LMM_Credit_Bureau_Approval_Process.id];
        
         req.setWorkitemId(pItem.Id);
         // Submit the request for approval
		 result = Approval.process(req);
        test.stopTest();
    }

}