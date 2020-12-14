/**
 * @description       : 
 * @author            : juandedios.hernandez@engen.com.mx
 * @group             : 
 * @last modified on  : 07-14-2020
 * @last modified by  : juandedios.hernandez@engen.com.mx
 * Modifications Log 
 * Ver   Date         Author                               Modification
 * 1.0   07-13-2020   ChangeMeIn@UserSettingsUnder.SFDoc   Initial Version
**/
public without sharing class LMM_ReportedeVisitaPYME_Controller {


   @AuraEnabled(cacheable=true)
    public static list<Reporte_de_visita_PYME__c> getReportesByOpId(string opportunityId){
        list<Reporte_de_visita_PYME__c> reports = [Select Id, IsDeleted, Name, CurrencyIsoCode, CreatedDate, CreatedById, LastModifiedDate, 
        LastModifiedById, SystemModstamp, LastActivityDate, LMM_Fecha_de_Visita__c, LMM_Tipo_de_Cliente_para_EC__c, 
        LMM_Visita_realizada_por__c, LMM_Tipo_de_reporte__c, LMM_Puesto__c, LMM_Especificar_Otro__c, LMM_Calle_DV__c,
        LMM_Numero_DV__c, LMM_Colonia_DV__c, LMM_Ciudad_DV__c, LMM_Estado_DV__c, LMM_Tiempo_de_Arraigo_DV__c, 
        LMM_Se_Anexan_Fotos_DV__c, LMM_Ubicaci_n_del_Domicilio_Fiscal__c, LMM_Calle_DF__c, LMM_Numero_DF__c, 
        LMM_Colonia_DF__c, LMM_Ciudad_DF__c, LMM_Estado_DF__c, LMM_Tiempo_de_Arraigo_DF__c, LMM_Se_Anexan_Fotos_DF__c, 
        LMM_Desc_n_de_las_Instalaciones_Visitad__c, LMM_Opportunity__c, LMM_Nombre_del_cliente__r.LMM_tx_Entity_Name__c, LMM_Nombre_del_cliente__r.Id, 
        LMM_Depositario_Legal__r.LMM_tx_Entity_Name__c,LMM_Depositario_Legal__r.Id, LMM_AntePrActividAnioservDatos__c, LMM_descdelEquipoobservadodurante_visita__c, 
        LMM_Pagina_web__c, LMM_N_de_Empleados__c, LMM_Empresas_Filiales_o_Relacionadas__c, LMM_Experiencia_de_cr_dito_previa__c, 
        LMM_Nomdeentidadesquehan_otorgandofinan__c, LMM_CuentaconFinanciamiento_Vigente__c, 
        LMM_Monto_del_Cr_dito_M_ximo_Recibido__c, LMM_Motivo_de_la_Solicitud__c, LMM_Tipo_de_Equipo__c, 
        LMM_El_cliente_cuenta_con_equipo_similar__c, LMM_Descripci_n_de_Equipo__c, LMM_Descripci_nde_laSolicitud_y_estruct__c, 
        LMM_Justificaci_n_de_la_Estructura__c, LMM_Por_qu_apoyas_la_solicitud__c, LMM_Fortalezas_Detectadas__c, 
        LMM_Debilidades_Detectadas__c, LMM_Nombre_del_Originador__c, LMM_Nombre_del_Supervisor__c from Reporte_de_visita_PYME__c 
        where LMM_Opportunity__c =:opportunityId];
        return reports;
    }

    @AuraEnabled(cacheable=true)
    public static list<LookupSearchResult> getEntidadesdeLaOpp(string searchTerm, List<String> selectedIds, string opportunityId ){
        list<LMM_Entidad_de_oportunidad__c> entidades = [Select Id, LMM_pd_Entity_CP__r.Name from LMM_Entidad_de_oportunidad__c where LMM_pd_Oportunidad__c =:opportunityId  AND id NOT IN:selectedIds];
        List<LookupSearchResult> results = new List<LookupSearchResult>();
        String accountIcon = 'standard:account';
        for(LMM_Entidad_de_oportunidad__c ent: entidades){
            results.add(new LookupSearchResult(ent.Id,'LMM_Entidad_de_oportunidad__c',accountIcon,ent.LMM_pd_Entity_CP__r.Name,'Entidad • ' + ent.LMM_pd_Entity_CP__r.Name));
        }
        return results;
    }

    @AuraEnabled(Cacheable = false)
    public static Reporte_de_visita_PYME__c createReporte(Reporte_de_visita_PYME__c reporte, list<LMM_Entidad_de_oportunidad__c> avales, list<Contact> pf, list<Contact>pc, list<Contact> ppv, list<Contact> pac , string reporteId, string oppId){
       system.debug(reporte);
       system.debug(avales);
       System.debug(pf);
       System.debug(pc);
       System.debug(ppv);
       System.debug(pac);
        
       Boolean haveAvales = false;
       Boolean havePf = false;
       Boolean havepc = false;
       Boolean haveppv = false;
       Boolean havepac = false;
       Boolean reportFill = false;
        
       Id recordTypeIdContact =Schema.SObjectType.Contact.getRecordTypeInfosByDeveloperName().get('LMM_Reporte_de_Visita_PYME_Contact').getRecordTypeId();
       reporte.id  =reporteId;
       upsert reporte;
        
          if(avales.size()>0){
            haveAvales = true;
        }

       for (LMM_Entidad_de_oportunidad__c aval : avales) {
           aval.Is_Aval__c =true;
       }

       list<LMM_Entidad_de_oportunidad__c> avalestoDisable =[Select Id, Is_Aval__c from LMM_Entidad_de_oportunidad__c where LMM_pd_Oportunidad__c =:oppId AND Id NOT IN:avales];
       for (LMM_Entidad_de_oportunidad__c val : avalestoDisable) {
           val.Is_Aval__c = false;
           avales.add(val);
       }
       update avales;

       for(Contact con: pf){
           con.RecordTypeId = recordTypeIdContact;
           con.LMM_Reporte_de_visita_PYME__c =reporte.id;
           con.LastName=con.LMM_RPYME_Name__c;
       }

       upsert pf;

       for(Contact con: pc){
           con.RecordTypeId =recordTypeIdContact;
           con.LMM_Reporte_de_visita_PYME__c =reporte.id;
           con.LastName=con.LMM_RPYME_Name__c;
       }

       upsert pc;

       for(Contact con: ppv){
           con.RecordTypeId = recordTypeIdContact;
           con.LMM_Reporte_de_visita_PYME__c = reporte.id;
           con.LastName=con.LMM_RPYME_Name__c;
       }

       upsert ppv;

       for(Contact con:pac){
           con.RecordTypeId = recordTypeIdContact;
           con.LMM_Reporte_de_visita_PYME__c = reporte.id;
           con.LastName=con.LMM_RPYME_Name__c;
       }

       upsert pac;
        
      
        if(
            reporte.LMM_AntePrActividAnioservDatos__c !=null && reporte.LMM_Calle_DF__c != null && reporte.LMM_Calle_DV__c !=null &&
            reporte.LMM_Ciudad_DF__c != null && reporte.LMM_Ciudad_DV__c != null && reporte.LMM_Colonia_DF__c != null && reporte.LMM_Colonia_DV__c != null &&
            reporte.LMM_CuentaconFinanciamiento_Vigente__c != null && reporte.LMM_Debilidades_Detectadas__c != null&&
            reporte.LMM_Desc_n_de_las_Instalaciones_Visitad__c != null && reporte.LMM_descdelEquipoobservadodurante_visita__c != null && reporte.LMM_El_cliente_cuenta_con_equipo_similar__c!=null&&
            reporte.LMM_Descripci_nde_laSolicitud_y_estruct__c != null && reporte.LMM_Descripci_n_de_Equipo__c!=null && reporte.LMM_Empresas_Filiales_o_Relacionadas__c != null&&
            reporte.LMM_Tipo_de_reporte__c != null && reporte.LMM_Estado_DF__c != null &&
            reporte.LMM_Estado_DV__c != null && reporte.LMM_Experiencia_de_cr_dito_previa__c != null && reporte.LMM_Fecha_de_Visita__c != null && reporte.LMM_Fortalezas_Detectadas__c!=null &&
            reporte.LMM_Justificaci_n_de_la_Estructura__c != null && reporte.LMM_Monto_del_Cr_dito_M_ximo_Recibido__c != null && reporte.LMM_Motivo_de_la_Solicitud__c != null &&
            reporte.LMM_N_de_Empleados__c != null&&
            reporte.LMM_Nomdeentidadesquehan_otorgandofinan__c != null &&  reporte.LMM_Numero_DF__c != null && reporte.LMM_Numero_DV__c != null && reporte.LMM_Opportunity__c != null &&
            reporte.LMM_Pagina_web__c != null&& reporte.LMM_Por_qu_apoyas_la_solicitud__c != null && reporte.LMM_Puesto__c != null && reporte.LMM_Se_Anexan_Fotos_DF__c != null&&
            reporte.LMM_Se_Anexan_Fotos_DV__c != null && reporte.LMM_Tiempo_de_Arraigo_DF__c != null && reporte.LMM_Tiempo_de_Arraigo_DV__c != null && reporte.LMM_Tipo_de_Cliente_para_EC__c != null &&
            reporte.LMM_Tipo_de_Equipo__c != null && reporte.LMM_Ubicaci_n_del_Domicilio_Fiscal__c != null && reporte.LMM_Visita_realizada_por__c != null
        ){
            reportFill = true;
            
        }else{
            reportfill = false;
            system.debug('reporte datos:');
            system.debug(JSON.serialize(reporte));
        }
        
        if(pf.size()>0){
            havePf = true;
        }
        
        if(pc.size()>0){
            havepc = true;
        }
        
        if(ppv.size()>0){
            haveppv = true;
        }
        
        if(pac.size()>0){
            havepac = true;
        }
        
        system.debug('valores a comparar');
        system.debug(haveAvales + ' ' +  havepac + ' ' +  havepc + ' '+  havePf + ' ' + haveppv + 'REPORTE: ' + reportFill);
        
        if(haveAvales == true && havepac == true && havepc == true && havePf == true && haveppv == true && reportFill== true){
            Opportunity oppParent = [Select Id, LMM_Reporte_de_Visita_lleno__c from Opportunity where Id =: reporte.LMM_Opportunity__c LIMIT 1];
            if(oppParent != null){
                oppParent.LMM_Reporte_de_Visita_lleno__c = true;
                update oppParent;
            }
        }else{
             Opportunity oppParent = [Select Id, LMM_Reporte_de_Visita_lleno__c from Opportunity where Id =: reporte.LMM_Opportunity__c LIMIT 1];
            if(oppParent != null){
                oppParent.LMM_Reporte_de_Visita_lleno__c = false;
                update oppParent;
            }
        }
       
       return null;
    }

    @AuraEnabled(Cacheable=false)
    public static list<Contact> getAllcontacts(string reporteId){
        list<Contact>Contacts =[Select Id, LMM_RPYME_Name__c,Title,Phone,LMM_Ingresos__c,LMM_A_os__c,email,LMM_Nombre_del_Contacto__c, LMM_Type_Reporte_Visita__c from Contact where LMM_Reporte_de_visita_PYME__c =:reporteId];
        return Contacts;
    }

    @AuraEnabled(Cacheable=false)
    public static void deleteContact(Contact con){
        delete con;
    }

    @AuraEnabled(Cacheable=false)
    public static void upsertContact(Contact con){
        upsert con;
    }
}