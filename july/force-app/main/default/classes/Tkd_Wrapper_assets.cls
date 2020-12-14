public class Tkd_Wrapper_assets {
    public class EvAssets {
		public List<EvalAsset> evalAsset;
	}

	public String requestId;
	public EvAssets evAssets;

	public class EvalAsset {
		public String evAssetOracleFACategoryId;
		public String evAssetOracleFACategory;
		public String evAssetOracleFASubcategory;
		public String evAssetCollateralType;
		public String evAssetCollateralDescription;
		public String evAssetCollateralId;
		public String evAssetAssetModel;
		public String evAssetAssetModelYear;
		public String evAssetManufacturer;
		public String evAssetCurrencyType;
		public String evAssetExchangeRate;
		public Integer evAssetQuantity;
		public Decimal evAssetUnitCost;
		public Integer evAssetUnitTax;
		public Integer evAssetFreightCost;
		public Integer evAssetParkingCost;
		public Integer evAssetInstallationCost;
		public Integer evAssetTrainingCost;
		public Integer evAssetWarrantyCost;
		public Integer evAssetSoftwareCost;
		public String evAssetConditionType;
		public String evAssetTotalCost;
		public String evAssetPhysicalCatType;
		public String evAssetInsuranceType;
		public String evAssetMultLocationFlag;
		public String evAssetRapidTagFlag;
		public String evAssetImportFlag;
		public String evAssetActiveFlag;
		public String evAssetClonedAssetId;
		public String evAssetCreatedBy;
		public String evAssetCreationDate;
		public String evLastUpdatedBy;
		public String evAssetLastUpdateDate;
	}

	public static Tkd_Wrapper_assets parse(String json) {
		return (Tkd_Wrapper_assets) System.JSON.deserialize(json, Tkd_Wrapper_assets.class);
	}
}