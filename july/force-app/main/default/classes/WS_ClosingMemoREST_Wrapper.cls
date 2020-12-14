/**
 * @description       : 
 * @author            : eduardo.amiens@outlook.com
 * @group             : 
 * @last modified on  : 10-14-2020
 * @last modified by  : eduardo.amiens@outlook.com
 * Modifications Log 
 * Ver   Date         Author                       Modification
 * 1.0   09-30-2020   eduardo.amiens@outlook.com   Initial Version
**/
public with sharing class WS_ClosingMemoREST_Wrapper {

    @AuraEnabled
    public InformacionGeneral informacionGeneral {get;set;}

    @AuraEnabled
    public NivelDeAprobacion nivelDeAprobacion {get;set;}

    @AuraEnabled
    public EstructuraDeEntidades estructuraDeEntidades {get;set;}

    @AuraEnabled
    public list<Cotizacion> cotizaciones {get;set;}

    @AuraEnabled
    public EstructuraDeEntidades specialConditionAndCovenant {get;set;}

    public class InformacionGeneral {
        @AuraEnabled
        public String nombreDeLaOpportunidad {get;set;}

        @AuraEnabled
        public String estatusOportunidad {get;set;}

        @AuraEnabled
        public String vertical {get;set;}

        @AuraEnabled
        public String grupoEconomico {get;set;}

        @AuraEnabled
        public String tipoDeAprobacionDeCredito {get;set;}

        @AuraEnabled
        public String tipoDeNegocio {get;set;}
    }
    public class NivelDeAprobacion {

    }
    public class EstructuraDeEntidades {
        @AuraEnabled
        public list<Entidad> entidades {get;set;}
    }
    public class Entidad {
        @AuraEnabled
        public String id {get;set;}
        @AuraEnabled
        public String nombre {get;set;}
        @AuraEnabled
        public list<String> roles {get;set;}
    }
    public class Cotizacion {
        @AuraEnabled
        public Id id {get;set;}
        @AuraEnabled
        public String nombre {get;set;}        
        @AuraEnabled
        public String product {get;set;}
        @AuraEnabled
        public String currencyISOCode {get;set;}

        @AuraEnabled
        public Double amountToFinanceK {get;set;}
        @AuraEnabled
        public String frequency {get;set;}
        @AuraEnabled
        public String aRRADV {get;set;}
        @AuraEnabled
        public Double termInMonthsIncludingPP {get;set;}
        @AuraEnabled
        public Double termInMonthsWithoutPP {get;set;} //Advance Payment
        @AuraEnabled
        public Double progressPaymentsM {get;set;}

        @AuraEnabled
        public String progressDescription {get;set;}
        @AuraEnabled
        public String gracePeriod {get;set;}
        @AuraEnabled
        public String typeOfGracePeriod {get;set;}
        @AuraEnabled
        public String lowHighHighLow {get;set;}
        @AuraEnabled
        public String LHDescription {get;set;}






        @AuraEnabled
        public Double advancePayment  {get;set;}
        @AuraEnabled
        public String eFA {get;set;}
        @AuraEnabled
        public String usedNew {get;set;}
        @AuraEnabled
        public String SLBYESNO {get;set;}
        @AuraEnabled
        public String EBO {get;set;}


        @AuraEnabled
        public String EBODescription  {get;set;}
        @AuraEnabled
        public String equipmentToFinance {get;set;}
        @AuraEnabled
        public String assetDescription {get;set;}
        @AuraEnabled
        public String returnCondition {get;set;}
        @AuraEnabled
        public Double remarketingFee {get;set;}


        @AuraEnabled
        public Double splitTrac  {get;set;}
        @AuraEnabled
        public Double lockFee {get;set;}
        @AuraEnabled
        public String bootCollateralType {get;set;}
        @AuraEnabled
        public String EOLOption {get;set;}
        @AuraEnabled
        public String promNote {get;set;}

        @AuraEnabled
        public String cargaPeligrosa  {get;set;}
        @AuraEnabled
        public String cashCollateral {get;set;}
        @AuraEnabled
        public String collectionRights {get;set;}
        @AuraEnabled
        public String crossCollateral {get;set;}
        @AuraEnabled
        public String directDebit {get;set;}

        @AuraEnabled
        public Double expenseANI  {get;set;}
        @AuraEnabled
        public Double rOIwithInsurance {get;set;}
        @AuraEnabled
        public Double rOINoInsurance {get;set;}
        @AuraEnabled
        public Double openingFee {get;set;}
        @AuraEnabled
        public Double sD {get;set;}
        @AuraEnabled
        public Double sDPercentage {get;set;}

        @AuraEnabled
        public String sDComment  {get;set;}
        @AuraEnabled
        public String rateFixedFloating {get;set;}
        @AuraEnabled
        public Double ratePercentage  {get;set;}
        @AuraEnabled
        public Double rV {get;set;}
        @AuraEnabled
        public Double balloonBulletPayment {get;set;}
        @AuraEnabled
        public Double pOption {get;set;}
        @AuraEnabled
        public Datetime lastUpdate {get;set;}

        
    }

    public class SpecialConditionAndCovenant {

    }
}