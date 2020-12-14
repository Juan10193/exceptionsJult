/**
 * @File Name          : SupperTRUMP_Parse_Pricing_Quote_cls.cls
 * @Description        : 
 * @Author             : eduardo.villegas@engeniumcapital.com
 * @Group              : 
 * @Last Modified By   : eduardo.amiens@outlook.com
 * @Last Modified On   : 10-14-2020
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    9/10/2019   eduardo.villegas@engeniumcapital.com     Initial Version
**/
public class SupperTRUMP_Parse_Pricing_Quote_cls { 
    
    /**
    * @description 
    * @author eduardo.villegas@engeniumcapital.com | 7/10/2019 
    * @param IST__SuperTRUMP_Pricing_Quote__c IST_SuperTRUMP_Pricing_Quote 
    * @return SupperTRUMP_Pricing_Quote_Wrapper.query_All_Fields 
    **/
    public static SupperTRUMP_Pricing_Quote_Wrapper.query_All_Fields dropDataIntoWrapper(IST__SuperTRUMP_Pricing_Quote__c IST_SuperTRUMP_Pricing_Quote){
    	SupperTRUMP_Pricing_Quote_Wrapper.query_All_Fields Pricing_Quote_Wrapper = new SupperTRUMP_Pricing_Quote_Wrapper.query_All_Fields();     
        Pricing_Quote_Wrapper.LastModifiedDate						= IST_SuperTRUMP_Pricing_Quote.LastModifiedDate;
        Pricing_Quote_Wrapper.recordID								= IST_SuperTRUMP_Pricing_Quote.id;
        Pricing_Quote_Wrapper.Of_Insurance_Payments                 = IST_SuperTRUMP_Pricing_Quote.Of_Insurance_Payments__c;
        Pricing_Quote_Wrapper.Of_Payments                           = IST_SuperTRUMP_Pricing_Quote.Of_Payments__c;
        Pricing_Quote_Wrapper.Of_Payments_Loan                      = IST_SuperTRUMP_Pricing_Quote.Of_Payments_Loan__c;
        Pricing_Quote_Wrapper.ProposalToGo_Use_Count                = IST_SuperTRUMP_Pricing_Quote.ProposalToGo_Use_Count__c;
        Pricing_Quote_Wrapper.ProposalToGo_With_Insurance_Use_Count = IST_SuperTRUMP_Pricing_Quote.ProposalToGo_With_Insurance_Use_Count__c;
        Pricing_Quote_Wrapper.QuoteToGo_Use_Count                   = IST_SuperTRUMP_Pricing_Quote.QuoteToGo_Use_Count__c;
        Pricing_Quote_Wrapper.QuoteToGo_With_Insurance_Use_Count    = IST_SuperTRUMP_Pricing_Quote.QuoteToGo_With_Insurance_Use_Count__c;
        Pricing_Quote_Wrapper.Additional_Rent                       = IST_SuperTRUMP_Pricing_Quote.Additional_Rent__c;
        Pricing_Quote_Wrapper.Advance_Payment_Loan                  = IST_SuperTRUMP_Pricing_Quote.Advance_Payment_Loan__c;
        Pricing_Quote_Wrapper.Advance_Payments                      = IST_SuperTRUMP_Pricing_Quote.Advance_Payments__c;
        Pricing_Quote_Wrapper.TotalBookANI                          = IST_SuperTRUMP_Pricing_Quote.TotalBookANI__c;
        Pricing_Quote_Wrapper.Apoderado_1                           = IST_SuperTRUMP_Pricing_Quote.Apoderado_1__c;
        Pricing_Quote_Wrapper.Apoderado_2                           = IST_SuperTRUMP_Pricing_Quote.Apoderado_2__c;
        Pricing_Quote_Wrapper.Average_Life_of_Asset_years           = IST_SuperTRUMP_Pricing_Quote.Average_Life_of_Asset_years__c;
        Pricing_Quote_Wrapper.IST_Balloon                           = IST_SuperTRUMP_Pricing_Quote.IST__Balloon__c;
        Pricing_Quote_Wrapper.BookYield                             = IST_SuperTRUMP_Pricing_Quote.BookYield__c;
        Pricing_Quote_Wrapper.Cla_sula_Tasa_Variable_No_Aplica_en_Fij = IST_SuperTRUMP_Pricing_Quote.Cla_sula_Tasa_Variable_No_Aplica_en_Fij__c;
        Pricing_Quote_Wrapper.Cl_usula_Tasa_Efectiva_Variable       = IST_SuperTRUMP_Pricing_Quote.Cl_usula_Tasa_Efectiva_Variable__c;
        Pricing_Quote_Wrapper.IST_Commencement                      = IST_SuperTRUMP_Pricing_Quote.IST__Commencement__c;
        Pricing_Quote_Wrapper.Contributed_Value                     = IST_SuperTRUMP_Pricing_Quote.Contributed_Value__c;
        Pricing_Quote_Wrapper.IST_Cost                              = IST_SuperTRUMP_Pricing_Quote.IST__Cost__c;
        Pricing_Quote_Wrapper.Cost_of_Funds_Levered                 = IST_SuperTRUMP_Pricing_Quote.Cost_of_Funds_Levered__c;
        Pricing_Quote_Wrapper.Cost_of_Funds_Unlevered               = IST_SuperTRUMP_Pricing_Quote.Cost_of_Funds_Unlevered__c;
        Pricing_Quote_Wrapper.CreatedById                           = IST_SuperTRUMP_Pricing_Quote.CreatedById;
        Pricing_Quote_Wrapper.created_in_SF                         = IST_SuperTRUMP_Pricing_Quote.created_in_SF__c;
        Pricing_Quote_Wrapper.CurrencyIsoCode                       = IST_SuperTRUMP_Pricing_Quote.CurrencyIsoCode;
        Pricing_Quote_Wrapper.Customer_Name                         = IST_SuperTRUMP_Pricing_Quote.Customer_Name__c;
        Pricing_Quote_Wrapper.IST_Is_Synchronized                   = IST_SuperTRUMP_Pricing_Quote.IST__Is_Synchronized__c;
        Pricing_Quote_Wrapper.IST_Delivery_Date                     = IST_SuperTRUMP_Pricing_Quote.IST__Delivery_Date__c;
        Pricing_Quote_Wrapper.Depreciation                          = IST_SuperTRUMP_Pricing_Quote.Depreciation__c;
        Pricing_Quote_Wrapper.EBO                                   = IST_SuperTRUMP_Pricing_Quote.EBO__c;
        Pricing_Quote_Wrapper.EBO_Active                            = IST_SuperTRUMP_Pricing_Quote.EBO_Active__c;
        Pricing_Quote_Wrapper.Economic_ROE                          = IST_SuperTRUMP_Pricing_Quote.Economic_ROE__c;
        Pricing_Quote_Wrapper.Economic_ROI                          = IST_SuperTRUMP_Pricing_Quote.Economic_ROI__c;
        Pricing_Quote_Wrapper.Economic_Yield                        = IST_SuperTRUMP_Pricing_Quote.Economic_Yield__c;
        Pricing_Quote_Wrapper.Engenium_Legal_Entity                 = IST_SuperTRUMP_Pricing_Quote.Engenium_Legal_Entity__c;
        Pricing_Quote_Wrapper.Exchange_Rate                         = IST_SuperTRUMP_Pricing_Quote.Exchange_Rate__c;
        Pricing_Quote_Wrapper.Expense_ANI                           = IST_SuperTRUMP_Pricing_Quote.Expense_ANI__c;
        Pricing_Quote_Wrapper.Fecha_Pago_Interes_Interino           = IST_SuperTRUMP_Pricing_Quote.Fecha_Pago_Interes_Interino__c;
        Pricing_Quote_Wrapper.Fecha_pago_renta_vencida_anticipada   = IST_SuperTRUMP_Pricing_Quote.Fecha_pago_renta_vencida_anticipada__c;
        Pricing_Quote_Wrapper.Finance_Margin                        = IST_SuperTRUMP_Pricing_Quote.Finance_Margin__c;
        Pricing_Quote_Wrapper.IST_FinanceType                       = IST_SuperTRUMP_Pricing_Quote.IST__FinanceType__c;
        Pricing_Quote_Wrapper.Fines_Monitoring_Fee_Income           = IST_SuperTRUMP_Pricing_Quote.Fines_Monitoring_Fee_Income__c;
        Pricing_Quote_Wrapper.Full_Term_Rate                        = IST_SuperTRUMP_Pricing_Quote.Full_Term_Rate__c;
        Pricing_Quote_Wrapper.FulltermRatewithresidual              = IST_SuperTRUMP_Pricing_Quote.FulltermRatewithresidual__c;
        Pricing_Quote_Wrapper.Gross_Margin                          = IST_SuperTRUMP_Pricing_Quote.Gross_Margin__c;
        Pricing_Quote_Wrapper.Import_Services_Fee                   = IST_SuperTRUMP_Pricing_Quote.Import_Services_Fee__c;
        Pricing_Quote_Wrapper.Insurance_Policy_Issuing_Cost         = IST_SuperTRUMP_Pricing_Quote.Insurance_Policy_Issuing_Cost__c;
        Pricing_Quote_Wrapper.Insurance_Policy_Rebate               = IST_SuperTRUMP_Pricing_Quote.Insurance_Policy_Rebate__c;
        Pricing_Quote_Wrapper.Insurance_Rate                        = IST_SuperTRUMP_Pricing_Quote.Insurance_Rate__c;
        Pricing_Quote_Wrapper.Insurance_Rebate_UDI                  = IST_SuperTRUMP_Pricing_Quote.Insurance_Rebate_UDI__c;
        Pricing_Quote_Wrapper.IST_IRR_NPT                           = IST_SuperTRUMP_Pricing_Quote.IST__IRR_NPT__c;
        Pricing_Quote_Wrapper.LastModifiedById                      = IST_SuperTRUMP_Pricing_Quote.LastModifiedById;
        Pricing_Quote_Wrapper.Proposal_With_Insurance               = IST_SuperTRUMP_Pricing_Quote.Proposal_With_Insurance__c;
        Pricing_Quote_Wrapper.Quote_With_Insurance                  = IST_SuperTRUMP_Pricing_Quote.Quote_With_Insurance__c;
        Pricing_Quote_Wrapper.Lease_Rate_Percentage                 = IST_SuperTRUMP_Pricing_Quote.Lease_Rate_Percentage__c;
        Pricing_Quote_Wrapper.IST_Lending_Rate                      = IST_SuperTRUMP_Pricing_Quote.IST__Lending_Rate__c;
        Pricing_Quote_Wrapper.IST_LessorFAS                         = IST_SuperTRUMP_Pricing_Quote.IST__LessorFAS__c;
        Pricing_Quote_Wrapper.Leverage                              = IST_SuperTRUMP_Pricing_Quote.Leverage__c;
        Pricing_Quote_Wrapper.Loan_Rate                             = IST_SuperTRUMP_Pricing_Quote.Loan_Rate__c;
        Pricing_Quote_Wrapper.LossANI                               = IST_SuperTRUMP_Pricing_Quote.LossANI__c;
        Pricing_Quote_Wrapper.Maintenance_Cost_Expense              = IST_SuperTRUMP_Pricing_Quote.Maintenance_Cost_Expense__c;
        Pricing_Quote_Wrapper.Maintenance_Cost_With_Markup          = IST_SuperTRUMP_Pricing_Quote.Maintenance_Cost_With_Markup__c;
        Pricing_Quote_Wrapper.Maintenance_Fee                       = IST_SuperTRUMP_Pricing_Quote.Maintenance_Fee__c;
        Pricing_Quote_Wrapper.Maintenance_Markup                    = IST_SuperTRUMP_Pricing_Quote.Maintenance_Markup__c;
        Pricing_Quote_Wrapper.MC_Currency                           = IST_SuperTRUMP_Pricing_Quote.MC_Currency__c;
        Pricing_Quote_Wrapper.IST_MISF_NAT                          = IST_SuperTRUMP_Pricing_Quote.IST__MISF_NAT__c;
        Pricing_Quote_Wrapper.IST_Mode                              = IST_SuperTRUMP_Pricing_Quote.IST__Mode__c;
        Pricing_Quote_Wrapper.Moneda                                = IST_SuperTRUMP_Pricing_Quote.Moneda__c;
        Pricing_Quote_Wrapper.MoneyCostDateFound                    = IST_SuperTRUMP_Pricing_Quote.MoneyCostDateFound__c;
        Pricing_Quote_Wrapper.Net_Income                            = IST_SuperTRUMP_Pricing_Quote.Net_Income__c;
        Pricing_Quote_Wrapper.Net_Income_Eco                        = IST_SuperTRUMP_Pricing_Quote.Net_Income_Eco__c;
        Pricing_Quote_Wrapper.Opening_Fee                           = IST_SuperTRUMP_Pricing_Quote.Opening_Fee__c;
        Pricing_Quote_Wrapper.Opening_Fee_Amount                    = IST_SuperTRUMP_Pricing_Quote.Opening_Fee_Amount__c;
        Pricing_Quote_Wrapper.IST_Opportunity                       = IST_SuperTRUMP_Pricing_Quote.IST__Opportunity__c;
        Pricing_Quote_Wrapper.Opportunity_Collateral                = IST_SuperTRUMP_Pricing_Quote.Opportunity_Collateral__c;
        Pricing_Quote_Wrapper.OwnerId                               = IST_SuperTRUMP_Pricing_Quote.OwnerId;
        Pricing_Quote_Wrapper.IST_Payment                           = IST_SuperTRUMP_Pricing_Quote.IST__Payment__c;
        Pricing_Quote_Wrapper.Payment_Timing                        = IST_SuperTRUMP_Pricing_Quote.IST__Payment_Timing__c;
        Pricing_Quote_Wrapper.Periodicidad_mensual_trimestral       = IST_SuperTRUMP_Pricing_Quote.Periodicidad_mensual_trimestral__c;
        Pricing_Quote_Wrapper.Periodicidad_mensuales_trimestrales   = IST_SuperTRUMP_Pricing_Quote.Periodicidad_mensuales_trimestrales__c;
        Pricing_Quote_Wrapper.Periodicidad_mes_trimestre            = IST_SuperTRUMP_Pricing_Quote.Periodicidad_mes_trimestre__c;
        Pricing_Quote_Wrapper.Periodicidad_meses_trimestres         = IST_SuperTRUMP_Pricing_Quote.Periodicidad_meses_trimestres__c;
        Pricing_Quote_Wrapper.IST_Periodicity                       = IST_SuperTRUMP_Pricing_Quote.IST__Periodicity__c;
        Pricing_Quote_Wrapper.Plazo_en_texto                        = IST_SuperTRUMP_Pricing_Quote.Plazo_en_texto__c;
        Pricing_Quote_Wrapper.PQ_Validity_for_Fleet_Date            = IST_SuperTRUMP_Pricing_Quote.PQ_Validity_for_Fleet_Date__c;
        Pricing_Quote_Wrapper.Name                                  = IST_SuperTRUMP_Pricing_Quote.Name;
        Pricing_Quote_Wrapper.Product                               = IST_SuperTRUMP_Pricing_Quote.Product__c;
        Pricing_Quote_Wrapper.Product_Name                          = IST_SuperTRUMP_Pricing_Quote.Product_Name__c;
        Pricing_Quote_Wrapper.Purchase_Option_Method                = IST_SuperTRUMP_Pricing_Quote.Purchase_Option_Method__c;
        Pricing_Quote_Wrapper.IST_Description                       = IST_SuperTRUMP_Pricing_Quote.IST__Description__c;
        Pricing_Quote_Wrapper.IST_QuoteStatus                       = IST_SuperTRUMP_Pricing_Quote.IST__QuoteStatus__c;
        Pricing_Quote_Wrapper.Rapid_Tag_Emission_Control            = IST_SuperTRUMP_Pricing_Quote.Rapid_Tag_Emission_Control__c;
        Pricing_Quote_Wrapper.Rapid_Tag_Plates                      = IST_SuperTRUMP_Pricing_Quote.Rapid_Tag_Plates__c;
        Pricing_Quote_Wrapper.Rapid_Tag_Fee                         = IST_SuperTRUMP_Pricing_Quote.Rapid_Tag_Fee__c;
        Pricing_Quote_Wrapper.Rapid_Tag_Policy_Income               = IST_SuperTRUMP_Pricing_Quote.Rapid_Tag_Policy_Income__c;
        Pricing_Quote_Wrapper.Rate_Type                             = IST_SuperTRUMP_Pricing_Quote.Rate_Type__c;
        Pricing_Quote_Wrapper.RecordTypeId                          = IST_SuperTRUMP_Pricing_Quote.RecordTypeId;
        Pricing_Quote_Wrapper.Referral_Fee                          = IST_SuperTRUMP_Pricing_Quote.Referral_Fee__c;
        Pricing_Quote_Wrapper.IST_Rent_IBR                          = IST_SuperTRUMP_Pricing_Quote.IST__Rent_IBR__c;
        Pricing_Quote_Wrapper.IST_Residual                          = IST_SuperTRUMP_Pricing_Quote.IST__Residual__c;
        Pricing_Quote_Wrapper.Residual_Guarantee_Type               = IST_SuperTRUMP_Pricing_Quote.Residual_Guarantee_Type__c;
        Pricing_Quote_Wrapper.Residual_Value                        = IST_SuperTRUMP_Pricing_Quote.Residual_Value__c;
        Pricing_Quote_Wrapper.Security_Deposit                      = IST_SuperTRUMP_Pricing_Quote.Security_Deposit__c;
        Pricing_Quote_Wrapper.Security_Deposit_Percentage           = IST_SuperTRUMP_Pricing_Quote.Security_Deposit_Percentage__c;
        Pricing_Quote_Wrapper.Security_Deposit_Method               = IST_SuperTRUMP_Pricing_Quote.Security_Deposit_Method__c;
        Pricing_Quote_Wrapper.IST_stExternalID                      = IST_SuperTRUMP_Pricing_Quote.IST__stExternalID__c;
        Pricing_Quote_Wrapper.IST_Takedown                          = IST_SuperTRUMP_Pricing_Quote.IST__Takedown__c;
        Pricing_Quote_Wrapper.Telematics_Fee_Income                 = IST_SuperTRUMP_Pricing_Quote.Telematics_Fee_Income__c;
        Pricing_Quote_Wrapper.IST_Template                          = IST_SuperTRUMP_Pricing_Quote.IST__Template__c;
        Pricing_Quote_Wrapper.IST_TemplateName                      = IST_SuperTRUMP_Pricing_Quote.IST__Template__r.Name;
        Pricing_Quote_Wrapper.IST_Term                              = IST_SuperTRUMP_Pricing_Quote.IST__Term__c;
        Pricing_Quote_Wrapper.Tipo_de_Moneda                        = IST_SuperTRUMP_Pricing_Quote.Tipo_de_Moneda__c;
        Pricing_Quote_Wrapper.Tipo_de_pago                          = IST_SuperTRUMP_Pricing_Quote.Tipo_de_pago__c;
        Pricing_Quote_Wrapper.Total_Insurance_Cost                  = IST_SuperTRUMP_Pricing_Quote.Total_Insurance_Cost__c;
        Pricing_Quote_Wrapper.IST_Total_Lending                     = IST_SuperTRUMP_Pricing_Quote.IST__Total_Lending__c;
        Pricing_Quote_Wrapper.Total_Purchase_Option_Fixed_Amount    = IST_SuperTRUMP_Pricing_Quote.Total_Purchase_Option_Fixed_Amount__c;
        Pricing_Quote_Wrapper.Total_Residual_Guaranteed_Amount      = IST_SuperTRUMP_Pricing_Quote.Total_Residual_Guaranteed_Amount__c;
        Pricing_Quote_Wrapper.Total_Residual_Guaranteed_Percent     = IST_SuperTRUMP_Pricing_Quote.Total_Residual_Guaranteed_Percent__c;
        Pricing_Quote_Wrapper.Total_Residual_Unguaranteed_Amount    = IST_SuperTRUMP_Pricing_Quote.Total_Residual_Unguaranteed_Amount__c;
        Pricing_Quote_Wrapper.Total_Residual_Unguaranteed_Percent   = IST_SuperTRUMP_Pricing_Quote.Total_Residual_Unguaranteed_Percent__c;
        Pricing_Quote_Wrapper.Total_Security_Deposit                = IST_SuperTRUMP_Pricing_Quote.Total_Security_Deposit__c;
        Pricing_Quote_Wrapper.WOA_nu_Term_in_months_without_PP      = IST_SuperTRUMP_Pricing_Quote.WOA_nu_Term_in_months_without_PP__c;
        Pricing_Quote_Wrapper.WOA_nu_Term_in_Months_Including_PP    = IST_SuperTRUMP_Pricing_Quote.WOA_nu_Term_in_Months_Including_PP__c;
        Pricing_Quote_Wrapper.WOA_nu_Progress_Payments_M            = IST_SuperTRUMP_Pricing_Quote.WOA_nu_Progress_Payments_M__c;
        Pricing_Quote_Wrapper.WOA_tl_Progress_Description           = IST_SuperTRUMP_Pricing_Quote.WOA_tl_Progress_Description__c;
        Pricing_Quote_Wrapper.WOA_nu_Grace_Period_M                 = IST_SuperTRUMP_Pricing_Quote.WOA_nu_Grace_Period_M__c;
        Pricing_Quote_Wrapper.WOA_ls_Type_of_Grace_Period           = IST_SuperTRUMP_Pricing_Quote.WOA_ls_Type_of_Grace_Period__c;
        Pricing_Quote_Wrapper.WOA_ls_Low_High_High_Low              = IST_SuperTRUMP_Pricing_Quote.WOA_ls_Low_High_High_Low__c;
        Pricing_Quote_Wrapper.WOA_tl_Low_High_High_Low_Description  = IST_SuperTRUMP_Pricing_Quote.WOA_tl_Low_High_High_Low_Description__c;
        Pricing_Quote_Wrapper.WOA_pr_Advance_Payment                = IST_SuperTRUMP_Pricing_Quote.WOA_pr_Advance_Payment__c;
        Pricing_Quote_Wrapper.WOA_ls_EFA                            = IST_SuperTRUMP_Pricing_Quote.WOA_ls_EFA__c;
        Pricing_Quote_Wrapper.WOA_ls_Used_New                       = IST_SuperTRUMP_Pricing_Quote.WOA_ls_Used_New__c;
        Pricing_Quote_Wrapper.WOA_ls_SL_B_YES_NO                    = IST_SuperTRUMP_Pricing_Quote.WOA_ls_SL_B_YES_NO__c;
        Pricing_Quote_Wrapper.WOA_ls_EBO                            = IST_SuperTRUMP_Pricing_Quote.WOA_ls_EBO__c;
        Pricing_Quote_Wrapper.WOA_tl_EBO_Description                = IST_SuperTRUMP_Pricing_Quote.WOA_tl_EBO_Description__c;
        Pricing_Quote_Wrapper.WOA_tl_Asset_description              = IST_SuperTRUMP_Pricing_Quote.WOA_tl_Asset_description__c;
        Pricing_Quote_Wrapper.WOA_tl_Return_Condition               = IST_SuperTRUMP_Pricing_Quote.WOA_tl_Return_Condition__c;
        Pricing_Quote_Wrapper.WOA_pr_Remarketing_Fee                = IST_SuperTRUMP_Pricing_Quote.WOA_pr_Remarketing_Fee__c;
        Pricing_Quote_Wrapper.WOA_pr_Split_Trac                     = IST_SuperTRUMP_Pricing_Quote.WOA_pr_Split_Trac__c;
        Pricing_Quote_Wrapper.WOA_pr_Lock_Fee                       = IST_SuperTRUMP_Pricing_Quote.WOA_pr_Lock_Fee__c;
        Pricing_Quote_Wrapper.WOA_tx_Boot_Collateral_Type           = IST_SuperTRUMP_Pricing_Quote.WOA_tx_Boot_Collateral_Type__c;
        Pricing_Quote_Wrapper.WOA_tl_EOL_Option                     = IST_SuperTRUMP_Pricing_Quote.WOA_tl_EOL_Option__c;
        Pricing_Quote_Wrapper.WOA_ls_Prom_Note                      = IST_SuperTRUMP_Pricing_Quote.WOA_ls_Prom_Note__c;
        Pricing_Quote_Wrapper.WOA_ls_Carga_Peligrosa                = IST_SuperTRUMP_Pricing_Quote.WOA_ls_Carga_Peligrosa__c;
        Pricing_Quote_Wrapper.WOA_ls_Cash_Collateral                = IST_SuperTRUMP_Pricing_Quote.WOA_ls_Cash_Collateral__c;
        Pricing_Quote_Wrapper.WOA_ls_Cross_Collateral               = IST_SuperTRUMP_Pricing_Quote.WOA_ls_Cross_Collateral__c;
        Pricing_Quote_Wrapper.WOA_ls_Direct_Debit                   = IST_SuperTRUMP_Pricing_Quote.WOA_ls_Direct_Debit__c;
        Pricing_Quote_Wrapper.WOA_nu_ROI_No_Insurance               = IST_SuperTRUMP_Pricing_Quote.WOA_nu_ROI_No_Insurance__c;
        Pricing_Quote_Wrapper.WOA_pr_Opening_Fee                    = IST_SuperTRUMP_Pricing_Quote.WOA_pr_Opening_Fee__c;
        Pricing_Quote_Wrapper.WOA_dv_Security_Deposit               = IST_SuperTRUMP_Pricing_Quote.WOA_dv_Security_Deposit__c;
        Pricing_Quote_Wrapper.WOA_pr_Security_Deposit               = IST_SuperTRUMP_Pricing_Quote.WOA_pr_Security_Deposit__c;
        Pricing_Quote_Wrapper.WOA_at_Security_Deposit_Comments      = IST_SuperTRUMP_Pricing_Quote.WOA_at_Security_Deposit_Comments__c;
        Pricing_Quote_Wrapper.WOA_pr_Rate                           = IST_SuperTRUMP_Pricing_Quote.WOA_pr_Rate__c;
        Pricing_Quote_Wrapper.WOA_pr_RV                             = IST_SuperTRUMP_Pricing_Quote.WOA_pr_RV__c;
        Pricing_Quote_Wrapper.WOA_dv_Ballon_Bullet_Payment          = IST_SuperTRUMP_Pricing_Quote.WOA_dv_Ballon_Bullet_Payment__c;
        Pricing_Quote_Wrapper.WOA_pr_P_Option                       = IST_SuperTRUMP_Pricing_Quote.WOA_pr_P_Option__c;



        Pricing_Quote_Wrapper.list_SP_PQ_Expense_Fee_Wrapper		= getList_SP_PQ_Expense_Fee_Wrapper(IST_SuperTRUMP_Pricing_Quote.IST__Expense_Fees__r);
        Pricing_Quote_Wrapper.list_IST_ST_PQ_Income_Fee_Wrapper		= getList_IST_ST_PQ_Income_Fee_Wrapper(IST_SuperTRUMP_Pricing_Quote.IST__Income_Fees__r);
        Pricing_Quote_Wrapper.list_IST_ST_PQ_Loan_Wrapper			= getList_IST_ST_PQ_Loan_Wrapper(IST_SuperTRUMP_Pricing_Quote.IST__Loans__r);
        Pricing_Quote_Wrapper.list_IST_ST_PQ_Rent_Wrapper			= getList_IST_ST_PQ_Rent_Wrapper(IST_SuperTRUMP_Pricing_Quote.IST__Rents__r);
        Pricing_Quote_Wrapper.list_ST_PQ_Periodic_Expense_Wrapper	= getList_ST_PQ_Periodic_Expense_Wrapper(IST_SuperTRUMP_Pricing_Quote.Periodic_Expenses__r);
        Pricing_Quote_Wrapper.list_ST_PQ_Periodic_Income_Wrapper	= getList_ST_PQ_Periodic_Income_Wrapper(IST_SuperTRUMP_Pricing_Quote.Periodic_Incomes__r);
        Pricing_Quote_Wrapper.list_ST_PQ_SSDeposit_Wrapper			= getList_ST_PQ_SSDeposit_Wrapper(IST_SuperTRUMP_Pricing_Quote.Specified_Security_Deposits__r);
        Pricing_Quote_Wrapper.list_ST_PQ_TV_Schedule_Step_Wrapper	= getList_ST_PQ_TV_Schedule_Step_Wrapper(IST_SuperTRUMP_Pricing_Quote.TV_Schedule_Steps__r);
        Pricing_Quote_Wrapper.list_ST_PQ_EBO_Wrapper				= getList_ST_PQ_EBO_Wrapper_cls(IST_SuperTRUMP_Pricing_Quote.EBOs__r);
        
        return Pricing_Quote_Wrapper;
    }
    /**
    * @description 
    * @author eduardo.villegas@engeniumcapital.com | 7/10/2019 
    * @param List<IST__SuperTRUMP_PQ_Expense_Fee__c> SP_PQ_Expense_Fee 
    * @return List<IST_SP_PQ_Expense_Fee_Wrapper_cls> 
    **/
    public static List<IST_SP_PQ_Expense_Fee_Wrapper_cls.query_All_Fields> getList_SP_PQ_Expense_Fee_Wrapper(List<IST__SuperTRUMP_PQ_Expense_Fee__c> SP_PQ_Expense_Fee){
        List<IST_SP_PQ_Expense_Fee_Wrapper_cls.query_All_Fields> list_SP_PQ_Expense_Fee_Wrapper = new List<IST_SP_PQ_Expense_Fee_Wrapper_cls.query_All_Fields>();
        for(IST__SuperTRUMP_PQ_Expense_Fee__c Expense_Fee : SP_PQ_Expense_Fee){
        	IST_SP_PQ_Expense_Fee_Wrapper_cls.query_All_Fields  IST_SP_PQ_Expense_Fee_Wrapper = new IST_SP_PQ_Expense_Fee_Wrapper_cls.query_All_Fields();
            IST_SP_PQ_Expense_Fee_Wrapper.recordID              = Expense_Fee.id;
            IST_SP_PQ_Expense_Fee_Wrapper.IST_Amount            = Expense_Fee.IST__Amount__c;
            IST_SP_PQ_Expense_Fee_Wrapper.IST_Calculation_Index = Integer.valueof(Expense_Fee.IST__Calculation_Index__c);
            IST_SP_PQ_Expense_Fee_Wrapper.CreatedById           = Expense_Fee.CreatedById;
            IST_SP_PQ_Expense_Fee_Wrapper.CurrencyIsoCode       = Expense_Fee.CurrencyIsoCode;
            IST_SP_PQ_Expense_Fee_Wrapper.IST_Description       = Expense_Fee.IST__Description__c;
            IST_SP_PQ_Expense_Fee_Wrapper.Name                  = Expense_Fee.Name;
            IST_SP_PQ_Expense_Fee_Wrapper.LastModifiedById      = Expense_Fee.LastModifiedById;
            IST_SP_PQ_Expense_Fee_Wrapper.IST_Paid_Date         = Expense_Fee.IST__Paid_Date__c;
            IST_SP_PQ_Expense_Fee_Wrapper.IST_Percent           = Expense_Fee.IST__Percent__c;
            IST_SP_PQ_Expense_Fee_Wrapper.IST_Pricing_Quote     = Expense_Fee.IST__Pricing_Quote__c;
            IST_SP_PQ_Expense_Fee_Wrapper.IST_stExternalID      = Expense_Fee.IST__stExternalID__c;
            list_SP_PQ_Expense_Fee_Wrapper.add(IST_SP_PQ_Expense_Fee_Wrapper); 
        }        
        return list_SP_PQ_Expense_Fee_Wrapper;
    }
    /**
    * @description 
    * @author eduardo.villegas@engeniumcapital.com | 7/10/2019 
    * @param List<IST__SuperTRUMP_PQ_Expense_Fee__c> SP_PQ_Expense_Fee 
    * @return List<IST_ST_PQ_Income_Fee_Wrapper_cls> 
    **/
    public static List<IST_ST_PQ_Income_Fee_Wrapper_cls.query_All_Fields> getList_IST_ST_PQ_Income_Fee_Wrapper(List<IST__SuperTRUMP_PQ_Income_Fee__c> ST_PQ_Income_Fee){
        List<IST_ST_PQ_Income_Fee_Wrapper_cls.query_All_Fields> list_IST_ST_PQ_Income_Fee_Wrapper = new List<IST_ST_PQ_Income_Fee_Wrapper_cls.query_All_Fields>();
        for(IST__SuperTRUMP_PQ_Income_Fee__c Income_Fee : ST_PQ_Income_Fee){
        	IST_ST_PQ_Income_Fee_Wrapper_cls.query_All_Fields  IST_ST_PQ_Income_Fee_Wrapper = new IST_ST_PQ_Income_Fee_Wrapper_cls.query_All_Fields();
            IST_ST_PQ_Income_Fee_Wrapper.recordID               = Income_Fee.id;
            IST_ST_PQ_Income_Fee_Wrapper.IST_Amount             = Income_Fee.IST__Amount__c;
            IST_ST_PQ_Income_Fee_Wrapper.IST_Calculation_Index  = Integer.valueof(Income_Fee.IST__Calculation_Index__c);
            IST_ST_PQ_Income_Fee_Wrapper.CreatedById            = Income_Fee.CreatedById;
            IST_ST_PQ_Income_Fee_Wrapper.CurrencyIsoCode        = Income_Fee.CurrencyIsoCode;
            IST_ST_PQ_Income_Fee_Wrapper.IST_Description        = Income_Fee.IST__Description__c;
            IST_ST_PQ_Income_Fee_Wrapper.Name                   = Income_Fee.Name;
            IST_ST_PQ_Income_Fee_Wrapper.LastModifiedById       = Income_Fee.LastModifiedById;
            IST_ST_PQ_Income_Fee_Wrapper.IST_Paid_Date          = Income_Fee.IST__Paid_Date__c;
            IST_ST_PQ_Income_Fee_Wrapper.IST_Percent            = Income_Fee.IST__Percent__c;
            IST_ST_PQ_Income_Fee_Wrapper.IST_Pricing_Quote      = Income_Fee.IST__Pricing_Quote__c;
            IST_ST_PQ_Income_Fee_Wrapper.IST_stExternalID       = Income_Fee.IST__stExternalID__c;
            list_IST_ST_PQ_Income_Fee_Wrapper.add(IST_ST_PQ_Income_Fee_Wrapper); 
        }        
        return list_IST_ST_PQ_Income_Fee_Wrapper;
    }
    /**
    * @description 
    * @author eduardo.villegas@engeniumcapital.com | 7/10/2019 
    * @param List<IST__SuperTRUMP_PQ_Loan__c> ST_PQ_Loan 
    * @return List<IST_ST_PQ_Loan_Wrapper_cls.query_All_Fields> 
    **/
    public static List<IST_ST_PQ_Loan_Wrapper_cls.query_All_Fields> getList_IST_ST_PQ_Loan_Wrapper(List<IST__SuperTRUMP_PQ_Loan__c> ST_PQ_Loan){
        List<IST_ST_PQ_Loan_Wrapper_cls.query_All_Fields> list_IST_ST_PQ_Loan_Wrapper = new List<IST_ST_PQ_Loan_Wrapper_cls.query_All_Fields>();
        for(IST__SuperTRUMP_PQ_Loan__c Loan : ST_PQ_Loan){
        	IST_ST_PQ_Loan_Wrapper_cls.query_All_Fields  IST_ST_PQ_Loan_Wrapper = new IST_ST_PQ_Loan_Wrapper_cls.query_All_Fields();
            IST_ST_PQ_Loan_Wrapper.recordID               = Loan.id;
            IST_ST_PQ_Loan_Wrapper.IST_Advance_Payment    = Loan.IST__Advance_Payment__c;
            IST_ST_PQ_Loan_Wrapper.IST_Calculation_Index  = Integer.valueof(Loan.IST__Calculation_Index__c);
            IST_ST_PQ_Loan_Wrapper.CreatedById            = Loan.CreatedById;
            IST_ST_PQ_Loan_Wrapper.CurrencyIsoCode        = Loan.CurrencyIsoCode;            
            IST_ST_PQ_Loan_Wrapper.IST_Description        = Loan.IST__Description__c;
            IST_ST_PQ_Loan_Wrapper.LastModifiedById       = Loan.LastModifiedById;
            IST_ST_PQ_Loan_Wrapper.Name                   = Loan.Name;
            IST_ST_PQ_Loan_Wrapper.Loan_Rate              = Loan.Loan_Rate__c;
            IST_ST_PQ_Loan_Wrapper.IST_Num_Payments       = Integer.valueof(Loan.IST__Num_Payments__c);
            IST_ST_PQ_Loan_Wrapper.IST_Pricing_Quote      = Loan.IST__Pricing_Quote__c;
            IST_ST_PQ_Loan_Wrapper.IST_stExternalID       = Loan.IST__stExternalID__c;
            IST_ST_PQ_Loan_Wrapper.IST_Start_Date         = Loan.IST__Start_Date__c;
            IST_ST_PQ_Loan_Wrapper.IST_Total_Funding      = Loan.IST__Total_Funding__c;
            IST_ST_PQ_Loan_Wrapper.IST_Total_Payments     = Loan.IST__Total_Payments__c;
            list_IST_ST_PQ_Loan_Wrapper.add(IST_ST_PQ_Loan_Wrapper); 
        }        
        return list_IST_ST_PQ_Loan_Wrapper;
    }
    /**
    * @description 
    * @author eduardo.villegas@engeniumcapital.com | 9/10/2019 
    * @param List<IST__SuperTRUMP_PQ_Rent__c> ST_PQ_Rent 
    * @return List<IST_ST_PQ_Rent_Wrapper_cls.query_All_Fields> 
    **/
    public static List<IST_ST_PQ_Rent_Wrapper_cls.query_All_Fields> getList_IST_ST_PQ_Rent_Wrapper(List<IST__SuperTRUMP_PQ_Rent__c> ST_PQ_Rent){
        set<Id> setRentId = new set<Id>();
        for(IST__SuperTRUMP_PQ_Rent__c IST_SuperTRUMP_PQ_Rent : ST_PQ_Rent){
            setRentId.add(IST_SuperTRUMP_PQ_Rent.Id);
        }
        List<IST_ST_PQ_Rent_Wrapper_cls.query_All_Fields> list_IST_ST_PQ_Rent_Wrapper = new List<IST_ST_PQ_Rent_Wrapper_cls.query_All_Fields>();
        list_IST_ST_PQ_Rent_Wrapper = Data_Access_WOS_IST_ST_PQ_Rent_cls.getAllFieldsBySetID(setRentId);
        /* for(IST__SuperTRUMP_PQ_Rent__c Rent : Data_Access_WOS_IST_ST_PQ_Rent_cls.getAllFieldsBySetID(setRentId)){
        	IST_ST_PQ_Rent_Wrapper_cls.query_All_Fields  IST_ST_PQ_Rent_Wrapper = new IST_ST_PQ_Rent_Wrapper_cls.query_All_Fields();
            IST_ST_PQ_Rent_Wrapper.recordID				  =Rent.id;	
            IST_ST_PQ_Rent_Wrapper.IST_Advance_Payment    = Rent.IST__Advance_Payment__c;
            IST_ST_PQ_Rent_Wrapper.IST_Calculation_Index  = Integer.valueof(Rent.IST__Calculation_Index__c);
            IST_ST_PQ_Rent_Wrapper.CreatedById            = Rent.CreatedById;
            IST_ST_PQ_Rent_Wrapper.CurrencyIsoCode        = Rent.CurrencyIsoCode;
            IST_ST_PQ_Rent_Wrapper.IST_Description        = Rent.IST__Description__c;
            IST_ST_PQ_Rent_Wrapper.LastModifiedById       = Rent.LastModifiedById;
            IST_ST_PQ_Rent_Wrapper.IST_Num_Payments		  = Integer.valueof(Rent.IST__Num_Payments__c);
            IST_ST_PQ_Rent_Wrapper.IST_Pricing_Quote      = Rent.IST__Pricing_Quote__c;
            IST_ST_PQ_Rent_Wrapper.Quasi_Lease_Rate       = Rent.Quasi_Lease_Rate__c;
            IST_ST_PQ_Rent_Wrapper.Name                   = Rent.Name;
            IST_ST_PQ_Rent_Wrapper.IST_stExternalID       = Rent.IST__stExternalID__c;
            IST_ST_PQ_Rent_Wrapper.IST_Total_Payments     = Rent.IST__Total_Payments__c;            
            list_IST_ST_PQ_Rent_Wrapper.add(IST_ST_PQ_Rent_Wrapper); 
        }        */
        return list_IST_ST_PQ_Rent_Wrapper;
    }
    /**
    * @description 
    * @author eduardo.villegas@engeniumcapital.com | 9/10/2019 
    * @param List<ST_PQ_Periodic_Expense__c> ST_PQ_Periodic_Expense 
    * @return List<ST_PQ_Periodic_Expense_Wrapper_cls.query_All_Fields> 
    **/
    public static List<ST_PQ_Periodic_Expense_Wrapper_cls.query_All_Fields> getList_ST_PQ_Periodic_Expense_Wrapper(List<ST_PQ_Periodic_Expense__c> ST_PQ_Periodic_Expense){
        List<ST_PQ_Periodic_Expense_Wrapper_cls.query_All_Fields> list_ST_PQ_Periodic_Expense_Wrapper = new List<ST_PQ_Periodic_Expense_Wrapper_cls.query_All_Fields>();
        for(ST_PQ_Periodic_Expense__c Periodic_Expense : ST_PQ_Periodic_Expense){
        	ST_PQ_Periodic_Expense_Wrapper_cls.query_All_Fields  ST_PQ_Periodic_Expense_Wrapper = new ST_PQ_Periodic_Expense_Wrapper_cls.query_All_Fields();
            ST_PQ_Periodic_Expense_Wrapper.recordID			= Periodic_Expense.id;	
            ST_PQ_Periodic_Expense_Wrapper.Active    		= Periodic_Expense.Active__c;
            ST_PQ_Periodic_Expense_Wrapper.Average_Payment  = Integer.valueof(Periodic_Expense.Average_Payment__c);
            ST_PQ_Periodic_Expense_Wrapper.CreatedById      = Periodic_Expense.CreatedById;
            ST_PQ_Periodic_Expense_Wrapper.CurrencyIsoCode  = Periodic_Expense.CurrencyIsoCode;
            ST_PQ_Periodic_Expense_Wrapper.Description      = Periodic_Expense.Description__c;
            ST_PQ_Periodic_Expense_Wrapper.LastModifiedById = Periodic_Expense.LastModifiedById;
            ST_PQ_Periodic_Expense_Wrapper.Num_Payments		= Integer.valueof(Periodic_Expense.Num_Payments__c);
            ST_PQ_Periodic_Expense_Wrapper.Name      		= Periodic_Expense.Name;
            ST_PQ_Periodic_Expense_Wrapper.Periodicity      = Periodic_Expense.Periodicity__c;
            ST_PQ_Periodic_Expense_Wrapper.stExternalID     = Periodic_Expense.stExternalID__c;
            ST_PQ_Periodic_Expense_Wrapper.Start_Date       = Periodic_Expense.Start_Date__c;
            ST_PQ_Periodic_Expense_Wrapper.Pricing_Quote    = Periodic_Expense.Pricing_Quote__c;            
            list_ST_PQ_Periodic_Expense_Wrapper.add(ST_PQ_Periodic_Expense_Wrapper); 
        }        
        return list_ST_PQ_Periodic_Expense_Wrapper;
    }
    /**
    * @description 
    * @author eduardo.villegas@engeniumcapital.com | 9/10/2019 
    * @param List<ST_PQ_Periodic_Income__c> ST_PQ_Periodic_Income 
    * @return List<ST_PQ_Periodic_Income_Wrapper_cls.query_All_Fields> 
    **/
    public static List<ST_PQ_Periodic_Income_Wrapper_cls.query_All_Fields> getList_ST_PQ_Periodic_Income_Wrapper(List<ST_PQ_Periodic_Income__c> ST_PQ_Periodic_Income){
        List<ST_PQ_Periodic_Income_Wrapper_cls.query_All_Fields> list_ST_PQ_Periodic_Income_Wrapper = new List<ST_PQ_Periodic_Income_Wrapper_cls.query_All_Fields>();
        for(ST_PQ_Periodic_Income__c Periodic_Expense : ST_PQ_Periodic_Income){
        	ST_PQ_Periodic_Income_Wrapper_cls.query_All_Fields  ST_PQ_Periodic_Income_Wrapper = new ST_PQ_Periodic_Income_Wrapper_cls.query_All_Fields();
            ST_PQ_Periodic_Income_Wrapper.recordID			= Periodic_Expense.id;	
            ST_PQ_Periodic_Income_Wrapper.Of_Payments    	= Periodic_Expense.Of_Payments__c;
            ST_PQ_Periodic_Income_Wrapper.Active  			= Periodic_Expense.Active__c;
            ST_PQ_Periodic_Income_Wrapper.Average_Payment   = Periodic_Expense.Average_Payment__c;
            ST_PQ_Periodic_Income_Wrapper.CreatedById  		= Periodic_Expense.CreatedById;
            ST_PQ_Periodic_Income_Wrapper.CurrencyIsoCode   = Periodic_Expense.CurrencyIsoCode;
            ST_PQ_Periodic_Income_Wrapper.Description 		= Periodic_Expense.Description__c;
            ST_PQ_Periodic_Income_Wrapper.Financed_Amount	= Periodic_Expense.Financed_Amount__c;
            ST_PQ_Periodic_Income_Wrapper.LastModifiedById  = Periodic_Expense.LastModifiedById;
            ST_PQ_Periodic_Income_Wrapper.Num_Payments      = Integer.valueof(Periodic_Expense.Num_Payments__c);
            ST_PQ_Periodic_Income_Wrapper.Name     			= Periodic_Expense.Name;
            ST_PQ_Periodic_Income_Wrapper.Periodicity       = Periodic_Expense.Periodicity__c;
            ST_PQ_Periodic_Income_Wrapper.Insurance_Rate    = Periodic_Expense.Insurance_Rate__c;
            ST_PQ_Periodic_Income_Wrapper.stExternalID    	= Periodic_Expense.stExternalID__c;
            ST_PQ_Periodic_Income_Wrapper.Start_Date    	= Periodic_Expense.Start_Date__c;
            ST_PQ_Periodic_Income_Wrapper.Pricing_Quote    	= Periodic_Expense.Pricing_Quote__c;            
            list_ST_PQ_Periodic_Income_Wrapper.add(ST_PQ_Periodic_Income_Wrapper); 
        }        
        return list_ST_PQ_Periodic_Income_Wrapper;
    }
    /**
    * @description 
    * @author eduardo.villegas@engeniumcapital.com | 9/10/2019 
    * @param List<ST_PQ_Specified_Security_Deposit__c> ST_PQ_Specified_Security_Deposit 
    * @return List<ST_PQ_SSDeposit_Wrapper_cls.query_All_Fields> 
    **/
    public static List<ST_PQ_SSDeposit_Wrapper_cls.query_All_Fields> getList_ST_PQ_SSDeposit_Wrapper(List<ST_PQ_Specified_Security_Deposit__c> ST_PQ_Specified_Security_Deposit){
        List<ST_PQ_SSDeposit_Wrapper_cls.query_All_Fields> list_ST_PQ_SSDeposit_Wrapper = new List<ST_PQ_SSDeposit_Wrapper_cls.query_All_Fields>();
        for(ST_PQ_Specified_Security_Deposit__c Specified_Security_Deposit : ST_PQ_Specified_Security_Deposit){
        	ST_PQ_SSDeposit_Wrapper_cls.query_All_Fields  ST_PQ_SSDeposit_Wrapper = new ST_PQ_SSDeposit_Wrapper_cls.query_All_Fields();
            ST_PQ_SSDeposit_Wrapper.recordID			= Specified_Security_Deposit.id;	
            ST_PQ_SSDeposit_Wrapper.Amount    			= Specified_Security_Deposit.Amount__c;
            ST_PQ_SSDeposit_Wrapper.CreatedById  		= Specified_Security_Deposit.CreatedById;
            ST_PQ_SSDeposit_Wrapper.CurrencyIsoCode  	= Specified_Security_Deposit.CurrencyIsoCode;
            ST_PQ_SSDeposit_Wrapper.LastModifiedById  	= Specified_Security_Deposit.LastModifiedById;
            ST_PQ_SSDeposit_Wrapper.Received   			= Specified_Security_Deposit.Received__c;
            ST_PQ_SSDeposit_Wrapper.Returned   			= Specified_Security_Deposit.Returned__c;
            ST_PQ_SSDeposit_Wrapper.Name 				= Specified_Security_Deposit.Name;
            ST_PQ_SSDeposit_Wrapper.stExternalID		= Specified_Security_Deposit.stExternalID__c;
            ST_PQ_SSDeposit_Wrapper.Pricing_Quote  		= Specified_Security_Deposit.Pricing_Quote__c;           
            list_ST_PQ_SSDeposit_Wrapper.add(ST_PQ_SSDeposit_Wrapper); 
        }        
        return list_ST_PQ_SSDeposit_Wrapper;
    }
    
    
    
    /**
    * @description 
    * @author eduardo.villegas@engeniumcapital.com | 9/10/2019 
    * @param List<ST_PQ_TV_Schedule_Step__c> list_ST_PQ_TV_Schedule_Step 
    * @return List<ST_PQ_TV_Schedule_Step_Wrapper_cls.query_All_Fields> 
    **/
    public static List<ST_PQ_TV_Schedule_Step_Wrapper_cls.query_All_Fields> getList_ST_PQ_TV_Schedule_Step_Wrapper(List<ST_PQ_TV_Schedule_Step__c> list_ST_PQ_TV_Schedule_Step){
        List<ST_PQ_TV_Schedule_Step_Wrapper_cls.query_All_Fields> list_ST_PQ_TV_Schedule_Step_Wrapper = new List<ST_PQ_TV_Schedule_Step_Wrapper_cls.query_All_Fields>();
        for(ST_PQ_TV_Schedule_Step__c ST_PQ_TV_Schedule_Step : list_ST_PQ_TV_Schedule_Step){
        	ST_PQ_TV_Schedule_Step_Wrapper_cls.query_All_Fields  ST_PQ_TV_Schedule_Step_Wrapper = new ST_PQ_TV_Schedule_Step_Wrapper_cls.query_All_Fields();
            ST_PQ_TV_Schedule_Step_Wrapper.recordID						= ST_PQ_TV_Schedule_Step.id;	
            ST_PQ_TV_Schedule_Step_Wrapper.Advance_Debt_Service    		= ST_PQ_TV_Schedule_Step.Advance_Debt_Service__c;
            ST_PQ_TV_Schedule_Step_Wrapper.Advance_Rent  				= ST_PQ_TV_Schedule_Step.Advance_Rent__c;
            ST_PQ_TV_Schedule_Step_Wrapper.Arrears_Debt_Service			= ST_PQ_TV_Schedule_Step.Arrears_Debt_Service__c;
            ST_PQ_TV_Schedule_Step_Wrapper.Arrears_Rent  				= ST_PQ_TV_Schedule_Step.Arrears_Rent__c;
            ST_PQ_TV_Schedule_Step_Wrapper.CreatedById   				= ST_PQ_TV_Schedule_Step.CreatedById;
            ST_PQ_TV_Schedule_Step_Wrapper.CurrencyIsoCode   			= ST_PQ_TV_Schedule_Step.CurrencyIsoCode;
            ST_PQ_TV_Schedule_Step_Wrapper.TV_Date 						= ST_PQ_TV_Schedule_Step.TV_Date__c;
            ST_PQ_TV_Schedule_Step_Wrapper.LastModifiedById				= ST_PQ_TV_Schedule_Step.LastModifiedById;
            ST_PQ_TV_Schedule_Step_Wrapper.Number_of_Payments_Scheduled = Integer.valueof(ST_PQ_TV_Schedule_Step.Number_of_Payments_Scheduled__c);            
            ST_PQ_TV_Schedule_Step_Wrapper.Quote  						= ST_PQ_TV_Schedule_Step.Quote__c; 
            ST_PQ_TV_Schedule_Step_Wrapper.Termination_Value_Amount  	= ST_PQ_TV_Schedule_Step.Termination_Value_Amount__c; 
            ST_PQ_TV_Schedule_Step_Wrapper.Termination_Value_Percent  	= ST_PQ_TV_Schedule_Step.Termination_Value_Percent__c; 
            ST_PQ_TV_Schedule_Step_Wrapper.Total_Due_On_Termination  	= ST_PQ_TV_Schedule_Step.Total_Due_On_Termination__c; 
            ST_PQ_TV_Schedule_Step_Wrapper.Name  						= ST_PQ_TV_Schedule_Step.Name; 
            
            list_ST_PQ_TV_Schedule_Step_Wrapper.add(ST_PQ_TV_Schedule_Step_Wrapper); 
        }        
        return list_ST_PQ_TV_Schedule_Step_Wrapper;
    }
    
    /**
    * @description 
    * @author eduardo.villegas@engeniumcapital.com | 9/10/2019 
    * @param List<SuperTRUMP_PQ_EBO__c> list_SuperTRUMP_PQ_EBO 
    * @return List<ST_PQ_EBO_Wrapper_cls.query_All_Fields> 
    **/
    public static List<ST_PQ_EBO_Wrapper_cls.query_All_Fields> getList_ST_PQ_EBO_Wrapper_cls(List<SuperTRUMP_PQ_EBO__c> list_SuperTRUMP_PQ_EBO){
        List<ST_PQ_EBO_Wrapper_cls.query_All_Fields> list_ST_PQ_TV_Schedule_Step_Wrapper = new List<ST_PQ_EBO_Wrapper_cls.query_All_Fields>();
        for(SuperTRUMP_PQ_EBO__c SuperTRUMP_PQ_EBO : list_SuperTRUMP_PQ_EBO){
        	ST_PQ_EBO_Wrapper_cls.query_All_Fields  ST_PQ_EBO_Wrapper = new ST_PQ_EBO_Wrapper_cls.query_All_Fields();
            ST_PQ_EBO_Wrapper.recordID			= SuperTRUMP_PQ_EBO.id;	
            ST_PQ_EBO_Wrapper.Active    		= SuperTRUMP_PQ_EBO.Active__c;
            ST_PQ_EBO_Wrapper.Amount  			= SuperTRUMP_PQ_EBO.Amount__c;
            ST_PQ_EBO_Wrapper.Based_on			= SuperTRUMP_PQ_EBO.Based_on__c;
            ST_PQ_EBO_Wrapper.CreatedById  		= SuperTRUMP_PQ_EBO.CreatedById;
            ST_PQ_EBO_Wrapper.CurrencyIsoCode   = SuperTRUMP_PQ_EBO.CurrencyIsoCode;
            ST_PQ_EBO_Wrapper.EBO_Date   		= SuperTRUMP_PQ_EBO.EBO_Date__c;
            ST_PQ_EBO_Wrapper.Name 				= SuperTRUMP_PQ_EBO.Name;
            ST_PQ_EBO_Wrapper.FMV				= SuperTRUMP_PQ_EBO.FMV__c;
            ST_PQ_EBO_Wrapper.LastModifiedById 	= SuperTRUMP_PQ_EBO.LastModifiedById;            
            ST_PQ_EBO_Wrapper.Premium  			= SuperTRUMP_PQ_EBO.Premium__c; 
            ST_PQ_EBO_Wrapper.stExternalID  	= SuperTRUMP_PQ_EBO.stExternalID__c; 
            ST_PQ_EBO_Wrapper.Pricing_Quote  	= SuperTRUMP_PQ_EBO.Pricing_Quote__c; 
            ST_PQ_EBO_Wrapper.Term  			= SuperTRUMP_PQ_EBO.Term__c; 
            
            list_ST_PQ_TV_Schedule_Step_Wrapper.add(ST_PQ_EBO_Wrapper); 
        }        
        return list_ST_PQ_TV_Schedule_Step_Wrapper;
    }

}