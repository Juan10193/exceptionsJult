@isTest
private class Eng_SuperTRUMPResetEBOMappingsTests {
        
    static testMethod void testSettingEBOMappings() {
        insertObjectRelationships();
        DescribeSObjectResult quoteDescribe = Schema.sObjectType.IST__SuperTRUMP_Pricing_Quote__c;
        DescribeSObjectResult eboDescribe = Schema.sObjectType.SuperTRUMP_PQ_EBO__c;
        Map<String, Schema.SObjectField> eboFields = eboDescribe.fields.getMap();
        
        List<IST__SuperTRUMP_Mapping__c> initialMappings = new List<IST__SuperTRUMP_Mapping__c>{
            new IST__SuperTRUMP_Mapping__c(IST__SF_Object_Name__c = eboDescribe.getName(),
                IST__SF_Field_Name__c = Schema.sObjectType.SuperTRUMP_PQ_EBO__c.fields.EBO_Date__c.Name,
                IST__SF_Parent_Name__c = quoteDescribe.getName(),
                IST__ST_Field_Name__c = 'Opportunity.Quotes.Quote[].Transaction.TerminationEBO.EBOs.EBO[].Date',
                IST__SF_Object_Level__c = '2',
                IST__IsSynch__c = true,
                IST__IsSynch_In__c = false,
                IST__Allow_Salesforce_Changes__c = false,
                IST__SOR__c = 'ST',
                IST__SF_Master_Object_Name__c = quoteDescribe.getName()),
            new IST__SuperTRUMP_Mapping__c(IST__SF_Object_Name__c = eboDescribe.getName(),
                IST__SF_Field_Name__c = Schema.sObjectType.SuperTRUMP_PQ_EBO__c.fields.Amount__c.Name,
                IST__SF_Parent_Name__c = quoteDescribe.getName(),
                IST__ST_Field_Name__c = 'Opportunity.Quotes.Quote[].Transaction.TerminationEBO.EBOs.EBO[].EBOAmount',
                IST__SF_Object_Level__c = '2',
                IST__IsSynch__c = true,
                IST__IsSynch_In__c = false,
                IST__Allow_Salesforce_Changes__c = false,
                IST__SOR__c = 'ST',
                IST__SF_Master_Object_Name__c = quoteDescribe.getName()),
            new IST__SuperTRUMP_Mapping__c(IST__SF_Object_Name__c = eboDescribe.getName(),
                IST__SF_Field_Name__c = Schema.sObjectType.SuperTRUMP_PQ_EBO__c.fields.Based_on__c.Name,
                IST__SF_Parent_Name__c = quoteDescribe.getName(),
                IST__ST_Field_Name__c = 'Opportunity.Quotes.Quote[].Transaction.TerminationEBO.EBOs.EBO[].EBOMethod',
                IST__SF_Object_Level__c = '2',
                IST__IsSynch__c = true,
                IST__IsSynch_In__c = false,
                IST__Allow_Salesforce_Changes__c = false,
                IST__SOR__c = 'ST',
                IST__SF_Master_Object_Name__c = quoteDescribe.getName()),
            new IST__SuperTRUMP_Mapping__c(IST__SF_Object_Name__c = eboDescribe.getName(),
                IST__SF_Field_Name__c = Schema.sObjectType.SuperTRUMP_PQ_EBO__c.fields.Premium__c.Name,
                IST__SF_Parent_Name__c = quoteDescribe.getName(),
                IST__ST_Field_Name__c = 'Opportunity.Quotes.Quote[].Transaction.TerminationEBO.EBOs.EBO[].EBOPremium',
                IST__SF_Object_Level__c = '2',
                IST__IsSynch__c = true,
                IST__IsSynch_In__c = false,
                IST__Allow_Salesforce_Changes__c = false,
                IST__SOR__c = 'ST',
                IST__SF_Master_Object_Name__c = quoteDescribe.getName()),
            new IST__SuperTRUMP_Mapping__c(IST__SF_Object_Name__c = eboDescribe.getName(),
                IST__SF_Field_Name__c = Schema.sObjectType.SuperTRUMP_PQ_EBO__c.fields.FMV__c.Name,
                IST__SF_Parent_Name__c = quoteDescribe.getName(),
                IST__ST_Field_Name__c = 'Opportunity.Quotes.Quote[].Transaction.TerminationEBO.EBOs.EBO[].FMVamount',
                IST__SF_Object_Level__c = '2',
                IST__IsSynch__c = true,
                IST__IsSynch_In__c = false,
                IST__Allow_Salesforce_Changes__c = false,
                IST__SOR__c = 'ST',
                IST__SF_Master_Object_Name__c = quoteDescribe.getName()),
            new IST__SuperTRUMP_Mapping__c(IST__SF_Object_Name__c = eboDescribe.getName(),
                IST__SF_Field_Name__c = Schema.sObjectType.SuperTRUMP_PQ_EBO__c.fields.Active__c.Name,
                IST__SF_Parent_Name__c = quoteDescribe.getName(),
                IST__ST_Field_Name__c = 'Opportunity.Quotes.Quote[].Transaction.TerminationEBO.EBOs.EBO[].IsCurrent',
                IST__SF_Object_Level__c = '2',
                IST__IsSynch__c = true,
                IST__IsSynch_In__c = false,
                IST__Allow_Salesforce_Changes__c = false,
                IST__SOR__c = 'ST',
                IST__SF_Master_Object_Name__c = quoteDescribe.getName()),
            new IST__SuperTRUMP_Mapping__c(IST__SF_Object_Name__c = eboDescribe.getName(),
                IST__SF_Field_Name__c = Schema.sObjectType.SuperTRUMP_PQ_EBO__c.fields.Term__c.Name,
                IST__SF_Parent_Name__c = quoteDescribe.getName(),
                IST__ST_Field_Name__c = 'Opportunity.Quotes.Quote[].Transaction.TerminationEBO.EBOs.EBO[].TermInMonths',
                IST__SF_Object_Level__c = '2',
                IST__IsSynch__c = true,
                IST__IsSynch_In__c = false,
                IST__Allow_Salesforce_Changes__c = false,
                IST__SOR__c = 'ST',
                IST__SF_Master_Object_Name__c = quoteDescribe.getName())
        };
        Database.insert(initialMappings, true);

        Eng_SuperTRUMPResetEBOMappings.resetEBOMappings();
    	
        List<IST__SuperTRUMP_Mapping__c> storedMappings = [Select IST__SF_Object_Name__c, IST__SF_Field_Name__c, IST__ST_Field_Name__c
                                                           From IST__SuperTRUMP_Mapping__c];
        System.assertequals(7, storedMappings.size());

        String sfObjectName = eboDescribe.getName();
        String sfFieldName = Schema.sObjectType.SuperTRUMP_PQ_EBO__c.fields.Amount__c.Name;

        List<IST__SuperTRUMP_Mapping__c> eboAmountMapping = [Select IST__SF_Object_Name__c, IST__SF_Field_Name__c, IST__ST_Field_Name__c
                                                             From IST__SuperTRUMP_Mapping__c
                                                             Where IST__SF_Object_Name__c = :sfObjectName And IST__SF_Field_Name__c = :sfFieldName];

        System.assertequals('Opportunity.Quotes.Quote[].Transaction.TerminationEBO.ActiveEBOs.EBO[].EBOAmount', eboAmountMapping[0].IST__ST_Field_Name__c);                                                                                                   
    }
    
    static void insertObjectRelationships(){
        Map<String, IST__SuperTRUMP_Object_Relationships__c> objRelMap = IST__SuperTRUMP_Object_Relationships__c.getAll();
        Schema.DescribeSObjectResult quoteDescribe = Schema.sObjectType.IST__SuperTRUMP_Pricing_Quote__c;
        if (!objRelMap.containsKey(quoteDescribe.getName())){
            IST__SuperTRUMP_Object_Relationships__c objRel = new IST__SuperTRUMP_Object_Relationships__c();
            objRel.Name = quoteDescribe.getName();
            
            Schema.DescribeFieldResult fieldResult = Schema.sObjectType.IST__SuperTRUMP_PQ_Asset__c.fields.IST__Pricing_Quote__c;
            
            objRel.IST__Child_To_Master_Field_Name__c = fieldResult.getName();
            objRel.IST__Child_To_Master_Relationship_Name__c = fieldResult.getRelationshipName();
            
            if (!Schema.sObjectType.IST__SuperTRUMP_Object_Relationships__c.isCreateable()
                || !Schema.sObjectType.IST__SuperTRUMP_Object_Relationships__c.fields.Name.isCreateable()
                || !Schema.sObjectType.IST__SuperTRUMP_Object_Relationships__c.fields.IST__Child_To_Master_Field_Name__c.isCreateable()
                || !Schema.sObjectType.IST__SuperTRUMP_Object_Relationships__c.fields.IST__Child_To_Master_Relationship_Name__c.isCreateable())
            {
                throw new Eng_IvorySalesforceServices.PermissionException('You do not have permission to create an object of type SuperTRUMP_Object_Relationships__c.');
            }
            Database.insert(objRel, true);
        }
    }
}