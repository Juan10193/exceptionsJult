const ACTIONS =[
    { label: 'Delete', name: 'deleteOnly' },
    
]

const COLUMNAS =[
    { label: 'Party Name', fieldName: 'partyName', type: 'text', cellAttributes: { alignment: 'left' }},
    { label: 'Economic Group Name', fieldName: 'economicGroupName', type: 'text', cellAttributes: { alignment: 'left' }},
    { label: 'Oracle Account Number', fieldName: 'oracleAccountNumber', type: 'text', cellAttributes: { alignment: 'left' }},
    { label: 'Contract Number', fieldName: 'contractNumber', type: 'text', cellAttributes: { alignment: 'left' }},
    { label: 'currency', fieldName: 'curency', type: 'text', cellAttributes: { alignment: 'left' }},
    { label: 'product Name', fieldName: 'productName', type: 'text', cellAttributes: { alignment: 'left' }},
    { label: 'contract Oec', fieldName: 'contractOec', type: 'number', cellAttributes: { alignment: 'left' }},
    { label: 'exposure', fieldName: 'exposure', type: 'number', cellAttributes: { alignment: 'left' }},
    { label: 'nbv', fieldName: 'nbv', type: 'number', cellAttributes: { alignment: 'left' }},
    { label: 'open Items Ar', fieldName: 'openItemsAr', type: 'number', cellAttributes: { alignment: 'left' }},
    { label: 'days Due Ar', fieldName: 'daysDueAr', type: 'number', cellAttributes: { alignment: 'left' }},
    { label: 'open Items Dlq', fieldName: 'openItemsDlq', type: 'number', cellAttributes: { alignment: 'left' }},
    { label: 'days Due Dlq', fieldName: 'daysDueDlq', type: 'number', cellAttributes: { alignment: 'left' }},
    { label: 'vertical', fieldName: 'vertical', type: 'text', cellAttributes: { alignment: 'left' }},
    { type: 'action', typeAttributes: { rowActions: ACTIONS, menuAlignment: 'left' } }
];

export default {COLUMNAS};