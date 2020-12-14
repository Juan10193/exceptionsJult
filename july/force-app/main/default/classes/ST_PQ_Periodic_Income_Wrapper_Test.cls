@Istest
public class ST_PQ_Periodic_Income_Wrapper_Test {
   @Istest
   public static void prueba()
   {
       Date Start_Date = Date.newInstance(2019, 09, 30);
       ST_PQ_Periodic_Income_Wrapper_cls.query_All_Fields query = new ST_PQ_Periodic_Income_Wrapper_cls.query_All_Fields();
       query.recordID = 'a2Y5C000000Dq2BUAS' ;
       query.Of_Payments = 4.4 ;
       query.Active= true;
       query.Average_Payment = 3.2  ;
       query.CreatedById = 'a2Y5C000000Dq2BUAS';
       query.CurrencyIsoCode = 'MXN';
       query.Description = 'Desc ';
       query.Financed_Amount= 4.8;
       query.LastModifiedById = 'a2Y5C000000Dq2BUAS';
       query.Num_Payments = 4;
       query.Name='pruebas';
       query.Periodicity= 'Periodicity';
       query.Insurance_Rate = 2.3;
       query.stExternalID= 'a2Y5C000000Dq2BUAS';
       query.Start_Date= Start_Date;
       query.Pricing_Quote = 'a2Y5C000000Dq2BUAS';
       query.ST_PQ_Periodic_Income_CFS_Wrapper = new List<ST_PQ_Periodic_Income_CFS_Wrapper_cls.query_All_Fields>();
   }
}