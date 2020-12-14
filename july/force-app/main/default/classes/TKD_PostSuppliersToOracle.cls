/**
 * @description       : 
 * @author            : eduardo.amiens@outlook.com
 * @group             : 
 * @last modified on  : 09-18-2020
 * @last modified by  : eduardo.amiens@outlook.com
 * Modifications Log 
 * Ver   Date         Author                       Modification
 * 1.0   08-06-2020   eduardo.amiens@outlook.com   Initial Version
**/
global class TKD_PostSuppliersToOracle implements Database.Batchable<sObject>,Database.AllowsCallouts, Database.Stateful {
    private  set<Id> supInAppIds {get;set;}
    
    public TKD_PostSuppliersToOracle(set<Id> supInAppIds) { 
        this.supInAppIds = supInAppIds;
        system.debug('suppliersID');
        system.debug(this.supInAppIds);
    }
    
    
    global Integer recordsProcessed =0;
    list<TKD_PostSuppliersResponseWraper.ResponsePostSuppliers> totalrespuestas = new list<TKD_PostSuppliersResponseWraper.ResponsePostSuppliers>();
    global Database.QueryLocator start(Database.BatchableContext bc){
        
        system.debug('suppAppIds: ' + supInAppIds);
        
        return Database.getQueryLocator(
            [Select Id,IsDeleted,Name,CurrencyIsoCode,LastActivityDate,TKD_tx_Vendor_Name__c,
             TKD_tx_Vat_Registration_Num__c,TKD_tx_Contexto__c,TKD_ls_Tipo_de_tercero__c,TKD_ls_Pais_de_residencia__c,Nacionalidad__c,Categoria__c,
             TKD_pd_Supplier_in_approval__c,TKD_tx_amlHits__c,TKD_tl_hitsDescription__c,TKD_un_oracleSupplier__c,
             TKD_tx_Vendor_name_alternative__c,TKD_Vendor_ID__c,TKD_chkb_HaveInvoice__c,TKD_tx_Supplier_Unique_ID__c from Supplier__c
             where TKD_pd_Supplier_in_approval__c IN:supInAppIds]
        );
    }
    
    global void execute(Database.BatchableContext bc, List<Supplier__c> scope){
        List<Id>supplierIds = new list<Id>();
        
        for(Supplier__c supplier: scope){
            supplierIds.add(supplier.Id);
        }
        
        list<TKD_Site__c> sitesOfSuppliers =[Select Id, IsDeleted, Name, TKD_Vat_code__c, CurrencyIsoCode, Supplier__c, tkd_tf_phone__c, primaryPaySiteFlag__c, Pay_Site_Flag__c,  
                                             Tkd_ls_Org_Name__c, inactiveDate__c, Tkd_ls_Country__c, Tkd_at_Address_line_1__c, Tkd_at_Address_line_2__c, Tkd_tx_City__c, TKD_ls_State__c, 
                                             Tkd_tx_Zip__c, TKD_Vendor_Site_ID__c, TKD_Vendor_ID__c, TKD_tx_Country__c, SR_ls_Custom_Currency__c, SR_ls_Currency__c, (Select Id, IsDeleted, MasterRecordId, AccountId, 
                                                                                                                         LastName, FirstName, Salutation, MiddleName, Name, RecordTypeId, MailingStreet, MailingCity, MailingState, 
                                                                                                                         MailingPostalCode, MailingCountry, MailingStateCode, MailingCountryCode, MailingLatitude, MailingLongitude, 
                                                                                                                         MailingGeocodeAccuracy, MailingAddress, Phone, Fax, MobilePhone, ReportsToId, Email, Title, Department, CurrencyIsoCode, 
                                                                                                                         OwnerId, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, LastActivityDate, LastCURequestDate, 
                                                                                                                         LastCUUpdateDate, EmailBouncedReason, EmailBouncedDate, IsEmailBounced, PhotoUrl, 
                                                                                                                         JigsawContactId, IndividualId, CON_ca_Principal__c, CON_fh_Last_Call_Date__c, CON_fh_Last_activity_date__c, 
                                                                                                                         CON_fh_Last_meeting_Date__c, CON_fm_Account_Potential_Category__c, CON_fm_Account_Status__c, CON_fm_Commercial_Name__c, 
                                                                                                                         CON_lm_Line_s_of_bussiness__c, CON_ls_Departament__c, CON_ls_Tittle__c, CON_ls_Type__c, CON_txt_EXT_REF_ID__c, 
                                                                                                                         CON_un_Phone_number_extension__c, Folio__c, LID__LinkedIn_Company_Id__c, LID__LinkedIn_Member_Token__c,  
                                                                                                                         Global_People_ID__c, rrpu__Alert_Message__c, rh2__Currency_Test__c, rh2__Describe__c, rh2__Formula_Test__c, rh2__Integer_Test__c, 
                                                                                                                         Entities_Business_name__c, Historic_Christmas_Present__c, Contact_Comments__c, No_longer_works_there__c, Latest_Date_Survey_Sent__c,
                                                                                                                         Easy_Cold_Calling_Contact__c, Latest_Date_Survey_Responded__c, Account_ID__c, Latests_NPS_Survey_Responded_Link__c, 
                                                                                                                         Insurance_Contact__c, TKD_rb_Site__c,  inactiveDate__c, SR_tf_Phone_area_code__c, TKD_Vendor_Site_ID__c from Contacts__r), 
                                             (Select Id, OwnerId, IsDeleted, Name, CurrencyIsoCode, RecordTypeId, CreatedDate, CreatedById, LastModifiedDate, 
                                              LastModifiedById, SystemModstamp, Entity_Name__c, Bank_Account_Currency__c, Contexto__c, Tipo_BIC__c, Codigo_BIC__c, Nombre_Banco_intermediadio__c, Tipo__c,
                                              Codigo__c,TKD_tx_OraclebankId__c, Pago_a_Cuenta_Concentradora__c, Pago_a_Cta_Concentradora_RN__c,
                                              Bank_Name__c, Bank_Country__c, Mexican_Swift__c, ABA_Swift__c, Intermediary_Bnak_Name__c, Intermediary_Bank_Swift__c, 
                                              Intermediary_Bank_Account_CLABE_IBAN__c, FFC_Name__c, FFC_Ref__c, Virtual_Account__c, Cuenta__c, ABAswift__c, Bank_Account_Name__c, 
                                              TKD_rb_Site__c, TKD_Vendor_Site_ID__c, SR_ls_Country__c, SR_tx_Bank_Name__c, SR_tx_Country__c, SR_ls_Specific_intermediary_bank__c from Bank_Accounts__r) 
                                              from TKD_Site__c where  Supplier__c IN:supplierIds];
        
        
        list<Takedown_Wrapper_NewSupplierInCA.Request_Parameters> parameters = new list<Takedown_Wrapper_NewSupplierInCA.Request_Parameters>();
        
        for(Supplier__c supplier: scope){
            Takedown_Wrapper_NewSupplierInCA.Request_Parameters param = TKD_CreateEstructureBatchPostSuppliers.createPostSuppliers(sitesOfSuppliers, supplier);
            parameters.add(param); 
        }
        
        list<HttpResponse> respuestas = new list<HttpResponse>();
        system.debug('PARAMETROS PARA SERVICIO');
        system.debug(parameters);
        for(Takedown_Wrapper_NewSupplierInCA.Request_Parameters par: parameters){
            string body = JSON.serialize(par, true);
            body = body.replace('sitePostXXXX', 'site');
            body = body.replace('currens', 'currency');
            system.debug('BODYRQ');
            system.debug(body);
            if(Test.isRunningTest()){
                HttpResponse respuesta = null;
                respuestas.add(respuesta);
                TKD_PostSuppliersResponseWraper.ResponsePostSuppliers response = ( TKD_PostSuppliersResponseWraper.ResponsePostSuppliers)JSON.deserializeStrict('{'+
                                                                                                                                                                '  "supplierId" : null,'+
                                                                                                                                                                '  "partyId" : null,'+
                                                                                                                                                                '  "status" : {'+
                                                                                                                                                                '    "code" : null,'+
                                                                                                                                                                '    "message" : "Ha ocurrido un error al crear el Proveedor:  - Proceso XXEC_INT_CREATE_VENDOR - PARTY_ID is invalid - Party ID is invalid",'+
                                                                                                                                                                '    "detail" : "F"'+
                                                                                                                                                                '  }'+
                                                                                                                                                                '}',  TKD_PostSuppliersResponseWraper.ResponsePostSuppliers.class);
                if(response.status.detail =='F'){
                    response.supplierSFID = par.parametros.supplier.supplierId;
                    totalrespuestas.add(response);
                }
                recordsProcessed = recordsProcessed + 1;
            }else{
                HttpResponse respuesta = TKD_WS_PostSuppliers.postSupplier(body);
                respuestas.add(respuesta);
                TKD_PostSuppliersResponseWraper.ResponsePostSuppliers response = ( TKD_PostSuppliersResponseWraper.ResponsePostSuppliers)JSON.deserializeStrict(respuesta.getBody(),  TKD_PostSuppliersResponseWraper.ResponsePostSuppliers.class);
                if(response.status.detail =='F' || response.status.code.contains('Message: Fail')){
                    response.supplierSFID = par.parametros.supplier.supplierId;
                    totalrespuestas.add(response);
                }
                recordsProcessed = recordsProcessed + 1;
            }
            
        }
        
        system.debug('Las respuestas');
        System.debug(respuestas);
        
    }
    
    
    global void finish(Database.BatchableContext bc){
        System.debug(recordsProcessed + 'records processed!');
        
        for(TKD_PostSuppliersResponseWraper.ResponsePostSuppliers res:totalrespuestas){
            
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            String[] toAddresses = new String[] {'juandedios.hernandez@engeniumcapital.com', 'narain.harjani@engeniumcapital.com', 'eduardo.villegas@engeniumcapital.com', 
                'eduardo.correa@engen.com.mx'};
                    mail.setToAddresses(toAddresses);
            mail.setSenderDisplayName('Salesforce ADMIN');
            mail.setSubject('ERROR TO POST TO ORACLE THE SUPPLIER : ' + res.supplierSFID);
            mail.setBccSender(false);
            mail.setUseSignature(false);
            mail.setPlainTextBody('The supplier in salesforce with the ID : ' + res.supplierSFID +' can´t be Posted to Oracle.' +'\n'
                                  + 'We have the next service response:' +'\n' + JSON.serialize(res));
            
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
            
        }
    }
}