const columnas = [
    { label: 'Periodo', fieldName: 'intPeriod',type:'number', cellAttributes: { alignment: 'left' }},
    { label: 'Balance', fieldName: 'dblBalance', type: 'number',typeAttributes: { currencyDTO: { fieldName: 'strCurrencyCode' }, maximumFractionDigits:2, minimumFractionDigits:2},  cellAttributes: { alignment: 'left' }},
    { label: 'Capital', fieldName: 'dblCapital', type: 'number', typeAttributes: { currencyDTO: { fieldName: 'strCurrencyCode' }, maximumFractionDigits:2, minimumFractionDigits:2}, cellAttributes: { alignment: 'left' }},
    { label: 'Interes', fieldName: 'dblInterest', type: 'number',typeAttributes: { currencyDTO: { fieldName: 'strCurrencyCode' },maximumFractionDigits:2, minimumFractionDigits:2}, cellAttributes: { alignment: 'left' }},
    { label: 'Pago', fieldName: 'dblSubtotal', type: 'number',typeAttributes: { currencyDTO: { fieldName: 'strCurrencyCode' }, maximumFractionDigits:2, minimumFractionDigits:2},  cellAttributes: { alignment: 'left' }},
    { label: 'IVA', fieldName: 'dblIva', type: 'number',typeAttributes: { currencyDTO: { fieldName: 'strCurrencyCode' },maximumFractionDigits:2, minimumFractionDigits:2}, cellAttributes: { alignment: 'left' }},
    { label: 'Pago c/IVA', fieldName: 'dblTotal', type: 'number',typeAttributes: { currencyDTO: { fieldName: 'strCurrencyCode' }, maximumFractionDigits:2, minimumFractionDigits:2}, cellAttributes: { alignment: 'left' }},
];





    export default {columnas};