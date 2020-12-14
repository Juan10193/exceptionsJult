const columnsAssets = [
    {label:'ASSET ID', fieldName:'evAssetAssetId', type:'number'},
    {label:'COLLATERAL TYPE', fieldName:'evAssetCollateralType'},
    {label:'COLLATERAL DESCRIPTION', fieldName:'evAssetCollateralDescription'},
    {label:'ASSET DESCRIPTION', fieldName:'evAssetOracleFACategory'},
    {label:'CONDITION', fieldName:'evAssetConditionType'},
    {label:'QUANTITY', fieldName:'evAssetQuantity', type:'number'},
    {label:'CURRENCY', fieldName:'evAssetCurrencyType'},
    {
        label:'UNIT COST', fieldName:'evAssetUnitCost', type: 'currency',  typeAttributes: {currencyCode: { fieldName: 'evAssetCurrencyType' }, currencyDisplayAs:'symbol' }
    },
    {label:'TOTAL COST', fieldName:'evAssetTotalCost', type: 'currency',  typeAttributes: {currencyCode: { fieldName: 'evAssetCurrencyType' }, currencyDisplayAs:'symbol'}},
    {label:'INSURANCE', fieldName:'evAssetInsuranceType'},
    {label:'RAPID TAG', fieldName:'evAssetRapidTagFlag'},
    {label:'IMPORTS', fieldName:'evAssetImportFlag'}
];


const columnsValuations =[
    
    {label:'VALUATION ID', fieldName:'evValValuationId', type:'number', cellAttributes: { alignment: 'center' }},
    {label:'ASSET ID', fieldName:'evValAssetId', type:'number', cellAttributes: { alignment: 'center' }},
    {label:'TERM MONTHS', fieldName:'evValTermMonths', type:'number', cellAttributes: { alignment: 'center' }},
    {
        label:'FMV AMOUNT', fieldName:'evValFmvAmount', type: 'currency',  typeAttributes: {currencyCode:'MXN', currencyDisplayAs:'symbol' }, cellAttributes: { alignment: 'center' }
    },
    {label:'FMV PERCENT', fieldName:'evValFmvPercent', type:'number', cellAttributes: { alignment: 'center' }},
    {
        label:'NRV AMOUNT', fieldName:'evValNrvAmount', type: 'currency',  typeAttributes: {currencyCode:'MXN', currencyDisplayAs:'symbol' }, cellAttributes: { alignment: 'center' }
    },
    {label:'NRV PERCENT', fieldName:'evValNrvPercent', type:'number', cellAttributes: { alignment: 'center' }},
    {
        label:'OLV AMOUNT', fieldName:'evValOlvAmount', type: 'currency',  typeAttributes: {currencyCode:'MXN', currencyDisplayAs:'symbol' }, cellAttributes: { alignment: 'center' }
    },
    {label:'OLV PERCENT', fieldName:'evValOlvPercent', type:'number', cellAttributes: { alignment: 'center' }},
    {
        label:'RV AMOUNT', fieldName:'evValRvAmount', type: 'currency',  typeAttributes: {currencyCode:'MXN', currencyDisplayAs:'symbol' }, cellAttributes: { alignment: 'center' }
    },
    {label:'RV PERCENT', fieldName:'evValRvPercent', type:'number', cellAttributes: { alignment: 'center' }}
];



export {columnsAssets, columnsValuations};