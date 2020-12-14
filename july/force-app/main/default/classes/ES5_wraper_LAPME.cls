public class ES5_wraper_LAPME {
    //acta constituida
    public string pOutLAPMEACDocumentID {get;set;}
    public string pOutLAPMEACDenomconstituirse {get;set;}
    public string pOutLAPMEACEscrituraNum {get;set;}
    public string pOutLAPMEACFechaEscritura {get;set;}
    public string pOutLAPMEACDuracion {get;set;}
    public string pOutLAPMEACObservaciones {get;set;}
    //domicilio social
    public string pOutLAPMEDSAddressID {get;set;}
    public string pOutLAPMEDSPais {get;set;}
    public string pOutLAPMEDSCodigoPostal {get;set;}
    public string pOutLAPMEDSEstado {get;set;}
    public string pOutLAPMEDSCiudad {get;set;}
    public string pOutLAPMEDSMunicipioAlcaldia {get;set;}
    public string pOutLAPMEDSColonia {get;set;}
    public string pOutLAPMEDSCalle {get;set;}
    public string pOutLAPMEDSNoExterior {get;set;}
    public string pOutLAPMEDSNoInterior {get;set;}
    //comprobante domiciliario
    public string pOutLAPMECDAddressID {get;set;}
    public string pOutLAPMECDPais {get;set;}
    public string pOutLAPMECDCodigoPostal {get;set;}
    public string pOutLAPMECDEstado {get;set;}
    public string pOutLAPMECDCiudad {get;set;}
    public string pOutLAPMECDMunicipioAlcaldia {get;set;}
    public string pOutLAPMECDColonia {get;set;}
    public string pOutLAPMECDCalle {get;set;}
    public string pOutLAPMECDNoExterior {get;set;}
    public string pOutLAPMECDNoInterior {get;set;}
    //datos fiscales
    public string pOutLAPMEDFAddressID {get;set;}
    public string pOutLAPMEDFTIN {get;set;}
    public string pOutLAPMEDFPais {get;set;}
    public string pOutLAPMEDFCodigoPostal {get;set;}
    public string pOutLAPMEDFEstado {get;set;}
    public string pOutLAPMEDFCiudad {get;set;}
    public string pOutLAPMEDFMunicipioAlcaldia {get;set;}
    public string pOutLAPMEDFColonia {get;set;}
    public string pOutLAPMEDFCalle {get;set;}
    public string pOutLAPMEDFNoExterior {get;set;}
    public string pOutLAPMEDFNoInterior {get;set;}
    public string pOutLAPMEDFW8W9 {get;set;}
    //laPFBIL
    public string pOutLAPMEBBilId {get; set;}
    public string pOutLAPMEBFechaRevision {get; set;}
    public string pOutLAPMEBIncidencias {get; set;}
    public string pOutLAPMEBComentarios {get; set;}
    public list<ES5_wraper_LA_Estatutos> estatutos{get; set;}
    public list<ES5_wraper_LA_apoderados> apoderados{get;set;}
}