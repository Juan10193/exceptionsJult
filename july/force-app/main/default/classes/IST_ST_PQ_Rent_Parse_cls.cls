/**
 * @File Name          : IST_ST_PQ_Rent_Parse_cls.cls
 * @Description        : 
 * @Author             : eduardo.villegas@engeniumcapital.com
 * @Group              : 
 * @Last Modified By   : eduardo.villegas@engeniumcapital.com
 * @Last Modified On   : 9/10/2019 16:31:27
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification 
 * 1.0    9/10/2019   eduardo.villegas@engeniumcapital.com     Initial Version
**/
public class IST_ST_PQ_Rent_Parse_cls {
    /**
    * @description 
    * @author eduardo.villegas@engeniumcapital.com | 9/10/2019 
    * @param IST__SuperTRUMP_PQ_Rent__c rentPQ 
    * @return IST_ST_PQ_Rent_Wrapper_cls.query_All_Fields 
    **/
    public static IST_ST_PQ_Rent_Wrapper_cls.query_All_Fields dropDataIntoWrapper(IST__SuperTRUMP_PQ_Rent__c rentPQ){
        IST_ST_PQ_Rent_Wrapper_cls.query_All_Fields IST_ST_PQ_Rent_Wrapper = new IST_ST_PQ_Rent_Wrapper_cls.query_All_Fields();
        IST_ST_PQ_Rent_Wrapper.recordID                 = rentPQ.id;
        IST_ST_PQ_Rent_Wrapper.IST_Advance_Payment      = rentPQ.IST__Advance_Payment__c;
        IST_ST_PQ_Rent_Wrapper.IST_Calculation_Index    = Integer.valueof(rentPQ.IST__Calculation_Index__c);
        IST_ST_PQ_Rent_Wrapper.CreatedById              = rentPQ.CreatedById;
        IST_ST_PQ_Rent_Wrapper.CurrencyIsoCode          = rentPQ.CurrencyIsoCode;
        IST_ST_PQ_Rent_Wrapper.IST_Description          = rentPQ.IST__Description__c;
        IST_ST_PQ_Rent_Wrapper.LastModifiedById         = rentPQ.LastModifiedById;
        IST_ST_PQ_Rent_Wrapper.IST_Num_Payments         = Integer.valueof(rentPQ.IST__Num_Payments__c);
        IST_ST_PQ_Rent_Wrapper.IST_Pricing_Quote        = rentPQ.IST__Pricing_Quote__c;
        IST_ST_PQ_Rent_Wrapper.Quasi_Lease_Rate         = rentPQ.Quasi_Lease_Rate__c;
        IST_ST_PQ_Rent_Wrapper.Name                     = rentPQ.Name;
        IST_ST_PQ_Rent_Wrapper.IST_stExternalID         = rentPQ.IST__stExternalID__c;
        IST_ST_PQ_Rent_Wrapper.IST_Total_Payments       = rentPQ.IST__Total_Payments__c;
        IST_ST_PQ_Rent_Wrapper.list_ST_PQ_Rent_ASS_Wrapper = getlist_ST_PQ_Rent_ASS_Wrapper(rentPQ.Rent_Amortization_Schedule_Steps__r);
        IST_ST_PQ_Rent_Wrapper.list_ST_PQ_Rent_CFS_Wrapper = getlist_ST_PQ_Rent_CFS_Wrapper(rentPQ.Rent_Cashflow_Steps__r);
        
        return IST_ST_PQ_Rent_Wrapper;
        
    }
    /**
    * @description 
    * @author eduardo.villegas@engeniumcapital.com | 9/10/2019 
    * @param list<ST_PQ_Rent_Amortization_Schedule_Step__c> list_ST_PQ_Rent_Amortization_Schedule_Step 
    * @return List<ST_PQ_Rent_ASS_Wrapper_cls.query_All_Fields> 
    **/
    public static List<ST_PQ_Rent_ASS_Wrapper_cls.query_All_Fields> getlist_ST_PQ_Rent_ASS_Wrapper(list<ST_PQ_Rent_Amortization_Schedule_Step__c> list_ST_PQ_Rent_Amortization_Schedule_Step){
    	List<ST_PQ_Rent_ASS_Wrapper_cls.query_All_Fields> list_ST_PQ_Loan_ASS_Wrapper = new List<ST_PQ_Rent_ASS_Wrapper_cls.query_All_Fields>();
        for(ST_PQ_Rent_Amortization_Schedule_Step__c ST_PQ_Rent_Amortization_Schedule_Step : list_ST_PQ_Rent_Amortization_Schedule_Step){
            ST_PQ_Rent_ASS_Wrapper_cls.query_All_Fields ST_PQ_Rent_ASS_Wrapper = new ST_PQ_Rent_ASS_Wrapper_cls.query_All_Fields();
            ST_PQ_Rent_ASS_Wrapper.recordID             = ST_PQ_Rent_Amortization_Schedule_Step.id;
            ST_PQ_Rent_ASS_Wrapper.Balance              = ST_PQ_Rent_Amortization_Schedule_Step.Balance__c;
            ST_PQ_Rent_ASS_Wrapper.CreatedById          = ST_PQ_Rent_Amortization_Schedule_Step.CreatedById;
            ST_PQ_Rent_ASS_Wrapper.CurrencyIsoCode      = ST_PQ_Rent_Amortization_Schedule_Step.CurrencyIsoCode;
            ST_PQ_Rent_ASS_Wrapper.Amort_Date           = ST_PQ_Rent_Amortization_Schedule_Step.Amort_Date__c; 
            ST_PQ_Rent_ASS_Wrapper.Funding              = ST_PQ_Rent_Amortization_Schedule_Step.Funding__c;
            ST_PQ_Rent_ASS_Wrapper.Interest             = ST_PQ_Rent_Amortization_Schedule_Step.Interest__c;
            ST_PQ_Rent_ASS_Wrapper.LastModifiedById     = ST_PQ_Rent_Amortization_Schedule_Step.LastModifiedById;
            ST_PQ_Rent_ASS_Wrapper.Payment              = ST_PQ_Rent_Amortization_Schedule_Step.Payment__c;
            ST_PQ_Rent_ASS_Wrapper.Principal            = ST_PQ_Rent_Amortization_Schedule_Step.Principal__c;
            ST_PQ_Rent_ASS_Wrapper.Step                 = Integer.valueof(ST_PQ_Rent_Amortization_Schedule_Step.Step__c);            
            ST_PQ_Rent_ASS_Wrapper.rent                 = ST_PQ_Rent_Amortization_Schedule_Step.Rent__c;
            ST_PQ_Rent_ASS_Wrapper.Name                 = ST_PQ_Rent_Amortization_Schedule_Step.Name;
        	list_ST_PQ_Loan_ASS_Wrapper.add(ST_PQ_Rent_ASS_Wrapper);        
            
        }
        return list_ST_PQ_Loan_ASS_Wrapper;
        
    }
    
    /**
    * @description 
    * @author eduardo.villegas@engeniumcapital.com | 9/10/2019 
    * @param list<ST_PQ_Rent_Cash_Flow_Step__c> list_ST_PQ_Rent_Cash_Flow_Step 
    * @return List<ST_PQ_Rent_CFS_Wrapper_cls.query_All_Fields> 
    **/
    public static List<ST_PQ_Rent_CFS_Wrapper_cls.query_All_Fields> getlist_ST_PQ_Rent_CFS_Wrapper(list<ST_PQ_Rent_Cash_Flow_Step__c> list_ST_PQ_Rent_Cash_Flow_Step){
    	List<ST_PQ_Rent_CFS_Wrapper_cls.query_All_Fields> list_ST_PQ_Rent_CFS_Wrapper = new List<ST_PQ_Rent_CFS_Wrapper_cls.query_All_Fields>();
        for(ST_PQ_Rent_Cash_Flow_Step__c ST_PQ_Rent_Cash_Flow_Step : list_ST_PQ_Rent_Cash_Flow_Step){
            ST_PQ_Rent_CFS_Wrapper_cls.query_All_Fields ST_PQ_Rent_CFS_Wrapper = new ST_PQ_Rent_CFS_Wrapper_cls.query_All_Fields();
            ST_PQ_Rent_CFS_Wrapper.recordID             = ST_PQ_Rent_Cash_Flow_Step.id;
            ST_PQ_Rent_CFS_Wrapper.Amount               = ST_PQ_Rent_Cash_Flow_Step.Amount__c;
            ST_PQ_Rent_CFS_Wrapper.Balance              = ST_PQ_Rent_Cash_Flow_Step.Balance__c;
            ST_PQ_Rent_CFS_Wrapper.CreatedById          = ST_PQ_Rent_Cash_Flow_Step.CreatedById;
            ST_PQ_Rent_CFS_Wrapper.CurrencyIsoCode      = ST_PQ_Rent_Cash_Flow_Step.CurrencyIsoCode;
            ST_PQ_Rent_CFS_Wrapper.Start_Accrual        = ST_PQ_Rent_Cash_Flow_Step.Start_Accrual__c;                
            ST_PQ_Rent_CFS_Wrapper.LastModifiedById     = ST_PQ_Rent_Cash_Flow_Step.LastModifiedById;
            ST_PQ_Rent_CFS_Wrapper.Rent                 = ST_PQ_Rent_Cash_Flow_Step.Rent__c;
            ST_PQ_Rent_CFS_Wrapper.Name                 = ST_PQ_Rent_Cash_Flow_Step.Name;
            ST_PQ_Rent_CFS_Wrapper.Num_Pmts             = integer.valueof(ST_PQ_Rent_Cash_Flow_Step.Num_Pmts__c);
            ST_PQ_Rent_CFS_Wrapper.Period               = ST_PQ_Rent_Cash_Flow_Step.Period__c;
            ST_PQ_Rent_CFS_Wrapper.Rate                 = ST_PQ_Rent_Cash_Flow_Step.Rate__c;
            ST_PQ_Rent_CFS_Wrapper.Step                 = integer.valueof(ST_PQ_Rent_Cash_Flow_Step.Step__c);
            ST_PQ_Rent_CFS_Wrapper.Timing               = ST_PQ_Rent_Cash_Flow_Step.Timing__c;
            ST_PQ_Rent_CFS_Wrapper.End_Accrual          = ST_PQ_Rent_Cash_Flow_Step.End_Accrual__c;
            ST_PQ_Rent_CFS_Wrapper.TypeRent             = ST_PQ_Rent_Cash_Flow_Step.Type__c;
        	list_ST_PQ_Rent_CFS_Wrapper.add(ST_PQ_Rent_CFS_Wrapper);        
            
        }
        return list_ST_PQ_Rent_CFS_Wrapper;
        
    }

}