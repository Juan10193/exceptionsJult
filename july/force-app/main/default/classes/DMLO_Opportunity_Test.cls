@Istest
private class DMLO_Opportunity_Test {
    @Istest
    static void updateOpportunityTest(){
        Opportunity opp = Data_Factory_Opportunity_Test.createNewOpportunityTypeWK();
        list<Opportunity> opportunitys = new list<Opportunity>();
        opportunitys.add(opp);
        DMLO_Opportunity.updateOpportunity(opportunitys);
    }
    
    @Istest
    static void updateOpportunityFailTest(){
       
        Opportunity opp = Data_Factory_Opportunity_Test.createNewOpportunityTypeWK();
        opp.Amount = 1.0;
        update opp;
        list<Opportunity> opportunitys = new list<Opportunity>();
        Opportunity blankOpportunity = new Opportunity();
        opportunitys.add(blankOpportunity);
        DMLO_Opportunity.updateOpportunity(opportunitys);
        UpdateAmountCA upca = new UpdateAmountCA(opportunitys, new Map<Id, Opportunity>{opp.Id =>opp});
        TBO014_Credit_Approval__c cp =  TestDataFactory_tst.createCreditApproval();
        map<id,TBO014_Credit_Approval__c>mapca = new map<id,TBO014_Credit_Approval__c>{cp.id => cp};
        upca.updateCA(mapca);
        
        AccountUpdateLastDateFundedOP aop = new AccountUpdateLastDateFundedOP(opportunitys, opportunitys);
        aop.getSetAccountIDByOpp();
        aop.filltest();
        
        
    }
    
    @Istest
    static void blankConstructor(){
        DMLO_Opportunity dmloOpportunity = new DMLO_Opportunity();
    }
}