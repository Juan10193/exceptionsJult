@isTest
public class APInstanceStepCommentControllerTest {
    @testSetup static void setup(){
        //creation of EIV parameters
        list<EIV_Parameter__c> parameters = Test.loadData(EIV_Parameter__c.sobjectType, 'parametrosTest');
        System.assert(parameters.size()>0);
    }
    
    @isTest
    public static void getApprovalProccessInstanceStepComment(){
        Opportunity opp = Data_Factory_Opportunity_Test.createNewOpportunityTypeWK();
       TBO021_Takedowns_forecast__c forecast = Data_Factory_EasyForecast_Test.createForecast(opp.Id);
       IST__SuperTRUMP_Template__c template = TestDataFactory_tst.createSTPricingTemplate();
       IST__SuperTRUMP_Pricing_Quote__c pq = TestDataFactory_tst.createSTPricingQuote(opp,template);
       Test.startTest();
       Entity_CP__c entitycp = Data_Factory_EntityCp.createEntityCP('CDMX', 'CDMX123456' );
       Takedowns_Contingency_plan__c takedown = new Takedowns_Contingency_plan__c();
       takedown.CPL_ls_Stage__c = 'New';
       takedown.CPL_rb_Entity_Name_CP__c =entitycp.Id;
       takedown.Takedowns_forecast__c = forecast.Id;
       takedown.Annex_Pricing_SuperTrump__c = pq.Id;
       takedown.TKD_ls_takedown_stage__c ='Converted';
       takedown.CPL_ls_Deal_Category__c ='Refi';
       takedown.Financing_Needs__c ='CapEx Lines';
       takedown.CPL_rb_Opp__c = opp.Id;
       takedown.TDAmount__c =1.00;
       takedown.Contract_Annex_Number__c= '13213124';
       takedown.Invoice_Exchange_Rate__c =19.147400;
       takedown.CPL_ls_Operation_Unit__c ='	UO_397 HOLDING';
       takedown.CLI_lsInvoice_Currency__c ='MXN';
       takedown.CPL_ls_Product__c ='OPERFIN-FIJA';
       insert takedown;
        
        string action = 'Reject';
        string comment = TkdActionsController_Test.getComments();
        list<EIV_Parameter__c> parameters = Test.loadData(EIV_Parameter__c.sobjectType, 'parametrosTest');
        Id devRecordTypeId = Schema.SObjectType.Takedowns_Contingency_plan__c.getRecordTypeInfosByName().get('Takedown').getRecordTypeId();


        //Takedowns_Contingency_plan__c takedown = Data_Factory_Takedown_Test.createTakedown('OPERFIN-FIJA','CDMX', 'CDMX123456');
		
        takedown.RecordTypeId = devRecordTypeId;
        update takedown; 
        takedown.CPL_ls_Stage__c = 'Tollgate 1';
        update takedown; 
		
        id userId = UserInfo.getUserId();

        // Create an approval request for the account
        Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
        req1.setComments('Submitting request for approval.');
        req1.setObjectId(takedown.id);

        // Submit on behalf of a specific submitter
        req1.setSubmitterId(userId); 

        // Submit the record to specific process and skip the criteria evaluation
        req1.setProcessDefinitionNameOrId('TKD_Tollgate_1');
        req1.setSkipEntryCriteria(true);

        // Submit the approval request for the account
        Approval.ProcessResult result = Approval.process(req1);
        test.stopTest();
        TkdActionsController.processApproval(takedown.Id, action, comment);
        
        list<ProcessInstanceStep> listProInsStep = [SELECT Id, ProcessInstanceId, StepStatus, OriginalActorId, ActorId, Comments, 
                StepNodeId, ElapsedTimeInDays, ElapsedTimeInHours, ElapsedTimeInMinutes, CreatedDate, 
                CreatedById, SystemModstamp FROM ProcessInstanceStep];
        APInstanceStepCommentController.getApprovalProccessInstanceStepComment(listProInsStep.get(0).id);
    }

}