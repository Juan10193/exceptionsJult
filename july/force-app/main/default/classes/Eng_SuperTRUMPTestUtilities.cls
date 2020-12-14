@isTest
public class Eng_SuperTRUMPTestUtilities
{
    @isTest
    public static Opportunity createOpportunity()
    {
        Opportunity opp = new Opportunity(
            Name = 'Test Opportunity',
            Amount = 1000000.00,
            StageName = 'Lead',
            CloseDate = Date.today().addYears(1),
            OPP_ls_Line_of_Business__c='Equipment', 
            OPP_ls_Collateral__c='Agricultural Equipment'
        );
        Database.insert(opp);
        return opp;
    }
    @isTest
    public static IST__SuperTRUMP_Template__c createTemplate()
    {
        IST__SuperTRUMP_Template__c template = new IST__SuperTRUMP_Template__c();
        template.Name = 'Test Template';
        Database.insert(template);
        return template;
    }
    @isTest
    public static IST__SuperTRUMP_Pricing_Quote__c createPricingQuote()
    {
        Opportunity opp = createOpportunity();
        IST__SuperTRUMP_Template__c template = createTemplate();

        IST__SuperTRUMP_Pricing_Quote__c pq = new IST__SuperTRUMP_Pricing_Quote__c();
        pq.IST__Commencement__c = Date.today().addDays(10);
        pq.IST__Cost__c = Decimal.valueOf('50000.00');
        pq.IST__Delivery_Date__c = pq.IST__Commencement__c;
        pq.IST__Description__c = 'Test Quote';
        pq.IST__Is_Synchronized__c = true;
        pq.IST__Opportunity__c = opp.Id;
        pq.IST__Payment__c = Decimal.valueOf('1000000.00');
        pq.IST__stExternalID__c = 'Z10001transaction';
        pq.IST__Template__c = template.Id;
        Database.insert(pq);
        
        IST__SuperTRUMP_PQ_Rent__c rent = new IST__SuperTRUMP_PQ_Rent__c();
        rent.IST__Pricing_Quote__c = pq.Id;
        rent.IST__Advance_Payment__c = 0;
        rent.IST__Num_Payments__c = 60;
        rent.IST__Total_Payments__c = 1080000.00;
        rent.IST__stExternalID__c = 'Z10001transactionrent104';
        Database.insert(rent);
        
        ST_PQ_Periodic_Income__c perinc = new ST_PQ_Periodic_Income__c();
        perinc.Pricing_Quote__c = pq.Id;
        perinc.Num_Payments__c = 60;
        perinc.Average_Payment__c = 45.00;
        perinc.stExternalID__c = 'Z10001transactionperiodicincomes105';
        Database.insert(perinc);
        
        perinc = new ST_PQ_Periodic_Income__c();
        perinc.Pricing_Quote__c = pq.Id;
        perinc.Num_Payments__c = 60;
        perinc.Average_Payment__c = 50.00;
        perinc.stExternalID__c = 'Z10001transactionperiodicincomes106';
        Database.insert(perinc);

        ST_PQ_Periodic_Expense__c perexp = new ST_PQ_Periodic_Expense__c();
        perexp.Pricing_Quote__c = pq.Id;
        perexp.Num_Payments__c = 5;
        perexp.Average_Payment__c = 100.00;
        perexp.Periodicity__c = 'Annual';
        perexp.stExternalID__c = 'Z10001transactionperiodicexpenses107';
        Database.insert(perexp);
        
        return pq;
    }
    public static IST__SuperTRUMP_Pricing_Quote__c createLoanPricingQuote(String opportunityId, String templateId)
    {
        IST__SuperTRUMP_Pricing_Quote__c pq = new IST__SuperTRUMP_Pricing_Quote__c();
        pq.IST__Commencement__c = Date.today().addDays(10);
        pq.IST__Cost__c = Decimal.valueOf('50000.00');
        pq.IST__Delivery_Date__c = pq.IST__Commencement__c;
        pq.IST__Description__c = 'Test Quote 2';
        pq.IST__Is_Synchronized__c = true;
        pq.IST__Opportunity__c = opportunityId;
        pq.IST__Payment__c = Decimal.valueOf('1000000.00');
        pq.IST__stExternalID__c = 'Z10001transaction';
        pq.IST__Template__c = templateId;
        Database.insert(pq);

        IST__SuperTRUMP_PQ_Loan__c loan = new IST__SuperTRUMP_PQ_Loan__c();
        loan.IST__Pricing_Quote__c = pq.Id;
        loan.IST__Advance_Payment__c = 0;
        loan.IST__stExternalID__c = 'Z10001transactionloan108';
        Database.insert(loan);
        
        loan = new IST__SuperTRUMP_PQ_Loan__c();
        loan.IST__Pricing_Quote__c = pq.Id;
        loan.IST__Advance_Payment__c = 0;
        loan.IST__stExternalID__c = 'Z10001transactionloan109';
        Database.insert(loan);
        
        return pq;
    }
}