trigger opp_ToBacklogWithFundings on TBO020_Takedowns__c (after insert, after update) {
    
    List<id> oppList = new List<id>();
    Map<id, Opportunity> oppMap = new Map<id, Opportunity>();  
   
    //Verifico si el TD es Funded y agrego a la lista la opp
    for(TBO020_Takedowns__c td : Trigger.new){
        if(td.TBO020_tx_Status__c == 'Funded')
        {
            oppList.add(td.TBO020_pd_Opportunity__c);
        }        
    }
    
    //Selecciono solo las opps que esten en estatus Backlog
    for(Opportunity oppsListSelected : [select id,StageName from Opportunity where id IN:oppList and StageName = 'Backlog'])
    {
        oppMap.put(oppsListSelected.id,new Opportunity(id=oppsListSelected.id, StageName = 'Backlog with fundings'));               
    }
    
    //Actualizo las opp con los nuevos valores
    try{
        if(oppMap.size()> 0)
            update oppMap.values();
    }
    Catch(Exception e){
        System.debug('Exception al actualizar las oportunidades como Backlog with fundings OEJ:'+e.getMessage());
    }   
}