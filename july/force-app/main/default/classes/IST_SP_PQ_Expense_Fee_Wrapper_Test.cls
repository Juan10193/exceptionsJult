@Istest
public class IST_SP_PQ_Expense_Fee_Wrapper_Test {
    @Istest
    public static void istSpPqExpenseFeeWrapper(){
        iST_SP_PQ_Expense_Fee_Wrapper_cls.query_All_Fields query = new iST_SP_PQ_Expense_Fee_Wrapper_cls.query_All_Fields();
        Date firstDate = Date.newInstance(2019, 09, 30);
        query.recordID = 'a2Y5C000000Dq2BUAS';
        query.IST_Amount = 2.1;
        query.IST_Calculation_Index = 5;
        query.CreatedById = 'a2Y5C000000Dq2BUAS';
        query.CurrencyIsoCode = '12345';
        query.IST_Description = 'Pruebas';
        query.Name = 'Pruebas';
        query.LastModifiedById = 'a2Y5C000000Dq2BUAS';
        query.IST_Paid_Date = firstDate;
        query.IST_Percent = 2.5;
        query.IST_Pricing_Quote = 'a2Y5C000000Dq2BUAS';
        query.IST_stExternalID = 'a2Y5C000000Dq2BUAS'; 
    }
}