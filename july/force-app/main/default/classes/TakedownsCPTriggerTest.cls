@isTest
public class TakedownsCPTriggerTest {
 
    @isTest
    public static void getApprovalProccessInstanceStepComment(){
        list<EIV_Parameter__c> parameters = Test.loadData(EIV_Parameter__c.sobjectType, 'parametrosTest');
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
        
        Id devRecordTypeId = Schema.SObjectType.Takedowns_Contingency_plan__c.getRecordTypeInfosByName().get('Takedown').getRecordTypeId();
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
    @isTest
    public static void valTgt2(){
        list<EIV_Parameter__c> parameters = Test.loadData(EIV_Parameter__c.sobjectType, 'parametrosTest');
        Takedowns_Contingency_plan__c takedown = Data_Factory_Takedown_Test.createTakedown('AFINAN-FIJA', 'LaloTest', 'VIGH463728DHFJRKS02');
        takedown.TKD_ls_takedown_stage__c = 'In Signatures';
        takedown.CPL_ls_Deal_Category__c = 'Not new origination';
        takedown.TKD_Tollgate_1_Val__c = true;
        update takedown;        
        takedown.TKD_ls_takedown_stage__c = 'Tollgate 2';
        try {
        	update takedown;     
        } catch(Exception e){
            System.debug('Validación realizada');
        }      
    }
    @isTest
    public static void valTgt2Insurance(){
        list<EIV_Parameter__c> parameters = Test.loadData(EIV_Parameter__c.sobjectType, 'parametrosTest');
        Takedowns_Contingency_plan__c takedown = Data_Factory_Takedown_Test.createTKDLMM();
        takedown.TKD_ls_takedown_stage__c = 'In Signatures';
        takedown.CPL_ls_Deal_Category__c = 'Not new origination';
        takedown.TKD_Tollgate_1_Val__c = true;
        update takedown;        
        takedown.TKD_ls_takedown_stage__c = 'Tollgate 2';
        Data_Factory_Insurance_VoBo.createExternalInsurance_VoBo(takedown.id);
        try {
        	update takedown;     
        } catch(Exception e){
            System.debug('Validación realizada');
        }      
    }
    @isTest
    public static void valTgt2ApprovedInsurance(){
        list<EIV_Parameter__c> parameters = Test.loadData(EIV_Parameter__c.sobjectType, 'parametrosTest');
        Takedowns_Contingency_plan__c takedown = Data_Factory_Takedown_Test.createTKDLMM();
        takedown.TKD_ls_takedown_stage__c = 'In Signatures';
        takedown.CPL_ls_Deal_Category__c = 'Not new origination';
        takedown.TKD_Tollgate_1_Val__c = true;
        update takedown;        
        takedown.TKD_ls_takedown_stage__c = 'Tollgate 2';
        Insurance_VoBo__c Insurance_VoBo = Data_Factory_Insurance_VoBo.createExternalInsurance_VoBo(takedown.id);
        Data_Factory_Insurance_Policy.createInsurance_Policy(Insurance_VoBo.id);
        try {
        	update takedown;     
        } catch(Exception e){
            System.debug('Validación realizada');
        }      
    }

}