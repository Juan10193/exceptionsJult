public class Data_Access_WOS_ST_PQ_Perio_Expe_cls { 
     public static list<ST_PQ_Periodic_Expense_Wrapper_cls.query_All_Fields> getAllFieldsBySetID(set<id> setPerioExpetId){
        list<ST_PQ_Periodic_Expense_Wrapper_cls.query_All_Fields> listST_PQ_Periodic_Expense_Wrapper = new list<ST_PQ_Periodic_Expense_Wrapper_cls.query_All_Fields>();
        for(ST_PQ_Periodic_Expense__c ST_PQ_Periodic_Expense : [Select Id, IsDeleted, Name, CurrencyIsoCode, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, 
                                                                 SystemModstamp, LastActivityDate, Pricing_Quote__c, Active__c, Average_Payment__c, Description__c, Num_Payments__c, 
                                                                 Periodicity__c, Start_Date__c, stExternalID__c, 
                                                                 (Select Id, IsDeleted, Name, CurrencyIsoCode, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, 
                                                                  SystemModstamp, LastActivityDate, Periodic_Expense__c, Amount__c, Balance__c, End_Accrual__c, Num_Pmts__c, 
                                                                  Period__c, Rate__c, Start_Accrual__c, Step__c, Timing__c, Type__c 
                                                                  from Periodic_Expense_Cashflow_Steps__r) 
                                                                 From ST_PQ_Periodic_Expense__c
                                                              where id in :setPerioExpetId]){
                                                                  listST_PQ_Periodic_Expense_Wrapper.add(ST_PQ_Perio_Expe_Parse_cls.dropDataIntoWrapper(ST_PQ_Periodic_Expense));                                                             
                                                              }
        return listST_PQ_Periodic_Expense_Wrapper;
    }

}