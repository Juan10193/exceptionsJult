public class Takedown_CA_VS_ST_Wrapper_cls {
    public class CA_VS_ST_Wrapper {
        @AuraEnabled
        public CA_Wrapper cA_Wrapper		{get;set;}
        @AuraEnabled
        public ST_Wrapper sT_Wrapper		{get;set;}
    }
    public class CA_Wrapper{
        @AuraEnabled
    	public string creditApprovalName 	{get;set;}
        @AuraEnabled
        public id creditApprovalId 			{get;set;}
        @AuraEnabled
        public string pricingName 			{get;set;}
        @AuraEnabled
        public id pricingId 				{get;set;}    
    }
    public class ST_Wrapper{
        @AuraEnabled
        public string pricingName 			{get;set;} 
        @AuraEnabled
        public id pricingcreditApprovalId 	{get;set;}    
    }
}