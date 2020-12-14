let makeOrderHeaderFields = (listHeader)=>{

    let listOrderedHeader = [];
    for(let element of listHeader){
        listOrderedHeader.push({
            CONTRACT_NUMBER : element.CONTRACT_NUMBER,
            LEGAL_ENTITY : element.LEGAL_ENTITY,
            OPERATING_UNIT : element.OPERATING_UNIT, 
            CONTRACT_DESCRIPTION : element.CONTRACT_DESCRIPTION,
            CURRENCY_CODE : element.CURRENCY_CODE,
            CURRENCY_CONVERSION_DATE : element.CURRENCY_CONVERSION_DATE,
            CURRENCY_CONVERSION_TYPE : element.CURRENCY_CONVERSION_TYPE,
            CURRENCY_CONVERSION_RATE : element.CURRENCY_CONVERSION_RATE,
            TERM : element.TERM,
            EFFECTIVE_FROM : element.EFFECTIVE_FROM,
            EXPECTED_DELIVERY_DATE : element.EXPECTED_DELIVERY_DATE,
            ACCEPTANCE_DATE : element.ACCEPTANCE_DATE,
            DATE_SIGNED : element.DATE_SIGNED,
            LEGACY_NUMBER : element.LEGACY_NUMBER,
            SALES_REP : element.SALES_REP,
            CUSTOMER_PO : element.CUSTOMER_PO,
            CONTRACT_TEMPLATE : element.CONTRACT_TEMPLATE,
            FINANCE_PRODUCT : element.FINANCE_PRODUCT,
            CUSTOMER_NAME : element.CUSTOMER_NAME,
            BILL_TO_SITE_LOCATION : element.BILL_TO_SITE_LOCATION,
            LINEA_DE_NEGOCIO : element.LINEA_DE_NEGOCIO,
            NUMERO_DEL_DOCUMENTO_LEGAL : element.NUMERO_DEL_DOCUMENTO_LEGAL,
            YIELD : element.YIELD,
            PRODUCTO : element.PRODUCTO,
            CALIFICATION_DE_CREDITO : element.CALIFICATION_DE_CREDITO,
            NUMERO_DE_ACTA : element.NUMERO_DE_ACTA,
            FECHA_DE_LA_NOTARIA : element.FECHA_DE_LA_NOTARIA,
            EVERGREEN_ELIGIBLE_FLAG : element.EVERGREEN_ELIGIBLE_FLAG,
            EARLY_TERMINATION_PURCHASE_AMOUNT : element.EARLY_TERMINATION_PURCHASE_AMOUNT,
            END_OF_TERM_PURCHASE_AMOUNT : element.END_OF_TERM_PURCHASE_AMOUNT,
            INSURANCE_POLICY_NUMBER : element.INSURANCE_POLICY_NUMBER,
            QUOTE_EFFECTIVE_FROM : element.QUOTE_EFFECTIVE_FROM,
            QUOTE_EFFECTIVE_TO : element.QUOTE_EFFECTIVE_TO,
            INSURANCE_EFFECTIVE_FROM : element.INSURANCE_EFFECTIVE_FROM,
            LOCATION : element.LOCATION,
            LESSOR_INSURED : element.LESSOR_INSURED,
            LESSOR_PAYEE : element.LESSOR_PAYEE,
            INSURANCE_PROVIDER : element.INSURANCE_PROVIDER,
            INSURANCE_PAYMENT_FREQUENCY : element.INSURANCE_PAYMENT_FREQUENCY,
            INSURANCE_TERM : element.INSURANCE_TERM,
            INSURANCE_ADJUSTMENT : element.INSURANCE_ADJUSTMENT,
            INSURANCE_SALESPERSON : element.INSURANCE_SALESPERSON,
            MULTI_ANNUAL_POLICY : element.MULTI_ANNUAL_POLICY,
            CONTRACT_IMPORT_STATUS : element.CONTRACT_IMPORT_STATUS,
            PREFUNDING_YN : element.PREFUNDING_YN,
            VAR_INDEX_NAME : element.VAR_INDEX_NAME,
            VAR_BASE_RATE : element.VAR_BASE_RATE,
            VAR_ADDR_RATE : element.VAR_ADDR_RATE,
            DAYS_IN_YEAR : element.DAYS_IN_YEAR,
            DAYS_IN_MONTH : element.DAYS_IN_MONTH
        });
            
    }
    return listOrderedHeader;
}

let makeOrderLineFields = (listLines)=>{
    let listOrderedline = [];
    for(let element of listLines){
        listOrderedline.push({
            CONTRACT_NUMBER : element.CONTRACT_NUMBER,
            FEE_NAME : element.FEE_NAME,
            FEE_TYPE : element.FEE_TYPE,
            FEE_AMOUNT : element.FEE_AMOUNT,
            ASSET_NUMBER : element.ASSET_NUMBER,
            ASSET_DESCRIPTION : element.ASSET_DESCRIPTION,
            SERIAL_NUMBER : element.SERIAL_NUMBER,
            ITEM_NUMBER : element.ITEM_NUMBER,
            ASSET_USAGE_FOR_TAX : element.ASSET_USAGE_FOR_TAX,
            UNITS : element.UNITS,
            UNIT_COST : element.UNIT_COST,
            MODEL : element.MODEL,
            MANUFACTURER : element.MANUFACTURER,
            YEAR_OF_MANUFACTURE : element.YEAR_OF_MANUFACTURE,
            EXPECTED_FUNDING_DATE : element.EXPECTED_FUNDING_DATE,
            IN_SERVICE_DATE : element.IN_SERVICE_DATE,
            RESIDUAL_AMOUNT : element.RESIDUAL_AMOUNT,
            GUARANTOR : element.GUARANTOR,
            GUARNTEED_AMOUNT : element.GUARNTEED_AMOUNT,
            SUPPLIER : element.SUPPLIER,
            SUPPLIER_SITE : element.SUPPLIER_SITE,
            SUPPLIER_INVOICE : element.SUPPLIER_INVOICE,
            SUPPLIER_INVOICE_DATE : element.SUPPLIER_INVOICE_DATE,
            VEHICLE_IDENTIFIER : element.VEHICLE_IDENTIFIER,
            IMPORT_DATE : element.IMPORT_DATE,
            IMPORT_CERTIFICATE : element.IMPORT_CERTIFICATE,
            SHIPPING_NUMBER : element.SHIPPING_NUMBER,
            INVOICE_DESCRIPTION : element.INVOICE_DESCRIPTION,
            IMPORT_ADDRESS : element.IMPORT_ADDRESS,
            IMPORT_INVOICE : element.IMPORT_INVOICE,
            SHIPPING_NAME : element.SHIPPING_NAME,
            INSTALL_AT_SITE_LOCATION : element.INSTALL_AT_SITE_LOCATION,
            FIXED_ASSETS_LOCATION : element.FIXED_ASSETS_LOCATION,
            SUBSIDY_NAME : element.SUBSIDY_NAME,
            SUBSIDY_AMOUNT : element.SUBSIDY_AMOUNT,
            INSURANCE_REBATE_AMOUNT : element.INSURANCE_REBATE_AMOUNT,
            DOWNPAYMENT_RECEIVER_CODE : element.DOWNPAYMENT_RECEIVER_CODE,
            CAPITALIZE_DOWN_PMT : element.CAPITALIZE_DOWN_PMT,
            DOWNPAYMENT_AMOUNT : element.DOWNPAYMENT_AMOUNT,
            INTERIM_RENT_START_DATE : element.INTERIM_RENT_START_DATE,
            INTERIM_RENT_AMOUNT : element.INTERIM_RENT_AMOUNT,
            PAYMENT_FREQUENCY : element.PAYMENT_FREQUENCY,
            PAYMENT_ORDER : element.PAYMENT_ORDER,
            PERIOD : element.PERIOD,
            PAYMENT_AMOUNT : element.PAYMENT_AMOUNT,
            ARREARS_FLAG : element.ARREARS_FLAG,
            PAYMENT_TYPE : element.PAYMENT_TYPE,
            EVERGREEN_PERIOD : element.EVERGREEN_PERIOD,
            EVERGREEN_FREQUENCY : element.EVERGREEN_FREQUENCY,
            EVERGREEN_AMOUNT : element.EVERGREEN_AMOUNT
        });
            
    }
    return listOrderedline;
}

let workDownload = (s) => {
    let buf = new ArrayBuffer(s.length);
    let view = new Uint8Array(buf);
    for(let i=0; i<s.length; i++) view[i] = s.charCodeAt(i) & 0xFF;
    return buf;    
}


export {makeOrderHeaderFields, makeOrderLineFields, workDownload};