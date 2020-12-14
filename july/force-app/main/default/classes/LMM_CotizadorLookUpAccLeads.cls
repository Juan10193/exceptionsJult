public without sharing class LMM_CotizadorLookUpAccLeads {
    private final static Integer MAX_RESULTS = 7;

    @AuraEnabled(Cacheable=true)
    public static List<LookupSearchResult> search(String searchTerm, List<String> selectedIds) {
        // Prepare query paramters
        searchTerm += '*';
        
        // Execute search query
        List<List<SObject>> searchResults = [
            FIND :searchTerm
            IN ALL FIELDS
            RETURNING
                Account(Id, Name, ACC_fm_Company_Legal_Name__c  WHERE id NOT IN :selectedIds),
                Lead(Id,Name, Company  WHERE id NOT IN :selectedIds)
            LIMIT :MAX_RESULTS
        ];

        // Prepare results
        List<LookupSearchResult> results = new List<LookupSearchResult>();

        // Extract Accounts & convert them into LookupSearchResult
        String accountIcon = 'standard:account';
        Account[] accounts = (List<Account>) searchResults[0];
        for (Account account : accounts) {
            results.add(new LookupSearchResult(account.Id,'Account',accountIcon,account.ACC_fm_Company_Legal_Name__c,'Account • ' + account.ACC_fm_Company_Legal_Name__c));
        }

        // Extract Leads & convert them into LookupSearchResult
        String leadIcon = 'standard:lead';
        Lead[] leads = (List<Lead>) searchResults[1];
        for (Lead ld : leads) {
            results.add(new LookupSearchResult(ld.Id,'Lead',leadIcon,ld.Company,'Lead • ' + ld.Company));
        }

      
        return results;
    }


    @AuraEnabled
    public static Account getAccountFields(string recordId){
        Account acc = [SELECT Id, ACC_fm_Company_Legal_Name__c, (select Id, Name, Phone, Email FROM Contacts  ORDER BY LastModifiedDate DESC) from Account where Id=:recordId][0];
        return acc;
    }

    @AuraEnabled
    public static Lead getLeadFields(string recordId){
        Lead prospect = [SELECT Id, Name, Company, City, State, PostalCode, Country, Phone, Email FROM Lead  where Id=:recordId][0];
        return prospect;
    }
}