const COLS = [
    { label: 'Document Name', fieldName: 'Name', sortable: "true" },
    { label: 'Extension', fieldName: 'TKD_txt_Extension__c', fixedWidth: 110, sortable: "true" },
    {
        label: 'SAT Validation',
        fieldName: 'TKD_tl_SAT_message__c',
        cellAttributes: {
            iconName: { fieldName: 'TKD_ls_SAT_Status__c' },
            iconPosition: 'left'
        },
        sortable: "true"
    },
    {
        label: 'Engenium Validation',
        fieldName: 'TKD_tl_Eng_message__c',
        cellAttributes: {
            iconName: { fieldName: 'TKD_ls_Eng_Status__c' },
            iconPosition: 'left'
        },
        sortable: "true"
    },
    {
        label: 'Prebook validation',
        fieldName: 'MC_Rejection_Comments_txt__c',
        cellAttributes: {
            iconName: { fieldName: 'MC_Estatus_Prebook_pl__c' },
            iconPosition: 'left'
        },
        sortable: "true"
    },
    { type: 'action', typeAttributes: { rowActions: [
        { label: 'Show Asset Breakdown', name: 'assetbd' },
        { label: 'Open Record', name: 'openrecord' },
        { label: 'Document Preview', name: 'preview' },
        { label: 'Delete', name: 'delete' },
    ] } },
];

const FIELDS = ['Takedowns_Contingency_plan__c.TKD_ls_asset_type__c', 'Takedowns_Contingency_plan__c.Name', 
'Takedowns_Contingency_plan__c.TKD_ca_Notify_to_Prebook__c','Takedowns_Contingency_plan__c.TKD_ca_Block_AB__c',
'Takedowns_Contingency_plan__c.TKD_ca_Approve_Asset_Breakdown__c', 'Takedowns_Contingency_plan__c.CPL_ls_Product__c',
'Takedowns_Contingency_plan__c.TKD_ls_Invoices_approval_status__c', 'Takedowns_Contingency_plan__c.TKD_ca_Block_invoices__c'];

export default { COLS, FIELDS };