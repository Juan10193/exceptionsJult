@RestResource(urlMapping='/Supplier_in_approval__c/*')
global with sharing class WS_SupplierInApproval_REST {
    public virtual class BaseException extends Exception {}
    public class WsException extends BaseException {}
    
    @HttpGet
    global static void doGet(){
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        res.addHeader('Content-Type', 'application/json;charset=UTF-8');

        string recordId = req.params.get('recordId');
        if(recordId!=null){
            try{
                Supplier_in_approval__c supplierInApproval = Data_Access_Supplier_in_approval.getSupplierInApprovalWithSuppliersById(recordId);
                SuppplierInApprovalWithSuppliersWrapper supplierInApprovalAndSuppliers = new SuppplierInApprovalWithSuppliersWrapper();

                List<Supplier__c> suppliers = [SELECT Id,IsDeleted, Name, CurrencyIsoCode, 
                LastActivityDate, LastViewedDate, LastReferencedDate, 
                TKD_pd_Supplier_in_approval__c, Nacionalidad__c, TKD_Vendor_ID__c, 
                TKD_chkb_HaveInvoice__c, TKD_ls_Pais_de_residencia__c, TKD_ls_Tipo_de_tercero__c, 
                TKD_tl_hitsDescription__c, TKD_tx_Contexto__c, TKD_tx_Supplier_Unique_ID__c, 
                TKD_tx_Vat_Registration_Num__c, TKD_tx_Vendor_Name__c, 
                TKD_tx_Vendor_name_alternative__c, TKD_tx_amlHits__c, 
                TKD_un_oracleSupplier__c, TKD_Monto_Invoice__c, 
                Opini_n_positiva_del_SAT__c, TKD_A_os_de_garant_a_del_activo__c,
                TKD_C_ha_trabajado_con_el_proveedor__c, TKD_Cuantos_clientes_de_EC_han_traido__c, 
                TKD_L_deres_en_venta_de_este_activo__c, TKD_Numero_de_veces_que_hemos_trabajo__c, 
                TKD_Pagina_web_existente__c, TKD_Presencia_en_otras_ciudades_regiones__c, 
                TKD_Proveedores_sustitutos__c, TKD_Que_montonoshafacturado_el_proveedor__c, 
                TKD_Revision_de_facturas_origen__c, TKD_Se_encuentra_correcto_en_el_BIL__c, 
                TKD_Se_encuentra_en_Google_Search__c, TKD_quien_es_quien__c, 
                TKD_Servicio_post_venta__c, TKD_Tipo_de_proveedor__c, 
                TKD_Validaci_n_de_RFC_ante_el_SAT__c, TKD_Verificacion_de_domicilio__c, 
                TKD_Tipo_de_Scorecard__c 
                FROM Supplier__c WHERE TKD_pd_Supplier_in_approval__c =:recordId];

                Set<Id> suppliersIds = new Set<Id>();

                for (Supplier__c supplier : suppliers) {
                    suppliersIds.add(supplier.Id);
                }

                List<TKD_Site__c> sites = new List<TKD_Site__c>();

                if(suppliersIds.size()>0){

                    sites =[SELECT Id, IsDeleted, Name, CurrencyIsoCode, Supplier__c, TKD_Vat_code__c, 
                    TKD_Vendor_ID__c, TKD_Vendor_Site_ID__c, TKD_ls_State__c, TKD_tx_Country__c, Tkd_at_Address_line_1__c, 
                    Tkd_at_Address_line_2__c, Tkd_ls_Country__c, Tkd_ls_Org_Name__c, Tkd_tx_City__c, Tkd_tx_State__c, 
                    Tkd_tx_Zip__c, tkd_tf_phone__c, Pay_Site_Flag__c, primaryPaySiteFlag__c, SR_ls_Custom_Currency__c, 
                    (SELECT Id,IsDeleted,MasterRecordId,AccountId,LastName,FirstName,Salutation,MiddleName,Name,RecordTypeId,
                    MailingStreet,MailingCity,MailingState,MailingPostalCode,MailingCountry,MailingStateCode,MailingCountryCode,
                    MailingLatitude,MailingLongitude,MailingGeocodeAccuracy,MailingAddress,Phone,Fax,MobilePhone,ReportsToId,
                    Email,Title,Department,CurrencyIsoCode,OwnerId,LastActivityDate,LastCURequestDate,LastCUUpdateDate,LastViewedDate,
                    LastReferencedDate,EmailBouncedReason,EmailBouncedDate,IsEmailBounced,PhotoUrl,JigsawContactId,IndividualId,
                    CON_ca_Principal__c,CON_fh_Last_Call_Date__c,CON_fh_Last_activity_date__c,CON_fh_Last_meeting_Date__c,
                    CON_fm_Account_Potential_Category__c,CON_fm_Account_Status__c,CON_fm_Commercial_Name__c,CON_lm_Line_s_of_bussiness__c,
                    CON_ls_Departament__c,CON_ls_Tittle__c,CON_ls_Type__c,CON_txt_EXT_REF_ID__c,CON_un_Phone_number_extension__c,Folio__c,
                    LID__LinkedIn_Company_Id__c,LID__LinkedIn_Member_Token__c,geopointe__Geocode__c,Global_People_ID__c,rrpu__Alert_Message__c,
                    rh2__Currency_Test__c,rh2__Describe__c,rh2__Formula_Test__c,rh2__Integer_Test__c,Entities_Business_name__c,Historic_Christmas_Present__c,
                    Contact_Comments__c,No_longer_works_there__c,Latest_Date_Survey_Sent__c,Easy_Cold_Calling_Contact__c,Latest_Date_Survey_Responded__c,
                    Account_ID__c,Latests_NPS_Survey_Responded_Link__c,Insurance_Contact__c,iSell__Avention_ID__c,pi__Needs_Score_Synced__c,
                    pi__Pardot_Last_Scored_At__c,pi__campaign__c,pi__comments__c,pi__conversion_date__c,pi__conversion_object_name__c,pi__conversion_object_type__c,
                    pi__created_date__c,pi__first_activity__c,pi__first_search_term__c,pi__first_search_type__c,pi__first_touch_url__c,pi__grade__c,
                    pi__last_activity__c,pi__notes__c,pi__pardot_hard_bounced__c,pi__score__c,pi__url__c,pi__utm_campaign__c,pi__utm_content__c,
                    pi__utm_medium__c,pi__utm_source__c,pi__utm_term__c,Days_since_last_meeting__c,Last_Activity_Contact__c,Last_Meeting_Contact__c,
                    Last_update_Counter__c,TKD_Vendor_Site_ID__c,TKD_rb_Site__c,LMM_A_os__c,LMM_Ingresos__c,LMM_Nombre_del_Contacto__c,
                    LMM_RPYME_Name__c,LMM_Reporte_de_visita_PYME__c,LMM_Type_Reporte_Visita__c FROM  Contacts__r), 
                    (SELECT Id,OwnerId,IsDeleted,Name,CurrencyIsoCode,RecordTypeId,Entity_Name__c,
                    Bank_Account_Currency__c,Bank_Name__c,Bank_Account_Name__c,Bank_Country__c,Mexican_Swift__c,ABA_Swift__c,
                    Intermediary_Bnak_Name__c,Intermediary_Bank_Swift__c,Intermediary_Bank_Account_CLABE_IBAN__c,FFC_Name__c,
                    FFC_Ref__c,Virtual_Account__c,Cuenta__c,ABAswift__c,TKD_Vendor_Site_ID__c,TKD_rb_Site__c,Codigo_BIC__c,
                    Codigo__c,Contexto__c,Nombre_Banco_intermediadio__c,Pago_a_Cta_Concentradora_RN__c,Pago_a_Cuenta_Concentradora__c,
                    Tipo_BIC__c,Tipo__c FROM  Bank_Accounts__r) FROM TKD_Site__c WHERE Supplier__c IN:suppliersIds];
                }

                list<Supplier_Details_Wrapper> suppliersDetails = new List<Supplier_Details_Wrapper>();
                suppliersDetails = WS_Supplier_REST_Helper.suppliersDetails(suppliers, sites);  
                supplierInApprovalAndSuppliers.supplierInApproval = new  SuppplierInApprovalWithSuppliersWrapper.SupplierInApprovalDetails();
                supplierInApprovalAndSuppliers.supplierInApproval.supplierInApprovalInfo = supplierInApproval;
                supplierInApprovalAndSuppliers.supplierInApproval.suppliers =suppliersDetails;

                res.responseBody = Blob.valueOf(JSON.serialize(supplierInApprovalAndSuppliers, false));
            }catch(Exception e){
                SalesforceError[] errs = new SalesforceError[]{ 
                    new SalesforceError('BAD_REQUEST', e.getStackTraceString())
                };
                res.statusCode =400;
                res.responseBody = Blob.valueOf(JSON.serialize(errs));
            }
        }
    }
}