public class ST_PQ_Perio_Inco_Parse_cls {
    /**
    * @description 
    * @author eduardo.villegas@engeniumcapital.com | 10/10/2019 
    * @param ST_PQ_Periodic_Expense__c Periodic_Expense 
    * @return ST_PQ_Periodic_Expense_Wrapper_cls.query_All_Fields 
    **/
    public static ST_PQ_Periodic_Income_Wrapper_cls.query_All_Fields dropDataIntoWrapper(ST_PQ_Periodic_Income__c ST_PQ_Periodic_Income){
        ST_PQ_Periodic_Income_Wrapper_cls.query_All_Fields ST_PQ_Periodic_Income_Wrapper = new ST_PQ_Periodic_Income_Wrapper_cls.query_All_Fields();
        ST_PQ_Periodic_Income_Wrapper.recordID             = ST_PQ_Periodic_Income.id;
        ST_PQ_Periodic_Income_Wrapper.Active      			= ST_PQ_Periodic_Income.Active__c;
        ST_PQ_Periodic_Income_Wrapper.Average_Payment    	= ST_PQ_Periodic_Income.Average_Payment__c;
        ST_PQ_Periodic_Income_Wrapper.CreatedById          = ST_PQ_Periodic_Income.CreatedById;
        ST_PQ_Periodic_Income_Wrapper.CurrencyIsoCode      = ST_PQ_Periodic_Income.CurrencyIsoCode;
        ST_PQ_Periodic_Income_Wrapper.Description        	= ST_PQ_Periodic_Income.Description__c;
        ST_PQ_Periodic_Income_Wrapper.LastModifiedById		= ST_PQ_Periodic_Income.LastModifiedById;
        ST_PQ_Periodic_Income_Wrapper.Num_Payments			= Integer.valueof(ST_PQ_Periodic_Income.Num_Payments__c);
        ST_PQ_Periodic_Income_Wrapper.Name               	= ST_PQ_Periodic_Income.Name;
        ST_PQ_Periodic_Income_Wrapper.Periodicity     		= ST_PQ_Periodic_Income.Periodicity__c;
        ST_PQ_Periodic_Income_Wrapper.stExternalID        	= ST_PQ_Periodic_Income.stExternalID__c;
        ST_PQ_Periodic_Income_Wrapper.Start_Date         	= ST_PQ_Periodic_Income.Start_Date__c;
        ST_PQ_Periodic_Income_Wrapper.Pricing_Quote        = ST_PQ_Periodic_Income.Pricing_Quote__c;
        ST_PQ_Periodic_Income_Wrapper.ST_PQ_Periodic_Income_CFS_Wrapper	= getlist_ST_PQ_Periodic_Income_CFS_Wrapper(ST_PQ_Periodic_Income.Periodic_Income_Cashflow_Steps__r);
        
        return ST_PQ_Periodic_Income_Wrapper;
        
    }
    /**
    * @description 
    * @author eduardo.villegas@engeniumcapital.com | 10/10/2019 
    * @param list<ST_PQ_Periodic_Expense_Cash_Flow_Step__c> list_ST_PQ_Periodic_Expense_Cash_Flow_Step 
    * @return List<ST_PQ_Periodic_Expense_CFS_Wrapper_cls.query_All_Fields> 
    **/
    public static List<ST_PQ_Periodic_Income_CFS_Wrapper_cls.query_All_Fields> getlist_ST_PQ_Periodic_Income_CFS_Wrapper(list<ST_PQ_Periodic_Income_Cash_Flow_Step__c> list_ST_PQ_Periodic_Income_Cash_Flow_Step){
    	List<ST_PQ_Periodic_Income_CFS_Wrapper_cls.query_All_Fields> list_ST_PQ_Periodic_Income_CFS_Wrapper = new List<ST_PQ_Periodic_Income_CFS_Wrapper_cls.query_All_Fields>();
        for(ST_PQ_Periodic_Income_Cash_Flow_Step__c ST_PQ_Periodic_Income_Cash_Flow_Step : list_ST_PQ_Periodic_Income_Cash_Flow_Step){
            ST_PQ_Periodic_Income_CFS_Wrapper_cls.query_All_Fields ST_PQ_Periodic_Income_CFS_Wrapper = new ST_PQ_Periodic_Income_CFS_Wrapper_cls.query_All_Fields();
        ST_PQ_Periodic_Income_CFS_Wrapper.recordID             	= ST_PQ_Periodic_Income_Cash_Flow_Step.id;
        ST_PQ_Periodic_Income_CFS_Wrapper.Amount      			= ST_PQ_Periodic_Income_Cash_Flow_Step.Amount__c;
        ST_PQ_Periodic_Income_CFS_Wrapper.Balance    			= ST_PQ_Periodic_Income_Cash_Flow_Step.Balance__c;
        ST_PQ_Periodic_Income_CFS_Wrapper.CreatedById          	= ST_PQ_Periodic_Income_Cash_Flow_Step.CreatedById;
        ST_PQ_Periodic_Income_CFS_Wrapper.CurrencyIsoCode      	= ST_PQ_Periodic_Income_Cash_Flow_Step.CurrencyIsoCode;
        ST_PQ_Periodic_Income_CFS_Wrapper.Start_Accrual        	= ST_PQ_Periodic_Income_Cash_Flow_Step.Start_Accrual__c;
        ST_PQ_Periodic_Income_CFS_Wrapper.LastModifiedById		= ST_PQ_Periodic_Income_Cash_Flow_Step.LastModifiedById;
        ST_PQ_Periodic_Income_CFS_Wrapper.Num_Pmts				= Integer.valueof(ST_PQ_Periodic_Income_Cash_Flow_Step.Num_Pmts__c);
        ST_PQ_Periodic_Income_CFS_Wrapper.Period               	= ST_PQ_Periodic_Income_Cash_Flow_Step.Period__c;
        ST_PQ_Periodic_Income_CFS_Wrapper.Periodic_Income     	= ST_PQ_Periodic_Income_Cash_Flow_Step.Periodic_Income__c;
        ST_PQ_Periodic_Income_CFS_Wrapper.Name        			= ST_PQ_Periodic_Income_Cash_Flow_Step.Name;
        ST_PQ_Periodic_Income_CFS_Wrapper.Rate         			= ST_PQ_Periodic_Income_Cash_Flow_Step.Rate__c;
        ST_PQ_Periodic_Income_CFS_Wrapper.Step           		= ST_PQ_Periodic_Income_Cash_Flow_Step.Step__c;
        ST_PQ_Periodic_Income_CFS_Wrapper.Timing        		= ST_PQ_Periodic_Income_Cash_Flow_Step.Timing__c;
        ST_PQ_Periodic_Income_CFS_Wrapper.End_Accrual       	= ST_PQ_Periodic_Income_Cash_Flow_Step.End_Accrual__c;
        ST_PQ_Periodic_Income_CFS_Wrapper.Type       			= ST_PQ_Periodic_Income_Cash_Flow_Step.Type__c;
                ST_PQ_Periodic_Income_CFS_Wrapper.Step = Integer.valueof(ST_PQ_Periodic_Income_Cash_Flow_Step.Step__c);
        	list_ST_PQ_Periodic_Income_CFS_Wrapper.add(ST_PQ_Periodic_Income_CFS_Wrapper);        
            
        }
        return list_ST_PQ_Periodic_Income_CFS_Wrapper;
        
    }

}