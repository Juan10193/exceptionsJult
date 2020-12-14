/**
 * @File Name          : LMM_Opportunity_CB_AP.cls
 * @Description        : 
 * @Author             : eduardo.amiens@outlook.com
 * @Group              : 
 * @Last Modified By   : eduardo.amiens@outlook.com
 * @Last Modified On   : 5/6/2020 13:00:33
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    5/6/2020   eduardo.amiens@outlook.com     Initial Version
**/
public class LMM_Opportunity_CB_AP {
    private Map<Id, Opportunity> newMapOpportunity;
    
    public LMM_Opportunity_CB_AP(Map<Id, Opportunity> newMapOpportunity){
        system.debug('inicia LMM_Opportunity_CB_AP');
        this.newMapOpportunity = newMapOpportunity;                
    }
    public void createLMM_Credit_Bureau_Approval_Process(){
        list<LMM_Credit_Bureau_Approval_Process__c> listLMM_Credit_Bureau_Approval_Process = new list<LMM_Credit_Bureau_Approval_Process__c>();
        for(Opportunity opp : [SELECT Id, RecordType.Name FROM Opportunity 
        where id in:newMapOpportunity.keySet() 
        and RecordType.Name ='LMM']){
            //if(opp.RecordType.Name.equals('LMM')){
            	LMM_Credit_Bureau_Approval_Process__c LMM_Credit_Bureau_Approval_Process = new LMM_Credit_Bureau_Approval_Process__c();
                LMM_Credit_Bureau_Approval_Process.LMM_rb_Opportunity__c = opp.Id;
                listLMM_Credit_Bureau_Approval_Process.add(LMM_Credit_Bureau_Approval_Process); 
            //}            
        }
		insert listLMM_Credit_Bureau_Approval_Process;        
    }

}