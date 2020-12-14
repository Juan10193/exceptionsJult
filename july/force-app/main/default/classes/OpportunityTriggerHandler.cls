/**
 * @description       : 
 * @author            : eduardo.amiens@outlook.com
 * @group             : 
 * @last modified on  : 11-12-2020
 * @last modified by  : eduardo.amiens@outlook.com
 * Modifications Log 
 * Ver   Date         Author                       Modification
 * 1.0   09-28-2020   eduardo.amiens@outlook.com   Initial Version
**/
public class OpportunityTriggerHandler extends TriggerHandlerKO{ 

    private Map<Id, Opportunity> newMapOpportunity;
    private Map<Id, Opportunity> oldMapOpportunity;
    private List<Opportunity> newListOpportunity; 
    private List<Opportunity> oldListOpportunity;
    
    private OpportunityStageValidation opportunityStageValidation;
    private UpdateAmountCA updateAmountCA;
    private AccountUpdateLastDateFundedOP accountUpdateLastDateFundedOP; 
    private UpdateOpportunityLostStage updateOpportunityLostStage;
    private OpportunityContactRoleValidation opportunityContactRoleValidation;
    private LMM_Opportunity_CB_AP lMM_Opportunity_CB_AP;
    private WOA_Create_Custom_AP wOA_Create_Custom_AP;
    
    public OpportunityTriggerHandler() {
        this.newListOpportunity = Trigger.new;
        this.oldListOpportunity = Trigger.old;        
        this.newMapOpportunity = (Map<Id, Opportunity>) Trigger.newMap;
        this.oldMapOpportunity = (Map<Id, Opportunity>) Trigger.oldMap;
    }
    public override void afterUpdate() {
        this.updateAmountCA = new UpdateAmountCA(this.newListOpportunity, this.oldMapOpportunity);
        this.updateAmountCA.updateCA(this.updateAmountCA.searchCAToUpdate());
        
        this.accountUpdateLastDateFundedOP =  new AccountUpdateLastDateFundedOP(this.oldListOpportunity, this.newListOpportunity);
        this.accountUpdateLastDateFundedOP.updateCA(this.accountUpdateLastDateFundedOP.getSetAccountIDByOppFunded(), false);
        
  	}
    public override void beforeUpdate() {
//        LMM_OpportunityValidateReporteV.validaReportedVisita(oldListOpportunity, newMapOpportunity);
        this.opportunityStageValidation = new OpportunityStageValidation(this.newListOpportunity, this.newMapOpportunity, this.oldMapOpportunity);
        this.opportunityStageValidation.proporsalOrApprovedStage();
        
        this.updateOpportunityLostStage = new UpdateOpportunityLostStage(this.newListOpportunity, this.oldMapOpportunity);
        this.updateOpportunityLostStage.fillLostStageData();
        
        this.opportunityContactRoleValidation = new OpportunityContactRoleValidation(this.newMapOpportunity); 
    	this.opportunityContactRoleValidation.validateContactRole();
  	}
    public override void afterDelete() {     
        this.accountUpdateLastDateFundedOP =  new AccountUpdateLastDateFundedOP(this.oldListOpportunity, this.newListOpportunity);
        this.accountUpdateLastDateFundedOP.updateCA(this.accountUpdateLastDateFundedOP.getSetAccountIDByOpp(), true);        
    }
    public override void afterInsert() {    
		this.lMM_Opportunity_CB_AP = new LMM_Opportunity_CB_AP(this.newMapOpportunity);
        this.lMM_Opportunity_CB_AP.createLMM_Credit_Bureau_Approval_Process();
        this.wOA_Create_Custom_AP = new WOA_Create_Custom_AP(this.newMapOpportunity);
		this.wOA_Create_Custom_AP.createRecords();
		        
    }

}