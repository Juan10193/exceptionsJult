@isTest
public class addCurrency_tst {
    static testMethod void testaddCurrency() {
        test.startTest();
        User currentUser = TestDataFactory_tst.createUser('test@engenium.com', 'Generic', 'Sales Rep 1');
        
        System.runAs(currentUser) {
            Account accnt = TestDataFactory_tst.createAccount();
            
            accnt.ACC_dv_Sales_Annual_Revenue__c = 200000000;
            
            update accnt;
            
            TBO022_Competitor__c competitor = TestDataFactory_tst.createCompetitor();
            
            Opportunity opp = TestDataFactory_tst.createOpportunity(accnt, currentUser, competitor);
            
            opp.StageName = 'Opportunity Identified';
            
            update opp;
            
            ReglasAprobacion__c regla = TestDataFactory_tst.createReglaApprovacion();
            
            IST__SuperTRUMP_Template__c pricingTemplate = TestDataFactory_tst.createSTPricingTemplate();
            
            IST__SuperTRUMP_Pricing_Quote__c pricingQuote = TestDataFactory_tst.createSTPricingQuote(opp, pricingTemplate);
            
            IST__SuperTRUMP_PQ_Loan__c pricingLoan = createSTPQLoan(pricingQuote);
            
            IST__SuperTRUMP_PQ_Income_Fee__c pricingFee = createSTPQIncomeFee(pricingQuote);
            
            IST__SuperTRUMP_PQ_Expense_Fee__c pricingExpFee = createSTPQExpFee(pricingQuote);
            
            IST__SuperTRUMP_PQ_Rent__c pricingRent = createSTPQRent(pricingQuote);                     
            
            TBO018_Pricing__c pricing = [SELECT Id FROM TBO018_Pricing__c WHERE TBO018_rb_SuperTRUMP_Pricing_Quote__c = :pricingQuote.Id];
            
			opp.StageName = 'Lost Deal';
            
            opp.OPP_ls_Reason_Lost_Level_1__c = 'Customer Declined';
                
            opp.OPP_ls_Reason_Lost_Level_2__c = 'Ability to Execute';
                
            opp.OPP_ls_Reason_Lost_Level_3__c = 'Ability to Deliver';
            
            opp.OPP_tx_Lost_Comments__c = 'Se perdio';
                
            update opp;
        }
        
        test.stopTest();       
        
    }    
    
    public static IST__SuperTRUMP_PQ_Loan__c createSTPQLoan( IST__SuperTRUMP_Pricing_Quote__c quote ) {
        IST__SuperTRUMP_PQ_Loan__c loan = new IST__SuperTRUMP_PQ_Loan__c();
        loan.IST__Pricing_Quote__c = quote.id;        
        insert loan;        
        return loan;
    }
    public static IST__SuperTRUMP_PQ_Income_Fee__c createSTPQIncomeFee( IST__SuperTRUMP_Pricing_Quote__c quote ) {
        IST__SuperTRUMP_PQ_Income_Fee__c fee = new IST__SuperTRUMP_PQ_Income_Fee__c();
        fee.IST__Pricing_Quote__c = quote.id;        
        insert fee;        
        return fee;
    }    
    public static IST__SuperTRUMP_PQ_Expense_Fee__c createSTPQExpFee( IST__SuperTRUMP_Pricing_Quote__c quote ) {
        IST__SuperTRUMP_PQ_Expense_Fee__c fee = new IST__SuperTRUMP_PQ_Expense_Fee__c();
        fee.IST__Pricing_Quote__c = quote.id;        
        insert fee;        
        return fee;
    }    
    public static IST__SuperTRUMP_PQ_Rent__c createSTPQRent( IST__SuperTRUMP_Pricing_Quote__c quote ) {
        IST__SuperTRUMP_PQ_Rent__c fee = new IST__SuperTRUMP_PQ_Rent__c();
        fee.IST__Pricing_Quote__c = quote.id;        
        insert fee;        
        return fee;
    }      
    
    
}