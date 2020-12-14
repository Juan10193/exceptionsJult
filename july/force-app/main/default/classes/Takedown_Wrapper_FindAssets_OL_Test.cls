@Istest
public class Takedown_Wrapper_FindAssets_OL_Test {
    @Istest
    public static void TakedownWrapperFindAssetsOLTest(){
        Takedown_Wrapper_FindAssets_OL_cls.FindAssetsRequestByTakedown findAssestTkd = new Takedown_Wrapper_FindAssets_OL_cls.FindAssetsRequestByTakedown();
        	findAssestTkd.takedownId = 'a2YS00000032VKOMA2';
        
        Takedown_Wrapper_FindAssets_OL_cls.FindAssetsRequestByDocument findAssestDoc = new Takedown_Wrapper_FindAssets_OL_cls.FindAssetsRequestByDocument();
        	findAssestDoc.documentId= 'a2YS00000032VKOMA2';
        
       
        
        Takedown_Wrapper_FindAssets_OL_cls.Response responses = new Takedown_Wrapper_FindAssets_OL_cls.Response();
            responses.code = '200';
            responses.message  = 'Success';
            responses.success = 'S';
        
         Takedown_Wrapper_FindAssets_OL_cls.Assets  assets = new Takedown_Wrapper_FindAssets_OL_cls.Assets();
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
            assets.documentId = 'a2YS00000032VKOMA2'; 				
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
            assets.takedownId	= 'a2YS00000032VKOMA2';			
            assets.totalCost	= 12.5;			
            assets.unitCost	= 12.5;
        
      	Takedown_Wrapper_FindAssets_OL_cls.FindAssetsResponse findAssetResp = new Takedown_Wrapper_FindAssets_OL_cls.FindAssetsResponse();
            findAssetResp.assets = new List<Takedown_Wrapper_FindAssets_OL_cls.Assets>();      
            findAssetResp.response =  responses;
        
       	
    }
    

}