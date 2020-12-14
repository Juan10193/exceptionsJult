@Istest
public with sharing class ST_PQ_EBO_Wrapper_Test {
    @Istest
    public static void rellenaWraper(){
        ST_PQ_EBO_Wrapper_cls.query_All_Fields wrapper = new ST_PQ_EBO_Wrapper_cls.query_All_Fields();
        wrapper.recordID = 'a0Bm000000Cn56EEAR';
        wrapper.Active = true;
        wrapper.Amount =12.12;
        wrapper.Based_on ='based';
        wrapper.CreatedById ='0051R00000D8QcZQAV';
        wrapper.CurrencyIsoCode ='MXN';
        wrapper.EBO_Date = Date.newInstance(2019,08,11);
        wrapper.Name ='Nombre';
        wrapper.FMV = 12.22;
        wrapper.LastModifiedById ='0051R00000D8QcZQAV';
        wrapper.Premium = 12.1212;
        wrapper.stExternalID ='1231231';
        wrapper.Pricing_Quote='a0Bm000000Cn56EEAR';
        wrapper.Term =12345.12345; 
    }
}