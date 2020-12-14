/**
 * @File Name          : Data_Access_IST_SuperTRUMP_Pricing_Quote.cls
 * @Description        : 
 * @Author             : eduardo.villegas@engeniumcapital.com
 * @Group              : 
 * @Last Modified By   : eduardo.amiens@outlook.com
 * @Last Modified On   : 10-13-2020
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    19/9/2019   eduardo.villegas@engeniumcapital.com     Initial Version
**/
public without sharing class Data_Access_WOS_IST_SP_Pricing_Quote {
    /**
    * @description 
    * @author eduardo.villegas@engeniumcapital.com | 7/10/2019 
    * @param id PQ_ID 
    * @return SupperTRUMP_Pricing_Quote_Wrapper.query_All_Fields 
    **/
    public static SupperTRUMP_Pricing_Quote_Wrapper.query_All_Fields getAllFieldsByID(id PQ_ID){
        SupperTRUMP_Pricing_Quote_Wrapper.query_All_Fields Pricing_Quote_Wrapper = new SupperTRUMP_Pricing_Quote_Wrapper.query_All_Fields();
        IST__SuperTRUMP_Pricing_Quote__c IST_SuperTRUMP_Pricing_Quote = new IST__SuperTRUMP_Pricing_Quote__c();
        for(IST__SuperTRUMP_Pricing_Quote__c Pricing_Quote : [Select Id, OwnerId, IsDeleted, Name, CurrencyIsoCode, RecordTypeId, CreatedDate, CreatedById, LastModifiedDate, 
                                                              LastModifiedById, SystemModstamp, LastActivityDate, LastViewedDate, LastReferencedDate, IST__Balloon__c, 
                                                              IST__Commencement__c, Of_Payments_Loan__c, IST__Cost__c, IST__Delivery_Date__c, IST__Description__c, IST__FinanceType__c, 
                                                              IST__IRR_NPT__c, IST__Is_Synchronized__c, IST__Lending_Rate__c, IST__LessorFAS__c, IST__MISF_NAT__c, 
                                                              IST__Mode__c, IST__Opportunity__c, IST__Payment_Timing__c, IST__Payment__c, IST__Periodicity__c, 
                                                              IST__QuoteStatus__c, IST__Rent_IBR__c, IST__Residual__c, IST__Takedown__c, IST__Template__c,IST__Template__r.Name, IST__Term__c, 
                                                              IST__Total_Lending__c, IST__stExternalID__c, BookYield__c, Contributed_Value__c, Cost_of_Funds_Levered__c, 
                                                              Cost_of_Funds_Unlevered__c, Depreciation__c, Economic_ROE__c, Economic_ROI__c, Economic_Yield__c, 
                                                              Expense_ANI__c, Finance_Margin__c, Full_Term_Rate__c, FulltermRatewithresidual__c, Leverage__c, LossANI__c, 
                                                              MC_Currency__c, MoneyCostDateFound__c, Net_Income_Eco__c, Net_Income__c, Product__c, Rate_Type__c, 
                                                              Security_Deposit__c, created_in_SF__c, Opening_Fee__c, TotalBookANI__c, Periodicidad_mensuales_trimestrales__c, 
                                                              Tipo_de_pago__c, Tipo_de_Moneda__c, Moneda__c, Periodicidad_meses_trimestres__c, Opening_Fee_Amount__c, 
                                                              Plazo_en_texto__c, Fecha_pago_renta_vencida_anticipada__c, Advance_Payments__c, Additional_Rent__c, 
                                                              Fecha_Pago_Interes_Interino__c, Engenium_Legal_Entity__c, Advance_Payment_Loan__c, Cl_usula_Tasa_Efectiva_Variable__c, 
                                                              Periodicidad_mes_trimestre__c, Periodicidad_mensual_trimestral__c, Cla_sula_Tasa_Variable_No_Aplica_en_Fij__c, 
                                                              Proposal_With_Insurance__c, Quote_With_Insurance__c, Exchange_Rate__c, Apoderado_1__c, Apoderado_2__c, 
                                                              Security_Deposit_Percentage__c, ProposalToGo_Use_Count__c, Of_Payments__c, QuoteToGo_Use_Count__c, 
                                                              ProposalToGo_With_Insurance_Use_Count__c, Referral_Fee__c, QuoteToGo_With_Insurance_Use_Count__c, 
                                                              Opportunity_Collateral__c, Import_Services_Fee__c, Product_Name__c, Customer_Name__c, Residual_Value__c, 
                                                              Rapid_Tag_Fee__c, Average_Life_of_Asset_years__c, EBO_Active__c, Gross_Margin__c, Purchase_Option_Method__c, 
                                                              Residual_Guarantee_Type__c, Security_Deposit_Method__c, Total_Purchase_Option_Fixed_Amount__c, 
                                                              Total_Residual_Guaranteed_Amount__c, Total_Residual_Guaranteed_Percent__c, Total_Residual_Unguaranteed_Amount__c, 
                                                              Total_Residual_Unguaranteed_Percent__c, Total_Security_Deposit__c, EBO__c, Insurance_Rate__c, Loan_Rate__c, 
                                                              Maintenance_Fee__c, Maintenance_Cost_With_Markup__c, Maintenance_Markup__c, Maintenance_Cost_Expense__c, 
                                                              Telematics_Fee_Income__c, Rapid_Tag_Policy_Income__c, Fines_Monitoring_Fee_Income__c, Rapid_Tag_Plates__c, 
                                                              Rapid_Tag_Emission_Control__c, PQ_Validity_for_Fleet_Date__c, Of_Insurance_Payments__c, Lease_Rate_Percentage__c, 
                                                              Insurance_Policy_Issuing_Cost__c, Total_Insurance_Cost__c, Insurance_Policy_Rebate__c, Insurance_Rebate_UDI__c,                                                              
                                                              WOA_nu_Term_in_months_without_PP__c, WOA_nu_Term_in_Months_Including_PP__c, WOA_nu_Progress_Payments_M__c,
                                                              WOA_tl_Progress_Description__c, WOA_nu_Grace_Period_M__c, WOA_ls_Type_of_Grace_Period__c, WOA_ls_Low_High_High_Low__c,
                                                              WOA_tl_Low_High_High_Low_Description__c, WOA_pr_Advance_Payment__c, WOA_ls_EFA__c, WOA_ls_Used_New__c,
                                                              WOA_ls_SL_B_YES_NO__c, WOA_ls_EBO__c, WOA_tl_EBO_Description__c, WOA_tl_Asset_description__c, WOA_tl_Return_Condition__c,
                                                              WOA_pr_Remarketing_Fee__c, WOA_pr_Split_Trac__c, WOA_pr_Lock_Fee__c, WOA_tx_Boot_Collateral_Type__c, WOA_tl_EOL_Option__c,
                                                              WOA_ls_Prom_Note__c, WOA_ls_Carga_Peligrosa__c, WOA_ls_Cash_Collateral__c, WOA_ls_Cross_Collateral__c, WOA_ls_Direct_Debit__c,
                                                              WOA_nu_ROI_No_Insurance__c, WOA_pr_Opening_Fee__c, WOA_dv_Security_Deposit__c, WOA_pr_Security_Deposit__c,
                                                              WOA_at_Security_Deposit_Comments__c, WOA_pr_Rate__c, WOA_pr_RV__c, WOA_dv_Ballon_Bullet_Payment__c, WOA_pr_P_Option__c,
                                                              (Select Id from IST__Assets__r), 
                                                              (Select Id, IsDeleted, Name, CurrencyIsoCode, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, 
                                                               		SystemModstamp, IST__Pricing_Quote__c, IST__Amount__c, IST__Calculation_Index__c, IST__Description__c, 
                                                               		IST__Paid_Date__c, IST__Percent__c, IST__stExternalID__c 
                                                               		from IST__Expense_Fees__r), 
                                                              (Select Id, IsDeleted, Name, CurrencyIsoCode, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, 
                                                               		SystemModstamp, IST__Pricing_Quote__c, IST__Amount__c, IST__Calculation_Index__c, IST__Description__c, 
                                                               		IST__Paid_Date__c, IST__Percent__c, IST__stExternalID__c 
                                                               		from IST__Income_Fees__r), 
                                                              (Select Id, IsDeleted, Name, CurrencyIsoCode, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, 
                                                               		SystemModstamp, IST__Pricing_Quote__c, IST__Advance_Payment__c, IST__Calculation_Index__c, 
                                                               		IST__Description__c, IST__Num_Payments__c, IST__Start_Date__c, IST__Total_Funding__c, IST__Total_Payments__c, 
                                                               		IST__stExternalID__c, Loan_Rate__c 
                                                               		from IST__Loans__r), 
                                                              (Select Id, IsDeleted, Name, CurrencyIsoCode, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, 
                                                               		SystemModstamp, IST__Pricing_Quote__c, IST__Advance_Payment__c, IST__Calculation_Index__c, IST__Description__c, 
                                                               		IST__Num_Payments__c, IST__Total_Payments__c, IST__stExternalID__c, Quasi_Lease_Rate__c 
                                                               		from IST__Rents__r), 
                                                              (Select Id, IsDeleted, Name, CurrencyIsoCode, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, 
                                                               		SystemModstamp, LastActivityDate, Pricing_Quote__c, Active__c, Average_Payment__c, Description__c, 
                                                               		Num_Payments__c, Periodicity__c, Start_Date__c, stExternalID__c 
                                                               		from Periodic_Expenses__r), 
                                                              (Select Id, IsDeleted, Name, CurrencyIsoCode, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, 
                                                               		SystemModstamp, LastActivityDate, Pricing_Quote__c, Active__c, Average_Payment__c, Description__c, 
                                                               		Num_Payments__c, Periodicity__c, Start_Date__c, stExternalID__c, Insurance_Rate__c, Of_Payments__c, 
                                                               		Financed_Amount__c 
                                                               		from Periodic_Incomes__r), 
                                                              (Select Id, IsDeleted, Name, CurrencyIsoCode, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, 
                                                               		SystemModstamp, LastActivityDate, Pricing_Quote__c, Amount__c, Received__c, Returned__c, stExternalID__c 
                                                               		from Specified_Security_Deposits__r), 
                                                              (Select Id, IsDeleted, Name, CurrencyIsoCode, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, 
                                                               		SystemModstamp, LastActivityDate, Quote__c, Advance_Debt_Service__c, Advance_Rent__c, Arrears_Debt_Service__c, 
                                                               		Arrears_Rent__c, Number_of_Payments_Scheduled__c, TV_Date__c, Termination_Value_Amount__c, Termination_Value_Percent__c, 
                                                               		Total_Due_On_Termination__c 
                                                               		from TV_Schedule_Steps__r), 
                                                              (Select Id, IsDeleted, Name, CurrencyIsoCode, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, 
                                                               		SystemModstamp, LastActivityDate, Pricing_Quote__c, Active__c, Amount__c, Based_on__c, EBO_Date__c, 
                                                               		FMV__c, Premium__c, Term__c, stExternalID__c 
                                                               		from EBOs__r) 
                                                              From IST__SuperTRUMP_Pricing_Quote__c
                                                               where id = :PQ_ID]){
                                                                  IST_SuperTRUMP_Pricing_Quote = Pricing_Quote;
                                                                  
                                                              }
        if(IST_SuperTRUMP_Pricing_Quote != null){
        	Pricing_Quote_Wrapper =  SupperTRUMP_Parse_Pricing_Quote_cls.dropDataIntoWrapper(IST_SuperTRUMP_Pricing_Quote);   
        }
        return Pricing_Quote_Wrapper;
    }
    /**
    * @description 
    * @author eduardo.villegas@engeniumcapital.com | 7/10/2019 
    * @param String name 
    * @return SupperTRUMP_Pricing_Quote_Wrapper.query_All_Fields 
    **/
    public static SupperTRUMP_Pricing_Quote_Wrapper.query_All_Fields getAllFieldsByName(String name){
        SupperTRUMP_Pricing_Quote_Wrapper.query_All_Fields Pricing_Quote_Wrapper = new SupperTRUMP_Pricing_Quote_Wrapper.query_All_Fields();
        IST__SuperTRUMP_Pricing_Quote__c IST_SuperTRUMP_Pricing_Quote = new IST__SuperTRUMP_Pricing_Quote__c();
        for(IST__SuperTRUMP_Pricing_Quote__c Pricing_Quote : [Select Id, OwnerId, IsDeleted, Name, CurrencyIsoCode, RecordTypeId, CreatedDate, CreatedById, LastModifiedDate, 
                                                              LastModifiedById, SystemModstamp, LastActivityDate, LastViewedDate, LastReferencedDate, IST__Balloon__c, 
                                                              IST__Commencement__c, IST__Cost__c, IST__Delivery_Date__c, IST__Description__c, IST__FinanceType__c, 
                                                              IST__IRR_NPT__c, IST__Is_Synchronized__c, IST__Lending_Rate__c, IST__LessorFAS__c, IST__MISF_NAT__c, 
                                                              IST__Mode__c, IST__Opportunity__c, IST__Payment_Timing__c, IST__Payment__c, IST__Periodicity__c, 
                                                              IST__QuoteStatus__c, IST__Rent_IBR__c, IST__Residual__c, IST__Takedown__c, IST__Template__c, IST__Template__r.Name, IST__Term__c, 
                                                              IST__Total_Lending__c, IST__stExternalID__c, BookYield__c, Contributed_Value__c, Cost_of_Funds_Levered__c, 
                                                              Cost_of_Funds_Unlevered__c, Depreciation__c, Economic_ROE__c, Economic_ROI__c, Economic_Yield__c, 
                                                              Expense_ANI__c, Finance_Margin__c, Full_Term_Rate__c, FulltermRatewithresidual__c, Leverage__c, LossANI__c, 
                                                              MC_Currency__c, MoneyCostDateFound__c, Net_Income_Eco__c, Net_Income__c, Product__c, Rate_Type__c, 
                                                              Security_Deposit__c, created_in_SF__c, Opening_Fee__c, TotalBookANI__c, Periodicidad_mensuales_trimestrales__c, 
                                                              Tipo_de_pago__c, Tipo_de_Moneda__c, Moneda__c, Periodicidad_meses_trimestres__c, Opening_Fee_Amount__c, 
                                                              Plazo_en_texto__c, Fecha_pago_renta_vencida_anticipada__c, Advance_Payments__c, Additional_Rent__c, 
                                                              Fecha_Pago_Interes_Interino__c, Engenium_Legal_Entity__c, Advance_Payment_Loan__c, Cl_usula_Tasa_Efectiva_Variable__c, 
                                                              Periodicidad_mes_trimestre__c, Periodicidad_mensual_trimestral__c, Cla_sula_Tasa_Variable_No_Aplica_en_Fij__c, 
                                                              Proposal_With_Insurance__c, Quote_With_Insurance__c, Exchange_Rate__c, Apoderado_1__c, Apoderado_2__c, 
                                                              Security_Deposit_Percentage__c, ProposalToGo_Use_Count__c, Of_Payments__c, QuoteToGo_Use_Count__c, 
                                                              ProposalToGo_With_Insurance_Use_Count__c, Referral_Fee__c, QuoteToGo_With_Insurance_Use_Count__c, 
                                                              Opportunity_Collateral__c, Import_Services_Fee__c, Product_Name__c, Customer_Name__c, Residual_Value__c, 
                                                              Rapid_Tag_Fee__c, Average_Life_of_Asset_years__c, EBO_Active__c, Gross_Margin__c, Purchase_Option_Method__c, 
                                                              Residual_Guarantee_Type__c, Of_Payments_Loan__c, Security_Deposit_Method__c, Total_Purchase_Option_Fixed_Amount__c, 
                                                              Total_Residual_Guaranteed_Amount__c, Total_Residual_Guaranteed_Percent__c, Total_Residual_Unguaranteed_Amount__c, 
                                                              Total_Residual_Unguaranteed_Percent__c, Total_Security_Deposit__c, EBO__c, Insurance_Rate__c, Loan_Rate__c, 
                                                              Maintenance_Fee__c, Maintenance_Cost_With_Markup__c, Maintenance_Markup__c, Maintenance_Cost_Expense__c, 
                                                              Telematics_Fee_Income__c, Rapid_Tag_Policy_Income__c, Fines_Monitoring_Fee_Income__c, Rapid_Tag_Plates__c, 
                                                              Rapid_Tag_Emission_Control__c, PQ_Validity_for_Fleet_Date__c, Of_Insurance_Payments__c, Lease_Rate_Percentage__c, 
                                                              Insurance_Policy_Issuing_Cost__c, Total_Insurance_Cost__c, Insurance_Policy_Rebate__c, Insurance_Rebate_UDI__c, 
                                                              WOA_nu_Term_in_months_without_PP__c, WOA_nu_Term_in_Months_Including_PP__c, WOA_nu_Progress_Payments_M__c,
                                                              WOA_tl_Progress_Description__c, WOA_nu_Grace_Period_M__c, WOA_ls_Type_of_Grace_Period__c, WOA_ls_Low_High_High_Low__c,
                                                              WOA_tl_Low_High_High_Low_Description__c, WOA_pr_Advance_Payment__c, WOA_ls_EFA__c, WOA_ls_Used_New__c,
                                                              WOA_ls_SL_B_YES_NO__c, WOA_ls_EBO__c, WOA_tl_EBO_Description__c, WOA_tl_Asset_description__c, WOA_tl_Return_Condition__c,
                                                              WOA_pr_Remarketing_Fee__c, WOA_pr_Split_Trac__c, WOA_pr_Lock_Fee__c, WOA_tx_Boot_Collateral_Type__c, WOA_tl_EOL_Option__c,
                                                              WOA_ls_Prom_Note__c, WOA_ls_Carga_Peligrosa__c, WOA_ls_Cash_Collateral__c, WOA_ls_Cross_Collateral__c, WOA_ls_Direct_Debit__c,
                                                              WOA_nu_ROI_No_Insurance__c, WOA_pr_Opening_Fee__c, WOA_dv_Security_Deposit__c, WOA_pr_Security_Deposit__c,
                                                              WOA_at_Security_Deposit_Comments__c, WOA_pr_Rate__c, WOA_pr_RV__c, WOA_dv_Ballon_Bullet_Payment__c, WOA_pr_P_Option__c,
                                                              (Select Id from IST__Assets__r), 
                                                              (Select Id, IsDeleted, Name, CurrencyIsoCode, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, 
                                                               		SystemModstamp, IST__Pricing_Quote__c, IST__Amount__c, IST__Calculation_Index__c, IST__Description__c, 
                                                               		IST__Paid_Date__c, IST__Percent__c, IST__stExternalID__c 
                                                               		from IST__Expense_Fees__r), 
                                                              (Select Id, IsDeleted, Name, CurrencyIsoCode, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, 
                                                               		SystemModstamp, IST__Pricing_Quote__c, IST__Amount__c, IST__Calculation_Index__c, IST__Description__c, 
                                                               		IST__Paid_Date__c, IST__Percent__c, IST__stExternalID__c 
                                                               		from IST__Income_Fees__r), 
                                                              (Select Id, IsDeleted, Name, CurrencyIsoCode, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, 
                                                               		SystemModstamp, IST__Pricing_Quote__c, IST__Advance_Payment__c, IST__Calculation_Index__c, 
                                                               		IST__Description__c, IST__Num_Payments__c, IST__Start_Date__c, IST__Total_Funding__c, IST__Total_Payments__c, 
                                                               		IST__stExternalID__c, Loan_Rate__c 
                                                               		from IST__Loans__r), 
                                                              (Select Id, IsDeleted, Name, CurrencyIsoCode, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, 
                                                               		SystemModstamp, IST__Pricing_Quote__c, IST__Advance_Payment__c, IST__Calculation_Index__c, IST__Description__c, 
                                                               		IST__Num_Payments__c, IST__Total_Payments__c, IST__stExternalID__c, Quasi_Lease_Rate__c 
                                                               		from IST__Rents__r), 
                                                              (Select Id, IsDeleted, Name, CurrencyIsoCode, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, 
                                                               		SystemModstamp, LastActivityDate, Pricing_Quote__c, Active__c, Average_Payment__c, Description__c, 
                                                               		Num_Payments__c, Periodicity__c, Start_Date__c, stExternalID__c 
                                                               		from Periodic_Expenses__r), 
                                                              (Select Id, IsDeleted, Name, CurrencyIsoCode, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, 
                                                               		SystemModstamp, LastActivityDate, Pricing_Quote__c, Active__c, Average_Payment__c, Description__c, 
                                                               		Num_Payments__c, Periodicity__c, Start_Date__c, stExternalID__c, Insurance_Rate__c, Of_Payments__c, 
                                                               		Financed_Amount__c 
                                                               		from Periodic_Incomes__r), 
                                                              (Select Id, IsDeleted, Name, CurrencyIsoCode, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, 
                                                               		SystemModstamp, LastActivityDate, Pricing_Quote__c, Amount__c, Received__c, Returned__c, stExternalID__c 
                                                               		from Specified_Security_Deposits__r), 
                                                              (Select Id, IsDeleted, Name, CurrencyIsoCode, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, 
                                                               		SystemModstamp, LastActivityDate, Quote__c, Advance_Debt_Service__c, Advance_Rent__c, Arrears_Debt_Service__c, 
                                                               		Arrears_Rent__c, Number_of_Payments_Scheduled__c, TV_Date__c, Termination_Value_Amount__c, Termination_Value_Percent__c, 
                                                               		Total_Due_On_Termination__c 
                                                               		from TV_Schedule_Steps__r), 
                                                              (Select Id, IsDeleted, Name, CurrencyIsoCode, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, 
                                                               		SystemModstamp, LastActivityDate, Pricing_Quote__c, Active__c, Amount__c, Based_on__c, EBO_Date__c, 
                                                               		FMV__c, Premium__c, Term__c, stExternalID__c 
                                                               		from EBOs__r) 
                                                              From IST__SuperTRUMP_Pricing_Quote__c 
                                                              where name = :name]){
            IST_SuperTRUMP_Pricing_Quote = Pricing_Quote;                                                     
                                                              }
        if(IST_SuperTRUMP_Pricing_Quote != null){
        	Pricing_Quote_Wrapper =  SupperTRUMP_Parse_Pricing_Quote_cls.dropDataIntoWrapper(IST_SuperTRUMP_Pricing_Quote);   
        }
        return Pricing_Quote_Wrapper;
    }
    
    /**
    * @description 
    * @author eduardo.amiens@outlook.com | 09-30-2020 
    * @param setPQ_ID 
    * @return SupperTRUMP_Pricing_Quote_Wrapper.query_All_Fields 
    **/
    public static list<SupperTRUMP_Pricing_Quote_Wrapper.query_All_Fields> getAllFieldsBySetId(set<Id> setPQ_ID){
        list<SupperTRUMP_Pricing_Quote_Wrapper.query_All_Fields> listPricing_Quote_Wrapper = new list<SupperTRUMP_Pricing_Quote_Wrapper.query_All_Fields>();
        for(IST__SuperTRUMP_Pricing_Quote__c Pricing_Quote : [Select Id, OwnerId, IsDeleted, Name, CurrencyIsoCode, RecordTypeId, CreatedDate, CreatedById, LastModifiedDate, 
                                                              LastModifiedById, SystemModstamp, LastActivityDate, LastViewedDate, LastReferencedDate, IST__Balloon__c, 
                                                              IST__Commencement__c, Of_Payments_Loan__c, IST__Cost__c, IST__Delivery_Date__c, IST__Description__c, IST__FinanceType__c, 
                                                              IST__IRR_NPT__c, IST__Is_Synchronized__c, IST__Lending_Rate__c, IST__LessorFAS__c, IST__MISF_NAT__c, 
                                                              IST__Mode__c, IST__Opportunity__c, IST__Payment_Timing__c, IST__Payment__c, IST__Periodicity__c, 
                                                              IST__QuoteStatus__c, IST__Rent_IBR__c, IST__Residual__c, IST__Takedown__c, IST__Template__c,IST__Template__r.Name, IST__Term__c, 
                                                              IST__Total_Lending__c, IST__stExternalID__c, BookYield__c, Contributed_Value__c, Cost_of_Funds_Levered__c, 
                                                              Cost_of_Funds_Unlevered__c, Depreciation__c, Economic_ROE__c, Economic_ROI__c, Economic_Yield__c, 
                                                              Expense_ANI__c, Finance_Margin__c, Full_Term_Rate__c, FulltermRatewithresidual__c, Leverage__c, LossANI__c, 
                                                              MC_Currency__c, MoneyCostDateFound__c, Net_Income_Eco__c, Net_Income__c, Product__c, Rate_Type__c, 
                                                              Security_Deposit__c, created_in_SF__c, Opening_Fee__c, TotalBookANI__c, Periodicidad_mensuales_trimestrales__c, 
                                                              Tipo_de_pago__c, Tipo_de_Moneda__c, Moneda__c, Periodicidad_meses_trimestres__c, Opening_Fee_Amount__c, 
                                                              Plazo_en_texto__c, Fecha_pago_renta_vencida_anticipada__c, Advance_Payments__c, Additional_Rent__c, 
                                                              Fecha_Pago_Interes_Interino__c, Engenium_Legal_Entity__c, Advance_Payment_Loan__c, Cl_usula_Tasa_Efectiva_Variable__c, 
                                                              Periodicidad_mes_trimestre__c, Periodicidad_mensual_trimestral__c, Cla_sula_Tasa_Variable_No_Aplica_en_Fij__c, 
                                                              Proposal_With_Insurance__c, Quote_With_Insurance__c, Exchange_Rate__c, Apoderado_1__c, Apoderado_2__c, 
                                                              Security_Deposit_Percentage__c, ProposalToGo_Use_Count__c, Of_Payments__c, QuoteToGo_Use_Count__c, 
                                                              ProposalToGo_With_Insurance_Use_Count__c, Referral_Fee__c, QuoteToGo_With_Insurance_Use_Count__c, 
                                                              Opportunity_Collateral__c, Import_Services_Fee__c, Product_Name__c, Customer_Name__c, Residual_Value__c, 
                                                              Rapid_Tag_Fee__c, Average_Life_of_Asset_years__c, EBO_Active__c, Gross_Margin__c, Purchase_Option_Method__c, 
                                                              Residual_Guarantee_Type__c, Security_Deposit_Method__c, Total_Purchase_Option_Fixed_Amount__c, 
                                                              Total_Residual_Guaranteed_Amount__c, Total_Residual_Guaranteed_Percent__c, Total_Residual_Unguaranteed_Amount__c, 
                                                              Total_Residual_Unguaranteed_Percent__c, Total_Security_Deposit__c, EBO__c, Insurance_Rate__c, Loan_Rate__c, 
                                                              Maintenance_Fee__c, Maintenance_Cost_With_Markup__c, Maintenance_Markup__c, Maintenance_Cost_Expense__c, 
                                                              Telematics_Fee_Income__c, Rapid_Tag_Policy_Income__c, Fines_Monitoring_Fee_Income__c, Rapid_Tag_Plates__c, 
                                                              Rapid_Tag_Emission_Control__c, PQ_Validity_for_Fleet_Date__c, Of_Insurance_Payments__c, Lease_Rate_Percentage__c, 
                                                              Insurance_Policy_Issuing_Cost__c, Total_Insurance_Cost__c, Insurance_Policy_Rebate__c, Insurance_Rebate_UDI__c, 
                                                              WOA_nu_Term_in_months_without_PP__c, WOA_nu_Term_in_Months_Including_PP__c, WOA_nu_Progress_Payments_M__c,
                                                              WOA_tl_Progress_Description__c, WOA_nu_Grace_Period_M__c, WOA_ls_Type_of_Grace_Period__c, WOA_ls_Low_High_High_Low__c,
                                                              WOA_tl_Low_High_High_Low_Description__c, WOA_pr_Advance_Payment__c, WOA_ls_EFA__c, WOA_ls_Used_New__c,
                                                              WOA_ls_SL_B_YES_NO__c, WOA_ls_EBO__c, WOA_tl_EBO_Description__c, WOA_tl_Asset_description__c, WOA_tl_Return_Condition__c,
                                                              WOA_pr_Remarketing_Fee__c, WOA_pr_Split_Trac__c, WOA_pr_Lock_Fee__c, WOA_tx_Boot_Collateral_Type__c, WOA_tl_EOL_Option__c,
                                                              WOA_ls_Prom_Note__c, WOA_ls_Carga_Peligrosa__c, WOA_ls_Cash_Collateral__c, WOA_ls_Cross_Collateral__c, WOA_ls_Direct_Debit__c,
                                                              WOA_nu_ROI_No_Insurance__c, WOA_pr_Opening_Fee__c, WOA_dv_Security_Deposit__c, WOA_pr_Security_Deposit__c,
                                                              WOA_at_Security_Deposit_Comments__c, WOA_pr_Rate__c, WOA_pr_RV__c, WOA_dv_Ballon_Bullet_Payment__c, WOA_pr_P_Option__c,
                                                              (Select Id from IST__Assets__r), 
                                                              (Select Id, IsDeleted, Name, CurrencyIsoCode, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, 
                                                               		SystemModstamp, IST__Pricing_Quote__c, IST__Amount__c, IST__Calculation_Index__c, IST__Description__c, 
                                                               		IST__Paid_Date__c, IST__Percent__c, IST__stExternalID__c 
                                                               		from IST__Expense_Fees__r), 
                                                              (Select Id, IsDeleted, Name, CurrencyIsoCode, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, 
                                                               		SystemModstamp, IST__Pricing_Quote__c, IST__Amount__c, IST__Calculation_Index__c, IST__Description__c, 
                                                               		IST__Paid_Date__c, IST__Percent__c, IST__stExternalID__c 
                                                               		from IST__Income_Fees__r), 
                                                              (Select Id, IsDeleted, Name, CurrencyIsoCode, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, 
                                                               		SystemModstamp, IST__Pricing_Quote__c, IST__Advance_Payment__c, IST__Calculation_Index__c, 
                                                               		IST__Description__c, IST__Num_Payments__c, IST__Start_Date__c, IST__Total_Funding__c, IST__Total_Payments__c, 
                                                               		IST__stExternalID__c, Loan_Rate__c 
                                                               		from IST__Loans__r), 
                                                              (Select Id, IsDeleted, Name, CurrencyIsoCode, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, 
                                                               		SystemModstamp, IST__Pricing_Quote__c, IST__Advance_Payment__c, IST__Calculation_Index__c, IST__Description__c, 
                                                               		IST__Num_Payments__c, IST__Total_Payments__c, IST__stExternalID__c, Quasi_Lease_Rate__c 
                                                               		from IST__Rents__r), 
                                                              (Select Id, IsDeleted, Name, CurrencyIsoCode, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, 
                                                               		SystemModstamp, LastActivityDate, Pricing_Quote__c, Active__c, Average_Payment__c, Description__c, 
                                                               		Num_Payments__c, Periodicity__c, Start_Date__c, stExternalID__c 
                                                               		from Periodic_Expenses__r), 
                                                              (Select Id, IsDeleted, Name, CurrencyIsoCode, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, 
                                                               		SystemModstamp, LastActivityDate, Pricing_Quote__c, Active__c, Average_Payment__c, Description__c, 
                                                               		Num_Payments__c, Periodicity__c, Start_Date__c, stExternalID__c, Insurance_Rate__c, Of_Payments__c, 
                                                               		Financed_Amount__c 
                                                               		from Periodic_Incomes__r), 
                                                              (Select Id, IsDeleted, Name, CurrencyIsoCode, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, 
                                                               		SystemModstamp, LastActivityDate, Pricing_Quote__c, Amount__c, Received__c, Returned__c, stExternalID__c 
                                                               		from Specified_Security_Deposits__r), 
                                                              (Select Id, IsDeleted, Name, CurrencyIsoCode, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, 
                                                               		SystemModstamp, LastActivityDate, Quote__c, Advance_Debt_Service__c, Advance_Rent__c, Arrears_Debt_Service__c, 
                                                               		Arrears_Rent__c, Number_of_Payments_Scheduled__c, TV_Date__c, Termination_Value_Amount__c, Termination_Value_Percent__c, 
                                                               		Total_Due_On_Termination__c 
                                                               		from TV_Schedule_Steps__r), 
                                                              (Select Id, IsDeleted, Name, CurrencyIsoCode, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, 
                                                               		SystemModstamp, LastActivityDate, Pricing_Quote__c, Active__c, Amount__c, Based_on__c, EBO_Date__c, 
                                                               		FMV__c, Premium__c, Term__c, stExternalID__c 
                                                               		from EBOs__r) 
                                                              From IST__SuperTRUMP_Pricing_Quote__c
                                                               where id in :setPQ_ID]){
            if(Pricing_Quote != null){
                listPricing_Quote_Wrapper.add(SupperTRUMP_Parse_Pricing_Quote_cls.dropDataIntoWrapper(Pricing_Quote));
            }                                                                  
        }        
        return listPricing_Quote_Wrapper;
    }

    	

}