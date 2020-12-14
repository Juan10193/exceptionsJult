@isTest
public class TakedownCPTgrServiceValidateTD_Test {
    @testSetup static void methodName() {
        String uniqueUserName = 'standarduser' + DateTime.now().getTime() + '@testorg.com';
        // This code runs as the system user
        Profile p = [SELECT Id FROM Profile WHERE Name='Risk'];
        User u = new User(Alias = 'standt', Email='standarduser@testorg.com',
        EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
        LocaleSidKey='en_US', ProfileId = p.Id,
        TimeZoneSidKey='America/Los_Angeles',
         UserName=uniqueUserName);
        insert u;

	}
    @isTest
    public static void valTgt2(){
        list<EIV_Parameter__c> parameters = Test.loadData(EIV_Parameter__c.sobjectType, 'parametrosTest');
        Takedowns_Contingency_plan__c takedown = Data_Factory_Takedown_Test.createTKDLMM();
        takedown.TKD_ls_takedown_stage__c = 'In Signatures';
        takedown.CPL_ls_Deal_Category__c = 'Not new origination';
        takedown.TKD_Tollgate_1_Val__c = true;
        update takedown;        
        takedown.TKD_ls_takedown_stage__c = 'Tollgate 2';
        user u = [SELECT id FROM User WHERE Email = 'standarduser@testorg.com'];
        
        try {
        	System.runAs(u) {
          		update takedown; 
        	}
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
        user u = [SELECT id FROM User WHERE Email = 'standarduser@testorg.com'];
        try {
            System.runAs(u) {
          		update takedown;   
            }
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
        Data_Factory_Insurance_Policy.createExternalInsurancePolicy(Insurance_VoBo.id);
        Insurance_VoBo.Stage__c = 'T2 VoBo Approved';
        update Insurance_VoBo;
        user u = [SELECT id FROM User WHERE Email = 'standarduser@testorg.com'];
        try {
            System.runAs(u) {
          		update takedown;   
            }
        } catch(Exception e){
            System.debug('Validación realizada');
        }      
    }
    @isTest
    public static void valTgt2WaiverNew(){
        list<EIV_Parameter__c> parameters = Test.loadData(EIV_Parameter__c.sobjectType, 'parametrosTest');
        Takedowns_Contingency_plan__c takedown = Data_Factory_Takedown_Test.createTKDLMM();
        takedown.TKD_ls_takedown_stage__c = 'In Signatures';
        takedown.CPL_ls_Deal_Category__c = 'Not new origination';
        takedown.TKD_Tollgate_1_Val__c = true;
        update takedown;        
        takedown.TKD_ls_takedown_stage__c = 'Tollgate 2';
        Data_Factory_WaiverToGo.createWaiver(takedown.id);
        user u = [SELECT id FROM User WHERE Email = 'standarduser@testorg.com'];
        try {
            System.runAs(u) {
          		update takedown;   
            }
        } catch(Exception e){
            System.debug('Validación realizada');
        }      
    }
    @isTest
    public static void valTgt2WaiverApproved(){
        list<EIV_Parameter__c> parameters = Test.loadData(EIV_Parameter__c.sobjectType, 'parametrosTest');
        Takedowns_Contingency_plan__c takedown = Data_Factory_Takedown_Test.createTKDLMM();
        takedown.TKD_ls_takedown_stage__c = 'In Signatures';
        takedown.CPL_ls_Deal_Category__c = 'Not new origination';
        takedown.TKD_Tollgate_1_Val__c = true;
        update takedown;        
        takedown.TKD_ls_takedown_stage__c = 'Tollgate 2';
        WaiverToGo__c WaiverToGo = Data_Factory_WaiverToGo.createWaiver(takedown.id);
        WaiverToGo.Stage__c = 'Approved';
        WaiverToGo.Document_Type__c = 'Insurance';
        WaiverToGo.Reason_for_Exception__c = 'Coverage letter';
        update WaiverToGo;
        user u = [SELECT id FROM User WHERE Email = 'standarduser@testorg.com'];
        try {
            System.runAs(u) {
          		update takedown;   
            }
        } catch(Exception e){
            System.debug('Validación realizada');
        }      
    }
    @isTest
    public static void valTgt2WaiverCompleted(){
        list<EIV_Parameter__c> parameters = Test.loadData(EIV_Parameter__c.sobjectType, 'parametrosTest');
        Takedowns_Contingency_plan__c takedown = Data_Factory_Takedown_Test.createTKDLMM();
        takedown.TKD_ls_takedown_stage__c = 'In Signatures';
        takedown.CPL_ls_Deal_Category__c = 'Not new origination';
        takedown.TKD_Tollgate_1_Val__c = true;
        update takedown;        
        takedown.TKD_ls_takedown_stage__c = 'Tollgate 2';
        WaiverToGo__c WaiverToGo = Data_Factory_WaiverToGo.createWaiver(takedown.id);
        WaiverToGo.Stage__c = 'Completed';
        WaiverToGo.Document_Type__c = 'Insurance CRO';
        WaiverToGo.Reason_for_Exception__c = 'No insurance policy';
        update WaiverToGo;
        user u = [SELECT id FROM User WHERE Email = 'standarduser@testorg.com'];
        try {
        	System.runAs(u) {    
          		update takedown;    
            }
        } catch(Exception e){
            System.debug('Validación realizada');
        }      
    }
    @isTest
    public static void valFunded(){
        list<EIV_Parameter__c> parameters = Test.loadData(EIV_Parameter__c.sobjectType, 'parametrosTest');
        Takedowns_Contingency_plan__c takedown = Data_Factory_Takedown_Test.createTKDLMM();
        takedown.TKD_ls_takedown_stage__c = 'In Signatures';
        takedown.CPL_ls_Deal_Category__c = 'Not new origination';
        takedown.TKD_Tollgate_1_Val__c = true;
        update takedown;        
        takedown.TKD_ls_takedown_stage__c = 'Funded';
        user u = [SELECT id FROM User WHERE Email = 'standarduser@testorg.com'];
        try {
            System.runAs(u) {    
          		update takedown;     
            }
        } catch(Exception e){
            System.debug('Validación realizada');
        }      
    }
    @isTest
    public static void valFunFundedInsurance(){
        list<EIV_Parameter__c> parameters = Test.loadData(EIV_Parameter__c.sobjectType, 'parametrosTest');
        Takedowns_Contingency_plan__c takedown = Data_Factory_Takedown_Test.createTKDLMM();
        takedown.TKD_ls_takedown_stage__c = 'In Signatures';
        takedown.CPL_ls_Deal_Category__c = 'Not new origination';
        takedown.TKD_Tollgate_1_Val__c = true;
        update takedown;        
        takedown.TKD_ls_takedown_stage__c = 'Funded';
        Insurance_VoBo__c Insurance_VoBo = Data_Factory_Insurance_VoBo.createExternalInsurance_VoBo(takedown.id);
        //Data_Factory_Insurance_Policy.createInsurance_Policy(Insurance_VoBo.id);
        //Insurance_VoBo.Stage__c = 'T2 VoBo Approved';
        update Insurance_VoBo;
        user u = [SELECT id FROM User WHERE Email = 'standarduser@testorg.com'];
        try {
            System.runAs(u) {  
          		update takedown; 
            }
        } catch(Exception e){
            System.debug('Validación realizada');
        }      
    }
    @isTest
    public static void valFunFundedApprovedInsurance(){
        list<EIV_Parameter__c> parameters = Test.loadData(EIV_Parameter__c.sobjectType, 'parametrosTest');
        Takedowns_Contingency_plan__c takedown = Data_Factory_Takedown_Test.createTKDLMM();
        takedown.TKD_ls_takedown_stage__c = 'In Signatures';
        takedown.CPL_ls_Deal_Category__c = 'Not new origination';
        takedown.TKD_Tollgate_1_Val__c = true;
        update takedown;        
        takedown.TKD_ls_takedown_stage__c = 'Funded';
        Insurance_VoBo__c Insurance_VoBo = Data_Factory_Insurance_VoBo.createInternalInsurance_VoBo(takedown.id);
        Data_Factory_Insurance_Policy.createInternalInsurancePolicy(Insurance_VoBo.id);
        Insurance_VoBo.Stage__c = 'T2 VoBo Approved';
        update Insurance_VoBo;
        user u = [SELECT id FROM User WHERE Email = 'standarduser@testorg.com'];
        try {
            System.runAs(u) {  
          		update takedown; 
            }
        } catch(Exception e){
            System.debug('Validación realizada');
        }      
    }
    @isTest
    public static void valFunFundedApprovedInsurancePNumber(){
        list<EIV_Parameter__c> parameters = Test.loadData(EIV_Parameter__c.sobjectType, 'parametrosTest');
        Takedowns_Contingency_plan__c takedown = Data_Factory_Takedown_Test.createTKDLMM();
        takedown.TKD_ls_takedown_stage__c = 'In Signatures';
        takedown.CPL_ls_Deal_Category__c = 'Not new origination';
        takedown.TKD_Tollgate_1_Val__c = true;
        update takedown;        
        takedown.TKD_ls_takedown_stage__c = 'Funded';
        Insurance_VoBo__c Insurance_VoBo = Data_Factory_Insurance_VoBo.createInternalInsurance_VoBo(takedown.id);
        Insurance_Policy__c Insurance_Policy = Data_Factory_Insurance_Policy.createInternalInsurancePolicy(Insurance_VoBo.id);
        Insurance_VoBo.Stage__c = 'T2 VoBo Approved';
        Insurance_Policy.Insurance_Policy_Number__c = '101024';
        update Insurance_VoBo;
        update Insurance_Policy;
        user u = [SELECT id FROM User WHERE Email = 'standarduser@testorg.com'];
        try {
            System.runAs(u) {  
          		update takedown;
            }
        } catch(Exception e){
            System.debug('Validación realizada');
        }      
    }
    

}