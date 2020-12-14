@isTest
public class Takedown_CA_VS_ST_Table_Wrapper_Test {
	@isTest
    public static void PricingGroup(){
        Takedown_CA_VS_ST_Table_Wrapper_cls.PricingGroup Test_PG = new Takedown_CA_VS_ST_Table_Wrapper_cls.PricingGroup();
        SupperTRUMP_Pricing_Quote_Wrapper.query_All_Fields Pricing_CA = new SupperTRUMP_Pricing_Quote_Wrapper.query_All_Fields();
        Test_PG.PricingCA = Pricing_CA;
        SupperTRUMP_Pricing_Quote_Wrapper.query_All_Fields Pricing_PQ = new SupperTRUMP_Pricing_Quote_Wrapper.query_All_Fields();
        Test_PG.PricingPQ = Pricing_PQ;
    }
    @isTest
    public static void Table(){
        Takedown_CA_VS_ST_Table_Wrapper_cls.Table Test_Table = new Takedown_CA_VS_ST_Table_Wrapper_cls.Table();
        Test_Table.rows = new List <Takedown_CA_VS_ST_Table_Wrapper_cls.Row>();
    }
    @isTest
    public static void Row(){
        Takedown_CA_VS_ST_Table_Wrapper_cls.Row Test_Row = new Takedown_CA_VS_ST_Table_Wrapper_cls.Row();
        Test_Row.field = 'Campo';
        Test_Row.dataPricingCA = 'Data Pricing CA';
        Test_Row.dataPricingST = 'Data Pricing ST';
        Test_Row.evaluation = 'Evaluación';
        Test_Row.symbol = '$$$';
    }
}