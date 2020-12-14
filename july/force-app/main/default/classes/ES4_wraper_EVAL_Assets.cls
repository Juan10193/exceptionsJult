public class ES4_wraper_EVAL_Assets {
    
    public string pOutEVAssetAssetId{get; set;}
    public string pOutEVAssetRequestId{get; set;}
    public string pOutEVAssetOracleFACategoryID{get; set;}
    public string pOutEVAssetOracleFACategory{get; set;}
    public string pOutEVAssetOracleFASubcategory{get; set;}
    public string pOutEVAssetCollateralType{get; set;}
    public string pOutEVAssetCollateralDescription{get; set;}
    public string pOutEVAssetCollateralId{get; set;}
    public string pOutEVAssetAssetModel{get; set;}
    public string pOutEVAssetAssetModelYear{get; set;}
    public string pOutEVAssetManufacturer{get; set;}
    public string pOutEVAssetCurrencyType{get; set;}
    public string pOutEVAssetExchangeRate{get; set;}
    public string pOutEVAssetQuantity{get; set;}
    public string pOutEVAssetUnitCost{get; set;}
    public string pOutEVAssetUnitTax{get; set;}
    public string pOutEVAssetFreightCost{get; set;}
    public string pOutEVAssetParkingCost{get; set;}
    public string pOutEVAssetInstallationCost{get; set;}
    public string pOutEVAssetTrainingCost{get; set;}
    public string pOutEVAssetWarrantyCost{get; set;}
    public string pOutEVAssetSoftwareCost{get; set;}
    public string pOutEVAssetConditionType{get; set;}
    public string pOutEVAssetTotalCost{get; set;}
    public string pOutEVAssetPhysicalCatType{get; set;}
    public string pOutEVAssetInsuranceType{get; set;}
    public string pOutEVAssetMultLocationFlag{get; set;}
    public string pOutEVAssetRapidTagFlag{get; set;}
    public string pOutEVAssetImportFlag{get; set;}
    public string pOutEVAssetActiveFlag{get; set;}
    public string pOutevAssetClonedAssetId{get;Set;}
    public string pOutEVAssetCreatedBy{get; set;}
    public string pOutEVAssetCreationDate{get; set;}
    public string pOutEVAssetLastUpdatedBy{get; set;}
    public string pOutEVAssetLastUpdateDate{get; set;}
    public string pOutEVAssetNameCreatedBy{get; set;}
    public string pOutEVAssetNameUpdatedBy{get; set;}
    public list <ES4_Wraper_EVAL_Valuation> pOutEVValuationTBL{get; set;}
    public list <ES4_Wraper_EVAL_Endorsement> pOutEVEndorsementTBL{get; set;}
    
    public ES4_wraper_EVAL_Assets(){
        pOutEVValuationTBL = new list <ES4_Wraper_EVAL_Valuation>();
        pOutEVEndorsementTBL = new list <ES4_Wraper_EVAL_Endorsement>();
    }
    
}