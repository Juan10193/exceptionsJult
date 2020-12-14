/**
 * @File Name          : Takedown_Wrapper_Contract_Import_cls.cls
 * @Description        : 
 * @Author             : eduardo.villegas@engeniumcapital.com
 * @Group              : 
 * @Last Modified By   : eduardo.villegas@engeniumcapital.com
 * @Last Modified On   : 15/10/2019 22:00:18
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    15/10/2019   eduardo.villegas@engeniumcapital.com     Initial Version
**/
public class Takedown_Wrapper_Contract_Import_cls {
    public class Contract_Import {
        @AuraEnabled
        public list<Headers> listHeaders 	{get;set;}
        @AuraEnabled
        public list<Lines> listLines 		{get;set;}        
    }
    public class Headers { 
        @AuraEnabled
        public String CONTRACT_NUMBER {get;set;}
        @AuraEnabled
        public String LEGAL_ENTITY {get;set;}
        @AuraEnabled
        public String OPERATING_UNIT {get;set;}
        @AuraEnabled
        public String CONTRACT_DESCRIPTION {get;set;}
        @AuraEnabled
        public String CURRENCY_CODE {get;set;}
        @AuraEnabled
        public string CURRENCY_CONVERSION_DATE {get;set;}
        @AuraEnabled
        public String CURRENCY_CONVERSION_TYPE {get;set;}
        @AuraEnabled
        public double CURRENCY_CONVERSION_RATE {get;set;}
        @AuraEnabled
        public double TERM {get;set;}
        @AuraEnabled
        public string EFFECTIVE_FROM {get;set;}
        @AuraEnabled
        public string EXPECTED_DELIVERY_DATE {get;set;}
        @AuraEnabled
        public string ACCEPTANCE_DATE {get;set;}
        @AuraEnabled
        public string DATE_SIGNED {get;set;}
        @AuraEnabled
        public String LEGACY_NUMBER {get;set;}
        @AuraEnabled
        public String SALES_REP {get;set;}
        @AuraEnabled
        public String CUSTOMER_PO {get;set;}
        @AuraEnabled
        public String CONTRACT_TEMPLATE {get;set;}
        @AuraEnabled
        public String FINANCE_PRODUCT {get;set;}
        @AuraEnabled
        public String CUSTOMER_NAME {get;set;} 
        @AuraEnabled
        public String BILL_TO_SITE_LOCATION {get;set;}
        @AuraEnabled
        public String LINEA_DE_NEGOCIO {get;set;}
        @AuraEnabled
        public String NUMERO_DEL_DOCUMENTO_LEGAL {get;set;}
        @AuraEnabled
        public double YIELD {get;set;}
        @AuraEnabled
        public String PRODUCTO {get;set;}
        @AuraEnabled
        public String CALIFICATION_DE_CREDITO {get;set;}
        @AuraEnabled
        public String NUMERO_DE_ACTA {get;set;}
        @AuraEnabled
        public date FECHA_DE_LA_NOTARIA {get;set;}
        @AuraEnabled
        public double EVERGREEN_ELIGIBLE_FLAG {get;set;}
        @AuraEnabled
        public double EARLY_TERMINATION_PURCHASE_AMOUNT {get;set;}
        @AuraEnabled
        public double END_OF_TERM_PURCHASE_AMOUNT {get;set;}
        @AuraEnabled
        public String INSURANCE_POLICY_NUMBER {get;set;}
        @AuraEnabled
        public date QUOTE_EFFECTIVE_FROM {get;set;}
        @AuraEnabled
        public date QUOTE_EFFECTIVE_TO {get;set;} 
        @AuraEnabled
        public date INSURANCE_EFFECTIVE_FROM {get;set;}
        @AuraEnabled
        public String LOCATION {get;set;}
        @AuraEnabled
        public String LESSOR_INSURED {get;set;}
        @AuraEnabled
        public String LESSOR_PAYEE {get;set;}
        @AuraEnabled
        public String INSURANCE_PROVIDER {get;set;}
        @AuraEnabled
        public String INSURANCE_PAYMENT_FREQUENCY {get;set;}
        @AuraEnabled
        public String INSURANCE_TERM {get;set;}
        @AuraEnabled
        public double INSURANCE_ADJUSTMENT {get;set;}
        @AuraEnabled
        public String INSURANCE_SALESPERSON {get;set;}
        @AuraEnabled
        public String MULTI_ANNUAL_POLICY {get;set;}
        @AuraEnabled
        public String CONTRACT_IMPORT_STATUS {get;set;}
        @AuraEnabled
        public String PREFUNDING_YN {get;set;}
        @AuraEnabled
        public String VAR_INDEX_NAME {get;set;}
        @AuraEnabled
        public double VAR_BASE_RATE {get;set;}
        @AuraEnabled
        public double VAR_ADDR_RATE {get;set;}
        @AuraEnabled
        public double DAYS_IN_YEAR {get;set;}
        @AuraEnabled
        public double DAYS_IN_MONTH {get;set;}
    }
    
    public class Lines{
        @AuraEnabled
        public String CONTRACT_NUMBER {get;set;}
        @AuraEnabled
        public String FEE_NAME {get;set;}
        @AuraEnabled
        public String FEE_TYPE {get;set;}
        @AuraEnabled
        public String FEE_AMOUNT {get;set;}        
        @AuraEnabled
        public String ASSET_NUMBER {get;set;}
        @AuraEnabled
        public String ASSET_DESCRIPTION {get;set;}
        @AuraEnabled
        public String CURRENCY_CONVERSION_TYPE {get;set;}
        @AuraEnabled
        public String SERIAL_NUMBER {get;set;}
        @AuraEnabled
        public String ITEM_NUMBER {get;set;}
        @AuraEnabled
        public String ASSET_USAGE_FOR_TAX {get;set;}              
        @AuraEnabled
        public String UNITS {get;set;}
        @AuraEnabled
        public double UNIT_COST {get;set;}
        @AuraEnabled
        public String MODEL {get;set;}
        @AuraEnabled
        public String MANUFACTURER {get;set;}
        @AuraEnabled
        public String YEAR_OF_MANUFACTURE {get;set;}
        @AuraEnabled
        public String EXPECTED_FUNDING_DATE {get;set;}
        @AuraEnabled
        public String IN_SERVICE_DATE {get;set;}        
        @AuraEnabled
        public String RESIDUAL_AMOUNT {get;set;}
        @AuraEnabled
        public String GUARANTOR {get;set;} 
        @AuraEnabled
        public String GUARNTEED_AMOUNT {get;set;}
        @AuraEnabled
        public String SUPPLIER {get;set;}
        @AuraEnabled
        public String SUPPLIER_SITE {get;set;}
        @AuraEnabled
        public string SUPPLIER_INVOICE {get;set;}
        @AuraEnabled
        public String SUPPLIER_INVOICE_DATE {get;set;}
        @AuraEnabled
        public String VEHICLE_IDENTIFIER {get;set;}
        @AuraEnabled
        public String IMPORT_DATE {get;set;}
        @AuraEnabled
        public date IMPORT_CERTIFICATE {get;set;}
        @AuraEnabled
        public double SHIPPING_NUMBER {get;set;}        
        @AuraEnabled
        public double INVOICE_DESCRIPTION {get;set;}
        @AuraEnabled
        public double IMPORT_ADDRESS {get;set;}
        @AuraEnabled
        public String IMPORT_INVOICE {get;set;}
        @AuraEnabled
        public date SHIPPING_NAME {get;set;}
        @AuraEnabled
        public date INSTALL_AT_SITE_LOCATION {get;set;} 
        @AuraEnabled
        public date FIXED_ASSETS_LOCATION {get;set;}               
        @AuraEnabled
        public String SUBSIDY_NAME {get;set;}
        @AuraEnabled
        public String SUBSIDY_AMOUNT {get;set;}
        @AuraEnabled
        public String INSURANCE_REBATE_AMOUNT {get;set;}
        @AuraEnabled
        public String DOWNPAYMENT_RECEIVER_CODE {get;set;}
        @AuraEnabled
        public String CAPITALIZE_DOWN_PMT {get;set;}
        @AuraEnabled
        public String DOWNPAYMENT_AMOUNT {get;set;}       
        @AuraEnabled
        public double INTERIM_RENT_START_DATE {get;set;}
        @AuraEnabled
        public String INTERIM_RENT_AMOUNT {get;set;}
        @AuraEnabled
        public String PAYMENT_FREQUENCY {get;set;}
        @AuraEnabled
        public String PAYMENT_ORDER {get;set;}
        @AuraEnabled
        public String PERIOD {get;set;}
        @AuraEnabled
        public double PAYMENT_AMOUNT {get;set;}
        @AuraEnabled
        public string ARREARS_FLAG {get;set;}
        @AuraEnabled
        public string PAYMENT_TYPE {get;set;}
        @AuraEnabled
        public double EVERGREEN_PERIOD {get;set;}        
        @AuraEnabled
        public double EVERGREEN_FREQUENCY {get;set;}
        @AuraEnabled
        public double EVERGREEN_AMOUNT {get;set;}
    }
    
    public class SuperTrump_FEE {
        @AuraEnabled
        public String FEE_NAME {get;set;}	
        @AuraEnabled
        public String FEE_TYPE {get;set;}
        @AuraEnabled
        public String FEE_AMOUNT {get;set;}
    }


}