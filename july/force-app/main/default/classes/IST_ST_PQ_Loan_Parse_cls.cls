/**
 * @File Name          : IST_ST_PQ_Loan_Parse_cls.cls
 * @Description        : 
 * @Author             : eduardo.villegas@engeniumcapital.com
 * @Group              : 
 * @Last Modified By   : eduardo.villegas@engeniumcapital.com
 * @Last Modified On   : 9/10/2019 15:47:53
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    9/10/2019   eduardo.villegas@engeniumcapital.com     Initial Version
**/
public without sharing class IST_ST_PQ_Loan_Parse_cls {
    public static IST_ST_PQ_Loan_Wrapper_cls.query_All_Fields dropDataIntoWrapper(IST__SuperTRUMP_PQ_Loan__c loanPQ){
        IST_ST_PQ_Loan_Wrapper_cls.query_All_Fields IST_ST_PQ_Loan_Wrapper = new IST_ST_PQ_Loan_Wrapper_cls.query_All_Fields();
        IST_ST_PQ_Loan_Wrapper.recordID                 = loanPQ.id;
        IST_ST_PQ_Loan_Wrapper.IST_Advance_Payment      = loanPQ.IST__Advance_Payment__c;
        IST_ST_PQ_Loan_Wrapper.IST_Calculation_Index    = Integer.valueof(loanPQ.IST__Calculation_Index__c);
        IST_ST_PQ_Loan_Wrapper.CreatedById              = loanPQ.CreatedById;
        IST_ST_PQ_Loan_Wrapper.CurrencyIsoCode          = loanPQ.CurrencyIsoCode;
        IST_ST_PQ_Loan_Wrapper.IST_Description          = loanPQ.IST__Description__c;
        IST_ST_PQ_Loan_Wrapper.LastModifiedById         = loanPQ.LastModifiedById;
        IST_ST_PQ_Loan_Wrapper.Name                     = loanPQ.Name;
        IST_ST_PQ_Loan_Wrapper.Loan_Rate                = loanPQ.Loan_Rate__c;
        IST_ST_PQ_Loan_Wrapper.IST_Num_Payments         = Integer.valueof(loanPQ.IST__Num_Payments__c);
        IST_ST_PQ_Loan_Wrapper.IST_Pricing_Quote        = loanPQ.IST__Pricing_Quote__c;
        IST_ST_PQ_Loan_Wrapper.IST_stExternalID         = loanPQ.IST__stExternalID__c;
        IST_ST_PQ_Loan_Wrapper.IST_Start_Date           = loanPQ.IST__Start_Date__c;
        IST_ST_PQ_Loan_Wrapper.IST_Total_Funding        = loanPQ.IST__Total_Funding__c;
        IST_ST_PQ_Loan_Wrapper.IST_Total_Payments       = loanPQ.IST__Total_Payments__c;
        IST_ST_PQ_Loan_Wrapper.list_ST_PQ_Loan_ASS_Wrapper = getlist_ST_PQ_Loan_ASS_Wrapper(loanPQ.Loan_Amortization_Schedule_Steps__r);
        IST_ST_PQ_Loan_Wrapper.list_ST_PQ_Loan_CFS_Wrapper = getlist_ST_PQ_Loan_CFS_Wrapper(loanPQ.Loan_Cashflow_Steps__r);
        
        return IST_ST_PQ_Loan_Wrapper;
        
    }
    /**
    * @description 
    * @author eduardo.villegas@engeniumcapital.com | 9/10/2019 
    * @param list<ST_PQ_Loan_Amortization_Schedule_Step__c> list_Loan_Amortization_Schedule_Step 
    * @return List<ST_PQ_Loan_ASS_Wrapper_cls.query_All_Fields> 
    **/
    public static List<ST_PQ_Loan_ASS_Wrapper_cls.query_All_Fields> getlist_ST_PQ_Loan_ASS_Wrapper(list<ST_PQ_Loan_Amortization_Schedule_Step__c> list_Loan_Amortization_Schedule_Step){
    	List<ST_PQ_Loan_ASS_Wrapper_cls.query_All_Fields> list_ST_PQ_Loan_ASS_Wrapper = new List<ST_PQ_Loan_ASS_Wrapper_cls.query_All_Fields>();
        for(ST_PQ_Loan_Amortization_Schedule_Step__c Loan_Amortization_Schedule_Step : list_Loan_Amortization_Schedule_Step){
            ST_PQ_Loan_ASS_Wrapper_cls.query_All_Fields ST_PQ_Loan_ASS_Wrapper = new ST_PQ_Loan_ASS_Wrapper_cls.query_All_Fields();
            ST_PQ_Loan_ASS_Wrapper.recordID = Loan_Amortization_Schedule_Step.id;
            ST_PQ_Loan_ASS_Wrapper.Balance = Loan_Amortization_Schedule_Step.Balance__c;
            ST_PQ_Loan_ASS_Wrapper.CreatedById = Loan_Amortization_Schedule_Step.CreatedById;
                ST_PQ_Loan_ASS_Wrapper.CurrencyIsoCode = Loan_Amortization_Schedule_Step.CurrencyIsoCode;
                ST_PQ_Loan_ASS_Wrapper.Amort_Date = Loan_Amortization_Schedule_Step.Amort_Date__c;
                ST_PQ_Loan_ASS_Wrapper.Funding = Loan_Amortization_Schedule_Step.Funding__c;
                ST_PQ_Loan_ASS_Wrapper.Interest = Loan_Amortization_Schedule_Step.Interest__c;
                ST_PQ_Loan_ASS_Wrapper.LastModifiedById = Loan_Amortization_Schedule_Step.LastModifiedById;
                ST_PQ_Loan_ASS_Wrapper.Loan = Loan_Amortization_Schedule_Step.Loan__c;
                ST_PQ_Loan_ASS_Wrapper.Name = Loan_Amortization_Schedule_Step.Name;
                ST_PQ_Loan_ASS_Wrapper.Payment = Loan_Amortization_Schedule_Step.Payment__c;
                ST_PQ_Loan_ASS_Wrapper.Principal = Loan_Amortization_Schedule_Step.Principal__c;
                ST_PQ_Loan_ASS_Wrapper.Step = Integer.valueof(Loan_Amortization_Schedule_Step.Step__c);
        	list_ST_PQ_Loan_ASS_Wrapper.add(ST_PQ_Loan_ASS_Wrapper);        
            
        }
        return list_ST_PQ_Loan_ASS_Wrapper;
        
    }
    
    /**
    * @description 
    * @author eduardo.villegas@engeniumcapital.com | 9/10/2019 
    * @param list<ST_PQ_Loan_Cash_Flow_Step__c> list_ST_PQ_Loan_Cash_Flow_Step 
    * @return List<ST_PQ_Loan_CFS_Wrapper_cls.query_All_Fields> 
    **/
    public static List<ST_PQ_Loan_CFS_Wrapper_cls.query_All_Fields> getlist_ST_PQ_Loan_CFS_Wrapper(list<ST_PQ_Loan_Cash_Flow_Step__c> list_ST_PQ_Loan_Cash_Flow_Step){
    	List<ST_PQ_Loan_CFS_Wrapper_cls.query_All_Fields> list_ST_PQ_Loan_CFS_Wrapper = new List<ST_PQ_Loan_CFS_Wrapper_cls.query_All_Fields>();
        for(ST_PQ_Loan_Cash_Flow_Step__c ST_PQ_Loan_Cash_Flow_Step : list_ST_PQ_Loan_Cash_Flow_Step){
            ST_PQ_Loan_CFS_Wrapper_cls.query_All_Fields ST_PQ_Loan_CFS_Wrapper = new ST_PQ_Loan_CFS_Wrapper_cls.query_All_Fields();
            ST_PQ_Loan_CFS_Wrapper.recordID = ST_PQ_Loan_Cash_Flow_Step.id;
            ST_PQ_Loan_CFS_Wrapper.Amount = ST_PQ_Loan_Cash_Flow_Step.Amount__c;
            ST_PQ_Loan_CFS_Wrapper.Balance = ST_PQ_Loan_Cash_Flow_Step.Balance__c;
            ST_PQ_Loan_CFS_Wrapper.CreatedById = ST_PQ_Loan_Cash_Flow_Step.CreatedById;
            ST_PQ_Loan_CFS_Wrapper.CurrencyIsoCode = ST_PQ_Loan_Cash_Flow_Step.CurrencyIsoCode;
            ST_PQ_Loan_CFS_Wrapper.Start_Accrual = ST_PQ_Loan_Cash_Flow_Step.Start_Accrual__c;                
            ST_PQ_Loan_CFS_Wrapper.LastModifiedById = ST_PQ_Loan_Cash_Flow_Step.LastModifiedById;
            ST_PQ_Loan_CFS_Wrapper.Loan = ST_PQ_Loan_Cash_Flow_Step.Loan__c;
            ST_PQ_Loan_CFS_Wrapper.Name = ST_PQ_Loan_Cash_Flow_Step.Name;
            ST_PQ_Loan_CFS_Wrapper.Num_Pmts = integer.valueof(ST_PQ_Loan_Cash_Flow_Step.Num_Pmts__c);
            ST_PQ_Loan_CFS_Wrapper.Period = ST_PQ_Loan_Cash_Flow_Step.Period__c;
            ST_PQ_Loan_CFS_Wrapper.Rate = ST_PQ_Loan_Cash_Flow_Step.Rate__c;
            ST_PQ_Loan_CFS_Wrapper.Step = integer.valueof(ST_PQ_Loan_Cash_Flow_Step.Step__c);
            ST_PQ_Loan_CFS_Wrapper.Timing = ST_PQ_Loan_Cash_Flow_Step.Timing__c;
            ST_PQ_Loan_CFS_Wrapper.End_Accrual = ST_PQ_Loan_Cash_Flow_Step.End_Accrual__c;
            ST_PQ_Loan_CFS_Wrapper.TypeLoan = ST_PQ_Loan_Cash_Flow_Step.Type__c;
        	list_ST_PQ_Loan_CFS_Wrapper.add(ST_PQ_Loan_CFS_Wrapper);        
            
        }
        return list_ST_PQ_Loan_CFS_Wrapper;
        
    }

}