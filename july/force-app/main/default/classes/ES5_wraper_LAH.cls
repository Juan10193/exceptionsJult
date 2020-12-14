public class ES5_wraper_LAH {
    
        //Inicio modificaciones para ES5
    public string pOutlaType				{get;set;}//
    public String pOutValidThrough			{get;set;}
    public String pOutEntidad				{get;set;}
    public String pOutnacionalidad			{get;set;}//
    public String pOutRFC					{get;set;}//
    public String pOutNoCuenta				{get;set;}//
    public String pOutEntidadtype			{get;set;}//
    public String pOutEConomicgroup			{get;set;}//
    public String pOutTaxRegime				{get;set;}//
    public String pOutcurp					{get;set;}//
    public string pOutCustomerName 			{get;set;}//
    //Fin modificaciones para ES5 

    public ES5_Wraper_LAPF pfisica {get;set;}
    public ES5_Wraper_LAPM pmoral {get;set;}
    public ES5_wraper_LAPME pmoralExtranjera{get;set;}
    
    public ES5_wraper_LAH(){
        pfisica = new ES5_Wraper_LAPF();
        pmoral = new ES5_Wraper_LAPM();
        pmoralExtranjera = new ES5_wraper_LAPME();
    }
    
}