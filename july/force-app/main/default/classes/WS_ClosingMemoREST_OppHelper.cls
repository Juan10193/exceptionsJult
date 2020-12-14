/**
* @description       : 
* @author            : eduardo.amiens@outlook.com
* @group             : 
* @last modified on  : 11-12-2020
* @last modified by  : eduardo.amiens@outlook.com
* Modifications Log 
* Ver   Date         Author                       Modification
* 1.0   09-30-2020   eduardo.amiens@outlook.com   Initial Version
**/
public without sharing class WS_ClosingMemoREST_OppHelper {
    
    private Id opportunityId {get;set;}
    
    public WS_ClosingMemoREST_OppHelper(ApexPages.StandardController stdController){
        this.opportunityId = stdController.getId();
    }
    
    public WS_ClosingMemoREST_OppHelper(Id opportunityId) {
        this.opportunityId = opportunityId;
    }
    public WS_ClosingMemoREST_Wrapper getData(){
        system.debug('1');
        WS_ClosingMemoREST_Wrapper wrapper = new WS_ClosingMemoREST_Wrapper();
        WS_ClosingMemoREST_Wrapper.InformacionGeneral informacionGeneral = new WS_ClosingMemoREST_Wrapper.InformacionGeneral();
        set<Id> setPricingId = new set<Id>();
        for(Opportunity opp : [SELECT Id, 
                               WKA_rb_AP_Tesoreria__c, WKA_rb_AP_Tesoreria__r.WKA_ls_Proceso_de_aprobacion__c, WKA_rb_AP_Tesoreria__r.WKA_Stage__c, 
                               WKA_rb_AP_AML__c,       WKA_rb_AP_AML__r.WKA_ls_Proceso_de_aprobacion__c,       WKA_rb_AP_AML__r.WKA_Stage__c, 
                               WKA_rb_AP_Riesgo__c,    WKA_rb_AP_Riesgo__r.WKA_ls_Proceso_de_aprobacion__c,    WKA_rb_AP_Riesgo__r.WKA_Stage__c,
                               LMM_Tipo_de_credito__c, StageName, Name, OPP_ls_Vertical__c,
                               (Select Id, LMM_tx_Entity_Name__c, LMM_lm_Rol__c from Entidades_de_oportunidad__r),
                               (Select Id from IST__Pricing_Quotes__r),
                               (SELECT id, name from Pricing__r) 
                               
                               FROM Opportunity where Id = :this.opportunityId]){
                                   system.debug('2');
                                   //InformacionGenera
                                   InformacionGeneral.nombreDeLaOpportunidad = opp.Name; 
                                   InformacionGeneral.estatusOportunidad = opp.StageName;
                                   InformacionGeneral.vertical = opp.OPP_ls_Vertical__c;
                                   //InformacionGeneral.grupoEconomico = opp.
                                   InformacionGeneral.tipoDeAprobacionDeCredito = opp.LMM_Tipo_de_credito__c;
                                   //InformacionGeneral.tipoDeNegocio = opp.
                                   WS_ClosingMemoREST_Wrapper.EstructuraDeEntidades estructuraDeEntidades = new WS_ClosingMemoREST_Wrapper.EstructuraDeEntidades();
                                   list<WS_ClosingMemoREST_Wrapper.Entidad> listEntidad = new list<WS_ClosingMemoREST_Wrapper.Entidad>();
                                   for(LMM_Entidad_de_oportunidad__c LMM_Entidad_de_oportunidad : opp.Entidades_de_oportunidad__r){
                                       WS_ClosingMemoREST_Wrapper.Entidad entidad = new WS_ClosingMemoREST_Wrapper.Entidad();
                                       entidad.id = LMM_Entidad_de_oportunidad.Id;
                                       entidad.nombre = LMM_Entidad_de_oportunidad.LMM_tx_Entity_Name__c;
                                       if(LMM_Entidad_de_oportunidad.LMM_lm_Rol__c != null)
                                           entidad.roles = LMM_Entidad_de_oportunidad.LMM_lm_Rol__c.split(';');
                                       listEntidad.add(entidad);
                                   }
                                   estructuraDeEntidades.entidades = listEntidad;
                                   for(IST__SuperTRUMP_Pricing_Quote__c pricing : opp.IST__Pricing_Quotes__r){
                                       setPricingId.add(pricing.Id);
                                   }
                                   
                                   
                                   wrapper.informacionGeneral =  InformacionGeneral;   
                                   wrapper.estructuraDeEntidades = estructuraDeEntidades;
                                   
                                   
                               }
        list<WS_ClosingMemoREST_Wrapper.Cotizacion> listCotizaciones = new list<WS_ClosingMemoREST_Wrapper.Cotizacion>();
        for(SupperTRUMP_Pricing_Quote_Wrapper.query_All_Fields query_All_Fields : Data_Access_WOS_IST_SP_Pricing_Quote.getAllFieldsBySetId(setPricingId)){
            WS_ClosingMemoREST_Wrapper.Cotizacion cotizacion  = new WS_ClosingMemoREST_Wrapper.Cotizacion();
            cotizacion.id = query_All_Fields.recordID;
            cotizacion.nombre = query_All_Fields.Name;
            cotizacion.product = query_All_Fields.Product_Name;
            cotizacion.currencyISOCode = query_All_Fields.CurrencyIsoCode;
            cotizacion.amountToFinanceK = query_All_Fields.IST_Cost;
            cotizacion.frequency = query_All_Fields.IST_Periodicity;
            cotizacion.aRRADV = query_All_Fields.Payment_Timing;
            cotizacion.termInMonthsIncludingPP = query_All_Fields.IST_Term;
            cotizacion.termInMonthsWithoutPP = query_All_Fields.IST_Term;
            
            cotizacion.progressPaymentsM = query_All_Fields.WOA_nu_Progress_Payments_M;
            cotizacion.progressDescription = query_All_Fields.WOA_tl_Progress_Description;
            cotizacion.gracePeriod = query_All_Fields.WOA_ls_Type_of_Grace_Period;
            cotizacion.typeOfGracePeriod = query_All_Fields.WOA_ls_Type_of_Grace_Period;
            cotizacion.lowHighHighLow = query_All_Fields.WOA_ls_Low_High_High_Low;
            cotizacion.LHDescription = query_All_Fields.WOA_tl_Low_High_High_Low_Description;
            cotizacion.eFA = query_All_Fields.WOA_ls_EFA;
            cotizacion.usedNew = query_All_Fields.WOA_ls_Used_New;
            cotizacion.SLBYESNO = query_All_Fields.WOA_ls_SL_B_YES_NO;
            cotizacion.EBODescription = query_All_Fields.WOA_tl_EBO_Description;
            cotizacion.equipmentToFinance = query_All_Fields.Opportunity_Collateral;
            cotizacion.assetDescription = query_All_Fields.WOA_tl_Asset_description;
            cotizacion.returnCondition = query_All_Fields.WOA_tl_Return_Condition;
            cotizacion.remarketingFee = query_All_Fields.WOA_pr_Remarketing_Fee;
            cotizacion.splitTrac = query_All_Fields.WOA_pr_Split_Trac;
            if(query_All_Fields.EBO_Active){
                cotizacion.EBO = 'YES';
            } else {
                cotizacion.EBO = 'NO';
            } 
            if(query_All_Fields.WOA_pr_Lock_Fee != null){
                cotizacion.lockFee = query_All_Fields.WOA_pr_Lock_Fee;
            } else {
                for(IST_ST_PQ_Income_Fee_Wrapper_cls.query_All_Fields ST_PQ_Income_Fee_Wrapper : query_All_Fields.list_IST_ST_PQ_Income_Fee_Wrapper){
                    if(String.isNotEmpty(ST_PQ_Income_Fee_Wrapper.IST_Description) && ST_PQ_Income_Fee_Wrapper.IST_Description.equals('Residual Lock Fee')){
                        cotizacion.lockFee = ST_PQ_Income_Fee_Wrapper.IST_Percent;
                    }
                }
            }            
            cotizacion.bootCollateralType = query_All_Fields.WOA_tx_Boot_Collateral_Type;
            cotizacion.EOLOption = query_All_Fields.WOA_tl_EOL_Option;
            cotizacion.promNote = query_All_Fields.WOA_ls_Prom_Note;
            cotizacion.cargaPeligrosa = query_All_Fields.WOA_ls_Carga_Peligrosa;
            cotizacion.cashCollateral = query_All_Fields.WOA_ls_Cash_Collateral;
            //cotizacion.collectionRights = query_All_Fields.righ
            cotizacion.crossCollateral = query_All_Fields.WOA_ls_Cross_Collateral;
            cotizacion.directDebit = query_All_Fields.WOA_ls_Direct_Debit;
            cotizacion.expenseANI = query_All_Fields.Expense_ANI;
            cotizacion.rOIwithInsurance = query_All_Fields.Economic_ROI;
            cotizacion.rOINoInsurance = query_All_Fields.WOA_nu_ROI_No_Insurance; 
            cotizacion.openingFee = query_All_Fields.Opening_Fee;
            if(query_All_Fields.WOA_dv_Security_Deposit != null){
                cotizacion.sD = query_All_Fields.WOA_dv_Security_Deposit;
                //cotizacion.sDPercentage = query_All_Fields.WOA_pr_Security_Deposit__c;
            } else {
                cotizacion.sD = query_All_Fields.Total_Security_Deposit;
                cotizacion.sDPercentage = query_All_Fields.IST_Payment / query_All_Fields.IST_Cost * 100;
            }
            
            
            cotizacion.sDComment = query_All_Fields.WOA_at_Security_Deposit_Comments;
            cotizacion.rateFixedFloating = query_All_Fields.Rate_Type;
            if(string.isNotEmpty(query_All_Fields.IST_TemplateName) && query_All_Fields.IST_TemplateName.equals('EC Quasi Lease')){
                cotizacion.ratePercentage = query_All_Fields.Full_Term_Rate;
            } else if(string.isNotEmpty(query_All_Fields.IST_TemplateName) && !query_All_Fields.IST_TemplateName.equals('EC Loan')){
                cotizacion.ratePercentage = query_All_Fields.FulltermRatewithresidual;
            } else {
                cotizacion.ratePercentage = query_All_Fields.IST_Lending_Rate;
            }
            cotizacion.rV = query_All_Fields.Residual_Value;
            string product = string.isNotEmpty(query_All_Fields.IST_TemplateName) ? query_All_Fields.IST_TemplateName.equals('EC Loan') ? 'Term Load' : query_All_Fields.IST_TemplateName.mid(4,query_All_Fields.IST_TemplateName.length()) : '';
            //newPricings.get(idpri).IST__Template__r.Name == 'EC Loan'?'Term Load':newPricings.get(idpri).IST__Template__r.Name.mid(4,newPricings.get(idpri).IST__Template__r.Name.length());
            if(string.isNotEmpty(product) && (product.contains('True') || product.contains('Fleet') || product.contains('TF'))){
                cotizacion.rv = query_All_Fields.Residual_Value;
            }
            for(IST_ST_PQ_Rent_Wrapper_cls.query_All_Fields ST_PQ_Rent_Wrapper : query_All_Fields.list_IST_ST_PQ_Rent_Wrapper){
                boolean findAdvancePayment = false;
                if(ST_PQ_Rent_Wrapper.IST_Advance_Payment != null){
                    cotizacion.advancePayment = ST_PQ_Rent_Wrapper.IST_Advance_Payment;
                } else {
                    findAdvancePayment = true;
                }
                for(ST_PQ_Rent_CFS_Wrapper_cls.query_All_Fields PQ_Rent_CFS_Wrapper : ST_PQ_Rent_Wrapper.list_ST_PQ_Rent_CFS_Wrapper){
                    //Este if valida si hay que buscar el advance payment en la tabla CFS
                    if(findAdvancePayment){
                        //Este if valida que los campos Stub, payment, num pmts, type rent y timming no estén vacios
                        // si el Period = Stub, solo tiene un payment, el tipo de renta es Payment, y el timing es equal
                        // y el step no es el último, entonces se trata de un advance payment 
                        if(string.isNotEmpty(PQ_Rent_CFS_Wrapper.Period) 
                           && PQ_Rent_CFS_Wrapper.Num_Pmts != null
                           && String.isNotEmpty(PQ_Rent_CFS_Wrapper.TypeRent)
                           && String.isNotEmpty(PQ_Rent_CFS_Wrapper.Timing) 
                           && PQ_Rent_CFS_Wrapper.Period.equals('Stub')
                           && PQ_Rent_CFS_Wrapper.Num_Pmts == 1 
                           && (PQ_Rent_CFS_Wrapper.TypeRent.equals('Payment'))
                           && PQ_Rent_CFS_Wrapper.Timing.equals('Equal')
                           && ST_PQ_Rent_Wrapper.list_ST_PQ_Rent_CFS_Wrapper.size() != PQ_Rent_CFS_Wrapper.Step){
                               cotizacion.advancePayment = PQ_Rent_CFS_Wrapper.Amount;
                           }    
                    }
                    //Este if valida que los campos Stub, payment, num pmts, type rent y timming no estén vacios
                    // si el Period = Stub, solo tiene un payment, el tipo de renta es Payment, y el timing es equal
                    // y el step es el último, entonces se trata de un Ballon
                    if(string.isNotEmpty(PQ_Rent_CFS_Wrapper.Period) 
                       && PQ_Rent_CFS_Wrapper.Num_Pmts != null
                       && String.isNotEmpty(PQ_Rent_CFS_Wrapper.TypeRent)
                       && String.isNotEmpty(PQ_Rent_CFS_Wrapper.Timing) 
                       && PQ_Rent_CFS_Wrapper.Period.equals('Stub')
                       && PQ_Rent_CFS_Wrapper.Num_Pmts == 1 
                       && (PQ_Rent_CFS_Wrapper.TypeRent.equals('Payment') || PQ_Rent_CFS_Wrapper.TypeRent.equals('Ballon'))
                       && PQ_Rent_CFS_Wrapper.Timing.equals('Equal')
                       && ST_PQ_Rent_Wrapper.list_ST_PQ_Rent_CFS_Wrapper.size() == PQ_Rent_CFS_Wrapper.Step){
                           cotizacion.balloonBulletPayment = PQ_Rent_CFS_Wrapper.Amount;
                       }
                }
                
            }
            
            if(string.isNotEmpty(product) && product.contains('Quasi')){
                cotizacion.pOption = query_All_Fields.Residual_Value;
            }
            cotizacion.lastUpdate = query_All_Fields.LastModifiedDate;
            
            listCotizaciones.add(cotizacion);
        }
        wrapper.cotizaciones = listCotizaciones;
        return wrapper;
    }
}