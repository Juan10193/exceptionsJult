/**
 * @description       : 
 * @author            : eduardo.amiens@outlook.com
 * @group             : 
 * @last modified on  : 09-09-2020
 * @last modified by  : eduardo.amiens@outlook.com
 * Modifications Log 
 * Ver   Date         Author                       Modification
 * 1.0   09-09-2020   eduardo.amiens@outlook.com   Initial Version
**/
public without sharing class Takedown_Controller_tableAmlHits {
    
    // Metodo que actualiza la informacion de los supplier desde el servicio AML Hits. 
    @AuraEnabled  
    public static void updateInformationSupp(String recordId){        
        System.debug('::::::: updateInformationSupp:::::::');
        System.debug('recordId: ' + recordId); 
        Supplier_in_approval__c supplierInApproval = getIdSupplierInApproval(recordId);
        System.debug('Id updateInformationSupp: '+ supplierInApproval.Id);

        List<Supplier__c> suppliers = [SELECT TKD_tx_Vat_Registration_Num__c,Name, TKD_tx_amlHits__c  FROM Supplier__c where TKD_pd_Supplier_in_approval__c  =: supplierInApproval.Id];

        List<Supplier__c> suppliersTovalidate = new List<Supplier__c>();

        if(suppliers.size()>0 ){
            for(Supplier__c supp : suppliers){
                List<Takedown_Wrapper_SupplierInCA.Parametro> lstParametros = new List<Takedown_Wrapper_SupplierInCA.Parametro>();
                Takedown_Wrapper_SupplierInCA.Parametro param = new Takedown_Wrapper_SupplierInCA.Parametro();
                param.name = supp.Name;
                param.rfc = supp.TKD_tx_Vat_Registration_Num__c;
                System.debug('param.name: ' + param.name); 
                System.debug('param.rfc: ' + param.rfc);
                lstParametros.add(param);
                Takedown_Wrapper_SupplierInCA.responseAmlHits responseAmlHits = getInformationSupplier( lstParametros);
                List<Takedown_Wrapper_SupplierInCA.AmlHits> lstAmlHits= responseAmlHits.result.amlHits;
                system.debug('aml lel we lel');
                system.debug(lstAmlHits);

                
                
                FOR(Takedown_Wrapper_SupplierInCA.AmlHits amlHits : lstAmlHits){
                    if((amlHits.hits == 'true' && supp.TKD_tx_amlHits__c=='false' ) ||(amlHits.hits == 'true' && supp.TKD_tx_amlHits__c=='true') 
                    ||(amlHits.hits == 'true' && (supp.TKD_tx_amlHits__c==''|| supp.TKD_tx_amlHits__c==null))){
                    system.debug('ESTAMOS EN EL TRUE HIT');
                       supp.TKD_tl_hitsDescription__c = amlHits.hitDescription;
                       supp.TKD_tx_amlHits__c = amlHits.hits;
                       if(suppliersTovalidate.contains(supp)){
                        Integer result = suppliersTovalidate.indexOf(supp);
                        suppliersTovalidate.remove(result);
                        suppliersTovalidate.add(supp);
                       }
                       if(!suppliersTovalidate.contains(supp)){
                        suppliersTovalidate.add(supp);
                    }
                    }else if(amlHits.hits == 'false' && (supp.TKD_tx_amlHits__c=='false' || supp.TKD_tx_amlHits__c=='' || supp.TKD_tx_amlHits__c==null)){
                        supp.TKD_tl_hitsDescription__c = amlHits.hitDescription;
                        supp.TKD_tx_amlHits__c = amlHits.hits;
                        if(!suppliersTovalidate.contains(supp)){
                            suppliersTovalidate.add(supp);
                        }
                        
                    }
                }
            }

            System.debug('La lista: ');
            System.debug(suppliersTovalidate);
            try{
                update suppliersTovalidate;
            } catch (DmlException e) {
                System.debug('Ocurrio un error en la clase:Takedown_Controller_tableAmlHits en el metodo: updateInformationSupp: ' + e);
            } 

        }

       /*  Set<String> rfcsSet = new Set<String>();
        Supplier__c [] lstAggregateRfcsResult = [SELECT TKD_tx_Vat_Registration_Num__c,Name  FROM Supplier__c where TKD_pd_Supplier_in_approval__c  =: supplierInApproval.Id];
        for(Supplier__c aggregateResult : lstAggregateRfcsResult) {
            rfcsSet.add(String.valueOf(aggregateResult.get('TKD_tx_Vat_Registration_Num__c')));
        }
        System.debug('rfcsSet USAML: '+ rfcsSet);
        
        List<Takedown_Wrapper_SupplierInCA.Parametro> lstParametros = new List<Takedown_Wrapper_SupplierInCA.Parametro>();
        
        for (Supplier__c supp : lstAggregateRfcsResult){
            Takedown_Wrapper_SupplierInCA.Parametro param = new Takedown_Wrapper_SupplierInCA.Parametro();
            param.name = supp.Name;
            param.rfc = supp.TKD_tx_Vat_Registration_Num__c;            		
            System.debug('param.name: ' + param.name); 
            System.debug('param.rfc: ' + param.rfc);
            lstParametros.add(param);
        }
        System.debug('lstParametros: USAML ' + lstParametros);
        System.debug('lstParametros Size: USAML ' + lstParametros.size());
        
        
        if(lstParametros.size() > 0){
            Takedown_Wrapper_SupplierInCA.responseAmlHits responseAmlHits = getInformationSupplier( lstParametros);            
            List<Takedown_Wrapper_SupplierInCA.AmlHits> lstAmlHits= responseAmlHits.result.amlHits;
            system.debug('aml lel we lel');
            system.debug(lstAmlHits);
            List<String>amlrfcs = new List<String>();
            List <String> amlNames = new list<String>();
            list<Supplier__c> supplierinTakedown = new list<Supplier__c>(); */

            //for (/* Takedown_Wrapper_SupplierInCA.AmlHits amlHits : lstAmlHits){
                /*amlrfcs.add(amlHits.rfc);
                amlNames.add(amlHits.entityName); */
               /*  system.debug('MUERRREEE');
                List<Supplier__c> supplier = [SELECT Id, Name, TKD_tx_Vat_Registration_Num__c FROM Supplier__c where TKD_tx_Vat_Registration_Num__c=: amlHits.rfc and  TKD_pd_Supplier_in_approval__c =: supplierInApproval.Id];
                system.debug('EL supplier:' + supplier);
                system.debug(supplier);
                if(supplier.size()>0){
                    supplier[0].TKD_tx_Vat_Registration_Num__c = amlHits.rfc;
                    //supplier[0].Name = amlHits.entityName;
                    supplier[0].TKD_tx_amlHits__c = amlHits.hits;
                    supplier[0].TKD_tl_hitsDescription__c = amlHits.hitDescription;
                    supplier[0].TKD_Vendor_ID__c  = String.valueOf(amlHits.vendorId); 
                    //supplier[0].TKD_chkb_HaveInvoice__c = true;
                    //supplier[0].TKD_pd_Supplier_in_approval__c = supplierInApproval.Id;           
                    supplierinTakedown.add(supplier[0]);       	 
                } */
                
            //}

            /* List<Supplier__c> supplier = [SELECT Id, TKD_tx_Vat_Registration_Num__c FROM Supplier__c where (TKD_tx_Vat_Registration_Num__c IN: amlrfcs and  TKD_pd_Supplier_in_approval__c =: supplierInApproval.Id) OR (Name IN:amlNames)];
            if(supplier.size()>0){
                for (Supplier__c su : supplier) {
                    for (Takedown_Wrapper_SupplierInCA.AmlHits am : lstAmlHits) {
                        if(am.rfc == su.TKD_tx_Vat_Registration_Num__c && !supplierinTakedown.contains(su)){
                            su.TKD_tx_Vat_Registration_Num__c = am.rfc;
                            //supplier[0].Name = amlHits.entityName;
                            su.TKD_tx_amlHits__c = am.hits;
                            su.TKD_tl_hitsDescription__c = am.hitDescription;
                            //su.TKD_Vendor_ID__c  = String.valueOf(am.vendorId); 
                            //supplier[0].TKD_chkb_HaveInvoice__c = true;
                            //supplier[0].TKD_pd_Supplier_in_approval__c = supplierInApproval.Id;           
                            supplierinTakedown.add(su);     
                        }
                    }
                }
            }

          
            System.debug('La lista: ');
            System.debug(supplierinTakedown);
            try{
                update supplierinTakedown;
            } catch (DmlException e) {
                System.debug('Ocurrio un error en la clase:Takedown_Controller_tableAmlHits en el metodo: updateInformationSupp: ' + e);
            } 
            System.debug('Lista updateInformationSupp USAML' + supplierinTakedown);
        } */
    }
    
    @AuraEnabled
    public static void onSaveSupplierInApproval(String recordId){
        System.debug('Entro al metodo 2'); 
        System.debug('metodo onSaveSupplierInApproval: RecordId ::: '+ recordId);        
        Supplier_in_approval__c supplierInApproval = getIdSupplierInApproval(recordId); 
        if(supplierInApproval != null){
            // solo actualiza campo Hits   
            System.debug('Actualiza campo hits');
            boolean haveHits = Takedown_Controller_SupplierInCA.validationHits(supplierInApproval.Id);
            System.debug('valor haveHits: '+ haveHits);
            System.debug('haveHits ----' + haveHits);
            if(haveHits){
                supplierInApproval.TKD_tx_Hits__c = 'true';
            }else{             	
                supplierInApproval.TKD_tx_Hits__c = 'false';
            }
            try{
                upsert supplierInApproval;
            }catch (DmlException e) {
                System.debug('Ocurrio un error en el metodo: onSaveSupplierInApproval: ' + e);
            } 
            
            
        }    
    } 
    
    

    @AuraEnabled
    public static List<Supplier__c> getSuppliers(String recordId){
        list<Supplier__c>  suplier = [Select Id from Supplier__c where TKD_pd_Supplier_in_approval__r.TKD_rb_SupplierInApproval__r.Id =: recordId];
        System.debug('Lista de suppliers');
        return suplier;
    }
    
    @AuraEnabled
    public static List<Supplier__c>  getAllSupplier(String recordId){
        System.debug('Entro al metodo 1');        
        Supplier_in_approval__c supplierInApproval = getIdSupplierInApproval(recordId);        
        List<Supplier__c> supp = [SELECT Id,
                                  TKD_tx_Vat_Registration_Num__c,
                                  Name,
                                  TKD_tx_amlHits__c,
                                  TKD_tl_hitsDescription__c,
                                  TKD_Vendor_ID__c,
                                  TKD_chkb_HaveInvoice__c,
                                  TKD_pd_Supplier_in_approval__c
                                  FROM 
                                  Supplier__c
                                  where
                                  TKD_pd_Supplier_in_approval__c =: supplierInApproval.Id];
        System.debug('Supp: ' + supp);
        System.debug('Supp SizE: ' + supp.size());           
        
        return supp;
        
    }
    
    @AuraEnabled
    public static Supplier_in_approval__c  getIdSupplierInApproval(String recordId){
        System.debug('metodo getIdSupplierInApproval: RecordId ::: '+ recordId);  
        Supplier_in_approval__c SupplierInApproval = null ;
        List<Supplier_in_approval__c> lstSupplierInApproval = [SELECT Id, TKD_rb_SupplierInApproval__c FROM Supplier_in_approval__c  WHERE TKD_rb_SupplierInApproval__c =: recordId]; 		
        System.debug('Lista Supplier: ' + lstSupplierInApproval.size());       
        if (lstSupplierInApproval.size() > 0) {
            System.debug('If');
            SupplierInApproval = lstSupplierInApproval[0]; 
        }
        System.debug('SupplierInApproval: ' + SupplierInApproval);        
        return SupplierInApproval;               
    }
    
    // metodo que obtiene todos los hits description 
    @AuraEnabled
    public static Supplier__c getHitsDesc(String recordId, String id){
        System.debug('::::::: getHitsDesc :::::::');
        Supplier__c supp = [SELECT Id, TKD_tl_hitsDescription__c FROM Supplier__c where id=: Id];        
        return supp; 
    }
    
    // Metodo para obtener las facturas de acuerdo al name y rfc del proveedor.
    @AuraEnabled
    public static List<Takedown_Invoice__c> getInvoiceByNameOrRfcSupplier(String recordId, String rfc){
        System.debug('::::::: getInvoiceByNameOrRfcSupplier :::::::');
        List<Takedown_Invoice__c> invoice = [SELECT  Id,
                                             Name,
                                             TKD_txt_RFC__c,
                                             TKD_tx_Supplier_name__c,
                                             TKD_pd_Takedown_CP__c,
                                             TKD_rb_Supplier__c,
                                             TKD_txt_Extension__c
                                             FROM  Takedown_Invoice__c 
                                             WHERE TKD_pd_Takedown_CP__c =: recordId ];
        
        System.debug('Lista Invoice: ' + invoice);
        System.debug('Lista Invoice size: ' + invoice.size());
        return invoice; 
    }  
    
    // metodo que elimina los registros de la tabla AML Hits
    @AuraEnabled 
    public static void deleteReg(String idSite, boolean isSite){
        if(isSite){
            
            try{
                TKD_Supplier_TableAMLHits_controller.deleteSupplier(idSite);                                 
            }catch(Exception e){
                System.debug('Ocurrio un error en la clase: Takedown_Controller_tableAmlHits en el metodo: deleteReg  '+ e);
                
            }
        }else{
            Supplier__c supp = new Supplier__c(Id=idSite);
            try{
                delete supp;
            }catch(Exception e){
                System.debug('Ocurrio un error en la clase: Takedown_Controller_tableAmlHits en el metodo: deleteReg  '+ e);
            }
        }
        
        
        
        
        /*System.debug('::::::: delete Site:::::::' + idSite );
try{
TKD_Supplier_TableAMLHits_controller.deleteSupplier(idSite);                                 
}catch(Exception e){
System.debug('Ocurrio un error en la clase: Takedown_Controller_tableAmlHits en el metodo: deleteReg  '+ e);

}*/
        
    }
    
    
    
    @AuraEnabled  
    public static  List<Takedown_Supplier_Site> getAllSupplierTblAmlHits(String recordId){
        List<Takedown_Supplier_Site>  lstSuppSite = new List<Takedown_Supplier_Site>();
        System.debug('::::::: getAllSupplierTblAmlHits :::::::');
        System.debug('recordId: ' + recordId); 
        Supplier_in_approval__c supplierInApproval = getIdSupplierInApproval(recordId);
        System.debug('Id Get Supplier by Invoice: '+ supplierInApproval.Id);
        List<Supplier__c> lstSupplierTblAmlHits  = [SELECT Id,
                                                    Name,
                                                    TKD_tx_Vat_Registration_Num__c,
                                                    TKD_pd_Supplier_in_approval__c,
                                                    TKD_tx_amlHits__c,
                                                    TKD_tl_hitsDescription__c,
                                                    TKD_Vendor_ID__c
                                                    FROM Supplier__c
                                                    where TKD_pd_Supplier_in_approval__c =: supplierInApproval.Id]; 
        
        for(Supplier__c supp : lstSupplierTblAmlHits){
            String concatInvoices ='';
            //Obtener los invoices por supplier para mostrarlos en la tabla  																
            List<Takedown_Invoice__c> lstInvoices = [SELECT  Name FROM Takedown_Invoice__c where TKD_pd_Takedown_CP__c=: recordId and  TKD_txt_RFC__c=: supp.TKD_tx_Vat_Registration_Num__c];
            if(!lstInvoices.isEmpty()){
                for(Takedown_Invoice__c invoice : lstInvoices){
                    concatInvoices= concatInvoices + ', ' + invoice.Name;
                }
                concatInvoices=concatInvoices.substring(1);
                
            }            
            List<TKD_Site__c> lstSitesSupp  = [SELECT  TKD_Vendor_ID__c, Name, CurrencyIsoCode, SR_ls_Currency__c, TKD_Vat_code__c, Id FROM TKD_Site__c where Supplier__c  =: supp.Id]; 
            if(lstSitesSupp.isEmpty()){
                Takedown_Supplier_Site Supp_Site = new Takedown_Supplier_Site();
                Supp_Site.idSupplier =supp.Id;
                Supp_Site.rfc = supp.TKD_tx_Vat_Registration_Num__c;
                Supp_Site.name = supp.Name;
                Supp_Site.amlHits = supp.TKD_tx_amlHits__c;
                Supp_Site.oracleSupplier = supp.TKD_Vendor_ID__c; 
                Supp_Site.currencyCode='NA';
                Supp_Site.taxCode='NA';
                Supp_Site.nameSite='NA';
                Supp_Site.invoice =concatInvoices;
                
                lstSuppSite.add(Supp_Site);
            }else{
                for(TKD_Site__c site: lstSitesSupp){
                    Takedown_Supplier_Site Supp_Site = new Takedown_Supplier_Site();
                    Supp_Site.idSupplier =supp.Id;
                    Supp_Site.rfc = supp.TKD_tx_Vat_Registration_Num__c;
                    Supp_Site.name = supp.Name;
                    Supp_Site.amlHits = supp.TKD_tx_amlHits__c;
                    Supp_Site.oracleSupplier = supp.TKD_Vendor_ID__c; 
                    Supp_Site.idSite =site.Id;
                    Supp_Site.currencyCode = String.valueOf(site.SR_ls_Currency__c);
                    Supp_Site.taxCode = site.TKD_Vat_code__c;
                    Supp_Site.nameSite = site.Name;
                    Supp_Site.invoice =concatInvoices;
                    lstSuppSite.add(Supp_Site);
                } 
            }
            
            
            
        }
        
        System.debug('lstSuppSite: '+ lstSuppSite);
        System.debug('lstSuppSite Size: '+ lstSuppSite.size());
        return lstSuppSite;
        
    }
    
    
    
    
    // ::::::::::::::::::::::::::::::::  Metodos que mandan a llamar a un servicio ::::::::::::::::::::::::::::::::
    
    // Llamando al servicio AML HITS 
    @AuraEnabled 
    public static Takedown_Wrapper_SupplierInCA.responseAmlHits getInformationSupplier(List<Takedown_Wrapper_SupplierInCA.Parametro> datosSupplier) {
        System.debug('String: ' + datosSupplier);        
        Takedown_Wrapper_SupplierInCA.responseAmlHits responseAmlHits = new Takedown_Wrapper_SupplierInCA.responseAmlHits();             
        //Setear los valores al wrapper               
        Takedown_Wrapper_SupplierInCA.requestAmlHits requestAmlHits = new Takedown_Wrapper_SupplierInCA.requestAmlHits();
        requestAmlHits.parametros = new Takedown_Wrapper_SupplierInCA.parametros();       
        requestAmlHits.parametros.parametro = datosSupplier;
        String jsonRequest = System.JSON.serialize(requestAmlHits);
        System.debug(' jsonRequest:::S ' +  jsonRequest );  
        
        responseAmlHits=Takedown_Callout_SupplierInCA.FindSupplierForNameOrRFC(jsonRequest);
        
        System.debug('responseAML-Hits ControllerSICA Ser--- '+ responseAmlHits);
        
        return responseAmlHits; 
    }

    @AuraEnabled
    public static void validateHitsCheck(string takedownId, Boolean validation){
        list<Supplier_in_approval__c> supplierInApp = [Select Id, TKD_Validation_Hits__c from Supplier_in_approval__c where TKD_rb_SupplierInApproval__c =:takedownId];
        list<Supplier_in_approval__c> supplierToUpsert = new List<Supplier_in_approval__c>();
        if(supplierInApp.size()>0){
            for (Supplier_in_approval__c supp : supplierInApp) {
                supp.TKD_Validation_Hits__c = validation;
                supplierToUpsert.add(supp);
            }
            update supplierToUpsert;
        }else{
            system.debug('No hay supplier para actualizar');
        }
    }
    
    

    @AuraEnabled
    public static void validateHitsCheck2(string takedownId, Boolean validation){
        list<Supplier_in_approval__c> supplierInApp = [Select Id, TKD_Validation_Hits__c from Supplier_in_approval__c where TKD_rb_SupplierInApproval__c =:takedownId];
        list<Supplier_in_approval__c> supplierToUpsert = new List<Supplier_in_approval__c>();
        if(supplierInApp.size()>0){
            for (Supplier_in_approval__c supp : supplierInApp) {
                supp.TKD_Validation_Hits__c = validation;
                supplierToUpsert.add(supp);
            }
            update supplierToUpsert;
        }else{
            system.debug('No hay supplier para actualizar');
        }
    }
    


    @AuraEnabled
    public static void validateHitsCheck3(string takedownId, Boolean validation){
        list<Supplier_in_approval__c> supplierInApp = [Select Id, TKD_Validation_Hits__c from Supplier_in_approval__c where TKD_rb_SupplierInApproval__c =:takedownId];
        list<Supplier_in_approval__c> supplierToUpsert = new List<Supplier_in_approval__c>();
        if(supplierInApp.size()>0){
            for (Supplier_in_approval__c supp : supplierInApp) {
                supp.TKD_Validation_Hits__c = validation;
                supplierToUpsert.add(supp);
            }
            update supplierToUpsert;
        }else{
            system.debug('No hay supplier para actualizar');
        }
    }
    
    

    @AuraEnabled
    public static void validateHitsCheck4(string takedownId, Boolean validation){
        list<Supplier_in_approval__c> supplierInApp = [Select Id, TKD_Validation_Hits__c from Supplier_in_approval__c where TKD_rb_SupplierInApproval__c =:takedownId];
        list<Supplier_in_approval__c> supplierToUpsert = new List<Supplier_in_approval__c>();
        if(supplierInApp.size()>0){
            for (Supplier_in_approval__c supp : supplierInApp) {
                supp.TKD_Validation_Hits__c = validation;
                supplierToUpsert.add(supp);
            }
            update supplierToUpsert;
        }else{
            system.debug('No hay supplier para actualizar');
        }
    }
    
    

    @AuraEnabled
    public static void validateHitsCheck5(string takedownId, Boolean validation){
        list<Supplier_in_approval__c> supplierInApp = [Select Id, TKD_Validation_Hits__c from Supplier_in_approval__c where TKD_rb_SupplierInApproval__c =:takedownId];
        list<Supplier_in_approval__c> supplierToUpsert = new List<Supplier_in_approval__c>();
        if(supplierInApp.size()>0){
            for (Supplier_in_approval__c supp : supplierInApp) {
                supp.TKD_Validation_Hits__c = validation;
                supplierToUpsert.add(supp);
            }
            update supplierToUpsert;
        }else{
            system.debug('No hay supplier para actualizar');
        }
    }
    
    
      @AuraEnabled
    public static void validateHitsCheck6(string takedownId, Boolean validation){
        list<Supplier_in_approval__c> supplierInApp = [Select Id, TKD_Validation_Hits__c from Supplier_in_approval__c where TKD_rb_SupplierInApproval__c =:takedownId];
        list<Supplier_in_approval__c> supplierToUpsert = new List<Supplier_in_approval__c>();
        if(supplierInApp.size()>0){
            for (Supplier_in_approval__c supp : supplierInApp) {
                supp.TKD_Validation_Hits__c = validation;
                supplierToUpsert.add(supp);
            }
            update supplierToUpsert;
        }else{
            system.debug('No hay supplier para actualizar');
        }
    }
    


    @AuraEnabled
    public static void validateHitsCheck7(string takedownId, Boolean validation){
        list<Supplier_in_approval__c> supplierInApp = [Select Id, TKD_Validation_Hits__c from Supplier_in_approval__c where TKD_rb_SupplierInApproval__c =:takedownId];
        list<Supplier_in_approval__c> supplierToUpsert = new List<Supplier_in_approval__c>();
        if(supplierInApp.size()>0){
            for (Supplier_in_approval__c supp : supplierInApp) {
                supp.TKD_Validation_Hits__c = validation;
                supplierToUpsert.add(supp);
            }
            update supplierToUpsert;
        }else{
            system.debug('No hay supplier para actualizar');
        }
    }
    
    

    @AuraEnabled
    public static void validateHitsCheck8(string takedownId, Boolean validation){
        list<Supplier_in_approval__c> supplierInApp = [Select Id, TKD_Validation_Hits__c from Supplier_in_approval__c where TKD_rb_SupplierInApproval__c =:takedownId];
        list<Supplier_in_approval__c> supplierToUpsert = new List<Supplier_in_approval__c>();
        if(supplierInApp.size()>0){
            for (Supplier_in_approval__c supp : supplierInApp) {
                supp.TKD_Validation_Hits__c = validation;
                supplierToUpsert.add(supp);
            }
            update supplierToUpsert;
        }else{
            system.debug('No hay supplier para actualizar');
        }
    }
    
    

    @AuraEnabled
    public static void validateHitsCheck9(string takedownId, Boolean validation){
        list<Supplier_in_approval__c> supplierInApp = [Select Id, TKD_Validation_Hits__c from Supplier_in_approval__c where TKD_rb_SupplierInApproval__c =:takedownId];
        list<Supplier_in_approval__c> supplierToUpsert = new List<Supplier_in_approval__c>();
        if(supplierInApp.size()>0){
            for (Supplier_in_approval__c supp : supplierInApp) {
                supp.TKD_Validation_Hits__c = validation;
                supplierToUpsert.add(supp);
            }
            update supplierToUpsert;
        }else{
            system.debug('No hay supplier para actualizar');
        }
    }
    
    
      @AuraEnabled
    public static void validateHitsCheck10(string takedownId, Boolean validation){
        list<Supplier_in_approval__c> supplierInApp = [Select Id, TKD_Validation_Hits__c from Supplier_in_approval__c where TKD_rb_SupplierInApproval__c =:takedownId];
        list<Supplier_in_approval__c> supplierToUpsert = new List<Supplier_in_approval__c>();
        if(supplierInApp.size()>0){
            for (Supplier_in_approval__c supp : supplierInApp) {
                supp.TKD_Validation_Hits__c = validation;
                supplierToUpsert.add(supp);
            }
            update supplierToUpsert;
        }else{
            system.debug('No hay supplier para actualizar');
        }
    }
    


    @AuraEnabled
    public static void validateHitsCheck11(string takedownId, Boolean validation){
        list<Supplier_in_approval__c> supplierInApp = [Select Id, TKD_Validation_Hits__c from Supplier_in_approval__c where TKD_rb_SupplierInApproval__c =:takedownId];
        list<Supplier_in_approval__c> supplierToUpsert = new List<Supplier_in_approval__c>();
        if(supplierInApp.size()>0){
            for (Supplier_in_approval__c supp : supplierInApp) {
                supp.TKD_Validation_Hits__c = validation;
                supplierToUpsert.add(supp);
            }
            update supplierToUpsert;
        }else{
            system.debug('No hay supplier para actualizar');
        }
    }
    
    

    @AuraEnabled
    public static void validateHitsCheck12(string takedownId, Boolean validation){
        list<Supplier_in_approval__c> supplierInApp = [Select Id, TKD_Validation_Hits__c from Supplier_in_approval__c where TKD_rb_SupplierInApproval__c =:takedownId];
        list<Supplier_in_approval__c> supplierToUpsert = new List<Supplier_in_approval__c>();
        if(supplierInApp.size()>0){
            for (Supplier_in_approval__c supp : supplierInApp) {
                supp.TKD_Validation_Hits__c = validation;
                supplierToUpsert.add(supp);
            }
            update supplierToUpsert;
        }else{
            system.debug('No hay supplier para actualizar');
        }
    }
    
    

    @AuraEnabled
    public static void validateHitsCheck13(string takedownId, Boolean validation){
        list<Supplier_in_approval__c> supplierInApp = [Select Id, TKD_Validation_Hits__c from Supplier_in_approval__c where TKD_rb_SupplierInApproval__c =:takedownId];
        list<Supplier_in_approval__c> supplierToUpsert = new List<Supplier_in_approval__c>();
        if(supplierInApp.size()>0){
            for (Supplier_in_approval__c supp : supplierInApp) {
                supp.TKD_Validation_Hits__c = validation;
                supplierToUpsert.add(supp);
            }
            update supplierToUpsert;
        }else{
            system.debug('No hay supplier para actualizar');
        }
    }
    
    
     @AuraEnabled
    public static void validateHitsCheck14(string takedownId, Boolean validation){
        list<Supplier_in_approval__c> supplierInApp = [Select Id, TKD_Validation_Hits__c from Supplier_in_approval__c where TKD_rb_SupplierInApproval__c =:takedownId];
        list<Supplier_in_approval__c> supplierToUpsert = new List<Supplier_in_approval__c>();
        if(supplierInApp.size()>0){
            for (Supplier_in_approval__c supp : supplierInApp) {
                supp.TKD_Validation_Hits__c = validation;
                supplierToUpsert.add(supp);
            }
            update supplierToUpsert;
        }else{
            system.debug('No hay supplier para actualizar');
        }
    }
    
    

    @AuraEnabled
    public static void validateHitsCheck15(string takedownId, Boolean validation){
        list<Supplier_in_approval__c> supplierInApp = [Select Id, TKD_Validation_Hits__c from Supplier_in_approval__c where TKD_rb_SupplierInApproval__c =:takedownId];
        list<Supplier_in_approval__c> supplierToUpsert = new List<Supplier_in_approval__c>();
        if(supplierInApp.size()>0){
            for (Supplier_in_approval__c supp : supplierInApp) {
                supp.TKD_Validation_Hits__c = validation;
                supplierToUpsert.add(supp);
            }
            update supplierToUpsert;
        }else{
            system.debug('No hay supplier para actualizar');
        }
    }
    
    

    @AuraEnabled
    public static void validateHitsCheck16(string takedownId, Boolean validation){
        list<Supplier_in_approval__c> supplierInApp = [Select Id, TKD_Validation_Hits__c from Supplier_in_approval__c where TKD_rb_SupplierInApproval__c =:takedownId];
        list<Supplier_in_approval__c> supplierToUpsert = new List<Supplier_in_approval__c>();
        if(supplierInApp.size()>0){
            for (Supplier_in_approval__c supp : supplierInApp) {
                supp.TKD_Validation_Hits__c = validation;
                supplierToUpsert.add(supp);
            }
            update supplierToUpsert;
        }else{
            system.debug('No hay supplier para actualizar');
        }
    }
    
}