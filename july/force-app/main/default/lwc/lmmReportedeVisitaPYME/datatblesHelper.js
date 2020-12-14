const actions = [
    { label: 'Delete', name: 'delete' },
    {label:'Edit', name:'edit'}
];

const columnsFuncP = [
    { label: 'Puesto', fieldName: 'Title', type:"text" },
    { label: 'Nombre', fieldName: 'LMM_RPYME_Name__c', type:"text"},
    { label: 'Teléfono de Contacto', fieldName: 'Phone', type:"phone"},
    {
        type: 'action',
        typeAttributes: { rowActions: actions },
    }
];

const columnsFuncPV=[
    { label: 'Puesto', fieldName: 'Title', type:"text" , cellAttributes: { alignment: 'left' }},
    { label: 'Nombre', fieldName: 'LMM_RPYME_Name__c', type:"text", cellAttributes: { alignment: 'left' }},
    { label: 'Teléfono de Contacto', fieldName: 'Phone', type:"phone", cellAttributes: { alignment: 'left' }},
]

const columnsPC=[
    { label: 'Nombre', fieldName: 'LMM_RPYME_Name__c', type:"text", cellAttributes: { alignment: 'left' } },
    { label: '% Ingresos', fieldName: 'LMM_Ingresos__c', type:"number", cellAttributes: { alignment: 'left' }},
    { label: 'Años', fieldName: 'LMM_A_os__c', type:"number", cellAttributes: { alignment: 'left' }},
    { label: 'Tel de Contacto', fieldName: 'Phone', type:"phone", cellAttributes: { alignment: 'left' }},
    { label: 'Email', fieldName: 'Email', type:"email", cellAttributes: { alignment: 'left' }},
    { label: 'Nombre del Contacto', fieldName: 'LMM_Nombre_del_Contacto__c', type:"text", cellAttributes: { alignment: 'left' }},
    {
        type: 'action',
        typeAttributes: { rowActions: actions },
    }
]

const columnsPCv =[
    { label: 'Nombre', fieldName: 'LMM_RPYME_Name__c', type:"text" , cellAttributes: { alignment: 'left' }},
    { label: '% Ingresos', fieldName: 'LMM_Ingresos__c', type:"number", cellAttributes: { alignment: 'left' }},
    { label: 'Años', fieldName: 'LMM_A_os__c', type:"number", cellAttributes: { alignment: 'left' }},
    { label: 'Tel de Contacto', fieldName: 'Phone', type:"phone", cellAttributes: { alignment: 'left' }},
    { label: 'Email', fieldName: 'Email', type:"email", cellAttributes: { alignment: 'left' }},
    { label: 'Nombre del Contacto', fieldName: 'LMM_Nombre_del_Contacto__c', type:"text", cellAttributes: { alignment: 'left' }},
]

const columnsAvales=[
    { label: 'Nombre', fieldName: 'LMM_tx_Entity_Name__c', type:"text" , cellAttributes: { alignment: 'left' }},    
]

export{
    columnsFuncP, columnsPC, columnsAvales, columnsFuncPV, columnsPCv
}