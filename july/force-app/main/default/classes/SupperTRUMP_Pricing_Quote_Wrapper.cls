/**
 * @File Name          : SupperTRUMP_Pricing_Quote_Wrapper.cls
 * @Description        : 
 * @Author             : eduardo.villegas@engeniumcapital.com
 * @Group              : 
 * @Last Modified By   : eduardo.amiens@outlook.com
 * @Last Modified On   : 10-14-2020
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    26/9/2019   eduardo.villegas@engeniumcapital.com     Initial Version
**/
public without sharing class SupperTRUMP_Pricing_Quote_Wrapper {
	public class query_All_Fields{
        
        //DataType: Date
        @AuraEnabled
        public Datetime LastModifiedDate {get;set;}

        //DataType: record id
        @AuraEnabled
        public id recordID {get;set;}
        
        //DataType: Roll-Up Summary (MAX Periodic Income)
        @AuraEnabled
        public Double Of_Insurance_Payments {get;set;}
        
        //DataType: Roll-Up Summary (SUM Rent)
        @AuraEnabled
        public Double Of_Payments {get;set;}
        
        //DataType: Roll-Up Summary (SUM Loan)
        @AuraEnabled
        public Double Of_Payments_Loan {get;set;}
        
        //DataType: Number(18, 0)
        @AuraEnabled
        public Double ProposalToGo_Use_Count {get;set;}

        //DataType: Number(18, 0)
        @AuraEnabled
        public Double ProposalToGo_With_Insurance_Use_Count {get;set;}

		//DataType: Number(18, 0) 
        @AuraEnabled
        public Double QuoteToGo_Use_Count {get;set;}

        //DataType: Number(18, 0)
        @AuraEnabled
        public Double QuoteToGo_With_Insurance_Use_Count {get;set;}

    	//DataType: Formula (Currency)
        @AuraEnabled
        public Double Additional_Rent {get;set;}

		//DataType: Roll-Up Summary (SUM Loan) 
        @AuraEnabled       
        public Double Advance_Payment_Loan {get;set;}

        //DataType: Roll-Up Summary (SUM Rent)
        @AuraEnabled
        public Double Advance_Payments {get;set;}

        //DataType: Currency(12, 2)
        @AuraEnabled
        public Double TotalBookANI {get;set;}

        //DataType: Text
        @AuraEnabled
        public String Apoderado_1 {get;set;}

        //DataType: Text
        @AuraEnabled
        public String Apoderado_2 {get;set;}

        //DataType: Number(6, 4)
        @AuraEnabled
        public Double Average_Life_of_Asset_years {get;set;}

        //DataType: Number(12, 2)
        @AuraEnabled
        public Double IST_Balloon {get;set;}

        //DataType: Percent(14, 4)
        @AuraEnabled
        public Double BookYield {get;set;}

        //DataType: Formula (Text)
        @AuraEnabled
        public String Cla_sula_Tasa_Variable_No_Aplica_en_Fij {get;set;}

		//DataType: Formula (Text)
        @AuraEnabled
        public String Cl_usula_Tasa_Efectiva_Variable {get;set;}

        //DataType: Date
        @AuraEnabled
        public Date IST_Commencement {get;set;}

        //DataType: Number(12,2)
        @AuraEnabled
        public Double Contributed_Value {get;set;}

        //DataType: Currency(12,2)
        @AuraEnabled
        public double IST_Cost {get;set;}

        //DataType: Percent(14,4)
        @AuraEnabled
        public double Cost_of_Funds_Levered {get;set;}

        //DataType: Percent(14,4)
        @AuraEnabled
        public double Cost_of_Funds_Unlevered {get;set;}

        //DataType: LookUp(user)
        @AuraEnabled
        public id CreatedById {get;set;}

        //DataType: checkBox
        @AuraEnabled
        public boolean created_in_SF {get;set;}

        //DataType: CurrencyIsoCode
        @AuraEnabled
        public String CurrencyIsoCode {get;set;}

        //DataType: Formula (Text)
        @AuraEnabled
        public String Customer_Name {get;set;}

        //DataType: Checkbox
        @AuraEnabled
        public boolean IST_Is_Synchronized {get;set;}

        //DataType: Date
        @AuraEnabled
        public date IST_Delivery_Date {get;set;}

        //DataType: Number(12,2)
        @AuraEnabled
        public double Depreciation {get;set;}

        //DataType: Roll-Up Summary (MAX EBO)
        @AuraEnabled
        public double EBO {get;set;}

        //DataType: Checkbox
        @AuraEnabled
        public boolean EBO_Active {get;set;}

        //DataType: Percent(14, 4)
        @AuraEnabled
        public double Economic_ROE {get;set;}

        //DataType: Percent(12, 4)
        @AuraEnabled        
        public double Economic_ROI {get;set;}

        //DataType: Percent(14, 4)
        @AuraEnabled        
        public double Economic_Yield {get;set;}

        //DataType: Formula (Text)
        @AuraEnabled        
        public String Engenium_Legal_Entity {get;set;}

        //DataType: Formula (Number)
        @AuraEnabled        
        public Double Exchange_Rate {get;set;}

        //DataType: Percent(14, 4)
        @AuraEnabled        
        public Double Expense_ANI {get;set;}

        //DataType: Formula (Date)
        @AuraEnabled        
        public Date Fecha_Pago_Interes_Interino {get;set;}

        //DataType: Formula (Date)
        @AuraEnabled        	
        public Date Fecha_pago_renta_vencida_anticipada {get;set;}

        //DataType: Percent(14, 4)
        @AuraEnabled
        public Double Finance_Margin {get;set;}

        //DataType: Text(50)
        @AuraEnabled
        public String IST_FinanceType {get;set;}

        //DataType: Roll-Up Summary (MAX Periodic Income)
        @AuraEnabled
        public Double Fines_Monitoring_Fee_Income {get;set;}

        //DataType: Percent(14, 4)
        @AuraEnabled
        public Double Full_Term_Rate {get;set;}

        //DataType: Percent(14, 4)
        @AuraEnabled
        public Double FulltermRatewithresidual {get;set;}

        //DataType: Percent(6, 4)
        @AuraEnabled
        public Double Gross_Margin {get;set;}

        //DataType: Roll-Up Summary (SUM Income Fee)
        @AuraEnabled
        public Double Import_Services_Fee {get;set;}
        //DataType: Roll-Up Summary (MAX Periodic Income)
        @AuraEnabled
        public Double Insurance_Policy_Issuing_Cost {get;set;}
        //DataType: Roll-Up Summary (MAX Periodic Income)
        @AuraEnabled
        public Double Insurance_Policy_Rebate {get;set;}

        //DataType: Roll-Up Summary (MAX Periodic Income)
        @AuraEnabled
        public Double Insurance_Rate {get;set;}

        //DataType: Formula (Percent)
        @AuraEnabled
        public Double Insurance_Rebate_UDI {get;set;}

        //DataType: Percent(6, 4)
        @AuraEnabled
        public Double IST_IRR_NPT {get;set;}

        //DataType: Lookup(User)
        @AuraEnabled
        public Id LastModifiedById {get;set;}

        //DataType: Checkbox
        @AuraEnabled
        public boolean Proposal_With_Insurance {get;set;}

        //DataType: Checkbox
        @AuraEnabled
        public boolean Quote_With_Insurance {get;set;}

        //DataType: Formula (Percent)
        @AuraEnabled
        public Double Lease_Rate_Percentage {get;set;}

        //DataType: Percent(6, 4)
        @AuraEnabled
        public double IST_Lending_Rate {get;set;}

        //DataType: Text(50)
        @AuraEnabled
        public String IST_LessorFAS {get;set;}

        //DataType: Percent(12, 4)
        @AuraEnabled
        public Double Leverage {get;set;}

        //DataType: Roll-Up Summary (MAX Loan)
        @AuraEnabled
        public double Loan_Rate {get;set;}

        //DataType: Percent(14, 4)
        @AuraEnabled
        public double LossANI {get;set;}

        //DataType: Roll-Up Summary (MAX Periodic Expense)
        @AuraEnabled
        public double Maintenance_Cost_Expense {get;set;}

        //DataType: Roll-Up Summary (MAX Periodic Income)
        @AuraEnabled
        public double Maintenance_Cost_With_Markup {get;set;}

        //DataType: Roll-Up Summary (MAX Periodic Income)
        @AuraEnabled
        public double Maintenance_Fee {get;set;}

        //DataType: Formula (Percent)
        @AuraEnabled
        public double Maintenance_Markup {get;set;}

        //DataType: Text(3)
        @AuraEnabled
        public String MC_Currency {get;set;}

        //DataType: Percent(6, 4)
        @AuraEnabled
        public Double IST_MISF_NAT {get;set;}

        //DataType: Text(10)
        @AuraEnabled
        public String IST_Mode {get;set;}

        //DataType: Formula (Text)
        @AuraEnabled
        public String Moneda {get;set;}

        //DataType: Date
        @AuraEnabled
        public Date MoneyCostDateFound {get;set;}

        //DataType: Number(16, 2)
        @AuraEnabled
        public Double Net_Income {get;set;}

        //DataType: Number(16, 2)
        @AuraEnabled
        public Double Net_Income_Eco {get;set;}

        //DataType: Roll-Up Summary (SUM Income Fee)
        @AuraEnabled	
        public Double Opening_Fee {get;set;}

        //DataType: Formula (Currency)	
        @AuraEnabled
        public Double Opening_Fee_Amount {get;set;}

        //DataType: Lookup(Opportunity)	
        @AuraEnabled
        public id IST_Opportunity {get;set;}

        //DataType: Formula (Text)
        @AuraEnabled		
        public String Opportunity_Collateral {get;set;}

        //DataType: Lookup(User,Group)
        @AuraEnabled
        public id OwnerId {get;set;}

        //DataType: Currency(12, 2)
        @AuraEnabled
        public double IST_Payment {get;set;}

        //DataType: Text(50)
        @AuraEnabled
        public String Payment_Timing {get;set;}

        //DataType: Formula (Text)
        @AuraEnabled
        public String Periodicidad_mensual_trimestral {get;set;}

        //DataType: Formula (Text)
        @AuraEnabled
        public String Periodicidad_mensuales_trimestrales {get;set;}

   		//DataType: Formula (Text)
        @AuraEnabled
   		public String Periodicidad_mes_trimestre {get;set;}

   		//DataType: Formula (Text)
        @AuraEnabled
        public String Periodicidad_meses_trimestres {get;set;}

        //DataType: Text(50)
        @AuraEnabled
        public String IST_Periodicity {get;set;}

        //DataType: Formula (Text)
        @AuraEnabled
        public String Plazo_en_texto {get;set;}

        //DataType: Formula (Date)
        @AuraEnabled	
        public Date PQ_Validity_for_Fleet_Date {get;set;}

        //DataType: Auto Number
        @AuraEnabled
        public String Name {get;set;}

        //DataType: Text(100)
        @AuraEnabled
        public String Product {get;set;}

        //DataType: Formula (Text)
        @AuraEnabled
        public String Product_Name {get;set;}

        //DataType: Text(50)
        @AuraEnabled
        public String Purchase_Option_Method {get;set;}

        //DataType: Text(60)
        @AuraEnabled
        public String IST_Description {get;set;}

        //DataType: Picklist
        @AuraEnabled
        public String IST_QuoteStatus {get;set;}

        //DataType: Roll-Up Summary (MAX Income Fee)
        @AuraEnabled	
        public Double Rapid_Tag_Emission_Control {get;set;}

        //DataType: Roll-Up Summary (MAX Income Fee)
        @AuraEnabled
        public Double Rapid_Tag_Plates {get;set;}

        //DataType: Roll-Up Summary (SUM Income Fee)
        @AuraEnabled
        public Double Rapid_Tag_Fee {get;set;}

        //DataType: Roll-Up Summary (MAX Periodic Income)
        @AuraEnabled
        public Double Rapid_Tag_Policy_Income {get;set;}

        //DataType: Text(100)
        @AuraEnabled
        public String Rate_Type {get;set;}

        //DataType: Record Type	
        @AuraEnabled
        public id RecordTypeId {get;set;}

        //DataType: Roll-Up Summary (SUM Expense Fee)
        @AuraEnabled
        public Double Referral_Fee {get;set;}

        //DataType: Percent(6, 4)
        @AuraEnabled
        public Double IST_Rent_IBR {get;set;}

        //DataType: Currency(16, 2)
        @AuraEnabled
        public Double IST_Residual {get;set;}

        //DataType: Text(50)
        @AuraEnabled
        public String Residual_Guarantee_Type {get;set;}

        //DataType: Roll-Up Summary (MAX Asset)
        @AuraEnabled
        public Double Residual_Value {get;set;}

        //DataType: Currency(12, 2)
        @AuraEnabled
        public Double Security_Deposit {get;set;}

        //DataType: Formula (Percent)
        @AuraEnabled
        public Double Security_Deposit_Percentage {get;set;}

        //DataType: Text(50)
        @AuraEnabled
        public String Security_Deposit_Method {get;set;}

        //DataType: Text(255)
        @AuraEnabled
        public String IST_stExternalID {get;set;}

        //DataType: Date
        @AuraEnabled
        public Date IST_Takedown {get;set;}

        //DataType: Roll-Up Summary (MAX Periodic Income)
        @AuraEnabled
        public Double Telematics_Fee_Income {get;set;}

        //DataType: Lookup(SuperTRUMP Template)
        @AuraEnabled
        public id IST_Template {get;set;}

        //DataType: Lookup(SuperTRUMP Template Name)
        @AuraEnabled
        public string IST_TemplateName {get;set;}

        //DataType: Number(5, 0)
        @AuraEnabled
        public Double IST_Term {get;set;}

        //DataType: Formula (Text)
        @AuraEnabled
        public String Tipo_de_Moneda {get;set;}

        //DataType: Formula (Text)
        @AuraEnabled
        public String Tipo_de_pago {get;set;}

        //DataType: Roll-Up Summary (MAX Periodic Income)
        @AuraEnabled
        public Double Total_Insurance_Cost {get;set;}

        //DataType: Currency(12, 2)
        @AuraEnabled
        public Double IST_Total_Lending {get;set;}

        //DataType: Currency(12, 2)
        @AuraEnabled
        public Double Total_Purchase_Option_Fixed_Amount {get;set;}

        //DataType: Currency(12, 2)
        @AuraEnabled
        public Double Total_Residual_Guaranteed_Amount {get;set;}

        //DataType: Percent(4, 4)
        @AuraEnabled
        public Double Total_Residual_Guaranteed_Percent {get;set;}

        //DataType: Currency(12, 2)
        @AuraEnabled
        public Double Total_Residual_Unguaranteed_Amount {get;set;}

        //DataType: Percent(4, 4)
        @AuraEnabled
        public Double Total_Residual_Unguaranteed_Percent {get;set;}

        //DataType: Currency(12, 2)
        @AuraEnabled
        public Double Total_Security_Deposit {get;set;}



        //Number(18, 0)	
        @AuraEnabled
        public double WOA_nu_Term_in_months_without_PP {get;set;}

        //Number(18, 0)
        @AuraEnabled
        public double WOA_nu_Term_in_Months_Including_PP {get;set;}

        //Number(18, 0)
        @AuraEnabled
        public double WOA_nu_Progress_Payments_M {get;set;}

        //Long Text Area(32768)
        @AuraEnabled
        public string WOA_tl_Progress_Description {get;set;}

        //Number(18, 0)
        @AuraEnabled
        public double WOA_nu_Grace_Period_M {get;set;}

        //Picklist
        @AuraEnabled
        public string WOA_ls_Type_of_Grace_Period {get;set;}

        //Picklist
        @AuraEnabled
        public string WOA_ls_Low_High_High_Low {get;set;}

        //Long Text Area(32768)
        @AuraEnabled
        public string WOA_tl_Low_High_High_Low_Description {get;set;}

        //Percent(12, 4)
        @AuraEnabled
        public double WOA_pr_Advance_Payment {get;set;}

        //Picklist
        @AuraEnabled
        public string WOA_ls_EFA {get;set;}

        //Picklist
        @AuraEnabled
        public string WOA_ls_Used_New {get;set;}

        //Picklist
        @AuraEnabled
        public string WOA_ls_SL_B_YES_NO {get;set;}

        //Picklist
        @AuraEnabled
        public string WOA_ls_EBO {get;set;}

        //Long Text Area(32768)
        @AuraEnabled
        public string WOA_tl_EBO_Description {get;set;}

        //Long Text Area(32768)
        @AuraEnabled
        public string WOA_tl_Asset_description {get;set;}

        //Long Text Area(32768)
        @AuraEnabled
        public string WOA_tl_Return_Condition {get;set;}

        //Percent(12, 4)
        @AuraEnabled
        public double WOA_pr_Remarketing_Fee {get;set;}

        //Percent(12, 4)
        @AuraEnabled
        public double WOA_pr_Split_Trac {get;set;}

        //Percent(14, 4)
        @AuraEnabled
        public double WOA_pr_Lock_Fee {get;set;}

        //Text(255)
        @AuraEnabled
        public string WOA_tx_Boot_Collateral_Type {get;set;}

        //Long Text Area(32768)
        @AuraEnabled
        public string WOA_tl_EOL_Option {get;set;}

        //Picklist
        @AuraEnabled
        public string WOA_ls_Prom_Note {get;set;}

        //Picklist
        @AuraEnabled
        public string WOA_ls_Carga_Peligrosa {get;set;}

        //Picklist
        @AuraEnabled
        public string WOA_ls_Cash_Collateral {get;set;}

        //Picklist
        @AuraEnabled
        public string WOA_ls_Cross_Collateral {get;set;}

        //Picklist
        @AuraEnabled
        public string WOA_ls_Direct_Debit {get;set;}

        //Number(12, 4)
        @AuraEnabled
        public double WOA_nu_ROI_No_Insurance {get;set;}

        //Percent(16, 2)
        @AuraEnabled
        public double WOA_pr_Opening_Fee {get;set;}

        //Currency(16, 2)
        @AuraEnabled
        public double WOA_dv_Security_Deposit {get;set;}

        //Percent(14, 4)
        @AuraEnabled
        public double WOA_pr_Security_Deposit {get;set;}

        //Text Area(255)
        @AuraEnabled
        public string WOA_at_Security_Deposit_Comments {get;set;}

        //Percent(14, 4)	
        @AuraEnabled
        public double WOA_pr_Rate {get;set;}

        //Percent(14, 4)
        @AuraEnabled
        public double WOA_pr_RV {get;set;}

        //Currency(16, 2)
        @AuraEnabled
        public double WOA_dv_Ballon_Bullet_Payment {get;set;}

        //Percent(14, 4)	
        @AuraEnabled
        public double WOA_pr_P_Option {get;set;}


        
        /***** Objetos relacionados ***/
        
        @AuraEnabled 
        public List<IST_SP_PQ_Expense_Fee_Wrapper_cls.query_All_Fields> list_SP_PQ_Expense_Fee_Wrapper {get;set;}
        
        @AuraEnabled 
        public List<IST_ST_PQ_Income_Fee_Wrapper_cls.query_All_Fields> list_IST_ST_PQ_Income_Fee_Wrapper {get;set;}
        
        @AuraEnabled 
        public List<IST_ST_PQ_Loan_Wrapper_cls.query_All_Fields> list_IST_ST_PQ_Loan_Wrapper {get;set;}
        
        @AuraEnabled
        public List<IST_ST_PQ_Rent_Wrapper_cls.query_All_Fields> list_IST_ST_PQ_Rent_Wrapper {get;set;}
        
        @AuraEnabled
        public List<ST_PQ_Periodic_Expense_Wrapper_cls.query_All_Fields> list_ST_PQ_Periodic_Expense_Wrapper {get;set;}        
            
        @AuraEnabled
        public List<ST_PQ_Periodic_Income_Wrapper_cls.query_All_Fields> list_ST_PQ_Periodic_Income_Wrapper {get;set;}
        
        @AuraEnabled
        public List<ST_PQ_SSDeposit_Wrapper_cls.query_All_Fields> list_ST_PQ_SSDeposit_Wrapper {get;set;} 
        
        @AuraEnabled
        public List<ST_PQ_TV_Schedule_Step_Wrapper_cls.query_All_Fields> list_ST_PQ_TV_Schedule_Step_Wrapper {get;set;}
        
        @AuraEnabled
        public List<ST_PQ_EBO_Wrapper_cls.query_All_Fields> list_ST_PQ_EBO_Wrapper {get;set;}

    }
}