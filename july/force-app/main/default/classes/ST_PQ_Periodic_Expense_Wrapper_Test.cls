@isTest
public class ST_PQ_Periodic_Expense_Wrapper_Test {
    @isTest static void Wrapper_Test() {
        ST_PQ_Periodic_Expense_Wrapper_cls.query_All_Fields Test = new ST_PQ_Periodic_Expense_Wrapper_cls.query_All_Fields();
        Test.recordID = 'a40m0000000XcDEAA0';
		Test.Average_Payment = 25000 ;
		Test.Active = true ;
		Test.CreatedById = 'a40m0000000XcDEAA1' ;
		Test.CurrencyIsoCode = '23233' ;
		Test.Description = 'Este es un test :)';
		Test.LastModifiedById = 'a40m0000000XcDEAA2' ;
		Test.Num_Payments = 4;
		Test.Name = 'Ejemplo';
		Test.Periodicity = 'Cada que se requiera';
		Test.stExternalID = 'a40m0000000XcDEAA6' ;
        Date firstDate = Date.newInstance(2019, 09, 30);
		Test.Start_Date = firstDate;
		Test.Pricing_Quote = 'a40m0000000XcDEAA9';
		Test.ST_PQ_Periodic_Expense_CFS_Wrapper = new list<ST_PQ_Periodic_Expense_CFS_Wrapper_cls.query_All_Fields>();
    }
}