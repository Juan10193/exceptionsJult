public class ES2_controller_POSTjson {
    
    //Constructor
    public ES2_controller_POSTjson(){}
    
    
    
    public string pascheckbox(string che){
        string a = 'true';
        string b ='false';
        if(che == a){
            return 'Y';
        }else{
            return 'N';
        }
        
    }
    public string pascheckbox2(boolean che){
        if(che == true){
            return 'Y';
        }else{
            return 'N';
        }
        
    }
    
    public string pasnull(string a){
        if(a!=null){
            return a;
                }else{
                    return '';
                }
    }
    /****************************** TABLAS LIMITANTES LA********************************/
     public string Post_Limitantes_Edit(string requestid,ES5_wraper_LA_limitante li){
        System.debug(LoggingLevel.INFO,'Inicia Post_Limitantes');
        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartObject();
            if(requestid != null){
                gen.writeNumberField('requestId',Integer.valueOf(requestid));
            }
            gen.writeFieldName('laMLimitation');
            gen.writeStartObject();
                if(li.laMLLimatingId != null){
                    gen.writeNumberField('laMLLimatingId',Integer.valueOf(li.laMLLimatingId));    
                }
                //gen.writeNumberField('laMLLimatingId',String_To_Integer(li.laMLLimatingId));
                gen.writeStringField('laMLLimitante',pasnull(li.laMLLimitante));
                if(li.laMLDocumentID != null){
                    gen.writeNumberField('laMLDocumentID',Integer.valueOf(li.laMLDocumentID));
                }
                gen.writeStringField('laMLEscritura',pasnull(li.laMLEscritura));
                gen.writeStringField('laMLFecha',pasnull(li.laMLFecha));        
                gen.writeStringField('laMLFederatarioPublico',pasnull(li.laMLFederatarioPublico));
                gen.writeStringField('laMLRLugar',pasnull(li.laMLRLugar));
                gen.writeStringField('laMLRFecha',pasnull(li.laMLRFecha));
                gen.writeStringField('laMLRDatos',pasnull(li.laMLRDatos));
                gen.writeStringField('laMLActiveFlag',pasnull(li.laMLActiveFlag));
                gen.writeStringField('laMLCreatedBy',pasnull(li.laMLCreatedBy));
                gen.writeStringField('laMLCreationDate',pasnull(li.laMLCreationDate));
                gen.writeStringField('laMLLastUpdatedBy',pasnull(li.laMLLastUpdatedBy));
                gen.writeStringField('laMLLastUpdateDate',pasnull(li.laMLLastUpdateDate));
                gen.writeStringField('laMLNameCreatedBy',pasnull(li.laMLNameCreatedBy));
                gen.writeStringField('laMLNameUpdatedBy',pasnull(li.laMLNameUpdatedBy));
            gen.writeEndObject();
        gen.writeEndObject();
        String jsonS = gen.getAsString();
        return jsonS;
    }
    public string Post_Limitantes_New(string requestid,ES5_wraper_LA_limitante li){
        System.debug(LoggingLevel.INFO,'Inicia Post_Limitantes');
        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartObject();
            if(requestid != null){
                gen.writeNumberField('requestId',Integer.valueOf(requestid));
            }
            gen.writeFieldName('laMLimitation');
            gen.writeStartObject();
                gen.writeStringField('laMLLimitante',pasnull(li.laMLLimitante));
                gen.writeStringField('laMLEscritura',pasnull(li.laMLEscritura));
                gen.writeStringField('laMLFecha',pasnull(li.laMLFecha));        
                gen.writeStringField('laMLFederatarioPublico',pasnull(li.laMLFederatarioPublico));
                gen.writeStringField('laMLRLugar',pasnull(li.laMLRLugar));
                gen.writeStringField('laMLRFecha',pasnull(li.laMLRFecha));
                gen.writeStringField('laMLRDatos',pasnull(li.laMLRDatos));
                gen.writeStringField('laMLActiveFlag',pasnull(li.laMLActiveFlag));
                gen.writeStringField('laMLCreatedBy',pasnull(li.laMLCreatedBy));
            gen.writeEndObject();
        gen.writeEndObject();
        String jsonS = gen.getAsString();
        
        System.debug(LoggingLevel.DEBUG, 'Se ha generado el siguiente JSON: ' + jsonS);        
        system.debug(LoggingLevel.INFO, 'Termina Post_Limitantes ');   
        return jsonS;
    }
    /****************************** TABLAS MODIFICACIONES LA********************************/
    public string Post_Modificaciones_EDIT_NEW(string requestid,ES5_wraper_LA_modificacion mo){
        System.debug(LoggingLevel.INFO,'Inicia Post_Modificaciones');
        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartObject();
            if(requestid != null){
                gen.writeNumberField('requestId',Integer.valueOf(requestid));
            }
            gen.writeFieldName('laMModification');
            gen.writeStartObject();
                if(mo.laMModificationId != null){
                    gen.writeNumberField('laMModificationId',Integer.valueOf(mo.laMModificationId));
                }
                if(mo.laMMDocumentId != null){
                    gen.writeNumberField('laMMDocumentId',Integer.valueOf(mo.laMMDocumentId));
                }
                gen.writeStringField('laMMReformaTotal',pasnull(mo.laMMReformaTotal));
                gen.writeStringField('laMMEscritura',pasnull(mo.laMMEscritura));
                gen.writeStringField('laMMFecha',pasnull(mo.laMMFecha));
                gen.writeStringField('laMMFederatarioPublico',pasnull(mo.laMMFederatarioPublico));
                gen.writeStringField('laMMRLugar',pasnull(mo.laMMRLugar));
                gen.writeStringField('laMMRFecha',pasnull(mo.laMMRFecha));
                gen.writeStringField('laMMRDatos',pasnull(mo.laMMRDatos));
                gen.writeStringField('laMMObservaciones',pasnull(mo.laMMObservaciones));
        
                gen.writeStringField('laMMActiveFlag',pasnull(mo.laMMActiveFlag));
                gen.writeStringField('laMMCreatedBy',pasnull(mo.laMMCreatedBy));
                gen.writeStringField('laMMCreationDate',pasnull(mo.laMMCreationDate));
                gen.writeStringField('laMMLastUpdatedBy',pasnull(mo.laMMLastUpdatedBy));
                gen.writeStringField('laMMLastUpdateDate',pasnull(mo.laMMLastUpdateDate));
                gen.writeStringField('laMMNameCreatedBy',pasnull(mo.laMMNameCreatedBy));
                gen.writeStringField('laMMNameUpdatedBy',pasnull(mo.laMMNameUpdatedBy));
            gen.writeEndObject();
        gen.writeEndObject();
        
        
        String jsonS = gen.getAsString();
        System.debug(LoggingLevel.DEBUG, 'Se ha generado el siguiente JSON: ' + jsonS);        
        System.debug(LoggingLevel.INFO, 'Termina Post_Modificaciones ');        
        return jsonS;
    }
    /****************************** TABLAS APODERADOS LA********************************/
    public string Post_Apoderados_NEW(string requestid,ES5_wraper_LA_apoderados apo){
        System.debug(LoggingLevel.INFO,'Inicia Post_Apoderados_NEW');
        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartObject();
            if(requestid != null){
                gen.writeNumberField('requestId',Integer.valueOf(requestid));
            }
            gen.writeFieldName('laAAttorney');
            gen.writeStartObject();
                System.debug('apo.laAObservaciones ' + apo.laAObservaciones);
                System.debug('apo.laAObservacionesRevoca ' + apo.laAObservacionesRevoca);
        
                if(apo.laAApoderadoID != null){
                    gen.writeNumberField('laAApoderadoID',Integer.valueOf(apo.laAApoderadoID));
                }
                if(apo.laADocumentID != null){
                    gen.writeNumberField('laADocumentID',Integer.valueOf(apo.laADocumentID));
                }
                gen.writeStringField('laANombreFacultado',pasnull(apo.laANombreFacultado));
                gen.writeStringField('laAFecha',pasnull(apo.laAFecha));
                gen.writeStringField('laAActosDominio',pasnull(apo.laAActosDominio));
                gen.writeStringField('laATitulosCredito',pasnull(apo.laATitulosCredito));
                gen.writeStringField('laAActosAdministrativos',pasnull(apo.laAActosAdministrativos));
                gen.writeStringField('laAPleitosCobranza',pasnull(apo.laAPleitosCobranza));
                gen.writeStringField('laAIndMan',pasnull(apo.laAIndMan));
                gen.writeStringField('laAObservaciones',pasnull(apo.laAObservaciones));
                gen.writeStringField('laAEscrituraNum',pasnull(apo.laAEscrituraNum));
                gen.writeStringField('laAPEspecial',pasnull(apo.laAPEspecial));
                gen.writeStringField('laAPOtros',pasnull(apo.laAPOtros));
                gen.writeStringField('laAFedatarioPublico',pasnull(apo.laAFedatarioPublico));
                gen.writeStringField('laAFechaRegistro',pasnull(apo.laAFechaRegistro));
                gen.writeStringField('laALugarRegistro',pasnull(apo.laALugarRegistro));
                gen.writeStringField('laADatosRegistro',pasnull(apo.laADatosRegistro)) ;
                gen.writeStringField('laAOcupacion',pasnull(apo.laAOcupacion));
                gen.writeStringField('laAFechaNacimiento',pasnull(apo.laAFechaNacimiento));
                gen.writeStringField('laANacionalidad',pasnull(apo.laANacionalidad));
                gen.writeStringField('laADomicilio',pasnull(apo.laADomicilio));
                gen.writeStringField('laAEscrituraRevoca',pasnull(apo.laAEscrituraRevoca));
                gen.writeStringField('laAFechaRevoca',pasnull(apo.laAFechaRevoca));
                gen.writeStringField('laALugarRevoca',pasnull(apo.laALugarRevoca));
                gen.writeStringField('laADatosRegistroRevoca',pasnull(apo.laADatosRegistroRevoca));
                gen.writeStringField('laAObservacionesRevoca',pasnull(apo.laAObservacionesRevoca));
                gen.writeStringField('laAActiveFlag',pasnull(apo.laAActiveFlag));
                gen.writeStringField('laACreatedBy',pasnull(apo.laACreatedBy));
                gen.writeStringField('laACreationDate',pasnull(apo.laACreationDate));
                gen.writeStringField('laALastUpdatedBy',pasnull(apo.laALastUpdatedBy));
                gen.writeStringField('laALastUpdateDate',pasnull(apo.laALastUpdateDate));
                gen.writeStringField('laANameCreatedBy',pasnull(apo.laANameCreatedBy));
                gen.writeStringField('laANameUpdatedBy',pasnull(apo.laANameUpdatedBy));
            gen.writeEndObject();
        gen.writeEndObject();
        String jsonS = gen.getAsString();
        
        System.debug(LoggingLevel.DEBUG, 'Se ha generado el siguiente JSON: ' + jsonS);        
        System.debug(LoggingLevel.INFO, 'Termina Post_Apoderados_NEW ');
        return jsonS;
    }
    public string Post_Apoderados_EDIT(string requestid,ES5_wraper_LA_apoderados apo){
        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartObject();
            if(requestid != null){
                gen.writeNumberField('requestId',Integer.valueOf(requestid));
            }
            gen.writeFieldName('laAAttorney');
            gen.writeStartObject();
                gen.writeStringField('laANombreFacultado',pasnull(apo.laANombreFacultado));
                gen.writeStringField('laAFecha',pasnull(apo.laAFecha));
                gen.writeStringField('laATitulosCredito',pasnull(apo.laATitulosCredito));
                gen.writeStringField('laAActosAdministrativos',pasnull(apo.laAActosAdministrativos));
                gen.writeStringField('laAPleitosCobranza',pasnull(apo.laAPleitosCobranza));
                gen.writeStringField('laAEscrituraNum',pasnull(apo.laAEscrituraNum));
                gen.writeStringField('laAFechaRegistro',pasnull(apo.laAFechaRegistro));
                gen.writeStringField('laAEscrituraRevoca',pasnull(apo.laAEscrituraRevoca));
                gen.writeStringField('laAObservacionesRevoca',pasnull(apo.laAObservacionesRevoca));
                gen.writeStringField('laAFechaRevoca',pasnull(apo.laAFechaRevoca));
                gen.writeStringField('laAActiveFlag',pasnull(apo.laAActiveFlag));
                gen.writeStringField('laACreatedBy',pasnull(apo.laACreatedBy));
                gen.writeStringField('laACreationDate',pasnull(apo.laACreationDate));
            gen.writeEndObject();
        gen.writeEndObject();
        String jsonS = gen.getAsString();
        
        System.debug(LoggingLevel.DEBUG, 'Se ha generado el siguiente JSON: ' + jsonS);        
        System.debug(LoggingLevel.INFO, 'Termina Post_Apoderados_EDIT ');
        return jsonS;
    }
    /*************************Estatutos********************************/
    /****************************** TABLAS Estatutos LA********************************/
    public string Post_Estatutos_EDIT(string requestid,ES5_wraper_LA_Estatutos est){
        System.debug(LoggingLevel.INFO,'Inicia Post_Estatutos_EDIT');
        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartObject();
            if(requestid != null){
                gen.writeNumberField('requestId',Integer.valueOf(requestid));
            }
            gen.writeFieldName('laEEstatuto');
            gen.writeStartObject();
                if(est.pOutlaEEstatutoID != null){
                    gen.writeNumberField('laEEstatutoID',Integer.valueOf(est.pOutlaEEstatutoID));
                }
                gen.writeStringField('laEEstatuto',pasnull(est.pOutlaEEstatuto));
                gen.writeStringField('laEFecha',pasnull(est.pOutlaEFecha));
                gen.writeStringField('laEComentarios',pasnull(est.pOutlaEComentarios));
                gen.writeStringField('laEObservaciones',pasnull(est.pOutlaEObservaciones));
                gen.writeStringField('laEActiveFlag',pasnull(est.pOutlaEActiveFlag));
                gen.writeStringField('laECreatedBy',pasnull(est.pOutlaECreatedBy));
                gen.writeStringField('laECreationDate',pasnull(est.pOutlaECreationDate));
        
                gen.writeStringField('laELastUpdatedBy',pasnull(est.pOutlaELastUpdatedBy));
                gen.writeStringField('laELastUpdateDate',pasnull(est.pOutlaELastUpdateDate));
        
                gen.writeStringField('laENameCreatedBy',pasnull(est.pOutlaENameCreatedBy));
                gen.writeStringField('laENameUpdatedBy',pasnull(est.pOutlaENameUpdatedB));
            gen.writeEndObject();
        gen.writeEndObject();
        String jsonS = gen.getAsString();
        
        System.debug(LoggingLevel.DEBUG, 'Se ha generado el siguiente JSON: ' + jsonS);        
        System.debug(LoggingLevel.INFO, 'Termina Post_Estatutos_EDIT ');
        return jsonS;
    }
    public string Post_Estatutos_NEW(string requestid,ES5_wraper_LA_Estatutos est){
        System.debug(LoggingLevel.INFO,'Inicia Post_Estatutos_NEW');
        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartObject();
            if(requestid != null){
                gen.writeNumberField('requestId',Integer.valueOf(requestid));
            }
            gen.writeFieldName('laEEstatuto');
            gen.writeStartObject();
                if(est.pOutlaEEstatutoID != null){
                    gen.writeNumberField('laEEstatutoID',Integer.valueOf(est.pOutlaEEstatutoID));
                }
                gen.writeStringField('laEEstatuto',pasnull(est.pOutlaEEstatuto));
                gen.writeStringField('laEFecha',pasnull(est.pOutlaEFecha));
                gen.writeStringField('laEComentarios',pasnull(est.pOutlaEComentarios));
                gen.writeStringField('laEObservaciones',pasnull(est.pOutlaEObservaciones));
                gen.writeStringField('laEActiveFlag',pasnull(est.pOutlaEActiveFlag));
                gen.writeStringField('laECreatedBy',pasnull(est.pOutlaECreatedBy));
                gen.writeStringField('laECreationDate',pasnull(est.pOutlaECreationDate));
        
                gen.writeStringField('laELastUpdatedBy',pasnull(est.pOutlaELastUpdatedBy));
                gen.writeStringField('laELastUpdateDate',pasnull(est.pOutlaELastUpdateDate));
        
                gen.writeStringField('laENameCreatedBy',pasnull(est.pOutlaENameCreatedBy));
                gen.writeStringField('laENameUpdatedBy',pasnull(est.pOutlaENameUpdatedB));
            gen.writeEndObject();
        gen.writeEndObject();
        String jsonS = gen.getAsString();
        
        System.debug(LoggingLevel.DEBUG, 'Se ha generado el siguiente JSON: ' + jsonS);        
        System.debug(LoggingLevel.INFO, 'Termina Post_Estatutos_NEW ');
        return jsonS;
    }
    public string postLA(ES2_WraperRequest req, string tipop){
        JSONGenerator gen = JSON.createGenerator(true);    
        gen.writeStartObject();
            gen.writeFieldName('request');
            gen.writeStartObject();
            
                gen.writeFieldName('header');
                gen.writeStartObject();
        
                    gen.writeStringField('requestId' ,pasnull(req.pOutRequestId));
                    gen.writeStringField('requestType' , pasnull(req.pOutRequestType));
                    gen.writeStringField('applicationCode' , 'SF');
                    gen.writeStringField('requestStartDate' , pasnull(req.pOutStartDate));
                    gen.writeStringField('requestEndDate' , pasnull(req.pOutEndDate));
                    gen.writeStringField('partyId' , pasnull(req.pOutPartyId));
                    gen.writeStringField('requestStatus' , pasnull(req.pOutRequestStatus));
                    gen.writeStringField('requestedBy' , pasnull(req.pOutRequestedBy));
                    gen.writeStringField('assignedToPerson' , pasnull(req.pOutAssignedTo));
                
                gen.writeEndObject();
        
                gen.writeFieldName('detail');
                gen.writeStartObject();
                    gen.writeFieldName('legalAssessment');
                    gen.writeStartObject(); 
                        gen.writeFieldName('header');
                        gen.writeStartObject();
                                gen.writeStringField('requestId' ,pasnull(req.pOutRequestId));
                                gen.writeStringField('laTipo' , pasnull(req.LAH.pOutlaType));
                                gen.writeStringField('laGIValidThrough' , pasnull(req.LAH.pOutValidThrough));
                                gen.writeStringField('laNombre', pasnull(req.pOutPartyName));
                            gen.writeFieldName('entityInformation');
                            gen.writeStartObject();
                                gen.writeStringField('LAEINacionalidad' , pasnull(req.LAH.pOutnacionalidad));
                                gen.writeStringField('LAEINombre', pasnull(req.pOutPartyName));
                                gen.writeStringField('laEIRfcTin' , pasnull(req.LAH.pOutRFC));
                                gen.writeStringField('laEICurp' , pasnull(req.LAH.pOutcurp));
                                gen.writeStringField('laEINumeroCuenta' , pasnull(req.LAH.pOutNoCuenta));
                                gen.writeStringField('laEITipoEntidad' , pasnull(req.LAH.pOutEntidadtype));
                                gen.writeStringField('laEIGrupoEconomico' , pasnull(req.LAH.pOutEConomicgroup));
                                gen.writeStringField('laEITaxRegime' , pasnull(req.LAH.pOutTaxRegime));
                            gen.writeEndObject();
                        gen.writeEndObject();
                    gen.writeFieldName('detail');
                                gen.writeStartObject();
                                    switch on tipop {
                                    when 'laPersonaMoral' {     // when block 1
                                            gen.writeFieldName('laPersonaMoral');
                                    gen.writeStartObject();
                                        gen.writeFieldName('laPMActaConstitutiva');
                                        gen.writeStartObject();
                                            if(req.LAH.pmoral.pOutLAMACDocumentID != null){
                                                gen.writeNumberField('laPMACDocumentId' , integer.valueOf(req.LAH.pmoral.pOutLAMACDocumentID));
                                            }
                                            //
                                            gen.writeStringField('laPMACDenomConstituirse' , pasnull(req.LAH.pmoral.pOutLAMACDenomconstituirse));
                                            gen.writeStringField('laPMACEscrituraNum' , pasnull(req.LAH.pmoral.pOutLAMACEscrituraNo));
                                            gen.writeStringField('laPMACFechaEscritura' , pasnull(req.LAH.pmoral.pOutLAMACFechaEscritura));
                                            gen.writeStringField('laPMACDuracion' , pasnull(req.LAH.pmoral.pOutLAMACDuracion));
                                            /*if(req.LAH.pmoral.pOutLAMACDuracion != null){
                                                gen.writeNumberField('laPMACDuracion' , integer.valueOf(req.LAH.pmoral.pOutLAMACDuracion));
                                            } */
                                            gen.writeStringField('laPMACClausulaExtranjero' , pasnull(req.LAH.pmoral.pOutLAMACClausulaExtranjero));
                                            gen.writeStringField('laPMACFedatarioPublico' , pasnull(req.LAH.pmoral.pOutLAMACFedatarioPublico));
                                            gen.writeStringField('laPMACFechaRegistro' , pasnull(req.LAH.pmoral.pOutLAMACFechaRegistro));
                                            gen.writeStringField('laPMACLugarRegistro' , pasnull(req.LAH.pmoral.pOutLAMACLugarRegistro));
                                            gen.writeStringField('laPMACDatosRegistro' , pasnull(req.LAH.pmoral.pOutLAMACDatosRegistro));
                                            gen.writeStringField('laPMACObservaciones' , pasnull(req.LAH.pmoral.pOutLAMACObservaciones));
                                        gen.writeEndObject();
                                        //
                                        gen.writeFieldName('laPMDomicilioSocial');
                                        gen.writeStartObject();
                                            if(req.LAH.pmoral.pOutLAMDSAddressID != null){
                                                gen.writeNumberField('laDSAddressID' , integer.valueOf(req.LAH.pmoral.pOutLAMDSAddressID));
                                            }
                                            
                                            gen.writeStringField('laDSPais' , pasnull(req.LAH.pmoral.pOutLAMDSPais));
                                            gen.writeStringField('laDSCodigoPostal' , pasnull(req.LAH.pmoral.pOutLAMDSCodigoPostal));
                                            gen.writeStringField('laDSEstado' , pasnull(req.LAH.pmoral.pOutLAMDSEstado));
                                            gen.writeStringField('laDSCiudad' , pasnull(req.LAH.pmoral.pOutLAMDSCiudad));        
                                            gen.writeStringField('laDSMunicipioAlcaldia' , pasnull(req.LAH.pmoral.pOutLAMDSMunicipioAlcaldia));
                                            gen.writeStringField('laDSColonia' , pasnull(req.LAH.pmoral.pOutLAMDSColonia));
                                            gen.writeStringField('laDSCalle' , pasnull(req.LAH.pmoral.pOutLAMDSCalle));
                                            gen.writeStringField('laDSNumExterior' , pasnull(req.LAH.pmoral.pOutLAMDSNoExterior));
                                            gen.writeStringField('laDSNumInterior' , pasnull(req.LAH.pmoral.pOutLAMDSNoInterior));
                                        gen.writeEndObject();
                                        //
                                        gen.writeFieldName('laPMObjetoSocial');
                                        gen.writeStartObject();
                                            if(req.LAH.pmoral.pOutLAMOSDocumentID != null){
                                                gen.writeNumberField('laPMOSDocumentId' , integer.valueOf(req.LAH.pmoral.pOutLAMOSDocumentID));
                                            }
                                            //gen.writeNumberField('laPMOSDocumentId' , integer.valueOf(pasnull(req.LAH.pmoral.pOutLAMOSDocumentID)));
                                            gen.writeStringField('LAPMOSPurposeId' , pasnull(req.LAH.pmoral.pOutLAMOSPurposeID));
                                            gen.writeStringField('laPMOSEscritura' , pasnull(req.LAH.pmoral.pOutLAMOSEscritura));
                                            gen.writeStringField('laPMOSAutorizadoArrendar' , pasnull(req.LAH.pmoral.pOutLAMOSAutorizadoArrendar));
                                            gen.writeStringField('laPMOSAutSuscribirTitCredito' , pasnull(req.LAH.pmoral.pOutLAMOSAutSuscTItulosCredit));        
                                            gen.writeStringField('laPMOSAutGarantizar' , pasnull(req.LAH.pmoral.pOutLAMOSAutorizadoGarantizar));
                                            gen.writeStringField('laPMOSFiador' , pasnull(req.LAH.pmoral.pOutLAMOSFiador));
                                            gen.writeStringField('laPMOSAval' , pasnull(req.LAH.pmoral.pOutLAMOSAval));
                                            gen.writeStringField('laPMOSObservaciones' , pasnull(req.LAH.pmoral.pOutLAMOSObservaciones));
                                            gen.writeStringField('laPMOSObligadoSolidario' , pasnull(req.LAH.pmoral.pOutLAMOSObligadoSolidario));
                                            gen.writeStringField('laPMOSGarantObligTerceros' , pasnull(req.LAH.pmoral.pOutLAMOSGarantObligTerceros));
                                            gen.writeStringField('laPMOSLimitantesObjetoSocial' , pasnull(req.LAH.pmoral.pOutLAMOSLimitanteObjetoSoc));
                                        gen.writeEndObject();
                                        //
                                        gen.writeFieldName('laPMComprobanteDomicilio');
                                        gen.writeStartObject();
                                            if(req.LAH.pmoral.pOutLAMCDAddressID != null){
                                                gen.writeNumberField('laCDAddressId' , integer.valueOf(req.LAH.pmoral.pOutLAMCDAddressID));    
                                            }
                                            //gen.writeNumberField('laCDAddressId' , integer.valueOf(pasnull(req.LAH.pmoral.pOutLAMCDAddressID)));
                                            gen.writeStringField('laCDPais' , pasnull(req.LAH.pmoral.pOutLAMCDPais));
                                            gen.writeStringField('laCDCodigoPostal' , pasnull(req.LAH.pmoral.pOutLAMCDCodigoPostal));
                                            gen.writeStringField('laMCDEstado' , pasnull(req.LAH.pmoral.pOutLAMCDEstado));
                                            gen.writeStringField('laCDCiudad' , pasnull(req.LAH.pmoral.pOutLAMCDCiudad));        
                                            gen.writeStringField('laCDMunicipioAlcaldia' , pasnull(req.LAH.pmoral.pOutLAMCDMunicipioAlcaldia));
                                            gen.writeStringField('laCDColonia' , pasnull(req.LAH.pmoral.pOutLAMCDColonia));
                                            gen.writeStringField('laCDCalle' , pasnull(req.LAH.pmoral.pOutLAMCDCalle));
                                            gen.writeStringField('laCDNumExterior' , pasnull(req.LAH.pmoral.pOutLAMCDNoExterior));
                                            gen.writeStringField('laCDNumInterior' , pasnull(req.LAH.pmoral.pOutLAMCDNoInterior));                                          
                                        gen.writeEndObject();
                                        //
                                        gen.writeFieldName('laPMDatosFiscales');
                                        gen.writeStartObject();
                                            if(req.LAH.pmoral.pOutLAMDFAddressID != null){
                                                gen.writeNumberField('laDFAddressId' , integer.valueOf(req.LAH.pmoral.pOutLAMDFAddressID));    
                                            }
                                            //gen.writeNumberField('laDFAddressId' , integer.valueOf(pasnull(req.LAH.pmoral.pOutLAMDFAddressID)));
                                            gen.writeStringField('laDFRfcTin' , pasnull(req.LAH.pmoral.pOutLAMDFRFC));
                                            gen.writeStringField('laDFPais' , pasnull(req.LAH.pmoral.pOutLAMDFPais));
                                            gen.writeStringField('laDFCodigoPostal' , pasnull(req.LAH.pmoral.pOutLAMDFCodigoPostal));
                                            gen.writeStringField('laDFEstado' , pasnull(req.LAH.pmoral.pOutLAMDFEstado));        
                                            gen.writeStringField('laDFCiudad' , pasnull(req.LAH.pmoral.pOutLAMDFCiudad));
                                            gen.writeStringField('laDFMunicipioAlcaldia' , pasnull(req.LAH.pmoral.pOutLAMDFMunicipioAlcaldia));
                                            gen.writeStringField('laDFColonia' , pasnull(req.LAH.pmoral.pOutLAMDFColonia));
                                            gen.writeStringField('laDFCalle' , pasnull(req.LAH.pmoral.pOutLAMDFCalle));
                                            gen.writeStringField('laDFNumExterior' , pasnull(req.LAH.pmoral.pOutLAMDFNoExterior)); 
                                            gen.writeStringField('laDFNumInterior' , pasnull(req.LAH.pmoral.pOutLAMDFNoInterior)); 
                                        gen.writeEndObject();
                                        //
                                        gen.writeFieldName('laPMBil');
                                        gen.writeStartObject();
                                         gen.writeStringField('laBBilId' , pasnull(req.LAH.pmoral.pOutLAMBBilId));
                                         gen.writeStringField('laBFechaRevision' , pasnull(req.LAH.pmoral.pOutLAMBFechaRevision));
                                         gen.writeStringField('laBIncidencias' , pasnull(req.LAH.pmoral.pOutLAMBIncidencias));
                                         gen.writeStringField('laBComentarios' , pasnull(req.LAH.pmoral.pOutLAMBComentarios));
                                        gen.writeEndObject();
                                        //
                                    gen.writeEndObject();
                                    //
                                        }   
                                    when 'laPersonaMoralExtranjera' {       // when block 2
                                        gen.writeFieldName('laPersonaMoralExtranjera');
                                    gen.writeStartObject();
                                        gen.writeFieldName('laPMEActaConstitutiva');
                                        gen.writeStartObject();
                                            if(req.LAH.pmoralExtranjera.pOutLAPMEACDocumentID != null){
                                                gen.writeNumberField('laPMACDocumentId' , integer.valueOf(req.LAH.pmoralExtranjera.pOutLAPMEACDocumentID));   
                                            }
                                            //gen.writeNumberField('laPMACDocumentId' , integer.valueOf(pasnull(req.LAH.pmoralExtranjera.pOutLAPMEACDocumentID)));
                                            gen.writeStringField('laPMACDenomConstituirse' , pasnull(req.LAH.pmoralExtranjera.pOutLAPMEACDenomconstituirse));
                                            gen.writeStringField('laPMACEscrituraNum' , pasnull(req.LAH.pmoralExtranjera.pOutLAPMEACEscrituraNum));
                                            gen.writeStringField('laPMACFechaEscritura' , pasnull(req.LAH.pmoralExtranjera.pOutLAPMEACFechaEscritura));
                                            gen.writeStringField('laPMACDuracion' , pasnull(req.LAH.pmoralExtranjera.pOutLAPMEACDuracion));
                                            gen.writeStringField('laPMACObservaciones' , pasnull(req.LAH.pmoralExtranjera.pOutLAPMEACObservaciones));
                                        gen.writeEndObject();
                                        //
                                        gen.writeFieldName('laPMEDomicilioSocial');
                                        gen.writeStartObject();
                                            if(req.LAH.pmoralExtranjera.pOutLAPMEDSAddressID != null){
                                                gen.writeNumberField('laDSAddressID' , integer.valueOf(req.LAH.pmoralExtranjera.pOutLAPMEDSAddressID));    
                                            }
                                            //gen.writeNumberField('laDSAddressID' , integer.valueOf(pasnull(req.LAH.pmoralExtranjera.pOutLAPMEDSAddressID)));
                                            gen.writeStringField('laDSPais' , pasnull(req.LAH.pmoralExtranjera.pOutLAPMEDSPais));
                                            gen.writeStringField('laDSCodigoPostal' , pasnull(req.LAH.pmoralExtranjera.pOutLAPMEDSCodigoPostal));
                                            gen.writeStringField('laDSEstado' , pasnull(req.LAH.pmoralExtranjera.pOutLAPMEDSEstado));
                                            gen.writeStringField('laDSCiudad' , pasnull(req.LAH.pmoralExtranjera.pOutLAPMEDSCiudad));
                                            gen.writeStringField('laDSMunicipioAlcaldia' , pasnull(req.LAH.pmoralExtranjera.pOutLAPMEDSMunicipioAlcaldia));
                                            gen.writeStringField('laDSColonia' , pasnull(req.LAH.pmoralExtranjera.pOutLAPMEDSColonia));
                                            gen.writeStringField('laDSCalle' , pasnull(req.LAH.pmoralExtranjera.pOutLAPMEDSCalle));
                                            gen.writeStringField('laDSNumExterior' , pasnull(req.LAH.pmoralExtranjera.pOutLAPMEDSNoExterior));
                                            gen.writeStringField('laDSNumInterior' , pasnull(req.LAH.pmoralExtranjera.pOutLAPMEDSNoInterior));
                                        gen.writeEndObject();
                                        //
                                        gen.writeFieldName('laPMEComprobanteDomicilio');
                                        gen.writeStartObject();
                                            if(req.LAH.pmoralExtranjera.pOutLAPMECDAddressID != null){
                                                gen.writeNumberField('laCDAddressId' , integer.valueOf(req.LAH.pmoralExtranjera.pOutLAPMECDAddressID));
                                            }
                                            //gen.writeNumberField('laCDAddressId' , integer.valueOf(pasnull(req.LAH.pmoralExtranjera.pOutLAPMECDAddressID)));
                                            gen.writeStringField('laCDPais' , pasnull(req.LAH.pmoralExtranjera.pOutLAPMECDPais));
                                            gen.writeStringField('laCDCodigoPostal' , pasnull(req.LAH.pmoralExtranjera.pOutLAPMECDCodigoPostal));
                                            gen.writeStringField('laMCDEstado' , pasnull(req.LAH.pmoralExtranjera.pOutLAPMECDEstado));
                                            gen.writeStringField('laCDCiudad' , pasnull(req.LAH.pmoralExtranjera.pOutLAPMECDCiudad));
                                            gen.writeStringField('laCDMunicipioAlcaldia' , pasnull(req.LAH.pmoralExtranjera.pOutLAPMECDMunicipioAlcaldia));        
                                            gen.writeStringField('laCDColonia' , pasnull(req.LAH.pmoralExtranjera.pOutLAPMECDColonia));
                                            gen.writeStringField('laCDCalle' , pasnull(req.LAH.pmoralExtranjera.pOutLAPMECDCalle));
                                            gen.writeStringField('laCDNumExterior' , pasnull(req.LAH.pmoralExtranjera.pOutLAPMECDNoExterior));
                                            gen.writeStringField('laCDNumInterior' , pasnull(req.LAH.pmoralExtranjera.pOutLAPMECDNoInterior));
                                        gen.writeEndObject();
                                        //
                                        gen.writeFieldName('laPMEDatosFiscales');
                                        gen.writeStartObject();
                                            if(req.LAH.pmoralExtranjera.pOutLAPMEDFAddressID != null){
                                                gen.writeNumberField('laDFAddressId' , integer.valueOf(req.LAH.pmoralExtranjera.pOutLAPMEDFAddressID));                             
                                            }                         
                                            //gen.writeNumberField('laDFAddressId' , integer.valueOf(pasnull(req.LAH.pmoralExtranjera.pOutLAPMEDFAddressID)));
                                            gen.writeStringField('laDFRfcTin' , pasnull(req.LAH.pmoralExtranjera.pOutLAPMEDFTIN));
                                            gen.writeStringField('laDFPais' , pasnull(req.LAH.pmoralExtranjera.pOutLAPMEDFPais));
                                            gen.writeStringField('laDFCodigoPostal' , pasnull(req.LAH.pmoralExtranjera.pOutLAPMEDFCodigoPostal));
                                            gen.writeStringField('laDFEstado' , pasnull(req.LAH.pmoralExtranjera.pOutLAPMEDFEstado));
                                            gen.writeStringField('laDFCiudad' , pasnull(req.LAH.pmoralExtranjera.pOutLAPMEDFCiudad));
                                            gen.writeStringField('laDFMunicipioAlcaldia' , pasnull(req.LAH.pmoralExtranjera.pOutLAPMEDFMunicipioAlcaldia));
                                            gen.writeStringField('laDFColonia' , pasnull(req.LAH.pmoralExtranjera.pOutLAPMEDFColonia));
                                            gen.writeStringField('laDFCalle' , pasnull(req.LAH.pmoralExtranjera.pOutLAPMEDFCalle));
                                            gen.writeStringField('laDFNumExterior' , pasnull(req.LAH.pmoralExtranjera.pOutLAPMEDFNoExterior));
                                            gen.writeStringField('laDFNumInterior' , pasnull(req.LAH.pmoralExtranjera.pOutLAPMEDFNoInterior));
                                            gen.writeStringField('laDFW8W9' , pasnull(req.LAH.pmoralExtranjera.pOutLAPMEDFW8W9));
                                        gen.writeEndObject();
                                        gen.writeFieldName('laPMEBil');
                                        gen.writeStartObject();
                                         gen.writeStringField('laBBilId' , pasnull(req.LAH.pmoralExtranjera.pOutLAPMEBBilId));
                                         gen.writeStringField('laBFechaRevision' , pasnull(req.LAH.pmoralExtranjera.pOutLAPMEBFechaRevision));
                                         gen.writeStringField('laBIncidencias' , pasnull(req.LAH.pmoralExtranjera.pOutLAPMEBIncidencias));
                                         gen.writeStringField('laBComentarios' , pasnull(req.LAH.pmoralExtranjera.pOutLAPMEBComentarios));
                                        gen.writeEndObject();
                                        //
                                    gen.writeEndObject();
                                    //
                                        }
                                    when 'laPersonaFisica' {        // when block 3
                                        gen.writeFieldName('laPersonaFisica');
                                    gen.writeStartObject();
                                        //
                                        gen.writeFieldName('laPFDatosGenerales');
                                        gen.writeStartObject();                                     
                                            gen.writeStringField('laPFDGNombre' , pasnull(req.LAH.pfisica.pOutLAPFDGNombre));
                                            gen.writeStringField('laPFDGFechadenacimiento' , pasnull(req.LAH.pfisica.pOutLAPFDGFechadenacimiento));
                                            gen.writeStringField('laPFDGLugardenacimiento' , pasnull(req.LAH.pfisica.pOutLAPFDGLugardenacimiento));
                                            gen.writeStringField('laPFDGEstadoCivil' , pasnull(req.LAH.pfisica.pOutLAPFDGEstadoCivil));
                                            gen.writeStringField('laPFDGVigenciaId' , pasnull(req.LAH.pfisica.pOutLAPFDGVigenciaId));
                                            gen.writeStringField('laPFDGComentarios' , pasnull(req.LAH.pfisica.pOutLAPFDGComentarios));
                                                  
                                        gen.writeEndObject();
                                        //
                                        gen.writeFieldName('laPFDomicilioSocial');
                                        gen.writeStartObject();
                                            if(req.LAH.pfisica.pOutLADSAddressID != null){
                                                gen.writeNumberField('laDSAddressID' , integer.valueOf(req.LAH.pfisica.pOutLADSAddressID));    
                                            }                                           
                                            gen.writeStringField('laDSPais' , pasnull(req.LAH.pfisica.pOutLADSPais));
                                            gen.writeStringField('laDSCodigoPostal' , pasnull(req.LAH.pfisica.pOutLADSCodigoPostal));
                                            gen.writeStringField('laDSEstado' , pasnull(req.LAH.pfisica.pOutLADSEstado));
                                            gen.writeStringField('laDSCiudad' , pasnull(req.LAH.pfisica.pOutLADSCiudad));
                                            gen.writeStringField('laDSMunicipioAlcaldia' , pasnull(req.LAH.pfisica.pOutLADSMunicipioAlcaldia));
                                            gen.writeStringField('laDSColonia' , pasnull(req.LAH.pfisica.pOutLADSColonia));
                                            gen.writeStringField('laDSCalle' , pasnull(req.LAH.pfisica.pOutLADSCalle));
                                            gen.writeStringField('laDSNumExterior' , pasnull(req.LAH.pfisica.pOutLADSNumExterior));
                                            gen.writeStringField('laDSNumInterior' , pasnull(req.LAH.pfisica.pOutLADSNumInterior));        
                                        gen.writeEndObject();
                                        //
                                        gen.writeFieldName('laPFComprobanteDomicilio');
                                        gen.writeStartObject();
                                            if(req.LAH.pfisica.pOutLACDAddressId != null){
                                                gen.writeNumberField('laCDAddressId' , integer.valueOf(req.LAH.pfisica.pOutLACDAddressId));    
                                            }
                                            //gen.writeNumberField('laCDAddressId' , integer.valueOf(pasnull(req.LAH.pfisica.pOutLACDAddressId)));
                                            gen.writeStringField('laCDPais' , pasnull(req.LAH.pfisica.pOutLACDPais));
                                            gen.writeStringField('laCDCodigoPostal' , pasnull(req.LAH.pfisica.pOutLACDCodigoPostal));
                                            gen.writeStringField('laMCDEstado' , pasnull(req.LAH.pfisica.pOutLAMCDEstado));
                                            gen.writeStringField('laCDCiudad' , pasnull(req.LAH.pfisica.pOutLACDCiudad));
                                            gen.writeStringField('laCDMunicipioAlcaldia' , pasnull(req.LAH.pfisica.pOutLACDMunicipioAlcaldia));
                                            gen.writeStringField('laCDColonia' , pasnull(req.LAH.pfisica.pOutLACDColonia));
                                            gen.writeStringField('laCDCalle' , pasnull(req.LAH.pfisica.pOutLACDCalle));
                                            gen.writeStringField('laCDNumExterior' , pasnull(req.LAH.pfisica.pOutLACDNumExterior));
                                            gen.writeStringField('laCDNumInterior' , pasnull(req.LAH.pfisica.pOutLACDNumInterior));        
                                        gen.writeEndObject();
                                        //
                                        gen.writeFieldName('laPFDatosFiscales');
                                        gen.writeStartObject();
                                            if(req.LAH.pfisica.pOutLADFAddressId != null){
                                                gen.writeNumberField('laDFAddressId' , integer.valueOf(req.LAH.pfisica.pOutLADFAddressId));    
                                            }                                           
                                            gen.writeStringField('laDFRfcTin' , pasnull(req.LAH.pfisica.pOutLADFRfcTin));
                                            gen.writeStringField('laDFPais' , pasnull(req.LAH.pfisica.pOutLADFPais));
                                            gen.writeStringField('laDFCodigoPostal' , pasnull(req.LAH.pfisica.pOutLADFCodigoPostal));
                                            gen.writeStringField('laDFEstado' , pasnull(req.LAH.pfisica.pOutLADFEstado));
                                            gen.writeStringField('laDFCiudad' , pasnull(req.LAH.pfisica.pOutLADFCiudad));
                                            gen.writeStringField('laDFMunicipioAlcaldia' , pasnull(req.LAH.pfisica.pOutLADFMunicipioAlcaldia));
                                            gen.writeStringField('laDFColonia' , pasnull(req.LAH.pfisica.pOutLADFColonia));
                                            gen.writeStringField('laDFCalle' , pasnull(req.LAH.pfisica.pOutLADFCalle));
                                            gen.writeStringField('laDFNumExterior' , pasnull(req.LAH.pfisica.pOutLADFNumExterior));
                                            gen.writeStringField('laDFNumInterior' , pasnull(req.LAH.pfisica.pOutLADFNumInterior));
                                            gen.writeStringField('laDFCurp' , pasnull(req.LAH.pfisica.pOutLADFCurp));        
                                        gen.writeEndObject();
                                        //
                                        gen.writeFieldName('laPFBil');
                                        gen.writeStartObject();
                                         gen.writeStringField('laBBilId' , pasnull(req.LAH.pfisica.pOutLABBilId));
                                         gen.writeStringField('laBFechaRevision' , pasnull(req.LAH.pfisica.pOutLABFechaRevision));
                                         gen.writeStringField('laBIncidencias' , pasnull(req.LAH.pfisica.pOutLABIncidencias));
                                         gen.writeStringField('laBComentarios' , pasnull(req.LAH.pfisica.pOutLABComentarios));
                                        gen.writeEndObject();
                                        //                                                      
                                    gen.writeEndObject();
                                        }
                                    }
                                    
                                    
                                    
                                    

                                    //
                                gen.writeEndObject();
                    gen.writeEndObject();
                gen.writeEndObject();
        
            gen.writeEndObject();
            gen.writeStringField('laActiveFlag' , pasnull(req.pOutActiveFlag));
            gen.writeStringField('laCreatedBy' , pasnull(req.pOutCreatedBy));
            gen.writeStringField('laCreationDate' , pasnull(req.pOutCreationDate));
            gen.writeStringField('laLastUpdatedBy' , pasnull(req.pOutUpdatedBy));
            gen.writeStringField('laLastUpdateDate' , System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00')));
        gen.writeEndObject();
        
        String jsonS = gen.getAsString();
        system.debug('hola ' + jsonS);
        return jsonS;
    }
    public string Get_Post_General(ES2_WraperRequest req){
        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartObject();
            gen.writeFieldName('request');
            gen.writeStartObject();
                gen.writeFieldName('header');
                gen.writeStartObject();
                    gen.writeStringField('requestId' ,pasnull(req.pOutRequestId));
                gen.writeEndObject();
            gen.writeEndObject();
        gen.writeEndObject();
       
         String jsonS = gen.getAsString();
        System.debug('GetPostGeneral ' + jsonS);
        return jsonS;
    }
    public string postgeneral(string section,ES2_WraperRequest req){
        JSONGenerator gen = JSON.createGenerator(true);    
        gen.writeStartObject();
        
            gen.writeFieldName('request');
            gen.writeStartObject();
            
                gen.writeFieldName('header');
                gen.writeStartObject();
        
                    gen.writeStringField('requestId' ,pasnull(req.pOutRequestId));
                    gen.writeStringField('requestType' , pasnull(section));
                    gen.writeStringField('applicationCode' , 'SF');
                    gen.writeStringField('partyId' , pasnull(req.pOutPartyId));
                    gen.writeStringField('requestStatus' , pasnull(req.pOutRequestStatus));
                    gen.writeStringField('requestedBy' , pasnull(req.pOutRequestedBy));
                    gen.writeStringField('startDate' , pasnull(req.pOutStartDate));
                    gen.writeStringField('endDate' , pasnull(req.pOutEndDate));
                    gen.writeStringField('rootRequestId' , pasnull(req.pOutRootRequestId));
        			/*if(section == 'LEGAL ASSESSMENT'){
            			gen.writeStringField('assignedToPerson' , pasnull(req.pOutAssignedTo)); 
        			}else{*/
            			gen.writeStringField('assignedTo' , pasnull(req.pOutAssignedTo)); 
        			//}
                    gen.writeStringField('ndaType' , pasnull(req.pOutndaType));
                    gen.writeStringField('sourceAccountId' , pasnull(req.pOutSourceAccountId));
                    gen.writeStringField('sourceAccountName' , pasnull(req.pOutSourceAccountName));
                    gen.writeStringField('sourceTopParentId' , pasnull(req.pOutSourceTopParentId));
                    gen.writeStringField('sourceTopParentName' , pasnull(req.pOutsourceTopParentName));
                    gen.writeStringField('partyName' , pasnull(req.pOutPartyName));
                    gen.writeStringField('egPartyId' , pasnull(req.pOutEGPartyId));
                    gen.writeStringField('egPartyName' , pasnull(req.pOutEGPartyName));
                    gen.writeStringField('sourceOpId' , pasnull(req.pOutSourceOpId));
                    gen.writeStringField('sourceCAId' , pasnull(req.pOutSourceCAId));
                    gen.writeStringField('createdBy' , pasnull(req.pOutCreatedBy));
                    gen.writeStringField('assignedGroup' , pasnull(req.pOutAssignedGroup));
                    gen.writeStringField('assignedDate' , pasnull(req.pOutAssignedDate));
                    gen.writeStringField('activeFlag' , pasnull(req.pOutActiveFlag));
                    gen.writeStringField('creationDate' , pasnull(req.pOutCreationDate));
                    gen.writeStringField('updatedBy' , pasnull(req.pOutUpdatedBy));
                    gen.writeStringField('lastUpdateDate' , System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00')));
                    gen.writeStringField('solvedBy' , pasnull(req.pOutSolvedBy));
                    gen.writeStringField('solvedDate' , pasnull(req.pOutSolvedDate));
                    gen.writeStringField('finantialEntity' , pasnull(req.pOutFinantialEntity));
                    system.debug('aa y bb '+req.pOutsourceTopParentName+' '+req.pOutPartyName);
            gen.writeEndObject();
            gen.writeEndObject();
            gen.writeFieldName('detail');
                gen.writeStartObject();
                
                //switch on section {
        
                        gen.writeFieldName('amlCRR');
                        gen.writeStartObject();
                            gen.writeStringField('crr' , pasnull(req.amlObj.CRR));
                            gen.writeStringField('crrModificationDate' , pasnull(req.amlObj.CRRModificationDate));
                            gen.writeStringField('crrExpirationDate' , pasnull(req.amlObj.CRRExpirationDate));
                            gen.writeStringField('crrOverride' , pasnull(req.amlObj.CRROverride));
                            gen.writeStringField('crrSourceType' , pasnull(req.amlObj.CRRSourceType));
                            gen.writeStringField('crrComments' , pasnull(req.amlObj.CRR_Override_Comment));
                        gen.writeEndObject(); 
                        gen.writeFieldName('amlHit');
                        gen.writeStartObject();
                            gen.writeStringField('hitRFC' , pasnull(req.amlhitsObj.RFC));
                            gen.writeStringField('hitEntityName' , pasnull(req.amlhitsObj.EntityName));
                            gen.writeStringField('hitFlag' , pascheckbox2(req.amlhitsObj.Flag));
                            gen.writeStringField('hitUwStatus' , pasnull(req.amlhitsObj.UwStatus));
                            gen.writeStringField('hitUwComments' , pasnull(req.amlhitsObj.UwComments));
                            gen.writeStringField('hitAMLStatus' , pasnull(req.amlhitsObj.AMLStatus));
                            gen.writeStringField('hitAMLComments' , pasnull(req.amlhitsObj.AMLComments));
                            gen.writeStringField('hitAMLMaxPercent' , pasnull(req.amlhitsObj.AMLMaxPercent));
                        gen.writeEndObject(); 
                      
                    ///}
                    //when   'CREDIT_BUREAU' {
                        gen.writeFieldName('creditBureau');
                        gen.writeStartObject();
                            gen.writeStringField('cbTransactionId' , pasnull(req.CreditBureauObj.cbTransactionId));
                            gen.writeStringField('cbPartySiteID' , pasnull(req.CreditBureauObj.CBPartySiteID));
                            gen.writeStringField('cbLegalPartyId' , pasnull(req.CreditBureauObj.CBLegalPartyId));
                            gen.writeStringField('cbLegalPartyAlias' , pasnull(req.CreditBureauObj.CBLegalPartyAlias));
                            gen.writeStringField('cbRejectReason' , pasnull(req.CreditBureauObj.CBRejectReason));
                            gen.writeStringField('cbLetterFlag' , pasnull(req.CreditBureauObj.CBLetterFlag));
                            gen.writeStringField('cbrfc' , pasnull(req.CreditBureauObj.RFC));
                            gen.writeStringField('cbCustomerType' , pasnull(req.CreditBureauObj.cbCustomerType));
                            gen.writeStringField('cbName' , pasnull(req.CreditBureauObj.cbName ));
                            gen.writeStringField('cbSecondName' , pasnull(req.CreditBureauObj.cbSecondName));
                            gen.writeStringField('cbLastName' , pasnull(req.CreditBureauObj.cbLastName ));
                            gen.writeStringField('cbSecondLastName' , pasnull(req.CreditBureauObj.cbSecondLastName));
                            gen.writeStringField('cbAPIRequestor' , pasnull(req.CreditBureauObj.cbAPIRequestor));
                            gen.writeStringField('cbMunicipality', pasnull(req.CreditBureauObj.municipality));
                            gen.writeStringField('cbOutNum', pasnull(req.CreditBureauObj.outnum));
                            gen.writeStringField('cbIntNum' , pasnull(req.CreditBureauObj.intnum));
                            gen.writeStringField('cbcompanyName' , pasnull(req.CreditBureauObj.CompanyName));
                            gen.writeStringField('cbaddress' , pasnull(req.CreditBureauObj.Address));
                            gen.writeStringField('cbecEntity' , pasnull(req.CreditBureauObj.ECEntity));
        
                            if(req.CreditBureauObj.LetterSigningDate!=null)
                                    {
                                        gen.writeStringField('cbletterSigningDate' ,  req.CreditBureauObj.LetterSigningDate.format() );
                                    }
                            
                            //gen.writeStringField('cbletterSigningDate' , System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00')));
                            gen.writeStringField('cbletterSigningPlace' , pasnull(req.CreditBureauObj.LetterSigningPlace));
                            gen.writeStringField('cbalias' , pasnull(req.CreditBureauObj.Alias));
                            gen.writeStringField('cbstreetAndNumber' , pasnull(req.CreditBureauObj.Street ));
                            gen.writeStringField('cbsuburb' , pasnull(req.CreditBureauObj.Suburb));
                            gen.writeStringField('cbzipCode' , pasnull(req.CreditBureauObj.ZipCode));
                            gen.writeStringField('cbcity' , pasnull(req.CreditBureauObj.City));
                            gen.writeStringField('cbstate' , pasnull(req.CreditBureauObj.State));
                            gen.writeStringField('cbcountry' , pasnull(req.CreditBureauObj.Country));
                            gen.writeStringField('cbautorizationLetter' , pasnull(req.CreditBureauObj.AutorizationLetter));
                            gen.writeStringField('dummyFlag' , pasnull(req.CreditBureauObj.dummyFlag));
                        gen.writeEndObject(); 
                   // }
                    //when 'CREDIT_APPROVAL'
                    //{
                        
                       gen.writeFieldName('economicGroup');
                        gen.writeStartObject();
                            gen.writeStringField('egProposedName' , '');
                            gen.writeStringField('egPartyId' , '');
                            gen.writeStringField('egPartyName' , '');
                            gen.writeStringField('egSicId' , '');
                            gen.writeStringField('egSicDescription' , '');
                        gen.writeEndObject();  
                    //}
                   // when 'KYC_IND'
                    //{
                       gen.writeFieldName('kycInd');
                        gen.writeStartObject();
                            gen.writeStringField('kycIndName' , pasnull(req.kwypfObj.pOutKYCIndName));
                            gen.writeFieldName('datosGenerales');
                            gen.writeStartObject();
                            if(req.kwypfObj.datosObj.BirthDate!=null)
                            {
                               gen.writeStringField('kycIndGDBirthDate' , pasnull(req.kwypfObj.datosObj.BirthDate.format() )); 
                            }
                                
                                    

                                
                                gen.writeStringField('kycIndGDRFC' , pasnull(req.kwypfObj.datosObj.GDRFC));
                                gen.writeStringField('kycIndGDCURP' , pasnull(req.kwypfObj.datosObj.GDCURP));
                                gen.writeStringField('kycIndGDNacionalities' , pasnull(req.kwypfObj.datosObj.GDNacionalities));
                                gen.writeStringField('kycIndGDFEASerialNo' , pasnull(req.kwypfObj.datosObj.GDFEASerialNo));
                                gen.writeStringField('kycIndGDBirthCountry' , pasnull(req.kwypfObj.datosObj.GDBirthCountry));
                                gen.writeStringField('kycIndGDBirthState' , pasnull(req.kwypfObj.datosObj.GDBirthState));
                                gen.writeStringField('kycIndGDSex' , pasnull(req.kwypfObj.datosObj.GDSex));
                                gen.writeStringField('kycIndGDMarriageStatus' , pasnull(req.kwypfObj.datosObj.GDMarriageStatus));
                                gen.writeStringField('kycIndGDMarriageRegime' ,pasnull(req.kwypfObj.datosObj.GDMarriageRegime ));
                                gen.writeStringField('kycIndGDNameOfSpouse' , pasnull(req.kwypfObj.datosObj.GDNameOfSpouse));
                            gen.writeEndObject(); 
                            gen.writeFieldName('domicilioParticular');
                            gen.writeStartObject();
                                gen.writeStringField('kycIndAdrStreet' , pasnull(req.kwypfObj.dominioObj.pOutKYCIndAdrStreet));
                                gen.writeStringField('kycIndAdrOutNum' , pasnull(req.kwypfObj.dominioObj.pOutKYCIndAdrOutNum));
                                gen.writeStringField('kycIndAdrIntNum' , pasnull(req.kwypfObj.dominioObj.pOutKYCIndAdrIntNum));
                                gen.writeStringField('kycIndAdrCounty' , pasnull(req.kwypfObj.dominioObj.pOutKYCIndAdrCounty));
                                gen.writeStringField('kycIndAdrMunicipality' , pasnull(req.kwypfObj.dominioObj.pOutKYCIndAdrMunicipality));
                                gen.writeStringField('kycIndAdrCity' , pasnull(req.kwypfObj.dominioObj.pOutKYCIndAdrCity));
                                gen.writeStringField('kycIndAdrState' , pasnull(req.kwypfObj.dominioObj.pOutKYCIndAdrState));
                                gen.writeStringField('kycIndAdrCountry' , pasnull(req.kwypfObj.dominioObj.pOutKYCIndAdrCountry));
                                gen.writeStringField('kycIndIntAdrZipCode' , pasnull(req.kwypfObj.dominioObj.pOutKYCIndIntAdrZipCode));
                            gen.writeEndObject();
                            gen.writeFieldName('datosGralesEmpleo');
                            gen.writeStartObject();
                                gen.writeStringField('kycIndBizTitle' , pasnull(req.kwypfObj.datosgObj.pOutKYCIndBizTitle));
                                gen.writeStringField('kycIndBizRelatedPaties' , pasnull(req.kwypfObj.datosgObj.pOutKYCIndBizRelatedPaties));
                            gen.writeEndObject();
                            gen.writeFieldName('ppe');
                            gen.writeStartObject();
                                gen.writeStringField('kycIndPPEFlag' , pasnull(req.kwypfObj.ppeObj.pOutKYCIndPPEFlag));
                                gen.writeStringField('kycIndPPEJob' , pasnull(req.kwypfObj.ppeObj.pOutKYCIndPPEJob));
                                gen.writeStringField('kycIndPPEAFlag' , pasnull(req.kwypfObj.ppeObj.pOutKYCIndPPEAFlag));
                                gen.writeStringField('kycIndPPEAName' , pasnull(req.kwypfObj.ppeObj.pOutKYCIndPPEAName));
                                gen.writeStringField('kycIndPPEARelationship' , pasnull(req.kwypfObj.ppeObj.pOutKYCIndPPEARelationship));
                            gen.writeEndObject();
                            gen.writeFieldName('suscritoPor');
                            gen.writeStartObject();
                                gen.writeStringField('kycIndSignName' , pasnull(req.kwypfObj.suscritoObj.pOutKYCIndSignName));
                                gen.writeStringField('kycIndSignFlag' ,pascheckbox(pasnull(req.kwypfObj.suscritoObj.pOutKYCIndSignFlag)));
                                gen.writeStringField('kycIndSignPowerFlag' ,pascheckbox( pasnull(req.kwypfObj.suscritoObj.pOutKYCIndSignPowerFlag)));
                                gen.writeStringField('kycIndSignPublicDeedNum' , pasnull(req.kwypfObj.suscritoObj.pOutKYCIndSignPublicDeedNum));
                                    if(req.kwypfObj.suscritoObj.pOutKYCIndSignPublicDeedDate!=null)
                                    {
                                       gen.writeStringField('kycIndSignPublicDeedDate' , req.kwypfObj.suscritoObj.pOutKYCIndSignPublicDeedDate.format() ); 
                                    }
                                                                gen.writeStringField('kycIndSignNotaryName' , pasnull(req.kwypfObj.suscritoObj.pOutKYCIndSignNotaryName));
                                gen.writeStringField('kycIndSignNotaryNum' , pasnull(req.kwypfObj.suscritoObj.pOutKYCIndSignNotaryNum));
                                gen.writeStringField('kycIndSignNotaryState' , pasnull(req.kwypfObj.suscritoObj.pOutKYCIndSignNotaryState));
                                gen.writeStringField('kycIndSignDateDay' , pasnull(req.kwypfObj.suscritoObj.pOutKYCIndSignDateDay));
                                gen.writeStringField('kycIndSignDateMonth' , pasnull(req.kwypfObj.suscritoObj.pOutKYCIndSignDateMonth));
                                gen.writeStringField('kycIndSignDateYear' , pasnull(req.kwypfObj.suscritoObj.pOutKYCIndSignDateYear));
                            gen.writeEndObject();
                        gen.writeEndObject(); 
                    //}
                    //when 'KYC_ORG'
                    
                        
                        gen.writeFieldName('kycOrg');
                        gen.writeStartObject();
                            gen.writeStringField('kycOrgName' , pasnull(req.kwypmObj.pOutKYCOrgName));
                            gen.writeFieldName('datosGenerales');
                            gen.writeStartObject();
                                gen.writeStringField('kycOrgGDRFC' , pasnull(req.kwypmObj.datosgObj.GDRFC));
                                if(req.kwypmObj.datosgObj.BirthDate!=null)
                                {
                                    gen.writeStringField('kycOrgGDBirthDate' , req.kwypmObj.datosgObj.BirthDate.format() );
                                }
                                
                                gen.writeStringField('kycOrgGDNacionality' , pasnull(req.kwypmObj.datosgObj.kycOrgGDNacionality));
                                gen.writeStringField('kycOrgGDFEASerialNo' , pasnull(req.kwypmObj.datosgObj.GDFEASerialNo));
                                gen.writeStringField('kycOrgGDPhone' , pasnull(req.kwypmObj.datosgObj.GDPhone));
                                gen.writeStringField('kycOrgGDEmail' , pasnull(req.kwypmObj.datosgObj.GDEmail));
                                gen.writeStringField('kycOrgGDActivity' , pasnull(req.kwypmObj.datosgObj.GDActivity));
                            gen.writeEndObject(); 
                            gen.writeFieldName('domicilioParticular');
                            gen.writeStartObject();
                                gen.writeStringField('kycOrgAdrStreet' , pasnull(req.kwypmObj.domiciliopObj.kycOrgAdrStreet));
                                gen.writeStringField('kycOrgAdrOutNum' , pasnull(req.kwypmObj.domiciliopObj.kycOrgAdrOutNum));
                                gen.writeStringField('kycOrgAdrIntNum' , pasnull(req.kwypmObj.domiciliopObj.kycOrgAdrIntNum));
                                gen.writeStringField('kycOrgAdrCounty' , pasnull(req.kwypmObj.domiciliopObj.kycOrgAdrCounty));
                                gen.writeStringField('kycOrgAdrMunicipality' , pasnull(req.kwypmObj.domiciliopObj.kycOrgAdrMunicipality));
                                gen.writeStringField('kycOrgAdrCity' , pasnull(req.kwypmObj.domiciliopObj.kycOrgAdrCity));
                                gen.writeStringField('kycOrgAdrState' , pasnull(req.kwypmObj.domiciliopObj.kycOrgAdrState));
                                gen.writeStringField('kycOrgIntAdrCountry' , pasnull(req.kwypmObj.domiciliopObj.kycOrgIntAdrCountry));
                                gen.writeStringField('kycOrgIntAdrZipCode' , pasnull(req.kwypmObj.domiciliopObj.kycOrgIntAdrZipCode));
                            gen.writeEndObject();
                            gen.writeFieldName('actividadEconomica');
                            gen.writeStartObject();
                                gen.writeStringField('kycOrgActGovFlag' , pasnull(req.kwypmObj.actividadeObj.pOutKYCOrgActGovFlag));
                                gen.writeStringField('kycOrgActGovPartyName' , pasnull(req.kwypmObj.actividadeObj.pOutKYCOrgActGovPartyName));
                                gen.writeStringField('kycOrgActGovAnnualIncome' , pasnull(req.kwypmObj.actividadeObj.pOutKYCOrgActGovAnnualIncome));
                                gen.writeStringField('kycOrgActGovServices' , pasnull(req.kwypmObj.actividadeObj.pOutKYCOrgActGovServices));
                                gen.writeStringField('kycOrgActGovAge' , pasnull(req.kwypmObj.actividadeObj.pOutKYCOrgActGovAge));
                            gen.writeEndObject();
                            gen.writeStringField('kycOrgFinanceUse' , pasnull(req.kwypmObj.pOutKYCOrgFinanceUse));
                            gen.writeFieldName('mercadoGeografico');
                            gen.writeStartObject();
                                gen.writeStringField('kycOrgCorpSites' , pasnull(req.kwypmObj.mercadogObj.pOutKYCOrgCorpSites));
                                gen.writeStringField('kycOrgMktSites' , pasnull(req.kwypmObj.mercadogObj.pOutKYCOrgMktSites));
                            gen.writeEndObject();
                            gen.writeStringField('kycOrgBankPayeeName' , pasnull(req.kwypmObj.pOutKYCOrgBankPayeeName));
                            gen.writeFieldName('ppe');
                            gen.writeStartObject();
                                gen.writeStringField('kycOrgPPEFlag' , pasnull(req.kwypmObj.PPEObj.kycOrgPPEFlag));
                                gen.writeStringField('kycOrgPPEJob' , pasnull(req.kwypmObj.PPEObj.kycOrgPPEJob));
                                gen.writeStringField('kycOrgPPEName' , pasnull(req.kwypmObj.PPEObj.kycOrgPPEName));
                                gen.writeStringField('kycOrgPPEAName' , pasnull(req.kwypmObj.PPEObj.kycOrgPPEAName));
                                gen.writeStringField('kycOrgPPEARelationship' , pasnull(req.kwypmObj.PPEObj.kycOrgPPEARelationship));
                                gen.writeStringField('kycOrgPPEABoardJob' , pasnull(req.kwypmObj.PPEObj.pOutKYCOrgPPEABoardJob));
                                gen.writeStringField('kycOrgPPEABoardName' , pasnull(req.kwypmObj.PPEObj.pOutKYCOrgPPEABoardName));
                                gen.writeStringField('kycOrgPPEAName2' , pasnull(req.kwypmObj.PPEObj.pOutKYCOrgPPEAName2));
                                gen.writeStringField('kycOrgPPEARelationship2' , pasnull(req.kwypmObj.PPEObj.pOutKYCOrgPPEARelationship2));
                            gen.writeEndObject();
                                gen.writeStringField('kycOrgPartnerOrgName' , pasnull(req.kwypmObj.pOutKYCOrgPartnerOrgName));
                                gen.writeStringField('kycOrgTrustOrgName' , pasnull(req.kwypmObj.pOutKYCOrgTrustOrgName));
                                gen.writeStringField('kycOrgBizManagedBy' , pasnull(req.kwypmObj.pOutKYCOrgBizManagedBy));
                                gen.writeStringField('kycOrgCorpName' , pasnull(req.kwypmObj.pOutKYCOrgCorpName));
                            gen.writeFieldName('certificacionRepresentanteLegal');
                            gen.writeStartObject();
                                gen.writeStringField('kycOrgSignName' , pasnull(req.kwypmObj.cerificadoL.pOutKYCOrgSignName));
                                gen.writeStringField('kycOrgSignJob' , pasnull(req.kwypmObj.cerificadoL.pOutKYCOrgSignJob));
                            gen.writeStringField('kycOrgSignPublicDeedNum' , pasnull(req.kwypmObj.cerificadoL.pOutKYCOrgSignPublicDeedNum));
                            if(req.kwypmObj.cerificadoL.pOutKYCOrgSignPublicDeedDate!=null)
                            {
                                gen.writeStringField('kycOrgSignPublicDeedDate' , req.kwypmObj.cerificadoL.pOutKYCOrgSignPublicDeedDate.format() ); 
                            }
                                
                            
                            gen.writeStringField('kycOrgSignNotaryName' ,  pasnull(req.kwypmObj.cerificadoL.pOutKYCOrgSignNotaryName));
                            gen.writeStringField('kycOrgSignNotaryNum' , pasnull(req.kwypmObj.cerificadoL.pOutKYCOrgSignNotaryNum));
                            gen.writeStringField('kycOrgSignNotaryState' , pasnull(req.kwypmObj.cerificadoL.pOutKYCOrgSignNotaryState));
                            gen.writeStringField('kycOrgSignDateDay' , pasnull(req.kwypmObj.cerificadoL.pOutKYCOrgSignDateDay));
                            gen.writeStringField('kycOrgSignDateMonth' , pasnull(req.kwypmObj.cerificadoL.pOutKYCOrgSignDateMonth));
                            gen.writeStringField('kycOrgSignDateYear' , pasnull(req.kwypmObj.cerificadoL.pOutKYCOrgSignDateYear));
                            gen.writeEndObject();
                        gen.writeEndObject();
        
                        gen.writeFieldName('eval');
                            gen.writeStartObject();
                                gen.writeFieldName('evalHeader');
                                    gen.writeStartObject();
                                        gen.writeStringField('evEvalType' , pasnull(req.EVALOBJ.pOutEVEVALType));
                                        gen.writeStringField('evInsuranceReqFlag' , pasnull(req.EVALOBJ.pOutEVInsuranceReqFlag));
                                        gen.writeStringField('evEfaReqFlag' , pasnull(req.EVALOBJ.pOutEVEFAReqFlag));
                                        gen.writeStringField('evSlbFlag' , pasnull(req.EVALOBJ.pOutEVSLBFlag));
                                        gen.writeStringField('evImportsReqFlag' , pasnull(req.EVALOBJ.pOutEVImportsReqFlag));
                                        gen.writeStringField('evProgressPayFlag' , pasnull(req.EVALOBJ.pOutEVProgressPayFlag));
                                        gen.writeStringField('evShowFMVFlag' , pasnull(req.EVALOBJ.pOutEVShowFMVFlag));
                                        gen.writeStringField('evFreezeEvalFlag' , pasnull(req.EVALOBJ.pOutEVFreezeEvalFlag));
                                        gen.writeStringField('evFreezeStartDate' , pasnull(req.EVALOBJ.pOutEVFreezeStartDate));
                                        gen.writeStringField('evFreezeEndDate' , pasnull(req.EVALOBJ.OutEVFreezeEndDate));
                                        gen.writeStringField('evProgressPayTermMonths' , pasnull(req.EVALOBJ.pOutEVProgressPayTermMonths));
                                        gen.writeStringField('evEquipmentAmount' , pasnull(req.EVALOBJ.pOutEVEquipmentAmount));
                                        gen.writeStringField('evEquipmentAmountTax' , pasnull(req.EVALOBJ.pOutEVEquipmentAmountTax));
                                        gen.writeStringField('evEquipmentAmountPercent' , pasnull(req.EVALOBJ.pOutEVEquipmentAmountPercent));
                                        gen.writeStringField('evCostAmount' , pasnull(req.EVALOBJ.pOutEVCostAmount));
                                        gen.writeStringField('evCostAmountTax' , pasnull(req.EVALOBJ.pOutEVCostAmountTax));
                                        gen.writeStringField('evCostAmountPercent' , pasnull(req.EVALOBJ.pOutEVCostAmountPercent));
                                        gen.writeStringField('evCurrencyType' , pasnull(req.EVALOBJ.pOutEVCurrencyType));
                                        gen.writeStringField('evExchangeRate' , pasnull(req.EVALOBJ.pOutEVExchangeRate));
                                        gen.writeStringField('evAssetCount' , pasnull(req.EVALOBJ.pOutEVAssetCount));
                                        gen.writeStringField('evProductType' , pasnull(req.EVALOBJ.pOutEVProductType));
                                        gen.writeStringField('evResidualMaxTermMonths' , pasnull(req.EVALOBJ.pOutEVResidualMaxTermMonths));
                                        gen.writeStringField('evSpecialTermMonths01' , pasnull(req.EVALOBJ.pOutEVSpecialTermMonths01));
                                        gen.writeStringField('evSpecialTermMonths02' , pasnull(req.EVALOBJ.pOutEVSpecialTermMonths02));
                                        gen.writeStringField('evSpecialTermMonths03' , pasnull(req.EVALOBJ.pOutEVSpecialTermMonths03));
                                        gen.writeStringField('evEndorsementComment' , pasnull(req.EVALOBJ.pOutEVEndorsementComment));
                                    gen.writeEndObject();
                            gen.writeEndObject();
                        
                    //}
                    //when 'Sic Code(no aplica)'
                    //{
                        
                        gen.writeFieldName('sicCode');
                            gen.writeStartObject();
                                gen.writeStringField('sicProposedId' , pasnull(req.sic.pOutSicProposedId));
                                gen.writeStringField('sicProposedDescription' , pasnull(req.sic.pOutSicProposedDescription));
                                gen.writeStringField('sicId' , pasnull(req.sic.pOutSicId));
                                gen.writeStringField('sicDescription' , pasnull(req.sic.pOutSicDescription));
                            gen.writeEndObject();
                    //}
                //}            
                gen.writeStringField('laActiveFlag' , pasnull(req.pOutActiveFlag));
                gen.writeStringField('laCreatedBy' , pasnull(req.pOutCreatedBy));
                gen.writeStringField('laCreationDate' , pasnull(req.pOutCreationDate));
                gen.writeStringField('laLastUpdatedBy' , pasnull(req.sic.pOutSicId));
                gen.writeStringField('laLastUpdateDate' , System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00')));
                gen.writeEndObject();
        gen.writeEndObject();
        system.debug('GEN OEJ ' + gen);
        String jsonS = gen.getAsString();
        
        system.debug('hola ' + jsonS);
        return jsonS;
    }

}