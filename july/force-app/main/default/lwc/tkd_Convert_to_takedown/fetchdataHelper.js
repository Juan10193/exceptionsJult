const COLUMNAS = [
    { label: 'Opportunity Name', fieldName: 'Name' },
    { label: 'OpportunityId', fieldName: 'Id' },
    {
        type:  'button',
        typeAttributes: 
        {
          iconName: 'utility:add',
          label: 'Select', 
          name: 'Select', 
          title: 'Select', 
          disabled: false, 
          value: 'Select',
        }
    },
];

const COLUMNS_CUSTOMER = [
  { label: 'Name', fieldName: 'Name'},
  {label: 'CustomerId', fieldName: 'Id'},
  {
    type:'button',
    typeAttributes:
    {
      iconName: 'utility:add',
      label:'Select',
      name:'Select',
      title:'Select',
      disabled:false,
      value: 'Select',
    }
  },
];

const COLUMNS_PRICINGCA = [
  { label: 'Name', fieldName: 'Name'},
  {label: 'Pricing in Ca Id', fieldName: 'Id'},
  {
    type:'button',
    typeAttributes:
    {
      iconName: 'utility:add',
      label:'Select',
      name:'Select',
      title:'Select',
      disabled:false,
      value: 'Select',
    }
  },
  {label: 'PQ', fieldName:'ES3_fm_Pricing_Super_Trump__c'}
];



export default {COLUMNAS, COLUMNS_CUSTOMER, COLUMNS_PRICINGCA};