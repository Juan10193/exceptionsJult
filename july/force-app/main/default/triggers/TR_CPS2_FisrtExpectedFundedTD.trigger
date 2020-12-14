trigger TR_CPS2_FisrtExpectedFundedTD on TBO021_Takedowns_forecast__c (after insert, after update) {
   
    Set<id> oppList = new Set<id>();
    Map<id, Opportunity> oppMap = new Map<id, Opportunity>();  
   
    //Verifico si el TD Forecast is Commited y NO es Funded or Cancelled y agrego a la lista la opp
    for(TBO021_Takedowns_forecast__c td : Trigger.new)
    {
        
        //if(td.TBO021_ls_Committed__c == 'Yes')
        //{
        if(td.TBO021_ls_Status__c == 'New' || td.TBO021_ls_Status__c == 'Converted')
        {
            oppList.add(td.TBO021_rb_Opportunity__c);
        }                    
        //}
    }  
    
    //Debo de eliminar de la seleccion las opps que contengan TD Forecast is Commited y es Funded or Cancelled   
    for(TBO021_Takedowns_forecast__c tdForecastListSelected : [select id,TBO021_ls_Committed__c,TBO021_ls_Status__c, TBO021_fh_Funding_Date__c,TBO021_rb_Opportunity__c 
                                                               from TBO021_Takedowns_forecast__c 
                                                               where TBO021_rb_Opportunity__c IN:oppList 
                                                               and TBO021_ls_Committed__c = 'Yes' 
                                                               and TBO021_ls_Status__c not in ('New','Converted')])
    {  
        if(oppList.contains((Id)tdForecastListSelected.TBO021_rb_Opportunity__c))
        {
            oppList.remove(tdForecastListSelected.TBO021_rb_Opportunity__c);
        }
    } 
    
    //De las opps que quedan que contengan TD Forecast is Commited tomar la fecha mas cercana y actualizar la opp   
    if(oppList.size()>0)
    {
        
        
        
        for( AggregateResult tdForecastListSelected : [select Min(TBO021_fh_Delivery_Date__c), TBO021_rb_Opportunity__c 
                                                                   from TBO021_Takedowns_forecast__c 
                                                                   where TBO021_rb_Opportunity__c IN:oppList
                                                                   and TBO021_ls_Committed__c = 'Yes' 
                                                   				   and TBO021_ls_Status__c in ('New','Converted') group by TBO021_rb_Opportunity__c])
        {
            System.debug('OEJ Creamos las opps para actualizar la fecha minima de fondeo');
            System.debug('OEJ (Id)tdForecastListSelected.get(TBO021_rb_Opportunity__c)' + (Id)tdForecastListSelected.get('TBO021_rb_Opportunity__c'));
            System.debug('OEJ (Date)tdForecastListSelected.get(expr0)' + (Date)tdForecastListSelected.get('expr0'));
            
            
            oppMap.put((Id)tdForecastListSelected.get('TBO021_rb_Opportunity__c'), new Opportunity(id=(Id)tdForecastListSelected.get('TBO021_rb_Opportunity__c'), CPS2_da_Expected_1st_funding_date__c = (Date)tdForecastListSelected.get('expr0')));
            
        }   
    }
    
    //Actualizo las opp con las fechas de fondeo
    try{
        if(oppMap.size()> 0)
            update oppMap.values();
    }Catch(Exception e){System.debug('Exception al actualizar las oportunidades con las fechas de fondeo:'+e.getMessage());}       
}