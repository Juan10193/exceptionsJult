@Istest
private class Insurance_VoBo_Test {
    
    @IsTest
    static void testT(){
          test.startTest();
        User currentUser = TestDataFactory_tst.createUser('test@engenium.com', 'Insurance', 'Sales Rep - México 1');
        
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
            
            //IST__SuperTRUMP_PQ_Loan__c pricingLoan = createSTPQLoan(pricingQuote);
            
            //IST__SuperTRUMP_PQ_Income_Fee__c pricingFee = createSTPQIncomeFee(pricingQuote);
            
            //IST__SuperTRUMP_PQ_Expense_Fee__c pricingExpFee = createSTPQExpFee(pricingQuote);
            
            //IST__SuperTRUMP_PQ_Rent__c pricingRent = createSTPQRent(pricingQuote);                     
            
            TBO018_Pricing__c pricing = [SELECT Id FROM TBO018_Pricing__c WHERE TBO018_rb_SuperTRUMP_Pricing_Quote__c = :pricingQuote.Id];            
		
            TBO021_Takedowns_forecast__c tdf = new TBO021_Takedowns_forecast__c();
            tdf.TBO021_rb_Opportunity__c = opp.id;
            tdf.TBO021_dv_Amount__c = 1;
            tdf.CurrencyIsoCode = 'USD';
            tdf.TBO021_ls_Committed__c = 'No';
            tdf.TBO021_fh_Delivery_Date__c = Date.today();
            tdf.TBO021_fh_Funding_Date__c = Date.today();
            tdf.TBO021_ls_Invoice_Currency__c = 'USD';
            tdf.TBO021_ls_Status__c = 'New';
            insert tdf;
            tdf.TBO021_ls_Committed__c = 'Yes';
            tdf.TBO021_ls_Status__c = 'Funded';
            update tdf;
            
            //Se agrego para validar el contacto primario
            OpportunityContactRole oppRole = new OpportunityContactRole();
            oppRole.OpportunityId = opp.id;
            oppRole.IsPrimary = true;
            oppRole.ContactId = TestDataFactory_tst.createContact(accnt).id;
            insert oppRole;
            System.debug('Aqui ya se inserto el oppRole');            
            opp.StageName = 'Proposal';
            update opp; 
            
            Takedowns_Contingency_plan__c TDCP = new Takedowns_Contingency_plan__c();
            TDCP.CurrencyIsoCode = 'USD';
            TDCP.CPL_rb_Opp__c = opp.id;
            //TDCP.Takedowns_forecast__c = tdf.id;
            TDCP.Contract_Annex_Number__c = 'ssasasas';
            TDCP.Financing_Needs__c = 'CapEx Lines';
           
            
            insert TDCP;
            
            Insurance_VoBo__c ins = new Insurance_VoBo__c();
            ins.Takedown_CP__c = TDCP.id;
            insert ins;
            ins.Requestor_Comments__c = 'Omar';
            //ins.Stage__c = 'T1 Quote Approved';
            update ins;

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