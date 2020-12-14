/**
 * @File Name          : CustomDatatableController.cls
 * @Description        : 
 * @Author             : eduardo.amiens@outlook.com
 * @Group              : 
 * @Last Modified By   : eduardo.amiens@outlook.com
 * @Last Modified On   : 1/3/2020 18:24:46
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    1/3/2020   eduardo.amiens@outlook.com     Initial Version
**/
public with sharing class CustomDatatableController {

    private final static Integer MAX_RESULTS = 5;

    public CustomDatatableController() {

    }
    @AuraEnabled(Cacheable=true)
    public static List<LookupSearchResult> searchCollaterals(String searchTerm, List<String> selectedIds) {
        system.debug('termino');
        system.debug(searchTerm);
        system.debug('SelectedIds');
        system.debug(selectedIds);
        List<LookupSearchResult> results = new List<LookupSearchResult>();
        try{
            // Prepare query paramters
            searchTerm += '*';
    		
            // Execute search query
            List<List<SObject>> searchResults = [FIND :searchTerm IN ALL FIELDS RETURNING
            Catalogo_Colaterals__c (Id, Name,  COLATERAL_DESCRIPTION__c, COLATERAL_TYPE__c, MANUFACTURER__c, MODEL_YEAR__c, MODEL__c, Oracle_FA_Category_ID__c 
                                                  WHERE 
                                                  id NOT IN :selectedIds)
                LIMIT :MAX_RESULTS];
    
            // Prepare results           
    
            // Extract Accounts & convert them into LookupSearchResult
            String colateralIcon = 'custom:custom44';
            Catalogo_Colaterals__c [] colaterals = ((List<Catalogo_Colaterals__c>) searchResults[0]);
            system.debug('Catalogo_Colaterals__c ' + colaterals);
            for (Catalogo_Colaterals__c col : colaterals) {
                results.add(new LookupSearchResult(col.Id, 'Catalogo_Colaterals__c', colateralIcon, col.COLATERAL_DESCRIPTION__c, col.COLATERAL_TYPE__c));
            }
        } catch(Exception e){
            System.debug('' + e.getCause());
            System.debug('' + e.getLineNumber());
            System.debug('' + e.getMessage());
        }

        return results;
    }
}