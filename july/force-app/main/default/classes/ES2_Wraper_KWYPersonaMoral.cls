public class ES2_Wraper_KWYPersonaMoral {
    public string pOutKYCOrgName {get;set;}
    
//Datos Generales

    public ES2_wraper_datos_generales datosgObj {get; set;}
    
    
////domicilioParticular    
    public ES2_wraper_DomicilioParticular domiciliopObj {get; set;}
    
//Actividad Económica
    public ES2_wraper_actividadeconomica actividadeObj {get; set;}
    
//Uso del financiamiento solicitado
    public string pOutKYCOrgFinanceUse {get;set;}
    
//Mercados geográficos
    public ES2_wraper_mercadografico mercadogObj {get; set;}    
//Cuentas bancarias
    public list<ES2_wraper_cuentasbancarias> cuentas {get; set;}
//Personas Políticamente Expuestas
    
    public string pOutKYCOrgBankPayeeName {get;set;}
    public ES2_wraper_PPE PPEObj {get; set;}
    
    //tablaProveedoresRecursos
    public list<ES2_wraper_proveedoresRecursos> proveedores {get; set;}
    
    
    //tablaComposicionCapSocial
    public list<ES2_wraper_composicionsocial> composicion {get; set;}
    
    //
    public string pOutKYCOrgPartnerOrgName {get;set;}
    
    //tablaAccSociosPM
    public list<ES2_wraper_accionistaspm> accionistas {get; set;}
    
    
    public string pOutKYCOrgTrustOrgName {get;set;}
    
    //tablaAccSociosFideicomisos
    public list<ES2_wraper_sociosfideicomisos> fideicomisos {get;set;}
    
    //tablaAccSociosPF
    public list<ES2_wraper_sociosPF> sociosPF {get; set;}
    
    
    public string pOutKYCOrgBizManagedBy {get;set;}	
    
    
    //tablaSocAdminPor
    public list <ES2_Wraper_socioAdminPor>SocioAdmin {get;set;}
    
    //tablaFuncionariosPrincipales
    public list<ES2_wraper_funcionariosPrincipales> funcionarios {get;set;}
    
    
//Grupo Empresarial o Consorcio
    public string pOutKYCOrgCorpName {get;set;}
    //tablaGrupoEmpresarial
    public list<ES2_wraper_grupoEmpresarial> grupoE {get; set;}
    
//Certificación del representante legal
    public ES2_wraper_certificadorepresentantelegal cerificadoL {get; set;}
    
    PUBLIC ES2_Wraper_KWYPersonaMoral(){
        datosgObj = new ES2_wraper_datos_generales();
        domiciliopObj = new ES2_wraper_DomicilioParticular();
		actividadeObj = new  ES2_wraper_actividadeconomica();
        mercadogObj = new ES2_wraper_mercadografico(); 
        cuentas = new list<ES2_wraper_cuentasbancarias>();
        PPEObj = new ES2_wraper_PPE();
        proveedores = new  list<ES2_wraper_proveedoresRecursos>();
        composicion = new list<ES2_wraper_composicionsocial>();
        accionistas = new list<ES2_wraper_accionistaspm>();
        fideicomisos = new list<ES2_wraper_sociosfideicomisos>();
        sociosPF = new list<ES2_wraper_sociosPF>();
        SocioAdmin = new list <ES2_Wraper_socioAdminPor>();
        funcionarios = new list<ES2_wraper_funcionariosPrincipales>();
        grupoE = new list<ES2_wraper_grupoEmpresarial>();
        cerificadoL = new ES2_wraper_certificadorepresentantelegal();
    }
}