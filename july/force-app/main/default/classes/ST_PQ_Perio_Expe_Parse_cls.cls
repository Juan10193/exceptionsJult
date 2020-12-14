/**
 * @File Name          : ST_PQ_Perio_Expe_Parse_cls.cls
 * @Description        : 
 * @Author             : eduardo.villegas@engeniumcapital.com
 * @Group              : 
 * @Last Modified By   : eduardo.villegas@engeniumcapital.com
 * @Last Modified On   : 10/10/2019 17:21:09
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    10/10/2019   eduardo.villegas@engeniumcapital.com     Initial Version
**/
public without sharing class ST_PQ_Perio_Expe_Parse_cls {
    /**
    * @description 
    * @author eduardo.villegas@engeniumcapital.com | 10/10/2019 
    * @param ST_PQ_Periodic_Expense__c Periodic_Expense 
    * @return ST_PQ_Periodic_Expense_Wrapper_cls.query_All_Fields 
    **/
    public static ST_PQ_Periodic_Expense_Wrapper_cls.query_All_Fields dropDataIntoWrapper(ST_PQ_Periodic_Expense__c Periodic_Expense){
        ST_PQ_Periodic_Expense_Wrapper_cls.query_All_Fields ST_PQ_Periodic_Expense_CFS_Wrapper = new ST_PQ_Periodic_Expense_Wrapper_cls.query_All_Fields();
        ST_PQ_Periodic_Expense_CFS_Wrapper.recordID             = Periodic_Expense.id;
        ST_PQ_Periodic_Expense_CFS_Wrapper.Active      			= Periodic_Expense.Active__c;
        ST_PQ_Periodic_Expense_CFS_Wrapper.Average_Payment    	= Periodic_Expense.Average_Payment__c;
        ST_PQ_Periodic_Expense_CFS_Wrapper.CreatedById          = Periodic_Expense.CreatedById;
        ST_PQ_Periodic_Expense_CFS_Wrapper.CurrencyIsoCode      = Periodic_Expense.CurrencyIsoCode;
        ST_PQ_Periodic_Expense_CFS_Wrapper.Description        	= Periodic_Expense.Description__c;
        ST_PQ_Periodic_Expense_CFS_Wrapper.LastModifiedById		= Periodic_Expense.LastModifiedById;
        ST_PQ_Periodic_Expense_CFS_Wrapper.Num_Payments			= Integer.valueof(Periodic_Expense.Num_Payments__c);
        ST_PQ_Periodic_Expense_CFS_Wrapper.Name               	= Periodic_Expense.Name;
        ST_PQ_Periodic_Expense_CFS_Wrapper.Periodicity     		= Periodic_Expense.Periodicity__c;
        ST_PQ_Periodic_Expense_CFS_Wrapper.stExternalID        	= Periodic_Expense.stExternalID__c;
        ST_PQ_Periodic_Expense_CFS_Wrapper.Start_Date         	= Periodic_Expense.Start_Date__c;
        ST_PQ_Periodic_Expense_CFS_Wrapper.Pricing_Quote        = Periodic_Expense.Pricing_Quote__c;
        ST_PQ_Periodic_Expense_CFS_Wrapper.ST_PQ_Periodic_Expense_CFS_Wrapper	= getlist_ST_PQ_Periodic_Expense_CFS_Wrapper(Periodic_Expense.Periodic_Expense_Cashflow_Steps__r);
        
        return ST_PQ_Periodic_Expense_CFS_Wrapper;
        
    }
    /**
    * @description 
    * @author eduardo.villegas@engeniumcapital.com | 10/10/2019 
    * @param list<ST_PQ_Periodic_Expense_Cash_Flow_Step__c> list_ST_PQ_Periodic_Expense_Cash_Flow_Step 
    * @return List<ST_PQ_Periodic_Expense_CFS_Wrapper_cls.query_All_Fields> 
    **/
    public static List<ST_PQ_Periodic_Expense_CFS_Wrapper_cls.query_All_Fields> getlist_ST_PQ_Periodic_Expense_CFS_Wrapper(list<ST_PQ_Periodic_Expense_Cash_Flow_Step__c> list_ST_PQ_Periodic_Expense_Cash_Flow_Step){
    	List<ST_PQ_Periodic_Expense_CFS_Wrapper_cls.query_All_Fields> list_ST_PQ_Periodic_Expense_CFS_Wrapper = new List<ST_PQ_Periodic_Expense_CFS_Wrapper_cls.query_All_Fields>();
        for(ST_PQ_Periodic_Expense_Cash_Flow_Step__c ST_PQ_Periodic_Expense_Cash_Flow_Step : list_ST_PQ_Periodic_Expense_Cash_Flow_Step){
            ST_PQ_Periodic_Expense_CFS_Wrapper_cls.query_All_Fields ST_PQ_Periodic_Expense_CFS_Wrapper = new ST_PQ_Periodic_Expense_CFS_Wrapper_cls.query_All_Fields();
        ST_PQ_Periodic_Expense_CFS_Wrapper.recordID             = ST_PQ_Periodic_Expense_Cash_Flow_Step.id;
        ST_PQ_Periodic_Expense_CFS_Wrapper.Amount      			= ST_PQ_Periodic_Expense_Cash_Flow_Step.Amount__c;
        ST_PQ_Periodic_Expense_CFS_Wrapper.Balance    			= ST_PQ_Periodic_Expense_Cash_Flow_Step.Balance__c;
        ST_PQ_Periodic_Expense_CFS_Wrapper.CreatedById          = ST_PQ_Periodic_Expense_Cash_Flow_Step.CreatedById;
        ST_PQ_Periodic_Expense_CFS_Wrapper.CurrencyIsoCode      = ST_PQ_Periodic_Expense_Cash_Flow_Step.CurrencyIsoCode;
        ST_PQ_Periodic_Expense_CFS_Wrapper.Start_Accrual        = ST_PQ_Periodic_Expense_Cash_Flow_Step.Start_Accrual__c;
        ST_PQ_Periodic_Expense_CFS_Wrapper.LastModifiedById		= ST_PQ_Periodic_Expense_Cash_Flow_Step.LastModifiedById;
        ST_PQ_Periodic_Expense_CFS_Wrapper.Num_Pmts				= Integer.valueof(ST_PQ_Periodic_Expense_Cash_Flow_Step.Num_Pmts__c);
        ST_PQ_Periodic_Expense_CFS_Wrapper.Period               = ST_PQ_Periodic_Expense_Cash_Flow_Step.Period__c;
        ST_PQ_Periodic_Expense_CFS_Wrapper.Periodic_Expense     = ST_PQ_Periodic_Expense_Cash_Flow_Step.Periodic_Expense__c;
        ST_PQ_Periodic_Expense_CFS_Wrapper.Name        			= ST_PQ_Periodic_Expense_Cash_Flow_Step.Name;
        ST_PQ_Periodic_Expense_CFS_Wrapper.Rate         		= ST_PQ_Periodic_Expense_Cash_Flow_Step.Rate__c;
        ST_PQ_Periodic_Expense_CFS_Wrapper.Step           		= ST_PQ_Periodic_Expense_Cash_Flow_Step.Step__c;
        ST_PQ_Periodic_Expense_CFS_Wrapper.Timing        		= ST_PQ_Periodic_Expense_Cash_Flow_Step.Timing__c;
        ST_PQ_Periodic_Expense_CFS_Wrapper.End_Accrual       	= ST_PQ_Periodic_Expense_Cash_Flow_Step.End_Accrual__c;
        ST_PQ_Periodic_Expense_CFS_Wrapper.Type       	= ST_PQ_Periodic_Expense_Cash_Flow_Step.Type__c;
                ST_PQ_Periodic_Expense_CFS_Wrapper.Step = Integer.valueof(ST_PQ_Periodic_Expense_Cash_Flow_Step.Step__c);
        	list_ST_PQ_Periodic_Expense_CFS_Wrapper.add(ST_PQ_Periodic_Expense_CFS_Wrapper);        
            
        }
        return list_ST_PQ_Periodic_Expense_CFS_Wrapper;
        
    }

}