/**
 * @File Name          : componenteDocsV2Helper.js
 * @Description        : 
 * @Author             : juandedios.hernandez@engeniumcapital.com
 * @Group              : 
 * @Last Modified By   : juandedios.hernandez@engeniumcapital.com
 * @Last Modified On   : 6/11/2019 15:00:03
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    6/11/2019   juandedios.hernandez@engeniumcapital.com     Initial Version
**/
import getDocsIds from "@salesforce/apex/Data_Access_TKD_Doument_Exclusionmdt.getDocIds";

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
            return 'TAKEDOWN ARRENDAMIENTO FINANCIERO PROGRESS'
        default:
            return null;
    }
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

export {translateProduct, getExclude};