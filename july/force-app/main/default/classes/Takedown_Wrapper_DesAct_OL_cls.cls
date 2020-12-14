public class Takedown_Wrapper_DesAct_OL_cls {
    /**Request**/
    public class DesActRequest {
        public String takedownId  			{get;set;} //Posibles valores: 10
    }
    /**Response**/
    public class DesActResponse {
        public Response response  			{get;set;} //Posibles valores: 10
        public List<Assets> assets  			{get;set;} //Posibles valores: 10
    }
    public class Response {
        public String code  			{get;set;} //Posibles valores: 10
        public String message  			{get;set;} //Posibles valores: 10
        public String success  			{get;set;} //Posibles valores: 10
    }
    public class Assets {
        public String invAssetId  				{get;set;} //Posibles valores: 10
        public String takedownId  				{get;set;} //Posibles valores: 10
        public String activeFlag  				{get;set;} //Posibles valores: 10
        public String arrears  					{get;set;} //Posibles valores: 10
        public String assetId  					{get;set;} //Posibles valores: 10
        public String brand  					{get;set;} //Posibles valores: 10
        public String colateralDescription  	{get;set;} //Posibles valores: 10
        public String collateralType  			{get;set;} //Posibles valores: 10	
        public String createdBy  				{get;set;} //Posibles valores: 10
        public String creationDate  			{get;set;} //Posibles valores: 10
        public String ecPolicy  				{get;set;} //Posibles valores: 10
        public String engineNum  				{get;set;} //Posibles valores: 10
        public String faCategory  				{get;set;} //Posibles valores: 10
        public String faSubcategory  			{get;set;} //Posibles valores: 10
        public String importDate  				{get;set;} //Posibles valores: 10
        public String importedBy  				{get;set;} //Posibles valores: 10
        public String incisoInsurance  			{get;set;} //Posibles valores: 10
        public String insuranceCompany  		{get;set;} //Posibles valores: 10
        public String insuranceExpirationDate  	{get;set;} //Posibles valores: 10
        public String insurancePolicy  			{get;set;} //Posibles valores: 10
        public String invLinesId  				{get;set;} //Posibles valores: 10
        public String lastUpdateDate  			{get;set;} //Posibles valores: 10
        public String lastUpdatedBy  			{get;set;} //Posibles valores: 10
        public String model  					{get;set;} //Posibles valores: 10
        public String modelYear  				{get;set;} //Posibles valores: 10
        public String paymentAmount  			{get;set;} //Posibles valores: 10
        public String paymentFrecuency  		{get;set;} //Posibles valores: 10
        public String paymentOrder  			{get;set;} //Posibles valores: 10
        public String paymentType  				{get;set;} //Posibles valores: 10
        public String pediment  				{get;set;} //Posibles valores: 10
        public String period  					{get;set;} //Posibles valores: 10
        public String plates  					{get;set;} //Posibles valores: 10
        public String quantity  				{get;set;} //Posibles valores: 10
        public String serialNumber  			{get;set;} //Posibles valores: 10
        public String softCost  				{get;set;} //Posibles valores: 10
        public String sourceAssetDescription  	{get;set;} //Posibles valores: 10
        public String sourceAssetName  			{get;set;} //Posibles valores: 10
        public String totalCost  				{get;set;} //Posibles valores: 10
        public String unitCost  				{get;set;} //Posibles valores: 10
    }

}