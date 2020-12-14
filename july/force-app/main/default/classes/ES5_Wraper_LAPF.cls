public class ES5_Wraper_LAPF {
    //datosGenerales
    public string pOutLAPFDGNombre {get;set;}
    public string pOutLAPFDGFechadenacimiento {get;set;}
    public string pOutLAPFDGLugardenacimiento {get;set;}
    public string pOutLAPFDGEstadoCivil {get;set;}
    public string pOutLAPFDGVigenciaId {get;set;}
    public string pOutLAPFDGComentarios {get;set;} 
    //domicilioSocial
    public string pOutLADSAddressID {get;set;}
    public string pOutLADSPais {get;set;}
    public string pOutLADSCodigoPostal {get;set;}
    public string pOutLADSEstado {get;set;}
    public string pOutLADSCiudad {get;set;}
    public string pOutLADSMunicipioAlcaldia {get;set;}    
    public string pOutLADSColonia {get; set;}
    public string pOutLADSCalle {get; set;}
    public string pOutLADSNumExterior {get; set;}
    public string pOutLADSNumInterior {get; set;}
    //comprobanteDomicilio
    public string pOutLACDAddressId {get; set;}
    public string pOutLACDPais {get; set;}
    public string pOutLACDCodigoPostal {get; set;}
    public string pOutLAMCDEstado {get; set;}
    public string pOutLACDCiudad {get; set;}
    public string pOutLACDMunicipioAlcaldia {get; set;}
    public string pOutLACDColonia {get; set;}
    public string pOutLACDCalle {get; set;}
    public string pOutLACDNumExterior {get; set;}
    public string pOutLACDNumInterior {get; set;}
    //laPFDatosFiscales
    public string pOutLADFAddressId {get; set;}
    public string pOutLADFRfcTin {get; set;}
    public string pOutLADFPais {get; set;}
    public string pOutLADFCodigoPostal {get; set;}
    public string pOutLADFEstado {get; set;}
    public string pOutLADFCiudad {get; set;}
    public string pOutLADFMunicipioAlcaldia {get; set;}
    public string pOutLADFColonia {get; set;}
    public string pOutLADFCalle {get; set;}
    public string pOutLADFNumExterior {get; set;}
    public string pOutLADFNumInterior {get; set;}
    public string pOutLADFW8W9 {get; set;}
    public string pOutLADFCurp {get; set;}
    //laPFBIL
    public string pOutLABBilId {get; set;}
    public string pOutLABFechaRevision {get; set;}
    public string pOutLABIncidencias {get; set;}
    public string pOutLABComentarios {get; set;}
    public list<ES5_wraper_LA_apoderados> apoderados{get;set;}
}