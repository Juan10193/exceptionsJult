public class Takedown_Controller_SupplierInCA { 
    public virtual class BaseException extends Exception {}
    public class OtherException extends BaseException {}


    // Llamando al servicio Known Supplier
    
    @AuraEnabled 
    public static string getKnownSupplier(String recordId, String SearchByRFC,String SearchByName, String SearchByCurrency, String SearchByTaxCode){
      	//Takedown_Wrapper_SearchKnownSuppliers.responseSearchKnownSupplier responseSearchKnownSupplier = new Takedown_Wrapper_SearchKnownSuppliers.responseSearchKnownSupplier();
        if((SearchByRFC !=null & SearchByRFC !='') || (SearchByName != null & SearchByName!='')){      
      	string responseSearchKnownSupplier= Takedown_Callout_SupplierInCA.knownSupplierSearch(SearchByRFC,SearchByName,SearchByCurrency,SearchByTaxCode);
      	System.debug('responseSearchKnownSupplier ControllerSICA Ser--- '+ responseSearchKnownSupplier);
        return responseSearchKnownSupplier;
        }else {
            throw new OtherException('Please Fill RFC or Name');
        }
    }
    
    
    // metodo que obtiene el status de aprobacion de un grupo de supplier 
    @AuraEnabled
    public static Supplier_in_approval__c getStatusSuppInApproval(String recordId){
       System.debug('::::::: getStatusSuppInApproval :::::::');
       Supplier_in_approval__c statusSupp = [SELECT Id,
                                             	tkd_ls_Stage_AML__c,
                                             	tkd_ls_Stage_Supplier__c,
                                             	TKD_tx_Hits__c, 
                                             	TKD_rb_SupplierInApproval__c
                                             	FROM Supplier_in_approval__c 
                                             	WHERE TKD_rb_SupplierInApproval__c=: recordId limit 1];
        System.debug('::::::: getStatusSuppInApproval Return :::::::' + statusSupp );
        return statusSupp; 
    }  

    @AuraEnabled
    public static string getTakedownOperationUnit(string recordId){
        system.debug('recordId: '+ recordId);
        return [SELECT CPL_ls_Operation_Unit__c from Takedowns_Contingency_plan__c where Id =:recordId][0].CPL_ls_Operation_Unit__c;
    }


    //supplierList, TKD_Site__c[] sites, Contact[] contacs, Bank_Account__c[] bankaccounts
    @auraEnabled
    public static void saveListSitess(string recordId, Supplier__c[] supplierList, TKD_Site__c[] sites, Bank_Account__c[] banckaccounts, Contact[] contacts ){
        list<Supplier_in_approval__c> supplierInApproval = [Select Id from Supplier_in_approval__c where TKD_rb_SupplierInApproval__c =: recordId];
        string spplierInapprovalId = null;
        
        system.debug('sites : '+ sites);

        if(supplierInApproval.size()>0){
           system.debug('supplier in approval: ' + supplierInApproval);
           spplierInapprovalId = supplierInApproval.get(0).Id;
           system.debug('sup ina pp id: ' + spplierInapprovalId);
           List<Supplier__c> suppliers = new List<Supplier__c>();
           for (Supplier__c supplier : supplierList) {
               
                supplier.TKD_pd_Supplier_in_approval__c =spplierInapprovalId;
                supplier.TKD_tx_Supplier_Unique_ID__c = recordId + supplier.TKD_tx_Vat_Registration_Num__c;
                supplier.TKD_Vendor_ID__c = String.valueOf(supplier.TKD_Vendor_ID__c) + recordId;
                if(suppliers.contains(supplier) ==false){
                    suppliers.add(supplier);
                }
           }

           Schema.SObjectField supplierUniqueID = Supplier__c.Fields.TKD_tx_Supplier_Unique_ID__c;
           system.debug('suppliers a insertar');
           system.debuG(suppliers);
            Database.UpsertResult[] results = Database.upsert(suppliers, supplierUniqueID, false );
            for (Database.UpsertResult result: results) {
                if (result.isSuccess()) {
                // Operation was successful, so get the ID of the record that was processed
                System.debug('Successfully inserted Supplier. ID: ' + result.getId());
                }else {
                    // Operation failed, so get all errors                
                    for(Database.Error err : result.getErrors()) {
                        System.debug('The following error has occurred.');                    
                        System.debug(err.getStatusCode() + ': ' + err.getMessage());
                        System.debug('Supplier fields that affected this error: ' + err.getFields());
                    }
                }         
            }
            system.debug('suppliers insertados');
            System.debug(suppliers);
            List<TKD_Site__c> sitesList = new List<TKD_Site__c>();
            
            for (Supplier__c supp: suppliers) {
                for (TKD_Site__c sit : sites) {
                    string g = sit.TKD_Vendor_ID__c  + recordId;
                    if(g == supp.TKD_Vendor_ID__c){
                        sit.Supplier__c = supp.Id;
                        sit.TKD_Vendor_Site_ID__c = String.valueof(sit.TKD_Vendor_Site_ID__c) + recordId;
                        sitesList.add(sit);
                    }
                }
            }
            
            Schema.SObjectField vendorSiteId = TKD_Site__c.Fields.TKD_Vendor_Site_ID__c;
            Database.UpsertResult[] resultsites = Database.upsert(sitesList, vendorSiteId, false );
            for (Database.UpsertResult result: resultsites) {
                if (result.isSuccess()) {
                // Operation was successful, so get the ID of the record that was processed
                System.debug('Successfully inserted Site. ID: ' + result.getId());
                }else {
                    // Operation failed, so get all errors                
                    for(Database.Error err : result.getErrors()) {
                        System.debug('The following error has occurred.');                    
                        System.debug(err.getStatusCode() + ': ' + err.getMessage());
                        System.debug('Site fields that affected this error: ' + err.getFields());
                    }
                }         
            }
            
          /*   try{
                insert sitesList;
            }catch(DmlException  e){
                system.debug(LoggingLevel.ERROR, 'Error al insertar sites en El supplier:'+ e.getMessage());
            } */

            system.debug('banckaccounts');
            system.debug(banckaccounts);
            system.debug(sitesList);
             Id recordTypeId =Schema.SObjectType.Bank_Account__c.getRecordTypeInfosByName().get('Supplier Account').getRecordTypeId();
            TKD_KnownSupplierHelp.insertBancks(recordTypeId, sitesList, banckaccounts, contacts, recordId );
        }
    }
    
        @AuraEnabled
    	public static void onSaveSupplierInApproval(String recordId){
        System.debug('Entro al metodo 2'); 
        System.debug('metodo onSaveSupplierInApproval: RecordId ::: '+ recordId);        
        Supplier_in_approval__c supplierInApproval = Takedown_Controller_tableAmlHits.getIdSupplierInApproval(recordId); 
     	
         
        if(supplierInApproval  == null){            
             System.debug('Entro al if de los nulos: ');   
             Supplier_in_approval__c suppInApproval = new Supplier_in_approval__c();
             suppInApproval.TKD_rb_SupplierInApproval__c = recordId;               
            try{
                upsert suppInApproval;
                System.debug('Lista de upsert: '+ suppInApproval);
            }catch (DmlException e) {
                    System.debug('Ocurrio un error en el metodo: onSaveSupplierInApproval: ' + e);
            } 
            System.debug('SupplierInApproval: '+ suppInApproval);
        }else{
			// solo actualiza campo Hits   
			System.debug('Actualiza campo hits');
			boolean haveHits = validationHits(supplierInApproval.Id);
            System.debug('valor haveHits: '+ haveHits);
            //Supplier_in_approval__c suppInApproval = new Supplier_in_approval__c();
            //suppInApproval.Id = supplierInApproval.Id;
            //suppInApproval.TKD_rb_SupplierInApproval__c = recordId; 
            System.debug('haveHits ----' + haveHits);
            if(haveHits){
                supplierInApproval.TKD_tx_Hits__c = 'true';
            }else{             	
                supplierInApproval.TKD_tx_Hits__c = 'false';
            }
            try{
                //upsert suppInApproval;
                update supplierInApproval;
                //System.debug('Lista de upsert: campo hits'+ suppInApproval);
            }catch (DmlException e) {
                    System.debug('Ocurrio un error en el metodo: onSaveSupplierInApproval: ' + e);
            } 
              
			         
        }    
    }
    
     // metodo que verifica si algun supplier de un grupo en aprobacion  tiene hits 
     @AuraEnabled
    public static boolean validationHits(String recordId){
       System.debug('::::::: validationHits :::::::');
        System.debug('RecordId:: ' + recordId);
        Boolean haveHits = false;
        Integer accountHits = [SELECT  COUNT () 
                    	FROM Supplier__c 
                    	WHERE TKD_pd_Supplier_in_approval__c =: recordId 
                    	AND TKD_tx_amlHits__c='true'];
		System.debug('valor accountHits' +  accountHits);        
        if(accountHits >=1 ){
            haveHits = true;
        }
        System.debug('::::::: validationHits Return :::::::' + haveHits );
        return haveHits; 
    }
    
    @AuraEnabled
    public static Supplier_in_approval__c  getIdSupplierInApproval(String recordId){
        System.debug('Entro al metodo 3'); 
        System.debug('metodo getIdSupplierInApproval: RecordId ::: '+ recordId);  
        Supplier_in_approval__c SupplierInApproval = null ;
        List<Supplier_in_approval__c> lstSupplierInApproval = [SELECT Id,
                                                                      TKD_rb_SupplierInApproval__c
                                                               FROM Supplier_in_approval__c 
                                                               WHERE TKD_rb_SupplierInApproval__c =: recordId]; 
		
        System.debug('Lista Supplier: ' + lstSupplierInApproval.size());       
        if (lstSupplierInApproval.size() > 0) {
            System.debug('If');
        	SupplierInApproval = lstSupplierInApproval[0]; 
        }
        System.debug('SupplierInApproval: ' + SupplierInApproval);        
        return SupplierInApproval;               
    }
    
     // Metodo que retorna los Supplier deacuerdo a las facturas registradas en TKD   
    @AuraEnabled  
    public static List<Supplier__c> getSupplierByInvoice(String recordId){
        
        System.debug('::::::: getSupplierByInvoice uno:::::::');
        System.debug('recordId: ' + recordId); 
        Supplier_in_approval__c supplierInApproval = Takedown_Controller_tableAmlHits.getIdSupplierInApproval(recordId);
       	System.debug('Id Get Supplier by Invoice: '+ supplierInApproval.Id);
        Set<String> rfcsSet = new Set<String>();
        Supplier__c [] lstAggregateRfcsResult = [SELECT TKD_tx_Vat_Registration_Num__c FROM Supplier__c where TKD_pd_Supplier_in_approval__c  =: supplierInApproval.Id];
        
        for(Supplier__c aggregateResult : lstAggregateRfcsResult) {
            rfcsSet.add(String.valueOf(aggregateResult.get('TKD_tx_Vat_Registration_Num__c')));
        }
        System.debug('rfcsSet: '+ rfcsSet);
        AggregateResult [] lstAggregateResult  = [SELECT TKD_txt_RFC__c,
                                                	   TKD_tx_Supplier_name__c
                                                	FROM Takedown_Invoice__c 
                                                	WHERE TKD_pd_Takedown_CP__c =: recordId 
                                                  AND TKD_txt_RFC__c NOT IN :rfcsSet
													GROUP BY  TKD_txt_RFC__c,
                                                              TKD_tx_Supplier_name__c];  

        
        List<Takedown_Wrapper_SupplierInCA.Parametro> lstParametros = new List<Takedown_Wrapper_SupplierInCA.Parametro>();
        
        for (AggregateResult aggregateResult : lstAggregateResult){
            		Takedown_Wrapper_SupplierInCA.Parametro param = new Takedown_Wrapper_SupplierInCA.Parametro();
                    if(String.valueOf(aggregateResult.get('TKD_tx_Supplier_name__c')) != null || String.valueOf(aggregateResult.get('TKD_txt_RFC__c')) != null || String.valueOf(aggregateResult.get('TKD_tx_Supplier_name__c')) !='' || String.valueOf(aggregateResult.get('TKD_txt_RFC__c')) !=''){
            		param.name = String.valueOf(aggregateResult.get('TKD_tx_Supplier_name__c'));
            		param.rfc =  String.valueOf(aggregateResult.get('TKD_txt_RFC__c'));            		
                	System.debug('param.name: ' + param.name); 
                 	System.debug('param.rfc: ' + param.rfc);
            		lstParametros.add(param);
        }  
    }
        System.debug('lstParametros: ' + lstParametros);
        System.debug('lstParametros Size: ' + lstParametros.size());
        

        if(lstParametros.size() >= 1){
            //Aqui tendria que pasar primero por el servicio para obtener los  sites antes de pasar al servicio de aml hits 
            Takedown_Wrapper_SupplierInCA.responseAmlHits responseAmlHits = Takedown_Controller_tableAmlHits.getInformationSupplier( lstParametros);            
            List<Takedown_Wrapper_SupplierInCA.AmlHits> lstAmlHits= responseAmlHits.result.amlHits;
            //Metodo que realizará el guardado de los supplier en el objeto Supplier in approval
            List<Supplier__c> supplierinTakedown = new List<Supplier__c>();        
                for (Takedown_Wrapper_SupplierInCA.AmlHits amlHits : lstAmlHits){                
                        Supplier__c supplier = new Supplier__c();            
                        supplier.TKD_tx_Vat_Registration_Num__c = amlHits.rfc;
                        supplier.Name = amlHits.entityName; //Name
                        supplier.TKD_tx_amlHits__c = amlHits.hits;
                        supplier.TKD_tl_hitsDescription__c = amlHits.hitDescription;
                        supplier.TKD_un_oracleSupplier__c = amlHits.vendorId;
                    	supplier.TKD_chkb_HaveInvoice__c = true;
                    	supplier.TKD_pd_Supplier_in_approval__c = supplierInApproval.Id;           
                        supplierinTakedown.add(supplier);                    
                }
                try{
                        upsert supplierinTakedown;
                } catch (DmlException e) {
                    System.debug('Ocurrio un error en la clase : Takedown_Controller_tableAmlHits, en el metodo: getSupplierByInvoice: ' + e);
                } 
                System.debug('Lista supplierinTakedown' + supplierinTakedown);
            	return supplierinTakedown;            	
        }
        return null;
    }
    
    @AuraEnabled
    public static list<string> getallSitesOraIdByRecordId(string takedownId){
        list<TKD_Site__c> sites = [SELECT Id, TKD_Vendor_Site_ID__c  from TKD_Site__c where Supplier__r.TKD_pd_Supplier_in_approval__r.TKD_rb_SupplierInApproval__c =:takedownId AND TKD_Vendor_Site_ID__c != null];
        list<string> sitesIds = new list<string>();

        if(sites.size()>0){
            for(TKD_Site__c site: sites){
                sitesIds.add(site.TKD_Vendor_Site_ID__c);
            }
            return sitesIds; 
        }else{
            system.debug('No hay sites en los suppliers de este takedown');
            return null;
        }    
    }
    
//-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------    
     @auraEnabled
    public static void saveListSitess2(string recordId, Supplier__c[] supplierList, TKD_Site__c[] sites, Bank_Account__c[] banckaccounts, Contact[] contacts ){
        list<Supplier_in_approval__c> supplierInApproval = [Select Id from Supplier_in_approval__c where TKD_rb_SupplierInApproval__c =: recordId];
        string spplierInapprovalId = null;
        
        system.debug('sites : '+ sites);

        if(supplierInApproval.size()>0){
           system.debug('supplier in approval: ' + supplierInApproval);
           spplierInapprovalId = supplierInApproval.get(0).Id;
           system.debug('sup ina pp id: ' + spplierInapprovalId);
           List<Supplier__c> suppliers = new List<Supplier__c>();
           for (Supplier__c supplier : supplierList) {
               
                supplier.TKD_pd_Supplier_in_approval__c =spplierInapprovalId;
                supplier.TKD_tx_Supplier_Unique_ID__c = recordId + supplier.TKD_tx_Vat_Registration_Num__c;
                supplier.TKD_Vendor_ID__c = String.valueOf(supplier.TKD_Vendor_ID__c) + recordId;
                if(suppliers.contains(supplier) ==false){
                    suppliers.add(supplier);
                }
           }

           Schema.SObjectField supplierUniqueID = Supplier__c.Fields.TKD_tx_Supplier_Unique_ID__c;
           system.debug('suppliers a insertar');
           system.debuG(suppliers);
            Database.UpsertResult[] results = Database.upsert(suppliers, supplierUniqueID, false );
            for (Database.UpsertResult result: results) {
                if (result.isSuccess()) {
                // Operation was successful, so get the ID of the record that was processed
                System.debug('Successfully inserted Supplier. ID: ' + result.getId());
                }else {
                    // Operation failed, so get all errors                
                    for(Database.Error err : result.getErrors()) {
                        System.debug('The following error has occurred.');                    
                        System.debug(err.getStatusCode() + ': ' + err.getMessage());
                        System.debug('Supplier fields that affected this error: ' + err.getFields());
                    }
                }         
            }
            system.debug('suppliers insertados');
            System.debug(suppliers);
            List<TKD_Site__c> sitesList = new List<TKD_Site__c>();
            
            for (Supplier__c supp: suppliers) {
                for (TKD_Site__c sit : sites) {
                    string g = sit.TKD_Vendor_ID__c  + recordId;
                    if(g == supp.TKD_Vendor_ID__c){
                        sit.Supplier__c = supp.Id;
                        sit.TKD_Vendor_Site_ID__c = String.valueof(sit.TKD_Vendor_Site_ID__c) + recordId;
                        sitesList.add(sit);
                    }
                }
            }
            
            Schema.SObjectField vendorSiteId = TKD_Site__c.Fields.TKD_Vendor_Site_ID__c;
            Database.UpsertResult[] resultsites = Database.upsert(sitesList, vendorSiteId, false );
            for (Database.UpsertResult result: resultsites) {
                if (result.isSuccess()) {
                // Operation was successful, so get the ID of the record that was processed
                System.debug('Successfully inserted Site. ID: ' + result.getId());
                }else {
                    // Operation failed, so get all errors                
                    for(Database.Error err : result.getErrors()) {
                        System.debug('The following error has occurred.');                    
                        System.debug(err.getStatusCode() + ': ' + err.getMessage());
                        System.debug('Site fields that affected this error: ' + err.getFields());
                    }
                }         
            }
            
          /*   try{
                insert sitesList;
            }catch(DmlException  e){
                system.debug(LoggingLevel.ERROR, 'Error al insertar sites en El supplier:'+ e.getMessage());
            } */

            system.debug('banckaccounts');
            system.debug(banckaccounts);
            system.debug(sitesList);
             Id recordTypeId =Schema.SObjectType.Bank_Account__c.getRecordTypeInfosByName().get('Supplier Account').getRecordTypeId();
            TKD_KnownSupplierHelp.insertBancks(recordTypeId, sitesList, banckaccounts, contacts, recordId );
        }
    }
    
      @auraEnabled
    public static void saveListSitess3(string recordId, Supplier__c[] supplierList, TKD_Site__c[] sites, Bank_Account__c[] banckaccounts, Contact[] contacts ){
        list<Supplier_in_approval__c> supplierInApproval = [Select Id from Supplier_in_approval__c where TKD_rb_SupplierInApproval__c =: recordId];
        string spplierInapprovalId = null;
        
        system.debug('sites : '+ sites);

        if(supplierInApproval.size()>0){
           system.debug('supplier in approval: ' + supplierInApproval);
           spplierInapprovalId = supplierInApproval.get(0).Id;
           system.debug('sup ina pp id: ' + spplierInapprovalId);
           List<Supplier__c> suppliers = new List<Supplier__c>();
           for (Supplier__c supplier : supplierList) {
               
                supplier.TKD_pd_Supplier_in_approval__c =spplierInapprovalId;
                supplier.TKD_tx_Supplier_Unique_ID__c = recordId + supplier.TKD_tx_Vat_Registration_Num__c;
                supplier.TKD_Vendor_ID__c = String.valueOf(supplier.TKD_Vendor_ID__c) + recordId;
                if(suppliers.contains(supplier) ==false){
                    suppliers.add(supplier);
                }
           }

           Schema.SObjectField supplierUniqueID = Supplier__c.Fields.TKD_tx_Supplier_Unique_ID__c;
           system.debug('suppliers a insertar');
           system.debuG(suppliers);
            Database.UpsertResult[] results = Database.upsert(suppliers, supplierUniqueID, false );
            for (Database.UpsertResult result: results) {
                if (result.isSuccess()) {
                // Operation was successful, so get the ID of the record that was processed
                System.debug('Successfully inserted Supplier. ID: ' + result.getId());
                }else {
                    // Operation failed, so get all errors                
                    for(Database.Error err : result.getErrors()) {
                        System.debug('The following error has occurred.');                    
                        System.debug(err.getStatusCode() + ': ' + err.getMessage());
                        System.debug('Supplier fields that affected this error: ' + err.getFields());
                    }
                }         
            }
            system.debug('suppliers insertados');
            System.debug(suppliers);
            List<TKD_Site__c> sitesList = new List<TKD_Site__c>();
            
            for (Supplier__c supp: suppliers) {
                for (TKD_Site__c sit : sites) {
                    string g = sit.TKD_Vendor_ID__c  + recordId;
                    if(g == supp.TKD_Vendor_ID__c){
                        sit.Supplier__c = supp.Id;
                        sit.TKD_Vendor_Site_ID__c = String.valueof(sit.TKD_Vendor_Site_ID__c) + recordId;
                        sitesList.add(sit);
                    }
                }
            }
            
            Schema.SObjectField vendorSiteId = TKD_Site__c.Fields.TKD_Vendor_Site_ID__c;
            Database.UpsertResult[] resultsites = Database.upsert(sitesList, vendorSiteId, false );
            for (Database.UpsertResult result: resultsites) {
                if (result.isSuccess()) {
                // Operation was successful, so get the ID of the record that was processed
                System.debug('Successfully inserted Site. ID: ' + result.getId());
                }else {
                    // Operation failed, so get all errors                
                    for(Database.Error err : result.getErrors()) {
                        System.debug('The following error has occurred.');                    
                        System.debug(err.getStatusCode() + ': ' + err.getMessage());
                        System.debug('Site fields that affected this error: ' + err.getFields());
                    }
                }         
            }
            
          /*   try{
                insert sitesList;
            }catch(DmlException  e){
                system.debug(LoggingLevel.ERROR, 'Error al insertar sites en El supplier:'+ e.getMessage());
            } */

            system.debug('banckaccounts');
            system.debug(banckaccounts);
            system.debug(sitesList);
             Id recordTypeId =Schema.SObjectType.Bank_Account__c.getRecordTypeInfosByName().get('Supplier Account').getRecordTypeId();
            TKD_KnownSupplierHelp.insertBancks(recordTypeId, sitesList, banckaccounts, contacts, recordId );
        }
    }
    
    @AuraEnabled
    public static Supplier_in_approval__c getStatusSuppInApproval2(String recordId){
       System.debug('::::::: getStatusSuppInApproval :::::::');
       Supplier_in_approval__c statusSupp = [SELECT Id,
                                             	tkd_ls_Stage_AML__c,
                                             	tkd_ls_Stage_Supplier__c,
                                             	TKD_tx_Hits__c, 
                                             	TKD_rb_SupplierInApproval__c
                                             	FROM Supplier_in_approval__c 
                                             	WHERE TKD_rb_SupplierInApproval__c=: recordId limit 1];
        System.debug('::::::: getStatusSuppInApproval Return :::::::' + statusSupp );
        return statusSupp; 
    }  

    @AuraEnabled
    public static string getTakedownOperationUnit2(string recordId){
        system.debug('recordId: '+ recordId);
        return [SELECT CPL_ls_Operation_Unit__c from Takedowns_Contingency_plan__c where Id =:recordId][0].CPL_ls_Operation_Unit__c;
    }
    
     @auraEnabled
    public static void saveListSitess4(string recordId, Supplier__c[] supplierList, TKD_Site__c[] sites, Bank_Account__c[] banckaccounts, Contact[] contacts ){
        list<Supplier_in_approval__c> supplierInApproval = [Select Id from Supplier_in_approval__c where TKD_rb_SupplierInApproval__c =: recordId];
        string spplierInapprovalId = null;
        
        system.debug('sites : '+ sites);

        if(supplierInApproval.size()>0){
           system.debug('supplier in approval: ' + supplierInApproval);
           spplierInapprovalId = supplierInApproval.get(0).Id;
           system.debug('sup ina pp id: ' + spplierInapprovalId);
           List<Supplier__c> suppliers = new List<Supplier__c>();
           for (Supplier__c supplier : supplierList) {
               
                supplier.TKD_pd_Supplier_in_approval__c =spplierInapprovalId;
                supplier.TKD_tx_Supplier_Unique_ID__c = recordId + supplier.TKD_tx_Vat_Registration_Num__c;
                supplier.TKD_Vendor_ID__c = String.valueOf(supplier.TKD_Vendor_ID__c) + recordId;
                if(suppliers.contains(supplier) ==false){
                    suppliers.add(supplier);
                }
           }

           Schema.SObjectField supplierUniqueID = Supplier__c.Fields.TKD_tx_Supplier_Unique_ID__c;
           system.debug('suppliers a insertar');
           system.debuG(suppliers);
            Database.UpsertResult[] results = Database.upsert(suppliers, supplierUniqueID, false );
            for (Database.UpsertResult result: results) {
                if (result.isSuccess()) {
                // Operation was successful, so get the ID of the record that was processed
                System.debug('Successfully inserted Supplier. ID: ' + result.getId());
                }else {
                    // Operation failed, so get all errors                
                    for(Database.Error err : result.getErrors()) {
                        System.debug('The following error has occurred.');                    
                        System.debug(err.getStatusCode() + ': ' + err.getMessage());
                        System.debug('Supplier fields that affected this error: ' + err.getFields());
                    }
                }         
            }
            system.debug('suppliers insertados');
            System.debug(suppliers);
            List<TKD_Site__c> sitesList = new List<TKD_Site__c>();
            
            for (Supplier__c supp: suppliers) {
                for (TKD_Site__c sit : sites) {
                    string g = sit.TKD_Vendor_ID__c  + recordId;
                    if(g == supp.TKD_Vendor_ID__c){
                        sit.Supplier__c = supp.Id;
                        sit.TKD_Vendor_Site_ID__c = String.valueof(sit.TKD_Vendor_Site_ID__c) + recordId;
                        sitesList.add(sit);
                    }
                }
            }
            
            Schema.SObjectField vendorSiteId = TKD_Site__c.Fields.TKD_Vendor_Site_ID__c;
            Database.UpsertResult[] resultsites = Database.upsert(sitesList, vendorSiteId, false );
            for (Database.UpsertResult result: resultsites) {
                if (result.isSuccess()) {
                // Operation was successful, so get the ID of the record that was processed
                System.debug('Successfully inserted Site. ID: ' + result.getId());
                }else {
                    // Operation failed, so get all errors                
                    for(Database.Error err : result.getErrors()) {
                        System.debug('The following error has occurred.');                    
                        System.debug(err.getStatusCode() + ': ' + err.getMessage());
                        System.debug('Site fields that affected this error: ' + err.getFields());
                    }
                }         
            }
            
          /*   try{
                insert sitesList;
            }catch(DmlException  e){
                system.debug(LoggingLevel.ERROR, 'Error al insertar sites en El supplier:'+ e.getMessage());
            } */

            system.debug('banckaccounts');
            system.debug(banckaccounts);
            system.debug(sitesList);
             Id recordTypeId =Schema.SObjectType.Bank_Account__c.getRecordTypeInfosByName().get('Supplier Account').getRecordTypeId();
            TKD_KnownSupplierHelp.insertBancks(recordTypeId, sitesList, banckaccounts, contacts, recordId );
        }
    }
    
      @auraEnabled
    public static void saveListSitess5(string recordId, Supplier__c[] supplierList, TKD_Site__c[] sites, Bank_Account__c[] banckaccounts, Contact[] contacts ){
        list<Supplier_in_approval__c> supplierInApproval = [Select Id from Supplier_in_approval__c where TKD_rb_SupplierInApproval__c =: recordId];
        string spplierInapprovalId = null;
        
        system.debug('sites : '+ sites);

        if(supplierInApproval.size()>0){
           system.debug('supplier in approval: ' + supplierInApproval);
           spplierInapprovalId = supplierInApproval.get(0).Id;
           system.debug('sup ina pp id: ' + spplierInapprovalId);
           List<Supplier__c> suppliers = new List<Supplier__c>();
           for (Supplier__c supplier : supplierList) {
               
                supplier.TKD_pd_Supplier_in_approval__c =spplierInapprovalId;
                supplier.TKD_tx_Supplier_Unique_ID__c = recordId + supplier.TKD_tx_Vat_Registration_Num__c;
                supplier.TKD_Vendor_ID__c = String.valueOf(supplier.TKD_Vendor_ID__c) + recordId;
                if(suppliers.contains(supplier) ==false){
                    suppliers.add(supplier);
                }
           }

           Schema.SObjectField supplierUniqueID = Supplier__c.Fields.TKD_tx_Supplier_Unique_ID__c;
           system.debug('suppliers a insertar');
           system.debuG(suppliers);
            Database.UpsertResult[] results = Database.upsert(suppliers, supplierUniqueID, false );
            for (Database.UpsertResult result: results) {
                if (result.isSuccess()) {
                // Operation was successful, so get the ID of the record that was processed
                System.debug('Successfully inserted Supplier. ID: ' + result.getId());
                }else {
                    // Operation failed, so get all errors                
                    for(Database.Error err : result.getErrors()) {
                        System.debug('The following error has occurred.');                    
                        System.debug(err.getStatusCode() + ': ' + err.getMessage());
                        System.debug('Supplier fields that affected this error: ' + err.getFields());
                    }
                }         
            }
            system.debug('suppliers insertados');
            System.debug(suppliers);
            List<TKD_Site__c> sitesList = new List<TKD_Site__c>();
            
            for (Supplier__c supp: suppliers) {
                for (TKD_Site__c sit : sites) {
                    string g = sit.TKD_Vendor_ID__c  + recordId;
                    if(g == supp.TKD_Vendor_ID__c){
                        sit.Supplier__c = supp.Id;
                        sit.TKD_Vendor_Site_ID__c = String.valueof(sit.TKD_Vendor_Site_ID__c) + recordId;
                        sitesList.add(sit);
                    }
                }
            }
            
            Schema.SObjectField vendorSiteId = TKD_Site__c.Fields.TKD_Vendor_Site_ID__c;
            Database.UpsertResult[] resultsites = Database.upsert(sitesList, vendorSiteId, false );
            for (Database.UpsertResult result: resultsites) {
                if (result.isSuccess()) {
                // Operation was successful, so get the ID of the record that was processed
                System.debug('Successfully inserted Site. ID: ' + result.getId());
                }else {
                    // Operation failed, so get all errors                
                    for(Database.Error err : result.getErrors()) {
                        System.debug('The following error has occurred.');                    
                        System.debug(err.getStatusCode() + ': ' + err.getMessage());
                        System.debug('Site fields that affected this error: ' + err.getFields());
                    }
                }         
            }
            
          /*   try{
                insert sitesList;
            }catch(DmlException  e){
                system.debug(LoggingLevel.ERROR, 'Error al insertar sites en El supplier:'+ e.getMessage());
            } */

            system.debug('banckaccounts');
            system.debug(banckaccounts);
            system.debug(sitesList);
             Id recordTypeId =Schema.SObjectType.Bank_Account__c.getRecordTypeInfosByName().get('Supplier Account').getRecordTypeId();
            TKD_KnownSupplierHelp.insertBancks(recordTypeId, sitesList, banckaccounts, contacts, recordId );
        }
    }
    
      @auraEnabled
    public static void saveListSitess6(string recordId, Supplier__c[] supplierList, TKD_Site__c[] sites, Bank_Account__c[] banckaccounts, Contact[] contacts ){
        list<Supplier_in_approval__c> supplierInApproval = [Select Id from Supplier_in_approval__c where TKD_rb_SupplierInApproval__c =: recordId];
        string spplierInapprovalId = null;
        
        system.debug('sites : '+ sites);

        if(supplierInApproval.size()>0){
           system.debug('supplier in approval: ' + supplierInApproval);
           spplierInapprovalId = supplierInApproval.get(0).Id;
           system.debug('sup ina pp id: ' + spplierInapprovalId);
           List<Supplier__c> suppliers = new List<Supplier__c>();
           for (Supplier__c supplier : supplierList) {
               
                supplier.TKD_pd_Supplier_in_approval__c =spplierInapprovalId;
                supplier.TKD_tx_Supplier_Unique_ID__c = recordId + supplier.TKD_tx_Vat_Registration_Num__c;
                supplier.TKD_Vendor_ID__c = String.valueOf(supplier.TKD_Vendor_ID__c) + recordId;
                if(suppliers.contains(supplier) ==false){
                    suppliers.add(supplier);
                }
           }

           Schema.SObjectField supplierUniqueID = Supplier__c.Fields.TKD_tx_Supplier_Unique_ID__c;
           system.debug('suppliers a insertar');
           system.debuG(suppliers);
            Database.UpsertResult[] results = Database.upsert(suppliers, supplierUniqueID, false );
            for (Database.UpsertResult result: results) {
                if (result.isSuccess()) {
                // Operation was successful, so get the ID of the record that was processed
                System.debug('Successfully inserted Supplier. ID: ' + result.getId());
                }else {
                    // Operation failed, so get all errors                
                    for(Database.Error err : result.getErrors()) {
                        System.debug('The following error has occurred.');                    
                        System.debug(err.getStatusCode() + ': ' + err.getMessage());
                        System.debug('Supplier fields that affected this error: ' + err.getFields());
                    }
                }         
            }
            system.debug('suppliers insertados');
            System.debug(suppliers);
            List<TKD_Site__c> sitesList = new List<TKD_Site__c>();
            
            for (Supplier__c supp: suppliers) {
                for (TKD_Site__c sit : sites) {
                    string g = sit.TKD_Vendor_ID__c  + recordId;
                    if(g == supp.TKD_Vendor_ID__c){
                        sit.Supplier__c = supp.Id;
                        sit.TKD_Vendor_Site_ID__c = String.valueof(sit.TKD_Vendor_Site_ID__c) + recordId;
                        sitesList.add(sit);
                    }
                }
            }
            
            Schema.SObjectField vendorSiteId = TKD_Site__c.Fields.TKD_Vendor_Site_ID__c;
            Database.UpsertResult[] resultsites = Database.upsert(sitesList, vendorSiteId, false );
            for (Database.UpsertResult result: resultsites) {
                if (result.isSuccess()) {
                // Operation was successful, so get the ID of the record that was processed
                System.debug('Successfully inserted Site. ID: ' + result.getId());
                }else {
                    // Operation failed, so get all errors                
                    for(Database.Error err : result.getErrors()) {
                        System.debug('The following error has occurred.');                    
                        System.debug(err.getStatusCode() + ': ' + err.getMessage());
                        System.debug('Site fields that affected this error: ' + err.getFields());
                    }
                }         
            }
            
          /*   try{
                insert sitesList;
            }catch(DmlException  e){
                system.debug(LoggingLevel.ERROR, 'Error al insertar sites en El supplier:'+ e.getMessage());
            } */

            system.debug('banckaccounts');
            system.debug(banckaccounts);
            system.debug(sitesList);
             Id recordTypeId =Schema.SObjectType.Bank_Account__c.getRecordTypeInfosByName().get('Supplier Account').getRecordTypeId();
            TKD_KnownSupplierHelp.insertBancks(recordTypeId, sitesList, banckaccounts, contacts, recordId );
        }
    }
    
       @auraEnabled
    public static void saveListSitess7(string recordId, Supplier__c[] supplierList, TKD_Site__c[] sites, Bank_Account__c[] banckaccounts, Contact[] contacts ){
        list<Supplier_in_approval__c> supplierInApproval = [Select Id from Supplier_in_approval__c where TKD_rb_SupplierInApproval__c =: recordId];
        string spplierInapprovalId = null;
        
        system.debug('sites : '+ sites);

        if(supplierInApproval.size()>0){
           system.debug('supplier in approval: ' + supplierInApproval);
           spplierInapprovalId = supplierInApproval.get(0).Id;
           system.debug('sup ina pp id: ' + spplierInapprovalId);
           List<Supplier__c> suppliers = new List<Supplier__c>();
           for (Supplier__c supplier : supplierList) {
               
                supplier.TKD_pd_Supplier_in_approval__c =spplierInapprovalId;
                supplier.TKD_tx_Supplier_Unique_ID__c = recordId + supplier.TKD_tx_Vat_Registration_Num__c;
                supplier.TKD_Vendor_ID__c = String.valueOf(supplier.TKD_Vendor_ID__c) + recordId;
                if(suppliers.contains(supplier) ==false){
                    suppliers.add(supplier);
                }
           }

           Schema.SObjectField supplierUniqueID = Supplier__c.Fields.TKD_tx_Supplier_Unique_ID__c;
           system.debug('suppliers a insertar');
           system.debuG(suppliers);
            Database.UpsertResult[] results = Database.upsert(suppliers, supplierUniqueID, false );
            for (Database.UpsertResult result: results) {
                if (result.isSuccess()) {
                // Operation was successful, so get the ID of the record that was processed
                System.debug('Successfully inserted Supplier. ID: ' + result.getId());
                }else {
                    // Operation failed, so get all errors                
                    for(Database.Error err : result.getErrors()) {
                        System.debug('The following error has occurred.');                    
                        System.debug(err.getStatusCode() + ': ' + err.getMessage());
                        System.debug('Supplier fields that affected this error: ' + err.getFields());
                    }
                }         
            }
            system.debug('suppliers insertados');
            System.debug(suppliers);
            List<TKD_Site__c> sitesList = new List<TKD_Site__c>();
            
            for (Supplier__c supp: suppliers) {
                for (TKD_Site__c sit : sites) {
                    string g = sit.TKD_Vendor_ID__c  + recordId;
                    if(g == supp.TKD_Vendor_ID__c){
                        sit.Supplier__c = supp.Id;
                        sit.TKD_Vendor_Site_ID__c = String.valueof(sit.TKD_Vendor_Site_ID__c) + recordId;
                        sitesList.add(sit);
                    }
                }
            }
            
            Schema.SObjectField vendorSiteId = TKD_Site__c.Fields.TKD_Vendor_Site_ID__c;
            Database.UpsertResult[] resultsites = Database.upsert(sitesList, vendorSiteId, false );
            for (Database.UpsertResult result: resultsites) {
                if (result.isSuccess()) {
                // Operation was successful, so get the ID of the record that was processed
                System.debug('Successfully inserted Site. ID: ' + result.getId());
                }else {
                    // Operation failed, so get all errors                
                    for(Database.Error err : result.getErrors()) {
                        System.debug('The following error has occurred.');                    
                        System.debug(err.getStatusCode() + ': ' + err.getMessage());
                        System.debug('Site fields that affected this error: ' + err.getFields());
                    }
                }         
            }
            
          /*   try{
                insert sitesList;
            }catch(DmlException  e){
                system.debug(LoggingLevel.ERROR, 'Error al insertar sites en El supplier:'+ e.getMessage());
            } */

            system.debug('banckaccounts');
            system.debug(banckaccounts);
            system.debug(sitesList);
             Id recordTypeId =Schema.SObjectType.Bank_Account__c.getRecordTypeInfosByName().get('Supplier Account').getRecordTypeId();
            TKD_KnownSupplierHelp.insertBancks(recordTypeId, sitesList, banckaccounts, contacts, recordId );
        }
    }
    
       @auraEnabled
    public static void saveListSitess8(string recordId, Supplier__c[] supplierList, TKD_Site__c[] sites, Bank_Account__c[] banckaccounts, Contact[] contacts ){
        list<Supplier_in_approval__c> supplierInApproval = [Select Id from Supplier_in_approval__c where TKD_rb_SupplierInApproval__c =: recordId];
        string spplierInapprovalId = null;
        
        system.debug('sites : '+ sites);

        if(supplierInApproval.size()>0){
           system.debug('supplier in approval: ' + supplierInApproval);
           spplierInapprovalId = supplierInApproval.get(0).Id;
           system.debug('sup ina pp id: ' + spplierInapprovalId);
           List<Supplier__c> suppliers = new List<Supplier__c>();
           for (Supplier__c supplier : supplierList) {
               
                supplier.TKD_pd_Supplier_in_approval__c =spplierInapprovalId;
                supplier.TKD_tx_Supplier_Unique_ID__c = recordId + supplier.TKD_tx_Vat_Registration_Num__c;
                supplier.TKD_Vendor_ID__c = String.valueOf(supplier.TKD_Vendor_ID__c) + recordId;
                if(suppliers.contains(supplier) ==false){
                    suppliers.add(supplier);
                }
           }

           Schema.SObjectField supplierUniqueID = Supplier__c.Fields.TKD_tx_Supplier_Unique_ID__c;
           system.debug('suppliers a insertar');
           system.debuG(suppliers);
            Database.UpsertResult[] results = Database.upsert(suppliers, supplierUniqueID, false );
            for (Database.UpsertResult result: results) {
                if (result.isSuccess()) {
                // Operation was successful, so get the ID of the record that was processed
                System.debug('Successfully inserted Supplier. ID: ' + result.getId());
                }else {
                    // Operation failed, so get all errors                
                    for(Database.Error err : result.getErrors()) {
                        System.debug('The following error has occurred.');                    
                        System.debug(err.getStatusCode() + ': ' + err.getMessage());
                        System.debug('Supplier fields that affected this error: ' + err.getFields());
                    }
                }         
            }
            system.debug('suppliers insertados');
            System.debug(suppliers);
            List<TKD_Site__c> sitesList = new List<TKD_Site__c>();
            
            for (Supplier__c supp: suppliers) {
                for (TKD_Site__c sit : sites) {
                    string g = sit.TKD_Vendor_ID__c  + recordId;
                    if(g == supp.TKD_Vendor_ID__c){
                        sit.Supplier__c = supp.Id;
                        sit.TKD_Vendor_Site_ID__c = String.valueof(sit.TKD_Vendor_Site_ID__c) + recordId;
                        sitesList.add(sit);
                    }
                }
            }
            
            Schema.SObjectField vendorSiteId = TKD_Site__c.Fields.TKD_Vendor_Site_ID__c;
            Database.UpsertResult[] resultsites = Database.upsert(sitesList, vendorSiteId, false );
            for (Database.UpsertResult result: resultsites) {
                if (result.isSuccess()) {
                // Operation was successful, so get the ID of the record that was processed
                System.debug('Successfully inserted Site. ID: ' + result.getId());
                }else {
                    // Operation failed, so get all errors                
                    for(Database.Error err : result.getErrors()) {
                        System.debug('The following error has occurred.');                    
                        System.debug(err.getStatusCode() + ': ' + err.getMessage());
                        System.debug('Site fields that affected this error: ' + err.getFields());
                    }
                }         
            }
            
          /*   try{
                insert sitesList;
            }catch(DmlException  e){
                system.debug(LoggingLevel.ERROR, 'Error al insertar sites en El supplier:'+ e.getMessage());
            } */

            system.debug('banckaccounts');
            system.debug(banckaccounts);
            system.debug(sitesList);
             Id recordTypeId =Schema.SObjectType.Bank_Account__c.getRecordTypeInfosByName().get('Supplier Account').getRecordTypeId();
            TKD_KnownSupplierHelp.insertBancks(recordTypeId, sitesList, banckaccounts, contacts, recordId );
        }
    }
}