public class Data_Access_WOS_IST_ST_PQ_Loan_cls {
    public static list<IST_ST_PQ_Loan_Wrapper_cls.query_All_Fields> getAllFieldsBySetID(set<id> setLoanId){
        list<IST_ST_PQ_Loan_Wrapper_cls.query_All_Fields> listIST_ST_PQ_Loan_Wrapper = new list<IST_ST_PQ_Loan_Wrapper_cls.query_All_Fields>();
        for(IST__SuperTRUMP_PQ_Loan__c IST_SuperTRUMP_PQ_Loan : [Select Id, IsDeleted, Name, CurrencyIsoCode, CreatedDate, CreatedById, LastModifiedDate, 
                                                              LastModifiedById, SystemModstamp, IST__Pricing_Quote__c, IST__Advance_Payment__c, 
                                                              IST__Calculation_Index__c, IST__Description__c, IST__Num_Payments__c, IST__Start_Date__c, 
                                                              IST__Total_Funding__c, IST__Total_Payments__c, IST__stExternalID__c, Loan_Rate__c, 
                                                              (Select Id, IsDeleted, Name, CurrencyIsoCode, CreatedDate, CreatedById, LastModifiedDate, 
                                                               LastModifiedById, SystemModstamp, LastActivityDate, Loan__c, Amount__c, Balance__c, 
                                                               End_Accrual__c, Num_Pmts__c, Period__c, Rate__c, Start_Accrual__c, Step__c, Timing__c, 
                                                               Type__c 
                                                               from Loan_Cashflow_Steps__r), 
                                                              (Select Id, IsDeleted, Name, CurrencyIsoCode, CreatedDate, CreatedById, LastModifiedDate, 
                                                               LastModifiedById, SystemModstamp, LastActivityDate, Loan__c, Amort_Date__c, 
                                                               Balance__c, Funding__c, Interest__c, Payment__c, Principal__c, Step__c 
                                                               from Loan_Amortization_Schedule_Steps__r) 
                                                              From IST__SuperTRUMP_PQ_Loan__c
                                                              where id in :setLoanId]){
                                                                  listIST_ST_PQ_Loan_Wrapper.add(IST_ST_PQ_Loan_Parse_cls.dropDataIntoWrapper(IST_SuperTRUMP_PQ_Loan));                                                                  
                                                              }
        return listIST_ST_PQ_Loan_Wrapper;
    }

}