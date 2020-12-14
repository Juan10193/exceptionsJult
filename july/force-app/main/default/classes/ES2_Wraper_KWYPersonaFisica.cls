public class ES2_Wraper_KWYPersonaFisica {
    public string pOutKYCIndName {get; set;}  
//Datos Generales    
    public ES2_wraper_datos_generales datosObj {get; set;}
//Domicilio particular de residencia    
    public ES2_wraper_DomicilioParticular dominioObj {get; set;} 
//Datos generales de su empleo u ocupación principal    
    public ES2_wraper_datosGralesEmpleo datosgObj{get; set;}
//Personas Políticamente Expuestas    
    public ES2_wraper_PPE ppeObj {get; set;}
//Formato  
    public list<ES2_wraper_proveedorRecurso> provedorObj {get; set;}
    public ES2_wraper_suscritopor suscritoObj {get;set;}
    PUBLIC ES2_Wraper_KWYPersonaFisica()
    {
        datosObj = NEW ES2_wraper_datos_generales();
        dominioObj = NEW ES2_wraper_DomicilioParticular();
        datosgObj = NEW ES2_wraper_datosGralesEmpleo();
        ppeObj = NEW ES2_wraper_PPE();
        provedorObj = NEW list<ES2_wraper_proveedorRecurso>();
        suscritoObj = NEW ES2_wraper_suscritopor();
        
    }
}