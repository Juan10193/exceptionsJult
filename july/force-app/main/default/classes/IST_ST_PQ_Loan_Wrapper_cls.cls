/**
 * @File Name          : IST_ST_PQ_Loan_Wrapper_cls.cls
 * @Description        : 
 * @Author             : eduardo.villegas@engeniumcapital.com
 * @Group              : 
 * @Last Modified By   : eduardo.villegas@engeniumcapital.com
 * @Last Modified On   : 8/10/2019 15:40:03
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    7/10/2019   eduardo.villegas@engeniumcapital.com     Initial Version
**/
public class IST_ST_PQ_Loan_Wrapper_cls {
    public class query_All_Fields{
        //DataType: id
        @AuraEnabled
        public id recordID                      {get;set;}
        
        //DataType: Currency(12, 2)
        @AuraEnabled
        public double IST_Advance_Payment       {get;set;}
        
        //DataType: Number(5, 0)
        @AuraEnabled
        public integer IST_Calculation_Index    {get;set;}
        
        //DataType: Lookup(User)
        @AuraEnabled
        public id CreatedById                   {get;set;}
        
        //DataType: Picklist
        @AuraEnabled
        public string CurrencyIsoCode           {get;set;}
        
        //DataType: Text(50)
        @AuraEnabled
        public string IST_Description           {get;set;}
        
        //DataType: Lookup(User)
        @AuraEnabled
        public id LastModifiedById              {get;set;}
        
        //DataType: Auto Number
        @AuraEnabled
        public string Name                      {get;set;}
        
        //DataType: Roll-Up Summary (MAX Loan Cash Flow Step)
        @AuraEnabled
        public double Loan_Rate                 {get;set;}
        
        //DataType: Number(3, 0)
        @AuraEnabled
        public integer IST_Num_Payments         {get;set;}
        
        //DataType: Master-Detail(SuperTRUMP Pricing Quote)
        @AuraEnabled
        public id IST_Pricing_Quote             {get;set;}
        
        //DataType: Text(255) (External ID)
        @AuraEnabled
        public string IST_stExternalID          {get;set;}
        
        //DataType: Date
        @AuraEnabled
        public date IST_Start_Date              {get;set;}
        
        //DataType: Currency(12, 2)
        @AuraEnabled
        public double IST_Total_Funding         {get;set;}
        
        //DataType: Currency(12, 2)
        @AuraEnabled
        public double IST_Total_Payments        {get;set;}
        
        //DataType: Relationship child to parent 
        @AuraEnabled
        public List<ST_PQ_Loan_ASS_Wrapper_cls.query_All_Fields> list_ST_PQ_Loan_ASS_Wrapper {get;set;}
        
        //DataType: Relationship child to parent 
        @AuraEnabled
        public List<ST_PQ_Loan_CFS_Wrapper_cls.query_All_Fields> list_ST_PQ_Loan_CFS_Wrapper {get;set;}
        
        
        
    }
	

}