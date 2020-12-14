/**
 * @File Name          : TakedownsCPTriggerHandler_cls.cls
 * @Description        : 
 * @Author             : eduardo.amiens@outlook.com
 * @Group              : 
 * @Last Modified By   : eduardo.amiens@outlook.com
 * @Last Modified On   : 07-20-2020
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    11/11/2019   eduardo.villegas@engeniumcapital.com     Initial Version
**/
public class TakedownsCPTriggerHandler_cls extends TriggerHandlerKO{ 

    private Map<Id, Takedowns_Contingency_plan__c> newMapTakedownCP;
    private Map<Id, Takedowns_Contingency_plan__c> oldMapTakedownCP;
    private List<Takedowns_Contingency_plan__c> newListTakedownCP; 
    private List<Takedowns_Contingency_plan__c> oldListTakedownCP;
    
    private TakedownCPTgrServiceUnlockTD ServiceUnlockTD;
    private TakedownCPTgrServiceCreatePP ServiceCreatePP;
    private TakedownCPTgrServiceNewSuppliApp ServiceNewSuppliApp;
    private TakedownCPTgrServiceValidateTD ServiceValidateTD;
    private TakedownCPTgrValidateExceptions validateExceptions;
    
    public TakedownsCPTriggerHandler_cls() {
        this.newListTakedownCP = Trigger.new;
        this.oldListTakedownCP = Trigger.old;
        this.newMapTakedownCP = (Map<Id, Takedowns_Contingency_plan__c>) Trigger.newMap;
        this.oldMapTakedownCP = (Map<Id, Takedowns_Contingency_plan__c>) Trigger.oldMap;
    }

    public override void beforeInsert() {

    }
    
    /**
    * @description 
    * @author eduardo.villegas@engeniumcapital.com | 11/11/2019 
    * @return void 
    **/
    public override void beforeUpdate() {
        //TriggerHandlerKO.bypass('OpportunityTriggerHandler');
        this.ServiceUnlockTD = new TakedownCPTgrServiceUnlockTD(this.newListTakedownCP, this.oldListTakedownCP);
        this.ServiceUnlockTD.unlockApprovalData();
        this.ServiceValidateTD = new TakedownCPTgrServiceValidateTD(this.newMapTakedownCP,this.oldMapTakedownCP);
        this.ServiceValidateTD.validtateRules();
        this.validateExceptions = new TakedownCPTgrValidateExceptions(this.newListTakedownCP, this.newMapTakedownCP, this.oldMapTakedownCP);
        this.validateExceptions.validateExceptionsForT2();
        //TriggerHandlerKO.clearBypass('OpportunityTriggerHandler');
  	}
    /**
    * @description 
    * @author eduardo.villegas@engeniumcapital.com | 11/11/2019 
    * @return void 
    **/
    public override void afterInsert() {
        //TriggerHandlerKO.bypass('OpportunityTriggerHandler');
        try{
            this.ServiceCreatePP = new TakedownCPTgrServiceCreatePP(this.newMapTakedownCP);
            this.ServiceCreatePP.makeProgressPayment();
        }catch(Exception e){
        	system.debug(LoggingLevel.ERROR, 'Error ServiceCreatePP ');
            system.debug(LoggingLevel.ERROR, 'e.getCause() ' + e.getCause());
            system.debug(LoggingLevel.ERROR, 'e.getLineNumber()' + e.getLineNumber());
            system.debug(LoggingLevel.ERROR, 'e.getMessage()' + e.getMessage());
        }
        try{
        	this.ServiceNewSuppliApp = new TakedownCPTgrServiceNewSuppliApp(this.newMapTakedownCP);
        	this.ServiceNewSuppliApp.createSupplierInApproval();    
        } catch(Exception e){
        	system.debug(LoggingLevel.ERROR, 'Error ServiceNewSuppliApp ');
            system.debug(LoggingLevel.ERROR, 'e.getCause() ' + e.getCause());
            system.debug(LoggingLevel.ERROR, 'e.getLineNumber()' + e.getLineNumber());
            system.debug(LoggingLevel.ERROR, 'e.getMessage()' + e.getMessage());    
        }
        //TriggerHandlerKO.clearBypass('OpportunityTriggerHandler');
        
  	}
    /**
    * @description 
    * @author eduardo.villegas@engeniumcapital.com | 11/11/2019 
    * @return void 
    **/
    public override void afterUpdate() {
        //TriggerHandlerKO.bypass('OpportunityTriggerHandler');
        this.ServiceCreatePP = new TakedownCPTgrServiceCreatePP(this.newMapTakedownCP);
        this.ServiceCreatePP.makeProgressPayment();
        //TriggerHandlerKO.clearBypass('OpportunityTriggerHandler');
  	}

}