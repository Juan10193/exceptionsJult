public class ES2_jsonDummy {
    public static String entitymasterToJson()
    {
        JSONGenerator gen = JSON.createGenerator(true);    
        gen.writeStartObject();
        gen.writeFieldName('requests');
        gen.writeStartObject();
        gen.writeFieldName('request');
        gen.writeStartArray();
        gen.writeStartObject();
        gen.writeFieldName('header');
        gen.writeStartObject();
        gen.writeStringField('requestId' , '1111');
        gen.writeStringField('rootRequestId' , '1111');
        gen.writeStringField('requestType' , 'LEGAL ASSESSMENT');
        gen.writeStringField('ndaType' , 'AAAAA');
        gen.writeStringField('applicationId' , 'DUPLICADO CON REQUEST TYPE');
        gen.writeStringField('sourceAccountId' , 'AAAAA');
        gen.writeStringField('sourceTopParentId' , 'AAAAA');
        gen.writeStringField('partyId' , '1111');
        gen.writeStringField('partyName' , 'AAAAA');
        gen.writeStringField('egPartyId' , '1111');
        gen.writeStringField('egPartyName' , 'AAAAA');
        gen.writeStringField('sourceOpId' , 'AAAAA');
        gen.writeStringField('sourceCAId' , 'AAAAA');
        gen.writeStringField('startDate' , '2020-11-06T09:39:18.000-05:00');
        gen.writeStringField('endDate' , 'AAAAA');
        gen.writeStringField('requestStatus' , 'AAAAA');
        gen.writeStringField('createdBy' , 'AAAAA');
        gen.writeStringField('requestedBy' , 'AAAAA');
        gen.writeStringField('assignedGroup' , 'AAAAA');
        gen.writeStringField('assignedTo' , 'AAAAA');
        gen.writeStringField('assignedDate' , 'AAAAA');
        gen.writeStringField('activeFlag' , 'AAAAA');
        gen.writeStringField('creationDate' , 'AAAAA');
        gen.writeStringField('updatedBy' , 'AAAAA');
        gen.writeStringField('lastUpdateDate' , 'AAAAA');
        gen.writeStringField('solvedBy' , 'AAAAA');
        gen.writeStringField('solvedDate' , 'AAAAA');
        gen.writeStringField('finantialEntity' , 'AAAAA');
        
        gen.writeFieldName('docTypes');
        gen.writeStartObject();
        gen.writeFieldName('docType');
        gen.writeStartArray();
        
        gen.writeStartObject();
        gen.writeStringField('docTypeId' , '1111');
        gen.writeStringField('docSection' , 'AAAAA');
        gen.writeStringField('docTypeName' , 'TIPO 1');
        gen.writeStringField('docTypeReqFlag' , 'AAAAA');
        gen.writeStringField('prm1' , 'REQUIRED');
        gen.writeEndObject(); 
        
        gen.writeStartObject();
        gen.writeStringField('docTypeId' , '22222');
        gen.writeStringField('docSection' , 'AAAAA');
        gen.writeStringField('docTypeName' , 'TIPO 2');
        gen.writeStringField('docTypeReqFlag' , 'AAAAA');
        gen.writeStringField('prm1' , 'OK');
        gen.writeEndObject();
        
        gen.writeEndArray();
        gen.writeEndObject();
        
        gen.writeEndObject();
        
        gen.writeFieldName('privileges');
        gen.writeStartObject();
        gen.writeFieldName('privilege');
        gen.writeStartArray();
        
        gen.writeStartObject();
        gen.writeStringField('sso' , 'AAAAA');
        gen.writeStringField('applicationName' , 'AAAAA');
        gen.writeStringField('applicationCode' , 'AAAAA');
        gen.writeStringField('screen' , 'AAAAA');
        gen.writeStringField('section' , 'PENDING');
        gen.writeStringField('employeeName' , 'AAAAA');
        gen.writeStringField('vCrud' , '10000');
        gen.writeEndObject();
        
        gen.writeStartObject();
        gen.writeStringField('sso' , 'AAAAA');
        gen.writeStringField('applicationName' , 'AAAAA');
        gen.writeStringField('applicationCode' , 'AAAAA');
        gen.writeStringField('screen' , 'AAAAA');
        gen.writeStringField('section' , 'IN PROCESS');
        gen.writeStringField('employeeName' , 'AAAAA');
        gen.writeStringField('vCrud' , '00000');
        gen.writeEndObject();
        
        gen.writeStartObject();
        gen.writeStringField('sso' , 'AAAAA');
        gen.writeStringField('applicationName' , 'AAAAA');
        gen.writeStringField('applicationCode' , 'AAAAA');
        gen.writeStringField('screen' , 'AAAAA');
        gen.writeStringField('section' , 'ON HOLD');
        gen.writeStringField('employeeName' , 'AAAAA');
        gen.writeStringField('vCrud' , '00000');
        gen.writeEndObject();
        
        gen.writeStartObject();
        gen.writeStringField('sso' , 'AAAAA');
        gen.writeStringField('applicationName' , 'AAAAA');
        gen.writeStringField('applicationCode' , 'AAAAA');
        gen.writeStringField('screen' , 'AAAAA');
        gen.writeStringField('section' , 'REWORK');
        gen.writeStringField('employeeName' , 'AAAAA');
        gen.writeStringField('vCrud' , '10000');
        gen.writeEndObject();
        
        gen.writeStartObject();
        gen.writeStringField('sso' , 'AAAAA');
        gen.writeStringField('applicationName' , 'AAAAA');
        gen.writeStringField('applicationCode' , 'AAAAA');
        gen.writeStringField('screen' , 'AAAAA');
        gen.writeStringField('section' , 'REJECTED');
        gen.writeStringField('employeeName' , 'AAAAA');
        gen.writeStringField('vCrud' , '00000');
        gen.writeEndObject();
        
        gen.writeStartObject();
        gen.writeStringField('sso' , 'AAAAA');
        gen.writeStringField('applicationName' , 'AAAAA');
        gen.writeStringField('applicationCode' , 'AAAAA');
        gen.writeStringField('screen' , 'AAAAA');
        gen.writeStringField('section' , 'PRE APPROVED');
        gen.writeStringField('employeeName' , 'AAAAA');
        gen.writeStringField('vCrud' , '10000');
        gen.writeEndObject();
        
        gen.writeStartObject();
        gen.writeStringField('sso' , 'AAAAA');
        gen.writeStringField('applicationName' , 'AAAAA');
        gen.writeStringField('applicationCode' , 'AAAAA');
        gen.writeStringField('screen' , 'AAAAA');
        gen.writeStringField('section' , 'APPROVED');
        gen.writeStringField('employeeName' , 'AAAAA');
        gen.writeStringField('vCrud' , '00000');
        gen.writeEndObject();
        
        gen.writeStartObject();
        gen.writeStringField('sso' , 'AAAAA');
        gen.writeStringField('applicationName' , 'AAAAA');
        gen.writeStringField('applicationCode' , 'AAAAA');
        gen.writeStringField('screen' , 'AAAAA');
        gen.writeStringField('section' , 'AUTO APPROVED');
        gen.writeStringField('employeeName' , 'AAAAA');
        gen.writeStringField('vCrud' , '10000');
        gen.writeEndObject();
        
        gen.writeStartObject();
        gen.writeStringField('sso' , 'AAAAA');
        gen.writeStringField('applicationName' , 'AAAAA');
        gen.writeStringField('applicationCode' , 'AAAAA');
        gen.writeStringField('screen' , 'AAAAA');
        gen.writeStringField('section' , 'CANCELLED BY REQUESTOR');
        gen.writeStringField('employeeName' , 'AAAAA');
        gen.writeStringField('vCrud' , '00000');
        gen.writeEndObject();
        
        gen.writeStartObject();
        gen.writeStringField('sso' , 'AAAAA');
        gen.writeStringField('applicationName' , 'AAAAA');
        gen.writeStringField('applicationCode' , 'AAAAA');
        gen.writeStringField('screen' , 'AAAAA');
        gen.writeStringField('section' , 'WAITING FOR CUSTOMER');
        gen.writeStringField('employeeName' , 'AAAAA');
        gen.writeStringField('vCrud' , '10000');
        gen.writeEndObject();
        
        gen.writeStartObject();
        gen.writeStringField('sso' , 'AAAAA');
        gen.writeStringField('applicationName' , 'AAAAA');
        gen.writeStringField('applicationCode' , 'AAAAA');
        gen.writeStringField('screen' , 'AAAAA');
        gen.writeStringField('section' , 'EDIT');
        gen.writeStringField('employeeName' , 'AAAAA');
        gen.writeStringField('vCrud' , '00000');
        gen.writeEndObject();
        
        gen.writeStartObject();
        gen.writeStringField('sso' , 'AAAAA');
        gen.writeStringField('applicationName' , 'AAAAA');
        gen.writeStringField('applicationCode' , 'AAAAA');
        gen.writeStringField('screen' , 'AAAAA');
        gen.writeStringField('section' , 'NEW DOCUMENT');
        gen.writeStringField('employeeName' , 'AAAAA');
        gen.writeStringField('vCrud' , '10000');
        gen.writeEndObject();
        
        gen.writeStartObject();
        gen.writeStringField('sso' , 'AAAAA');
        gen.writeStringField('applicationName' , 'AAAAA');
        gen.writeStringField('applicationCode' , 'AAAAA');
        gen.writeStringField('screen' , 'AAAAA');
        gen.writeStringField('section' , 'NEW COMMENT');
        gen.writeStringField('employeeName' , 'AAAAA');
        gen.writeStringField('vCrud' , '00000');
        gen.writeEndObject();
        
        gen.writeEndArray();
        gen.writeEndObject();
        
        gen.writeFieldName('amlCRR');
        gen.writeStartObject();
        gen.writeStringField('crr' , 'AAAAA');
        gen.writeStringField('crrModificationDate' , 'AAAAA');
        gen.writeStringField('crrExpirationDate' , 'AAAAA');
        gen.writeStringField('crrOverride' , 'AAAAA');
        gen.writeStringField('crrSourceType' , 'AAAAA');
        gen.writeStringField('crrComments' , 'AAAAA');
        gen.writeEndObject();
        
        gen.writeFieldName('amlHit');
        gen.writeStartObject();
        gen.writeStringField('hitRFC' , 'AAAAA');
        gen.writeStringField('hitEntityName' , 'AAAAA');
        gen.writeStringField('hitExpirationDate' , 'AAAAA');
        gen.writeStringField('hitFlag' , 'AAAAA');
        gen.writeStringField('hitUwStatus' , 'AAAAA');
        gen.writeStringField('hitUwComments' , 'AAAAA');
        gen.writeStringField('hitAMLStatus' , 'AAAAA');
        gen.writeStringField('hitAMLComments' , 'AAAAA');
        gen.writeStringField('hitAMLMaxPercent' , 'AAAAA');
        gen.writeFieldName('hits');
        gen.writeStartObject();
        gen.writeFieldName('hit');
        gen.writeStartArray();
        
        gen.writeStartObject();
        gen.writeStringField('hitSource' , 'AAAAA');
        gen.writeStringField('hitDescription' , 'HIT 1');
        gen.writeStringField('hitPercent' , 'AAAAA');
        gen.writeEndObject(); 
        
        gen.writeStartObject();
        gen.writeStringField('hitSource' , 'AAAAA');
        gen.writeStringField('hitDescription' , 'HIT 2');
        gen.writeStringField('hitPercent' , 'AAAAA');
        gen.writeEndObject(); 
        gen.writeEndArray();
        gen.writeEndObject();
        gen.writeEndObject();
        
        gen.writeFieldName('creditBoureau');
        gen.writeStartObject();
        gen.writeStringField('cbPartySiteID' , '1111');
        gen.writeStringField('cbLegalPartyId' , '1111');
        gen.writeStringField('cbLegalPartyAlias' , 'AAAAA');
        gen.writeStringField('cbRejectReason' , 'AAAAA');
        gen.writeStringField('cbLetterFlag' , 'AAAAA');
        gen.writeStringField('rfc' , 'AAAAA');
        gen.writeStringField('cbCustomerType' , 'Individual');
        gen.writeStringField('cbName' , 'AAAAA');
        gen.writeStringField('cbSecondName' , 'AAAAA');
        gen.writeStringField('cbLastName' , 'AAAAA');
        gen.writeStringField('cbSecondLastName' , 'AAAAA');
        gen.writeStringField('cbAPIRequestor' , 'AAAAA');
        gen.writeStringField('companyName' , 'AAAAA');
        gen.writeStringField('address' , 'AAAAA');
        gen.writeStringField('ecEntity' , 'AAAAA');
        gen.writeStringField('letterSigningDate' , 'AAAAA');
        gen.writeStringField('letterSigningPlace' , 'AAAAA');
        gen.writeStringField('alias' , 'AAAAA');
        gen.writeStringField('street' , 'AAAAA');
        gen.writeStringField('CBIntNum' , 'AAAAA');
        gen.writeStringField('CBOutNum' , 'AAAAA');
        gen.writeStringField('CBMunicipality' , 'AAAAA');
        gen.writeStringField('suburb' , 'AAAAA');
        gen.writeStringField('zipCode' , 'AAAAA');
        gen.writeStringField('city' , 'AAAAA');
        gen.writeStringField('state' , 'AAAAA');
        gen.writeStringField('country' , 'AAAAA');
        gen.writeStringField('autorizationLetter' , 'AAAAA');
        gen.writeEndObject();
        
        gen.writeFieldName('creditApproval');
        gen.writeStartObject();
        gen.writeFieldName('parties');
        gen.writeStartObject();
        gen.writeFieldName('party');
        gen.writeStartArray();
        gen.writeStartObject();
        gen.writeStringField('oppPartyId' , '11111');
        gen.writeStringField('oppPartyName' , 'PARTY 1');
        gen.writeStringField('oppPartyObligorFlag' , 'TRUE');
        gen.writeStringField('oppPartyGuarantorFlag' , 'TRUE');
        gen.writeStringField('oppPartyBOFlag' , 'TRUE');
        gen.writeStringField('oppPartyRDEFlag' , 'TRUE');
        gen.writeEndObject(); 
        
        gen.writeStartObject();
        gen.writeStringField('oppPartyId' , '22222');
        gen.writeStringField('oppPartyName' , 'PARTY 2');
        gen.writeStringField('oppPartyObligorFlag' , 'FALSE');
        gen.writeStringField('oppPartyGuarantorFlag' , 'FALSE');
        gen.writeStringField('oppPartyBOFlag' , 'TRUE');
        gen.writeStringField('oppPartyRDEFlag' , 'TRUE');
        gen.writeEndObject(); 
        gen.writeEndArray();
        gen.writeEndObject();
        gen.writeEndObject(); 
        
        
        gen.writeFieldName('kycInd');
        gen.writeStartObject();
        gen.writeStringField('kycIndName' , 'AAAAA');
        
        gen.writeFieldName('datosGenerales');
        gen.writeStartObject();
        gen.writeStringField('kycIndGDBirthDate' , 'AAAAA');
        gen.writeStringField('kycIndGDRFC' , 'AAAAA');
        gen.writeStringField('kycIndGDCURP' , 'AAAAA');
        gen.writeStringField('kycIndGDNacionalities' , 'AAAAA');
        gen.writeStringField('kycIndGDFEASerialNo' , 'AAAAA');
        gen.writeStringField('kycIndGDBirthCountry' , 'AAAAA');
        gen.writeStringField('kycIndGDBirthState' , 'AAAAA');
        gen.writeStringField('kycIndGDSex' , 'AAAAA');
        gen.writeStringField('kycIndGDMarriageStatus' , 'AAAAA');
        gen.writeStringField('kycIndGDMarriageRegime' , 'AAAAA');
        gen.writeStringField('kycIndGDNameOfSpouse' , 'AAAAA');
        gen.writeEndObject();
        
        gen.writeFieldName('domicilioParticular');
        gen.writeStartObject();
        gen.writeStringField('kycIndAdrStreet' , 'AAAAA');
        gen.writeStringField('kycIndAdrOutNum' , 'AAAAA');
        gen.writeStringField('kycIndAdrIntNum' , 'AAAAA');
        gen.writeStringField('kycIndAdrCounty' , 'AAAAA');
        gen.writeStringField('kycIndAdrMunicipality' , 'AAAAA');
        gen.writeStringField('kycIndAdrCity' , 'AAAAA');
        gen.writeStringField('kycIndAdrState' , 'AAAAA');
        gen.writeStringField('kycIndAdrCountry' , 'AAAAA');
        gen.writeStringField('kycIndIntAdrZipCode' , 'AAAAA');
        gen.writeEndObject();
        
        gen.writeFieldName('datosGralesEmpleo');
        gen.writeStartObject();
        gen.writeStringField('kycIndBizTitle' , 'AAAAA');
        gen.writeStringField('kycIndBizRelatedPaties' , 'AAAAA');
        gen.writeEndObject();
        
        gen.writeFieldName('ppe');
        gen.writeStartObject();
        gen.writeStringField('kycIndPPEFlag' , 'AAAAA');
        gen.writeStringField('kycIndPPEJob' , 'AAAAA');
        gen.writeStringField('kycIndPPEAFlag' , 'AAAAA');
        gen.writeStringField('kycIndPPEAName' , 'AAAAA');
        gen.writeStringField('kycIndPPEARelationship' , 'AAAAA');
        gen.writeEndObject();
        
        gen.writeFieldName('tablaProveedorRecursos');
        gen.writeStartObject();
        gen.writeFieldName('proveedorRecurso');
        gen.writeStartArray();
        gen.writeStartObject();
        gen.writeStringField('kycIndResLegalName' , 'AAAAA');
        gen.writeStringField('kycIndResCountry' , 'AAAAA');
        gen.writeStringField('kycIndResRFC' , 'AAAAA');
        gen.writeStringField('kycIndResAddress' , 'AAAAA');
        gen.writeStringField('kycIndResFEASerialNo' , 'AAAAA');
        gen.writeEndObject(); 
        gen.writeEndArray();
        gen.writeEndObject();
        
        gen.writeFieldName('suscritoPor');
        gen.writeStartObject();
        gen.writeStringField('kycIndSignName' , 'AAAAA');
        gen.writeStringField('kycIndSignFlag' , 'AAAAA');
        gen.writeStringField('kycIndSignPowerFlag' , 'AAAAA');
        gen.writeStringField('kycIndSignPublicDeedNum' , 'AAAAA');
        gen.writeStringField('kycIndSignPublicDeedDate' , 'AAAAA');
        gen.writeStringField('kycIndSignNotaryName' , 'AAAAA');
        gen.writeStringField('kycIndSignNotaryNum' , 'AAAAA');
        gen.writeStringField('kycIndSignNotaryState' , 'AAAAA');
        gen.writeStringField('kycIndSignDateDay' , 'AAAAA');
        gen.writeStringField('kycIndSignDateMonth' , 'AAAAA');
        gen.writeStringField('kycIndSignDateYear' , 'AAAAA');
        gen.writeEndObject();
        
        gen.writeEndObject();
        
        gen.writeFieldName('kycOrg');
        gen.writeStartObject();
        gen.writeStringField('kycOrgName' , 'AAAAA');
        
        gen.writeFieldName('datosGenerales');
        gen.writeStartObject();
        gen.writeStringField('kycOrgGDRFC' , 'AAAAA');
        gen.writeStringField('kycOrgGDBirthDate' , 'AAAAA');
        gen.writeStringField('kycOrgGDNacionality' , 'AAAAA');
        gen.writeStringField('kycOrgGDFEASerialNo' , 'AAAAA');
        gen.writeStringField('kycOrgGDPhone' , 'AAAAA');
        gen.writeStringField('kycOrgGDEmail' , 'AAAAA');
        gen.writeStringField('kycOrgGDActivity' , 'AAAAA');
        gen.writeEndObject();
        
        gen.writeFieldName('domicilioParticular');
        gen.writeStartObject();
        gen.writeStringField('kycOrgAdrStreet' , 'AAAAA');
        gen.writeStringField('kycOrgAdrOutNum' , 'AAAAA');
        gen.writeStringField('kycOrgAdrIntNum' , 'AAAAA');
        gen.writeStringField('kycOrgAdrCounty' , 'AAAAA');
        gen.writeStringField('kycOrgAdrMunicipality' , 'AAAAA');
        gen.writeStringField('kycOrgAdrCity' , 'AAAAA');
        gen.writeStringField('kycOrgAdrState' , 'AAAAA');
        gen.writeStringField('kycOrgIntAdrCountry' , 'AAAAA');
        gen.writeStringField('kycOrgIntAdrZipCode' , 'AAAAA');
        gen.writeEndObject();
        
        gen.writeFieldName('actividadEconomica');
        gen.writeStartObject();
        gen.writeStringField('kycOrgActGovFlag' , 'AAAAA');
        gen.writeStringField('kycOrgActGovPartyName' , 'AAAAA');
        gen.writeStringField('kycOrgActGovAnnualIncome' , 'AAAAA');
        gen.writeStringField('kycOrgActGovServices' , 'AAAAA');
        gen.writeStringField('kycOrgActGovAge' , 'AAAAA');
        gen.writeEndObject();
        
        gen.writeStringField('kycOrgFinanceUse' , 'AAAAA');
        
        gen.writeFieldName('mercadoGeografico');
        gen.writeStartObject();
        gen.writeStringField('kycOrgCorpSites' , 'AAAAA');
        gen.writeStringField('kycOrgMktSites' , 'AAAAA');
        gen.writeEndObject();
        
        gen.writeFieldName('tablaCuentasBancarias');
        gen.writeStartObject();
        gen.writeFieldName('cuentaBancaria');
        gen.writeStartArray();
        gen.writeStartObject();
        gen.writeStringField('kycOrgBankName' , 'AAAAA');
        gen.writeStringField('kycOrgBankAccount' , 'AAAAA');
        gen.writeStringField('kycOrgBankCountry' , 'AAAAA');
        gen.writeEndObject(); 
        gen.writeEndArray();
        gen.writeEndObject();
        
        gen.writeStringField('kycOrgBankPayeeName' , 'AAAAA');
        
        gen.writeFieldName('ppe');
        gen.writeStartObject();
        gen.writeStringField('kycOrgPPEFlag' , 'AAAAA');
        gen.writeStringField('kycOrgPPEJob' , 'AAAAA');
        gen.writeStringField('kycOrgPPEName' , 'AAAAA');
        gen.writeStringField('kycOrgPPEAName' , 'AAAAA');
        gen.writeStringField('kycOrgPPEARelationship' , 'AAAAA');
        gen.writeStringField('kycOrgPPEABoardJob' , 'AAAAA');
        gen.writeStringField('kycOrgPPEABoardName' , 'AAAAA');
        gen.writeStringField('kycOrgPPEAName2' , 'AAAAA');
        gen.writeStringField('kycOrgPPEARelationship2' , 'AAAAA');
        gen.writeEndObject();
        
        gen.writeFieldName('tablaProveedoresRecursos');
        gen.writeStartObject();
        gen.writeFieldName('proveedorRecurso');
        gen.writeStartArray();
        gen.writeStartObject();
        gen.writeStringField('kycOrgResLegalName' , 'AAAAA');
        gen.writeStringField('kycOrgResCountry' , 'AAAAA');
        gen.writeStringField('kycOrgResRFC' , 'AAAAA');
        gen.writeStringField('kycOrgResAddress' , 'AAAAA');
        gen.writeStringField('kycOrgResFEASerialNo' , 'AAAAA');
        gen.writeEndObject(); 
        gen.writeEndArray();
        gen.writeEndObject();
        
        gen.writeFieldName('tablaComposicionCapSocial');
        gen.writeStartObject();
        gen.writeFieldName('capitalSocial');
        gen.writeStartArray();
        gen.writeStartObject();
        gen.writeStringField('kycOrgPartnerLegalName' , 'AAAAA');
        gen.writeStringField('kycOrgPartnerCountry' , 'AAAAA');
        gen.writeStringField('kycOrgPartnerRFC' , 'AAAAA');
        gen.writeStringField('kycOrgPartnerPorcent' , 'AAAAA');
        gen.writeEndObject(); 
        gen.writeEndArray();
        gen.writeEndObject();
        
        gen.writeStringField('kycOrgPartnerOrgName' , 'AAAAA');
        
        gen.writeFieldName('tablaAccSociosPM');
        gen.writeStartObject();
        gen.writeFieldName('accionistasPM');
        gen.writeStartArray();
        gen.writeStartObject();
        gen.writeStringField('kycOrgPartnerOrgLegalName' , 'AAAAA');
        gen.writeStringField('kycOrgPartnerOrgCountry' , 'AAAAA');
        gen.writeStringField('kycOrgPartnerOrgRFC' , 'AAAAA');
        gen.writeStringField('kycOrgPartnerOrgPorcent' , 'AAAAA');
        gen.writeEndObject(); 
        gen.writeEndArray();
        gen.writeEndObject();
        
        gen.writeStringField('kycOrgTrustOrgName' , 'AAAAA');
        
        gen.writeFieldName('tablaAccSociosFideicomisos');
        gen.writeStartObject();
        gen.writeFieldName('accionistaFideicomiso');
        gen.writeStartArray();
        gen.writeStartObject();
        gen.writeStringField('kycOrgTrustLegalName' , 'AAAAA');
        gen.writeStringField('kycOrgTrustCountry' , 'AAAAA');
        gen.writeStringField('kycOrgTrustRFC' , 'AAAAA');
        gen.writeStringField('kycOrgTrustPersons' , 'AAAAA');
        gen.writeEndObject(); 
        gen.writeEndArray();
        gen.writeEndObject();
        
        gen.writeFieldName('tablaAccSociosPF');
        gen.writeStartObject();
        gen.writeFieldName('accionistaPF');
        gen.writeStartArray();
        gen.writeStartObject();
        gen.writeStringField('kycOrgPartnerIndLegalName' , 'AAAAA');
        gen.writeStringField('kycOrgPartnerIndCountry' , 'AAAAA');
        gen.writeStringField('kycOrgPartnerIndRFC' , 'AAAAA');
        gen.writeStringField('kycOrgPartnerIndPorcent' , 'AAAAA');
        gen.writeEndObject(); 
        gen.writeEndArray();
        gen.writeEndObject();
        
        gen.writeStringField('kycOrgBizManagedBy' , 'AAAAA');
        
        gen.writeFieldName('tablaSocAdminPor');
        gen.writeStartObject();
        gen.writeFieldName('administradoPor');
        gen.writeStartArray();
        gen.writeStartObject();
        gen.writeStringField('kycOrgBizManagerName' , 'AAAAA');
        gen.writeStringField('kycOrgBizManagerTitle' , 'AAAAA');
        gen.writeStringField('kycOrgBizManagerRFC' , 'AAAAA');
        gen.writeEndObject(); 
        gen.writeEndArray();
        gen.writeEndObject();
        
        gen.writeFieldName('tablaFuncionariosPrincipales');
        gen.writeStartObject();
        gen.writeFieldName('funcionarioPrincipal');
        gen.writeStartArray();
        gen.writeStartObject();
        gen.writeStringField('kycOrgBizMainName' , 'AAAAA');
        gen.writeStringField('kycOrgBizMainTitle' , 'AAAAA');
        gen.writeStringField('kycOrgBizMainRFC' , 'AAAAA');
        gen.writeEndObject(); 
        gen.writeEndArray();
        gen.writeEndObject();
        
        gen.writeStringField('kycOrgCorpName' , 'AAAAA');
        
        gen.writeFieldName('tablaGrupoEmpresarial');
        gen.writeStartObject();
        gen.writeFieldName('grupoEmpresarial');
        gen.writeStartArray();
        gen.writeStartObject();
        gen.writeStringField('kycOrgCorpLegalName' , 'AAAAA');
        gen.writeStringField('kycOrgCorpCountry' , 'AAAAA');
        gen.writeStringField('kycOrgCorpAddress' , 'AAAAA');
        gen.writeStringField('kycOrgCorpObjective' , 'AAAAA');
        gen.writeStringField('kycOrgCorpPercent' , 'AAAAA');
        gen.writeEndObject(); 
        gen.writeEndArray();
        gen.writeEndObject();
        
        gen.writeFieldName('certificacionRepresentanteLegal');
        gen.writeStartObject();
        gen.writeStringField('kycOrgSignName' , 'AAAAA');
        gen.writeStringField('kycOrgSignJob' , 'AAAAA');
        gen.writeStringField('kycOrgSignPublicDeedNum' , 'AAAAA');
        gen.writeStringField('kycOrgSignPublicDeedDate' , 'AAAAA');
        gen.writeStringField('kycOrgSignNotaryName' , 'AAAAA');
        gen.writeStringField('kycOrgSignNotaryNum' , 'AAAAA');
        gen.writeStringField('kycOrgSignNotaryState' , 'AAAAA');
        gen.writeStringField('kycOrgSignDateDay' , 'AAAAA');
        gen.writeStringField('kycOrgSignDateMonth' , 'AAAAA');
        gen.writeStringField('kycOrgSignDateYear' , 'AAAAA');
        gen.writeEndObject();
        
        gen.writeEndObject();
        
        gen.writeFieldName('eval');
gen.writeStartObject();

gen.writeFieldName('evalHeader');
gen.writeStartObject();

        gen.writeStringField('evEvalType' , 'AAAA');
        gen.writeStringField('evInsuranceReqFlag' , 'Y');
        gen.writeStringField('evEfaReqFlag' , 'Y');
        gen.writeStringField('evSlbFlag' , 'Y');
        gen.writeStringField('evImportsReqFlag' , 'Y');
        gen.writeStringField('evProgressPayFlag' , 'N');
        gen.writeStringField('evShowFMVFlag' , 'Y');
        gen.writeStringField('evFreezeEvalFlag' , 'Y');
        gen.writeStringField('evFreezeStartDate' , 'AAAA');
        gen.writeStringField('evFreezeEndDate' , 'AAAA');
        gen.writeStringField('evProgressPayTermMonths' , '123');
        gen.writeStringField('evEquipmentAmount' , '123');
        gen.writeStringField('evEquipmentAmountTax' , '123');
        gen.writeStringField('evEquipmentAmountPercent' , '123');
        gen.writeStringField('evCostAmount' , '123');
        gen.writeStringField('evCostAmountTax' , '123');
        gen.writeStringField('evCostAmountPercent' , '123');
        gen.writeStringField('evCurrencyType' , 'AAAA');
        gen.writeStringField('evExchangeRate' , '123');
        gen.writeStringField('evAssetCount' , '123');
        gen.writeStringField('evProductType' , 'AAAA');
        gen.writeStringField('evResidualMaxTermMonths' , '123');
        gen.writeStringField('evSpecialTermMonths01' , '39');
        gen.writeStringField('evSpecialTermMonths02' , '12');
        gen.writeStringField('evSpecialTermMonths03' , '50');
        gen.writeStringField('evEndorsementComment' , 'AAAA');

gen.writeEndObject();
gen.writeFieldName('evalDetail');
gen.writeStartObject();

gen.writeFieldName('evAssets');
gen.writeStartObject();

gen.writeFieldName('evAsset');
gen.writeStartArray();
gen.writeStartObject();

        gen.writeStringField('evAssetAssetId' , '123');
        gen.writeStringField('evAssetRequestId' , '123');
        gen.writeStringField('evAssetOracleFACategoryId' , '123');
        gen.writeStringField('evAssetOracleFACategory' , 'AAAA');
        gen.writeStringField('evAssetOracleFASubcategory' , 'AAAA');
        gen.writeStringField('evAssetCollateralType' , 'AAAA');
        gen.writeStringField('evAssetCollateralDescription' , 'AAAA');
        gen.writeStringField('evAssetCollateralId' , 'AAAA');
        gen.writeStringField('evAssetAssetModel' , 'AAAA');
        gen.writeStringField('evAssetAssetModelYear' , 'AAAA');
        gen.writeStringField('evAssetManufacturer' , 'AAAA');
        gen.writeStringField('evAssetCurrencyType' , 'AAAA');
        gen.writeStringField('evAssetExchangeRate' , '123');
        gen.writeStringField('evAssetQuantity' , '123');
        gen.writeStringField('evAssetUnitCost' , '123');
        gen.writeStringField('evAssetUnitTax' , '123');
        gen.writeStringField('evAssetFreightCost' , '123');
        gen.writeStringField('evAssetParkingCost' , '123');
        gen.writeStringField('evAssetInstallationCost' , '123');
        gen.writeStringField('evAssetTrainingCost' , '123');
        gen.writeStringField('evAssetWarrantyCost' , '123');
        gen.writeStringField('evAssetSoftwareCost' , '123');
        gen.writeStringField('evAssetConditionType' , 'AAAA');
        gen.writeStringField('evAssetTotalCost' , '123');
        gen.writeStringField('evAssetPhysicalCatType' , 'AAAA');
        gen.writeStringField('evAssetInsuranceType' , 'AAAA');
        gen.writeStringField('evAssetMultLocationFlag' , 'AAAA');
        gen.writeStringField('evAssetRapidTagFlag' , 'AAAA');
        gen.writeStringField('evAssetImportFlag' , 'AAAA');

    gen.writeFieldName('evAssetValuations');
    gen.writeStartObject();

    gen.writeFieldName('evValuation');
    gen.writeStartArray();
    gen.writeStartObject();

        gen.writeStringField('evValValuationId' , '123');
        gen.writeStringField('evValAssetId' , '123');
        gen.writeStringField('evValRequestId' , '123');
        gen.writeStringField('evValTermMonths' , '123');
        gen.writeStringField('evValFmvAmount' , '123');
        gen.writeStringField('evValFmvPercent' , '123');
        gen.writeStringField('evValNrvAmount' , '123');
        gen.writeStringField('evValNrvPercent' , '123');
        gen.writeStringField('evValOlvAmount' , '123');
        gen.writeStringField('evValOlvPercent' , '123');
        gen.writeStringField('evValRvAmount' , '123');
        gen.writeStringField('evValRvPercent' , '123');
        gen.writeStringField('evValInsurancePrima' , '123');
        gen.writeStringField('evValActiveFlag' , 'AAAA');
        gen.writeStringField('evValCreatedBy' , 'AAAA');
        gen.writeStringField('evValNameCreatedBy' , 'AAAA');
        gen.writeStringField('evValCreationDate' , 'AAAA');
        gen.writeStringField('evValLastUpdatedBy' , 'AAAA');
        gen.writeStringField('evValNameUpdatedBy' , 'AAAA');
        gen.writeStringField('evValLastUpdateDate' , 'AAAA');

    gen.writeEndObject();
        
        gen.writeStartObject();

        gen.writeStringField('evValValuationId' , '234');
        gen.writeStringField('evValAssetId' , '234');
        gen.writeStringField('evValRequestId' , '234');
        gen.writeStringField('evValTermMonths' , '234');
        gen.writeStringField('evValFmvAmount' , '234');
        gen.writeStringField('evValFmvPercent' , '234');
        gen.writeStringField('evValNrvAmount' , '234');
        gen.writeStringField('evValNrvPercent' , '234');
        gen.writeStringField('evValOlvAmount' , '234');
        gen.writeStringField('evValOlvPercent' , '234');
        gen.writeStringField('evValRvAmount' , '234');
        gen.writeStringField('evValRvPercent' , '234');
        gen.writeStringField('evValInsurancePrima' , '234');
        gen.writeStringField('evValActiveFlag' , 'ABAB');
        gen.writeStringField('evValCreatedBy' , 'ABAB');
        gen.writeStringField('evValNameCreatedBy' , 'ABAB');
        gen.writeStringField('evValCreationDate' , 'ABAB');
        gen.writeStringField('evValLastUpdatedBy' , 'ABAB');
        gen.writeStringField('evValNameUpdatedBy' , 'ABAB');
        gen.writeStringField('evValLastUpdateDate' , 'ABAB');

    gen.writeEndObject();
        
    gen.writeEndArray();

    gen.writeEndObject();

    gen.writeFieldName('evAssetEndorsements');
    gen.writeStartObject();

    gen.writeFieldName('evEndorsement');
    gen.writeStartArray();
    gen.writeStartObject();

        gen.writeStringField('evEndEndorsementId' , '123');
        gen.writeStringField('evEndAssetId' , '123');
        gen.writeStringField('evEndRequestId' , '123');
        gen.writeStringField('evEndAttributeType' , 'AAAA');
        gen.writeStringField('evEndValueType' , 'AAAA');
        gen.writeStringField('evEndUomType' , 'AAAA');
        gen.writeStringField('evEndValueOther' , 'AAAA');
        gen.writeStringField('evEndComment' , 'AAAA');
        gen.writeStringField('evEndActiveFlag' , 'AAAA');
        gen.writeStringField('evEndCreatedBy' , 'AAAA');
        gen.writeStringField('evEndNameCreatedBy' , 'AAAA');
        gen.writeStringField('evEndCreationDate' , 'AAAA');
        gen.writeStringField('evEndLastUpdatedBy' , 'AAAA');
        gen.writeStringField('evEndNameUpdatedBy' , 'AAAA');
        gen.writeStringField('evEndLastUpdateDate' , 'AAAA');

    gen.writeEndObject();
    
    gen.writeStartObject();

        gen.writeStringField('evEndEndorsementId' , '234');
        gen.writeStringField('evEndAssetId' , '234');
        gen.writeStringField('evEndRequestId' , '234');
        gen.writeStringField('evEndAttributeType' , 'ABAB');
        gen.writeStringField('evEndValueType' , 'ABAB');
        gen.writeStringField('evEndUomType' , 'ABAB');
        gen.writeStringField('evEndValueOther' , 'ABAB');
        gen.writeStringField('evEndComment' , 'ABAB');
        gen.writeStringField('evEndActiveFlag' , 'ABAB');
        gen.writeStringField('evEndCreatedBy' , 'ABAB');
        gen.writeStringField('evEndNameCreatedBy' , 'ABAB');
        gen.writeStringField('evEndCreationDate' , 'ABAB');
        gen.writeStringField('evEndLastUpdatedBy' , 'ABAB');
        gen.writeStringField('evEndNameUpdatedBy' , 'ABAB');
        gen.writeStringField('evEndLastUpdateDate' , 'ABAB');

    gen.writeEndObject(); 
        
    gen.writeEndArray();

    gen.writeEndObject();

gen.writeEndObject();

gen.writeStartObject();

        gen.writeStringField('evAssetAssetId' , '321');
        gen.writeStringField('evAssetRequestId' , '321');
        gen.writeStringField('evAssetOracleFACategoryId' , '321');
        gen.writeStringField('evAssetOracleFACategory' , 'BBBB');
        gen.writeStringField('evAssetOracleFASubcategory' , 'BBBB');
        gen.writeStringField('evAssetCollateralType' , 'BBBB');
        gen.writeStringField('evAssetCollateralDescription' , 'BBBB');
        gen.writeStringField('evAssetCollateralId' , 'BBBB');
        gen.writeStringField('evAssetAssetModel' , 'BBBB');
        gen.writeStringField('evAssetAssetModelYear' , 'BBBB');
        gen.writeStringField('evAssetManufacturer' , 'BBBB');
        gen.writeStringField('evAssetCurrencyType' , 'BBBB');
        gen.writeStringField('evAssetExchangeRate' , '321');
        gen.writeStringField('evAssetQuantity' , '321');
        gen.writeStringField('evAssetUnitCost' , '321');
        gen.writeStringField('evAssetUnitTax' , '321');
        gen.writeStringField('evAssetFreightCost' , '321');
        gen.writeStringField('evAssetParkingCost' , '321');
        gen.writeStringField('evAssetInstallationCost' , '321');
        gen.writeStringField('evAssetTrainingCost' , '321');
        gen.writeStringField('evAssetWarrantyCost' , '321');
        gen.writeStringField('evAssetSoftwareCost' , '321');
        gen.writeStringField('evAssetConditionType' , 'BBBB');
        gen.writeStringField('evAssetTotalCost' , '321');
        gen.writeStringField('evAssetPhysicalCatType' , 'BBBB');
        gen.writeStringField('evAssetInsuranceType' , 'BBBB');
        gen.writeStringField('evAssetMultLocationFlag' , 'BBBB');
        gen.writeStringField('evAssetRapidTagFlag' , 'BBBB');
        gen.writeStringField('evAssetImportFlag' , 'BBBB');

    gen.writeFieldName('evAssetValuations');
    gen.writeStartObject();

    gen.writeFieldName('evValuation');
    gen.writeStartArray();
    gen.writeStartObject();

        gen.writeStringField('evValValuationId' , '321');
        gen.writeStringField('evValAssetId' , '321');
        gen.writeStringField('evValRequestId' , '321');
        gen.writeStringField('evValTermMonths' , '321');
        gen.writeStringField('evValFmvAmount' , '321');
        gen.writeStringField('evValFmvPercent' , '321');
        gen.writeStringField('evValNrvAmount' , '321');
        gen.writeStringField('evValNrvPercent' , '321');
        gen.writeStringField('evValOlvAmount' , '321');
        gen.writeStringField('evValOlvPercent' , '321');
        gen.writeStringField('evValRvAmount' , '321');
        gen.writeStringField('evValRvPercent' , '321');
        gen.writeStringField('evValInsurancePrima' , '321');
        gen.writeStringField('evValActiveFlag' , 'BBBB');
        gen.writeStringField('evValCreatedBy' , 'BBBB');
        gen.writeStringField('evValNameCreatedBy' , 'BBBB');
        gen.writeStringField('evValCreationDate' , 'BBBB');
        gen.writeStringField('evValLastUpdatedBy' , 'BBBB');
        gen.writeStringField('evValNameUpdatedBy' , 'BBBB');
        gen.writeStringField('evValLastUpdateDate' , 'BBBB');

    gen.writeEndObject();
    gen.writeEndArray();

    gen.writeEndObject();

    gen.writeFieldName('evAssetEndorsements');
    gen.writeStartObject();

    gen.writeFieldName('evEndorsement');
    gen.writeStartArray();
    gen.writeStartObject();

        gen.writeStringField('evEndEndorsementId' , '321');
        gen.writeStringField('evEndAssetId' , '321');
        gen.writeStringField('evEndRequestId' , '321');
        gen.writeStringField('evEndAttributeType' , 'BBBB');
        gen.writeStringField('evEndValueType' , 'BBBB');
        gen.writeStringField('evEndUomType' , 'BBBB');
        gen.writeStringField('evEndValueOther' , 'BBBB');
        gen.writeStringField('evEndComment' , 'BBBB');
        gen.writeStringField('evEndActiveFlag' , 'BBBB');
        gen.writeStringField('evEndCreatedBy' , 'BBBB');
        gen.writeStringField('evEndNameCreatedBy' , 'BBBB');
        gen.writeStringField('evEndCreationDate' , 'BBBB');
        gen.writeStringField('evEndLastUpdatedBy' , 'BBBB');
        gen.writeStringField('evEndNameUpdatedBy' , 'BBBB');
        gen.writeStringField('evEndLastUpdateDate' , 'BBBB');

    gen.writeEndObject();
    gen.writeEndArray();

    gen.writeEndObject();

gen.writeEndObject();

gen.writeEndArray();

gen.writeEndObject();

gen.writeEndObject();

gen.writeEndObject();
        gen.writeFieldName('legalAssessment');
        gen.writeStartObject();
        
         gen.writeFieldName('laHeader');
        gen.writeStartObject();
        
        gen.writeStringField('requestId' , '1111');
        gen.writeStringField('latipo' , 'moral');
        
        gen.writeFieldName('generalInformation');
        gen.writeStartObject();
            gen.writeStringField('laGIOracleAccountName' , 'AAAA');
            gen.writeStringField('laGITopParentName' , 'AAAA');
            gen.writeStringField('laGIRequestStatus' , 'AAAA');
            gen.writeStringField('laGIRequestedBy' , 'AAAA');
            gen.writeStringField('laGIRequestStartDate' , 'AAAA');
            gen.writeStringField('laGIRequestEndDate' , 'AAAA');
            gen.writeStringField('laGIAssignedToGroup' , 'AAAA');
            gen.writeStringField('laGIAssignedToPerson' , 'AAAA');
            gen.writeStringField('laGIValidThrough' , '11/11/11');
        gen.writeEndObject();
        
        gen.writeFieldName('entityInformation');
        gen.writeStartObject();
            gen.writeStringField('laEIEntidad' , 'AAAA');
            gen.writeStringField('LAEINacionalidad' , 'AAAA');
            gen.writeStringField('laEIRfcTin' , 'AAAA');
            gen.writeStringField('laEINumeroCuenta' , 'AAAA');
            gen.writeStringField('laEITipoEntidad' , 'AAAA');
            gen.writeStringField('laEIGrupoEconomico' , 'AAAA');
            gen.writeStringField('laEICurp' , 'AAAA');
        gen.writeEndObject();
        gen.writeEndObject();
        gen.writeFieldName('laDetail');
        gen.writeStartObject();
        gen.writeFieldName('moral');
        gen.writeStartObject();
        
        gen.writeFieldName('actaConstitutiva');
        gen.writeStartObject();
            gen.writeStringField('laPMACDocumentId' , '1111');
            gen.writeStringField('laPMACDenomConstituirse' , 'AAAA');
            gen.writeStringField('laPMACEscrituraNum' , 'AAAA');
            gen.writeStringField('laPMACFechaEscritura' , '11/11/11');
            gen.writeStringField('laPMACDuracion' , 'AAAA');
            gen.writeStringField('laPMACClausulaExtranjero' , 'AAAA');
            gen.writeStringField('laPMACFedatarioPublico' , 'AAAA');
            gen.writeStringField('laPMACFechaRegistro' , '11/11/11');
            gen.writeStringField('laPMACLugarRegistro' , 'AAAA');
            gen.writeStringField('laPMACDatosRegistro' , 'AAAA');
            gen.writeStringField('laPMACObservaciones' , 'AAAA');
        gen.writeEndObject();
        
        gen.writeFieldName('domicilioSocial');
        gen.writeStartObject();
            gen.writeStringField('laDSAddressID' , '1111');
            gen.writeStringField('laDSPais' , 'hola');
            gen.writeStringField('laDSCodigoPostal' , 'hola');
            gen.writeStringField('laDSEstado' , 'AAAA');
            gen.writeStringField('laDSCiudad' , 'AAAA');
            gen.writeStringField('laDSMunicipioAlcaldia' , 'AAAA');
            gen.writeStringField('laDSColonia' , 'AAAA');
            gen.writeStringField('laDSCalle' , 'AAAA');
            gen.writeStringField('laDSNumExterior' , 'AAAA');
            gen.writeStringField('laDSNumInterior' , 'AAAA');
        gen.writeEndObject();
        
        gen.writeFieldName('objetoSocial');
        gen.writeStartObject();
            gen.writeStringField('laPMOSDocumentId' , '1111');
            gen.writeStringField('LAPMOSPurposeId' , '1111');
            gen.writeStringField('laPMOSEscritura' , 'AAAA');
            gen.writeStringField('laPMOSAutorizadoArrendar' , 'AAAA');
            gen.writeStringField('laPMOSAutSuscribirTitCredito' , 'AAAA');
            gen.writeStringField('laPMOSAutGarantizar' , 'AAAA');
            gen.writeStringField('laPMOSFiador' , 'AAAA');
            gen.writeStringField('laPMOSAval' , 'AAAA');
            gen.writeStringField('laPMOSObservaciones' , 'AAAA');
            gen.writeStringField('laPMOSObligadoSolidario' , 'AAAA');
            gen.writeStringField('laPMOSGarantObligTerceros' , 'AAAA');
            gen.writeStringField('laPMOSLimitantesObjetoSocial' , 'AAAA');
        gen.writeEndObject();
        
        gen.writeFieldName('limitantes');
        gen.writeStartObject();
        
        gen.writeFieldName('limitante');
        gen.writeStartArray();
        gen.writeStartObject();
            gen.writeStringField('laMLLimatingId' , '1111');
            gen.writeStringField('laMLLimitante' , 'AAAA');
            gen.writeStringField('laMLEscritura' , 'AAAA');
            gen.writeStringField('laMLFecha' , '11/11/11');
            gen.writeStringField('laMLFederatarioPublico' , 'AAAA');
            gen.writeStringField('laMLRLugar' , 'AAAA');
            gen.writeStringField('laMLRFecha' , 'AAAA');
            gen.writeStringField('laMLRDatos' , 'AAAA');
            gen.writeStringField('laMLActiveFlag' , 'AAAA');
            gen.writeStringField('laMLCreatedBy' , 'AAAA');
            gen.writeStringField('laMLCreationDate' , 'AAAA');
            gen.writeStringField('laMLLastUpdatedBy' , 'AAAA');
            gen.writeStringField('laMLLastUpdateDate' , 'AAAA');
            gen.writeStringField('laMLNameCreatedBy' , 'AAAA');
            gen.writeStringField('laMLNameUpdatedBy' , 'AAAA');
        gen.writeEndObject();
        
        gen.writeStartObject();
            gen.writeStringField('laMLLimatingId' , '2222');
            gen.writeStringField('laMLLimitante' , 'BBBB');
            gen.writeStringField('laMLEscritura' , 'BBBB');
            gen.writeStringField('laMLFecha' , '11/11/11');
            gen.writeStringField('laMLFederatarioPublico' , 'BBBB');
            gen.writeStringField('laMLRLugar' , 'BBBB');
            gen.writeStringField('laMLRFecha' , 'BBBB');
            gen.writeStringField('laMLRDatos' , 'BBBB');
            gen.writeStringField('laMLActiveFlag' , 'BBBB');
            gen.writeStringField('laMLCreatedBy' , 'BBBB');
            gen.writeStringField('laMLCreationDate' , 'BBBB');
            gen.writeStringField('laMLLastUpdatedBy' , 'BBBB');
            gen.writeStringField('laMLLastUpdateDate' , 'BBBB');
            gen.writeStringField('laMLNameCreatedBy' , 'BBBB');
            gen.writeStringField('laMLNameUpdatedBy' , 'BBBB');
        gen.writeEndObject();
        gen.writeEndArray();
        
        gen.writeEndObject();
        
        gen.writeFieldName('modificaciones');
        gen.writeStartObject();
        
        gen.writeFieldName('modificacion');
        gen.writeStartArray();
        gen.writeStartObject();
            gen.writeStringField('laMModificationId' , '1111');
            gen.writeStringField('laMMDocumentId' , '1111');
            gen.writeStringField('laMMReformaTotal' , 'AAAA');
            gen.writeStringField('laMMEscritura' , 'AAAA');
            gen.writeStringField('laMMFecha' , '11/11/11');
            gen.writeStringField('laMMFederatarioPublico' , 'AAAA');
            gen.writeStringField('laMMRLugar' , 'AAAA');
            gen.writeStringField('laMMRFecha' , 'AAAA');
            gen.writeStringField('laMMRDatos' , 'AAAA');
            gen.writeStringField('laMMActiveFlag' , 'AAAA');
            gen.writeStringField('laMMCreatedBy' , 'AAAA');
            gen.writeStringField('laMMCreationDate' , 'AAAA');
            gen.writeStringField('laMMLastUpdatedBy' , 'AAAA');
            gen.writeStringField('laMMLastUpdateDate' , 'AAAA');
            gen.writeStringField('laMMNameCreatedBy' , 'AAAA');
            gen.writeStringField('laMMNameUpdatedBy' , 'AAAA');
        gen.writeEndObject();
        gen.writeStartObject();
            gen.writeStringField('laMModificationId' , '2222');
            gen.writeStringField('laMMDocumentId' , '2222');
            gen.writeStringField('laMMReformaTotal' , 'BBBB');
            gen.writeStringField('laMMEscritura' , 'BBBB');
            gen.writeStringField('laMMFecha' , '11/11/11');
            gen.writeStringField('laMMFederatarioPublico' , 'BBBB');
            gen.writeStringField('laMMRLugar' , 'BBBB');
            gen.writeStringField('laMMRFecha' , 'BBBB');
            gen.writeStringField('laMMRDatos' , 'BBBB');
            gen.writeStringField('laMMActiveFlag' , 'BBBB');
            gen.writeStringField('laMMCreatedBy' , 'BBBB');
            gen.writeStringField('laMMCreationDate' , 'BBBB');
            gen.writeStringField('laMMLastUpdatedBy' , 'BBBB');
            gen.writeStringField('laMMLastUpdateDate' , 'BBBB');
            gen.writeStringField('laMMNameCreatedBy' , 'BBBB');
            gen.writeStringField('laMMNameUpdatedBy' , 'BBBB');
        gen.writeEndObject();
        gen.writeEndArray();
        
        gen.writeEndObject();
        
        gen.writeFieldName('comprobanteDomicilio');
        gen.writeStartObject();
            gen.writeStringField('laCDAddressId' , '1111');
            gen.writeStringField('laCDPais' , 'hola');
            gen.writeStringField('laCDCodigoPostal' , 'hola');
            gen.writeStringField('laMCDEstado' , 'AAAA');
            gen.writeStringField('laCDCiudad' , 'AAAA');
            gen.writeStringField('laCDMunicipioAlcaldia' , 'AAAA');
            gen.writeStringField('laCDColonia' , 'AAAA');
            gen.writeStringField('laCDCalle' , 'AAAA');
            gen.writeStringField('laCDNumExterior' , 'AAAA');
            gen.writeStringField('laCDNumInterior' , 'AAAA');
        gen.writeEndObject();
        
        gen.writeFieldName('datosFiscales');
        gen.writeStartObject();
            gen.writeStringField('laDFAddressId' , '1111');
            gen.writeStringField('laDFRfcTin' , 'AAAA');
            gen.writeStringField('laDFPais' , 'hola');
            gen.writeStringField('laDFCodigoPostal' , 'hola');
            gen.writeStringField('laDFEstado' , 'AAAA');
            gen.writeStringField('laDFCiudad' , 'AAAA');
            gen.writeStringField('laDFMunicipioAlcaldia' , 'AAAA');
            gen.writeStringField('laDFColonia' , 'AAAA');
            gen.writeStringField('laDFCalle' , 'AAAA');
            gen.writeStringField('laDFNumExterior' , 'AAAA');
            gen.writeStringField('laDFNumInterior' , 'AAAA');
            gen.writeStringField('laDFW8W9' , 'AAAA');
            gen.writeStringField('laDFCurp' , 'AAAA');
        gen.writeEndObject();
        
        gen.writeFieldName('apoderados');
        gen.writeStartObject();
        
        gen.writeFieldName('apoderado');
        gen.writeStartArray();
        gen.writeStartObject();
            gen.writeStringField('laAApoderadoID' , '1111');
            gen.writeStringField('laADocumentID' , '1111');
            gen.writeStringField('laANombreFacultado' , 'AAAA');
            gen.writeStringField('laAFecha' , '11/11/11');
            gen.writeStringField('laAActosDominio' , 'AAAA');
            gen.writeStringField('laATitulosCredito' , 'AAAA');
            gen.writeStringField('laAActosAdministrativos' , 'AAAA');
            gen.writeStringField('laAPleitosCobranza' , 'AAAA');
            gen.writeStringField('laAIndMan' , 'AAAA');
            gen.writeStringField('laAObservaciones' , 'AAAA');
            gen.writeStringField('laAEscrituraNum' , 'AAAA');
            gen.writeStringField('laAPEspecial' , 'AAAA');
            gen.writeStringField('laAPOtros' , 'AAAA');
            gen.writeStringField('laAFedatarioPublico' , 'AAAA');
            gen.writeStringField('laAFechaRegistro' , 'AAAA');
            gen.writeStringField('laALugarRegistro' , 'AAAA');
            gen.writeStringField('laADatosRegistro' , 'AAAA');
            gen.writeStringField('laAOcupacion' , 'AAAA');
            gen.writeStringField('laAFechaNacimiento' , 'AAAA');
            gen.writeStringField('laANacionalidad' , 'AAAA');
            gen.writeStringField('laADomicilio' , 'AAAA');
            gen.writeStringField('laAEscrituraRevoca' , 'AAAA');
            gen.writeStringField('laAFechaRevoca' , 'AAAA');
            gen.writeStringField('laALugarRevoca' , 'AAAA');
            gen.writeStringField('laADatosRegistroRevoca' , 'AAAA');
            gen.writeStringField('laAObservacionesRevoca' , 'AAAA');
            gen.writeStringField('laAActiveFlag' , 'AAAA');
            gen.writeStringField('laACreatedBy' , 'AAAA');
            gen.writeStringField('laACreationDate' , 'AAAA');
            gen.writeStringField('laALastUpdatedBy' , 'AAAA');
            gen.writeStringField('laALastUpdateDate' , 'AAAA');
            gen.writeStringField('laANameCreatedBy' , 'AAAA');
            gen.writeStringField('laANameUpdatedBy' , 'AAAA');
        gen.writeEndObject();
        
        gen.writeStartObject();
            gen.writeStringField('laAApoderadoID' , '2222');
            gen.writeStringField('laADocumentID' , '2222');
            gen.writeStringField('laANombreFacultado' , 'BBBB');
            gen.writeStringField('laAFecha' , '11/11/11');
            gen.writeStringField('laAActosDominio' , 'BBBB');
            gen.writeStringField('laATitulosCredito' , 'BBBB');
            gen.writeStringField('laAActosAdministrativos' , 'BBBB');
            gen.writeStringField('laAPleitosCobranza' , 'BBBB');
            gen.writeStringField('laAIndMan' , 'BBBB');
            gen.writeStringField('laAObservaciones' , 'BBBB');
            gen.writeStringField('laAEscrituraNum' , 'BBBB');
            gen.writeStringField('laAPEspecial' , 'BBBB');
            gen.writeStringField('laAPOtros' , 'BBBB');
            gen.writeStringField('laAFedatarioPublico' , 'BBBB');
            gen.writeStringField('laAFechaRegistro' , 'BBBB');
            gen.writeStringField('laALugarRegistro' , 'BBBB');
            gen.writeStringField('laADatosRegistro' , 'BBBB');
            gen.writeStringField('laAOcupacion' , 'BBBB');
            gen.writeStringField('laAFechaNacimiento' , 'BBBB');
            gen.writeStringField('laANacionalidad' , 'BBBB');
            gen.writeStringField('laADomicilio' , 'BBBB');
            gen.writeStringField('laAEscrituraRevoca' , 'BBBB');
            gen.writeStringField('laAFechaRevoca' , 'BBBB');
            gen.writeStringField('laALugarRevoca' , 'BBBB');
            gen.writeStringField('laADatosRegistroRevoca' , 'BBBB');
            gen.writeStringField('laAObservacionesRevoca' , 'BBBB');
            gen.writeStringField('laAActiveFlag' , 'BBBB');
            gen.writeStringField('laACreatedBy' , 'BBBB');
            gen.writeStringField('laACreationDate' , 'BBBB');
            gen.writeStringField('laALastUpdatedBy' , 'BBBB');
            gen.writeStringField('laALastUpdateDate' , 'BBBB');
            gen.writeStringField('laANameCreatedBy' , 'BBBB');
            gen.writeStringField('laANameUpdatedBy' , 'BBBB');
        gen.writeEndObject();
        gen.writeEndArray();
        
        gen.writeEndObject();
        gen.writeEndObject();
        ///MoralExtranjera
        gen.writeFieldName('moralExtranjera');
        gen.writeStartObject();
        
        gen.writeFieldName('actaConstitutiva');
        gen.writeStartObject();
        gen.writeStringField('laPMACDocumentId' , '2589');
        gen.writeStringField('laPMACDenomConstituirse' , 'laPMACDenomConstituirse2590');
        gen.writeStringField('laPMACEscrituraNum' , 'laPMACEscrituraNum2591');
        gen.writeStringField('laPMACFechaEscritura' , 'laPMACFechaEscritura2592');
        gen.writeStringField('laPMACDuracion' , 'laPMACDuracion2593');
        gen.writeStringField('laPMACClausulaExtranjero' , 'laPMACClausulaExtranjero2594');
        gen.writeStringField('laPMACFedatarioPublico' , 'laPMACFedatarioPublico2595');
        gen.writeStringField('laPMACFechaRegistro' , 'laPMACFechaRegistro2596');
        gen.writeStringField('laPMACLugarRegistro' , 'laPMACLugarRegistro2597');
        gen.writeStringField('laPMACDatosRegistro' , 'laPMACDatosRegistro2598');
        gen.writeStringField('laPMACObservaciones' , 'laPMACObservaciones2599');
        gen.writeEndObject();
        
        gen.writeFieldName('domicilioSocial');
        gen.writeStartObject();
        gen.writeStringField('laDSAddressID' , '2600');
        gen.writeStringField('laDSPais' , 'laDSPais2601');
        gen.writeStringField('laDSCodigoPostal' , 'laDSCodigoPostal2602');
        gen.writeStringField('laDSEstado' , 'laDSEstado2603');
        gen.writeStringField('laDSCiudad' , 'laDSCiudad2604');
        gen.writeStringField('laDSMunicipioAlcaldia' , 'laDSMunicipioAlcaldia2605');
        gen.writeStringField('laDSColonia' , 'laDSColonia2606');
        gen.writeStringField('laDSCalle' , 'laDSCalle2607');
        gen.writeStringField('laDSNumExterior' , 'laDSNumExterior2608');
        gen.writeStringField('laDSNumInterior' , 'laDSNumInterior2609');
        gen.writeEndObject();
        
        gen.writeFieldName('estatutos');
        gen.writeStartObject();
        gen.writeFieldName('estatuto');
        gen.writeStartArray();
        
        gen.writeStartObject();
        gen.writeStringField('laEEstatutoID' , '2610');
        gen.writeStringField('laEEstatuto' , 'laEEstatuto2611');
        gen.writeStringField('laEFecha' , 'laEFecha2612');
        gen.writeStringField('laEComentarios' , 'laEComentarios2613');
        gen.writeStringField('laEObservaciones' , 'laEObservaciones2614');
        gen.writeStringField('laEActiveFlag' , 'laEActiveFlag2615');
        gen.writeStringField('laECreatedBy' , 'laECreatedBy2616');
        gen.writeStringField('laECreationDate' , 'laECreationDate2617');
        gen.writeStringField('laELastUpdatedBy' , 'laELastUpdatedBy2618');
        gen.writeStringField('laELastUpdateDate' , 'laELastUpdateDate2619');
        gen.writeStringField('laENameCreatedBy' , 'laENameCreatedBy2620');
        gen.writeStringField('laENameUpdatedBy' , 'laENameUpdatedBy2621');
        gen.writeEndObject();
        
        gen.writeEndArray();
        gen.writeEndObject();
        
        gen.writeFieldName('comprobanteDomicilio');
        gen.writeStartObject();
            gen.writeStringField('laCDAddressId' , '2622');
            gen.writeStringField('laCDPais' , 'laCDPais2623');
            gen.writeStringField('laCDCodigoPostal' , 'laCDCodigoPostal2624');
            gen.writeStringField('laMCDEstado' , 'laMCDEstado2625');
            gen.writeStringField('laCDCiudad' , 'laCDCiudad2626');
            gen.writeStringField('laCDMunicipioAlcaldia' , 'laCDMunicipioAlcaldia2627');
            gen.writeStringField('laCDColonia' , 'laCDColonia2628');
            gen.writeStringField('laCDCalle' , 'laCDCalle2629');
            gen.writeStringField('laCDNumExterior' , 'laCDNumExterior2630');
            gen.writeStringField('laCDNumInterior' , 'laCDNumInterior2631');
        gen.writeEndObject();
        
        gen.writeFieldName('datosFiscales');
        gen.writeStartObject();
        gen.writeStringField('laDFAddressId' , '2632');
        gen.writeStringField('laDFRfcTin' , 'laDFRfcTin2633');
        gen.writeStringField('laDFPais' , 'laDFPais2634');
        gen.writeStringField('laDFCodigoPostal' , 'laDFCodigoPostal2635');
        gen.writeStringField('laDFEstado' , 'laDFEstado2636');
        gen.writeStringField('laDFCiudad' , 'laDFCiudad2637');
        gen.writeStringField('laDFMunicipioAlcaldia' , 'laDFMunicipioAlcaldia2638');
        gen.writeStringField('laDFColonia' , 'laDFColonia2639');
        gen.writeStringField('laDFCalle' , 'laDFCalle2640');
        gen.writeStringField('laDFNumExterior' , 'laDFNumExterior2641');
        gen.writeStringField('laDFNumInterior' , 'laDFNumInterior2642');
        gen.writeStringField('laDFW8W9' , 'laDFW8W92643');
        gen.writeStringField('laDFCurp' , 'laDFCurp2644');
        gen.writeEndObject();
        
        gen.writeFieldName('apoderados');
        gen.writeStartObject();
        
        gen.writeFieldName('apoderado');
        gen.writeStartArray();
        gen.writeStartObject();
            gen.writeStringField('laAApoderadoID' , '2645');
            gen.writeStringField('laADocumentID' , '2646');
            gen.writeStringField('laANombreFacultado' , 'laANombreFacultado2647');
            gen.writeStringField('laAFecha' , 'laAFecha2648');
            gen.writeStringField('laAActosDominio' , 'laAActosDominio2649');
            gen.writeStringField('laATitulosCredito' , 'laATitulosCredito2650');
            gen.writeStringField('laAActosAdministrativos' , 'laAActosAdministrativos2651');
            gen.writeStringField('laAPleitosCobranza' , 'laAPleitosCobranza2652');
            gen.writeStringField('laAIndMan' , 'laAIndMan2653');
            gen.writeStringField('laAObservaciones' , 'laAObservaciones2654');
            gen.writeStringField('laAEscrituraNum' , 'laAEscrituraNum2655');
            gen.writeStringField('laAPEspecial' , 'laAPEspecial2656');
            gen.writeStringField('laAPOtros' , 'laAPOtros2657');
            gen.writeStringField('laAFedatarioPublico' , 'laAFedatarioPublico2658');
            gen.writeStringField('laAFechaRegistro' , 'laAFechaRegistro2659');
            gen.writeStringField('laALugarRegistro' , 'laALugarRegistro2660');
            gen.writeStringField('laADatosRegistro' , 'laADatosRegistro2661');
            gen.writeStringField('laAOcupacion' , 'laAOcupacion2662');
            gen.writeStringField('laAFechaNacimiento' , 'laAFechaNacimiento2663');
            gen.writeStringField('laANacionalidad' , 'laANacionalidad2664');
            gen.writeStringField('laADomicilio' , 'laADomicilio2665');
            gen.writeStringField('laAEscrituraRevoca' , 'laAEscrituraRevoca2666');
            gen.writeStringField('laAFechaRevoca' , 'laAFechaRevoca2667');
            gen.writeStringField('laALugarRevoca' , 'laALugarRevoca2668');
            gen.writeStringField('laADatosRegistroRevoca' , 'laADatosRegistroRevoca2669');
            gen.writeStringField('laAObservacionesRevoca' , 'laAObservacionesRevoca2670');
            gen.writeStringField('laAActiveFlag' , 'laAActiveFlag2671');
            gen.writeStringField('laACreatedBy' , 'laACreatedBy2672');
            gen.writeStringField('laACreationDate' , 'laACreationDate2673');
            gen.writeStringField('laALastUpdatedBy' , 'laALastUpdatedBy2674');
            gen.writeStringField('laALastUpdateDate' , 'laALastUpdateDate2675');
            gen.writeStringField('laANameCreatedBy' , 'laANameCreatedBy2676');
            gen.writeStringField('laANameUpdatedBy' , 'laANameUpdatedBy2677');
        gen.writeEndObject();
        gen.writeEndArray();
        
        gen.writeEndObject();
        
        gen.writeEndObject();
        
        ///Física
        gen.writeFieldName('fisica');
        //Inicia física
        gen.writeStartObject();
            //        
            gen.writeFieldName('datosGenerales');
            gen.writeStartObject();
                gen.writeStringField('laPFDGNombre' , 'laPFDGNombre2678');
                gen.writeStringField('laPFDGFechadenacimiento' , 'laPFDGFechadenacimiento2679');
                gen.writeStringField('laPFDGLugardenacimiento' , 'laPFDGLugardenacimiento2680');
                gen.writeStringField('laPFDGEstadoCivil' , 'laPFDGNombre2678');
                gen.writeStringField('laPFDGVigenciaId' , 'laPFDGVigenciaId2682');
                gen.writeStringField('laPFDGComentarios' , 'laPFDGComentarios2683');
            gen.writeEndObject();
            //
            gen.writeFieldName('domicilioSocial');
            gen.writeStartObject();
                gen.writeStringField('laDSAddressID' , '2684');
                gen.writeStringField('laDSPais' , 'laDSPais2685');
                gen.writeStringField('laDSCodigoPostal' , 'laDSCodigoPostal2686');
                gen.writeStringField('laDSEstado' , 'laDSEstado2687');
                gen.writeStringField('laDSCiudad' , 'laDSCiudad2688');
                gen.writeStringField('laDSMunicipioAlcaldia' , 'laDSMunicipioAlcaldia2689');
                gen.writeStringField('laDSColonia' , 'laDSColonia2690');
                gen.writeStringField('laDSCalle' , 'laDSCalle2691');
                gen.writeStringField('laDSNumExterior' , 'laDSNumExterior2692');
                gen.writeStringField('laDSNumInterior' , 'laDSNumInterior2693');
            gen.writeEndObject();
            //
            gen.writeFieldName('comprobanteDomicilio');
            gen.writeStartObject();
                gen.writeStringField('laCDAddressId' , '2694');
                gen.writeStringField('laCDPais' , 'laCDPais2695');
                gen.writeStringField('laCDCodigoPostal' , 'laCDCodigoPostal2696');
                gen.writeStringField('laMCDEstado' , 'laMCDEstado2697');
                gen.writeStringField('laCDCiudad' , 'laCDCiudad2698');
                gen.writeStringField('laCDMunicipioAlcaldia' , 'laCDMunicipioAlcaldia2699');
                gen.writeStringField('laCDColonia' , 'laCDColonia2700');
                gen.writeStringField('laCDCalle' , 'laCDCalle2701');
                gen.writeStringField('laCDNumExterior' , 'laCDNumExterior2702');
                gen.writeStringField('laCDNumInterior' , 'laCDNumInterior2703');
            gen.writeEndObject();
            //
            gen.writeFieldName('datosFiscales');
            gen.writeStartObject();
                gen.writeStringField('laDFAddressId' , '2704');
                gen.writeStringField('laDFRfcTin' , 'laDFRfcTin2705');
                gen.writeStringField('laDFPais' , 'laDFPais2706');
                gen.writeStringField('laDFCodigoPostal' , 'laDFCodigoPostal2707');
                gen.writeStringField('laDFEstado' , 'laDFEstado2708');
                gen.writeStringField('laDFCiudad' , 'laDFCiudad2709');
                gen.writeStringField('laDFMunicipioAlcaldia' , 'laDFMunicipioAlcaldia2710');
                gen.writeStringField('laDFColonia' , 'laDFColonia2711');
                gen.writeStringField('laDFCalle' , 'laDFCalle2712');
                gen.writeStringField('laDFNumExterior' , 'laDFNumExterior2713');
                gen.writeStringField('laDFNumInterior' , 'laDFNumInterior2714');
                gen.writeStringField('laDFW8W9' , 'laDFW8W92715');
                gen.writeStringField('laDFCurp' , 'laDFCurp2716');
            gen.writeEndObject();
            //
            gen.writeFieldName('apoderados');
            gen.writeStartObject();
                //
                gen.writeFieldName('apoderado');
                gen.writeStartArray();
                ///
                gen.writeStartObject();
                    gen.writeStringField('laAApoderadoID' , '2717');
                    gen.writeStringField('laADocumentID' , '2718');
                    gen.writeStringField('laANombreFacultado' , 'laANombreFacultado2719');
                    gen.writeStringField('laAFecha' , 'laAFecha2720');
                    gen.writeStringField('laAActosDominio' , 'laAActosDominio2721');
                    gen.writeStringField('laATitulosCredito' , 'laATitulosCredito2722');
                    gen.writeStringField('laAActosAdministrativos' , 'laAActosAdministrativos2723');
                    gen.writeStringField('laAPleitosCobranza' , 'laAPleitosCobranza2724');
                    gen.writeStringField('laAIndMan' , 'laAIndMan2725');
                    gen.writeStringField('laAObservaciones' , 'laAObservaciones2726');
                    gen.writeStringField('laAEscrituraNum' , 'laAEscrituraNum2727');
                    gen.writeStringField('laAPEspecial' , 'laAPEspecial2728');
                    gen.writeStringField('laAPOtros' , 'laAPOtros2729');
                    gen.writeStringField('laAFedatarioPublico' , 'laAFedatarioPublico2730');
                    gen.writeStringField('laAFechaRegistro' , 'laAFechaRegistro2731');
                    gen.writeStringField('laALugarRegistro' , 'laALugarRegistro2732');
                    gen.writeStringField('laADatosRegistro' , 'laADatosRegistro2733');
                    gen.writeStringField('laAOcupacion' , 'laAOcupacion2734');
                    gen.writeStringField('laAFechaNacimiento' , 'laAFechaNacimiento2735');        
                    gen.writeStringField('laANacionalidad' , 'laANacionalidad2736');
                    gen.writeStringField('laADomicilio' , 'laADomicilio2737');
                    gen.writeStringField('laAEscrituraRevoca' , 'laAEscrituraRevoca2738');
                    gen.writeStringField('laAFechaRevoca' , 'laAFechaRevoca2739');
                    gen.writeStringField('laALugarRevoca' , 'laALugarRevoca2740');
                    gen.writeStringField('laADatosRegistroRevoca' , 'laADatosRegistroRevoca2741');
                    gen.writeStringField('laAObservacionesRevoca' , 'laAObservacionesRevoca2742');
                    gen.writeStringField('laAActiveFlag' , 'laAActiveFlag2743');
                    gen.writeStringField('laACreatedBy' , 'laACreatedBy2744');
                    gen.writeStringField('laACreationDate' , 'laACreationDate2745');
                    gen.writeStringField('laALastUpdatedBy' , 'laALastUpdatedBy2746');
                    gen.writeStringField('laALastUpdateDate' , 'laALastUpdateDate2747');
                    gen.writeStringField('laANameCreatedBy' , 'laANameCreatedBy2748');
                    gen.writeStringField('laANameUpdatedBy' , 'laANameUpdatedBy2749');
                gen.writeEndObject();
                ///
                gen.writeStartObject();
                    gen.writeStringField('laAApoderadoID' , '2719');
                    gen.writeStringField('laADocumentID' , '2719');
                    gen.writeStringField('laANombreFacultado' , 'laANombreFacultado2619');
                    gen.writeStringField('laAFecha' , 'laAFecha2721');
                    gen.writeStringField('laAActosDominio' , 'laAActosDominio2722');
                    gen.writeStringField('laATitulosCredito' , 'laATitulosCredito2723');
                    gen.writeStringField('laAActosAdministrativos' , 'laAActosAdministrativos2724');
                    gen.writeStringField('laAPleitosCobranza' , 'laAPleitosCobranza2725');
                    gen.writeStringField('laAIndMan' , 'laAIndMan2726');
                    gen.writeStringField('laAObservaciones' , 'laAObservaciones2727');
                    gen.writeStringField('laAEscrituraNum' , 'laAEscrituraNum2728');
                    gen.writeStringField('laAPEspecial' , 'laAPEspecial2729');
                    gen.writeStringField('laAPOtros' , 'laAPOtros2731');
                    gen.writeStringField('laAFedatarioPublico' , 'laAFedatarioPublico2732');
                    gen.writeStringField('laAFechaRegistro' , 'laAFechaRegistro2733');
                    gen.writeStringField('laALugarRegistro' , 'laALugarRegistro2734');
                    gen.writeStringField('laADatosRegistro' , 'laADatosRegistro2735');
                    gen.writeStringField('laAOcupacion' , 'laAOcupacion2737');
                    gen.writeStringField('laAFechaNacimiento' , 'laAFechaNacimiento2738');        
                    gen.writeStringField('laANacionalidad' , 'laANacionalidad2739');
                    gen.writeStringField('laADomicilio' , 'laADomicilio2740');
                    gen.writeStringField('laAEscrituraRevoca' , 'laAEscrituraRevoca2741');
                    gen.writeStringField('laAFechaRevoca' , 'laAFechaRevoca2742');
                    gen.writeStringField('laALugarRevoca' , 'laALugarRevoca2743');
                    gen.writeStringField('laADatosRegistroRevoca' , 'laADatosRegistroRevoca2744');
                    gen.writeStringField('laAObservacionesRevoca' , 'laAObservacionesRevoca2745');
                    gen.writeStringField('laAActiveFlag' , 'laAActiveFlag2746');
                    gen.writeStringField('laACreatedBy' , 'laACreatedBy2747');
                    gen.writeStringField('laACreationDate' , 'laACreationDate2748');
                    gen.writeStringField('laALastUpdatedBy' , 'laALastUpdatedBy2749');
                    gen.writeStringField('laALastUpdateDate' , 'laALastUpdateDate2750');
                    gen.writeStringField('laANameCreatedBy' , 'laANameCreatedBy2751');
                    gen.writeStringField('laANameUpdatedBy' , 'laANameUpdatedBy2752');
                gen.writeEndObject();
                gen.writeEndArray();
                //
            gen.writeEndObject();
        //Termina física
        
        gen.writeEndObject();
        ///
        gen.writeEndObject();
        
        
        
        gen.writeEndObject();
        
        //lo demas 
        gen.writeFieldName('entityDocument');
        gen.writeStartObject();
        gen.writeStringField('entityDocDummy' , 'AAAA');
        gen.writeEndObject();
        
        gen.writeFieldName('entityComment');
        gen.writeStartObject();
        gen.writeStringField('entityComDummy' , 'AAAA');
        gen.writeEndObject();
        
        gen.writeFieldName('comments');
        gen.writeStartObject();
        gen.writeFieldName('comment');
        gen.writeStartArray();
        gen.writeStartObject();
        gen.writeStringField('comId' , '1111');
        gen.writeStringField('comSection' , 'AML');
        gen.writeStringField('comComment' , 'AAAAA');
        gen.writeStringField('comCreatedBy' , 'AAAAA');
        gen.writeStringField('comCreationDate' , 'AAAAA');
        gen.writeStringField('comUpdatedBy' , 'AAAAA');
        gen.writeStringField('comLastUpdateDate' , 'AAAAA');
        gen.writeEndObject(); 
        gen.writeStartObject();
        gen.writeStringField('comId' , '1111');
        gen.writeStringField('comSection' , 'Credit Bureau');
        gen.writeStringField('comComment' , 'BBBBB');
        gen.writeStringField('comCreatedBy' , 'BBBBB');
        gen.writeStringField('comCreationDate' , 'BBBBB');
        gen.writeStringField('comUpdatedBy' , 'AAAAA');
        gen.writeStringField('comLastUpdateDate' , 'AAAAA');
        gen.writeEndObject();
        gen.writeStartObject();
        gen.writeStringField('comId' , '1111');
        gen.writeStringField('comSection' , 'NDA');
        gen.writeStringField('comComment' , 'AAAAA');
        gen.writeStringField('comCreatedBy' , 'AAAAA');
        gen.writeStringField('comCreationDate' , 'AAAAA');
        gen.writeStringField('comUpdatedBy' , 'AAAAA');
        gen.writeStringField('comLastUpdateDate' , 'AAAAA');
        gen.writeEndObject();
        gen.writeEndArray();
        gen.writeEndObject();
        
        gen.writeFieldName('documents');
        gen.writeStartObject();
        gen.writeFieldName('document');
        gen.writeStartArray();
        gen.writeStartObject();
        gen.writeStringField('docId' , '1111');
        gen.writeStringField('docType' , 'AAAAA');
        gen.writeStringField('docName' , 'AAAAA');
        gen.writeStringField('docStatus' , 'AAAAA');
        gen.writeStringField('docURL' , 'AAAAA');
        gen.writeStringField('docStartDate' , '2018-12-31');
        gen.writeStringField('docEndDate' , 'AAAAA');
        gen.writeStringField('createdBy' , 'AAAAA');
        gen.writeStringField('creationDate' , 'AAAAA');
        gen.writeEndObject(); 
        
        gen.writeStartObject();
        gen.writeStringField('docId' , '22222');
        gen.writeStringField('docType' , 'AAAAA');
        gen.writeStringField('docName' , 'BBBBB');
        gen.writeStringField('docStatus' , 'AAAAA');
        gen.writeStringField('docURL' , 'AAAAA');
        gen.writeStringField('docStartDate' , '2018-12-31');
        gen.writeStringField('docEndDate' , 'AAAAA');
        gen.writeStringField('createdBy' , 'AAAAA');
        gen.writeStringField('creationDate' , 'AAAAA');
        gen.writeEndObject(); 
        
        gen.writeStartObject();
        gen.writeStringField('docId' , '33333');
        gen.writeStringField('docType' , 'AAAAA');
        gen.writeStringField('docName' , 'CCCCC');
        gen.writeStringField('docStatus' , 'AAAAA');
        gen.writeStringField('docURL' , 'AAAAA');
        gen.writeStringField('docStartDate' , '2018-12-31');
        gen.writeStringField('docEndDate' , 'AAAAA');
        gen.writeStringField('createdBy' , 'AAAAA');
        gen.writeStringField('creationDate' , 'AAAAA');
        gen.writeEndObject(); 
        gen.writeEndArray();
        gen.writeEndObject();
        
        gen.writeFieldName('audits');
        gen.writeStartObject();
        gen.writeFieldName('audit');
        gen.writeStartArray();
        gen.writeStartObject();
        gen.writeStringField('auditUpdatedBy' , 'AAAAA');
        gen.writeStringField('auditLastUpdateDate' , 'AAAAA');
        gen.writeStringField('auditField' , 'AAAAA');
        gen.writeStringField('auditLastValue' , 'AAAAA');
        gen.writeStringField('auditNewValue' , 'AAAAA');
        gen.writeStringField('auditComment' , 'AUDIT 1');
        gen.writeEndObject(); 
        
        gen.writeStartObject();
        gen.writeStringField('auditUpdatedBy' , 'AAAAA');
        gen.writeStringField('auditLastUpdateDate' , 'AAAAA');
        gen.writeStringField('auditField' , 'AAAAA');
        gen.writeStringField('auditLastValue' , 'AAAAA');
        gen.writeStringField('auditNewValue' , 'AAAAA');
        gen.writeStringField('auditComment' , 'AUDIT 2');
        gen.writeEndObject(); 
        
        gen.writeStartObject();
        gen.writeStringField('auditUpdatedBy' , 'AAAAA');
        gen.writeStringField('auditLastUpdateDate' , 'AAAAA');
        gen.writeStringField('auditField' , 'AAAAA');
        gen.writeStringField('auditLastValue' , 'AAAAA');
        gen.writeStringField('auditNewValue' , 'AAAAA');
        gen.writeStringField('auditComment' , 'AUDIT 3');
        gen.writeEndObject(); 
        gen.writeEndArray();
        gen.writeEndObject();
        
        gen.writeEndObject();
        gen.writeEndArray();
        gen.writeEndObject(); 
        
        gen.writeFieldName('status');
        gen.writeStartObject();
        gen.writeStringField('code' , 'AAAA');
        gen.writeStringField('message' , 'AAAA');
        gen.writeStringField('detail' , 'AAAA');
        gen.writeEndObject();
        
        gen.writeEndObject();
        String jsonS = gen.getAsString(); 
        return jsonS;
    }
    public static String JsonnULO(string requesty)
    {
        JSONGenerator gen = JSON.createGenerator(true);    
        gen.writeStartObject();
        gen.writeFieldName('requests');
        gen.writeStartObject();
        gen.writeFieldName('request');
        gen.writeStartArray();
        gen.writeStartObject();
        gen.writeFieldName('header');
        gen.writeStartObject();
        gen.writeStringField('requestId' ,  '');
        gen.writeStringField('rootRequestId' ,  '');
        gen.writeStringField('requestType' ,  requesty);
        gen.writeStringField('ndaType' ,  '');
        gen.writeStringField('applicationId' ,  '');
        gen.writeStringField('sourceAccountId' ,  '');
        gen.writeStringField('sourceTopParentId' ,  '');
        gen.writeStringField('partyId' ,  '');
        gen.writeStringField('partyName' ,  '');
        gen.writeStringField('egPartyId' ,  '');
        gen.writeStringField('egPartyName' ,  '');
        gen.writeStringField('sourceOpId' ,  '');
        gen.writeStringField('sourceCAId' ,  '');
        gen.writeStringField('startDate' ,  '');
        gen.writeStringField('endDate' ,  '');
        gen.writeStringField('requestStatus' ,  '');
        gen.writeStringField('createdBy' ,  '');
        gen.writeStringField('requestedBy' ,  '');
        gen.writeStringField('assignedGroup' ,  '');
        gen.writeStringField('assignedTo' ,  '');
        gen.writeStringField('assignedDate' ,  '');
        gen.writeStringField('activeFlag' ,  '');
        gen.writeStringField('creationDate' ,  '');
        gen.writeStringField('updatedBy' ,  '');
        gen.writeStringField('lastUpdateDate' ,  '');
        gen.writeStringField('solvedBy' ,  '');
        gen.writeStringField('solvedDate' ,  '');
        gen.writeStringField('finantialEntity' ,  '');
        
        gen.writeFieldName('docTypes');
        gen.writeStartObject();
        gen.writeFieldName('docType');
        gen.writeStartArray();
        
        gen.writeStartObject();
        gen.writeStringField('docTypeId' ,  '');
        gen.writeStringField('docSection' ,  '');
        gen.writeStringField('docTypeName' ,  '');
        gen.writeStringField('docTypeReqFlag' ,  '');
        gen.writeEndObject(); 
        
        gen.writeStartObject();
        gen.writeStringField('docTypeId' ,  '');
        gen.writeStringField('docSection' ,  '');
        gen.writeStringField('docTypeName' ,  '');
        gen.writeStringField('docTypeReqFlag' ,  '');
        gen.writeEndObject();
        
        gen.writeEndArray();
        gen.writeEndObject();
        
        gen.writeEndObject();
        
        gen.writeFieldName('privileges');
        gen.writeStartObject();
        gen.writeFieldName('privilege');
        gen.writeStartArray();
        
        gen.writeStartObject();
        gen.writeStringField('sso' ,  '');
        gen.writeStringField('applicationName' ,  '');
        gen.writeStringField('applicationCode' ,  '');
        gen.writeStringField('screen' ,  '');
        gen.writeStringField('section' , '');
        gen.writeStringField('employeeName' ,  '');
        gen.writeStringField('vCrud' , '');
        gen.writeEndObject();
        
        gen.writeStartObject();
        gen.writeStringField('sso' ,  '');
        gen.writeStringField('applicationName' ,  '');
        gen.writeStringField('applicationCode' ,  '');
        gen.writeStringField('screen' ,  '');
        gen.writeStringField('section' , '');
        gen.writeStringField('employeeName' ,  '');
        gen.writeStringField('vCrud' , '');
        gen.writeEndObject();
        
        gen.writeStartObject();
        gen.writeStringField('sso' ,  '');
        gen.writeStringField('applicationName' ,  '');
        gen.writeStringField('applicationCode' ,  '');
        gen.writeStringField('screen' ,  '');
        gen.writeStringField('section' , '');
        gen.writeStringField('employeeName' ,  '');
        gen.writeStringField('vCrud' , '');
        gen.writeEndObject();
        
        gen.writeEndArray();
        gen.writeEndObject();
        
        gen.writeFieldName('amlCRR');
        gen.writeStartObject();
        gen.writeStringField('crr' ,  '');
        gen.writeStringField('crrModificationDate' ,  '');
        gen.writeStringField('crrExpirationDate' ,  '');
        gen.writeStringField('crrOverride' ,  '');
        gen.writeStringField('crrSourceType' ,  '');
        gen.writeStringField('crrComments' ,  '');
        gen.writeEndObject();
        
        gen.writeFieldName('amlHit');
        gen.writeStartObject();
        gen.writeStringField('hitRFC' ,  '');
        gen.writeStringField('hitEntityName' ,  '');
        gen.writeStringField('hitExpirationDate' ,  '');
        gen.writeStringField('hitFlag' ,  '');
        gen.writeStringField('hitUwStatus' ,  '');
        gen.writeStringField('hitUwComments' ,  '');
        gen.writeStringField('hitAMLStatus' ,  '');
        gen.writeStringField('hitAMLComments' ,  '');
        gen.writeStringField('hitAMLMaxPercent' ,  '');
        gen.writeFieldName('hits');
        gen.writeStartObject();
        gen.writeFieldName('hit');
        gen.writeStartArray();
        
        gen.writeStartObject();
        gen.writeStringField('hitSource' ,  '');
        gen.writeStringField('hitDescription' , '');
        gen.writeStringField('hitPercent' ,  '');
        gen.writeEndObject(); 
        
        gen.writeStartObject();
        gen.writeStringField('hitSource' ,  '');
        gen.writeStringField('hitDescription' , '');
        gen.writeStringField('hitPercent' ,  '');
        gen.writeEndObject(); 
        gen.writeEndArray();
        gen.writeEndObject();
        gen.writeEndObject();
        
        gen.writeFieldName('creditBoureau');
        gen.writeStartObject();
        gen.writeStringField('cbPartySiteID' ,  '');
        gen.writeStringField('cbLegalPartyId' ,  '');
        gen.writeStringField('cbLegalPartyAlias' ,  '');
        gen.writeStringField('cbRejectReason' ,  '');
        gen.writeStringField('cbLetterFlag' ,  '');
        gen.writeStringField('rfc' ,  '');
        gen.writeStringField('cbCustomerType' , '');
        gen.writeStringField('cbName' ,  '');
        gen.writeStringField('cbSecondName' ,  '');
        gen.writeStringField('cbLastName' ,  '');
        gen.writeStringField('cbSecondLastName' ,  '');
        gen.writeStringField('cbAPIRequestor' ,  '');
        gen.writeStringField('companyName' ,  '');
        gen.writeStringField('address' ,  '');
        gen.writeStringField('ecEntity' ,  '');
        gen.writeStringField('letterSigningDate' ,  '');
        gen.writeStringField('letterSigningPlace' ,  '');
        gen.writeStringField('alias' ,  '');
        gen.writeStringField('street' ,  '');
        gen.writeStringField('CBIntNum' ,  '');
        gen.writeStringField('CBOutNum' ,  '');
        gen.writeStringField('CBMunicipality' ,  '');
        gen.writeStringField('suburb' ,  '');
        gen.writeStringField('zipCode' ,  '');
        gen.writeStringField('city' ,  '');
        gen.writeStringField('state' ,  '');
        gen.writeStringField('country' ,  '');
        gen.writeStringField('autorizationLetter' ,  '');
        gen.writeEndObject();
        
        /*gen.writeFieldName('creditApproval');
gen.writeStartObject();
gen.writeFieldName('parties');
gen.writeStartObject();
gen.writeFieldName('party');
gen.writeStartArray();
gen.writeStartObject();
gen.writeStringField('oppPartyId' , '');
gen.writeStringField('oppPartyName' , '');
gen.writeStringField('oppPartyObligorFlag' , '');
gen.writeStringField('oppPartyGuarantorFlag' , '');
gen.writeStringField('oppPartyBOFlag' , '');
gen.writeStringField('oppPartyRDEFlag' , '');
gen.writeEndObject(); 

gen.writeStartObject();
gen.writeStringField('oppPartyId' , '');
gen.writeStringField('oppPartyName' , '');
gen.writeStringField('oppPartyObligorFlag' , '');
gen.writeStringField('oppPartyGuarantorFlag' , '');
gen.writeStringField('oppPartyBOFlag' , '');
gen.writeStringField('oppPartyRDEFlag' , '');
gen.writeEndObject(); 
gen.writeEndArray();
gen.writeEndObject();
gen.writeEndObject(); */
        
        gen.writeFieldName('economicGroup');
        gen.writeStartObject();
        gen.writeStringField('egProposedName' , '');
        gen.writeStringField('egPartyId' , '');
        gen.writeStringField('egPartyName' , '');
        gen.writeStringField('egSicId' , '');
        gen.writeStringField('egSicDescription' , '');
        gen.writeEndObject();  
        
        gen.writeFieldName('kycInd');
        gen.writeStartObject();
        gen.writeStringField('kycIndName' ,  '');
        
        gen.writeFieldName('datosGenerales');
        gen.writeStartObject();
        gen.writeStringField('kycIndGDBirthDate' ,  '');
        gen.writeStringField('kycIndGDRFC' ,  '');
        gen.writeStringField('kycIndGDCURP' ,  '');
        gen.writeStringField('kycIndGDNacionalities' ,  '');
        gen.writeStringField('kycIndGDFEASerialNo' ,  '');
        gen.writeStringField('kycIndGDBirthCountry' ,  '');
        gen.writeStringField('kycIndGDBirthState' ,  '');
        gen.writeStringField('kycIndGDSex' ,  '');
        gen.writeStringField('kycIndGDMarriageStatus' ,  '');
        gen.writeStringField('kycIndGDMarriageRegime' ,  '');
        gen.writeStringField('kycIndGDNameOfSpouse' ,  '');
        gen.writeEndObject();
        
        gen.writeFieldName('domicilioParticular');
        gen.writeStartObject();
        gen.writeStringField('kycIndAdrStreet' ,  '');
        gen.writeStringField('kycIndAdrOutNum' ,  '');
        gen.writeStringField('kycIndAdrIntNum' ,  '');
        gen.writeStringField('kycIndAdrCounty' ,  '');
        gen.writeStringField('kycIndAdrMunicipality' ,  '');
        gen.writeStringField('kycIndAdrCity' ,  '');
        gen.writeStringField('kycIndAdrState' ,  '');
        gen.writeStringField('kycIndAdrCountry' ,  '');
        gen.writeStringField('kycIndIntAdrZipCode' ,  '');
        gen.writeEndObject();
        
        gen.writeFieldName('datosGralesEmpleo');
        gen.writeStartObject();
        gen.writeStringField('kycIndBizTitle' ,  '');
        gen.writeStringField('kycIndBizRelatedPaties' ,  '');
        gen.writeEndObject();
        
        gen.writeFieldName('ppe');
        gen.writeStartObject();
        gen.writeStringField('kycIndPPEFlag' ,  '');
        gen.writeStringField('kycIndPPEJob' ,  '');
        gen.writeStringField('kycIndPPEAFlag' ,  '');
        gen.writeStringField('kycIndPPEAName' ,  '');
        gen.writeStringField('kycIndPPEARelationship' ,  '');
        gen.writeEndObject();
        
        gen.writeFieldName('tablaProveedorRecursos');
        gen.writeStartObject();
        gen.writeFieldName('proveedorRecurso');
        gen.writeStartArray();
        gen.writeStartObject();
        gen.writeStringField('kycIndResLegalName' ,  '');
        gen.writeStringField('kycIndResCountry' ,  '');
        gen.writeStringField('kycIndResRFC' ,  '');
        gen.writeStringField('kycIndResAddress' ,  '');
        gen.writeStringField('kycIndResFEASerialNo' ,  '');
        gen.writeEndObject(); 
        gen.writeEndArray();
        gen.writeEndObject();
        
        gen.writeFieldName('suscritoPor');
        gen.writeStartObject();
        gen.writeStringField('kycIndSignName' ,  '');
        gen.writeStringField('kycIndSignFlag' ,  '');
        gen.writeStringField('kycIndSignPowerFlag' ,  '');
        gen.writeStringField('kycIndSignPublicDeedNum' ,  '');
        gen.writeStringField('kycIndSignPublicDeedDate' ,  '');
        gen.writeStringField('kycIndSignNotaryName' ,  '');
        gen.writeStringField('kycIndSignNotaryNum' ,  '');
        gen.writeStringField('kycIndSignNotaryState' ,  '');
        gen.writeStringField('kycIndSignDateDay' ,  '');
        gen.writeStringField('kycIndSignDateMonth' ,  '');
        gen.writeStringField('kycIndSignDateYear' ,  '');
        gen.writeEndObject();
        
        gen.writeEndObject();
        
        gen.writeFieldName('kycOrg');
        gen.writeStartObject();
        gen.writeStringField('kycOrgName' ,  '');
        
        gen.writeFieldName('datosGenerales');
        gen.writeStartObject();
        gen.writeStringField('kycOrgGDRFC' ,  '');
        gen.writeStringField('kycOrgGDBirthDate' ,  '');
        gen.writeStringField('kycOrgGDNacionality' ,  '');
        gen.writeStringField('kycOrgGDFEASerialNo' ,  '');
        gen.writeStringField('kycOrgGDPhone' ,  '');
        gen.writeStringField('kycOrgGDEmail' ,  '');
        gen.writeStringField('kycOrgGDActivity' ,  '');
        gen.writeEndObject();
        
        gen.writeFieldName('domicilioParticular');
        gen.writeStartObject();
        gen.writeStringField('kycOrgAdrStreet' ,  '');
        gen.writeStringField('kycOrgAdrOutNum' ,  '');
        gen.writeStringField('kycOrgAdrIntNum' ,  '');
        gen.writeStringField('kycOrgAdrCounty' ,  '');
        gen.writeStringField('kycOrgAdrMunicipality' ,  '');
        gen.writeStringField('kycOrgAdrCity' ,  '');
        gen.writeStringField('kycOrgAdrState' ,  '');
        gen.writeStringField('kycOrgIntAdrCountry' ,  '');
        gen.writeStringField('kycOrgIntAdrZipCode' ,  '');
        gen.writeEndObject();
        
        gen.writeFieldName('actividadEconomica');
        gen.writeStartObject();
        gen.writeStringField('kycOrgActGovFlag' ,  '');
        gen.writeStringField('kycOrgActGovPartyName' ,  '');
        gen.writeStringField('kycOrgActGovAnnualIncome' ,  '');
        gen.writeStringField('kycOrgActGovServices' ,  '');
        gen.writeStringField('kycOrgActGovAge' ,  '');
        gen.writeEndObject();
        
        gen.writeStringField('kycOrgFinanceUse' ,  '');
        
        gen.writeFieldName('mercadoGeografico');
        gen.writeStartObject();
        gen.writeStringField('kycOrgCorpSites' ,  '');
        gen.writeStringField('kycOrgMktSites' ,  '');
        gen.writeEndObject();
        
        gen.writeFieldName('tablaCuentasBancarias');
        gen.writeStartObject();
        gen.writeFieldName('cuentaBancaria');
        gen.writeStartArray();
        gen.writeStartObject();
        gen.writeStringField('kycOrgBankName' ,  '');
        gen.writeStringField('kycOrgBankAccount' ,  '');
        gen.writeStringField('kycOrgBankCountry' ,  '');
        gen.writeEndObject(); 
        gen.writeEndArray();
        gen.writeEndObject();
        
        gen.writeStringField('kycOrgBankPayeeName' ,  '');
        
        gen.writeFieldName('ppe');
        gen.writeStartObject();
        gen.writeStringField('kycOrgPPEFlag' ,  '');
        gen.writeStringField('kycOrgPPEJob' ,  '');
        gen.writeStringField('kycOrgPPEName' ,  '');
        gen.writeStringField('kycOrgPPEAName' ,  '');
        gen.writeStringField('kycOrgPPEARelationship' ,  '');
        gen.writeStringField('kycOrgPPEABoardJob' ,  '');
        gen.writeStringField('kycOrgPPEABoardName' ,  '');
        gen.writeStringField('kycOrgPPEAName2' ,  '');
        gen.writeStringField('kycOrgPPEARelationship2' ,  '');
        gen.writeEndObject();
        
        gen.writeFieldName('tablaProveedoresRecursos');
        gen.writeStartObject();
        gen.writeFieldName('proveedorRecurso');
        gen.writeStartArray();
        gen.writeStartObject();
        gen.writeStringField('kycOrgResLegalName' ,  '');
        gen.writeStringField('kycOrgResCountry' ,  '');
        gen.writeStringField('kycOrgResRFC' ,  '');
        gen.writeStringField('kycOrgResAddress' ,  '');
        gen.writeStringField('kycOrgResFEASerialNo' ,  '');
        gen.writeEndObject(); 
        gen.writeEndArray();
        gen.writeEndObject();
        
        gen.writeFieldName('tablaComposicionCapSocial');
        gen.writeStartObject();
        gen.writeFieldName('capitalSocial');
        gen.writeStartArray();
        gen.writeStartObject();
        gen.writeStringField('kycOrgPartnerLegalName' ,  '');
        gen.writeStringField('kycOrgPartnerCountry' ,  '');
        gen.writeStringField('kycOrgPartnerRFC' ,  '');
        gen.writeStringField('kycOrgPartnerPorcent' ,  '');
        gen.writeEndObject(); 
        gen.writeEndArray();
        gen.writeEndObject();
        
        gen.writeStringField('kycOrgPartnerOrgName' ,  '');
        
        gen.writeFieldName('tablaAccSociosPM');
        gen.writeStartObject();
        gen.writeFieldName('accionistasPM');
        gen.writeStartArray();
        gen.writeStartObject();
        gen.writeStringField('kycOrgPartnerOrgLegalName' ,  '');
        gen.writeStringField('kycOrgPartnerOrgCountry' ,  '');
        gen.writeStringField('kycOrgPartnerOrgRFC' ,  '');
        gen.writeStringField('kycOrgPartnerOrgPorcent' ,  '');
        gen.writeEndObject(); 
        gen.writeEndArray();
        gen.writeEndObject();
        
        gen.writeStringField('kycOrgTrustOrgName' ,  '');
        
        gen.writeFieldName('tablaAccSociosFideicomisos');
        gen.writeStartObject();
        gen.writeFieldName('accionistaFideicomiso');
        gen.writeStartArray();
        gen.writeStartObject();
        gen.writeStringField('kycOrgTrustLegalName' ,  '');
        gen.writeStringField('kycOrgTrustCountry' ,  '');
        gen.writeStringField('kycOrgTrustRFC' ,  '');
        gen.writeStringField('kycOrgTrustPersons' ,  '');
        gen.writeEndObject(); 
        gen.writeEndArray();
        gen.writeEndObject();
        
        gen.writeFieldName('tablaAccSociosPF');
        gen.writeStartObject();
        gen.writeFieldName('accionistaPF');
        gen.writeStartArray();
        gen.writeStartObject();
        gen.writeStringField('kycOrgPartnerIndLegalName' ,  '');
        gen.writeStringField('kycOrgPartnerIndCountry' ,  '');
        gen.writeStringField('kycOrgPartnerIndRFC' ,  '');
        gen.writeStringField('kycOrgPartnerIndPorcent' ,  '');
        gen.writeEndObject(); 
        gen.writeEndArray();
        gen.writeEndObject();
        
        gen.writeStringField('kycOrgBizManagedBy' ,  '');
        
        gen.writeFieldName('tablaSocAdminPor');
        gen.writeStartObject();
        gen.writeFieldName('administradoPor');
        gen.writeStartArray();
        gen.writeStartObject();
        gen.writeStringField('kycOrgBizManagerName' ,  '');
        gen.writeStringField('kycOrgBizManagerTitle' ,  '');
        gen.writeStringField('kycOrgBizManagerRFC' ,  '');
        gen.writeEndObject(); 
        gen.writeEndArray();
        gen.writeEndObject();
        
        gen.writeFieldName('tablaFuncionariosPrincipales');
        gen.writeStartObject();
        gen.writeFieldName('funcionarioPrincipal');
        gen.writeStartArray();
        gen.writeStartObject();
        gen.writeStringField('kycOrgBizMainName' ,  '');
        gen.writeStringField('kycOrgBizMainTitle' ,  '');
        gen.writeStringField('kycOrgBizMainRFC' ,  '');
        gen.writeEndObject(); 
        gen.writeEndArray();
        gen.writeEndObject();
        
        gen.writeStringField('kycOrgCorpName' ,  '');
        
        gen.writeFieldName('tablaGrupoEmpresarial');
        gen.writeStartObject();
        gen.writeFieldName('grupoEmpresarial');
        gen.writeStartArray();
        gen.writeStartObject();
        gen.writeStringField('kycOrgCorpLegalName' ,  '');
        gen.writeStringField('kycOrgCorpCountry' ,  '');
        gen.writeStringField('kycOrgCorpAddress' ,  '');
        gen.writeStringField('kycOrgCorpObjective' ,  '');
        gen.writeStringField('kycOrgCorpPercent' ,  '');
        gen.writeEndObject(); 
        gen.writeEndArray();
        gen.writeEndObject();
        
        gen.writeFieldName('certificacionRepresentanteLegal');
        gen.writeStartObject();
        gen.writeStringField('kycOrgSignName' ,  '');
        gen.writeStringField('kycOrgSignJob' ,  '');
        gen.writeStringField('kycOrgSignPublicDeedNum' ,  '');
        gen.writeStringField('kycOrgSignPublicDeedDate' ,  '');
        gen.writeStringField('kycOrgSignNotaryName' ,  '');
        gen.writeStringField('kycOrgSignNotaryNum' ,  '');
        gen.writeStringField('kycOrgSignNotaryState' ,  '');
        gen.writeStringField('kycOrgSignDateDay' ,  '');
        gen.writeStringField('kycOrgSignDateMonth' ,  '');
        gen.writeStringField('kycOrgSignDateYear' ,  '');
        gen.writeEndObject();
        
        gen.writeFieldName('eval');
        gen.writeStartObject();
        gen.writeFieldName('evalHeader ');
        gen.writeStartObject();
         gen.writeStringField('evEvalType','');
         gen.writeStringField('evInsuranceReqFlag','');
         gen.writeStringField('evEfaReqFlag','');
         gen.writeStringField('evSlbFlag','');
         gen.writeStringField('evImportsReqFlag','');
         gen.writeStringField('evProgressPayFlag','');
         gen.writeStringField('evShowFMVFlag','');
         gen.writeStringField('evFreezeEvalFlag','');
         gen.writeStringField('evProgressPayTermMonths','');
         gen.writeStringField('evEquipmentAmount','');
         gen.writeStringField('evEquipmentAmountTax','');
         gen.writeStringField('evEquipmentAmountPercent','');
         gen.writeStringField('evCostAmount','');
         gen.writeStringField('evCostAmountTax','');
         gen.writeStringField('evCostAmountPercent','');
         gen.writeStringField('evCurrencyType','');
         gen.writeStringField('evExchangeRate','');
         gen.writeStringField('evAssetCount','');
         gen.writeStringField('evProductType','');
         gen.writeStringField('evResidualMaxTermMonths','');
         gen.writeStringField('evSpecialTermMonths01','');
         gen.writeStringField('evSpecialTermMonths02','');
         gen.writeStringField('evSpecialTermMonths03','');
         gen.writeStringField('evEndorsementComment','');
        gen.writeEndObject();        
        gen.writeFieldName('evalDetail');
        gen.writeStartObject();
        gen.writeFieldName('evAssets');
        gen.writeStartObject();
        
        gen.writeFieldName('evAsset');
        gen.writeStartArray();
        gen.writeStartObject();
        
        gen.writeStringField('evAssetAssetId','');
        gen.writeStringField('evAssetRequestId','');
        gen.writeStringField('evAssetOracleFACategoryId','');
        gen.writeStringField('evAssetOracleFACategory','');
        gen.writeStringField('evAssetOracleFASubcategory','');
        gen.writeStringField('evAssetCollateralType','');
        gen.writeStringField('evAssetCollateralDescription','');
        gen.writeStringField('evAssetCollateralId','');
        gen.writeStringField('evAssetAssetModel','');
        gen.writeStringField('evAssetAssetModelYear','');
        gen.writeStringField('evAssetManufacturer','');
        gen.writeStringField('evAssetCurrencyType','');
        gen.writeStringField('evAssetExchangeRate','');
        gen.writeStringField('evAssetQuantity','');
        gen.writeStringField('evAssetUnitCost','');
        gen.writeStringField('evAssetUnitTax','');
        gen.writeStringField('evAssetFreightCost','');
        gen.writeStringField('evAssetParkingCost','');
        gen.writeStringField('evAssetInstallationCost','');
        gen.writeStringField('evAssetTrainingCost','');
        gen.writeStringField('evAssetWarrantyCost','');
        gen.writeStringField('evAssetSoftwareCost','');
        gen.writeStringField('evAssetConditionType','');
        gen.writeStringField('evAssetTotalCost','');
        gen.writeStringField('evAssetPhysicalCatType','');
        gen.writeStringField('evAssetInsuranceType','');
        gen.writeStringField('evAssetMultLocationFlag','');
        gen.writeStringField('evAssetRapidTagFlag','');
        gen.writeStringField('evAssetImportFlag','');
        
        gen.writeFieldName('evAssetValuations');
        gen.writeStartObject();
        
        gen.writeFieldName('evValuation');
        gen.writeStartArray();
        gen.writeStartObject();
        
        gen.writeStringField('evValValuationId','');
        gen.writeStringField('evValAssetId','');
        gen.writeStringField('evValRequestId','');
        gen.writeStringField('evValTermMonths','');
        gen.writeStringField('evValFmvAmount','');
        gen.writeStringField('evValFmvPercent','');
        gen.writeStringField('evValNrvAmount','');
        gen.writeStringField('evValNrvPercent','');
        gen.writeStringField('evValOlvAmount','');
        gen.writeStringField('evValOlvPercent','');
        gen.writeStringField('evValRvAmount','');
        gen.writeStringField('evValRvPercent','');
        gen.writeStringField('evValInsurancePrima','');
        gen.writeStringField('evValActiveFlag','');
        gen.writeStringField('evValCreatedBy','');
        gen.writeStringField('evValNameCreatedBy','');
        gen.writeStringField('evValCreationDate','');
        gen.writeStringField('evValLastUpdatedBy','');
        gen.writeStringField('evValNameUpdatedBy','');
        gen.writeStringField('evValLastUpdateDate','');
        
        gen.writeEndObject();
        gen.writeEndArray();
        
        gen.writeEndObject();
        
        gen.writeFieldName('evAssetEndorsements');
        gen.writeStartObject();
        
        gen.writeFieldName('evEndorsement');
        gen.writeStartArray();
        gen.writeStartObject();
        
        gen.writeStringField('evEndEndorsementId','');
        gen.writeStringField('evEndAssetId','');
        gen.writeStringField('evEndRequestId','');
        gen.writeStringField('evEndAttributeType','');
        gen.writeStringField('evEndValueType','');
        gen.writeStringField('evEndUomType','');
        gen.writeStringField('evEndValueOther','');
        gen.writeStringField('evEndComment','');
        gen.writeStringField('evEndActiveFlag','');
        gen.writeStringField('evEndCreatedBy','');
        gen.writeStringField('evEndNameCreatedBy','');
        gen.writeStringField('evEndCreationDate','');
        gen.writeStringField('evEndLastUpdatedBy','');
        gen.writeStringField('evEndNameUpdatedBy','');
        gen.writeStringField('evEndLastUpdateDate','');
        
        gen.writeEndObject();
        gen.writeEndArray();
        
        gen.writeEndObject();
        
        gen.writeStringField('evAssetActiveFlag','');
        gen.writeStringField('evAssetCreatedBy','');
        gen.writeStringField('evAssetNameCreatedBy','');
        gen.writeStringField('evAssetCreationDate','');
        gen.writeStringField('evLastUpdatedBy','');
        gen.writeStringField('evAssetNameUpdatedBy','');
        gen.writeStringField('evAssetLastUpdateDate','');
        
        gen.writeEndObject();
        gen.writeEndArray();
        
        gen.writeEndObject();
        gen.writeEndObject();
        
        gen.writeEndObject();
        gen.writeEndObject();

        
        gen.writeFieldName('entityDocument');
        gen.writeStartObject();
        gen.writeStringField('entityDocDummy' , '');
        gen.writeEndObject();
        
        gen.writeFieldName('entityComment');
        gen.writeStartObject();
        gen.writeStringField('entityComDummy' , '');
        gen.writeEndObject();
        
        gen.writeFieldName('comments');
        gen.writeStartObject();
        gen.writeFieldName('comment');
        gen.writeStartArray();
        gen.writeStartObject();
        gen.writeStringField('comId' ,  '');
        gen.writeStringField('comSection' , '');
        gen.writeStringField('comComment' ,  '');
        gen.writeStringField('comCreatedBy' ,  '');
        gen.writeStringField('comCreationDate' ,  '');
        gen.writeStringField('comUpdatedBy' ,  '');
        gen.writeStringField('comLastUpdateDate' ,  '');
        gen.writeEndObject(); 
        gen.writeStartObject();
        gen.writeStringField('comId' ,  '');
        gen.writeStringField('comSection' , '');
        gen.writeStringField('comComment' , '');
        gen.writeStringField('comCreatedBy' , '');
        gen.writeStringField('comCreationDate' , '');
        gen.writeStringField('comUpdatedBy' ,  '');
        gen.writeStringField('comLastUpdateDate' ,  '');
        gen.writeEndObject();
        gen.writeStartObject();
        gen.writeStringField('comId' ,  '');
        gen.writeStringField('comSection' , '');
        gen.writeStringField('comComment' ,  '');
        gen.writeStringField('comCreatedBy' ,  '');
        gen.writeStringField('comCreationDate' ,  '');
        gen.writeStringField('comUpdatedBy' ,  '');
        gen.writeStringField('comLastUpdateDate' ,  '');
        gen.writeEndObject();
        gen.writeEndArray();
        gen.writeEndObject();
        
        gen.writeFieldName('documents');
        gen.writeStartObject();
        gen.writeFieldName('document');
        gen.writeStartArray();
        gen.writeStartObject();
        gen.writeStringField('docId' ,  '');
        gen.writeStringField('docType' ,  '');
        gen.writeStringField('docName' ,  '');
        gen.writeStringField('docStatus' ,  '');
        gen.writeStringField('docURL' ,  '');
        gen.writeStringField('docStartDate' , '');
        gen.writeStringField('docEndDate' ,  '');
        gen.writeStringField('createdBy' ,  '');
        gen.writeStringField('creationDate' ,  '');
        gen.writeEndObject(); 
        
        gen.writeStartObject();
        gen.writeStringField('docId' , '');
        gen.writeStringField('docType' ,  '');
        gen.writeStringField('docName' , '');
        gen.writeStringField('docStatus' ,  '');
        gen.writeStringField('docURL' ,  '');
        gen.writeStringField('docStartDate' , '');
        gen.writeStringField('docEndDate' ,  '');
        gen.writeStringField('createdBy' ,  '');
        gen.writeStringField('creationDate' ,  '');
        gen.writeEndObject(); 
        
        gen.writeStartObject();
        gen.writeStringField('docId' , '');
        gen.writeStringField('docType' ,  '');
        gen.writeStringField('docName' , '');
        gen.writeStringField('docStatus' ,  '');
        gen.writeStringField('docURL' ,  '');
        gen.writeStringField('docStartDate' , '');
        gen.writeStringField('docEndDate' ,  '');
        gen.writeStringField('createdBy' ,  '');
        gen.writeStringField('creationDate' ,  '');
        gen.writeEndObject(); 
        gen.writeEndArray();
        gen.writeEndObject();
        
        gen.writeFieldName('audits');
        gen.writeStartObject();
        gen.writeFieldName('audit');
        gen.writeStartArray();
        gen.writeStartObject();
        gen.writeStringField('auditUpdatedBy' ,  '');
        gen.writeStringField('auditLastUpdateDate' ,  '');
        gen.writeStringField('auditField' ,  '');
        gen.writeStringField('auditLastValue' ,  '');
        gen.writeStringField('auditNewValue' ,  '');
        gen.writeStringField('auditComment' , '');
        gen.writeEndObject(); 
        
        gen.writeStartObject();
        gen.writeStringField('auditUpdatedBy' ,  '');
        gen.writeStringField('auditLastUpdateDate' ,  '');
        gen.writeStringField('auditField' ,  '');
        gen.writeStringField('auditLastValue' ,  '');
        gen.writeStringField('auditNewValue' ,  '');
        gen.writeStringField('auditComment' , '');
        gen.writeEndObject(); 
        
        gen.writeStartObject();
        gen.writeStringField('auditUpdatedBy' ,  '');
        gen.writeStringField('auditLastUpdateDate' ,  '');
        gen.writeStringField('auditField' ,  '');
        gen.writeStringField('auditLastValue' ,  '');
        gen.writeStringField('auditNewValue' ,  '');
        gen.writeStringField('auditComment' , '');
        gen.writeEndObject(); 
        gen.writeEndArray();
        gen.writeEndObject();
        
        gen.writeEndObject();
        gen.writeEndArray();
        gen.writeEndObject(); 
        
        gen.writeFieldName('status');
        gen.writeStartObject();
        gen.writeStringField('code' , '');
        gen.writeStringField('message' , '');
        gen.writeStringField('detail' , '');
        gen.writeEndObject();
        
        gen.writeEndObject();
        String jsonS = gen.getAsString(); 
        return jsonS;
    }
    
    public static String entitymasterToJsonTes(string requestType )
    {
        JSONGenerator gen = JSON.createGenerator(true);    
        gen.writeStartObject();
        gen.writeFieldName('requests');
        gen.writeStartObject();
        gen.writeFieldName('request');
        gen.writeStartArray();
        gen.writeStartObject();
        gen.writeFieldName('header');
        gen.writeStartObject();
        gen.writeStringField('requestId' , '1111');
        gen.writeStringField('rootRequestId' , '1111');
        gen.writeStringField('requestType' , requestType);
        gen.writeStringField('ndaType' , 'AAAAA');
        gen.writeStringField('applicationId' , 'DUPLICADO CON REQUEST TYPE');
        gen.writeStringField('sourceAccountId' , 'AAAAA');
        gen.writeStringField('sourceTopParentId' , 'AAAAA');
        gen.writeStringField('partyId' , '1111');
        gen.writeStringField('partyName' , 'AAAAA');
        gen.writeStringField('egPartyId' , '1111');
        gen.writeStringField('egPartyName' , 'AAAAA');
        gen.writeStringField('sourceOpId' , 'AAAAA');
        gen.writeStringField('sourceCAId' , 'AAAAA');
        gen.writeStringField('startDate' , 'AAAAA');
        gen.writeStringField('endDate' , 'AAAAA');
        gen.writeStringField('requestStatus' , 'AAAAA');
        gen.writeStringField('createdBy' , 'AAAAA');
        gen.writeStringField('requestedBy' , 'AAAAA');
        gen.writeStringField('assignedGroup' , 'AAAAA');
        gen.writeStringField('assignedTo' , 'AAAAA');
        gen.writeStringField('assignedDate' , 'AAAAA');
        gen.writeStringField('activeFlag' , 'AAAAA');
        gen.writeStringField('creationDate' , 'AAAAA');
        gen.writeStringField('updatedBy' , 'AAAAA');
        gen.writeStringField('lastUpdateDate' , 'AAAAA');
        gen.writeStringField('solvedBy' , 'AAAAA');
        gen.writeStringField('solvedDate' , 'AAAAA');
        gen.writeStringField('finantialEntity' , 'AAAAA');
        
        gen.writeFieldName('docTypes');
        gen.writeStartObject();
        gen.writeFieldName('docType');
        gen.writeStartArray();
        
        gen.writeStartObject();
        gen.writeStringField('docTypeId' , '1111');
        gen.writeStringField('docSection' , 'AAAAA');
        gen.writeStringField('docTypeName' , 'TIPO 1');
        gen.writeStringField('docTypeReqFlag' , 'AAAAA');
        gen.writeEndObject(); 
        
        gen.writeStartObject();
        gen.writeStringField('docTypeId' , '22222');
        gen.writeStringField('docSection' , 'AAAAA');
        gen.writeStringField('docTypeName' , 'TIPO 2');
        gen.writeStringField('docTypeReqFlag' , 'AAAAA');
        gen.writeEndObject();
        
        gen.writeEndArray();
        gen.writeEndObject();
        
        gen.writeEndObject();
        
        gen.writeFieldName('privileges');
        gen.writeStartObject();
        gen.writeFieldName('privilege');
        gen.writeStartArray();
        
        gen.writeStartObject();
        gen.writeStringField('sso' , 'AAAAA');
        gen.writeStringField('applicationName' , 'AAAAA');
        gen.writeStringField('applicationCode' , 'AAAAA');
        gen.writeStringField('screen' , 'AAAAA');
        gen.writeStringField('section' , 'PENDING');
        gen.writeStringField('employeeName' , 'AAAAA');
        gen.writeStringField('vCrud' , '10000');
        gen.writeEndObject();
        
        gen.writeStartObject();
        gen.writeStringField('sso' , 'AAAAA');
        gen.writeStringField('applicationName' , 'AAAAA');
        gen.writeStringField('applicationCode' , 'AAAAA');
        gen.writeStringField('screen' , 'AAAAA');
        gen.writeStringField('section' , 'IN PROCESS');
        gen.writeStringField('employeeName' , 'AAAAA');
        gen.writeStringField('vCrud' , '00000');
        gen.writeEndObject();
        
        gen.writeStartObject();
        gen.writeStringField('sso' , 'AAAAA');
        gen.writeStringField('applicationName' , 'AAAAA');
        gen.writeStringField('applicationCode' , 'AAAAA');
        gen.writeStringField('screen' , 'AAAAA');
        gen.writeStringField('section' , 'IN_PROCESS');
        gen.writeStringField('employeeName' , 'AAAAA');
        gen.writeStringField('vCrud' , '10000');
        gen.writeEndObject();
        
        gen.writeStartObject();
        gen.writeStringField('sso' , 'AAAAA');
        gen.writeStringField('applicationName' , 'AAAAA');
        gen.writeStringField('applicationCode' , 'AAAAA');
        gen.writeStringField('screen' , 'AAAAA');
        gen.writeStringField('section' , 'ON HOLD');
        gen.writeStringField('employeeName' , 'AAAAA');
        gen.writeStringField('vCrud' , '00000');
        gen.writeEndObject();
        
        gen.writeStartObject();
        gen.writeStringField('sso' , 'AAAAA');
        gen.writeStringField('applicationName' , 'AAAAA');
        gen.writeStringField('applicationCode' , 'AAAAA');
        gen.writeStringField('screen' , 'AAAAA');
        gen.writeStringField('section' , 'REWORK');
        gen.writeStringField('employeeName' , 'AAAAA');
        gen.writeStringField('vCrud' , '10000');
        gen.writeEndObject();
        
        gen.writeStartObject();
        gen.writeStringField('sso' , 'AAAAA');
        gen.writeStringField('applicationName' , 'AAAAA');
        gen.writeStringField('applicationCode' , 'AAAAA');
        gen.writeStringField('screen' , 'AAAAA');
        gen.writeStringField('section' , 'REJECTED');
        gen.writeStringField('employeeName' , 'AAAAA');
        gen.writeStringField('vCrud' , '00000');
        gen.writeEndObject();
        
        gen.writeStartObject();
        gen.writeStringField('sso' , 'AAAAA');
        gen.writeStringField('applicationName' , 'AAAAA');
        gen.writeStringField('applicationCode' , 'AAAAA');
        gen.writeStringField('screen' , 'AAAAA');
        gen.writeStringField('section' , 'PRE APPROVED');
        gen.writeStringField('employeeName' , 'AAAAA');
        gen.writeStringField('vCrud' , '10000');
        gen.writeEndObject();
        
        gen.writeStartObject();
        gen.writeStringField('sso' , 'AAAAA');
        gen.writeStringField('applicationName' , 'AAAAA');
        gen.writeStringField('applicationCode' , 'AAAAA');
        gen.writeStringField('screen' , 'AAAAA');
        gen.writeStringField('section' , 'APPROVED');
        gen.writeStringField('employeeName' , 'AAAAA');
        gen.writeStringField('vCrud' , '00000');
        gen.writeEndObject();
        
        gen.writeStartObject();
        gen.writeStringField('sso' , 'AAAAA');
        gen.writeStringField('applicationName' , 'AAAAA');
        gen.writeStringField('applicationCode' , 'AAAAA');
        gen.writeStringField('screen' , 'AAAAA');
        gen.writeStringField('section' , 'AUTO APPROVED');
        gen.writeStringField('employeeName' , 'AAAAA');
        gen.writeStringField('vCrud' , '10000');
        gen.writeEndObject();
        
        gen.writeStartObject();
        gen.writeStringField('sso' , 'AAAAA');
        gen.writeStringField('applicationName' , 'AAAAA');
        gen.writeStringField('applicationCode' , 'AAAAA');
        gen.writeStringField('screen' , 'AAAAA');
        gen.writeStringField('section' , 'CANCELLED BY REQUESTOR');
        gen.writeStringField('employeeName' , 'AAAAA');
        gen.writeStringField('vCrud' , '00000');
        gen.writeEndObject();
        
        gen.writeStartObject();
        gen.writeStringField('sso' , 'AAAAA');
        gen.writeStringField('applicationName' , 'AAAAA');
        gen.writeStringField('applicationCode' , 'AAAAA');
        gen.writeStringField('screen' , 'AAAAA');
        gen.writeStringField('section' , 'WAITING FOR CUSTOMER');
        gen.writeStringField('employeeName' , 'AAAAA');
        gen.writeStringField('vCrud' , '10000');
        gen.writeEndObject();
        
        gen.writeStartObject();
        gen.writeStringField('sso' , 'AAAAA');
        gen.writeStringField('applicationName' , 'AAAAA');
        gen.writeStringField('applicationCode' , 'AAAAA');
        gen.writeStringField('screen' , 'AAAAA');
        gen.writeStringField('section' , 'EDIT');
        gen.writeStringField('employeeName' , 'AAAAA');
        gen.writeStringField('vCrud' , '00000');
        gen.writeEndObject();
        
        gen.writeStartObject();
        gen.writeStringField('sso' , 'AAAAA');
        gen.writeStringField('applicationName' , 'AAAAA');
        gen.writeStringField('applicationCode' , 'AAAAA');
        gen.writeStringField('screen' , 'AAAAA');
        gen.writeStringField('section' , 'NEW DOCUMENT');
        gen.writeStringField('employeeName' , 'AAAAA');
        gen.writeStringField('vCrud' , '10000');
        gen.writeEndObject();
        
        gen.writeStartObject();
        gen.writeStringField('sso' , 'AAAAA');
        gen.writeStringField('applicationName' , 'AAAAA');
        gen.writeStringField('applicationCode' , 'AAAAA');
        gen.writeStringField('screen' , 'AAAAA');
        gen.writeStringField('section' , 'NEW COMMENT');
        gen.writeStringField('employeeName' , 'AAAAA');
        gen.writeStringField('vCrud' , '00000');
        gen.writeEndObject();
        
        gen.writeEndArray();
        gen.writeEndObject();
        
        gen.writeFieldName('amlCRR');
        gen.writeStartObject();
        gen.writeStringField('crr' , 'AAAAA');
        gen.writeStringField('crrModificationDate' , 'AAAAA');
        gen.writeStringField('crrExpirationDate' , 'AAAAA');
        gen.writeStringField('crrOverride' , 'AAAAA');
        gen.writeStringField('crrSourceType' , 'AAAAA');
        gen.writeStringField('crrComments' , 'AAAAA');
        gen.writeEndObject();
        
        gen.writeFieldName('amlHit');
        gen.writeStartObject();
        gen.writeStringField('hitRFC' , 'AAAAA');
        gen.writeStringField('hitEntityName' , 'AAAAA');
        gen.writeStringField('hitExpirationDate' , 'AAAAA');
        gen.writeStringField('hitFlag' , 'AAAAA');
        gen.writeStringField('hitUwStatus' , 'AAAAA');
        gen.writeStringField('hitUwComments' , 'AAAAA');
        gen.writeStringField('hitAMLStatus' , 'AAAAA');
        gen.writeStringField('hitAMLComments' , 'AAAAA');
        gen.writeStringField('hitAMLMaxPercent' , 'AAAAA');
        gen.writeFieldName('hits');
        gen.writeStartObject();
        gen.writeFieldName('hit');
        gen.writeStartArray();
        
        gen.writeStartObject();
        gen.writeStringField('hitSource' , 'AAAAA');
        gen.writeStringField('hitDescription' , 'HIT 1');
        gen.writeStringField('hitPercent' , 'AAAAA');
        gen.writeEndObject(); 
        
        gen.writeStartObject();
        gen.writeStringField('hitSource' , 'AAAAA');
        gen.writeStringField('hitDescription' , 'HIT 2');
        gen.writeStringField('hitPercent' , 'AAAAA');
        gen.writeEndObject(); 
        gen.writeEndArray();
        gen.writeEndObject();
        gen.writeEndObject();
        
        gen.writeFieldName('creditBureau');
        gen.writeStartObject();
        gen.writeStringField('cbPartySiteID' , '1111');
        gen.writeStringField('cbLegalPartyId' , '1111');
        gen.writeStringField('cbLegalPartyAlias' , 'AAAAA');
        gen.writeStringField('cbRejectReason' , 'AAAAA');
        gen.writeStringField('cbLetterFlag' , 'AAAAA');
        gen.writeStringField('rfc' , 'AAAAA');
        gen.writeStringField('cbCustomerType' , 'Individual');
        gen.writeStringField('cbName' , 'AAAAA');
        gen.writeStringField('cbSecondName' , 'AAAAA');
        gen.writeStringField('cbLastName' , 'AAAAA');
        gen.writeStringField('cbSecondLastName' , 'AAAAA');
        gen.writeStringField('cbAPIRequestor' , 'AAAAA');
        gen.writeStringField('companyName' , 'AAAAA');
        gen.writeStringField('address' , 'AAAAA');
        gen.writeStringField('ecEntity' , 'AAAAA');
        gen.writeStringField('letterSigningDate' , 'AAAAA');
        gen.writeStringField('letterSigningPlace' , 'AAAAA');
        gen.writeStringField('alias' , 'AAAAA');
        gen.writeStringField('street' , 'AAAAA');
        gen.writeStringField('CBIntNum' , 'AAAAA');
        gen.writeStringField('CBOutNum' , 'AAAAA');
        gen.writeStringField('CBMunicipality' , 'AAAAA');
        gen.writeStringField('suburb' , 'AAAAA');
        gen.writeStringField('zipCode' , 'AAAAA');
        gen.writeStringField('city' , 'AAAAA');
        gen.writeStringField('state' , 'AAAAA');
        gen.writeStringField('country' , 'AAAAA');
        gen.writeStringField('autorizationLetter' , 'AAAAA');
        gen.writeEndObject();
        
        gen.writeFieldName('creditApproval');
        gen.writeStartObject();
        gen.writeFieldName('parties');
        gen.writeStartObject();
        gen.writeFieldName('party');
        gen.writeStartArray();
        gen.writeStartObject();
        gen.writeStringField('oppPartyId' , '11111');
        gen.writeStringField('oppPartyName' , 'PARTY 1');
        gen.writeStringField('oppPartyObligorFlag' , 'TRUE');
        gen.writeStringField('oppPartyGuarantorFlag' , 'TRUE');
        gen.writeStringField('oppPartyBOFlag' , 'TRUE');
        gen.writeStringField('oppPartyRDEFlag' , 'TRUE');
        gen.writeEndObject(); 
        
        gen.writeStartObject();
        gen.writeStringField('oppPartyId' , '22222');
        gen.writeStringField('oppPartyName' , 'PARTY 2');
        gen.writeStringField('oppPartyObligorFlag' , 'FALSE');
        gen.writeStringField('oppPartyGuarantorFlag' , 'FALSE');
        gen.writeStringField('oppPartyBOFlag' , 'TRUE');
        gen.writeStringField('oppPartyRDEFlag' , 'TRUE');
        gen.writeEndObject(); 
        gen.writeEndArray();
        gen.writeEndObject();
        gen.writeEndObject(); 
        
        
        gen.writeFieldName('kycInd');
        gen.writeStartObject();
        gen.writeStringField('kycIndName' , 'AAAAA');
        
        gen.writeFieldName('datosGenerales');
        gen.writeStartObject();
        gen.writeStringField('kycIndGDBirthDate', '1990-10-10');
        gen.writeStringField('kycIndGDRFC' , 'AAAAA');
        gen.writeStringField('kycIndGDCURP' , 'AAAAA');
        gen.writeStringField('kycIndGDNacionalities' , 'AAAAA');
        gen.writeStringField('kycIndGDFEASerialNo' , 'AAAAA');
        gen.writeStringField('kycIndGDBirthCountry' , 'AAAAA');
        gen.writeStringField('kycIndGDBirthState' , 'AAAAA');
        gen.writeStringField('kycIndGDSex' , 'AAAAA');
        gen.writeStringField('kycIndGDMarriageStatus' , 'AAAAA');
        gen.writeStringField('kycIndGDMarriageRegime' , 'AAAAA');
        gen.writeStringField('kycIndGDNameOfSpouse' , 'AAAAA');
        gen.writeEndObject();
        
        gen.writeFieldName('domicilioParticular');
        gen.writeStartObject();
        gen.writeStringField('kycIndAdrStreet' , 'AAAAA');
        gen.writeStringField('kycIndAdrOutNum' , 'AAAAA');
        gen.writeStringField('kycIndAdrIntNum' , 'AAAAA');
        gen.writeStringField('kycIndAdrCounty' , 'AAAAA');
        gen.writeStringField('kycIndAdrMunicipality' , 'AAAAA');
        gen.writeStringField('kycIndAdrCity' , 'AAAAA');
        gen.writeStringField('kycIndAdrState' , 'AAAAA');
        gen.writeStringField('kycIndAdrCountry' , 'AAAAA');
        gen.writeStringField('kycIndIntAdrZipCode' , 'AAAAA');
        gen.writeEndObject();
        
        gen.writeFieldName('datosGralesEmpleo');
        gen.writeStartObject();
        gen.writeStringField('kycIndBizTitle' , 'AAAAA');
        gen.writeStringField('kycIndBizRelatedPaties' , 'AAAAA');
        gen.writeEndObject();
        
        gen.writeFieldName('ppe');
        gen.writeStartObject();
        gen.writeStringField('kycIndPPEFlag' , 'AAAAA');
        gen.writeStringField('kycIndPPEJob' , 'AAAAA');
        gen.writeStringField('kycIndPPEAFlag' , 'AAAAA');
        gen.writeStringField('kycIndPPEAName' , 'AAAAA');
        gen.writeStringField('kycIndPPEARelationship' , 'AAAAA');
        gen.writeEndObject();
        
        gen.writeFieldName('tablaProveedorRecursos');
        gen.writeStartObject();
        gen.writeFieldName('proveedorRecurso');
        gen.writeStartArray();
        gen.writeStartObject();
        gen.writeStringField('kycIndResLegalName' , 'AAAAA');
        gen.writeStringField('kycIndResCountry' , 'AAAAA');
        gen.writeStringField('kycIndResRFC' , 'AAAAA');
        gen.writeStringField('kycIndResAddress' , 'AAAAA');
        gen.writeStringField('kycIndResFEASerialNo' , 'AAAAA');
        gen.writeEndObject(); 
        gen.writeEndArray();
        gen.writeEndObject();
        
        gen.writeFieldName('suscritoPor');
        gen.writeStartObject();
        gen.writeStringField('kycIndSignName' , 'AAAAA');
        gen.writeStringField('kycIndSignFlag' , 'AAAAA');
        gen.writeStringField('kycIndSignPowerFlag' , 'AAAAA');
        gen.writeStringField('kycIndSignPublicDeedNum' , 'AAAAA');
        gen.writeStringField('kycIndSignPublicDeedDate' , 'AAAAA');
        gen.writeStringField('kycIndSignNotaryName' , 'AAAAA');
        gen.writeStringField('kycIndSignNotaryNum' , 'AAAAA');
        gen.writeStringField('kycIndSignNotaryState' , 'AAAAA');
        gen.writeStringField('kycIndSignDateDay' , 'AAAAA');
        gen.writeStringField('kycIndSignDateMonth' , 'AAAAA');
        gen.writeStringField('kycIndSignDateYear' , 'AAAAA');
        gen.writeEndObject();
        
        gen.writeEndObject();
        
        gen.writeFieldName('kycOrg');
        gen.writeStartObject();
        gen.writeStringField('kycOrgName' , 'AAAAA');
        
        gen.writeFieldName('datosGenerales');
        gen.writeStartObject();
        gen.writeStringField('kycOrgGDRFC' , 'AAAAA');
        gen.writeStringField('kycOrgGDBirthDate' , 'AAAAA');
        gen.writeStringField('kycOrgGDNacionality' , 'AAAAA');
        gen.writeStringField('kycOrgGDFEASerialNo' , 'AAAAA');
        gen.writeStringField('kycOrgGDPhone' , 'AAAAA');
        gen.writeStringField('kycOrgGDEmail' , 'AAAAA');
        gen.writeStringField('kycOrgGDActivity' , 'AAAAA');
        gen.writeEndObject();
        
        gen.writeFieldName('domicilioParticular');
        gen.writeStartObject();
        gen.writeStringField('kycOrgAdrStreet' , 'AAAAA');
        gen.writeStringField('kycOrgAdrOutNum' , 'AAAAA');
        gen.writeStringField('kycOrgAdrIntNum' , 'AAAAA');
        gen.writeStringField('kycOrgAdrCounty' , 'AAAAA');
        gen.writeStringField('kycOrgAdrMunicipality' , 'AAAAA');
        gen.writeStringField('kycOrgAdrCity' , 'AAAAA');
        gen.writeStringField('kycOrgAdrState' , 'AAAAA');
        gen.writeStringField('kycOrgIntAdrCountry' , 'AAAAA');
        gen.writeStringField('kycOrgIntAdrZipCode' , 'AAAAA');
        gen.writeEndObject();
        
        gen.writeFieldName('actividadEconomica');
        gen.writeStartObject();
        gen.writeStringField('kycOrgActGovFlag' , 'AAAAA');
        gen.writeStringField('kycOrgActGovPartyName' , 'AAAAA');
        gen.writeStringField('kycOrgActGovAnnualIncome' , 'AAAAA');
        gen.writeStringField('kycOrgActGovServices' , 'AAAAA');
        gen.writeStringField('kycOrgActGovAge' , 'AAAAA');
        gen.writeEndObject();
        
        gen.writeStringField('kycOrgFinanceUse' , 'AAAAA');
        
        gen.writeFieldName('mercadoGeografico');
        gen.writeStartObject();
        gen.writeStringField('kycOrgCorpSites' , 'AAAAA');
        gen.writeStringField('kycOrgMktSites' , 'AAAAA');
        gen.writeEndObject();
        
        gen.writeFieldName('tablaCuentasBancarias');
        gen.writeStartObject();
        gen.writeFieldName('cuentaBancaria');
        gen.writeStartArray();
        gen.writeStartObject();
        gen.writeStringField('kycOrgBankName' , 'AAAAA');
        gen.writeStringField('kycOrgBankAccount' , 'AAAAA');
        gen.writeStringField('kycOrgBankCountry' , 'AAAAA');
        gen.writeEndObject(); 
        gen.writeEndArray();
        gen.writeEndObject();
        
        gen.writeStringField('kycOrgBankPayeeName' , 'AAAAA');
        
        gen.writeFieldName('ppe');
        gen.writeStartObject();
        gen.writeStringField('kycOrgPPEFlag' , 'AAAAA');
        gen.writeStringField('kycOrgPPEJob' , 'AAAAA');
        gen.writeStringField('kycOrgPPEName' , 'AAAAA');
        gen.writeStringField('kycOrgPPEAName' , 'AAAAA');
        gen.writeStringField('kycOrgPPEARelationship' , 'AAAAA');
        gen.writeStringField('kycOrgPPEABoardJob' , 'AAAAA');
        gen.writeStringField('kycOrgPPEABoardName' , 'AAAAA');
        gen.writeStringField('kycOrgPPEAName2' , 'AAAAA');
        gen.writeStringField('kycOrgPPEARelationship2' , 'AAAAA');
        gen.writeEndObject();
        
        gen.writeFieldName('tablaProveedoresRecursos');
        gen.writeStartObject();
        gen.writeFieldName('proveedorRecurso');
        gen.writeStartArray();
        gen.writeStartObject();
        gen.writeStringField('kycOrgResLegalName' , 'AAAAA');
        gen.writeStringField('kycOrgResCountry' , 'AAAAA');
        gen.writeStringField('kycOrgResRFC' , 'AAAAA');
        gen.writeStringField('kycOrgResAddress' , 'AAAAA');
        gen.writeStringField('kycOrgResFEASerialNo' , 'AAAAA');
        gen.writeEndObject(); 
        gen.writeEndArray();
        gen.writeEndObject();
        
        gen.writeFieldName('tablaComposicionCapSocial');
        gen.writeStartObject();
        gen.writeFieldName('capitalSocial');
        gen.writeStartArray();
        gen.writeStartObject();
        gen.writeStringField('kycOrgPartnerLegalName' , 'AAAAA');
        gen.writeStringField('kycOrgPartnerCountry' , 'AAAAA');
        gen.writeStringField('kycOrgPartnerRFC' , 'AAAAA');
        gen.writeStringField('kycOrgPartnerPorcent' , 'AAAAA');
        gen.writeEndObject(); 
        gen.writeEndArray();
        gen.writeEndObject();
        
        gen.writeStringField('kycOrgPartnerOrgName' , 'AAAAA');
        
        gen.writeFieldName('tablaAccSociosPM');
        gen.writeStartObject();
        gen.writeFieldName('accionistasPM');
        gen.writeStartArray();
        gen.writeStartObject();
        gen.writeStringField('kycOrgPartnerOrgLegalName' , 'AAAAA');
        gen.writeStringField('kycOrgPartnerOrgCountry' , 'AAAAA');
        gen.writeStringField('kycOrgPartnerOrgRFC' , 'AAAAA');
        gen.writeStringField('kycOrgPartnerOrgPorcent' , 'AAAAA');
        gen.writeEndObject(); 
        gen.writeEndArray();
        gen.writeEndObject();
        
        gen.writeStringField('kycOrgTrustOrgName' , 'AAAAA');
        
        gen.writeFieldName('tablaAccSociosFideicomisos');
        gen.writeStartObject();
        gen.writeFieldName('accionistaFideicomiso');
        gen.writeStartArray();
        gen.writeStartObject();
        gen.writeStringField('kycOrgTrustLegalName' , 'AAAAA');
        gen.writeStringField('kycOrgTrustCountry' , 'AAAAA');
        gen.writeStringField('kycOrgTrustRFC' , 'AAAAA');
        gen.writeStringField('kycOrgTrustPersons' , 'AAAAA');
        gen.writeEndObject(); 
        gen.writeEndArray();
        gen.writeEndObject();
        
        gen.writeFieldName('tablaAccSociosPF');
        gen.writeStartObject();
        gen.writeFieldName('accionistaPF');
        gen.writeStartArray();
        gen.writeStartObject();
        gen.writeStringField('kycOrgPartnerIndLegalName' , 'AAAAA');
        gen.writeStringField('kycOrgPartnerIndCountry' , 'AAAAA');
        gen.writeStringField('kycOrgPartnerIndRFC' , 'AAAAA');
        gen.writeStringField('kycOrgPartnerIndPorcent' , 'AAAAA');
        gen.writeEndObject(); 
        gen.writeEndArray();
        gen.writeEndObject();
        
        gen.writeStringField('kycOrgBizManagedBy' , 'AAAAA');
        
        gen.writeFieldName('tablaSocAdminPor');
        gen.writeStartObject();
        gen.writeFieldName('administradoPor');
        gen.writeStartArray();
        gen.writeStartObject();
        gen.writeStringField('kycOrgBizManagerName' , 'AAAAA');
        gen.writeStringField('kycOrgBizManagerTitle' , 'AAAAA');
        gen.writeStringField('kycOrgBizManagerRFC' , 'AAAAA');
        gen.writeEndObject(); 
        gen.writeEndArray();
        gen.writeEndObject();
        
        gen.writeFieldName('tablaFuncionariosPrincipales');
        gen.writeStartObject();
        gen.writeFieldName('funcionarioPrincipal');
        gen.writeStartArray();
        gen.writeStartObject();
        gen.writeStringField('kycOrgBizMainName' , 'AAAAA');
        gen.writeStringField('kycOrgBizMainTitle' , 'AAAAA');
        gen.writeStringField('kycOrgBizMainRFC' , 'AAAAA');
        gen.writeEndObject(); 
        gen.writeEndArray();
        gen.writeEndObject();
        
        gen.writeStringField('kycOrgCorpName' , 'AAAAA');
        
        gen.writeFieldName('tablaGrupoEmpresarial');
        gen.writeStartObject();
        gen.writeFieldName('grupoEmpresarial');
        gen.writeStartArray();
        gen.writeStartObject();
        gen.writeStringField('kycOrgCorpLegalName' , 'AAAAA');
        gen.writeStringField('kycOrgCorpCountry' , 'AAAAA');
        gen.writeStringField('kycOrgCorpAddress' , 'AAAAA');
        gen.writeStringField('kycOrgCorpObjective' , 'AAAAA');
        gen.writeStringField('kycOrgCorpPercent' , 'AAAAA');
        gen.writeEndObject(); 
        gen.writeEndArray();
        gen.writeEndObject();
        
        gen.writeFieldName('certificacionRepresentanteLegal');
        gen.writeStartObject();
        gen.writeStringField('kycOrgSignName' , 'AAAAA');
        gen.writeStringField('kycOrgSignJob' , 'AAAAA');
        gen.writeStringField('kycOrgSignPublicDeedNum' , 'AAAAA');
        gen.writeStringField('kycOrgSignPublicDeedDate' , 'AAAAA');
        gen.writeStringField('kycOrgSignNotaryName' , 'AAAAA');
        gen.writeStringField('kycOrgSignNotaryNum' , 'AAAAA');
        gen.writeStringField('kycOrgSignNotaryState' , 'AAAAA');
        gen.writeStringField('kycOrgSignDateDay' , 'AAAAA');
        gen.writeStringField('kycOrgSignDateMonth' , 'AAAAA');
        gen.writeStringField('kycOrgSignDateYear' , 'AAAAA');
        gen.writeEndObject();
        
        gen.writeEndObject();
        
        gen.writeFieldName('entityDocument');
        gen.writeStartObject();
        gen.writeStringField('entityDocDummy' , 'AAAA');
        gen.writeEndObject();
        
        gen.writeFieldName('entityComment');
        gen.writeStartObject();
        gen.writeStringField('entityComDummy' , 'AAAA');
        gen.writeEndObject();
        
        gen.writeFieldName('comments');
        gen.writeStartObject();
        gen.writeFieldName('comment');
        gen.writeStartArray();
        gen.writeStartObject();
        gen.writeStringField('comId' , '1111');
        gen.writeStringField('comSection' , 'AML');
        gen.writeStringField('comComment' , 'AAAAA');
        gen.writeStringField('comCreatedBy' , 'AAAAA');
        gen.writeStringField('comCreationDate' , 'AAAAA');
        gen.writeStringField('comUpdatedBy' , 'AAAAA');
        gen.writeStringField('comLastUpdateDate' , 'AAAAA');
        gen.writeEndObject(); 
        gen.writeStartObject();
        gen.writeStringField('comId' , '1111');
        gen.writeStringField('comSection' , 'Credit Bureau');
        gen.writeStringField('comComment' , 'BBBBB');
        gen.writeStringField('comCreatedBy' , 'BBBBB');
        gen.writeStringField('comCreationDate' , 'BBBBB');
        gen.writeStringField('comUpdatedBy' , 'AAAAA');
        gen.writeStringField('comLastUpdateDate' , 'AAAAA');
        gen.writeEndObject();
        gen.writeStartObject();
        gen.writeStringField('comId' , '1111');
        gen.writeStringField('comSection' , 'NDA');
        gen.writeStringField('comComment' , 'AAAAA');
        gen.writeStringField('comCreatedBy' , 'AAAAA');
        gen.writeStringField('comCreationDate' , 'AAAAA');
        gen.writeStringField('comUpdatedBy' , 'AAAAA');
        gen.writeStringField('comLastUpdateDate' , 'AAAAA');
        gen.writeEndObject();
        gen.writeEndArray();
        gen.writeEndObject();
        
        gen.writeFieldName('documents');
        gen.writeStartObject();
        gen.writeFieldName('document');
        gen.writeStartArray();
        gen.writeStartObject();
        gen.writeStringField('docId' , '1111');
        gen.writeStringField('docType' , 'AAAAA');
        gen.writeStringField('docName' , 'AAAAA');
        gen.writeStringField('docStatus' , 'AAAAA');
        gen.writeStringField('docURL' , 'AAAAA');
        gen.writeStringField('docStartDate' , '2018-12-31');
        gen.writeStringField('docEndDate' , 'AAAAA');
        gen.writeStringField('createdBy' , 'AAAAA');
        gen.writeStringField('creationDate' , 'AAAAA');
        gen.writeEndObject(); 
        
        gen.writeStartObject();
        gen.writeStringField('docId' , '22222');
        gen.writeStringField('docType' , 'AAAAA');
        gen.writeStringField('docName' , 'BBBBB');
        gen.writeStringField('docStatus' , 'AAAAA');
        gen.writeStringField('docURL' , 'AAAAA');
        gen.writeStringField('docStartDate' , '2018-12-31');
        gen.writeStringField('docEndDate' , 'AAAAA');
        gen.writeStringField('createdBy' , 'AAAAA');
        gen.writeStringField('creationDate' , 'AAAAA');
        gen.writeEndObject(); 
        
        gen.writeStartObject();
        gen.writeStringField('docId' , '33333');
        gen.writeStringField('docType' , 'AAAAA');
        gen.writeStringField('docName' , 'CCCCC');
        gen.writeStringField('docStatus' , 'AAAAA');
        gen.writeStringField('docURL' , 'AAAAA');
        gen.writeStringField('docStartDate' , '2018-12-31');
        gen.writeStringField('docEndDate' , 'AAAAA');
        gen.writeStringField('createdBy' , 'AAAAA');
        gen.writeStringField('creationDate' , 'AAAAA');
        gen.writeEndObject(); 
        gen.writeEndArray();
        gen.writeEndObject();
        
        gen.writeFieldName('audits');
        gen.writeStartObject();
        gen.writeFieldName('audit');
        gen.writeStartArray();
        gen.writeStartObject();
        gen.writeStringField('auditUpdatedBy' , 'AAAAA');
        gen.writeStringField('auditLastUpdateDate' , 'AAAAA');
        gen.writeStringField('auditField' , 'AAAAA');
        gen.writeStringField('auditLastValue' , 'AAAAA');
        gen.writeStringField('auditNewValue' , 'AAAAA');
        gen.writeStringField('auditComment' , 'AUDIT 1');
        gen.writeEndObject(); 
        
        gen.writeStartObject();
        gen.writeStringField('auditUpdatedBy' , 'AAAAA');
        gen.writeStringField('auditLastUpdateDate' , 'AAAAA');
        gen.writeStringField('auditField' , 'AAAAA');
        gen.writeStringField('auditLastValue' , 'AAAAA');
        gen.writeStringField('auditNewValue' , 'AAAAA');
        gen.writeStringField('auditComment' , 'AUDIT 2');
        gen.writeEndObject(); 
        
        gen.writeStartObject();
        gen.writeStringField('auditUpdatedBy' , 'AAAAA');
        gen.writeStringField('auditLastUpdateDate' , 'AAAAA');
        gen.writeStringField('auditField' , 'AAAAA');
        gen.writeStringField('auditLastValue' , 'AAAAA');
        gen.writeStringField('auditNewValue' , 'AAAAA');
        gen.writeStringField('auditComment' , 'AUDIT 3');
        gen.writeEndObject(); 
        gen.writeEndArray();
        gen.writeEndObject();
        
        gen.writeEndObject();
        gen.writeEndArray();
        gen.writeEndObject(); 
        
        gen.writeFieldName('status');
        gen.writeStartObject();
        gen.writeStringField('code' , 'AAAA');
        gen.writeStringField('message' , 'AAAA');
        gen.writeStringField('detail' , 'AAAA');
        gen.writeEndObject();
        
        gen.writeEndObject();
        String jsonS = gen.getAsString(); 
        return jsonS;
    }
    
    
    public static string jsondocs(){
        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartObject();
        gen.writeFieldName('documentsList');
        gen.writeStartObject();
        gen.writeFieldName('document');
        gen.writeStartArray();
        gen.writeStartObject();
        gen.writeStringField('requestId', '450');
        gen.writeStringField('sourceAccountName', 'sourceAccountName');
        gen.writeStringField('sourceTopParentId', '0015B00000S9r4k');
        gen.writeStringField('sourceTopParentName', 'null');
        gen.writeStringField('partyId', '77483');
        gen.writeStringField('comment', 'Documento agregado desde Salesforce request ID: 450');
        gen.writeStringField('egPartyId', '77483');
        gen.writeStringField('egPartyName', 'NARAIN HARJANI RIVADENEYRA');
        gen.writeStringField('sourceOpId', 'No Aplica dijo LALO');
        gen.writeStringField('sourceCAId', 'No Aplica dijo LALO');
        gen.writeStringField('contentDocId', '26');
        gen.writeStringField('id', '175');
        gen.writeStringField('type', 'Non Disclosure Agreement (NDA)');
        gen.writeStringField('name', 'NDAHOLA001.txt');
        gen.writeStringField('url', 'NDA__NDAHOLA001_20180917.txt');
        gen.writestringField('startDate', '2018/09/17 10:34:33');
        gen.writeStringField('endDate', '2018/09/17 10:34:33');
        gen.writeStringField('createdBy', '212338620');
        gen.writeStringField('nameCreatedBy', 'Montserrat Ibarra');
        gen.writeStringField('creationDate', '2018/09/17 10:34:33');
        gen.writeStringField('updatedBy', '212338620');
        gen.writeStringField('nameUpdatedBy', 'Montserrat Ibarra');
        gen.writeEndObject();
        gen.writeEndArray();
        gen.writeFieldName('status');
        gen.writeStartObject();
        gen.writeStringField('code', '200');
        gen.writeStringField('message', 'Success');
        gen.writeStringField('detail', 'S');
        gen.writeEndObject();
        gen.writeEndObject();
        String jsonS = gen.getAsString(); 
        return jsonS;
        
    }
    
    public static string jsondocdetail(){
        JSONGenerator gen = JSON.createGenerator(true); 
        gen.writeStartObject();
        gen.writeStringField('docContentB64', 'asdasd');
        gen.writeStringField('contentDocId', '12');
        gen.writeStringField('docFormat', 'doc');
        gen.writeStringField('docType', 'KYC_DOCUMENT');
        gen.writeStringField('originalDocName', 'samara');
        gen.writeStringField('contentDocName', 'chucho');
        gen.writeFieldName('status');
        gen.writeStartObject();
        gen.writeStringField('code', '200');
        gen.writeStringField('message', 'Success' );
        gen.writeStringField('detail', 'S');
        gen.writeEndObject();
        gen.writeEndObject();
        String jsonS = gen.getAsString(); 
        return jsonS;
        
    }
    
    public static string jsonaudits(){
        JSONGenerator gen = JSON.createGenerator(true);
        
        gen.writeStartObject();
        gen.writeFieldName('audit');
        gen.writeStartObject();
        gen.writeFieldName('auditArray');
        gen.writeStartObject();
        gen.writeFieldName('auditElement');
        gen.writeStartArray();
        gen.writeStartObject();
        gen.writeStringField('auditUpdatedBy', '212335536');
        gen.writeStringField('auditNameUpdatedBy', 'Miguel Garcia' );
        gen.writeStringField('auditLastUpdateDate', '2018/09/21 13:10:58');
        gen.writeStringField('auditField', 'Status');
        gen.writeStringField('auditLastValue', '3');
        gen.writeStringField('auditNewValue', '11');
        gen.writeStringField('auditComment', 'El valor del campo \"Status\" fue modificado por el SSO \"212335536\" el día 2018/09/21 13:10:58\". Valor actual \"WAITING FOR CUSTOMER\" Valor anterior \"IN PROCESS');
        gen.writeEndObject();
        gen.writeEndArray();
        gen.writeEndObject();
        gen.writeEndObject();
        
        
        gen.writeFieldName('status');
        gen.writeStartObject();
        gen.writeStringField('code', '200');
        gen.writeStringField('detail', 'S');
        gen.writeStringField('message', 'Success');
        gen.writeEndObject();
        gen.writeEndObject();
        
        String jsonS = gen.getAsString(); 
        return jsonS;
    }
}