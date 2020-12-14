@Istest
public class IST_ST_PQ_Loan_Wrapper_Test {
    @Istest
    public static void ResolvedTestPQLoan(){
        
        IST_ST_PQ_Loan_Wrapper_cls.query_All_Fields b = new IST_ST_PQ_Loan_Wrapper_cls.query_All_Fields();
        b.recordID='a2YS00000032VKOMA2';
        b.IST_Advance_Payment=1.1;
        b.IST_Calculation_Index=1;
        b.CreatedById='a2YS00000032VKOMA2';
        b.CurrencyIsoCode='IsoCode';
        b.IST_Description='Description';
        b.LastModifiedById='a2YS00000032VKOMA2';
        b.Name='Eduardo';
        b.Loan_Rate=1.1;
        b.IST_Num_Payments=1;
        b.IST_Pricing_Quote='a2YS00000032VKOMA2';
        b.IST_stExternalID='a2YS00000032VKOMA2';
        b.IST_Start_Date=Date.today();
        b.IST_Total_Funding=1.1;
        b.IST_Total_Payments=1.1;
        b.list_ST_PQ_Loan_ASS_Wrapper = new list<ST_PQ_Loan_ASS_Wrapper_cls.query_All_Fields>();
        b.list_ST_PQ_Loan_CFS_Wrapper = new list<ST_PQ_Loan_CFS_Wrapper_cls.query_All_Fields>();

            
    }

}