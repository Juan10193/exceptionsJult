trigger TR_oppContactPrimaryValidation on Opportunity (before update) {
    /*sSet<Id> oppIds = new Set<Id>();
    List<Opportunity> opps = new List<Opportunity>();
    
    for( Opportunity oppNew: Trigger.new)
    {        
        System.debug('OEJ*1=' +oppNew.PROBABILITY );
        if(oppNew.PROBABILITY == 30)
        {
            System.debug('OEJ*2=' +oppNew.PROBABILITY );
            oppIds.add(oppNew.Id);
            opps.add(oppNew);
        }        
    }     
    List<OpportunityContactRole> ocrs = [SELECT OpportunityId, Role FROM OpportunityContactRole WHERE OpportunityId in: oppIds AND ISPRIMARY = true];
    //Contruyo un mapa donde el id de las opps son la llave
    Map<Id,OpportunityContactRole> ocrMap = new Map<Id,OpportunityContactRole>();
    for(OpportunityContactRole ocr: ocrs){
        ocrMap.put(ocr.OpportunityId, ocr);
    }
    //Checo que sea tenga el contacto primario
    for(Opportunity o: opps){
       if(!ocrMap.containsKey(o.Id)){ o.addError('Add the primary contact!'); }
    }*/
}