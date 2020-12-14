const FIELDS_TO_GET_RECORD = ['Takedown_Invoice__c.Name', 'Takedown_Invoice__c.CurrencyIsoCode', 'Takedown_Invoice__c.CreatedDate', 'Takedown_Invoice__c.CreatedById', 'Takedown_Invoice__c.LastModifiedDate', 
'Takedown_Invoice__c.TKD_txt_RFC__c', 'Takedown_Invoice__c.TKD_tx_Supplier_name__c', 'Takedown_Invoice__c.TKD_txt_Content_Version_ID__c', 'Takedown_Invoice__c.TKD_txt_Document_ID__c', 
'Takedown_Invoice__c.TKD_txt_Extension__c', 'Takedown_Invoice__c.TKD_tl_SAT_message__c', 'Takedown_Invoice__c.TKD_tl_Eng_message__c', 'Takedown_Invoice__c.TKD_ls_SAT_Status__c', 
'Takedown_Invoice__c.TKD_ls_Eng_Status__c', 'Takedown_Invoice__c.TKD_tx_Tax_code__c' ];


const FIELDS_FORM = ['Name', 'TKD_tx_Model__c', 'SerialNumber', 'Description', 'TKD_tx_model_year__c',
        'TKD_tl_engine_number__c', 'TKD_tx_brand__c', 'Status', 'TKD_ck_active__c',
        'TKD_tx_Insurance_policy__c', 'TKD_tl_ec_policy__c', 'TKD_tx_Insurance_company__c',
        'TKD_tx_inciso_insurance__c', 'TKD_fh_insurance_expiration_date__c', 'TKD_tx_aseguradora__c',
        'TKD_tx_annex_a_number__c', 'TKD_fh_annex_a_created_Date__c', 'TKD_fh_annex_a_approved_Date__c',
        'TKD_tx_quote_number__c', 'TKD_ls_annex_a_status__c', 'TKD_fh_quote_date__c', 'TKD_ls_ec_or_customer_supplier__c',
        'TKD_nu_unit_availability_days__c', 'TKD_tx_supplier_name__c', 'TKD_ls_purchase_Status__c',
        'TKD_ls_delivery_status__c', 'TKD_fh_customer_agreed_delivery_date__c', 'TKD_fh_real_delivery_date__c',
        'TKD_ca_welcome_kit_sent__c', 'TKD_fh_forcasted_delivery_date__c', 'TKD_fh_welcome_kit_sent_date__c',
        'TKD_ls_annex_b_status__c', 'TKD_fh_annex_b_sent_date__c', 'TKD_dv_payment_amount__c',
        'TKD_tx_payment_type__c', 'TDK_dv_Unit_cost__c', 'Quantity', 'TKD_tx_payment_order__c',
        'TKD_dv_soft_cost__c', 'CurrencyIsoCode', 'TKD_tx_payment_frecuency__c', 'TKD_dv_total_cost__c',
        'TDK_tx_pediment__c', 'TKD_tx_Category__c', 'TKD_tx_arrears__c', 'TKD_ls_stage__c',
        'TKD_tx_Sub_Category__c', 'TKD_tl_imported_by__c', 'TKD_fh_fecha_de_importacion__c',
        'TKD_tx_period__c', 'TKD_fh_imported_on__c', 'TKD_rb_collateral__c'
    ];

const SECTIONS = {
        label: 'Assets',
        icon: 'utility:description',
        items: [],
    };

export default { FIELDS_TO_GET_RECORD, FIELDS_FORM, SECTIONS };