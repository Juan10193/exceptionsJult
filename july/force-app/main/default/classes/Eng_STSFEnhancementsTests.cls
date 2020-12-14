@isTest
private class Eng_STSFEnhancementsTests
{
    static testMethod void testCustomEnhancementObjects(){
        IST__SuperTRUMP_Pricing_Quote__c quote = Eng_SuperTRUMPTestUtilities.createPricingQuote();
        Eng_STSFEnhancements stEnhancements = new Eng_STSFEnhancements();
        Blob b = Blob.valueof('');
        String xmlIn = stEnhancements.queryXML('', b);
        TestXmlIn(xmlIn);
        String xmlOut = getXmlOut();
        Eng_STSFEnhancements.CustomSTObjects customSTObjs = stEnhancements.parse(xmlOut);
        TestCustomSTObjs(customSTObjs);
        Add2TVSchedSteps(quote.Id);
        stEnhancements.CreateEnhancementObjects(quote.Id, customSTObjs);
        TestCashflowDB(quote.Id);
        TestAmortDB(quote.Id);
        TestTVSchedDB(quote.Id);
        
        String xmlOut2 = getXmlOut2();
        
        customSTObjs = stEnhancements.parse(xmlOut2);
        stEnhancements.CreateEnhancementObjects(quote.Id, customSTObjs);
        TestCashflowDB2(quote.Id);
        TestAmortDB2(quote.Id);
        TestTVSchedDB2(quote.Id);
        
        IST__SuperTRUMP_Pricing_Quote__c quoteloan = Eng_SuperTRUMPTestUtilities.createLoanPricingQuote(quote.IST__Opportunity__c, quote.IST__Template__c);
        String loanXmlOut1 = getLoanXmlOut1();
        customSTObjs = stEnhancements.parse(loanXmlOut1);
        stEnhancements.CreateEnhancementObjects(quoteloan.Id, customStObjs);
        TestLoanCashflowDB1(quoteloan.Id);
        String loanXmlOut2 = getLoanXmlOut2();

        IST__SuperTRUMP_PQ_Loan__c loan = [Select Id From IST__SuperTRUMP_PQ_Loan__c Where IST__Pricing_Quote__c = :quoteloan.Id And IST__stExternalID__c = 'Z10001transactionloan109' Limit 1];
        delete loan;

        stEnhancements.ParseAndCreateEnhancements(quoteloan.Id, loanXmlOut2);
        TestLoanCashflowDB2(quoteloan.Id);
    }
    
    private static void Add2TVSchedSteps(String pobjId)
    {
        List<ST_PQ_TV_Schedule_Step__c> sObjs = new List<ST_PQ_TV_Schedule_Step__c>();
        
        ST_PQ_TV_Schedule_Step__c step = new ST_PQ_TV_Schedule_Step__c(Quote__c = pobjID,
                                                                       TV_Date__c = '2018-01-02',
                                                                       Number_of_Payments_Scheduled__c = 1,
                                                                       Arrears_Rent__c = 2.0,
                                                                       Advance_Rent__c = 3.0,
                                                                       Arrears_Debt_Service__c = 4.0,
                                                                       Advance_Debt_Service__c = 5.0,
                                                                       Termination_Value_Percent__c = 6.0,
                                                                       Termination_Value_Amount__c = 7.0,
                                                                       Total_Due_On_Termination__c = 8.0
                                                                       );
                                                                       
         sObjs.Add(step);
        
         step = new ST_PQ_TV_Schedule_Step__c(Quote__c = pobjID,
                                              TV_Date__c = '2018-01-03',
                                              Number_of_Payments_Scheduled__c = 2,
                                              Arrears_Rent__c = 9.0,
                                              Advance_Rent__c = 10.0,
                                              Arrears_Debt_Service__c = 11.0,
                                              Advance_Debt_Service__c = 12.0,
                                              Termination_Value_Percent__c = 13.0,
                                              Termination_Value_Amount__c = 14.0,
                                              Total_Due_On_Termination__c = 15.0
                                              );
                                                   
        sObjs.Add(step);
        insert sObjs;
        
        sObjs = [Select Id, Quote__c From ST_PQ_TV_Schedule_Step__c Where Quote__c = :pobjId];
        System.assertequals(2, sObjs.Size());
    }
    
    private static void TestAmortDB(String pobjId)
    {
        IST__SuperTRUMP_PQ_Rent__c rent = [Select Id From IST__SuperTRUMP_PQ_Rent__c Where IST__Pricing_Quote__c = :pobjId Limit 1];
        List<ST_PQ_Rent_Amortization_Schedule_Step__c> rentAmortSteps = [Select Rent__c, Balance__c, Amort_Date__c, Funding__c, Interest__c, Payment__c, Principal__c From ST_PQ_Rent_Amortization_Schedule_Step__c Where Rent__c = :rent.Id];
        System.assertequals(4, rentAmortSteps.Size());
        System.assertequals(1000000.00, rentAmortSteps[0].Balance__c);
        System.assertequals('2018-08-14', rentAmortSteps[0].Amort_Date__c);
        System.assertequals(1000000.00, rentAmortSteps[0].Funding__c);
        System.assertequals(null, rentAmortSteps[0].Interest__c);
        System.assertequals(null, rentAmortSteps[0].Payment__c);
        System.assertequals(null, rentAmortSteps[0].Principal__c);
        System.assertequals(984558.68088694, rentAmortSteps[1].Balance__c.setscale(8));
        System.assertequals('2018-09-14', rentAmortSteps[1].Amort_Date__c);
        System.assertequals(null, rentAmortSteps[1].Funding__c);
        System.assertequals(2558.68088694, rentAmortSteps[1].Interest__c.setscale(8));
        System.assertequals(18000.00, rentAmortSteps[1].Payment__c);
        System.assertequals(15441.31911306, rentAmortSteps[1].Principal__c.setscale(8));
    }
    
    private static void TestTVSchedDB(String pobjId)
    {
        List<ST_PQ_TV_Schedule_Step__c> TVSteps = [Select Quote__c, TV_Date__c, Number_of_Payments_Scheduled__c, Termination_Value_Percent__c, Termination_Value_Amount__c, Advance_Rent__c, Arrears_Rent__c, Advance_Debt_Service__c, Arrears_Debt_Service__c, Total_Due_On_Termination__c From ST_PQ_TV_Schedule_Step__c Where Quote__c = :pobjId];
        System.assertequals(3, TVSteps.Size());
        System.assertequals('2018-10-22', TVSteps[0].TV_Date__c);
        System.assertequals(0, TVSteps[0].Number_of_Payments_Scheduled__c);
        System.assertequals(100.00, TVSteps[0].Termination_Value_Percent__c);
        System.assertequals(2000000.00, TVSteps[0].Termination_Value_Amount__c);
        System.assertequals(0, TVSteps[0].Advance_Rent__c);
        System.assertequals(0, TVSteps[0].Arrears_Rent__c);
        System.assertequals(0, TVSteps[0].Advance_Debt_Service__c);
        System.assertequals(0, TVSteps[0].Arrears_Debt_Service__c);
        System.assertequals(2000000.00, TVSteps[0].Total_Due_On_Termination__c);
        System.assertequals('2018-11-22', TVSteps[1].TV_Date__c);
        System.assertequals(1, TVSteps[1].Number_of_Payments_Scheduled__c);
        System.assertequals(95.000034, TVSteps[1].Termination_Value_Percent__c);
        System.assertequals(1900000.68, TVSteps[1].Termination_Value_Amount__c);
        System.assertequals(19000.22, TVSteps[1].Advance_Rent__c);
        System.assertequals(18000.01, TVSteps[1].Arrears_Rent__c);
        System.assertequals(19288.04, TVSteps[1].Advance_Debt_Service__c);
        System.assertequals(18100.03, TVSteps[1].Arrears_Debt_Service__c);
        System.assertequals(1968001.54, TVSteps[1].Total_Due_On_Termination__c);    
        System.assertequals('2018-12-22', TVSteps[2].TV_Date__c);
        System.assertequals(2, TVSteps[2].Number_of_Payments_Scheduled__c);
        System.assertequals(93.000000, TVSteps[2].Termination_Value_Percent__c);
        System.assertequals(1860000.00, TVSteps[2].Termination_Value_Amount__c);
        System.assertequals(null, TVSteps[2].Advance_Rent__c);
        System.assertequals(36000.01, TVSteps[2].Arrears_Rent__c);
        System.assertequals(null, TVSteps[2].Advance_Debt_Service__c);
        System.assertequals(null, TVSteps[2].Arrears_Debt_Service__c);
        System.assertequals(1868001.54, TVSteps[2].Total_Due_On_Termination__c);
    }
    
    private static void TestCashflowDB(String pobjId)
    {
        IST__SuperTRUMP_PQ_Rent__c rent = [Select Id From IST__SuperTRUMP_PQ_Rent__c Where IST__Pricing_Quote__c = :pobjId Limit 1];
        List<ST_PQ_Rent_Cash_Flow_Step__c> rentCashflows = [Select Rent__c, Type__c, Num_Pmts__c, Amount__c, Rate__c, Period__c, Start_Accrual__c, End_Accrual__c, Timing__c From ST_PQ_Rent_Cash_Flow_Step__c Where Rent__c = :rent.Id];
        System.assertequals(2, rentCashFlows.Size());
        System.assertequals('Funding', rentCashflows[0].Type__c);
        System.assertequals(null, rentCashflows[0].Num_Pmts__c);
        System.assertequals(-1000000.00, rentCashflows[0].Amount__c);
        System.assertequals(null, rentCashflows[0].Rate__c);
        System.assertequals(null, rentCashflows[0].Period__c);
        System.assertequals(null, rentCashflows[0].Timing__c);
        System.assertequals(null, rentCashflows[0].Start_Accrual__c);
        System.assertequals('2018-08-14', rentCashflows[0].End_Accrual__c);
        System.assertequals('Payment', rentCashflows[1].Type__c);
        System.assertequals(60, rentCashflows[1].Num_Pmts__c);
        System.assertequals(18000.00, rentCashflows[1].Amount__c);
        System.assertequals(3.070417, rentCashflows[1].Rate__c.setscale(6));
        System.assertequals('Monthly', rentCashflows[1].Period__c);
        System.assertequals('Arrears', rentCashflows[1].Timing__c);
        System.assertequals('2018-08-14', rentCashflows[1].Start_Accrual__c);
        System.assertequals('2023-08-14', rentCashflows[1].End_Accrual__c);

        List<ST_PQ_Periodic_Income__c> perincs = [Select Id From ST_PQ_Periodic_Income__c Where Pricing_Quote__c = :pobjId];
        System.assertequals(2, perincs.Size());
        List<ST_PQ_Periodic_Income_Cash_Flow_Step__c> perincCashflows = [Select Periodic_Income__c, Type__c, Num_Pmts__c, Amount__c, Rate__c, Period__c, Start_Accrual__c, End_Accrual__c, Timing__c From ST_PQ_Periodic_Income_Cash_Flow_Step__c Where Periodic_Income__c = :perincs[0].Id];
        System.assertequals(2, perincCashflows .Size());
        System.assertequals('Funding', perincCashflows[0].Type__c);
        System.assertequals(null, perincCashflows[0].Num_Pmts__c);
        System.assertequals(-3000.00, perincCashflows[0].Amount__c);
        System.assertequals(null, perincCashflows[0].Rate__c);
        System.assertequals(null, perincCashflows[0].Period__c);
        System.assertequals(null, perincCashflows[0].Timing__c);
        System.assertequals(null, perincCashflows[0].Start_Accrual__c);
        System.assertequals('2018-08-14', perincCashflows[0].End_Accrual__c);
        System.assertequals('Payment', perincCashflows[1].Type__c);
        System.assertequals(60, perincCashflows[1].Num_Pmts__c);
        System.assertequals(50.00, perincCashflows[1].Amount__c);
        System.assertequals(0.000000, perincCashflows[1].Rate__c.setscale(6));
        System.assertequals('Monthly', perincCashflows[1].Period__c);
        System.assertequals('Arrears', perincCashflows[1].Timing__c);
        System.assertequals('2018-08-14', perincCashflows[1].Start_Accrual__c);
        System.assertequals('2023-08-14', perincCashflows[1].End_Accrual__c);

        perincCashflows = [Select Periodic_Income__c, Type__c, Num_Pmts__c, Amount__c, Rate__c, Period__c, Start_Accrual__c, End_Accrual__c, Timing__c From ST_PQ_Periodic_Income_Cash_Flow_Step__c Where Periodic_Income__c = :perincs[1].Id];
        System.assertequals(2, perincCashflows .Size());
        System.assertequals('Funding', perincCashflows[0].Type__c);
        System.assertequals(null, perincCashflows[0].Num_Pmts__c);
        System.assertequals(-2700.00, perincCashflows[0].Amount__c);
        System.assertequals(null, perincCashflows[0].Rate__c);
        System.assertequals(null, perincCashflows[0].Period__c);
        System.assertequals(null, perincCashflows[0].Timing__c);
        System.assertequals(null, perincCashflows[0].Start_Accrual__c);
        System.assertequals('2018-08-14', perincCashflows[0].End_Accrual__c);
        System.assertequals('Payment', perincCashflows[1].Type__c);
        System.assertequals(60, perincCashflows[1].Num_Pmts__c);
        System.assertequals(45.00, perincCashflows[1].Amount__c);
        System.assertequals(0.000000, perincCashflows[1].Rate__c.setscale(6));
        System.assertequals('Monthly', perincCashflows[1].Period__c);
        System.assertequals('Arrears', perincCashflows[1].Timing__c);
        System.assertequals('2018-08-14', perincCashflows[1].Start_Accrual__c);
        System.assertequals('2023-08-14', perincCashflows[1].End_Accrual__c);
        
        List<ST_PQ_Periodic_Expense__c> perexps = [Select Id From ST_PQ_Periodic_Expense__c Where Pricing_Quote__c = :pobjId];
        System.assertequals(1, perexps.Size());
        List<ST_PQ_Periodic_Expense_Cash_Flow_Step__c> perexpCashflows = [Select Periodic_Expense__c, Type__c, Num_Pmts__c, Amount__c, Rate__c, Period__c, Start_Accrual__c, End_Accrual__c, Timing__c From ST_PQ_Periodic_Expense_Cash_Flow_Step__c Where Periodic_Expense__c = :perexps[0].Id];
        System.assertequals(2, perexpCashflows.Size());
        System.assertequals('Funding', perexpCashflows[0].Type__c);
        System.assertequals(null, perexpCashflows[0].Num_Pmts__c);
        System.assertequals(-500.00, perexpCashflows[0].Amount__c);
        System.assertequals(null, perexpCashflows[0].Rate__c);
        System.assertequals(null, perexpCashflows[0].Period__c);
        System.assertequals(null, perexpCashflows[0].Timing__c);
        System.assertequals(null, perexpCashflows[0].Start_Accrual__c);
        System.assertequals('2018-08-14', perexpCashflows[0].End_Accrual__c);
        System.assertequals('Payment', perexpCashflows[1].Type__c);
        System.assertequals(5, perexpCashflows[1].Num_Pmts__c);
        System.assertequals(100.00, perexpCashflows[1].Amount__c);
        System.assertequals(0.000000, perexpCashflows[1].Rate__c.setscale(6));
        System.assertequals('Annual', perexpCashflows[1].Period__c);
        System.assertequals('Arrears', perexpCashflows[1].Timing__c);
        System.assertequals('2018-08-14', perexpCashflows[1].Start_Accrual__c);
        System.assertequals('2023-08-14', perexpCashflows[1].End_Accrual__c);
    }
    
    private static void TestAmortDB2(String pobjId)
    {
        IST__SuperTRUMP_PQ_Rent__c rent = [Select Id From IST__SuperTRUMP_PQ_Rent__c Where IST__Pricing_Quote__c = :pobjId Limit 1];
        List<ST_PQ_Rent_Amortization_Schedule_Step__c> rentAmortSteps = [Select Rent__c, Balance__c, Amort_Date__c, Funding__c, Interest__c, Payment__c, Principal__c From ST_PQ_Rent_Amortization_Schedule_Step__c Where Rent__c = :rent.Id];
        System.assertequals(4, rentAmortSteps.Size());
        System.assertequals(1000000.00, rentAmortSteps[0].Balance__c);
        System.assertequals('2018-10-22', rentAmortSteps[0].Amort_Date__c);
        System.assertequals(1000000.00, rentAmortSteps[0].Funding__c);
        System.assertequals(null, rentAmortSteps[0].Interest__c);
        System.assertequals(null, rentAmortSteps[0].Payment__c);
        System.assertequals(null, rentAmortSteps[0].Principal__c);
        System.assertequals(984558.68088694, rentAmortSteps[1].Balance__c.setscale(8));
        System.assertequals('2018-11-22', rentAmortSteps[1].Amort_Date__c);
        System.assertequals(null, rentAmortSteps[1].Funding__c);
        System.assertequals(2558.68088694, rentAmortSteps[1].Interest__c.setscale(8));
        System.assertequals(18000.00, rentAmortSteps[1].Payment__c);
        System.assertequals(15441.31911306, rentAmortSteps[1].Principal__c.setscale(8));
    }
    
    private static void TestTVSchedDB2(String pobjId)
    {
        List<ST_PQ_TV_Schedule_Step__c> TVSteps = [Select Quote__c, TV_Date__c, Number_of_Payments_Scheduled__c, Termination_Value_Percent__c, Termination_Value_Amount__c, Advance_Rent__c, Arrears_Rent__c, Advance_Debt_Service__c, Arrears_Debt_Service__c, Total_Due_On_Termination__c From ST_PQ_TV_Schedule_Step__c Where Quote__c = :pobjId];
        System.assertequals(2, TVSteps.Size());
        System.assertequals('2018-10-23', TVSteps[0].TV_Date__c);
        System.assertequals(0, TVSteps[0].Number_of_Payments_Scheduled__c);
        System.assertequals(100.00, TVSteps[0].Termination_Value_Percent__c);
        System.assertequals(1000000.00, TVSteps[0].Termination_Value_Amount__c);
        System.assertequals(0, TVSteps[0].Advance_Rent__c);
        System.assertequals(0, TVSteps[0].Arrears_Rent__c);
        System.assertequals(0, TVSteps[0].Advance_Debt_Service__c);
        System.assertequals(0, TVSteps[0].Arrears_Debt_Service__c);
        System.assertequals(1000000.00, TVSteps[0].Total_Due_On_Termination__c);
        System.assertequals('2018-11-23', TVSteps[1].TV_Date__c);
        System.assertequals(1, TVSteps[1].Number_of_Payments_Scheduled__c);
        System.assertequals(95.000034, TVSteps[1].Termination_Value_Percent__c);
        System.assertequals(950000.34, TVSteps[1].Termination_Value_Amount__c);
        System.assertequals(10000.22, TVSteps[1].Advance_Rent__c);
        System.assertequals(9000.01, TVSteps[1].Arrears_Rent__c);
        System.assertequals(11000.99, TVSteps[1].Advance_Debt_Service__c);
        System.assertequals(8000.07, TVSteps[1].Arrears_Debt_Service__c);
        System.assertequals(968001.54, TVSteps[1].Total_Due_On_Termination__c);
    }
   
    private static void TestCashflowDB2(String pobjId)
    {
        IST__SuperTRUMP_PQ_Rent__c rent = [Select Id From IST__SuperTRUMP_PQ_Rent__c Where IST__Pricing_Quote__c = :pobjId Limit 1];
        List<ST_PQ_Rent_Cash_Flow_Step__c> rentCashflows = [Select Rent__c, Type__c, Num_Pmts__c, Amount__c, Rate__c, Period__c, Start_Accrual__c, End_Accrual__c, Timing__c From ST_PQ_Rent_Cash_Flow_Step__c Where Rent__c = :rent.Id];
        System.assertequals(2, rentCashFlows.Size());
        System.assertequals('Funding', rentCashflows[0].Type__c);
        System.assertequals(null, rentCashflows[0].Num_Pmts__c);
        System.assertequals(-1000000.00, rentCashflows[0].Amount__c);
        System.assertequals(null, rentCashflows[0].Rate__c);
        System.assertequals(null, rentCashflows[0].Period__c);
        System.assertequals(null, rentCashflows[0].Timing__c);
        System.assertequals(null, rentCashflows[0].Start_Accrual__c);
        System.assertequals('2018-10-22', rentCashflows[0].End_Accrual__c);
        System.assertequals('Payment', rentCashflows[1].Type__c);
        System.assertequals(60, rentCashflows[1].Num_Pmts__c);
        System.assertequals(18000.00, rentCashflows[1].Amount__c);
        System.assertequals(3.070417, rentCashflows[1].Rate__c.setscale(6));
        System.assertequals('Monthly', rentCashflows[1].Period__c);
        System.assertequals('Arrears', rentCashflows[1].Timing__c);
        System.assertequals('2018-10-22', rentCashflows[1].Start_Accrual__c);
        System.assertequals('2023-10-22', rentCashflows[1].End_Accrual__c);

        List<ST_PQ_Periodic_Income__c> perincs = [Select Id From ST_PQ_Periodic_Income__c Where Pricing_Quote__c = :pobjId];
        System.assertequals(2, perincs.Size());
        List<ST_PQ_Periodic_Income_Cash_Flow_Step__c> perincCashflows = [Select Periodic_Income__c, Type__c, Num_Pmts__c, Amount__c, Rate__c, Period__c, Start_Accrual__c, End_Accrual__c, Timing__c From ST_PQ_Periodic_Income_Cash_Flow_Step__c Where Periodic_Income__c = :perincs[0].Id];
        System.assertequals(2, perincCashflows .Size());
        System.assertequals('Funding', perincCashflows[0].Type__c);
        System.assertequals(null, perincCashflows[0].Num_Pmts__c);
        System.assertequals(-3000.00, perincCashflows[0].Amount__c);
        System.assertequals(null, perincCashflows[0].Rate__c);
        System.assertequals(null, perincCashflows[0].Period__c);
        System.assertequals(null, perincCashflows[0].Timing__c);
        System.assertequals(null, perincCashflows[0].Start_Accrual__c);
        System.assertequals('2018-10-22', perincCashflows[0].End_Accrual__c);
        System.assertequals('Payment', perincCashflows[1].Type__c);
        System.assertequals(60, perincCashflows[1].Num_Pmts__c);
        System.assertequals(50.00, perincCashflows[1].Amount__c);
        System.assertequals(0.000000, perincCashflows[1].Rate__c.setscale(6));
        System.assertequals('Monthly', perincCashflows[1].Period__c);
        System.assertequals('Arrears', perincCashflows[1].Timing__c);
        System.assertequals('2018-10-22', perincCashflows[1].Start_Accrual__c);
        System.assertequals('2023-10-22', perincCashflows[1].End_Accrual__c);

        perincCashflows = [Select Periodic_Income__c, Type__c, Num_Pmts__c, Amount__c, Rate__c, Period__c, Start_Accrual__c, End_Accrual__c, Timing__c From ST_PQ_Periodic_Income_Cash_Flow_Step__c Where Periodic_Income__c = :perincs[1].Id];
        System.assertequals(2, perincCashflows .Size());
        System.assertequals('Funding', perincCashflows[0].Type__c);
        System.assertequals(null, perincCashflows[0].Num_Pmts__c);
        System.assertequals(-2700.00, perincCashflows[0].Amount__c);
        System.assertequals(null, perincCashflows[0].Rate__c);
        System.assertequals(null, perincCashflows[0].Period__c);
        System.assertequals(null, perincCashflows[0].Timing__c);
        System.assertequals(null, perincCashflows[0].Start_Accrual__c);
        System.assertequals('2018-10-22', perincCashflows[0].End_Accrual__c);
        System.assertequals('Payment', perincCashflows[1].Type__c);
        System.assertequals(60, perincCashflows[1].Num_Pmts__c);
        System.assertequals(45.00, perincCashflows[1].Amount__c);
        System.assertequals(0.000000, perincCashflows[1].Rate__c.setscale(6));
        System.assertequals('Monthly', perincCashflows[1].Period__c);
        System.assertequals('Arrears', perincCashflows[1].Timing__c);
        System.assertequals('2018-10-22', perincCashflows[1].Start_Accrual__c);
        System.assertequals('2023-10-22', perincCashflows[1].End_Accrual__c);
        
        List<ST_PQ_Periodic_Expense__c> perexps = [Select Id From ST_PQ_Periodic_Expense__c Where Pricing_Quote__c = :pobjId];
        System.assertequals(1, perexps.Size());
        List<ST_PQ_Periodic_Expense_Cash_Flow_Step__c> perexpCashflows = [Select Periodic_Expense__c, Type__c, Num_Pmts__c, Amount__c, Rate__c, Period__c, Start_Accrual__c, End_Accrual__c, Timing__c From ST_PQ_Periodic_Expense_Cash_Flow_Step__c Where Periodic_Expense__c = :perexps[0].Id];
        System.assertequals(2, perexpCashflows.Size());
        System.assertequals('Funding', perexpCashflows[0].Type__c);
        System.assertequals(null, perexpCashflows[0].Num_Pmts__c);
        System.assertequals(-500.00, perexpCashflows[0].Amount__c);
        System.assertequals(null, perexpCashflows[0].Rate__c);
        System.assertequals(null, perexpCashflows[0].Period__c);
        System.assertequals(null, perexpCashflows[0].Timing__c);
        System.assertequals(null, perexpCashflows[0].Start_Accrual__c);
        System.assertequals('2018-10-22', perexpCashflows[0].End_Accrual__c);
        System.assertequals('Payment', perexpCashflows[1].Type__c);
        System.assertequals(5, perexpCashflows[1].Num_Pmts__c);
        System.assertequals(100.00, perexpCashflows[1].Amount__c);
        System.assertequals(0.000000, perexpCashflows[1].Rate__c.setscale(6));
        System.assertequals('Annual', perexpCashflows[1].Period__c);
        System.assertequals('Arrears', perexpCashflows[1].Timing__c);
        System.assertequals('2018-10-22', perexpCashflows[1].Start_Accrual__c);
        System.assertequals('2023-10-22', perexpCashflows[1].End_Accrual__c);
    }

    private static void TestLoanCashflowDB1(String pobjId)
    {
        List<IST__SuperTRUMP_PQ_Loan__c> loans = [Select Id From IST__SuperTRUMP_PQ_Loan__c Where IST__Pricing_Quote__c = :pobjId];
        System.assertequals(2, loans.Size());
       
        List<ST_PQ_Loan_Cash_Flow_Step__c> loanCashflows = [Select Loan__c, Type__c, Num_Pmts__c, Amount__c, Rate__c, Period__c, Start_Accrual__c, End_Accrual__c, Timing__c From ST_PQ_Loan_Cash_Flow_Step__c Where Loan__c = :loans[0].Id];
        System.assertequals(2, loanCashflows.Size());
        System.assertequals('Funding', loanCashflows[0].Type__c);
        System.assertequals(-1000000.00, loanCashflows[0].Amount__c);
        System.assertequals('Payment', loanCashflows[1].Type__c);
        System.assertequals(19332.80, loanCashflows[1].Amount__c.setscale(2));
        
        loanCashflows = [Select Loan__c, Type__c, Num_Pmts__c, Amount__c, Rate__c, Period__c, Start_Accrual__c, End_Accrual__c, Timing__c From ST_PQ_Loan_Cash_Flow_Step__c Where Loan__c = :loans[1].Id];
        System.assertequals(2, loanCashflows.Size());
        System.assertequals('Funding', loanCashflows[0].Type__c);
        System.assertequals(-2000000.00, loanCashflows[0].Amount__c);
        System.assertequals('Payment', loanCashflows[1].Type__c);
        System.assertequals(38665.60, loanCashflows[1].Amount__c.setscale(2));
    }
    
    private static void TestLoanCashflowDB2(String pobjId)
    {
        List<IST__SuperTRUMP_PQ_Loan__c> loans = [Select Id From IST__SuperTRUMP_PQ_Loan__c Where IST__Pricing_Quote__c = :pobjId];
        System.assertequals(1, loans.Size());
        
        List<ST_PQ_Loan_Cash_Flow_Step__c> loanCashflows = [Select Loan__c, Type__c, Num_Pmts__c, Amount__c, Rate__c, Period__c, Start_Accrual__c, End_Accrual__c, Timing__c From ST_PQ_Loan_Cash_Flow_Step__c Where Loan__c = :loans[0].Id];
        System.assertequals(3, loanCashflows.Size());
        System.assertequals('Funding', loanCashflows[0].Type__c);
        System.assertequals(-500000.00, loanCashflows[0].Amount__c);
        System.assertequals('Payment', loanCashflows[1].Type__c);
        System.assertequals(9346.22, loanCashflows[1].Amount__c.setscale(2));
        System.assertequals('Payment', loanCashflows[2].Type__c);
        System.assertequals(10038.26, loanCashflows[2].Amount__c.setscale(2));
    }
    
   
    private static string getXmlOut()
    {
        return
'<Response>' +
'<Result>success</Result>' +
'<Message/>' +
'<SuperTRUMP>' +
'<Transaction>' +
'<Rents count="1">' +
'<Rent index="0">' +
'<PID>104</PID>' +
'<CashflowSteps count="2">' +
'<CashflowStep index="0">' +
'<EndAccrual>2018-08-14</EndAccrual>' +
'<FirstPaymentDate>2018-08-14</FirstPaymentDate>' +
'<Type>Funding</Type>' +
'<Amount>-1000000</Amount>' +
'<Balance>1000000</Balance>' +
'</CashflowStep>' +
'<CashflowStep index="1">' +
'<NumberOfPayments>60</NumberOfPayments>' +
'<DaysInPeriod>30</DaysInPeriod>' +
'<Periodicity>Monthly</Periodicity>' +
'<StartAccrual>2018-08-14</StartAccrual>' +
'<EndAccrual>2023-08-14</EndAccrual>' +
'<FirstPaymentDate>2018-09-14</FirstPaymentDate>' +
'<Type>Payment</Type>' +
'<IsStub>false</IsStub>' +
'<IsAdvance>false</IsAdvance>' +
'<Rate>0.0307041706433</Rate>' +
'<Amount>18000</Amount>' +
'<AmountLocked>false</AmountLocked>' +
'<RateLocked>false</RateLocked>' +
'<Balance>0.0000067336659412831</Balance>' +
'<PaymentTiming>Arrears</PaymentTiming>' +
'<LeaseRateFactor>0.018</LeaseRateFactor>' +
'</CashflowStep>' +
'</CashflowSteps>' +
'<AmortSchedule>' +
'<Cashflow date="2018-08-14">' +
'<Funding>1000000</Funding>' +
'<Balance>1000000</Balance>' +
'</Cashflow>' +
'<Cashflow date="2018-09-14">' +
'<Payment>18000</Payment>' +
'<Interest>2558.68088694167</Interest>' +
'<Principal>15441.3191130583</Principal>' +
'<Balance>984558.68088694</Balance>' +
'</Cashflow>' +
'<Cashflow date="2018-10-14">' +
'<Payment>18000</Payment>' +
'<Interest>2519.17147885792</Interest>' +
'<Principal>15480.8285211421</Principal>' +
'<Balance>969077.8523658</Balance>' +
'</Cashflow>' +
'<Cashflow date="2018-11-14">' +
'<Payment>18000</Payment>' +
'<Interest>2479.56097880685</Interest>' +
'<Principal>15520.4390211932</Principal>' +
'<Balance>953557.41334461</Balance>' +
'</Cashflow>' +
'</AmortSchedule>' +
'</Rent>' +
'</Rents>' +
'<PeriodicIncomes count="2">' +
'<PeriodicIncome index="0">' +
'<PID>105</PID>' +
'<CashflowSteps count="2">' +
'<CashflowStep index="0">' +
'<EndAccrual>2018-08-14</EndAccrual>' +
'<FirstPaymentDate>2018-08-14</FirstPaymentDate>' +
'<Type>Funding</Type>' +
'<Amount>-3000</Amount>' +
'<Balance>3000</Balance>' +
'</CashflowStep>' +
'<CashflowStep index="1">' +
'<NumberOfPayments>60</NumberOfPayments>' +
'<DaysInPeriod>30</DaysInPeriod>' +
'<Periodicity>Monthly</Periodicity>' +
'<StartAccrual>2018-08-14</StartAccrual>' +
'<EndAccrual>2023-08-14</EndAccrual>' +
'<FirstPaymentDate>2018-09-14</FirstPaymentDate>' +
'<Type>Payment</Type>' +
'<IsStub>false</IsStub>' +
'<IsAdvance>false</IsAdvance>' +
'<Rate>0</Rate>' +
'<Amount>50</Amount>' +
'<AmountLocked>false</AmountLocked>' +
'<RateLocked>false</RateLocked>' +
'<Balance>0</Balance>' +
'<PaymentTiming>Arrears</PaymentTiming>' +
'<LeaseRateFactor>0.016666666666667</LeaseRateFactor>' +
'</CashflowStep>' +
'</CashflowSteps>' +
'</PeriodicIncome>' +
'<PeriodicIncome index="1">' +
'<PID>106</PID>' +
'<CashflowSteps count="2">' +
'<CashflowStep index="0">' +
'<EndAccrual>2018-08-14</EndAccrual>' +
'<FirstPaymentDate>2018-08-14</FirstPaymentDate>' +
'<Type>Funding</Type>' +
'<Amount>-2700</Amount>' +
'<Balance>2700</Balance>' +
'</CashflowStep>' +
'<CashflowStep index="1">' +
'<NumberOfPayments>60</NumberOfPayments>' +
'<DaysInPeriod>30</DaysInPeriod>' +
'<Periodicity>Monthly</Periodicity>' +
'<StartAccrual>2018-08-14</StartAccrual>' +
'<EndAccrual>2023-08-14</EndAccrual>' +
'<FirstPaymentDate>2018-09-14</FirstPaymentDate>' +
'<Type>Payment</Type>' +
'<IsStub>false</IsStub>' +
'<IsAdvance>false</IsAdvance>' +
'<Rate>0</Rate>' +
'<Amount>45</Amount>' +
'<AmountLocked>false</AmountLocked>' +
'<RateLocked>false</RateLocked>' +
'<Balance>0.00000000000045474735088646</Balance>' +
'<PaymentTiming>Arrears</PaymentTiming>' +
'<LeaseRateFactor>0.016666666666667</LeaseRateFactor>' +
'</CashflowStep>' +
'</CashflowSteps>' +
'</PeriodicIncome>' +
'</PeriodicIncomes>' +
'<PeriodicExpenses count="1">' +
'<PeriodicExpense index="0">' +
'<PID>107</PID>' +
'<CashflowSteps count="2">' +
'<CashflowStep index="0">' +
'<EndAccrual>2018-08-14</EndAccrual>' +
'<FirstPaymentDate>2018-08-14</FirstPaymentDate>' +
'<Type>Funding</Type>' +
'<Amount>-500</Amount>' +
'<Balance>500</Balance>' +
'</CashflowStep>' +
'<CashflowStep index="1">' +
'<NumberOfPayments>5</NumberOfPayments>' +
'<DaysInPeriod>360</DaysInPeriod>' +
'<Periodicity>Annual</Periodicity>' +
'<StartAccrual>2018-08-14</StartAccrual>' +
'<EndAccrual>2023-08-14</EndAccrual>' +
'<FirstPaymentDate>2019-08-14</FirstPaymentDate>' +
'<Type>Payment</Type>' +
'<IsStub>false</IsStub>' +
'<IsAdvance>false</IsAdvance>' +
'<Rate>0</Rate>' +
'<Amount>100</Amount>' +
'<AmountLocked>false</AmountLocked>' +
'<RateLocked>false</RateLocked>' +
'<Balance>0</Balance>' +
'<PaymentTiming>Arrears</PaymentTiming>' +
'<LeaseRateFactor>0.2</LeaseRateFactor>' +
'</CashflowStep>' +
'</CashflowSteps>' +
'</PeriodicExpense>' +
'</PeriodicExpenses>' +
'<PrintReportInfo>' +
'<ReportXml>' +
'<Report index="0">' +
'<Header>' +
'<Description>Schedule, with percent of TV</Description>' +
'<Title1>Termination Value</Title1>' +
'<Title2>Schedule</Title2>' +
'<PreparedDate>2018-10-25</PreparedDate>' +
'<Periodicity>Monthly</Periodicity>' +
'</Header>' +
'<Row>' +
'<Date>2018-10-22</Date>' +
'<NumberOfPaymentsScheduled>0</NumberOfPaymentsScheduled>' +
'<TerminationValuePercent>100</TerminationValuePercent>' +
'<TerminationValue>2000000</TerminationValue>' +
'<ArrearsRent>0</ArrearsRent>' +
'<AdvanceRent>0</AdvanceRent>' +
'<ArrearsDebtService>0</ArrearsDebtService>' +
'<AdvanceDebtService>0</AdvanceDebtService>' +
'<TotalDueOnTermination>2000000</TotalDueOnTermination>' +
'</Row>' +
'<Row>' +
'<Date>2018-11-22</Date>' +
'<NumberOfPaymentsScheduled>1</NumberOfPaymentsScheduled>' +
'<TerminationValuePercent>95.000034</TerminationValuePercent>' +
'<TerminationValue>1900000.68</TerminationValue>' +
'<ArrearsRent>18000.01</ArrearsRent>' +
'<AdvanceRent>19000.22</AdvanceRent>' +
'<ArrearsDebtService>18100.03</ArrearsDebtService>' +
'<AdvanceDebtService>19288.04</AdvanceDebtService>' +
'<TotalDueOnTermination>1968001.54</TotalDueOnTermination>' +
'</Row>' +
'<Row>' +
'<Date>2018-12-22</Date>' +
'<NumberOfPaymentsScheduled>2</NumberOfPaymentsScheduled>' +
'<TerminationValuePercent>93.000000</TerminationValuePercent>' +
'<TerminationValue>1860000.00</TerminationValue>' +
'<ArrearsRent>36000.01</ArrearsRent>' +
'<TotalDueOnTermination>1868001.54</TotalDueOnTermination>' +
'</Row>' +
'</Report>' +
'</ReportXml>' +
'</PrintReportInfo>' +
'</Transaction>' +
'</SuperTRUMP>' +
'</Response>';
    }
   
    private static string getXmlOut2()
    {
        return
'<Response>' +
'<Result>success</Result>' +
'<Message/>' +
'<SuperTRUMP>' +
'<Transaction>' +
'<Rents count="1">' +
'<Rent index="0">' +
'<PID>104</PID>' +
'<CashflowSteps count="2">' +
'<CashflowStep index="0">' +
'<EndAccrual>2018-10-22</EndAccrual>' +
'<FirstPaymentDate>2018-10-22</FirstPaymentDate>' +
'<Type>Funding</Type>' +
'<Amount>-1000000</Amount>' +
'<Balance>1000000</Balance>' +
'</CashflowStep>' +
'<CashflowStep index="1">' +
'<NumberOfPayments>60</NumberOfPayments>' +
'<DaysInPeriod>30</DaysInPeriod>' +
'<Periodicity>Monthly</Periodicity>' +
'<StartAccrual>2018-10-22</StartAccrual>' +
'<EndAccrual>2023-10-22</EndAccrual>' +
'<FirstPaymentDate>2018-11-22</FirstPaymentDate>' +
'<Type>Payment</Type>' +
'<IsStub>false</IsStub>' +
'<IsAdvance>false</IsAdvance>' +
'<Rate>0.0307041706433</Rate>' +
'<Amount>18000</Amount>' +
'<AmountLocked>false</AmountLocked>' +
'<RateLocked>false</RateLocked>' +
'<Balance>0.0000067336659412831</Balance>' +
'<PaymentTiming>Arrears</PaymentTiming>' +
'<LeaseRateFactor>0.018</LeaseRateFactor>' +
'</CashflowStep>' +
'</CashflowSteps>' +
'<AmortSchedule>' +
'<Cashflow date="2018-10-22">' +
'<Funding>1000000</Funding>' +
'<Balance>1000000</Balance>' +
'</Cashflow>' +
'<Cashflow date="2018-11-22">' +
'<Payment>18000</Payment>' +
'<Interest>2558.68088694167</Interest>' +
'<Principal>15441.3191130583</Principal>' +
'<Balance>984558.68088694</Balance>' +
'</Cashflow>' +
'<Cashflow date="2018-12-22">' +
'<Payment>18000</Payment>' +
'<Interest>2519.17147885792</Interest>' +
'<Principal>15480.8285211421</Principal>' +
'<Balance>969077.8523658</Balance>' +
'</Cashflow>' +
'<Cashflow date="2019-01-22">' +
'<Payment>18000</Payment>' +
'<Interest>2479.56097880685</Interest>' +
'<Principal>15520.4390211932</Principal>' +
'<Balance>953557.41334461</Balance>' +
'</Cashflow>' +
'</AmortSchedule>' +
'</Rent>' +
'</Rents>' +
'<PeriodicIncomes count="2">' +
'<PeriodicIncome index="0">' +
'<PID>105</PID>' +
'<CashflowSteps count="2">' +
'<CashflowStep index="0">' +
'<EndAccrual>2018-10-22</EndAccrual>' +
'<FirstPaymentDate>2018-10-22</FirstPaymentDate>' +
'<Type>Funding</Type>' +
'<Amount>-3000</Amount>' +
'<Balance>3000</Balance>' +
'</CashflowStep>' +
'<CashflowStep index="1">' +
'<NumberOfPayments>60</NumberOfPayments>' +
'<DaysInPeriod>30</DaysInPeriod>' +
'<Periodicity>Monthly</Periodicity>' +
'<StartAccrual>2018-10-22</StartAccrual>' +
'<EndAccrual>2023-10-22</EndAccrual>' +
'<FirstPaymentDate>2018-11-22</FirstPaymentDate>' +
'<Type>Payment</Type>' +
'<IsStub>false</IsStub>' +
'<IsAdvance>false</IsAdvance>' +
'<Rate>0</Rate>' +
'<Amount>50</Amount>' +
'<AmountLocked>false</AmountLocked>' +
'<RateLocked>false</RateLocked>' +
'<Balance>0</Balance>' +
'<PaymentTiming>Arrears</PaymentTiming>' +
'<LeaseRateFactor>0.016666666666667</LeaseRateFactor>' +
'</CashflowStep>' +
'</CashflowSteps>' +
'</PeriodicIncome>' +
'<PeriodicIncome index="1">' +
'<PID>106</PID>' +
'<CashflowSteps count="2">' +
'<CashflowStep index="0">' +
'<EndAccrual>2018-10-22</EndAccrual>' +
'<FirstPaymentDate>2018-10-22</FirstPaymentDate>' +
'<Type>Funding</Type>' +
'<Amount>-2700</Amount>' +
'<Balance>2700</Balance>' +
'</CashflowStep>' +
'<CashflowStep index="1">' +
'<NumberOfPayments>60</NumberOfPayments>' +
'<DaysInPeriod>30</DaysInPeriod>' +
'<Periodicity>Monthly</Periodicity>' +
'<StartAccrual>2018-10-22</StartAccrual>' +
'<EndAccrual>2023-10-22</EndAccrual>' +
'<FirstPaymentDate>2018-11-22</FirstPaymentDate>' +
'<Type>Payment</Type>' +
'<IsStub>false</IsStub>' +
'<IsAdvance>false</IsAdvance>' +
'<Rate>0</Rate>' +
'<Amount>45</Amount>' +
'<AmountLocked>false</AmountLocked>' +
'<RateLocked>false</RateLocked>' +
'<Balance>0.00000000000045474735088646</Balance>' +
'<PaymentTiming>Arrears</PaymentTiming>' +
'<LeaseRateFactor>0.016666666666667</LeaseRateFactor>' +
'</CashflowStep>' +
'</CashflowSteps>' +
'</PeriodicIncome>' +
'</PeriodicIncomes>' +
'<PeriodicExpenses count="1">' +
'<PeriodicExpense index="0">' +
'<PID>107</PID>' +
'<CashflowSteps count="2">' +
'<CashflowStep index="0">' +
'<EndAccrual>2018-10-22</EndAccrual>' +
'<FirstPaymentDate>2018-10-22</FirstPaymentDate>' +
'<Type>Funding</Type>' +
'<Amount>-500</Amount>' +
'<Balance>500</Balance>' +
'</CashflowStep>' +
'<CashflowStep index="1">' +
'<NumberOfPayments>5</NumberOfPayments>' +
'<DaysInPeriod>360</DaysInPeriod>' +
'<Periodicity>Annual</Periodicity>' +
'<StartAccrual>2018-10-22</StartAccrual>' +
'<EndAccrual>2023-10-22</EndAccrual>' +
'<FirstPaymentDate>2019-10-22</FirstPaymentDate>' +
'<Type>Payment</Type>' +
'<IsStub>false</IsStub>' +
'<IsAdvance>false</IsAdvance>' +
'<Rate>0</Rate>' +
'<Amount>100</Amount>' +
'<AmountLocked>false</AmountLocked>' +
'<RateLocked>false</RateLocked>' +
'<Balance>0</Balance>' +
'<PaymentTiming>Arrears</PaymentTiming>' +
'<LeaseRateFactor>0.2</LeaseRateFactor>' +
'</CashflowStep>' +
'</CashflowSteps>' +
'</PeriodicExpense>' +
'</PeriodicExpenses>' +
'<PrintReportInfo>' +
'<ReportXml>' +
'<Report index="0">' +
'<Header>' +
'<Description>Schedule, with percent of TV</Description>' +
'<Title1>Termination Value</Title1>' +
'<Title2>Schedule</Title2>' +
'<PreparedDate>2018-10-25</PreparedDate>' +
'<Periodicity>Monthly</Periodicity>' +
'</Header>' +
'<Row>' +
'<Date>2018-10-23</Date>' +
'<NumberOfPaymentsScheduled>0</NumberOfPaymentsScheduled>' +
'<TerminationValuePercent>100</TerminationValuePercent>' +
'<TerminationValue>1000000</TerminationValue>' +
'<ArrearsRent>0</ArrearsRent>' +
'<AdvanceRent>0</AdvanceRent>' +
'<ArrearsDebtService>0</ArrearsDebtService>' +
'<AdvanceDebtService>0</AdvanceDebtService>' +
'<TotalDueOnTermination>1000000</TotalDueOnTermination>' +
'</Row>' +
'<Row>' +
'<Date>2018-11-23</Date>' +
'<NumberOfPaymentsScheduled>1</NumberOfPaymentsScheduled>' +
'<TerminationValuePercent>95.000034</TerminationValuePercent>' +
'<TerminationValue>950000.34</TerminationValue>' +
'<ArrearsRent>9000.01</ArrearsRent>' +
'<AdvanceRent>10000.22</AdvanceRent>' +
'<ArrearsDebtService>8000.07</ArrearsDebtService>' +
'<AdvanceDebtService>11000.99</AdvanceDebtService>' +
'<TotalDueOnTermination>968001.54</TotalDueOnTermination>' +
'</Row>' +
'</Report>' +
'</ReportXml>' +
'</PrintReportInfo>' +
'</Transaction>' +
'</SuperTRUMP>' +
'</Response>';
    }

    private static string getLoanXmlOut1()
    {
        return
'<Response>' +
'<Result>success</Result>' +
'<Message/>' +
'<SuperTRUMP>' +
'<Transaction>' +
'<LendingLoans count="2">' +
'<LendingLoan index="0">' +
'<PID>108</PID>' +
'<CashflowSteps count="2">' +
'<CashflowStep index="0">' +
'<EndAccrual>2018-08-15</EndAccrual>' +
'<FirstPaymentDate>2018-08-15</FirstPaymentDate>' +
'<Type>Funding</Type>' +
'<Amount>-1000000</Amount>' +
'<AmountLocked>false</AmountLocked>' +
'<Balance>1000000</Balance>' +
'</CashflowStep>' +
'<CashflowStep index="1">' +
'<NumberOfPayments>60</NumberOfPayments>' +
'<DaysInPeriod>30</DaysInPeriod>' +
'<Periodicity>Monthly</Periodicity>' +
'<StartAccrual>2018-08-15</StartAccrual>' +
'<EndAccrual>2023-08-15</EndAccrual>' +
'<FirstPaymentDate>2018-09-15</FirstPaymentDate>' +
'<Type>Payment</Type>' +
'<IsStub>false</IsStub>' +
'<IsAdvance>false</IsAdvance>' +
'<Rate>0.06</Rate>' +
'<Amount>19332.8015294279</Amount>' +
'<AmountLocked>false</AmountLocked>' +
'<RateLocked>false</RateLocked>' +
'<Balance>0.000000000065483618527651</Balance>' +
'<PaymentTiming>Arrears</PaymentTiming>' +
'<LeaseRateFactor>0.019332801529428</LeaseRateFactor>' +
'</CashflowStep>' +
'</CashflowSteps>' +
'<AmortSchedule>' +
'<Cashflow date="2018-08-15">' +
'<Funding>1000000</Funding>' +
'<Balance>1000000</Balance>' +
'</Cashflow>' +
'<Cashflow date="2018-09-15">' +
'<Payment>19332.8015294279</Payment>' +
'<Interest>5000</Interest>' +
'<Principal>14332.8015294279</Principal>' +
'<Balance>985667.19847057</Balance>' +
'</Cashflow>' +
'<Cashflow date="2018-10-15">' +
'<Payment>19332.8015294279</Payment>' +
'<Interest>4928.33599235286</Interest>' +
'<Principal>14404.4655370751</Principal>' +
'<Balance>971262.7329335</Balance>' +
'</Cashflow>' +
'<Cashflow date="2018-11-15">' +
'<Payment>19332.8015294279</Payment>' +
'<Interest>4856.31366466748</Interest>' +
'<Principal>14476.4878647604</Principal>' +
'<Balance>956786.24506874</Balance>' +
'</Cashflow>' +
'</AmortSchedule>' +
'</LendingLoan>' +
'<LendingLoan index="1">' +
'<PID>109</PID>' +
'<CashflowSteps count="2">' +
'<CashflowStep index="0">' +
'<EndAccrual>2018-08-15</EndAccrual>' +
'<FirstPaymentDate>2018-08-15</FirstPaymentDate>' +
'<Type>Funding</Type>' +
'<Amount>-2000000</Amount>' +
'<AmountLocked>false</AmountLocked>' +
'<Balance>2000000</Balance>' +
'</CashflowStep>' +
'<CashflowStep index="1">' +
'<NumberOfPayments>60</NumberOfPayments>' +
'<DaysInPeriod>30</DaysInPeriod>' +
'<Periodicity>Monthly</Periodicity>' +
'<StartAccrual>2018-08-15</StartAccrual>' +
'<EndAccrual>2023-08-15</EndAccrual>' +
'<FirstPaymentDate>2018-09-15</FirstPaymentDate>' +
'<Type>Payment</Type>' +
'<IsStub>false</IsStub>' +
'<IsAdvance>false</IsAdvance>' +
'<Rate>0.06</Rate>' +
'<Amount>38665.6030588558</Amount>' +
'<AmountLocked>false</AmountLocked>' +
'<RateLocked>false</RateLocked>' +
'<Balance>0.00000000087311491370201</Balance>' +
'<PaymentTiming>Arrears</PaymentTiming>' +
'<LeaseRateFactor>0.019332801529428</LeaseRateFactor>' +
'</CashflowStep>' +
'</CashflowSteps>' +
'<AmortSchedule>' +
'<Cashflow date="2018-08-15">' +
'<Funding>2000000</Funding>' +
'<Balance>2000000</Balance>' +
'</Cashflow>' +
'<Cashflow date="2018-09-15">' +
'<Payment>38665.6030588558</Payment>' +
'<Interest>10000</Interest>' +
'<Principal>28665.6030588558</Principal>' +
'<Balance>1971334.39694114</Balance>' +
'</Cashflow>' +
'<Cashflow date="2018-10-15">' +
'<Payment>38665.6030588558</Payment>' +
'<Interest>9856.6719847057</Interest>' +
'<Principal>28808.9310741501</Principal>' +
'<Balance>1942525.46586699</Balance>' +
'</Cashflow>' +
'<Cashflow date="2018-11-15">' +
'<Payment>38665.6030588558</Payment>' +
'<Interest>9712.62732933497</Interest>' +
'<Principal>28952.9757295209</Principal>' +
'<Balance>1913572.49013747</Balance>' +
'</Cashflow>' +
'</AmortSchedule>' +
'</LendingLoan>' +
'</LendingLoans>' +
'</Transaction>' +
'</SuperTRUMP>' +
'</Response>';
    }
    
    
    private static string getLoanXmlOut2()
    {
        return
'<Response>' +
'<Result>success</Result>' +
'<Message/>' +
'<SuperTRUMP>' +
'<Transaction>' +
'<LendingLoans count="2">' +
'<LendingLoan index="0">' +
'<PID>108</PID>' +
'<CashflowSteps count="3">' +
'<CashflowStep index="0">' +
'<EndAccrual>2018-08-15</EndAccrual>' +
'<FirstPaymentDate>2018-08-15</FirstPaymentDate>' +
'<Type>Funding</Type>' +
'<Amount>-500000</Amount>' +
'<AmountLocked>false</AmountLocked>' +
'<Balance>500000</Balance>' +
'</CashflowStep>' +
'<CashflowStep index="1">' +
'<NumberOfPayments>30</NumberOfPayments>' +
'<DaysInPeriod>30</DaysInPeriod>' +
'<Periodicity>Monthly</Periodicity>' +
'<StartAccrual>2018-08-15</StartAccrual>' +
'<EndAccrual>2021-02-15</EndAccrual>' +
'<FirstPaymentDate>2018-09-15</FirstPaymentDate>' +
'<Type>Payment</Type>' +
'<IsStub>false</IsStub>' +
'<IsAdvance>false</IsAdvance>' +
'<Rate>0.06</Rate>' +
'<Amount>9346.22101532689</Amount>' +
'<AmountLocked>false</AmountLocked>' +
'<RateLocked>false</RateLocked>' +
'<Balance>279003.872121276</Balance>' +
'<PaymentTiming>Arrears</PaymentTiming>' +
'<LeaseRateFactor>0.018692442030654</LeaseRateFactor>' +
'</CashflowStep>' +
'<CashflowStep index="2">' +
'<NumberOfPayments>30</NumberOfPayments>' +
'<DaysInPeriod>30</DaysInPeriod>' +
'<Periodicity>Monthly</Periodicity>' +
'<StartAccrual>2021-02-15</StartAccrual>' +
'<EndAccrual>2023-08-15</EndAccrual>' +
'<FirstPaymentDate>2021-03-15</FirstPaymentDate>' +
'<Type>Payment</Type>' +
'<IsStub>false</IsStub>' +
'<IsAdvance>false</IsAdvance>' +
'<Rate>0.06</Rate>' +
'<Amount>10038.2575521935</Amount>' +
'<AmountLocked>false</AmountLocked>' +
'<RateLocked>false</RateLocked>' +
'<Balance>-0.00000000029285729397088</Balance>' +
'<PaymentTiming>Arrears</PaymentTiming>' +
'<LeaseRateFactor>0.020076515104387</LeaseRateFactor>' +
'</CashflowStep>' +
'</CashflowSteps>' +
'<AmortSchedule>' +
'<Cashflow date="2018-08-15">' +
'<Funding>500000</Funding>' +
'<Balance>500000</Balance>' +
'</Cashflow>' +
'<Cashflow date="2018-09-15">' +
'<Payment>9346.22101532689</Payment>' +
'<Interest>2500</Interest>' +
'<Principal>6846.22101532689</Principal>' +
'<Balance>493153.778984673</Balance>' +
'</Cashflow>' +
'<Cashflow date="2018-10-15">' +
'<Payment>9346.22101532689</Payment>' +
'<Interest>2465.76889492337</Interest>' +
'<Principal>6880.45212040353</Principal>' +
'<Balance>486273.32686427</Balance>' +
'</Cashflow>' +
'<Cashflow date="2018-11-15">' +
'<Payment>9346.22101532689</Payment>' +
'<Interest>2431.36663432135</Interest>' +
'<Principal>6914.85438100555</Principal>' +
'<Balance>479358.472483264</Balance>' +
'</Cashflow>' +
'<Cashflow date="2018-12-15">' +
'<Payment>9346.22101532689</Payment>' +
'<Interest>2396.79236241632</Interest>' +
'<Principal>6949.42865291057</Principal>' +
'<Balance>472409.043830353</Balance>' +
'</Cashflow>' +
'</AmortSchedule>' +
'</LendingLoan>' +
'</LendingLoans>' +
'</Transaction>' +
'</SuperTRUMP>' +
'</Response>';
    }
    
    private static string xmlInString =     
 '<SuperTRUMP LocalErrorReporting="true">' +
 '<Transaction>' +
   '<TransactionState></TransactionState>' +
   '<Rents>' +
     '<Rent index="*">' +
       '<UseFundingsAndRate>true</UseFundingsAndRate>' +
       '<BalanceRate></BalanceRate>' +
       '<PID query="true"></PID>' +
       '<CashflowSteps query="true"></CashflowSteps>' +
       '<AmortSchedule query="true"></AmortSchedule>' +
     '</Rent>' +
    '</Rents>' +
    '<LendingLoans>' +
      '<LendingLoan index="*">' +
        '<PID query="true"></PID>' +
        '<CashflowSteps query="true"></CashflowSteps>' +
        '<AmortSchedule query="true"></AmortSchedule>' +
      '</LendingLoan>' +
    '</LendingLoans>' +
    '<PeriodicIncomes>' +
      '<PeriodicIncome index="*">' +
        '<UseFundingsAndRate>true</UseFundingsAndRate>' +
        '<BalanceFunding></BalanceFunding>' +
        '<PID query="true"></PID>' +
        '<CashflowSteps query="true"></CashflowSteps>' +
      '</PeriodicIncome>' +
    '</PeriodicIncomes>' +
    '<PeriodicExpenses>' +
      '<PeriodicExpense index="*">' +
        '<UseFundingsAndRate>true</UseFundingsAndRate>' +
        '<BalanceFunding></BalanceFunding>' +
        '<PID query="true"></PID>' +
        '<CashflowSteps query="true"></CashflowSteps>' +
      '</PeriodicExpense>' +
    '</PeriodicExpenses>' +
    '<PrintReportInfo>' +
      '<ReportBlob></ReportBlob>' +
      '<Periodicity>Monthly</Periodicity>' +
      '<ReportXml query="true"></ReportXml>' +
    '</PrintReportInfo>' +
  '</Transaction>' +
  '</SuperTRUMP>';
  
    private static void TestXmlIn(string xmlIn)
    {
        System.assertequals(xmlIn, xmlInString);
    }

    private static void TestCustomSTObjs(Eng_STSFEnhancements.CustomSTObjects customSTObjs)
    {
        System.assertequals(2, customSTObjs.rentcashflows.Size());
        System.assertequals(4, customSTObjs.perinccashflows.Size());
        System.assertequals(2, customSTObjs.perexpcashflows.Size());
        System.assertequals(4, customSTObjs.rentamortschedule.Size());
             
        System.assertequals(104, customSTObjs.rentcashflows[0].PID);
        System.assertequals(1, customSTobjs.rentcashflows[0].Step);
        System.assertequals('Funding', customSTobjs.rentcashflows[0].Type);
        System.assertequals(-1000000.00, customSTObjs.rentcashflows[0].Amount);
        System.assertequals('2018-08-14', customSTObjs.rentcashflows[0].EndAccrual);
        System.assertequals(104, customSTObjs.rentcashflows[1].PID);
        System.assertequals(2, customSTobjs.rentcashflows[1].Step);
        System.assertequals('Payment', customSTobjs.rentcashflows[1].Type);
        System.assertequals(18000.00, customSTObjs.rentcashflows[1].Amount);
        System.assertequals('2023-08-14', customSTObjs.rentcashflows[1].EndAccrual);
        System.assertequals('Monthly', customSTObjs.rentcashflows[1].Period);
        System.assertequals('Arrears', customSTObjs.rentcashflows[1].Timing);
        
        integer PID;
        integer cntSteps = 0;
        List<integer> stepIndex = new List<integer>();
        for (integer i = 0; i < customSTObjs.perinccashflows.Size(); i++)
        {
            if (customSTObjs.perinccashflows[i].PID == 106)
            {
                stepIndex.Add(i);
                cntSteps++;
                PID = 106;
            }
        }
        System.assertequals(106, PID);
        System.assertequals(2, cntSteps);
        System.assertequals('Funding', customSTObjs.perinccashflows[stepIndex[0]].Type);
        System.assertequals(-2700.00, customSTObjs.perinccashflows[stepIndex[0]].Amount);
        System.assertequals(null, customSTObjs.perinccashflows[stepIndex[0]].NumPmts);
        System.assertequals('Payment', customSTObjs.perinccashflows[stepIndex[1]].Type);
        System.assertequals(45.00, customSTObjs.perinccashflows[stepIndex[1]].Amount);
        System.assertequals(60, customSTObjs.perinccashflows[stepIndex[1]].NumPmts);
            
        System.assertequals(3, customSTObjs.tvschedule.Size());
        System.assertequals('2018-10-22', customSTObjs.tvschedule[0].tvdate);
        System.assertequals(0, customSTObjs.tvschedule[0].numberOfPayments);
        System.assertequals(100.00, customSTObjs.tvschedule[0].tvValuePct);
        System.assertequals(2000000.00, customSTObjs.tvschedule[0].tvValueAmt);
        System.assertequals(0, customSTObjs.tvschedule[0].advanceRent);
        System.assertequals(0, customSTObjs.tvschedule[0].arrearsRent);
        System.assertequals(0, customSTObjs.tvschedule[0].advanceDebtService);
        System.assertequals(0, customSTObjs.tvschedule[0].arrearsDebtService);
        System.assertequals(2000000.00, customSTObjs.tvschedule[0].totalDue);
        System.assertequals('2018-11-22', customSTObjs.tvschedule[1].tvdate);
        System.assertequals(1, customSTObjs.tvschedule[1].numberOfPayments);
        System.assertequals(95.000034, customSTObjs.tvschedule[1].tvValuePct);
        System.assertequals(1900000.68, customSTObjs.tvschedule[1].tvValueAmt);
        System.assertequals(19000.22, customSTObjs.tvschedule[1].advanceRent);
        System.assertequals(18000.01, customSTObjs.tvschedule[1].arrearsRent);
        System.assertequals(19288.04, customSTObjs.tvschedule[1].advanceDebtService);
        System.assertequals(18100.03, customSTObjs.tvschedule[1].arrearsDebtService);
        System.assertequals(1968001.54, customSTObjs.tvschedule[1].totalDue);        
        System.assertequals('2018-12-22', customSTObjs.tvschedule[2].tvdate);
        System.assertequals(2, customSTObjs.tvschedule[2].numberOfPayments);
        System.assertequals(93.000000, customSTObjs.tvschedule[2].tvValuePct);
        System.assertequals(1860000.00, customSTObjs.tvschedule[2].tvValueAmt);
        System.assertequals(null, customSTObjs.tvschedule[2].advanceRent);
        System.assertequals(36000.01, customSTObjs.tvschedule[2].arrearsRent);
        System.assertequals(null, customSTObjs.tvschedule[2].advanceDebtService);
        System.assertequals(null, customSTObjs.tvschedule[2].arrearsDebtService);
        System.assertequals(1868001.54, customSTObjs.tvschedule[2].totalDue);
    }
}