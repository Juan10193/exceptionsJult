trigger TR_sumTakedownsCP on Takedowns_Contingency_plan__c (after update, after insert, after delete, after undelete) {
    
    List<id> oppList = new List<id>();
    Map<id, Opportunity> oppMap = new Map<id, Opportunity>();
    
    if(Trigger.isInsert || Trigger.isUndelete || Trigger.isUpdate){
        For(Takedowns_Contingency_plan__c td : Trigger.new){
            oppList.add(td.CPL_rb_Opp__c);
        }
    }
    if(Trigger.isDelete){
        For(Takedowns_Contingency_plan__c td:Trigger.old){
            oppList.add(td.CPL_rb_Opp__c);
        }
    }    
    //OEJ pongo en zero los datos que voy a re-calcular 
    for(Id parentId : oppList){
        if(!oppMap.containsKey(parentId)){
            oppMap.put(parentId, new Opportunity(id = parentId, CPL_nu_TakeDowns_in_Opportunity__c = 0, CPL_nu_Movement_in_credit_line__c = 0));
        }
    }
    
    //OEJ Realizo la consulta para agrupar los datos de los takedowns
    list<AggregateResult> agInstance = [select CPL_rb_Opp__c, Count(Id), SUM(CPL_nu_Movement_in_credit_line__c) from Takedowns_Contingency_plan__c where CPL_rb_Opp__c IN: oppList and CPL_ls_Stage__c != 'Cancelled' group by CPL_rb_Opp__c];
    for(AggregateResult agInstances : agInstance){
        Id parentId = (Id)agInstances.get('CPL_rb_Opp__c');
        oppMap.get(parentId).CPL_nu_TakeDowns_in_Opportunity__c = (Decimal)agInstances.get('expr0');
        oppMap.get(parentId).CPL_nu_Movement_in_credit_line__c = (Decimal)agInstances.get('expr1');
    }
    
    //Actualizo los datos re-calculados
    try{
        if(oppMap.size()> 0)
            update oppMap.values();
    }
    Catch(Exception e){
        System.debug('Exception al actualizar las oportunidades OEJ:'+e.getMessage());
    }    
}