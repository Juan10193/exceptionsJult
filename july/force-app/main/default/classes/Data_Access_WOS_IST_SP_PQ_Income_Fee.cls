public without sharing class Data_Access_WOS_IST_SP_PQ_Income_Fee {
    
    public static List<IST_ST_PQ_Income_Fee_Wrapper_cls.query_All_Fields> getIncome_FeeByPQ(id PQID){ 
        List<IST_ST_PQ_Income_Fee_Wrapper_cls.query_All_Fields> list_ST_PQ_Income_Fee_Wrapper_cls = new List<IST_ST_PQ_Income_Fee_Wrapper_cls.query_All_Fields>();
            for(IST__SuperTRUMP_PQ_Income_Fee__c Income_Fee : [SELECT Id, Name, IST__Amount__c, IST__Calculation_Index__c, CreatedById, CurrencyIsoCode, 
                                                      IST__Description__c, LastModifiedById, IST__Paid_Date__c, IST__Percent__c, IST__Pricing_Quote__c, 
                                                      IST__stExternalID__c 
                                                      FROM IST__SuperTRUMP_PQ_Income_Fee__c  
                                                         where IST__Pricing_Quote__c = :PQID]){
                list_ST_PQ_Income_Fee_Wrapper_cls.add(dropDataIntoWrapper(Income_Fee)); 

            }
        return list_ST_PQ_Income_Fee_Wrapper_cls;
    }
    
    private static IST_ST_PQ_Income_Fee_Wrapper_cls.query_All_Fields dropDataIntoWrapper(IST__SuperTRUMP_PQ_Income_Fee__c Income_Fee){
        IST_ST_PQ_Income_Fee_Wrapper_cls.query_All_Fields query_All_Fields = new IST_ST_PQ_Income_Fee_Wrapper_cls.query_All_Fields();
        query_All_Fields.IST_Amount = Income_Fee.IST__Amount__c;
        query_All_Fields.IST_Calculation_Index = Integer.valueof(Income_Fee.IST__Calculation_Index__c);
        query_All_Fields.CreatedById = Income_Fee.CreatedById;
        query_All_Fields.CurrencyIsoCode = Income_Fee.CurrencyIsoCode;
        query_All_Fields.IST_Description = Income_Fee.IST__Description__c;
        query_All_Fields.Name = Income_Fee.Name;
        query_All_Fields.LastModifiedById = Income_Fee.LastModifiedById;
        query_All_Fields.IST_Paid_Date = Income_Fee.IST__Paid_Date__c;
        query_All_Fields.IST_Percent = Income_Fee.IST__Percent__c;
        query_All_Fields.IST_Pricing_Quote = Income_Fee.IST__Pricing_Quote__c;
        query_All_Fields.IST_stExternalID = Income_Fee.IST__stExternalID__c;
        return query_All_Fields;
        
    }
    

}