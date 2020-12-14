public class wk_TesorerySurvey_controller_cls {
    
    // Metodo que retorna una consulta al objeto Question, la cual permitirá mostrar las preguntas.
 	@AuraEnabled
    public static wk_TesoreryTest__c  getTesoreryTest(String recordId){
        System.debug('recordId: ' + recordId);
        wk_TesoreryTest__c test = [SELECT Id, wk_pd_creditApproval__c, wk_ta_Response1__c, wk_ta_Response2__c, wk_ta_Response3__c, wk_ta_Response4__c, wk_ta_Response5__c, wk_ta_Response6__c, wk_ta_Response7__c, wk_ta_Response8__c FROM wk_TesoreryTest__c where wk_pd_creditApproval__c =: recordId];
        System.debug('TesoreryTest: ' + test);
        return test;
        
    }
    
    // Metodo que valida si hay respuestass NotComplaint en la encuesta de tesoreria  
    @AuraEnabled
    public static boolean getResponses(String recordId){
        Boolean count = false;
        String NotComplaint='Not Compliant';
        System.debug('recordId getResponses: ' + recordId);
        Integer  responseNotComplaint = [SELECT count() FROM wk_TesoreryTest__c  WHERE  wk_pd_creditApproval__c=:recordId and (wk_ta_Response1__c=: NotComplaint or wk_ta_Response2__c=: NotComplaint or wk_ta_Response3__c=: NotComplaint or wk_ta_Response4__c=:NotComplaint or wk_ta_Response5__c=: NotComplaint or wk_ta_Response6__c=: NotComplaint or wk_ta_Response7__c=:NotComplaint or wk_ta_Response8__c=:NotComplaint)];
        Integer responseNotExit=[SELECT count() FROM wk_TesoreryTest__c  WHERE  wk_pd_creditApproval__c=:recordId];
        System.debug('responseNotComplaint'+ responseNotComplaint);
        if(responseNotComplaint==1 || responseNotExit==0 ){
            count = true;
        }
        System.debug('count: ' + count);
        return count;
        
    }
   
	// Metodo que inserta y/o actualiza una encuesta de tesoreria
     @AuraEnabled
    public static void  getupsertTesoreryTest(wk_TesoreryTest__c tesoreryTest){
       Database.UpsertResult resulOperation = Database.upsert(tesoreryTest, false );
       
           if (resulOperation.isSuccess()) {
               System.debug('Successfully' + resulOperation.getId());
           }else {
               // Operation failed, so get all errors
               for(Database.Error err : resulOperation.getErrors()) {
                   System.debug('The following error has occurred.');
                   System.debug(err.getStatusCode() + ': ' + err.getMessage());
                   System.debug('Exporsure fields that affected this error: ' + err.getFields());
               }
           }
   }
    
    
}