public class OpportunityContactRoleValidation {
    private Map<Id, Opportunity> newMapOpportunity;
    
    public OpportunityContactRoleValidation(Map<Id, Opportunity> newMapOpportunity){
        this.newMapOpportunity = newMapOpportunity;        
        system.debug('inicia OpportunityContactRoleValidation');
    }
    public void validateContactRole(){
        Map<Id, Opportunity> mapOpportunityFiltered = new Map<Id, Opportunity>();
        for(Opportunity opp : newMapOpportunity.values()){
            string recordtypeid = string.valueOf(opp.RecordTypeId);
            string devname = Schema.getGlobalDescribe().get('Opportunity').getDescribe().getRecordTypeInfosById().get(recordtypeid).getDeveloperName();
            if(opp.probability == 30 && devname !='OPP_LMM'){
                system.debug('validateContactRole');
                mapOpportunityFiltered.put(opp.id,opp);
        	}             
        }
        List<OpportunityContactRole> ocrs = Data_Access_OpportunityContactRole.getOpportunityContactRoleByOppID(mapOpportunityFiltered.keyset());
        //Contruyo un mapa donde el id de las opps son la llave
        Map<Id,OpportunityContactRole> ocrMap = new Map<Id,OpportunityContactRole>();
        for(OpportunityContactRole ocr: ocrs){
            ocrMap.put(ocr.OpportunityId, ocr);
        }
        //Checo que sea tenga el contacto primario
        for(Opportunity o: mapOpportunityFiltered.values()){
            if(!ocrMap.containsKey(o.Id)){ o.addError('Add the primary contact!'); }
        }
        
    }

}