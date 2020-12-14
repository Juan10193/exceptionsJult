public with sharing class LMM_Controller_Closingmemo_PDF {
    
    public  Opportunity Opparent    {get;set;}
    public  LMM_Entidad_de_oportunidad__c EntidadOp {get;set;}
    public  List<LMM_Entidad_de_oportunidad__c> EntitiesOpp {get;set;}
    public 	List<EC_Quote__c>  EcQuotesOpp {get;set;}
    public 	string 		OppId		{get;set;}
    public 	string 		Uw		{get;set;}
    public 	string 		Originador		{get;set;}
    public  Integer     BuroRepresentativo {get;set;}
    public  Integer     BuroLegal {get;set;}
    public  Integer     BuroAval {get;set;}
    public  Integer     ExpCliente {get;set;}
    public  Integer     AnosNegocio {get;set;}
    public  Integer     ConcentClientes {get;set;}
    public  Integer     RiesgoIndustria {get;set;}
    public  Integer     DiasAR {get;set;}
    public  Integer     TamanoDeal {get;set;}
    public  Integer     Fccr {get;set;}
    public  Integer     TotalDebtEBITDA {get;set;}
    public  Integer     LtvAdvance {get;set;}
    public  Integer     ActivoAltMon {get;set;}
    public  Integer     CollateralGAP {get;set;}
    public  Integer     GarantAdic {get;set;}
    public  Integer     PuntosCaracter {get;set;}
    public  Integer     PuntosContinuidadNeg {get;set;}
    public  Integer     PuntosDesempFinan {get;set;}
    public  Integer     PuntosEstructura {get;set;}
    public  Integer     Primarios {get;set;}
    public  Integer     TotalLMM {get;set;}
    public  String 	    Rde {get;set;}
    public 	Integer     sumaRAC {get;set;}
    public  Decimal     nuevaOppUSD {get;set;}
    public  Decimal     nuevaOppMXN {get;set;}
    public  Decimal     backlogOppUSD {get;set;}
    public  Decimal     backlogOppMXN {get;set;}
    public  Decimal     riesgoOppUSD {get;set;}
    public  Decimal     riesgoOppMXN {get;set;}    
    public  Decimal     exposureOppUSD {get;set;}
    public  Decimal     exposureOppMXN {get;set;}  
    public  String      resultadoRAC {get;set;}

   

    
    public LMM_Controller_Closingmemo_PDF()
    {
        
        try{
            this.sumaRAC=0;
            this.OppId =  (String)System.currentPageReference().getParameters().get('OpId');
            cargaOppLMM();
            CargaEntidadesOpp();
            CargaEcQuotesOpp();
            calculateValuesRac();
            calculateMontosOpp();
            resultado();
            this.BuroRepresentativo=Integer.valueof(this.Opparent.LMM_ls_BurodeCrditoRepresentativo__c);
            this.BuroLegal =Integer.valueof(this.Opparent.LMM_ls_Bur_Legal__c);
            this.BuroAval =Integer.valueof(this.Opparent.LMM_ls_BurdeCrditoAval__c);
            this.ExpCliente =Integer.valueof(this.Opparent.LMM_ls_ExpConClientesPrinc__c);
            this.AnosNegocio=Integer.valueof(this.Opparent.LMM_ls_Anosenelnegocio__c);
            this.ConcentClientes=Integer.valueof(this.Opparent.LMM_ConcentracinenClientes__c);
            this.RiesgoIndustria=Integer.valueof(this.Opparent.LMM_ls_Industria__c);
            this.DiasAR=Integer.valueof(this.Opparent.LM_ls_D_as_de_AR__c);
            this.TamanoDeal=Integer.valueof(this.Opparent.LMM_ls_Tama_o_del_Deal__c);
            this.Fccr=Integer.valueof(this.Opparent.LMM_ls_FCCR__c);
            this.TotalDebtEBITDA=Integer.valueof(this.Opparent.LMM_ls_TotaldebtVSEBITDA__c);
            this.LtvAdvance=Integer.valueof(this.Opparent.LMM_ls_LTVAdvancePaymentSD__c);
            this.ActivoAltMon=Integer.valueof(this.Opparent.LM_ls_Activaltamentemonetiz__c);
            this.CollateralGAP=Integer.valueof(this.Opparent.LMM_ls_Collateral_Gap__c);
            this.GarantAdic=Integer.valueof(this.Opparent.LMM_ls_Garant_as_Adicionales__c);
            this.PuntosCaracter=(this.BuroRepresentativo + this.BuroLegal + this.BuroAval + this.ExpCliente);
            this.PuntosContinuidadNeg =(this.AnosNegocio + this.ConcentClientes + this.RiesgoIndustria);
            this.PuntosDesempFinan =(this.DiasAR + this.TamanoDeal + this.Fccr + this.TotalDebtEBITDA);
            this.PuntosEstructura =(this.LtvAdvance + this.ActivoAltMon + this.CollateralGAP + this.GarantAdic);
            this.Primarios =(this.PuntosCaracter + this.PuntosContinuidadNeg + this.PuntosDesempFinan);
            this.TotalLMM =(this.Primarios + this.PuntosEstructura);
            this.Uw = this.Opparent.LMM_Underwriter__r.FirstName + ' ' + this.Opparent.LMM_Underwriter__r.LastName;

                    }
            Catch(Exception e)
            {
                system.debug(e.getMessage());
            }

    }
    

    
    
        public void cargaOppLMM() {
            system.debug('EL ID DE LA OP' + this.OppId);
        try{
            this.Opparent = [Select id,OPP_ls_Of_sharing_reps__c,
                             		X1st_Funded_Takedown_Date__c,AccountId,OPP_rb_Account_Name__c,
									Account_Unique_Count__c,LM_ls_Activaltamentemonetiz__c,OPP_lm_Additional_Services__c,Aging_In_Credit_Backlog__c,
									Aging_since_opportunity__c,rrpu__Alert_Message__c,Amount,ES3_fm_Amount_Numeric__c,OPP_un_Amount_USD_Converted__c,
									LMM_Antecedentes_del_cliente__c,Approval_Date__c,Approval_Level__c,CPL_dv_Approved_Amount__c,LMM_ls_Anosenelnegocio__c,
									Backlog_Date__c,Book_Yield_Approved__c,OPP_pr_Broker_Fee_Commision__c,OPP_ls_Broker_Fee_Commision__c,
                                    OPP_ls_Broker_name__c,OPP_rb_Broker_Name__c,Budget_Confirmed__c,LMM_ls_BurdeCrditoAval__c,LMM_ls_BurodeCrditoRepresentativo__c,
                                    LMM_ls_Bur_Legal__c,CPL_nu_CA_Rate__c,Core_Capital_Paid_Amount__c,MD_Carveout_in_CA__c,LMM_Cliente_desde__c,CMS_Documents__c,
                                    OPP_ls_Collateral__c,CPIS2_tx_Collateral_Description__c,LMM_ls_Collateral_Gap__c,OPP_rb_Competitor__c,OPP_rb_Competitor_del__c,
                                    OPP_tl_Competitor_comments__c,OPP_ls_Competitor_Index__c,OPP_ls_Competitor_Is_the_main_lender__c,OPP_ls_Competitor_Product__c,
                                    OPP_ls_Competitor_Floating_Fixed__c,OPP_un_Competitor_Spread_bps__c,OPP_un_Competitor_Term_Months__c,LMM_ConcentracinenClientes__c,
                                    LMM_Condiciones_pre_y_post__c,ContractId,Converted_Pipeline__c,CreatedById,Created_Date_with__c,OPP_rb_Credit_Approval__c,
                                    Credit_Approval_ID__c,OPP_fm_Credit_Approval_Status__c,OPP_tx_Credit_Approval_Status__c,Credit_Line_Status__c,Current_Stage_Date__c,
                                    OPP_ls_Deal_Category__c,Description,Discovery_Completed__c,LMM_Domiciliacion__c,LM_ls_D_as_de_AR__c,OPP_fm_EditOpp__c,
                                    OPP_ls_Equipment_Condition__c,Equipment_Funded_Volume_USD__c,OPP_ls_Equipment_Import_Required__c,Equipment_Volume__c,
                                    Exclude_Backlog_from_Pipeline_Report__c,CPS2_da_Expected_1st_funding_date__c,CloseDate,OPP_fh_Date_Customer_Expects_Credit_App__c,
                                    ExpectedRevenue,LMM_ls_ExpConClientesPrinc__c,CPL_date_Expiration_Date__c,OPP_tx_EXT_REF_ID__c,LMM_ls_FCCR__c,LMM_Fecha_de_visita__c,
                                    CPL_fm_Final_Balance__c,MD_fm_Final_Balance_Number__c,OPP_ls_Financing_Need__c,LMM_Findigs__c,Fleet_Funded_Volume_USD__c,Fleet_This_Month_Forecast_Converted__c,
                                    Fleet_This_Month_Forecast_Funded__c,OPP_na_Folio__c,ForecastCategoryName,OPP_fh_Funded_Date__c,Funded_volume__c,LMM_ls_Garant_as_Adicionales__c,
                                    geopointe__Geocode__c,LMM_Grupo_Economico__c,LMM_Imagen_11__c,OPP_ls_Import_Type__c,In_Credit_Date__c,QLIK_ls_Vendor_Branch__c,
                                    OPP_ls_Vendor_Distributor__c,OPP_pr_Vendor_Fee_Commision__c,OPP_ls_Vendor_Fee_Commision__c,OPP_ls_Opportunity_from_Vendor__c,Indirect_Partner_Brand__c,
                                    OPP_ls_Vendor_Brand__c,QLIK_ls_Vendor_Sales_Rep__c,OPP_ls_Vendor_Rates_Subsides__c,OPP_ls_Vendor_Risk_Support__c,Vendor_Type__c,Indirect_Vertical__c,
                                    LMM_Informacion_del_aval__c,OPP_tl_CommercialSupportComments__c,OPP_rb_Closer__c,Insurance_Manager_Comments__c,OPP_ls_Insurance_Type__c,LID__Is_Influenced__c,
                                    CPL_ck_maybeProvidedAnotherCurrency__c,LMM_Justificaci_n_de_la_solicitud__c,LastModifiedById,Latest_Funded_Takedown_Date__c,OPP_ls_Line_of_Business__c,LID__LinkedIn_Company_Id__c,
                                    Loss_Reason__c,OPP_tx_Lost_Comments__c,OPP_fe_Lost_Date__c,Lost_Date_Marketing__c,OPP_tx_Lost_Date_Month__c,OPP_tx_Lost_Date_Q__c,OPP_tx_Lost_Date_Year__c,
                                    OPP_tx_LostStage__c,Lost_Stage_Marketing__c,LMM_ls_LTVAdvancePaymentSD__c,OPP_ls_Marketing_Initiative_1__c,OPP_ls_Marketing_Initiative_2__c,
                                    OPP_ls_Marketing_Initiative_3__c,LMM_Motivo_del_override__c,NextStep,OPP_ca_No_document__c,OPP_at_No_document_Reason__c,OPP_tl_Not_Signed_Proposal_Reason__c,
                                    LMM_Obligor__c,OPP_tx_Opportunity_Comments__c,CurrencyIsoCode,OPP_ls_Opportunity_from_Broker__c,Opportunity_Identified_Date__c,
                                    Name,OwnerId,Opportunity_Owner_Engenium_Area_Header__c,Opportunity_Owner_Engenium_Area_Logo__c,Opportunity_Owner_Signature_Photo__c,
                                    RecordTypeId,Opportunity_Unique_Count__c,LMM_OR_RDE__c,OPP_ls_Origin_of_equipment__c,OPP_fh_Original_Created_Date__c,MC3_dt_Original_Expiration_Date__c,
                                    OPP_tx_Original_Owner__c,LMM_ls_Override__c,CLI_fm_Pipeline_Amount__c,Pipeline_Amount_for_Rollup__c,
                                    Proposal_Awarded_Date__c,Proposal_Date__c,OPP_fh_Proposal_Signed_Received_Date__c,LeadSource,TotalOpportunityQuantity,Real_Estate_Funded_Volume_USD__c,Reason_Engenium_Insurance_Lost__c,
                                    OPP_ls_Reason_Lost_Level_1__c,OPP_ls_Reason_Lost_Level_2__c,OPP_ls_Reason_Lost_Level_3__c,OPP_ls_Reason_Won_Level_1__c,OPP_ls_Reason_Won_Level_2__c,LMM_Recomendacion__c,
                                    OPP_rb_Refered_by__c,LMM_Referencias_EC__c,OPP_ls_Region__c,Required_Book_Yield_to_Win__c,LMM_Resultado_AGARSA__c,LMM_Resultado_de_validaciones__c,LMM_ls_Origen_del_cliente__c,
                                    LMM_Resumen_Buro_credito_y_legal__c,LMM_ls_Industria__c,LMM_Risk_Class__c,ROI_Analysis_Completed__c,ROI_approved__c,IqScore,LMM_Otras_condiciones__c,
                                    OPP_rb_Share_Rep_1__c,OPP_rb_Share_Rep_2__c,OPP_rb_Share_Rep_3__c,OPP_rb_Share_Rep_4__c,OPP_ls_Shared_Opportunity__c,OPP_pr_Sharing_1__c,OPP_pr_Sharing_2__c,OPP_pr_Sharing_3__c,
                                    OPP_pr_Sharing_4__c,OPP_ls_Sharing_Criteria__c,OPP_ls_Shadow_Split__c,OPP_ls_Sharing_Type_2__c,OPP_ls_Sharing_Type_3__c,OPP_ls_Sharing_Type_4__c,SIC_code__c,LMM_Sic_Code_Description__c,
                                    OPP_un_Spread_Diff_vs_Competitor_in_bps__c,StageName,SyncedQuoteId,OPP_re_Takedown__c,CPL_nu_TakeDowns_in_Opportunity__c,CPL_nu_Movement_in_credit_line__c,LMM_ls_Tama_o_del_Deal__c,
                                    LMM_Tipo_de_credito__c,LMM_ls_TotaldebtVSEBITDA__c,Total_Units_Amount_MXN__c,IST__TrackingNumber__c,LMM_tx_Comentarios_Decision__c,LMM_OR_FDE__c,LMM_tx_Mitigantes__c,
                                    Type,LMM_ls_Tipo_de_cliente__c,LMM_Underwriter__c,Opp_ls_Vertical_Focus__c,OPP_tl_Won_Comments__c ,SIC_code__r.Name,Owner.Name,LMM_Buro_Representativo__c,
									LMM_OR15_o_mejor__c,LMM_Anos_experiencia_cliente_p__c,LMM_Maxima_concentracion__c,LMM_FCCR__c,LMM_Apalancamiento__c,LMM_Status_Risk__c,LMM_Status_AML__c,
                             		LMM_Ratio__c,LMM_Acciones_PG__c,LMM_Calificacion_Aval_Principal__c,LMM_Anos_de_experiencia_en_el_sector__c,LMM_Imagen_12__c,LMM_Exposure_cliente__c,LMM_Tipo_de_cambio__c
                                 FROM Opportunity  
                                 where Id =:this.OppId][0]; 
            system.debug('LA OPP');
            system.debug(this.Opparent);
                
            
        }
        Catch(Exception e)
        {
            System.debug(e.getMessage());
            
        }  
        
    }
    
    
    
    public void CargaEntidadesOpp(){
        this.EntitiesOpp = new list<LMM_Entidad_de_oportunidad__c>();
        try{ 
            this.EntitiesOpp = [SELECT Id, IsDeleted, Name, CreatedDate, CreatedById, LastModifiedDate, 
                                            LastModifiedById, SystemModstamp, LMM_tx_Entity_Name__c, LastActivityDate, LMM_pd_Oportunidad__c, 
                                            LMM_pd_Entity_CP__c, LMM_lm_Rol__c, LMM_ls_Hits__c, LMM_ls_Bil_Incidencias__c, 
                                            LMM_pd_Entity_CP__r.CPI_tx_RFC_TIN__c, LMM_pd_Entity_CP__r.name,
                                            LMM_tl_Hits_Description__c,LMM_pd_Entity_CP__r.EM_Economic_Group_ID__c,LMM_pd_Entity_CP__r.CPI_tx_OR_Rating__c,
                                			LMM_pd_Entity_CP__r.CPI_rb_SIC_Code_Actividad_econ_mica__c
                                            FROM LMM_Entidad_de_oportunidad__c where LMM_pd_Oportunidad__c = :OppId];
        }
        Catch(Exception e)
        {
            System.debug(e.getMessage());
        }
    }


    public void CargaEcQuotesOpp(){
        this.EcQuotesOpp = new list<EC_Quote__c>();
        try{
          this.EcQuotesOpp =[SELECT Id,LMM_Account__c,Book_Yield__c,Correo_eletr_nico__c,CreatedById,CurrencyIsoCode,Name,
								  LastModifiedById,Monto_Total__c,Nombre_de_contacto__c,Nombre_de_la_empresa__c,Opportunity__c,
                           		  OwnerId,Pago__c,Pago_de_seguro__c,Plazo__c,Prospect__c,RequestAmortizacion__c,RFC__c,Tasa_Activa__c,
								  Tel_fono__c,Tipo_de_activo__c,Tipo_de_Financiamiento__c,Tipo_de_persona__c,Ubicaci_n__c,
								  Valor_del_activo__c,Ventas_Ingresos_anuales__c,LMM_SL_B__c,LMM_Progress__c,LMM_Meses_en_progress__c,LMM_Periodo_de_gracia__c,
                             	  LMM_Tipo_de_gracia__c,LMM_Tipo_de_pago__c,LMM_Low_High__c,LMM_Nuevo_Usado__c,LMM_Comision__c,
                             	  LMM_RV_PO__c,LMM_Ballon__c,LMM_Anticipo_a_capital__c,LMM_Deposito_en_gtia__c,LMM_ROI_Sin_seguro__c,LMM_Gross_Margin__c, LMM_Segmento_de_Mercado__c,LMM_Seguro_EC_Financiado__c,
                                  LMM_Periodo_de_pagos_progresivos__c,LMM_Solo_AP_Final_de_arrendamiento__c	
                             	  FROM EC_Quote__c where Opportunity__c =:OppId];  
        }        
        Catch(Exception e)
        {
            System.debug(e.getMessage());
        }
    }
    


    
        public void calculateMontosOpp(){
        try{
                 if(Opparent.CurrencyIsoCode =='USD'){ 
              			this.nuevaOppUSD=Opparent.Amount;
                        this.backlogOppUSD=Opparent.CPL_fm_Final_Balance__c;	
                        this.exposureOppUSD = Opparent.LMM_Exposure_cliente__c;
                        this.nuevaOppMXN=(Opparent.Amount * Opparent.LMM_Tipo_de_cambio__c);
                        this.backlogOppMXN=(Opparent.CPL_fm_Final_Balance__c * Opparent.LMM_Tipo_de_cambio__c);
                        this.exposureOppMXN =(Opparent.LMM_Exposure_cliente__c * Opparent.LMM_Tipo_de_cambio__c);
                        this.riesgoOppUSD=Double.valueof(this.nuevaOppUSD + this.backlogOppUSD + this.exposureOppUSD);
                        this.riesgoOppMXN=Double.valueof(this.nuevaOppMXN + this.backlogOppMXN + this.exposureOppMXN);
         			 } 
            
                 if(Opparent.CurrencyIsoCode =='MXN'){ 
              			this.nuevaOppUSD=(Opparent.Amount * Opparent.LMM_Exposure_cliente__c);
                        this.backlogOppUSD=(Opparent.CPL_fm_Final_Balance__c * Opparent.LMM_Tipo_de_cambio__c);
                        this.exposureOppUSD = (Opparent.LMM_Exposure_cliente__c * Opparent.LMM_Tipo_de_cambio__c);
                        this.nuevaOppMXN=Opparent.Amount;
                        this.backlogOppMXN=Opparent.CPL_fm_Final_Balance__c;
                     	this.exposureOppMXN =Opparent.LMM_Exposure_cliente__c;
                        this.riesgoOppUSD=Double.valueof(this.nuevaOppUSD + this.backlogOppUSD + this.exposureOppUSD);
                        this.riesgoOppMXN=Double.valueof(this.nuevaOppMXN + this.backlogOppMXN + this.exposureOppMXN);
         			 } 
                        
        }        
        Catch(Exception e)
        {
            System.debug(e.getMessage());
        }
    }
    
    
       public void calculateValuesRac(){
           
           //Validacion de Buro Representativo*
           try{  
        if(Opparent.LMM_Buro_Representativo__c =='Positivo'){ 
              this.sumaRAC +=10;
          }
        else if(Opparent.LMM_Buro_Representativo__c =='Sin experiencia'){ 
              this.sumaRAC +=10;
          } 
           
         else if(Opparent.LMM_Buro_Representativo__c =='Negativo'){ 
              this.sumaRAC +=0;
          }
           
         //Validacion de Años de experiencia en el sector 7 Pass
         
           if(Opparent.LMM_Anos_de_experiencia_en_el_sector__c >=5){ 
              this.sumaRAC +=10;
          }
        else if(Opparent.LMM_Anos_de_experiencia_en_el_sector__c < 5){ 
              this.sumaRAC +=0;
          } 
               
         //Validacion OR15 o mejor
         
           if(Opparent.LMM_OR15_o_mejor__c <= 15 ){ 
              this.sumaRAC +=10;
          }
        else if(Opparent.LMM_OR15_o_mejor__c > 15){ 
              this.sumaRAC +=0;
          } 
               
         //Validacion Años de experiencia del cliente
         
           if(Opparent.LMM_Anos_experiencia_cliente_p__c >= 5 ){ 
              this.sumaRAC +=10;
          }
        else if(Opparent.LMM_Anos_experiencia_cliente_p__c < 5){ 
              this.sumaRAC +=0;
          } 

         //Validacion Maxima concentración
         
           if(Opparent.LMM_Maxima_concentracion__c <= 60 ){ 
              this.sumaRAC +=10;
          }
        else if(Opparent.LMM_Maxima_concentracion__c > 60){ 
              this.sumaRAC +=0;
          } 
               
         //Validacion FCCR
         
           if(Opparent.LMM_FCCR__c >= 0.75 ){ 
              this.sumaRAC +=10;
          }
        else if(Opparent.LMM_FCCR__c < 0.75){ 
              this.sumaRAC +=0;
          } 
                            
         //Validacion Apalancamiento
         
           if(Opparent.LMM_Apalancamiento__c <= 4 ){ 
              this.sumaRAC +=10;
          }
        else if(Opparent.LMM_Apalancamiento__c > 4 ){ 
              this.sumaRAC +=0;
          } 

         //Validacion Ratio
         
          if(Opparent.LMM_Ratio__c <= 0.5 ){ 
              this.sumaRAC +=10;
          }
        else if(Opparent.LMM_Ratio__c > 0.5){ 
              this.sumaRAC +=0;
          } 

         //Validacion Acciones PGo
         
           if(Opparent.LMM_Acciones_PG__c > 60){ 
              this.sumaRAC +=10;
          }
        else if(Opparent.LMM_Acciones_PG__c <= 60){ 
              this.sumaRAC +=0;
          } 

         //Validacion Calificación Aval Principal
         
           if(Opparent.LMM_Calificacion_Aval_Principal__c >= 690 ){ 
              this.sumaRAC +=10;
          }
        else if(Opparent.LMM_Calificacion_Aval_Principal__c < 690){ 
              this.sumaRAC +=0;
          } 
               
           }
       Catch(Exception e)
        {
            System.debug(e.getMessage());
        }
 
    }
    
    public void resultado(){
        integer suma = this.sumaRAC;
        if(suma  >= 80){
            this.resultadoRAC='Continuar';
              if(Opparent.LMM_Buro_Representativo__c =='Negativo' ||Opparent.LMM_Apalancamiento__c > 4 ||Opparent.LMM_FCCR__c < 0.75){
                 this.resultadoRAC='Rechazado';
                }
        }else{
            this.resultadoRAC='Rechazado';
        }
        
    }

}