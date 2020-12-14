@Istest
public class TKD_ClosingMemoFullTest {
	@Istest
    static void getCredutApprovalbyOpIdTest(){
        Opportunity opp = Data_Factory_Opportunity_Test.createNewOpportunityTypeSales();
        Credit_approval_CP__c  CA =  Data_Factory_CreditApproval_Test.createNewCreditApprovalTypeWK('PEPES');
        Opportunity_in_Credit_approval_CP__c oppinCa =  Data_Factory_OpportunityInCA_Test.createOppInCA(CA, opp);
        TKD_ClosingMemoFull.getCredutApprovalbyOpId(opp.Id);
    }
    
    @Istest
    static void fecthPricingPQTest(){
       TKD_ClosingMemoFull.fecthPricingPQ('PQ-001');
    }
    
    @Istest
    static void fetchPricingInCATest(){
        Opportunity opp = Data_Factory_Opportunity_Test.createNewOpportunityTypeSales();
        Credit_approval_CP__c  CA =  Data_Factory_CreditApproval_Test.createNewCreditApprovalTypeWK('PEPES');
        Opportunity_in_Credit_approval_CP__c oppinCa =  Data_Factory_OpportunityInCA_Test.createOppInCA(CA, opp);
        IST__SuperTRUMP_Template__c template = TestDataFactory_tst.createSTPricingTemplate();
        IST__SuperTRUMP_Pricing_Quote__c PQ = TestDataFactory_tst.createSTPricingQuote(opp, template);
        
        TBO018_Pricing__c pricing = TestDataFactory_tst.createPricing(opp, PQ);
        pricing.TBO018_tx_Pricing_Status__c ='Approved';
        update pricing;
        ES3_obj_Pricing_in_Credit_Approval__c pricingInCa =  TestDataFactory_tst.createPricingInCA(opp.Id, oppinCa.Id, pricing.Id, CA.Id);
        TKD_ClosingMemoFull.fetchPricingInCA(pricingInCa.Id);
        
    }
    
    @Istest
    static void fetchCovenantsTest(){
        Opportunity opp = Data_Factory_Opportunity_Test.createNewOpportunityTypeSales();
        Credit_approval_CP__c  CA =  Data_Factory_CreditApproval_Test.createNewCreditApprovalTypeWK('PEPES');
        Opportunity_in_Credit_approval_CP__c oppinCa =  Data_Factory_OpportunityInCA_Test.createOppInCA(CA, opp);
        IST__SuperTRUMP_Template__c template = TestDataFactory_tst.createSTPricingTemplate();
        IST__SuperTRUMP_Pricing_Quote__c PQ = TestDataFactory_tst.createSTPricingQuote(opp, template);
        
        TBO018_Pricing__c pricing = TestDataFactory_tst.createPricing(opp, PQ);
        pricing.TBO018_tx_Pricing_Status__c ='Approved';
        update pricing;
        ES3_obj_Pricing_in_Credit_Approval__c pricingInCa =  TestDataFactory_tst.createPricingInCA(opp.Id, oppinCa.Id, pricing.Id, CA.Id);
        TKD_ClosingMemoFull.fetchCovenants(opp.Id);
    }
}