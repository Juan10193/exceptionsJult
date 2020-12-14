@isTest
public class Takedown_CA_VS_ST_Wrapper_Test {
	@isTest 
    public static void CA_VS_ST_Wrapper(){
	   Takedown_CA_VS_ST_Wrapper_cls.CA_VS_ST_Wrapper Test_CA_ST = new Takedown_CA_VS_ST_Wrapper_cls.CA_VS_ST_Wrapper();
       Takedown_CA_VS_ST_Wrapper_cls.CA_Wrapper Test_CA = new Takedown_CA_VS_ST_Wrapper_cls.CA_Wrapper();
       Takedown_CA_VS_ST_Wrapper_cls.ST_Wrapper Test_ST = new Takedown_CA_VS_ST_Wrapper_cls.ST_Wrapper();
       Test_CA_ST.cA_Wrapper = Test_CA;
       Test_CA_ST.sT_Wrapper = Test_ST; 
    }
    @isTest 
    public static void CA_Wrapper(){
	   Takedown_CA_VS_ST_Wrapper_cls.CA_Wrapper Test_CA = new Takedown_CA_VS_ST_Wrapper_cls.CA_Wrapper();
       Test_Ca.creditApprovalId = 'a40m0000000XcDEAA8';
       Test_CA.creditApprovalName = 'Ejemplo Test CA';
       Test_CA.pricingId = 'a40m0000000XcDEAA7';
       Test_Ca.pricingName = 'Ejemplo Test Pricing';
    }
    @isTest 
    public static void ST_Wrapper(){
       Takedown_CA_VS_ST_Wrapper_cls.ST_Wrapper Test_ST = new Takedown_CA_VS_ST_Wrapper_cls.ST_Wrapper();
       Test_ST.pricingcreditApprovalId = 'a40m0000000XcDEAA9';
       Test_ST.pricingName = 'Ejemplo Test';    
    }
}