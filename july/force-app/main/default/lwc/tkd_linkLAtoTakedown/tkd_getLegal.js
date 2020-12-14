import searchLegal from '@salesforce/apex/TKD_LinkLAtoTakedownCallout_cls.searchRequestId'

let getLegalByLegalId = (legalId)=>{
    return new Promise((resolve, reject) => {
        searchLegal({requestId:legalId})
        .then(result=>{
            let resultado = JSON.parse(result);
            resolve (resultado.requests.request[0]);
        }).catch(error=>{
            reject(new Error(error));
        })
    });
}

let actaConstitutiva =(ndaType, lA)=>{
    let act
    let acta;
    switch (ndaType) {
        case 'Moral':
            act = lA.legalAssessment.laDetail.moral.actaConstitutiva;
            acta = {
                actaFlagMoral: ndaType ==='Moral'?true:false,
                actaFlagExtranj: ndaType ==='Extranjera'?true:false, 
                laCDenomConstituirse: act.laPMACDenomConstituirse,
                laACEscrituraNum: act.laPMACEscrituraNum,
                laACFechaEscritura: act.laPMACFechaEscritura,
                laACDuracion: act.laPMACDuracion,
                laACClausulaExtranjero: act.laPMACClausulaExtranjero,
                laACFedatarioPublico: act.laPMACFedatarioPublico,
                laACFechaRegistro : act.laPMACFechaRegistro,
                laACLugarRegistro: act.laPMACLugarRegistro,
                laACDatosRegistro: act.laPMACDatosRegistro,
                laACObservaciones: act.laPMACObservaciones
            }
            break;
        
        case 'Extranjera':
            act = lA.legalAssessment.laDetail.moralExtranjera.actaConstitutiva;
            acta = {
                actaFlagMoral: ndaType ==='Moral'?true:false,
                actaFlagExtranj: ndaType ==='Extranjera'?true:false,
                laCDenomConstituirse: act.laPMACDenomConstituirse,
                laACEscrituraNum: act.laPMACEscrituraNum,
                laACFechaEscritura: act.laPMACFechaEscritura,
                laACDuracion: act.laPMACDuracion,
                laACClausulaExtranjero: act.laPMACClausulaExtranjero,
                laACFedatarioPublico: act.laPMACFedatarioPublico,
                laACFechaRegistro : act.laPMACFechaRegistro,
                laACLugarRegistro: act.laPMACLugarRegistro,
                laACDatosRegistro: act.laPMACDatosRegistro,
                laACObservaciones: act.laPMACObservaciones
            }
            break;
        case 'Fisica':
            acta = lA.legalAssessment.laDetail.fisica.actaConstitutiva;
            break;
        default:
            break;
    }

    return acta;
}

let apoderados = (ndaType, lA)=>{
    let apodera;
    switch (ndaType) {
        case 'Moral':
            apodera = lA.legalAssessment.laDetail.moral.apoderados.apoderado;
            break;
        
        case 'Extranjera':
            apodera = lA.legalAssessment.laDetail.moralExtranjera.apoderados.apoderado;
            break;
        case 'Fisica':
            apodera = lA.legalAssessment.laDetail.fisica.apoderados.apoderado;
            break;
        default:
            break;
    }

    return apodera;
}

let bill = (ndaType, lA)=>{
    let bil;
    switch (ndaType) {
        case 'Moral':
            bil = lA.legalAssessment.laDetail.moral.bil;
            break;
        
        case 'Extranjera':
            bil = lA.legalAssessment.laDetail.moralExtranjera.bil;
            break;
        case 'Fisica':
            bil = lA.legalAssessment.laDetail.fisica.bil;
            break;
        default:
            break;
    }

    return bil;
}

const columnsApo = [
    {
        type:'button',
        typeAttributes:
        {
          iconName: 'utility:preview',
          label:'VIEW',
          name:'VIEW',
          title:'VIEW Apoderado',
          disabled:false,
          value: 'VIEW',
        }
    },
    {label:'NOMBRE', fieldName:'laANombreFacultado'},
    {label:'VIGENCIA ID', fieldName:'laAFecha'},
    {label:'ACTOS DE DOMINIO', fieldName:'laAActosDominio'},
    {label:'TITULOS DE CREDITO', fieldName:'laATitulosCredito'},
    {label:'ACTOS ADMINISTRATIVOS', fieldName:'laAActosAdministrativos'},
    {label:'PLEITOS Y COBRANZAS', fieldName:'laAPleitosCobranza'},
    {label:'I-M', fieldName:'laAIndMan'},
    {label:'OBSERVACIONES', fieldName:'laAObservaciones'},
];



export {getLegalByLegalId, actaConstitutiva, apoderados, bill, columnsApo}