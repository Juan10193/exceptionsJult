public class ES5_Wraper_LAPM {
    
    
    //acta constritutiva
    
    public string pOutLAMACDocumentID {get;set;}
    public string pOutLAMACDenomconstituirse {get;set;}
    public string pOutLAMACEscrituraNo {get;set;}
    public string pOutLAMACFechaEscritura {get;set;}
    public string pOutLAMACDuracion {get;set;}
    public string pOutLAMACClausulaExtranjero {get;set;}
    public string pOutLAMACFedatarioPublico {get;set;}
    public string pOutLAMACFechaRegistro {get;set;}
    public string pOutLAMACLugarRegistro {get;set;}
    public string pOutLAMACDatosRegistro {get;set;}
    public string pOutLAMACObservaciones {get;set;}
    //domicilio social
    public string pOutLAMDSAddressID {get;set;}
    public string pOutLAMDSPais {get;set;}
    public string pOutLAMDSCodigoPostal {get;set;}
    public string pOutLAMDSEstado {get;set;}
    public string pOutLAMDSCiudad {get;set;}
    public string pOutLAMDSMunicipioAlcaldia {get;set;}
    public string pOutLAMDSColonia {get;set;}
    public string pOutLAMDSCalle {get;set;}
    public string pOutLAMDSNoExterior {get;set;}
    public string pOutLAMDSNoInterior {get;set;}
    //objeto social
    public string pOutLAMOSPurposeID {get;set;}
    public string pOutLAMOSDocumentID {get;set;}
    public string pOutLAMOSEscritura {get;set;}
    public string pOutLAMOSAutorizadoArrendar {get;set;}
    public string pOutLAMOSAutSuscTItulosCredit {get;set;}
    public string pOutLAMOSAutorizadoGarantizar {get;set;}
    public string pOutLAMOSFiador {get;set;}
    public string pOutLAMOSAval {get;set;}
    public string pOutLAMOSObservaciones {get;set;}
    public string pOutLAMOSObligadoSolidario {get;set;}
    public string pOutLAMOSGarantObligTerceros {get;set;}
    public string pOutLAMOSLimitanteObjetoSoc {get;set;}
    //comprobante domicilario
    public string pOutLAMCDAddressID {get;set;}
    public string pOutLAMCDPais {get;set;}
    public string pOutLAMCDCodigoPostal {get;set;}
    public string pOutLAMCDEstado {get;set;}
    public string pOutLAMCDCiudad {get;set;}
    public string pOutLAMCDMunicipioAlcaldia {get;set;}
    public string pOutLAMCDColonia {get;set;}
    public string pOutLAMCDCalle {get;set;}
    public string pOutLAMCDNoExterior {get;set;}
    public string pOutLAMCDNoInterior {get;set;}
    //datos fiscales
    public string pOutLAMDFAddressID {get;set;}
    public string pOutLAMDFRFC {get;set;}
    public string pOutLAMDFPais {get;set;}
    public string pOutLAMDFCodigoPostal {get;set;}
    public string pOutLAMDFEstado {get;set;}
    public string pOutLAMDFCiudad {get;set;}
    public string pOutLAMDFMunicipioAlcaldia {get;set;}
    public string pOutLAMDFColonia {get;set;}
    public string pOutLAMDFCalle {get;set;}
    public string pOutLAMDFNoExterior {get;set;}
    public string pOutLAMDFNoInterior {get;set;}
    //laPFBIL
    public string pOutLAMBBilId {get; set;}
    public string pOutLAMBFechaRevision {get; set;}
    public string pOutLAMBIncidencias {get; set;}
    public string pOutLAMBComentarios {get; set;}
    public list<ES5_wraper_LA_limitante> limitantes {get; set;}
    public List<ES5_wraper_LA_modificacion> modificaciones {get; set;}
    public list<ES5_wraper_LA_apoderados> apoderados{get;set;}
    
}