const columnas2=[

    { label: 'Tipo Financimiento', fieldName: 'strDescription',type:'text', cellAttributes: { alignment: 'left' }},
    { label: 'Pago', fieldName: 'dblMonthlyPayment',type:'currency',typeAttributes:{currencyCode:{fieldName:'strCurrencyCode'}, maximumFractionDigits:2, minimumFractionDigits:2}, cellAttributes: { alignment: 'left' }},
    { label: 'Tasa Activa', fieldName: 'dblRealRate',type:'number',typeAttributes:{maximumFractionDigits:2, minimumFractionDigits:2}, cellAttributes: { alignment: 'left' }},
    { label: 'Book Yield', fieldName: 'dblBookYield',type:'number',typeAttributes:{maximumFractionDigits:2, minimumFractionDigits:2}, cellAttributes: { alignment: 'left' }},
    { label: 'Moneda', fieldName: 'strCurrencyCode',type:'text', cellAttributes: { alignment: 'left' }},
    { label: 'Monto Total', fieldName: 'dblTotalAmount',type:'currency',typeAttributes:{currencyCode:{fieldName:'strCurrencyCode'}, maximumFractionDigits:2, minimumFractionDigits:2}, cellAttributes: { alignment: 'left' }},
    { label: 'Pago de seguro', fieldName: 'dblFinancialInsuranceValue',type:'currency',typeAttributes:{currencyCode:{fieldName:'strCurrencyCode'}, maximumFractionDigits:2, minimumFractionDigits:2}, cellAttributes: { alignment: 'left' }},
];


    export default {columnas2};