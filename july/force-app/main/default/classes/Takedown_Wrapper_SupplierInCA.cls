public class Takedown_Wrapper_SupplierInCA {
    // ::::: Request :::::
    /**
     * name: String
     * rfc: String 
     * 
     */
    
    public class requestAmlHits{
        @AuraEnabled public Parametros parametros {get; set;}
        
    }
    
   
    
    public class Parametros {
         @AuraEnabled public List<Parametro> parametro 					{get; set;}
	}	

	public class Parametro {
		@AuraEnabled public String name 					{get; set;}
		@AuraEnabled public String rfc 						{get; set;}
	}


    // ::::: Response ::::
    /**
     * entityName 			: String 
     * entityType 			: String 
     * rfc 		  			: String 
     * customerType 		: String 
     * partyId    			: Integer
     * country    			: String 
     * state	  			: String 
     * sicCode	  			: String 
     * sicCodeDescription 	: String 
     * hits		  			: String 
     * hitDescription 		: String 
	*/
	
    public class responseAmlHits{
        @AuraEnabled public Result result;
		@AuraEnabled public Status status;
        
    }
    
    public class Result {
		@AuraEnabled public List<AmlHits> amlHits			{get; set;}
	}

	public class AmlHits { 
		@AuraEnabled public Integer partyId					{get; set;}
        @AuraEnabled public Integer vendorId				{get; set;}
		@AuraEnabled public String entityName				{get; set;}
		@AuraEnabled public String entityType				{get; set;}
		@AuraEnabled public String customerType				{get; set;}
		@AuraEnabled public String rfc						{get; set;}
		@AuraEnabled public String sicCode					{get; set;}
		@AuraEnabled public String sicCodeDescription		{get; set;}
		@AuraEnabled public String country					{get; set;}
		@AuraEnabled public String state					{get; set;}
		@AuraEnabled public String hits						{get; set;}
		@AuraEnabled public String hitDescription			{get; set;}
		@AuraEnabled public String crr						{get; set;}
	}	
    
    public class Status {
		@AuraEnabled public String code 					{get; set;}
		@AuraEnabled public String message					{get; set;}
		@AuraEnabled public String detail					{get; set;}
	}


}