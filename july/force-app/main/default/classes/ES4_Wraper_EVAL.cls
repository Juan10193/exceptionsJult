public class ES4_Wraper_EVAL {

    public String pOutEVEVALType {get; set;}
    public String pOutEVInsuranceReqFlag {get; set;}
    public String pOutEVEFAReqFlag {get; set;}
    public String pOutEVSLBFlag {get; set;}
    public String pOutEVImportsReqFlag {get; set;}
    public String pOutEVProgressPayFlag {get; set;}
    public String pOutEVShowFMVFlag {get; set;}
    public String pOutEVFreezeEvalFlag {get; set;}
    public String pOutEVFreezeStartDate {get; set;}
    public String OutEVFreezeEndDate {get; set;}
    public String pOutEVProgressPayTermMonths {get; set;}
    public String pOutEVEquipmentAmount {get; set;}
    public String pOutEVEquipmentAmountTax {get; set;}
    public String pOutEVEquipmentAmountPercent {get; set;}
    public String pOutEVCostAmount {get; set;}
    public String pOutEVCostAmountTax {get; set;}
    public String pOutEVCostAmountPercent {get; set;}
    public String pOutEVCurrencyType {get; set;}
    public String pOutEVExchangeRate {get; set;}
    public String pOutEVAssetCount {get; set;}
    public String pOutEVProductType {get; set;}
    public String pOutEVResidualMaxTermMonths {get; set;}
    public String pOutEVSpecialTermMonths01 {get; set;}
    public String pOutEVSpecialTermMonths02 {get; set;}
    public String pOutEVSpecialTermMonths03 {get; set;}
    public String pOutEVEndorsementComment {get; set;}
    public list <ES4_wraper_EVAL_Assets> pOutEVAssetTBL {get; set;}
    
    public ES4_Wraper_EVAL(){
       pOutEVAssetTBL = new  list <ES4_wraper_EVAL_Assets>();
    }
    
}