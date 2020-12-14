@istest
public class Takedown_Response_Operation_test {
    @istest
    static void Work_Response_ValidateData(){
        EIV_Parameter__c parameters = new EIV_Parameter__c();
        parameters.name = 'fecha limite';
        parameters.EIV_tx_parameter__c = '01/12/2018';
        insert parameters;
        Takedown_Invoice__c createTakedownInvoice = Data_Factory_TakedownInvoice_Test.createTakedownInvoice('xml');
        Takedowns_Contingency_plan__c tkd = [SELECT Id, Name, Annex_Pricing_SuperTrump__c FROM Takedowns_Contingency_plan__c where id =:createTakedownInvoice.TKD_pd_Takedown_CP__c];
        Account cuenta = Data_Factory_Account_Test.createNewAccount('lalo');
       	Data_Factory_Assets_test.createAsset(cuenta.id, tkd.id, createTakedownInvoice.id);
        Takedown_Response_Operation_cls responseOP = new Takedown_Response_Operation_cls(cuenta.id);
        
        Takedown_Wrapper_SATVal_OL_cls.SATValResponse response = new Takedown_Wrapper_SATVal_OL_cls.SATValResponse();
        Takedown_Wrapper_SATVal_OL_cls.ResponseSatVO responseSatVO = new Takedown_Wrapper_SATVal_OL_cls.ResponseSatVO();        
        responseSatVO.statusCode = '200'; 			
        responseSatVO.statusDescription = 'action:priority';    	
        responseSatVO.statusFactura = 'statusFactura';    	
        responseSatVO.messsage = 'testmensaje';  			
        responseSatVO.enableCancelation = 'test';
        Takedown_Wrapper_SATVal_OL_cls.ResponseValidatorVO responseValidatorVO = new Takedown_Wrapper_SATVal_OL_cls.ResponseValidatorVO();
        responseValidatorVO.code = '200';
        responseValidatorVO.message = 'testmensaje';
        responseValidatorVO.success = 'action:priority';
        
        Takedown_Wrapper_SATVal_OL_cls.ComprobanteVO comprobanteVO = new Takedown_Wrapper_SATVal_OL_cls.ComprobanteVO();
        
        
        Takedown_Wrapper_SATVal_OL_cls.EmisorVO emisorVO = new Takedown_Wrapper_SATVal_OL_cls.EmisorVO();
        emisorVO.nombre = 'testname';
        emisorVO.regimenFiscal = 'regfiscal';
        emisorVO.rfc = 'rfc';
        comprobanteVO.emisorVO = emisorVO;
        comprobanteVO.moneda = 'USD';
        
        response.comprobanteVO = comprobanteVO;
        response.responseSatVO = responseSatVO;
        response.responseValidatorVO = responseValidatorVO;
        List<Supplier__c> sub = new List<Supplier__c>();
        responseOP.Work_Response_ValidateData(response, createTakedownInvoice.TKD_txt_Document_ID__c, sub, tkd.Id);
        
    }
    @istest
    static void Work_Response_FindAssets(){
        EIV_Parameter__c parameters = new EIV_Parameter__c();
        parameters.name = 'fecha limite';
        parameters.EIV_tx_parameter__c = '01/12/2018';
        insert parameters;
        Takedown_Invoice__c createTakedownInvoice = Data_Factory_TakedownInvoice_Test.createTakedownInvoice('xml');
        Takedowns_Contingency_plan__c tkd = [SELECT Id, Name, Annex_Pricing_SuperTrump__c FROM Takedowns_Contingency_plan__c where id =:createTakedownInvoice.TKD_pd_Takedown_CP__c];
        Account cuenta = Data_Factory_Account_Test.createNewAccount('lalo');
       	Data_Factory_Assets_test.createAsset(cuenta.id, tkd.id, createTakedownInvoice.id);
        Takedown_Response_Operation_cls responseOP = new Takedown_Response_Operation_cls(cuenta.id);
        
        Takedown_Wrapper_FindAssets_OL_cls.FindAssetsResponse findAssetsResponse = new Takedown_Wrapper_FindAssets_OL_cls.FindAssetsResponse();
        Takedown_Wrapper_FindAssets_OL_cls.Response response = new Takedown_Wrapper_FindAssets_OL_cls.Response();
        response.code = '200';
        response.message = 'message';
        response.success = 'Success';
        list<Takedown_Wrapper_FindAssets_OL_cls.Assets> listAssets = new list<Takedown_Wrapper_FindAssets_OL_cls.Assets>();
        Takedown_Wrapper_FindAssets_OL_cls.Assets assets = new Takedown_Wrapper_FindAssets_OL_cls.Assets(); 
        assets.assetId	= 1;				
            assets.activeFlag = 1;		
            assets.arrears = 'arrears';	
            assets.assetDescription = 'assetDescription';	
            assets.assetName = 'NameAsset';		           
            assets.brand = 'brand';				       
            assets.colateralDescription = 'colateralDescription';	
            assets.collateralType = 'collateralType';		
            assets.conceptId = 12;			               
            assets.createdBy = 12;
            assets.documentId = createTakedownInvoice.TKD_txt_Document_ID__c; 				
            assets.ecPolicy = 'ecPolicy';				
            assets.engineNum = 'engineNum'; 				
            assets.faCategory = 'faCategory';		
            assets.faSubcategory = 'faSubcategory';		
            assets.importedBy	= 123;		
            assets.importedOn = 'importedOn';				
            assets.incisoInsurance	= 'incisoInsurance';		
            assets.insuranceCompany = 'insuranceCompany';	
            assets.insuranceExpirationDate	= 123;
            assets.insurancePolicy	= 'insurancePolicy';	
            assets.model= 'model';				
            assets.modelYear = 'modelYear';				
            assets.modifiedBy = 123;
            assets.paymentAmount	= 12.5;	
            assets.paymentFrecuency= 'paymentFrecuency';	
            assets.paymentOrder = 'paymentOrder';			
            assets.paymentType	= 'paymentType';			
            assets.pediment = 'pediment';				
            assets.period	= 'period';				
            assets.plates	= 'plates';				
            assets.quantity = 'quantity';				
            assets.serialNumber = 'serialNumber';		
            assets.softCost = 12.5;			
            assets.takedownId	= tkd.id;			
            assets.totalCost	= 12.5;			
            assets.unitCost	= 12.5;
        listAssets.add(assets);
        findAssetsResponse.response = response;
        findAssetsResponse.assets = listAssets; 
        //responseOP.Work_Response_FindAssets(findAssetsResponse);
        
    }

}