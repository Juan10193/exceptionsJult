/* eslint-disable no-console */
/* eslint-disable consistent-return */
//import getVals from '@salesforce/apex/TKD_ChecklistTolgate1Controller.getRequiredForPretollgate1'

import getDocsIds from "@salesforce/apex/Data_Access_TKD_Doument_Exclusionmdt.getDocIds";

const getValidations =(productType, jsonData)=>{
    return new Promise(async(resolve, reject) => {
        let product  = translateProduct(productType);
        console.log(`PRODUCT TYPE: ${product} JSONDATA: ${JSON.stringify(jsonData)}`)
        resolve(compareData(jsonData));    
    });
}

function translateProduct(productType){
    switch (productType) {
        case 'OPERFIN-FIJA':
            return 'TAKEDOWN ARRENDAMIENTO PURO CONVERTED'

        case 'AFINAN-FIJA':
            return 'TAKEDOWN ARRENDAMIENTO FINANCIERO CONVERTED'

        case 'AFINAN-VAR':
            return 'TAKEDOWN ARRENDAMIENTO FINANCIERO CONVERTED'

        case 'PRESTAMO-FIJA':
            return 'TAKEDOWN LOAN CONVERTED'

        case 'PRESTAMO-VAR':
            return 'TAKEDOWN LOAN CONVERTED'

        case 'PROGRESIVO_FIJA':
            return 'TAKEDOWN ARRENDAMIENTO FINANCIERO CONVERTED'
        default:
            return null;
    }

}

function compareData(jsonData){

    if(jsonData.identifiers !== undefined & jsonData.identifiers !== null){
        let contentValues = jsonData.identifiers.map((val)=>{
            val.processFiles.forEach(file => {
                file.entidad =val.name;
            });

            return val.processFiles;
        })

        let contentDocs=[];

        contentValues.forEach(row=>{
            row.forEach(col=>{
              contentDocs.push(col);
            })
        })
    
        let requiredVilations = contentDocs.filter(({required, isValid})=> required ===1 & isValid ===0)
        console.log('DOCUMENTOS FALTANTES')
        console.log(requiredVilations);
        return requiredVilations;
    }

    return undefined;
}

function getExclude(product, financingNeeds, dealCategory){

    return new Promise((resolve, reject) => {
        getDocsIds({product:product, financingNeeds:financingNeeds, dealCategory:dealCategory})
        .then(result=>{
            console.log("resultado tolga");
            console.log(result);
            let docsIds = [];
            result.forEach(doc => {
              docsIds.push(doc.Document_ID__c);
            });
            console.log(docsIds);
            let filteredIds = [...new Set(docsIds)];
            console.log(filteredIds);
            resolve(filteredIds);
        }).catch(error=>{
            reject('Error al traer los documentos excluidos' + error.message)
        })
    });
}


export {getValidations, translateProduct, getExclude}