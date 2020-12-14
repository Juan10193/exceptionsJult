public class WS_ParametricoREST_Helper {
  public Parametrico parametrico                                                                  {get;set;}


  public WS_ParametricoREST_Helper (id opportunityId, Opportunity opp, Opportunity ooplabels){
    integer cotizaciones = Data_Acess_EC_Quote.getQuotesByOpId(String.valueOf(opportunityId)).size();
    Parametrico parametric = new Parametrico();
    GeneralInformation infogeneral = new GeneralInformation();
    Caracter caracter = new Caracter();
    parametric.caracter = caracter;
    ContinuidadDeNegocio contneg = new ContinuidadDeNegocio();
    parametric.continuidadDeNegocio = contneg;
    DesempenoFinanciero desempFinan = new DesempenoFinanciero();
    parametric.desempenoFinanciero = desempFinan;
    Estructura estructura = new Estructura();
    parametric.Estructura = estructura;


    parametric.generalInformation = infogeneral;
    parametric.generalInformation.nombreDeLaOpportunidad = opp.Name;
    parametric.generalInformation.cotizaciones = cotizaciones;
    parametric.generalInformation.montoApagar =opp.Amount;
    parametric.generalInformation.moneda = opp.CurrencyIsoCode;
    parametric.generalInformation.cuentaName = opp.Account.Name;
    parametric.generalInformation.cuentaId = opp.AccountId;
    parametric.caracter.buroDeCreditoRepresentativoLabel = ooplabels.LMM_ls_BurodeCrditoRepresentativo__c;
    parametric.caracter.buroDeCreditoRepresentativoValue = Integer.valueOf(opp.LMM_ls_BurodeCrditoRepresentativo__c);
    parametric.caracter.experienciaCnPrincipClientsLabel = ooplabels.LMM_ls_ExpConClientesPrinc__c;
    parametric.caracter.experienciaCnPrincipClientsValue = Integer.valueOf(opp.LMM_ls_ExpConClientesPrinc__c);
    parametric.caracter.buroLegalValue = Integer.valueOf(opp.LMM_ls_Bur_Legal__c);
    parametric.caracter.buroLegealLabel = ooplabels.LMM_ls_Bur_Legal__c;
    parametric.caracter.buroAvalLabel = ooplabels.LMM_ls_BurdeCrditoAval__c;
    parametric.caracter.buroAvalValue = Integer.valueOf(opp.LMM_ls_BurdeCrditoAval__c);
    parametric.continuidadDeNegocio.aNiosEnelNegocioLabel = ooplabels.LMM_ls_Anosenelnegocio__c;
    parametric.continuidadDeNegocio.aNiosEnelNegocioValue =integer.valueOf(opp.LMM_ls_Anosenelnegocio__c);
    parametric.continuidadDeNegocio.concentracionEnClientesLabel = ooplabels.LMM_ConcentracinenClientes__c;
    parametric.continuidadDeNegocio.concentracionEnClientesValue = integer.valueOf(opp.LMM_ConcentracinenClientes__c);
    parametric.continuidadDeNegocio.riesgoIndustriaLabel = ooplabels.LMM_ls_Industria__c;
    parametric.continuidadDeNegocio.riesgoIndustriaValue = integer.valueOf(opp.LMM_ls_Industria__c);
    parametric.desempenoFinanciero.diasDeArValue = Integer.valueOf(opp.LM_ls_D_as_de_AR__c);
    parametric.desempenoFinanciero.diasDeArLabel = ooplabels.LM_ls_D_as_de_AR__c;
    parametric.desempenoFinanciero.totaldebVSEBITDAValue = Integer.valueOf(opp.LMM_ls_TotaldebtVSEBITDA__c);
    parametric.desempenoFinanciero.totaldebVSEBITDALabel = ooplabels.LMM_ls_TotaldebtVSEBITDA__c;
    parametric.desempenoFinanciero.tamanoDelDealValue = integer.valueOf(opp.LMM_ls_Tama_o_del_Deal__c);
    parametric.desempenoFinanciero.tamanoDelDealLabel = ooplabels.LMM_ls_Tama_o_del_Deal__c;
    parametric.desempenoFinanciero.fccrValue = Integer.valueOf(opp.LMM_ls_FCCR__c);
    parametric.desempenoFinanciero.fccrLabel = ooplabels.LMM_ls_FCCR__c;
    parametric.Estructura.ltvAdvancedPaymentOSdValue = Integer.valueOf(opp.LMM_ls_LTVAdvancePaymentSD__c);
    parametric.Estructura.ltvAdvancedPaymentOSdLabel =ooplabels.LMM_ls_LTVAdvancePaymentSD__c;
    parametric.Estructura.garantiasAdicionalesValue = Integer.valueOf(opp.LMM_ls_Garant_as_Adicionales__c);
    parametric.Estructura.garantiasAdicionalesLabel = ooplabels.LMM_ls_Garant_as_Adicionales__c;
    parametric.Estructura.activoAltamenteMonetizableValue = Integer.valueOf(opp.LM_ls_Activaltamentemonetiz__c);
    parametric.Estructura.activoAltamenteMonetizableLabel = ooplabels.LM_ls_Activaltamentemonetiz__c;
    parametric.Estructura.collateralGAPValue = Integer.valueOf(opp.LMM_ls_Collateral_Gap__c);
    parametric.Estructura.collateralGAPLabel = ooplabels.LMM_ls_Collateral_Gap__c;

  
    this.parametrico = parametric;
    parametrico.caracter.puntosCaracter = getPuntosCaracter();
    parametrico.continuidadDeNegocio.puntosContinuidadNeg = getPuntosContinuidad();
    parametrico.desempenoFinanciero.puntosContinuidadNeg = getPuntosDesempenoF();
    parametrico.Estructura.puntosEstructura =getEstructuraPoints();
    parametrico.primarios = getprimarios();
    parametrico.enhancer = getEstructuraPoints();
    parametrico.total = gettotalPoints();
    parametrico.resultado = getResultado();
    
  }


  public class Parametrico{
    public GeneralInformation  generalInformation                                                 {get;set;}
    public Caracter            caracter                                                           {get;set;}
    public ContinuidadDeNegocio continuidadDeNegocio                                              {get;set;}
    public DesempenoFinanciero  desempenoFinanciero                                               {get;set;}
    public Estructura          Estructura                                                         {get;set;}
    public integer            primarios                                                           {get;set;}
    public integer enhancer                                                                       {get;set;}
    public integer            total                                                               {get;set;}
    public string  resultado                                                                      {get;set;}
    public string  riesgo                                                                         {get;set;}
  }

  public class GeneralInformation{
    public string nombreDeLaOpportunidad                                                          {get;set;}
    public integer cotizaciones                                                                   {get;set;}
    public decimal montoApagar                                                                    {get;set;}
    public string  cuentaName                                                                     {get;set;}
    public id cuentaId                                                                            {get;set;}
    public string moneda                                                                          {get;set;}
  }

  public class Caracter{
    public string buroDeCreditoRepresentativoLabel                                                {get;set;}
    public integer buroDeCreditoRepresentativoValue                                               {get;set;}
    public string buroLegealLabel                                                                 {get;set;}
    public integer buroLegalValue                                                                 {get;set;}
    public string buroAvalLabel                                                                   {get;set;}
    public integer buroAvalValue                                                                  {get;set;}
    public string experienciaCnPrincipClientsLabel                                                {get;set;}
    public integer experienciaCnPrincipClientsValue                                               {get;set;}
    public integer puntosCaracter                                                                 {get;set;}
  }

  public class ContinuidadDeNegocio{
    public string aNiosEnelNegocioLabel                                                           {get;set;}
    public integer aNiosEnelNegocioValue                                                          {get;set;}
    public string concentracionEnClientesLabel                                                    {get;set;}
    public integer concentracionEnClientesValue                                                   {get;set;}
    public string riesgoIndustriaLabel                                                            {get;set;}
    public integer riesgoIndustriaValue                                                           {get;set;}
    public integer puntosContinuidadNeg                                                           {get;set;}
  }

  public class DesempenoFinanciero{
    public string diasDeArLabel                                                                   {get;set;}
    public integer diasDeArValue                                                                  {get;set;}
    public string tamanoDelDealLabel                                                              {get;set;}
    public integer tamanoDelDealValue                                                             {get;set;}
    public string fccrLabel                                                                       {get;set;}
    public integer fccrValue                                                                      {get;set;}
    public string totaldebVSEBITDALabel                                                           {get;set;}
    public integer totaldebVSEBITDAValue                                                          {get;set;}
    public integer puntosContinuidadNeg                                                           {get;set;}
  }

  public class Estructura{
    public string ltvAdvancedPaymentOSdLabel                                                      {get;set;}
    public integer ltvAdvancedPaymentOSdValue                                                     {get;set;}
    public string activoAltamenteMonetizableLabel                                                 {get;set;}
    public integer activoAltamenteMonetizableValue                                                {get;set;}
    public string collateralGAPLabel                                                              {get;set;}
    public integer collateralGAPValue                                                             {get;set;}
    public string garantiasAdicionalesLabel                                                       {get;set;}
    public integer garantiasAdicionalesValue                                                      {get;set;}
    public integer puntosEstructura                                                               {get;set;}
  }

  private integer getPuntosCaracter(){
    integer buroCreditoRepresent = this.parametrico.caracter.buroDeCreditoRepresentativoValue == null?0:this.parametrico.caracter.buroDeCreditoRepresentativoValue;
    integer buroLgeal = this.parametrico.caracter.buroLegalValue == null?0:this.parametrico.caracter.buroLegalValue;
    integer buroAval = this.parametrico.caracter.buroAvalValue == null?0:this.parametrico.caracter.buroAvalValue;
    integer expClientes = this.parametrico.caracter.experienciaCnPrincipClientsValue == null?0:this.parametrico.caracter.experienciaCnPrincipClientsValue;
    integer puntos = buroCreditoRepresent + buroLgeal + buroAval + expClientes;
    return puntos;
  }

  private integer getPuntosContinuidad(){
   integer anosNegocio = this.parametrico.continuidadDeNegocio.aNiosEnelNegocioValue ==null?0:this.parametrico.continuidadDeNegocio.aNiosEnelNegocioValue;
   integer concentEnClientes = this.parametrico.continuidadDeNegocio.concentracionEnClientesValue ==null?0:this.parametrico.continuidadDeNegocio.concentracionEnClientesValue;
   integer riesgoIndustria = this.parametrico.continuidadDeNegocio.riesgoIndustriaValue ==null?0:this.parametrico.continuidadDeNegocio.riesgoIndustriaValue;
   integer puntos = anosNegocio + concentEnClientes + riesgoIndustria;
   return puntos;
  }

  private integer getPuntosDesempenoF(){
    integer diasDeAr = this.parametrico.desempenoFinanciero.diasDeArValue ==null?0:this.parametrico.desempenoFinanciero.diasDeArValue;
    integer tamanoDelDeal = this.parametrico.desempenoFinanciero.tamanoDelDealValue ==null?0:this.parametrico.desempenoFinanciero.tamanoDelDealValue;
    integer fccr = this.parametrico.desempenoFinanciero.fccrValue == null?0:this.parametrico.desempenoFinanciero.fccrValue;
    integer totalDebVSEBITDA = this.parametrico.desempenoFinanciero.totaldebVSEBITDAValue ==null?0:this.parametrico.desempenoFinanciero.totaldebVSEBITDAValue;
    integer puntos = diasDeAr + tamanoDelDeal + fccr + totalDebVSEBITDA;
    return puntos;
  }


  private integer getEstructuraPoints(){
    integer ltv = this.parametrico.Estructura.ltvAdvancedPaymentOSdValue ==null?0:this.parametrico.Estructura.ltvAdvancedPaymentOSdValue;
    integer actvoAltMon = this.parametrico.Estructura.activoAltamenteMonetizableValue ==null?0:this.parametrico.Estructura.activoAltamenteMonetizableValue;
    integer collateralGap = this.parametrico.Estructura.collateralGAPValue ==null?0:this.parametrico.Estructura.collateralGAPValue;
    integer garantAdic = this.parametrico.Estructura.garantiasAdicionalesValue ==null?0:this.parametrico.Estructura.garantiasAdicionalesValue;
    integer puntos = ltv + actvoAltMon + collateralGap + garantAdic;
    return puntos;
  }

  private integer getprimarios(){
    return this.parametrico.caracter.puntosCaracter + this.parametrico.continuidadDeNegocio.puntosContinuidadNeg + this.parametrico.desempenoFinanciero.puntosContinuidadNeg;
  }


  private integer gettotalPoints(){
    return this.parametrico.primarios + this.parametrico.enhancer;
  }

  private string getResultado(){
    if(this.parametrico.total < 85){
      this.parametrico.riesgo ='C';
      return 'Rechazada';
    }

    if( this.parametrico.total >=85 && this.parametrico.total <90){
      this.parametrico.riesgo ='C';
      return 'Aprobada';
    }

    if( this.parametrico.total >=90 && this.parametrico.total < 110){
      this.parametrico.riesgo = 'B';
      return 'Aprobada';
    }

    if(this.parametrico.total > 110 ){
      this.parametrico.riesgo ='A';
      return 'Aprobada';
    }

    return null;

  }

}