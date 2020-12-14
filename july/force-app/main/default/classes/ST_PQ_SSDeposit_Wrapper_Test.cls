@isTest
public class ST_PQ_SSDeposit_Wrapper_Test {
    @isTest static void Wrapper_Test(){
        ST_PQ_SSDeposit_Wrapper_cls.query_All_Fields Test = new ST_PQ_SSDeposit_Wrapper_cls.query_All_Fields();
        Test.recordID = 'a40m0000000XcDEAA0';
		Test.Amount = 120000;
		Test.CreatedById = 'a40m0000000XcDEAA1' ;
		Test.CurrencyIsoCode = '123424' ;
		Test.LastModifiedById = 'a40m0000000XcDEAA3' ;
		Date firstDate = Date.newInstance(2019, 10, 30);
		Test.Received = firstDate;
		Date SecondDate = Date.newInstance(2019, 09, 30);
		Test.Returned = SecondDate;
		Test.Name = 'Ejemplo' ;
		Test.stExternalID = 'a40m0000000XcDEAA4';
		Test.Pricing_Quote = 'a40m0000000XcDEAA5';	
    } 
}