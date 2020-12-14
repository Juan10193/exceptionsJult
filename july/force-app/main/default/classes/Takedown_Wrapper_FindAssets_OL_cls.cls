public class Takedown_Wrapper_FindAssets_OL_cls {
    /**Request by takedown id**/
    public class FindAssetsRequestByTakedown {
        public String takedownId  			{get;set;} //Posibles valores: 1;2;3  
    }
    /**Request by document id**/
    public class FindAssetsRequestByDocument { 
        public String documentId  			{get;set;} //Posibles valores: 1;2;3  
    }
    /**Response**/
    public class FindAssetsResponse {
        public Response response 	{get;set;}
        public List<Assets> assets 		{get;set;}
    }
    public class Response {
    	public String code 		{get;set;}
        public String message 	{get;set;}
        public String success 	{get;set;}    
    }
    public class Assets {
        public Integer 	assetId					{get;set;}
        public Integer 	activeFlag				{get;set;}
        public String 	arrears					{get;set;}
        public String 	assetDescription		{get;set;}
        public String 	assetName				{get;set;}            
        public String 	brand					{get;set;}        
        public String 	colateralDescription	{get;set;}
        public String 	collateralType			{get;set;}
        public Integer 	conceptId 				{get;set;}               
        public Integer 	createdBy				{get;set;}
        //public Integer 	createdOn 				{get;set;}
        public String 	documentId 				{get;set;}
        public String 	ecPolicy				{get;set;}
        public String 	engineNum				{get;set;}
        public String 	faCategory				{get;set;}
        public String 	faSubcategory			{get;set;}
        public Integer 	importedBy				{get;set;}
        public String 	importedOn				{get;set;}
        public String 	incisoInsurance			{get;set;}
        public String 	insuranceCompany		{get;set;}
        public Integer 	insuranceExpirationDate	{get;set;}
        public String 	insurancePolicy			{get;set;}
        public String 	model					{get;set;}
        public String 	modelYear				{get;set;}
        public Integer 	modifiedBy				{get;set;}
        //public Integer 	modifiedOn				{get;set;}
        public double 	paymentAmount			{get;set;}
        public String 	paymentFrecuency		{get;set;}
        public String 	paymentOrder			{get;set;}
        public String 	paymentType				{get;set;}
        public String 	pediment				{get;set;}
        public String 	period					{get;set;}
        public String 	plates					{get;set;}
        public String 	quantity				{get;set;}
        public String 	serialNumber			{get;set;}
        public double 	softCost				{get;set;}
        public String 	takedownId				{get;set;}
        public double 	totalCost				{get;set;}
        public double 	unitCost				{get;set;}
    }

}