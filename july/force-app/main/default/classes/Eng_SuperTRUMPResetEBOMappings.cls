public with sharing class Eng_SuperTRUMPResetEBOMappings {
	
	public static void resetEBOMappings(){
		doInsertMappings(getDefaultMappings());
	}
    
    private static void doInsertMappings(List<IST__SuperTRUMP_Mapping__c> mappings){
        DescribeSObjectResult eboDescribe = Schema.sObjectType.SuperTRUMP_PQ_EBO__c;
        String eboName = eboDescribe.getName();
        List<IST__SuperTRUMP_Mapping__c> currentEBOMappings = [SELECT IST__SF_Object_Name__c, IST__SF_Field_Name__c
                                                               FROM IST__SuperTRUMP_Mapping__c WHERE IST__SF_Object_Name__c = :eboName];
        
        if (!Schema.sObjectType.IST__SuperTRUMP_Mapping__c.isCreateable()
            || !Schema.sObjectType.IST__SuperTRUMP_Mapping__c.fields.IST__SF_Object_Name__c.isCreateable()
            || !Schema.sObjectType.IST__SuperTRUMP_Mapping__c.fields.IST__SF_Field_Name__c.isCreateable()
            || !Schema.sObjectType.IST__SuperTRUMP_Mapping__c.fields.IST__SF_Parent_Name__c.isCreateable()
            || !Schema.sObjectType.IST__SuperTRUMP_Mapping__c.fields.IST__ST_Field_Name__c.isCreateable()
            || !Schema.sObjectType.IST__SuperTRUMP_Mapping__c.fields.IST__SF_Object_Level__c.isCreateable()
            || !Schema.sObjectType.IST__SuperTRUMP_Mapping__c.fields.IST__IsSynch__c.isCreateable()
            || !Schema.sObjectType.IST__SuperTRUMP_Mapping__c.fields.IST__IsSynch_In__c.isCreateable()
            || !Schema.sObjectType.IST__SuperTRUMP_Mapping__c.fields.IST__SOR__c.isCreateable()
            || !Schema.sObjectType.IST__SuperTRUMP_Mapping__c.fields.IST__SF_Master_Object_Name__c.isCreateable()
            || !Schema.sObjectType.IST__SuperTRUMP_Mapping__c.fields.IST__Allow_Salesforce_Changes__c.isCreateable())
        {
            throw new Eng_IvorySalesforceServices.PermissionException('You do not have permission to create an object of type IST__SuperTRUMP_Mapping__c.');
        }
        Boolean eboDeleted = false;
        if (currentEBOMappings.size() > 0){
            System.debug(currentEBOMappings.size() + ' EBO mappings being deleted.');
            if (!Schema.sObjectType.IST__SuperTRUMP_Mapping__c.isDeletable())
            {
                throw new Eng_IvorySalesforceServices.PermissionException('You do not have permission to delete an object of type IST__SuperTRUMP_Mapping__c.');
            }
            Database.delete(currentEBOMappings, true);
            eboDeleted = true;
        }
        if (mappings.size() > 0 && (currentEBOMappings.size() == 0 || eboDeleted)){
            System.debug(mappings.size() + ' new mappings being created.');
            Database.insert(mappings, true);
        }
    }
    
    private static List<IST__SuperTRUMP_Mapping__c> getDefaultMappings(){
        DescribeSObjectResult quoteDescribe = Schema.sObjectType.IST__SuperTRUMP_Pricing_Quote__c;
        DescribeSObjectResult eboDescribe = Schema.sObjectType.SuperTRUMP_PQ_EBO__c;
        Map<String, Schema.SObjectField> eboFields = eboDescribe.fields.getMap();
        
        List<IST__SuperTRUMP_Mapping__c> mappings = new List<IST__SuperTRUMP_Mapping__c>{
            new IST__SuperTRUMP_Mapping__c(IST__SF_Object_Name__c = eboDescribe.getName(),
                IST__SF_Field_Name__c = Schema.sObjectType.SuperTRUMP_PQ_EBO__c.fields.EBO_Date__c.Name,
                IST__SF_Parent_Name__c = quoteDescribe.getName(),
                IST__ST_Field_Name__c = 'Opportunity.Quotes.Quote[].Transaction.TerminationEBO.ActiveEBOs.EBO[].Date',
                IST__SF_Object_Level__c = '2',
                IST__IsSynch__c = true,
                IST__IsSynch_In__c = false,
                IST__Allow_Salesforce_Changes__c = false,
                IST__SOR__c = 'ST',
                IST__SF_Master_Object_Name__c = quoteDescribe.getName()),
            new IST__SuperTRUMP_Mapping__c(IST__SF_Object_Name__c = eboDescribe.getName(),
                IST__SF_Field_Name__c = Schema.sObjectType.SuperTRUMP_PQ_EBO__c.fields.Amount__c.Name,
                IST__SF_Parent_Name__c = quoteDescribe.getName(),
                IST__ST_Field_Name__c = 'Opportunity.Quotes.Quote[].Transaction.TerminationEBO.ActiveEBOs.EBO[].EBOAmount',
                IST__SF_Object_Level__c = '2',
                IST__IsSynch__c = true,
                IST__IsSynch_In__c = false,
                IST__Allow_Salesforce_Changes__c = false,
                IST__SOR__c = 'ST',
                IST__SF_Master_Object_Name__c = quoteDescribe.getName()),
            new IST__SuperTRUMP_Mapping__c(IST__SF_Object_Name__c = eboDescribe.getName(),
                IST__SF_Field_Name__c = Schema.sObjectType.SuperTRUMP_PQ_EBO__c.fields.Based_on__c.Name,
                IST__SF_Parent_Name__c = quoteDescribe.getName(),
                IST__ST_Field_Name__c = 'Opportunity.Quotes.Quote[].Transaction.TerminationEBO.ActiveEBOs.EBO[].EBOMethod',
                IST__SF_Object_Level__c = '2',
                IST__IsSynch__c = true,
                IST__IsSynch_In__c = false,
                IST__Allow_Salesforce_Changes__c = false,
                IST__SOR__c = 'ST',
                IST__SF_Master_Object_Name__c = quoteDescribe.getName()),
            new IST__SuperTRUMP_Mapping__c(IST__SF_Object_Name__c = eboDescribe.getName(),
                IST__SF_Field_Name__c = Schema.sObjectType.SuperTRUMP_PQ_EBO__c.fields.Premium__c.Name,
                IST__SF_Parent_Name__c = quoteDescribe.getName(),
                IST__ST_Field_Name__c = 'Opportunity.Quotes.Quote[].Transaction.TerminationEBO.ActiveEBOs.EBO[].EBOPremium',
                IST__SF_Object_Level__c = '2',
                IST__IsSynch__c = true,
                IST__IsSynch_In__c = false,
                IST__Allow_Salesforce_Changes__c = false,
                IST__SOR__c = 'ST',
                IST__SF_Master_Object_Name__c = quoteDescribe.getName()),
            new IST__SuperTRUMP_Mapping__c(IST__SF_Object_Name__c = eboDescribe.getName(),
                IST__SF_Field_Name__c = Schema.sObjectType.SuperTRUMP_PQ_EBO__c.fields.FMV__c.Name,
                IST__SF_Parent_Name__c = quoteDescribe.getName(),
                IST__ST_Field_Name__c = 'Opportunity.Quotes.Quote[].Transaction.TerminationEBO.ActiveEBOs.EBO[].FMVamount',
                IST__SF_Object_Level__c = '2',
                IST__IsSynch__c = true,
                IST__IsSynch_In__c = false,
                IST__Allow_Salesforce_Changes__c = false,
                IST__SOR__c = 'ST',
                IST__SF_Master_Object_Name__c = quoteDescribe.getName()),
            new IST__SuperTRUMP_Mapping__c(IST__SF_Object_Name__c = eboDescribe.getName(),
                IST__SF_Field_Name__c = Schema.sObjectType.SuperTRUMP_PQ_EBO__c.fields.Active__c.Name,
                IST__SF_Parent_Name__c = quoteDescribe.getName(),
                IST__ST_Field_Name__c = 'Opportunity.Quotes.Quote[].Transaction.TerminationEBO.ActiveEBOs.EBO[].IsCurrent',
                IST__SF_Object_Level__c = '2',
                IST__IsSynch__c = true,
                IST__IsSynch_In__c = false,
                IST__Allow_Salesforce_Changes__c = false,
                IST__SOR__c = 'ST',
                IST__SF_Master_Object_Name__c = quoteDescribe.getName()),
            new IST__SuperTRUMP_Mapping__c(IST__SF_Object_Name__c = eboDescribe.getName(),
                IST__SF_Field_Name__c = Schema.sObjectType.SuperTRUMP_PQ_EBO__c.fields.Term__c.Name,
                IST__SF_Parent_Name__c = quoteDescribe.getName(),
                IST__ST_Field_Name__c = 'Opportunity.Quotes.Quote[].Transaction.TerminationEBO.ActiveEBOs.EBO[].TermInMonths',
                IST__SF_Object_Level__c = '2',
                IST__IsSynch__c = true,
                IST__IsSynch_In__c = false,
                IST__Allow_Salesforce_Changes__c = false,
                IST__SOR__c = 'ST',
                IST__SF_Master_Object_Name__c = quoteDescribe.getName())
        };
        
        return mappings;
    }
}