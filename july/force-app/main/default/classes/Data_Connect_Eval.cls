public with sharing class Data_Connect_Eval {
    public String urlService {get; set;}
    public String dayFormat {get; set;}
    public String employeeNumber {get; set;}

    /*
        Data for service connection.
    */
    public Data_Connect_Eval() {
        urlService = Test.isRunningTest() ? 'Service' : 'callout:' + Data_Connect_Eval.credentialValidation();
        dayFormat = System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00'));
        employeeNumber = Test.isRunningTest() ? '666' : [Select EmployeeNumber From User Where Id = :UserInfo.getUserId()][0].EmployeeNumber;
    }

    /*
        Get connect service
    */
    public static String credentialValidation() {
        string namedCredential;
        
        switch on GetSandboxType.getTypeOfSandbox() {
            when 'DEV' {		
                namedCredential = 'getsServiceUrl';
            }	
            when 'QA' {		
                namedCredential = 'getsServiceUrlQa';
            }
            when 'PROD' {		
                namedCredential = 'getsServiceUrlProd';
            }
            when 'Developer Edition' {
            	namedCredential = 'getsServiceUrl';
        	}
            when else {		  
                namedCredential = 'getsServiceUrl';
            }
        }
        return namedCredential;
    }

    /*
        Get takedown information
    */
    @AuraEnabled
    public static Takedowns_Contingency_plan__c infoTakeDown(String idTakeDown) {
        return [SELECT id, CurrencyIsoCode, CPL_rb_Entity_Name_CP__r.EM_Party_ID__c, CPL_rb_Entity_Name_CP__c,
                CPL_rb_Entity_Name_CP__r.EM_Top_Parent_ID__c, CPL_rb_Entity_Name_CP__r.Name, 
                CPL_ls_Product__c, Annex_Pricing_SuperTrump__r.IST__Term__c FROM Takedowns_Contingency_plan__c WHERE id =: idTakeDown];
    }

    /*
        EVAL validation method.
    */
    public static Takedowns_Contingency_plan__c validationTakeDownEval (String idTackdown) {
        return [SELECT id, Name, TKD_LinkedEval__c FROM Takedowns_Contingency_plan__c WHERE id =: idTackdown Limit 1];
    }

    /*
        Method for updating the TAKEDOWN, when the EVAL shipment is generated.
    */
    public static void updateTakeDown (String idTakeDown, String oracleEval) {
        Takedowns_Contingency_plan__c updateEval = [SELECT id, TKD_LinkedEval__c FROM Takedowns_Contingency_plan__c WHERE id =: idTakeDown Limit 1];
        updateEval.TKD_LinkedEval__c = oracleEval;
        update updateEval;
    }

    /*
        Method, to join the total cost of the ASSETS table.
    */
    public static String joinRecords(String jsonTakeDown) {
        String fieldsUnion = '';
        List<Tkd_Wrapper_takedownCP> jsonConvert = Tkd_Wrapper_takedownCP.parse(jsonTakeDown);
        List<Tkd_Wrapper_takedownCP> jsonNewConvert = new List<Tkd_Wrapper_takedownCP>();
        List<Wrapper_validation_takedown> unitTotalCost = new List<Wrapper_validation_takedown>();
        Boolean exist = false;
        Boolean existDecimal = false;
        Integer index = null;
		Integer indexCount = 0;
        
        for(Tkd_Wrapper_takedownCP flag : jsonConvert) {
            if(unitTotalCost.size() == 0) {
                jsonNewConvert.add(flag);
                //unitTotalCost.add(new Wrapper_validation_takedown(flag.TKD_dv_total_cost_Tempc, flag.Name, flag.TKD_tx_Model_Tempc));
                unitTotalCost.add(new Wrapper_validation_takedown(flag.TKD_fm_collateral_description_Tempc, flag.TKD_tx_Model_Tempc, flag.TKD_tx_model_year_Tempc, flag.TKD_dv_total_cost_Tempc));
            } else {
                for(Wrapper_validation_takedown valueTotal : unitTotalCost) {
                    //if(valueTotal.total_cost == flag.TKD_dv_total_cost_Tempc && valueTotal.name == flag.Name && valueTotal.modelo == flag.TKD_tx_Model_Tempc) {
                    if(valueTotal.name == flag.TKD_fm_collateral_description_Tempc && valueTotal.modelo == flag.TKD_tx_Model_Tempc && valueTotal.year == flag.TKD_tx_model_year_Tempc) {
                        existDecimal = true;
                        System.debug('entre al igual');
                    }
                }
                if(existDecimal) {
                    for(Integer i=0; i < jsonNewConvert.size(); i++) {
                        //if(jsonNewConvert.get(i).TKD_dv_total_cost_Tempc == flag.TKD_dv_total_cost_Tempc) {
                        if(jsonNewConvert.get(i).TKD_fm_collateral_description_Tempc == flag.TKD_fm_collateral_description_Tempc && jsonNewConvert.get(i).TKD_tx_Model_Tempc == flag.TKD_tx_Model_Tempc && jsonNewConvert.get(i).TKD_tx_model_year_Tempc == flag.TKD_tx_model_year_Tempc && jsonNewConvert.get(i).TKD_dv_total_cost_Tempc == flag.TKD_dv_total_cost_Tempc) {
                            index = i;
                        }
                    }
                    if(index != null){
                    	jsonNewConvert.get(index).Quantity += flag.Quantity;
                    }
                    else {
                        flag.Description = String.valueOf(indexCount) +'.-'+flag.Description;
						jsonNewConvert.add(flag);
                    	unitTotalCost.add(new Wrapper_validation_takedown(flag.TKD_fm_collateral_description_Tempc, flag.TKD_tx_Model_Tempc, flag.TKD_tx_model_year_Tempc, flag.TKD_dv_total_cost_Tempc));                        
                    }
                } else {
                    System.debug(LoggingLevel.INFO, 'NO Duplicados');
                    jsonNewConvert.add(flag);
                    //unitTotalCost.add(new Wrapper_validation_takedown(flag.TKD_dv_total_cost_Tempc, flag.Name, flag.TKD_tx_Model_Tempc));
                    unitTotalCost.add(new Wrapper_validation_takedown(flag.TKD_fm_collateral_description_Tempc, flag.TKD_tx_Model_Tempc, flag.TKD_tx_model_year_Tempc, flag.TKD_dv_total_cost_Tempc));
                }
            }
            
            existDecimal = false;
            index = null;
            indexCount++;
        }
        System.debug(unitTotalCost);
        return System.JSON.serialize(jsonNewConvert);
    }
     /*
     Wrapper TakeDowns
	*/
    
    public class Wrapper_validation_takedown {
    	public String name {get; set;}
        public String modelo {get; set;}
        public String year {get; set;}
        public Decimal total_cost {get; set;}
        
        //public Wrapper_validation_takedown (Decimal total_cost, String name, String modelo, String year) {
        public Wrapper_validation_takedown (String name, String modelo, String year, Decimal total_cost) {
			this.name = name;
            this.modelo = modelo;
            this.year = year;
            this.total_cost =total_cost;
        }
	}

    /*
        Party Id, Parent Id and Terms Moths validation
    */
    public static String validationFielTakedown(Takedowns_Contingency_plan__c takedown) {
        String fieldsComplete = 'true';

        if(takedown.CPL_rb_Entity_Name_CP__r.EM_Party_ID__c == null || takedown.CPL_rb_Entity_Name_CP__r.EM_Party_ID__c == '') {
            fieldsComplete = 'Entity\'s Party Id field is empty.';
        }
        else if(takedown.CPL_rb_Entity_Name_CP__r.EM_Top_Parent_ID__c == null || takedown.CPL_rb_Entity_Name_CP__r.EM_Top_Parent_ID__c == '') {
            fieldsComplete = 'Entity\'s Top Parent Id field is empty.';
        }
        else if(takedown.CPL_rb_Entity_Name_CP__r.Name == null || takedown.CPL_rb_Entity_Name_CP__r.Name == '') {
            fieldsComplete = 'Entity\'s Top Parent Name field is empty.';
        }
        else if(takedown.CPL_ls_Product__c == null || takedown.CPL_ls_Product__c == '') {
            fieldsComplete = 'Takedown Product field is empty.';
        }
        /*else if(takedown.Annex_Pricing_SuperTrump__r.IST__Term__c == null || takedown.Annex_Pricing_SuperTrump__r.IST__Term__c == 0) {
            fieldsComplete = 'Takedown Annex Pricing field is empty.';
        }*/
        return fieldsComplete;
    }

    /*
        Validation that the ASSETS fields are not empty. Before sending to generate the EVAL.
    */
    public static String validationFieldAssets(String jsonTakeDown) {
        String fieldsComplete = 'true';
        Integer index = 1;

        List<Tkd_Wrapper_takedownCP> jsonConvert = Tkd_Wrapper_takedownCP.parse(jsonTakeDown);
        
        if(jsonConvert.isEmpty()) {
            fieldsComplete = 'Eval without assets';
        }

        for(Tkd_Wrapper_takedownCP flag : jsonConvert) {
            if(flag.Name == null || flag.Name == '') {
                fieldsComplete = 'ASSET does not contain Name';
            }
            else if(flag.TKD_tx_Model_Tempc == null || flag.TKD_tx_Model_Tempc == '') {
                fieldsComplete = 'ASETT: '+ index + '.-'+ flag.Name + ' does not contain Model.' ;
            }
            else if(flag.SerialNumber == null || flag.SerialNumber == '') {
                fieldsComplete = 'ASETT: '+ index + '.-'+ flag.Name + ' does not contain Serial Number.' ;
            }
            else if(flag.Description == null || flag.Description == '') {
                fieldsComplete = 'ASETT: '+ index + '.-'+ flag.Name + ' does not contain Description.' ;
            }
            else if( flag.TKD_tx_model_year_Tempc == null || flag.TKD_tx_model_year_Tempc == '') {
                fieldsComplete = 'ASETT: '+ index + '.-'+ flag.Name + ' does not contain Model Year.' ;
            }
            else if(flag.TKD_tx_brand_Tempc == null || flag.TKD_tx_brand_Tempc == '') {
                fieldsComplete = 'ASETT: '+ index + '.-'+ flag.Name + ' does not contain Brand.' ;
            }
            else if(flag.Quantity == null || flag.Quantity == 0) {
                fieldsComplete = 'ASETT: '+ index + '.-'+ flag.Name + ' does not contain Quantity.' ;
            }
            else if(flag.TKD_dv_total_cost_Tempc == null || flag.TKD_dv_total_cost_Tempc == 0.0) {
                fieldsComplete = 'ASETT: '+ index + '.-'+ flag.Name + ' does not contain Total Cost.' ;
            }
            else if(flag.CurrencyIsoCode == null || flag.CurrencyIsoCode == '' ) {
                fieldsComplete = 'ASETT: '+ index + '.-'+ flag.Name + ' does not contain CurrencyIsoCode.' ;
            }
            else if(flag.TKD_fm_collateral_type_Tempc == null || flag.TKD_fm_collateral_type_Tempc == '') {
                fieldsComplete = 'ASETT: '+ index + '.-'+ flag.Name + ' does not contain Collateral Type.' ;
            }
            else if(flag.TKD_fm_collateral_description_Tempc == null || flag.TKD_fm_collateral_description_Tempc == '') {
                fieldsComplete = 'ASETT: '+ index + '.-'+ flag.Name + ' does not contain Collateral Description.' ;
            }
            index ++;
        }

        return fieldsComplete;
    }

    /*
        JSON that generates the valid COMMENTS for the connection.
    */
    public static String createComments(String requestId, String comentario) {
        Data_Connect_Eval info = new Data_Connect_Eval();
        
        String jsonS;
        String idRequest  =  Test.isRunningTest() ? 'Id654' : requestId;

        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartObject();
        gen.writeFieldName('requestComment');
        gen.writeStartObject();
        gen.writeStringField('requestId',idRequest);
        gen.writeStringField('comSection','');
        gen.writeStringField('comComment',comentario);
        gen.writeStringField('comCreatedBy',info.employeeNumber);
        gen.writeStringField('comCreationDate',info.dayFormat);
        gen.writeStringField('comUpdatedBy',info.employeeNumber);
        gen.writeStringField('comLastUpdateDate',info.dayFormat);
        gen.writeEndObject(); 
        gen.writeEndObject(); 
        jsonS = gen.getAsString(); 

        return jsonS;
    }

    /*
        JSON that generates the valid ASSETS for the connection.
    */
    public static Tkd_Wrapper_assets createdAsset(String requestJson, String requestId){
        Data_Connect_Eval info = new Data_Connect_Eval();
		//Integer index = 0;
        List<Tkd_Wrapper_takedownCP> jsonConvert = Tkd_Wrapper_takedownCP.parse(requestJson);
        List<Tkd_Wrapper_assets.EvalAsset> listEval = new List<Tkd_Wrapper_assets.EvalAsset>();

        for(Tkd_Wrapper_takedownCP flag : jsonConvert) {
            Tkd_Wrapper_assets.EvalAsset evalAsset = new Tkd_Wrapper_assets.EvalAsset();
            evalAsset.evAssetOracleFACategoryId = flag.TKD_fm_collateral_id_oracle_Tempc; //Lookup value
            System.debug(flag.TKD_fm_collateral_id_oracle_Tempc);
            if(flag.Description.Length() > 59){
                evalAsset.evAssetOracleFACategory = flag.Description.substring(0,59);
            }
            else {
                evalAsset.evAssetOracleFACategory = flag.Description;
            }
	        evalAsset.evAssetOracleFASubcategory = '';
	        evalAsset.evAssetCollateralType = flag.TKD_fm_collateral_type_Tempc;
	        evalAsset.evAssetCollateralDescription = flag.TKD_fm_collateral_description_Tempc /*+ index*/;
	        evalAsset.evAssetCollateralId = '';
	        evalAsset.evAssetAssetModel = flag.TKD_tx_Model_Tempc;
	        evalAsset.evAssetAssetModelYear = flag.TKD_tx_model_year_Tempc;
	        evalAsset.evAssetManufacturer = flag.TKD_tx_brand_Tempc;
            
            if(flag.TKD_tx_brand_Tempc.Length() > 59){
                evalAsset.evAssetManufacturer = flag.TKD_tx_brand_Tempc.substring(0,59);
            }
            else {
                evalAsset.evAssetManufacturer = flag.TKD_tx_brand_Tempc;
            }
            
	        evalAsset.evAssetCurrencyType = flag.CurrencyIsoCode;
	        evalAsset.evAssetExchangeRate = '';
	        evalAsset.evAssetQuantity = flag.Quantity;
	        evalAsset.evAssetUnitCost = flag.TKD_dv_total_cost_Tempc;
	        evalAsset.evAssetUnitTax = 0;
	        evalAsset.evAssetFreightCost = 0;
	        evalAsset.evAssetParkingCost = 0;
	        evalAsset.evAssetInstallationCost = 0;
	        evalAsset.evAssetTrainingCost = 0;
	        evalAsset.evAssetWarrantyCost = 0;
	        evalAsset.evAssetSoftwareCost = 0;
	        evalAsset.evAssetConditionType = 'NEW';
	        //evalAsset.evAssetTotalCost = '';
	        evalAsset.evAssetPhysicalCatType = '';
	        evalAsset.evAssetInsuranceType = 'Customer';
	        evalAsset.evAssetMultLocationFlag = 'N';
	        evalAsset.evAssetRapidTagFlag = 'N';
	        evalAsset.evAssetImportFlag = 'N';
	        evalAsset.evAssetActiveFlag = 'Y';
	        evalAsset.evAssetClonedAssetId = '';
	        evalAsset.evAssetCreatedBy = info.employeeNumber;
	        evalAsset.evAssetCreationDate = info.dayFormat;
	        evalAsset.evLastUpdatedBy = info.employeeNumber;
	        evalAsset.evAssetLastUpdateDate = info.dayFormat;
            //index++;
	        listEval.add(evalAsset);
        }  

        Tkd_Wrapper_assets.EvAssets evAssets = new Tkd_Wrapper_assets.EvAssets();
	    evAssets.evalAsset = listEval;
	
	    Tkd_Wrapper_assets assets = new Tkd_Wrapper_assets();
	    assets.requestId = requestId;
        assets.evAssets = evAssets;
        
        return assets;
    }

    /*
        JSON that generates the valid EVAL for the connection.
    */
    public static Tkd_Wrapper_eval createdEval(Takedowns_Contingency_plan__c requestJson){
        Data_Connect_Eval info = new Data_Connect_Eval();

        Tkd_Wrapper_eval jsonEval = new Tkd_Wrapper_eval();

        Tkd_Wrapper_eval.Header header = new Tkd_Wrapper_eval.Header();
        header.requestId = ''; 
        header.requestType = 'EVAL';
        header.applicationCode = 'SF';
        header.partyId = requestJson.CPL_rb_Entity_Name_CP__r.EM_Party_ID__c;
        header.requestStatus = 'NEW';
        header.requestedBy = info.employeeNumber;
        header.startDate = info.dayFormat;
        header.endDate = '';
        header.rootRequestId = '';
        header.assignedTo = '';
        header.ndaType = '';
        header.sourceAccountId = '';
        header.sourceAccountName = '';
        header.sourceTopParentId = requestJson.CPL_rb_Entity_Name_CP__r.EM_Top_Parent_ID__c;
        header.sourceTopParentName = requestJson.CPL_rb_Entity_Name_CP__r.Name;
        header.partyName = requestJson.CPL_rb_Entity_Name_CP__r.Name;
        header.egPartyId = '';
        header.egPartyName = '';
        header.sourceOpId = '';
        header.sourceCAId = '';
        header.createdBy = info.employeeNumber;
        header.assignedGroup = '';
        header.assignedDate = '';
        header.activeFlag = 'Y';
        header.creationDate = info.dayFormat;
        header.updatedBy = info.employeeNumber;
        header.lastUpdateDate = info.dayFormat;
        header.solvedBy = info.employeeNumber;
        header.solvedDate = '';
        header.finantialEntity = '';

        Tkd_Wrapper_eval.EvalHeader evalHeader = new Tkd_Wrapper_eval.EvalHeader();
        evalHeader.evEvalType = 'Booking';
        evalHeader.evInsuranceReqFlag = 'Y';
        evalHeader.evEfaReqFlag = '';
        evalHeader.evSlbFlag = 'N';
        evalHeader.evImportsReqFlag = '';
        evalHeader.evProgressPayFlag = 'N';
        evalHeader.evShowFMVFlag = '';
        evalHeader.evFreezeEvalFlag = '';
        evalHeader.evFreezeStartDate = '';
        evalHeader.evFreezeEndDate = '';
        evalHeader.evProgressPayTermMonths = '';
        evalHeader.evEquipmentAmount = '';
        evalHeader.evEquipmentAmountTax = '';
        evalHeader.evEquipmentAmountPercent = '';
        evalHeader.evCostAmount = '';
        evalHeader.evCostAmountTax = '';
        evalHeader.evCostAmountPercent = '';
        evalHeader.evCurrencyType = requestJson.CurrencyIsoCode;
        evalHeader.evExchangeRate = '';
        evalHeader.evAssetCount = '';
        evalHeader.evProductType = Data_Connect_Eval.checkProduct(requestJson.CPL_ls_Product__c);
        evalHeader.evResidualMaxTermMonths = Data_Connect_Eval.termMoths(requestJson.Annex_Pricing_SuperTrump__r.IST__Term__c) ? String.valueOf(requestJson.Annex_Pricing_SuperTrump__r.IST__Term__c) : '0';
        evalHeader.evSpecialTermMonths01 = Data_Connect_Eval.termMoths(requestJson.Annex_Pricing_SuperTrump__r.IST__Term__c) ? '0': (requestJson.Annex_Pricing_SuperTrump__r.IST__Term__c == null) ? '0' : String.valueOf(requestJson.Annex_Pricing_SuperTrump__r.IST__Term__c);
        evalHeader.evSpecialTermMonths02 = '0';
        evalHeader.evSpecialTermMonths03 = '0';
        evalHeader.evEndorsementComment = '';

        Tkd_Wrapper_eval.SicCode sicCode = new Tkd_Wrapper_eval.SicCode();
        sicCode.sicProposedId = '';
        sicCode.sicProposedDescription = '';
        sicCode.sicId = '';
        sicCode.sicDescription = '';

        Tkd_Wrapper_eval.Eval eval = new Tkd_Wrapper_eval.Eval();
        eval.evalHeader = evalHeader;

        Tkd_Wrapper_eval.AmlHit amlHit = new Tkd_Wrapper_eval.AmlHit();
        amlHit.hitRFC = '';
        amlHit.hitEntityName = '';
        amlHit.hitFlag = 'N';
        amlHit.hitUwStatus = '';
        amlHit.hitUwComments = '';
        amlHit.hitAMLStatus = '';
        amlHit.hitAMLComments = '';
        amlHit.hitAMLMaxPercent = '';

        Tkd_Wrapper_eval.Detail detail = new Tkd_Wrapper_eval.Detail();
        detail.eval = eval;
        detail.sicCode = sicCode;
        detail.amlHit = amlHit;
        detail.laActiveFlag = 'Y';
        detail.laCreatedBy = '';
        detail.laCreationDate = info.dayFormat;
        detail.laLastUpdatedBy = '';
        detail.laLastUpdateDate = info.dayFormat;

        Tkd_Wrapper_eval.Request request = new Tkd_Wrapper_eval.Request();
        request.header = header;

        Tkd_Wrapper_eval wrapperEval = new Tkd_Wrapper_eval();
        wrapperEval.request = request;
        wrapperEval.detail = detail;

        return wrapperEval;
    }

    public static Boolean termMoths(Decimal termsMonth) {
        Integer terms = Integer.valueOf(termsMonth);
        if(terms == 0 || terms == 12 || terms == 24 || terms == 36 || terms == 48 || terms == 60 || terms == 72 || terms == 84) {
            return true;
        }
        else {
            return false;
        }
    }

    public static String checkProduct(String product) {
        if(product == 'OPERFIN-FIJA') {
            return 'True Lease';
        }
        else if(product == 'AFINAN-FIJA') {
            return 'Quasi Lease';
        }
        else {
            return 'Term Loan';
        }
    }

    /*
        Method for the EVAL created.
    */
    public static Map<String, Object> callRestEval(Tkd_Wrapper_eval sendJaon, String endPoint) {

        Data_Connect_Eval info = new Data_Connect_Eval();

        Map<String, Object> dataJson = new Map<String, Object>();
        String strResponse = null;

        if(!Test.isRunningTest() || info.urlService == 'http://160.34.7.97:70') {
            try {
                HttpRequest httpRequest = new HttpRequest();
                httpRequest.setEndpoint(info.urlService + endPoint);
                httpRequest.setTimeout(120000);
                httpRequest.setHeader('Content-Type', 'application/json');
                httpRequest.setMethod('POST');
                httpRequest.setBody(System.JSON.serialize(sendJaon));

                Http http = new Http();
                HttpResponse httpResponse = http.send(httpRequest);

                if(httpResponse.getStatusCode() == 200) {
                    strResponse = httpResponse.getBody();
                } else {
                    throw new CalloutException(httpResponse.getBody());
                }
            } catch (Exception ex) {
                throw ex;
            }

            if(!String.isBlank(strResponse)) {
                dataJson = (Map<String, Object>) System.JSON.deserializeUntyped(strResponse);
            }
            if(!dataJson.isEmpty()) {
                return dataJson;
            } else {
                return null;
            }
        } 
        else {
            return dataJson = (Map<String, Object>)JSON.deserializeUntyped(ES2_jsonDummy.entitymasterToJson());
        }
    }

    /*
        Method for the ASSETS created.
    */
    public static Map<String, Object> callRestAsset(Tkd_Wrapper_assets sendJson, String endPoint) {
        
        Data_Connect_Eval info = new Data_Connect_Eval();

        Map<String, Object> dataJson = new Map<String, Object>();
        String strResponse = null;
		System.debug('JSON' + System.JSON.serialize(sendJson));
        if(!Test.isRunningTest() || info.urlService == 'http://160.34.7.97:70') {
            try {
                HttpRequest httpRequest = new HttpRequest();
                httpRequest.setEndpoint(info.urlService + endPoint);
                httpRequest.setTimeout(120000);
                httpRequest.setHeader('Content-Type', 'application/json');
                httpRequest.setMethod('POST');
                httpRequest.setBody(System.JSON.serialize(sendJson));
                Http http = new Http();
                HttpResponse httpResponse = http.send(httpRequest);

                if(httpResponse.getStatusCode() == 200) {
                    strResponse = httpResponse.getBody();
                } else {
                    throw new CalloutException(httpResponse.getBody());
                }
            } catch (Exception ex) {
                throw ex;
            }

            if(!String.isBlank(strResponse)) {
                dataJson = (Map<String, Object>) System.JSON.deserializeUntyped(strResponse);
            }
            if(!dataJson.isEmpty()) {
                return dataJson;
            } else {
                return null;
            }
        }
        else {
            return dataJson = (Map<String, Object>) JSON.deserializeUntyped(EIV_EntityJsonCreateTest.updateinvoices());
        }
    }


    /*
        Method for the COMMENTS created.
    */
    public static Map<String, Object> callRestComments(String sendJson, String endPoint) {
        
        Data_Connect_Eval info = new Data_Connect_Eval();

        Map<String, Object> dataJson = new Map<String, Object>();
        String strResponse = null;

        if(!Test.isRunningTest() || info.urlService == 'http://160.34.7.97:70') {
            try {
                HttpRequest httpRequest = new HttpRequest();
                httpRequest.setEndpoint(info.urlService + endPoint);
                httpRequest.setTimeout(120000);
                httpRequest.setHeader('Content-Type', 'application/json');
                httpRequest.setMethod('POST');
                httpRequest.setBody(sendJson);

                Http http = new Http();
                HttpResponse httpResponse = http.send(httpRequest);

                if(httpResponse.getStatusCode() == 200) {
                    strResponse = httpResponse.getBody();
                } else {
                    throw new CalloutException(httpResponse.getBody());
                }
            } catch (Exception ex) {
                throw ex;
            }

            if(!String.isBlank(strResponse)) {
                dataJson = (Map<String, Object>) System.JSON.deserializeUntyped(strResponse);
            }
            if(!dataJson.isEmpty()) {
                return dataJson;
            } else {
                return null;
            }
        } 
        else {
            return dataJson = (Map<String, Object>) JSON.deserializeUntyped(EIV_EntityJsonCreateTest.updateinvoices());
        }
    }
}