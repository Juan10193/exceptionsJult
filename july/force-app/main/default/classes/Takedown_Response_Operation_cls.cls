/**
 * @File Name          : Takedown_Response_Operation_cls.cls
 * @Description        : 
 * @Author             : eduardo.amiens@outlook.com
 * @Group              : 
 * @Last Modified By   : eduardo.amiens@outlook.com
 * @Last Modified On   : 10/8/2019 21:44:53
 * @Modification Log   : 
 *==============================================================================
 * Ver         Date                     Author      		      Modification
 *==============================================================================
 * 1.0    10/8/2019 20:09:32   eduardo.amiens@outlook.com     Initial Version
**/
public with sharing class Takedown_Response_Operation_cls {
    public id AccountID	{get;set;}
    
    public Takedown_Response_Operation_cls(id AccountID) {
        this.AccountID = AccountID;

    }
    public void Work_Response_ValidateData(Takedown_Wrapper_SATVal_OL_cls.SATValResponse SATValResponse, id documentId, list<Supplier__c> listSupplier, id takedownID){
        try{
        List<Takedown_Invoice__c> listTakedown_Invoice = new List<Takedown_Invoice__c>();
            Takedown_Invoice__c Takedown_Invoice = new Takedown_Invoice__c();
            
        	Takedown_Invoice.TKD_tl_Eng_message__c = SATValResponse.ResponseValidatorVO == null ? '' : String.isEmpty(SATValResponse.ResponseValidatorVO.message) ? null : SATValResponse.ResponseValidatorVO.message;
            Takedown_Invoice.TKD_ls_Eng_Status__c =  SATValResponse.ResponseValidatorVO == null ? ChangeStatus('') : String.isEmpty(SATValResponse.ResponseValidatorVO.success) ? null : ChangeStatus(SATValResponse.ResponseValidatorVO.success);
            
            Takedown_Invoice.TKD_tl_SAT_message__c = SATValResponse.ResponseSatVO == null ? '' : String.isEmpty(SATValResponse.ResponseSatVO.messsage) ? null : SATValResponse.ResponseSatVO.messsage;
            Takedown_Invoice.TKD_ls_SAT_Status__c = SATValResponse.ResponseSatVO == null ? ChangeStatus('') : String.isEmpty(SATValResponse.ResponseSatVO.statusDescription) ? null : ChangeStatus(SATValResponse.ResponseSatVO.statusDescription);
            
        	Takedown_Invoice.TKD_txt_Document_ID__c = documentId;
            Takedown_Invoice.TKD_txt_RFC__c = SATValResponse.comprobanteVO == null ? '' : SATValResponse.comprobanteVO.emisorVO == null ? '' : SATValResponse.comprobanteVO.emisorVO.rfc;
            
            if(Takedown_Invoice.TKD_txt_RFC__c != null){
                //if(listSupplier.isEmpty()){
                    listSupplier = [SELECT Id, Name, TKD_pd_Supplier_in_approval__r.TKD_rb_SupplierInApproval__c, 
                                    Nacionalidad__c, TKD_Vendor_ID__c, TKD_chkb_HaveInvoice__c, TKD_ls_Pais_de_residencia__c, 
                                    TKD_ls_Tipo_de_tercero__c, TKD_tl_hitsDescription__c, TKD_tx_Contexto__c, TKD_tx_Supplier_Unique_ID__c, 
                                    TKD_tx_Vat_Registration_Num__c, TKD_tx_Vendor_Name__c, TKD_tx_Vendor_name_alternative__c, TKD_tx_amlHits__c, TKD_un_oracleSupplier__c 
                                    FROM Supplier__c where TKD_pd_Supplier_in_approval__r.TKD_rb_SupplierInApproval__c = :takedownID];  
                //}
                
                for(Supplier__c supplier : listSupplier){
                    if(supplier.TKD_tx_Vat_Registration_Num__c != null && supplier.TKD_tx_Vat_Registration_Num__c.equals(Takedown_Invoice.TKD_txt_RFC__c)){
                    	Takedown_Invoice.TKD_rb_Supplier__c = supplier.id;    
                    }	    
                }
            }
            Takedown_Invoice.TKD_tx_Supplier_name__c = SATValResponse.comprobanteVO == null ? '' : SATValResponse.comprobanteVO.emisorVO == null ? '' : SATValResponse.comprobanteVO.emisorVO.nombre;
            Takedown_Invoice.CurrencyIsoCode = SATValResponse.comprobanteVO == null ? '' : SATValResponse.comprobanteVO.moneda;
            Schema.SObjectField fieldDocumentID = Takedown_Invoice__c.Fields.TKD_txt_Document_ID__c;
        	Database.UpsertResult resulOperation = Database.upsert(Takedown_Invoice, fieldDocumentID, false );
                if (resulOperation.isSuccess()) {
                    // Operation was successful, so get the ID of the record that was processed
                    System.debug('Successfully inserted Takedown Invoice. ID: ' + resulOperation.getId());
                }
                else {
                    // Operation failed, so get all errors                
                    for(Database.Error err : resulOperation.getErrors()) {
                        System.debug('The following error has occurred.');                    
                        System.debug(err.getStatusCode() + ': ' + err.getMessage());
                        System.debug('Takedown Invoice fields that affected this error: ' + err.getFields());
                    }
                }            
        }catch(exception e){
            System.debug(LoggingLevel.ERROR, e.getLineNumber());
            System.debug(LoggingLevel.ERROR, e.getCause());
            System.debug(LoggingLevel.ERROR, e.getMessage());
            
        }    
    }
    public void Work_Response_FindAssets(Takedown_Wrapper_FindAssets_OL_cls.FindAssetsResponse findAssetsResponse, string Takedown_Invoice_CurrencyIsoCode){
        try{  
            List<Asset> listAsset = new List<Asset>();
            Set<id> setDocumentID = new Set<id>();
            for(Takedown_Wrapper_FindAssets_OL_cls.Assets asset : findAssetsResponse.assets){
            	setDocumentID.add(asset.documentId);	   
            }
            map<id,id> mapTakedownInvoiceID = new map<id,id>();
            for(Takedown_Invoice__c takedownInvoice : [SELECT TKD_txt_Document_ID__c, Name, Id FROM Takedown_Invoice__c where TKD_txt_Document_ID__c in :setDocumentID]){
            	mapTakedownInvoiceID.put(takedownInvoice.TKD_txt_Document_ID__c,takedownInvoice.id);    
            }
            for(Takedown_Wrapper_FindAssets_OL_cls.Assets asset : findAssetsResponse.assets){
            	listAsset.add(MakeAsset(asset, mapTakedownInvoiceID, Takedown_Invoice_CurrencyIsoCode));    
            }
            Schema.SObjectField assetExternalID = Asset.Fields.TKD_tx_asset_external_ID__c;
            List<Database.UpsertResult> resulOperation = Database.upsert(listAsset, assetExternalID, false );
            for(Database.UpsertResult result : resulOperation){
            	if (result.isSuccess()) {
                    // Operation was successful, so get the ID of the record that was processed
                    System.debug('Successfully inserted Asset. Asset ID: ' + result.getId());
                }else {
                    // Operation failed, so get all errors                
                    for(Database.Error err : result.getErrors()) {
                        System.debug('The following error has occurred.');                    
                        System.debug(err.getStatusCode() + ': ' + err.getMessage());
                        System.debug('Account fields that affected this error: ' + err.getFields());
                    }
                }    
            }
        }catch(exception e){
            System.debug(LoggingLevel.ERROR, e.getLineNumber());
            System.debug(LoggingLevel.ERROR, e.getCause());
            System.debug(LoggingLevel.ERROR, e.getMessage());
            
        }    
    }
    public Asset MakeAsset(Takedown_Wrapper_FindAssets_OL_cls.Assets asset, map<id,id> mapTakedownInvoiceID, string Takedown_Invoice_CurrencyIsoCode){
    	Asset AssetBreakdown = new Asset();
        AssetBreakdown.AccountId = this.AccountID;
        AssetBreakdown.TKD_tx_asset_external_ID__c 		= asset.assetId != null ? String.valueOf(asset.assetId) : null;
        AssetBreakdown.TKD_ck_active__c 				= asset.activeFlag == 1 ? true : false;
        AssetBreakdown.TKD_tx_arrears__c 				= asset.arrears;
        AssetBreakdown.Description 						= asset.assetDescription;
        AssetBreakdown.Name 							= cutLargeString(asset.assetName,254);
        AssetBreakdown.TKD_tx_brand__c 					= asset.brand;
        AssetBreakdown.TKD_tl_op_collateral_description__c = asset.colateralDescription;
        AssetBreakdown.TKD_tl_op_collateral_type__c 	= asset.collateralType;
        AssetBreakdown.TKD_tx_Concept_ID__c 			= asset.conceptId != null ? String.valueOf(asset.conceptId) : null;
        AssetBreakdown.TKD_tx_openlegacy_created_by__c 	= asset.createdBy != null ? String.valueOf(asset.createdBy) : null;
        AssetBreakdown.CurrencyIsoCode  				= Takedown_Invoice_CurrencyIsoCode;
        //AssetBreakdown.createdOn
        AssetBreakdown.TKD_rb_takedown_Invoice__c 		= mapTakedownInvoiceID.get(asset.documentId);
        AssetBreakdown.TKD_tl_ec_policy__c 				= asset.ecPolicy;
        AssetBreakdown.TKD_tl_engine_number__c 			= asset.engineNum;
        AssetBreakdown.TKD_tx_Category__c 				= asset.faCategory;
        AssetBreakdown.TKD_tx_Sub_Category__c 			= asset.faSubcategory;
        AssetBreakdown.TKD_tl_imported_by__c 			= asset.importedBy != null ? String.valueOf(asset.importedBy) : null;
        // public String 	importedOn				{get;set;}
        AssetBreakdown.TKD_tx_inciso_insurance__c 		= asset.incisoInsurance;
        AssetBreakdown.TKD_tx_Insurance_company__c 		= asset.insuranceCompany;
        //AssetBreakdown.insuranceExpirationDate
        AssetBreakdown.TKD_tx_Insurance_policy__c 		= asset.insurancePolicy;
        AssetBreakdown.TKD_tx_Model__c 					= asset.model;
        AssetBreakdown.TKD_tx_model_year__c 			= asset.modelYear;
        AssetBreakdown.TKD_tx_OpenLegacy_modified_by__c = asset.modifiedBy != null ? String.valueOf(asset.modifiedBy) : null;
        AssetBreakdown.TKD_dv_payment_amount__c 		= asset.paymentAmount;
        AssetBreakdown.TKD_tx_payment_frecuency__c 		= asset.paymentFrecuency;
        AssetBreakdown.TKD_tx_payment_order__c 			= asset.paymentOrder;
        AssetBreakdown.TKD_tx_payment_type__c 			= asset.paymentType;
        AssetBreakdown.TDK_tx_pediment__c 				= asset.pediment;
        AssetBreakdown.TKD_tx_period__c 				= asset.period;
        AssetBreakdown.TKD_tx_plates__c 				= asset.plates;
        AssetBreakdown.Quantity 						= asset.quantity != null ? Integer.valueOf(asset.quantity) : null;
        AssetBreakdown.SerialNumber 					= asset.serialNumber;
        AssetBreakdown.TKD_dv_soft_cost__c 				= asset.softCost;
        AssetBreakdown.TKD_rb_Takedown_CP__c 			= asset.takedownId;
        AssetBreakdown.TKD_dv_total_cost__c 			= asset.totalCost;
        AssetBreakdown.TDK_dv_Unit_cost__c 				= asset.unitCost;
        return AssetBreakdown;
    }
    public string ChangeStatus(String succes){
        String status;
        switch on succes {
            when 'True' {		
                status = 'action:approval';
            }	
            when 'False' {		
                status = 'action:close';
            }
            when 'success' {
            	status = 'action:approval';    
            }
            when 'error' {
            	status = 'action:approval';    
            }
            when else {		  
                status = 'action:apex';
            }
        }
        return status;
        
	}
    public string cutLargeString(string fieldValue, integer maximunSize){
        string correctFieldValue;
        if(string.isNotEmpty(fieldValue) && fieldValue.length() >= maximunSize){
            correctFieldValue = fieldValue.left(maximunSize);
        } else {
            correctFieldValue = fieldValue;
        }
        return correctFieldValue;
    }
}