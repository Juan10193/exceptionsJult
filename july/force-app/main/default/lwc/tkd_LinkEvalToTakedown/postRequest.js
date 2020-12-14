let dataHeader;
let evalHeader;
let startDate;
let isOp;
let customerPartyId;
let customerName;
let ssso;

export default class Request{

    constructor(request, strtDate,sso,fromOp, partyid, entiyName) {

        dataHeader = request.requests.request[0].header;
        evalHeader =request.requests.request[0].eval.evalHeader;
        startDate = strtDate;
        ssso = sso;
        isOp = fromOp;
        customerPartyId =partyid;
        customerName = entiyName
    }

    replacer(name, val){
        return val===null?'':val;
    }

    generatePost(){
        let postJson =
        {
            request:{
                header:{
                    requestId: dataHeader.requestId,
                    requestType: dataHeader.requestType,
                    applicationCode: 'SF',
                    partyId:isOp===false?dataHeader.partyId:customerPartyId,
                    requestStatus: "CLONETKD",
                    requestedBy: ssso,
                    startDate: startDate,
                    endDate: null,
                    rootRequestId: null,
                    assignedTo: null,
                    ndaType: "Booking",
                    sourceAccountId: null,
                    sourceAccountName: null,
                    sourceTopParentId: dataHeader.sourceTopParentId,
                    sourceTopParentName: dataHeader.sourceTopParentName,
                    partyName: isOp===false?dataHeader.partyName:customerName,
                    egPartyId: null,
                    egPartyName: null,
                    sourceOpId: dataHeader.sourceOpId,
                    sourceCAId: null,
                    createdBy: ssso,
                    assignedGroup: 'APP EVAL GROUP',
                    assignedDate: null,
                    activeFlag: 'Y',
                    creationDate: startDate,
                    updatedBy: ssso,
                    lastUpdateDate: startDate,
                    solvedBy: null,
                    solvedDate: null,
                    finantialEntity: null
                }
            },
            detail:{
                amlCRR: {
                    crr: '',
                    crrModificationDate: '',
                    crrExpirationDate: '',
                    crrOverride: '',
                    crrSourceType: '',
                    crrComments: ''
                },
                amlHit: {
                    hitRFC: '',
                    hitEntityName: '',
                    hitFlag: 'N',
                    hitUwStatus: '',
                    hitUwComments: '',
                    hitAMLStatus: '',
                    hitAMLComments: '',
                    hitAMLMaxPercent: ''
                },
                creditBureau: {
                    cbTransactionId: '',
                    cbPartySiteID: '',
                    cbLegalPartyId: '',
                    cbLegalPartyAlias: '',
                    cbRejectReason: '',
                    cbLetterFlag: '',
                    cbrfc: '',
                    cbCustomerType: '',
                    cbName: '',
                    cbSecondName: '',
                    cbLastName: '',
                    cbSecondLastName: '',
                    cbAPIRequestor: '',
                    cbMunicipality: '',
                    cbOutNum: '',
                    cbIntNum: '',
                    cbcompanyName: '',
                    cbaddress: '',
                    cbecEntity: '',
                    cbletterSigningPlace: '',
                    cbalias: '',
                    cbstreetAndNumber: '',
                    cbsuburb: '',
                    cbzipCode: '',
                    cbcity: '',
                    cbstate: '',
                    cbcountry: '',
                    cbautorizationLetter: '',
                    dummyFlag: ''
                },
                economicGroup: {
                    egProposedName: '',
                    egPartyId: '',
                    egPartyName: '',
                    egSicId: '',
                    egSicDescription: ''
                },
                kycInd: {
                kycIndName: '',
                datosGenerales: {
                    kycIndGDRFC: '',
                    kycIndGDCURP: '',
                    kycIndGDNacionalities: '',
                    kycIndGDFEASerialNo: '',
                    kycIndGDBirthCountry: '',
                    kycIndGDBirthState: '',
                    kycIndGDSex: '',
                    kycIndGDMarriageStatus: '',
                    kycIndGDMarriageRegime: '',
                    kycIndGDNameOfSpouse: ''
                },
                domicilioParticular: {
                    kycIndAdrStreet: '',
                    kycIndAdrOutNum: '',
                    kycIndAdrIntNum: '',
                    kycIndAdrCounty: '',
                    kycIndAdrMunicipality: '',
                    kycIndAdrCity: '',
                    kycIndAdrState: '',
                    kycIndAdrCountry: '',
                    kycIndIntAdrZipCode: ''
                },
                datosGralesEmpleo: {
                    kycIndBizTitle: '',
                    kycIndBizRelatedPaties: ''
                },
                ppe: {
                    kycIndPPEFlag: '',
                    kycIndPPEJob: '',
                    kycIndPPEAFlag: '',
                    kycIndPPEAName: '',
                    kycIndPPEARelationship: ''
                },
                suscritoPor: {
                    kycIndSignName: '',
                    kycIndSignFlag: 'N',
                    kycIndSignPowerFlag: 'N',
                    kycIndSignPublicDeedNum: '',
                    kycIndSignNotaryName: '',
                    kycIndSignNotaryNum: '',
                    kycIndSignNotaryState: '',
                    kycIndSignDateDay: '',
                    kycIndSignDateMonth: '',
                    kycIndSignDateYear: ''
                }
                },
                kycOrg: {
                kycOrgName: '',
                datosGenerales: {
                    kycOrgGDRFC: '',
                    kycOrgGDNacionality: '',
                    kycOrgGDFEASerialNo: '',
                    kycOrgGDPhone: '',
                    kycOrgGDEmail: '',
                    kycOrgGDActivity: ''
                },
                domicilioParticular: {
                    kycOrgAdrStreet: '',
                    kycOrgAdrOutNum: '',
                    kycOrgAdrIntNum: '',
                    kycOrgAdrCounty: '',
                    kycOrgAdrMunicipality: '',
                    kycOrgAdrCity: '',
                    kycOrgAdrState: '',
                    kycOrgIntAdrCountry: '',
                    kycOrgIntAdrZipCode: ''
                },
                actividadEconomica: {
                    kycOrgActGovFlag: '',
                    kycOrgActGovPartyName: '',
                    kycOrgActGovAnnualIncome: '',
                    kycOrgActGovServices: '',
                    kycOrgActGovAge: ''
                },
                kycOrgFinanceUse: '',
                mercadoGeografico: {
                    kycOrgCorpSites: '',
                    kycOrgMktSites: ''
                },
                kycOrgBankPayeeName: '',
                ppe: {
                    kycOrgPPEFlag: '',
                    kycOrgPPEJob: '',
                    kycOrgPPEName: '',
                    kycOrgPPEAName: '',
                    kycOrgPPEARelationship: '',
                    kycOrgPPEABoardJob: '',
                    kycOrgPPEABoardName: '',
                    kycOrgPPEAName2: '',
                    kycOrgPPEARelationship2: ''
                },
                kycOrgPartnerOrgName: '',
                kycOrgTrustOrgName: '',
                kycOrgBizManagedBy: '',
                kycOrgCorpName: '',
                certificacionRepresentanteLegal: {
                    kycOrgSignName: '',
                    kycOrgSignJob: '',
                    kycOrgSignPublicDeedNum: '',
                    kycOrgSignNotaryName: '',
                    kycOrgSignNotaryNum: '',
                    kycOrgSignNotaryState: '',
                    kycOrgSignDateDay: '',
                    kycOrgSignDateMonth: '',
                    kycOrgSignDateYear: ''
                }
                },
                eval: {
                    evalHeader: {
                        evEvalType: "Booking",
                        evInsuranceReqFlag: evalHeader.evInsuranceReqFlag,
                        evEfaReqFlag: evalHeader.evEfaReqFlag,
                        evSlbFlag: evalHeader.evSlbFlag,
                        evImportsReqFlag: evalHeader.evImportsReqFlag,
                        evProgressPayFlag: evalHeader.evProgressPayFlag,
                        evShowFMVFlag: evalHeader.evShowFMVFlag,
                        evFreezeEvalFlag: evalHeader.evFreezeEvalFlag,
                        evFreezeStartDate: null,
                        evFreezeEndDate: null,
                        evProgressPayTermMonths: evalHeader.evProgressPayTermMonths,
                        evEquipmentAmount: null,
                        evEquipmentAmountTax: null,
                        evEquipmentAmountPercent: null,
                        evCostAmount: null,
                        evCostAmountTax: null,
                        evCostAmountPercent: null,
                        evCurrencyType: evalHeader.evCurrencyType,
                        evExchangeRate: evalHeader.evExchangeRate,
                        evAssetCount: null,
                        evProductType: evalHeader.evProductType,
                        evResidualMaxTermMonths: evalHeader.evResidualMaxTermMonths,
                        evSpecialTermMonths01: evalHeader.evSpecialTermMonths01,
                        evSpecialTermMonths02: evalHeader.evSpecialTermMonths02,
                        evSpecialTermMonths03: evalHeader.evSpecialTermMonths03,
                        evEndorsementComment: null,
                    }
                },
                sicCode: {
                  sicProposedId: '',
                  sicProposedDescription: '',
                  sicId: '',
                  sicDescription: ''
                },
                laActiveFlag: 'Y',
                laCreatedBy: ssso,
                laCreationDate: startDate,
                laLastUpdatedBy: '',
                laLastUpdateDate: startDate
            },        
        }
        
        return JSON.stringify(postJson, this.replacer);
    }
}