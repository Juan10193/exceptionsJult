@isTest
private class Eng_SuperTRUMPSetMappingsTests {
        
    static testMethod void testSettingMappings() {
        insertObjectRelationships();
        DescribeSObjectResult quoteDescribe = Schema.sObjectType.IST__SuperTRUMP_Pricing_Quote__c;
        List<IST__SuperTRUMP_Mapping__c> initialMappings = new List<IST__SuperTRUMP_Mapping__c>{
            new IST__SuperTRUMP_Mapping__c(IST__SF_Object_Name__c = quoteDescribe.getName(),
                IST__SF_Field_Name__c = Schema.sObjectType.IST__SuperTRUMP_Pricing_Quote__c.fields.Purchase_Option_Method__c.Name,
                IST__ST_Field_Name__c = 'Opportunity.Quotes.Quote[].Transaction.EngeniumData.PurchaseOptionMethod',
                IST__SF_Object_Level__c = '1',
                IST__IsSynch__c = true,
                IST__IsSynch_In__c = false,
                IST__Allow_Salesforce_Changes__c = false,
                IST__SOR__c = 'ST',
                IST__SF_Master_Object_Name__c = quoteDescribe.getName()),
            new IST__SuperTRUMP_Mapping__c(IST__SF_Object_Name__c = quoteDescribe.getName(),
                IST__SF_Field_Name__c = Schema.sObjectType.IST__SuperTRUMP_Pricing_Quote__c.fields.Residual_Guarantee_Type__c.Name,
                IST__ST_Field_Name__c = 'Opportunity.Quotes.Quote[].Transaction.EngeniumData.ResidualGuaranteeType',
                IST__SF_Object_Level__c = '1',
                IST__IsSynch__c = true,
                IST__IsSynch_In__c = false,
                IST__Allow_Salesforce_Changes__c = false,
                IST__SOR__c = 'ST',
                IST__SF_Master_Object_Name__c = quoteDescribe.getName()),
            new IST__SuperTRUMP_Mapping__c(IST__SF_Object_Name__c = quoteDescribe.getName(),
                IST__SF_Field_Name__c = Schema.sObjectType.IST__SuperTRUMP_Pricing_Quote__c.fields.Total_Purchase_Option_Fixed_Amount__c.Name,
                IST__ST_Field_Name__c = 'Opportunity.Quotes.Quote[].Transaction.EngeniumData.TotalPurchaseOptionFixedAmount',
                IST__SF_Object_Level__c = '1',
                IST__IsSynch__c = true,
                IST__IsSynch_In__c = false,
                IST__Allow_Salesforce_Changes__c = false,
                IST__SOR__c = 'ST',
                IST__SF_Master_Object_Name__c = quoteDescribe.getName())
        };
        Database.insert(initialMappings, true);

        Eng_SuperTRUMPSetMappings.insertMappings();
    	
        List<IST__SuperTRUMP_Mapping__c> storedMappings = [Select IST__SF_Object_Name__c, IST__SF_Field_Name__c, IST__ST_Field_Name__c
                                                           From IST__SuperTRUMP_Mapping__c];
        
        System.assertequals(41, storedMappings.size());
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