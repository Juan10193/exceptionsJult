@Istest
public class Takedown_Wrapper_Contract_Import_Test {
    @Istest
    public static void TakedownWrapperContractImport(){
        Takedown_Wrapper_Contract_Import_cls.Contract_Import  contract = new Takedown_Wrapper_Contract_Import_cls.Contract_Import();
        contract.listHeaders = new list<Takedown_Wrapper_Contract_Import_cls.Headers>();
        contract.listLines = new list<Takedown_Wrapper_Contract_Import_cls.Lines>();   
        
        Takedown_Wrapper_Contract_Import_cls.Headers headers = new Takedown_Wrapper_Contract_Import_cls.Headers();
        headers.CONTRACT_NUMBER='123';
        headers.LEGAL_ENTITY='LEGAL_ENTITY';
        headers.OPERATING_UNIT='UNIT';
        headers.CONTRACT_DESCRIPTION='DESCRIPTION';
        headers.CURRENCY_CODE='CODE';
        headers.CURRENCY_CONVERSION_DATE='DATE';
        headers.CURRENCY_CONVERSION_TYPE= 'TYPE';
        headers.CURRENCY_CONVERSION_RATE = 3.5;
        headers.TERM = 2.5;
        headers.EFFECTIVE_FROM='EFFECTIVE';
        headers.EXPECTED_DELIVERY_DATE='EXPECTED';
        headers.ACCEPTANCE_DATE='ACCEPTANCE';
        headers.DATE_SIGNED='DATE';
        headers.LEGACY_NUMBER='NUMBER';
        headers.SALES_REP='SALES';
        headers.CUSTOMER_PO='PO';
        headers.CONTRACT_TEMPLATE='CONTRACT';
        headers.FINANCE_PRODUCT='PRODUCT';
        headers.CUSTOMER_NAME='CUSTOMER';
        headers.BILL_TO_SITE_LOCATION='LOCATION';
        headers.LINEA_DE_NEGOCIO='NEGOCIO';
        headers.NUMERO_DEL_DOCUMENTO_LEGAL='DOCUMENTO';
        headers.YIELD=3.7;
        headers.PRODUCTO='PRODUCTO';
        headers.CALIFICATION_DE_CREDITO='CALIFICACION';
        headers.NUMERO_DE_ACTA='ACTA';
        headers.FECHA_DE_LA_NOTARIA = Date.newInstance(2019, 09, 30);
        headers.EVERGREEN_ELIGIBLE_FLAG=3.3;
        headers.EARLY_TERMINATION_PURCHASE_AMOUNT = 2.3;
        headers.END_OF_TERM_PURCHASE_AMOUNT = 1.3;
        headers.INSURANCE_POLICY_NUMBER = 'POLICY';
        headers.QUOTE_EFFECTIVE_FROM = Date.newInstance(2019, 09, 30);
        headers.QUOTE_EFFECTIVE_TO = Date.newInstance(2019, 09, 30);
        headers.INSURANCE_EFFECTIVE_FROM = Date.newInstance(2019, 09, 30);
        headers.LOCATION = 'LOCATION';
        headers.LESSOR_INSURED = 'INSURED';
        headers.LESSOR_PAYEE ='PAYYE';
        headers.INSURANCE_PROVIDER='PROVIDER';
        headers.INSURANCE_PAYMENT_FREQUENCY = 'FREQUENCY';
        headers.INSURANCE_TERM = 'TERM';
        headers.INSURANCE_ADJUSTMENT = 3.4; 
        headers.INSURANCE_SALESPERSON='SALES';
        headers.MULTI_ANNUAL_POLICY='POLICY';
        headers.CONTRACT_IMPORT_STATUS='STATUS';
        headers.PREFUNDING_YN='TN';
        headers.VAR_INDEX_NAME='NAME';
        headers.VAR_BASE_RATE=2.3;
        headers.VAR_ADDR_RATE=2.4;
        headers.DAYS_IN_YEAR=2.5;
        headers.DAYS_IN_MONTH=2.5;
        
        Takedown_Wrapper_Contract_Import_cls.Lines lines = new Takedown_Wrapper_Contract_Import_cls.Lines();
       
            lines.CONTRACT_NUMBER ='123';
            lines.FEE_NAME='NAME';
            lines.FEE_TYPE= 'TYPE'; 
            lines.FEE_AMOUNT = 'AMOUNT';        
            lines.ASSET_NUMBER='NUMBER';
            lines.ASSET_DESCRIPTION='DESCRIPCION';
            lines.CURRENCY_CONVERSION_TYPE='CURRENCY';
            lines.SERIAL_NUMBER='SERIAL NUMBER';
            lines.ITEM_NUMBER='ITEM NUMBER';
            lines.ASSET_USAGE_FOR_TAX='USAGE TAX';             
            lines.UNITS= 'UNITS';
            lines.UNIT_COST=35.5;
            lines.MODEL='MODEL';
            lines.MANUFACTURER='MANOFACTURA';
            lines.YEAR_OF_MANUFACTURE='MANOFACTURA';
            lines.EXPECTED_FUNDING_DATE='EXPECTED';
            lines.IN_SERVICE_DATE ='SERVICE';       
            lines.RESIDUAL_AMOUNT = 'AMOUNT';
            lines.GUARANTOR = 'GUARANTOR';
            lines.GUARNTEED_AMOUNT ='GUARNTEED';
            lines.SUPPLIER ='SUPPLIER';
            lines.SUPPLIER_SITE ='SITE';
            lines.SUPPLIER_INVOICE ='INVOICE';
            lines.SUPPLIER_INVOICE_DATE ='INVOICE_DATE';
            lines.VEHICLE_IDENTIFIER ='IDENTIFIER';
            lines.IMPORT_DATE ='DATE';
            lines.IMPORT_CERTIFICATE=  Date.newInstance(2019, 09, 30);
            lines.SHIPPING_NUMBER =35.5;        
            lines.INVOICE_DESCRIPTION =35.5;
            lines.IMPORT_ADDRESS =35.5;
            lines.IMPORT_INVOICE ='INVOICE';
            lines.SHIPPING_NAME = Date.newInstance(2019, 09, 30);
            lines.INSTALL_AT_SITE_LOCATION = Date.newInstance(2019, 09, 30);
            lines.FIXED_ASSETS_LOCATION =  Date.newInstance(2019, 09, 30);               
            lines.SUBSIDY_NAME ='SUBSIDY NAME';
            lines.SUBSIDY_AMOUNT ='SUBSIDY AMOUNT';
            lines.INSURANCE_REBATE_AMOUNT ='REBATE AMOUNT';
            lines.DOWNPAYMENT_RECEIVER_CODE ='RECEIVER CODE';
            lines.CAPITALIZE_DOWN_PMT ='DOWN PMT';
            lines.DOWNPAYMENT_AMOUNT ='AMOUNT';       
            lines.INTERIM_RENT_START_DATE =35.5;
            lines.INTERIM_RENT_AMOUNT ='RENT AMOUNT';
            lines.PAYMENT_FREQUENCY ='FREQUENCY ';
            lines.PAYMENT_ORDER ='ORDER';
            lines.PERIOD ='PERIOD';
            lines.PAYMENT_AMOUNT =35.5;
            lines.ARREARS_FLAG ='FLAG';
            lines.PAYMENT_TYPE ='TYPE';
            lines.EVERGREEN_PERIOD =35.5;        
            lines.EVERGREEN_FREQUENCY =35.5;
            lines.EVERGREEN_AMOUNT =35.5;
        
        
        Takedown_Wrapper_Contract_Import_cls.SuperTrump_FEE superTrump=  new Takedown_Wrapper_Contract_Import_cls.SuperTrump_FEE();
        superTrump.FEE_NAME='SuperTrumName';
        superTrump.FEE_AMOUNT='SuperTrumpAmount';
        superTrump.FEE_TYPE='SuperTrumpType';
        
    }
    
     

}