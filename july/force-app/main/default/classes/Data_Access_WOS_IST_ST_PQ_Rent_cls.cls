/**
 * @File Name          : Data_Access_WOS_IST_ST_PQ_Rent_cls.cls
 * @Description        : 
 * @Author             : eduardo.villegas@engeniumcapital.com
 * @Group              : 
 * @Last Modified By   : eduardo.villegas@engeniumcapital.com
 * @Last Modified On   : 9/10/2019 16:29:22
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    9/10/2019   eduardo.villegas@engeniumcapital.com     Initial Version
**/
public class Data_Access_WOS_IST_ST_PQ_Rent_cls {
    /**
    * @description 
    * @author eduardo.villegas@engeniumcapital.com | 9/10/2019 
    * @param set<id> setLoanId 
    * @return list<IST_ST_PQ_Rent_Wrapper_cls.query_All_Fields> 
    **/
    public static list<IST_ST_PQ_Rent_Wrapper_cls.query_All_Fields> getAllFieldsBySetID(set<id> setRentId){
        list<IST_ST_PQ_Rent_Wrapper_cls.query_All_Fields> listIST_ST_PQ_Rent_Wrapper = new list<IST_ST_PQ_Rent_Wrapper_cls.query_All_Fields>();
        for(IST__SuperTRUMP_PQ_Rent__c IST_SuperTRUMP_PQ_Rent : [Select Id, IsDeleted, Name, CurrencyIsoCode, CreatedDate, CreatedById, LastModifiedDate, 
                                                                 LastModifiedById, SystemModstamp, IST__Pricing_Quote__c, IST__Advance_Payment__c, 
                                                                 IST__Calculation_Index__c, IST__Description__c, IST__Num_Payments__c, IST__Total_Payments__c, 
                                                                 IST__stExternalID__c, Quasi_Lease_Rate__c, 
                                                                 (Select Id, IsDeleted, Name, CurrencyIsoCode, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, 
                                                                  SystemModstamp, LastActivityDate, Rent__c, Amort_Date__c, Balance__c, Funding__c, Interest__c, 
                                                                  Payment__c, Principal__c, Step__c 
                                                                  from Rent_Amortization_Schedule_Steps__r), 
                                                                 (Select Id, IsDeleted, Name, CurrencyIsoCode, CreatedDate, CreatedById, LastModifiedDate, 
                                                                  LastModifiedById, SystemModstamp, LastActivityDate, Rent__c, Amount__c, Balance__c, End_Accrual__c, 
                                                                  Num_Pmts__c, Period__c, Rate__c, Start_Accrual__c, Step__c, Timing__c, Type__c 
                                                                  from Rent_Cashflow_Steps__r) 
                                                                 From IST__SuperTRUMP_PQ_Rent__c
                                                              where id in :setRentId]){
                                                                  listIST_ST_PQ_Rent_Wrapper.add(IST_ST_PQ_Rent_Parse_cls.dropDataIntoWrapper(IST_SuperTRUMP_PQ_Rent));                                                             
                                                              }
        return listIST_ST_PQ_Rent_Wrapper;
    }

}