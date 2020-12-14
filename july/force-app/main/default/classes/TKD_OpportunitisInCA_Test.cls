@isTest
public class TKD_OpportunitisInCA_Test {
	@isTest
    public static void getOppApproveds(){
        Opportunity Test_Opp = Data_Factory_Opportunity_Test.createNewOpportunityTypeSales();
        Credit_approval_CP__c Test_CA = Data_Factory_CreditApproval_Test.createNewCreditApprovalTypeWK('Test_Account');
        Opportunity_in_Credit_approval_CP__c Test_Opp_CA = Data_Factory_OpportunityInCA_Test.createOppInCA(Test_CA, Test_Opp);
        list<string> OppCA = new list<string>();
        OppCA.add(Test_Opp_CA.id);
        TKD_OpportunitisInCA.getOppApproveds(OppCA);
    }
}