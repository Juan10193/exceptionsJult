@RestResource(urlMapping='/Lead/*')
//global with sharing class LeadManager
global class LeadManager {
    
    @HttpPost 
    global static ID createLead(String nombre, 
                                String noCliente, 
                                String rfc, 
                                String tipoSociedad, 
                                String pais, 
                                String codigoPostal, 
                                String estado, 
                                String ciudad, 
                                String municipio,
                                String colonia, 
                                String calle, 
                                String numeroExterior, 
                                String numeroInterior,
                                String datosIndustria,
                                Boolean relacionComercialGobierno,
                                Boolean bolsaExtranjeraReconocida,
                                String oficinasReconocidad,
                                String actividadesComercionales,
                                String moneda,
                                Integer idVendor,
                                Integer idPrograma,
                                Decimal monto,
                                String idContent,
                                String link,
                                String idOportunidad){
        Id recordTypeId = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('PRM').getRecordTypeId();
        System.debug(recordTypeId);                            
        Lead newLead = new Lead(
            Company = nombre,
            LastName = nombre,
            LEA_tf_Company_Phone__c = '0000000',
            Prm_text_nocliente__c = noCliente,
            Prm_text_rfc__c = rfc,
            Prm_picklist_tipos__c = PrmWrapperLead.convierteSociedad(tipoSociedad),
            CountryCode = (pais == 'MEX') ? 'MX' : pais,
            PostalCode = codigoPostal,
            StateCode = estado,
            City = ciudad,
            Street = municipio +' '+ colonia +' '+ calle +' '+ numeroExterior +' '+ numeroInterior, 
            Prm_text_industria__c = datosIndustria,
            Prm_check_relaciongobierno__c = relacionComercialGobierno,
            Prm_check_bolsaextrangera__c = bolsaExtranjeraReconocida,
            Prm_select_clientecoorporativa__c = oficinasReconocidad,
            Prm_select_actividadcomercial__c = actividadesComercionales,
            CurrencyIsoCode = moneda,
            Prm_text_broken__c = String.valueOf(idVendor),
            Prm_check_program__c = String.valueOf(idPrograma),
            Prm_amount_lead__c = monto,
            Prm_text_content__c = idContent,
            Prm_url_link__c = link,
            Prm_id_opportunity__c = idOportunidad,
            RecordTypeId = recordTypeId
        );
        
        insert newLead;
        System.debug(newLead);
        return newLead.Id;    
    }
    
    @HttpGet
    global static List<PrmWrapperLead> getLead() {
        String id = RestContext.request.params.get('id');
        List<PrmWrapperLead> prmWrapper = new List<PrmWrapperLead>();
        Lead prmLead = new Lead();
        
        for(Lead lead : [SELECT id, 
                         ConvertedAccountId, 
                         Status, 
                         Company, 
                         Prm_text_nocliente__c, 
                         Prm_text_rfc__c, 
                         Prm_picklist_tipos__c,
                         Country, 
                         PostalCode, 
                         State, 
                         City, 
                         Street, 
                         Prm_text_industria__c, 
                         Prm_check_relaciongobierno__c,
                         Prm_check_bolsaextrangera__c,
                         Prm_select_clientecoorporativa__c,
                         Prm_select_actividadcomercial__c FROM Lead WHERE id =: id]) {
            if(lead.Status == 'Converted') {
                prmLead = lead;
                List<Account> infoCompleteLead = [select id, 
                                                  Name,
                                                  Sic,
                                                  Account_Type__c,
                                                  ACC_Company_Phone__c,
                                                  ACC_tx_Account_Potential_Comments__c,
                                                  Total_Available_Credit_Line__c,
                                                  Equipment_Available_Credit_Line__c,
                                                  (Select 
                                                   Id,
                                                   Name,
                                                   MailingAddress from contacts), 
                                                  (Select Id,
                                                   OwnerId,
                                                   Name,
                                                   OPP_rb_Closer__c,
                                                   StageName,
                                                   Probability,
                                                   OPP_ls_Region__c,
                                                   CPS2_da_Expected_1st_funding_date__c,
                                                   CMS_Documents__c,
                                                   CurrencyIsoCode,
                                                   LMM_Tipo_de_credito__c,
                                                   Amount,
                                                   OPP_ls_Product__c,
                                                   CPL_dv_Approved_Amount__c,
                                                   CPL_date_Expiration_Date__c,
                                                   Approval_Date__c,
                                                   LMM_ca_risk_approval_process__c,
                                                   CreatedById,
                                                   LastModifiedById,
                                                   Approval_Level__c,
                                                   LMM_Acciones_PG__c,
                                                   LMM_Anos_de_experiencia_en_el_sector__c,
                                                   LMM_Anos_experiencia_cliente_p__c,
                                                   LMM_Antecedentes_del_cliente__c,
                                                   LMM_Apalancamiento__c,
                                                   LMM_Buro_Representativo__c,
                                                   LMM_Calificacion_Aval_Principal__c,
                                                   LMM_Cliente_desde__c,
                                                   LMM_ConcentracinenClientes__c,
                                                   LMM_Condiciones_pre_y_post__c,
                                                   LMM_Domiciliacion__c,
                                                   LMM_FCCR__c,
                                                   LMM_Fecha_de_visita__c,
                                                   LMM_Findigs__c,
                                                   LMM_Grupo_Economico__c,
                                                   LMM_Imagen_11__c,
                                                   LMM_Informacion_del_aval__c,
                                                   LMM_Justificaci_n_de_la_solicitud__c,
                                                   LMM_Maxima_concentracion__c,
                                                   LMM_Motivo_del_override__c,
                                                   LMM_OR15_o_mejor__c,
                                                   LMM_OR_RDE__c,
                                                   LMM_Obligor__c,
                                                   LMM_ls_Override__c,
                                                   LMM_Ratio__c,
                                                   LMM_Recomendacion__c,
                                                   LMM_Referencias_EC__c,
                                                   LMM_Resultado_AGARSA__c,
                                                   LMM_Resultado_de_validaciones__c,
                                                   LMM_Resumen_Buro_credito_y_legal__c,
                                                   LMM_Risk_Class__c,
                                                   LMM_Sic_Code_Description__c,
                                                   LMM_Underwriter__c,
                                                   LMM_ls_Anosenelnegocio__c,
                                                   LMM_ls_Bur_Legal__c,
                                                   LMM_ls_BurdeCrditoAval__c,
                                                   LMM_ls_BurodeCrditoRepresentativo__c,
                                                   LMM_ls_Collateral_Gap__c,
                                                   LMM_ls_ExpConClientesPrinc__c,
                                                   LMM_ls_FCCR__c,
                                                   LMM_ls_Origen_del_cliente__c,
                                                   LMM_ls_Garant_as_Adicionales__c,
                                                   LMM_ls_Industria__c,
                                                   LMM_ls_LTVAdvancePaymentSD__c,
                                                   LMM_ls_Tama_o_del_Deal__c,
                                                   LMM_ls_TotaldebtVSEBITDA__c,
                                                   LMM_Otras_condiciones__c,
                                                   LM_ls_Activaltamentemonetiz__c,
                                                   LM_ls_D_as_de_AR__c,
                                                   LMM_ls_Tipo_de_cliente__c,
                                                   SIC_code__c                                                
                                                   From Opportunities) from Account WHERE Account.Id =: lead.ConvertedAccountId];
                for(Account a : infoCompleteLead){
                    prmWrapper.add(new PrmWrapperLead(prmLead, a));
                }
                return prmWrapper;
            }
            prmWrapper.add(new PrmWrapperLead(lead));
            return prmWrapper;
        }
         
        return null;
    }
}