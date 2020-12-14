public class LogCustomerService {
    
    /*public static void upsertLog(CaseMilestone cm, String commentsBody) 
    {
        if (cm.CaseId != null)
        {
            Customer_Service_Log__c log = new Customer_Service_Log__c(CAS001_rb_CasoId__c=cm.CaseId,Milestone__c = cm.id,CompletionDate__c=cm.CompletionDate,StartDate__c=cm.StartDate, TargetResponseInMins__c=cm.TargetResponseInMins,CAS002_tx_Nombre_Evento_Clave__c = cm.MilestoneType.Name,CAS004_rb_usuario__c= System.UserInfo.getUserId());
            if(commentsBody!='' ) 
            {
                log.CAS003_tx_CaseComments__c = commentsBody;
            }            
            try {
                upsert log;
            } catch (DmlException e) {
                
                System.debug('Excepción ' + e);
                log.id = [Select id from Customer_Service_Log__c where Milestone__c =:cm.id limit 1].id;
                update log;
            }            
                      
        }
    }    */
    public static void upsertLogSC(Id CaseId, String IdMilestone, Datetime CompletionDate, Datetime StartDate, Decimal TargetResponseInMins, String Nombre_Evento_Clave, String commentsBody) 
    {
        if (CaseId != null && String.isNotBlank(CaseId))
        {
            Customer_Service_Log__c log = new Customer_Service_Log__c(CAS001_rb_CasoId__c=CaseId,
                                                                      Milestone__c = IdMilestone,
                                                                      CompletionDate__c=CompletionDate,
                                                                      StartDate__c=StartDate, 
                                                                      TargetResponseInMins__c=TargetResponseInMins,
                                                                      CAS002_tx_Nombre_Evento_Clave__c = Nombre_Evento_Clave,
                                                                      CAS004_rb_usuario__c= System.UserInfo.getUserId());
            if(commentsBody!='' ) 
            {
                log.CAS003_tx_CaseComments__c = commentsBody;
            }            
            try {
                upsert log;
            } catch (DmlException e) {
                log.id = [Select id from Customer_Service_Log__c where Milestone__c =:IdMilestone limit 1].id;
                update log;
            }            
                      
        }
    }       
}