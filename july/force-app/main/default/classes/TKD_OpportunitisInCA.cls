public class TKD_OpportunitisInCA {
	 @InvocableMethod
    public static list<Opportunity> getOppApproveds (list<string> recordId){
        /*list<Opportunity> opp = [Select Id, Name from Opportunity where Id in:recordId 
                                 AND (Id in (select CP_rb_Oportunidad__c from Opportunity_in_Credit_approval_CP__c
                                 where CP_rb_Credit_approval_CP__r.SP3_pl_Credit_Approval_Status__c='Approved'))
                                ];*/
    
    	 list<Opportunity> opp =[Select Id, Name from Opportunity limit 1];
        
        list<Opportunity>filterOps = new list<Opportunity>();
        
        for(Opportunity op:opp){
            op.Name = op.Name + ' (Id: ' + op.Id + ')';
            filterOps.add(op);
        }
        return filterOps;
    }
}