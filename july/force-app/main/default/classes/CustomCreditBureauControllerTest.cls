@isTest 
public class CustomCreditBureauControllerTest {
    @isTest 
    static void getRejectCreditBureauApprovalProcess(){
        Test.setMock(HttpCalloutMock.class, new EIV_EntityCalloutMock());
        CustomCreditBureauController.getEntityBypartyID('partyID', 'employeeNumber');
        try{
            CustomCreditBureauController.getEntityBypartyID('partyID', '');
        }catch(Exception e){
            system.debug('Error');
        }
        
    }
    @isTest 
    static void getcreateCreditB(){
        Test.setMock(HttpCalloutMock.class, new EIV_EntityCalloutGeneralMock.createCreditBureau());
        CustomCreditBureauController.createCreditBureau('jsonRequest');
        try{
            CustomCreditBureauController.createCreditBureau('');
        }catch(Exception e){
            system.debug('Error');
        }
        
    }
    @isTest 
    static void getCreditBureauApprovalProcess(){
        Test.setMock(HttpCalloutMock.class, new EIV_EntityCalloutMock());
        opportunity opp = Data_Factory_Opportunity_Test.createNewOpportunityTypeLMM();
        CustomCreditBureauController.getCreditBureauApprovalProcess(opp.id);
        try{
            CustomCreditBureauController.getCreditBureauApprovalProcess(opp.id);
        }catch(Exception e){
            system.debug('Error');
        }
        
    }
    @isTest 
    static void getCurrentCreditBureau(){
        Test.setMock(HttpCalloutMock.class, new EIV_EntityCalloutMock());
        CustomCreditBureauController.getCurrentCreditBureau('partyId');
        
    }
    @isTest 
    static void getRequestsCreditBureau(){
        Data_Factory_Opportunity_Test.createNewOpportunityTypeLMM();
        Entity_CP__c Entity_CP = Data_Factory_EntityCp.createEntityCP('TestEntityCP', 'rfcTin');
        LMM_Credit_Bureau_Approval_Process__c LMM_Credit_Bureau_Approval_Process = [SELECT Id, Name, LMM_ls_Stage__c, LMM_rb_Opportunity__c FROM LMM_Credit_Bureau_Approval_Process__c limit 1];
    	LMM_Request_Credit_Bureau__c LMM_Request_Credit_Bureau = new LMM_Request_Credit_Bureau__c();
        LMM_Request_Credit_Bureau.Name = '23243';
        LMM_Request_Credit_Bureau.LMM_ls_Status__c = 'NEW';
        LMM_Request_Credit_Bureau.LMM_tl_JSON_Request__c = '';
        LMM_Request_Credit_Bureau.LMM_pd_Entity_CP__c = Entity_CP.id;
        LMM_Request_Credit_Bureau.LMM_rb_Credit_Bureau_Approval_Process__c = LMM_Credit_Bureau_Approval_Process.id;
        insert LMM_Request_Credit_Bureau;
        CustomCreditBureauController.getRequestsCreditBureau(Entity_CP.id);
        
    }
    @isTest 
    static void getResultssCreditBureau(){
        Test.setMock(HttpCalloutMock.class, new EIV_EntityCalloutGeneralMock.createCreditBureau());
        CustomCreditBureauController.getResultssCreditBureau('jsonParameter');
        try{
           CustomCreditBureauController.getResultssCreditBureau(''); 
        }catch(Exception e){
            System.debug('Error');
        }
        
    }
    @isTest 
    static void getUrlDocs(){
        CustomCreditBureauController.getUrlDocs(); 
        
    }
    
    
    

}