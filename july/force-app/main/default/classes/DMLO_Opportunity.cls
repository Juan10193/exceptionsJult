public class DMLO_Opportunity {
    public DMLO_Opportunity(){
        
    }
    public static void updateOpportunity(List<Opportunity> listOpportunityToUpdate){
       // if(Schema.sObjectType.Opportunity.isUpdateable){ Database.deleteResult[] srList = Database.delete(c, false);
            Database.SaveResult [] updateResult = Database.update(listOpportunityToUpdate, false);
            for (Database.SaveResult r : updateResult){
            	if (!r.isSuccess()){
            		for (Database.Error e : r.getErrors()){
                        System.debug(LoggingLevel.ERROR,'e.getStatusCode() ' + e.getStatusCode());
                        System.debug(LoggingLevel.ERROR,'e.getFields() ' + e.getFields());
                        System.debug(LoggingLevel.ERROR,'e.getMessage() ' + e.getMessage());
                    }            
            	}            
            }
       // }
    }

}