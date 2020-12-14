public without sharing class LMM_ReportedeVisitaLookUp {
    private final static Integer MAX_RESULTS = 7;

    @AuraEnabled(cacheable=true)
    public static list<LookupSearchResult> searchEntitysDelaOp(String searchTerm, List<String> selectedIds, string opportunityId ){
        // Prepare query paramters
        searchTerm += '*';
        system.debug('search: ' + searchTerm + ' oppid: ' + opportunityId);
    
        // Execute search query
        List<List<SObject>> searchResults = [
            FIND :searchTerm
            IN ALL FIELDS
            RETURNING
            LMM_Entidad_de_oportunidad__c(Id, Name, LMM_pd_Entity_CP__r.Name  WHERE id NOT IN :selectedIds AND LMM_pd_Oportunidad__c =: opportunityId)
            LIMIT :MAX_RESULTS
        ];

        // Prepare results
        List<LookupSearchResult> results = new List<LookupSearchResult>();

        // Extract Accounts & convert them into LookupSearchResult
        String accountIcon = 'standard:account';
        LMM_Entidad_de_oportunidad__c[] entitys = (List<LMM_Entidad_de_oportunidad__c>) searchResults[0];
        for (LMM_Entidad_de_oportunidad__c entidad : entitys) {
            results.add(new LookupSearchResult(entidad.Id,'LMM_Entidad_de_oportunidad__c',accountIcon,entidad.LMM_pd_Entity_CP__r.Name,'Entidad • ' + entidad.LMM_pd_Entity_CP__r.Name));
        }
        return results;

    }
}