@isTest
public class Data_Access_CreditApprovalCp_Test {
	@isTest
    public static void nullgetCreditApprovalbyopId(){
        Opportunity opp = Data_Factory_Opportunity_Test.createNewOpportunityTypeWK();
        Credit_approval_CP__c CA = Data_Factory_CreditApproval_Test.createNewCreditApprovalTypeWK('Ejemplo Cuenta');
        try{
            Data_Access_CreditApprovalCp_cls.getCreditApprovalbyopId(opp.id);
        }catch(exception e){
            system.debug('catchtest');
            system.debug(e);
        }
        
    }
    @isTest
    public static void getCreditApprovalbyopId(){
        Opportunity Opp = Data_Factory_Opportunity_Test.createNewOpportunityTypeWK();
        Credit_approval_CP__c CA = Data_Factory_CreditApproval_Test.createNewCreditApprovalTypeWK('Ejemplo Cuenta');
        Opportunity_in_Credit_approval_CP__c opp_CA = Data_Factory_OpportunityInCA_Test.createOppInCA(CA, Opp);
        ES3_obj_Pricing_in_Credit_Approval__c pca = new ES3_obj_Pricing_in_Credit_Approval__c();
        try{
            Data_Access_CreditApprovalCp_cls.getCreditApprovalbyopId(pca.id);
        }catch(exception e){
            system.debug('catchtest');
            system.debug(e);
        }
        
    }
}