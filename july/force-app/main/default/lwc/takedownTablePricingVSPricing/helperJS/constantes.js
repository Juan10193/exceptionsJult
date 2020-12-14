const FIELDS_TO_GET_RECORD = ['Takedowns_Contingency_plan__c.Name', 
'Takedowns_Contingency_plan__c.TKD_rb_Pricin_CA__c',
'Takedowns_Contingency_plan__c.CPL_rb_Opp__c'];

const COLUMNAS = [
    { label: 'Field', fieldName: 'field' },
    { label: 'PQ CreditApproval', fieldName: 'dataPricingCA'},
    { label: 'Evaluation', fieldName: 'evaluation', cellAttributes: { alignment: 'left' } },
    { label: 'PQ Booking', fieldName: 'dataPricingST' },    
    {
        label: 'Validation',
        cellAttributes: {
            iconName: { fieldName: 'symbol' },
            iconPosition: 'left'
        }
    },
];

export default { FIELDS_TO_GET_RECORD, COLUMNAS };