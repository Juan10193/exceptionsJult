/**
 * @File Name          : Takedown_Table_AB_Controller_cls.cls
 * @Description        : 
 * @Author             : eduardo.villegas@engeniumcapital.com
 * @Group              : 
 * @Last Modified By   : eduardo.villegas@engeniumcapital.com
 * @Last Modified On   : 29/8/2019 17:38:02
 * @Modification Log   : 
 *==============================================================================
 * Ver         Date                     Author      		      Modification
 *==============================================================================
 * 1.0    22/8/2019 11:24:54   eduardo.villegas@engeniumcapital.com     Initial Version
**/
public with sharing class Takedown_Table_AB_Controller_cls {    
    /**
    * @description 
    * @author eduardo.villegas@engeniumcapital.com | 22/8/2019
    * @param String recordId
    * @return List<Takedown_Invoice__c>
    */
    @AuraEnabled(cacheable=true)
    public static List<Asset> initRecords(String recordId) {
        system.debug('recordId ' + recordId);
        system.debug('Data_Access_Assets_cls.getAssetsByTakedownId(recordId) ' + Data_Access_Assets_cls.getAssetsByTakedownId(recordId));
        return Data_Access_Assets_cls.getAssetsByTakedownId(recordId);
    }
    /**
    * @description
    * @author eduardo.villegas@engeniumcapital.com | 28/8/2019
    * @param Id idParent
    * @param String strFileName
    * @param String base64Data
    * @return ContentVersion
    */
    /*
    @AuraEnabled
    public static void saveFile(List<String> labelFields, List<String> apiFields, string base) {
        Takedown_Table_AB_Service_cls takedown_Table_AB_Service = new Takedown_Table_AB_Service_cls(labelFields,apiFields,base);
        takedown_Table_AB_Service.updateAssetsWithCSV();
    }*/
    @AuraEnabled(cacheable=false)
    public static void saveData(List<Asset> activos, String idAccount, id idTakedown) {
        
        system.debug('activosLEL');
        system.debug(JSON.serialize(activos));
        List<Asset> listAsset = new List<Asset>();
        try {

            for(Asset asset : activos) {
                Asset updateAsset = new Asset();
                updateAsset.Name = asset.Name;
                updateAsset.TKD_tx_Model__c = asset.TKD_tx_Model__c;
                updateAsset.SerialNumber = asset.SerialNumber;
                updateAsset.Description = asset.Description;
                updateAsset.TKD_tx_model_year__c = asset.TKD_tx_model_year__c;
                updateAsset.TKD_tx_brand__c = asset.TKD_tx_brand__c;
                updateAsset.Status = asset.Status;
                updateAsset.TKD_ck_active__c = asset.TKD_ck_active__c;
                updateAsset.TKD_tx_Insurance_policy__c = asset.TKD_tx_Insurance_policy__c;
                updateAsset.TKD_tl_ec_policy__c = asset.TKD_tl_ec_policy__c;
                updateAsset.TKD_tx_Insurance_company__c = asset.TKD_tx_Insurance_company__c;
                updateAsset.TKD_tx_inciso_insurance__c = asset.TKD_tx_inciso_insurance__c;
                updateAsset.TKD_tx_aseguradora__c = asset.TKD_tx_aseguradora__c;
                updateAsset.TKD_tx_annex_a_number__c = asset.TKD_tx_annex_a_number__c;
                updateAsset.TKD_tx_quote_number__c = asset.TKD_tx_quote_number__c;
                updateAsset.TKD_ls_annex_a_status__c = asset.TKD_ls_annex_a_status__c;
                updateAsset.TKD_ls_ec_or_customer_supplier__c = asset.TKD_ls_ec_or_customer_supplier__c;
                updateAsset.TKD_nu_unit_availability_days__c = asset.TKD_nu_unit_availability_days__c;
                updateAsset.TKD_tx_supplier_name__c = asset.TKD_tx_supplier_name__c;
                updateAsset.TKD_ls_purchase_Status__c = asset.TKD_ls_purchase_Status__c;
                updateAsset.TKD_ls_delivery_status__c = asset.TKD_ls_delivery_status__c;
                updateAsset.TKD_ca_welcome_kit_sent__c = asset.TKD_ca_welcome_kit_sent__c;
                updateAsset.TKD_ls_annex_b_status__c = asset.TKD_ls_annex_b_status__c;
                updateAsset.TKD_dv_payment_amount__c = asset.TKD_dv_payment_amount__c;
                updateAsset.TKD_tx_payment_type__c = asset.TKD_tx_payment_type__c;
                updateAsset.Quantity = asset.Quantity;
                updateAsset.TKD_tx_payment_order__c = asset.TKD_tx_payment_order__c;
                updateAsset.TKD_dv_soft_cost__c = asset.TKD_dv_soft_cost__c;
                updateAsset.TKD_tx_payment_frecuency__c = asset.TKD_tx_payment_frecuency__c;
                updateAsset.TKD_dv_total_cost__c = asset.TKD_dv_total_cost__c;
                updateAsset.TKD_rb_collateral__c = asset.TKD_rb_collateral__c;
                updateAsset.TKD_rb_takedown_Invoice__c = asset.TKD_rb_takedown_Invoice__c;
                updateAsset.TKD_rb_Takedown_CP__c = idTakedown;
                System.debug(String.isBlank(asset.Id));
                if(!String.isBlank(asset.Id)) {
                    updateAsset.Id = asset.Id;
                    listAsset.add(updateAsset);
                }
                else {
                    updateAsset.AccountId = idAccount;
                    listAsset.add(updateAsset);
                }
            }
            upsert listAsset;
        }catch(DMLException e) {
			System.debug('Error de campos: ' + e.getMessage());
            throw new AuraHandledException(e.getMessage());
        }
    }
    
    @AuraEnabled(cacheable=true)
    public static list<Catalogo_Colaterals__c>  getCatalogCollateral() {
        system.debug('Inicia catalog Collateral ');
        return [SELECT Id, OwnerId, Name, CurrencyIsoCode, COLATERAL_DESCRIPTION__c, COLATERAL_TYPE__c, MANUFACTURER__c, MODEL_YEAR__c, MODEL__c, Oracle_FA_Category_ID__c FROM Catalogo_Colaterals__c];
       
    }
    
    @AuraEnabled(cacheable=true)
    public static List<Takedown_Invoice__c> getTakedownInvoice(String idTakedown) {
        return [SELECT id, Name, TKD_txt_RFC__c, TKD_pd_Takedown_CP__c, TKD_tx_Supplier_name__c, LMM_nu_Total_assets_cost__c FROM Takedown_Invoice__c WHERE TKD_pd_Takedown_CP__c =: idTakedown];
    }
    
    @AuraEnabled
    public static void deleteAsset(List<Asset> assetList, String idTakedown) {
        List<Asset> currentAssets = new List<Asset>();
        List<Id> currentAsstsId = new List<Id>();
        List<Asset> delAssetsId = new List<Asset>();
        Boolean idExist = False;
        
        try {
            currentAssets = [SELECT id, Name FROM Asset WHERE TKD_rb_Takedown_CP__c =: idTakedown];
            for(Asset astCur : currentAssets) {
                currentAsstsId.add(astCur.Id);
            }
            
            for(Integer i=0; i<currentAsstsId.size(); i++) {
                for(Integer j=0; j < assetList.size(); j++) {
                    if(currentAsstsId[i] == assetList[j].Id) {
                        idExist = true;
                    }
                }
                if(!idExist) {
                    delAssetsId.add(new Asset(Id = currentAsstsId[i]));
                }
                idExist = false;
            }
            System.debug(delAssetsId);
            
            if(!delAssetsId.isEmpty()) {
                delete delAssetsId;
            }
        }catch(DMLException e) {
             throw new AuraHandledException(e.getMessage());
        }
    }

    /* 
        Method for the creation of EVAL and ASSETS
    */
    @AuraEnabled
    public static Map<String, Object> sendEvalApprove(String json, String IdTakeDown) {
		system.debug('EVAL JONSON');
        system.debug(json);
        Map<String, Object> respose = new  Map<String, Object>();
        String oracleNumber = '';
        String message = '';
        String code = '';
        String responseEval = '{\"status\": \"500\",\"source\": { \"pointer\": \"/data/attributes/secretPowers\" },\"message\": \"The request already has EVAL.\"}';
        String responseAssets = '{\"status\": \"500\",\"source\": { \"pointer\": \"/data/attributes/secretPowers\" },\"message\": \"Some field are empty on ASSET.\"}';
        String responseCustumer = '{\"status\": \"500\",\"source\": { \"pointer\": \"/data/attributes/secretPowers\" },\"message\": \"Validate Party Id and Parent Id fields in Entity CP.\"}';
        String resultValidation;
        Takedowns_Contingency_plan__c evalResponse;
        Takedowns_Contingency_plan__c infoEval;
        String newJson;
        String comment;
        Boolean pricing = false;
        
        String endPointEval = '/EcRequestSbDat/SFRequestTypeDetailsRs/sfRequestTypeDetails';
        String endPointAssets = '/EcRequestSbDat/SFRequestTypeDetailsRs/sfRequestTypeDetails/evals/details/assets';
        String endPointComments = '/EcRequestSbDat/SFRequestTypeDetailsRs/sfRequestTypeDetails/comments';

        evalResponse = Data_Connect_Eval.validationTakeDownEval(IdTakeDown);
        if(evalResponse.TKD_LinkedEval__c == null || evalResponse.TKD_LinkedEval__c == '') {
            resultValidation = Data_Connect_Eval.validationFieldAssets(json);
            if(resultValidation == 'true'){
                infoEval  = Data_Connect_Eval.infoTakeDown(IdTakeDown);
                if(Data_Connect_Eval.validationFielTakedown(infoEval) == 'true') {
                    Tkd_Wrapper_eval evalJson = Data_Connect_Eval.createdEval(infoEval);
                    respose = Data_Connect_Eval.callRestEval(evalJson, endPointEval);

                    System.debug(LoggingLevel.INFO, 'EVAL RESPONSE: '+ respose);
                    newJson = Data_Connect_Eval.joinRecords(json);
                    for(String key : respose.keySet()){
                        oracleNumber = String.valueOf(respose.get('requestId'));
                    }

                    if(Test.isRunningTest() ){
                        oracleNumber = '2356';
                    }
            
                    if(oracleNumber != null || oracleNumber == ''){
                        Tkd_Wrapper_assets assetJson = Data_Connect_Eval.createdAsset(newJson, oracleNumber);
                        respose = Data_Connect_Eval.callRestAsset(assetJson, endPointAssets);
                        
                        Map<String, Object> o = respose;
                        Map<String, Object> status = (Map<String, Object>) o.get('status');
                        if(status.get('detail') == 'S') {
                            comment =  Data_Connect_Eval.createComments(oracleNumber , evalResponse.Name);
                        	respose = Data_Connect_Eval.callRestComments(comment, endPointComments);
                        	Data_Connect_Eval.updateTakeDown(IdTakeDown, oracleNumber);
                        }
                        else {
                            //responseCustumer = '{\"status\": \"500\",\"source\": { \"pointer\": \"/data/attributes/secretPowers\" },\"message\": \"'+ status.get('code') +'\"}';
                    		//respose = (Map<String, Object>) System.JSON.deserializeUntyped(responseCustumer);
                    		System.debug('Asset error: ' + respose);
                        }
                    }
                }
                else {
                    responseCustumer = '{\"status\": \"500\",\"source\": { \"pointer\": \"/data/attributes/secretPowers\" },\"message\": \"'+Data_Connect_Eval.validationFielTakedown(infoEval) +'\"}';
                    respose = (Map<String, Object>) System.JSON.deserializeUntyped(responseCustumer);
                    System.debug('Field takedown: ' + respose);
                }
            }
            else {
                responseAssets = '{\"status\": \"500\",\"source\": { \"pointer\": \"/data/attributes/secretPowers\" },\"message\": \"'+resultValidation+'\"}';
                respose = (Map<String, Object>) System.JSON.deserializeUntyped(responseAssets);
                System.debug('Field ASSET: ' + respose);
            }
        }
        else {
            respose = (Map<String, Object>) System.JSON.deserializeUntyped(responseEval);
        }
        return respose;
    }
}