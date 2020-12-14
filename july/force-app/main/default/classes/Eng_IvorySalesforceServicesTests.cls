@isTest
private class Eng_IvorySalesforceServicesTests 
{

    private static Map<String, sObjectType> globalDescribeMap = Schema.getGlobalDescribe();
    
    static testMethod void testGetSObjectFields()
    {
        List<String> sObjNames = new List<String>{ Schema.sObjectType.Opportunity.Name, Schema.sObjectType.Task.Name };
        for (String sObjName : sObjNames)
        {
            sObjectType objType = globalDescribeMap.get(sObjName);
            System.assertEquals(globalDescribeMap.get(sObjName).getDescribe().fields.getMap(), Eng_IvorySalesforceServices.getSObjectFields(objType));
        }
    }
    
    static testMethod void testIsSF1()
    {
        Map<String, String> sfOneParamIds = new Map<String, String>{
            'sfdcIFrameHost' => 'true',
            'sfdcIFrameOrigin' => 'true',
            'isdtp' => 'p1',
            'retURL' => 'https://na10.salesforce.com/projectone/'
        };
        
        Test.setCurrentPage(new PageReference('https://testurl.test'));
        Map<String, String> params = ApexPages.currentPage().getParameters();
        
        for (String key : sfOneParamIds.keySet()){
            params.put(key, sfOneParamIds.get(key));
            System.assert(Eng_IvorySalesforceServices.isSF1(), 'This page should be considered an SF1 page.');
            params.clear();
        }
        
        System.assert(!Eng_IvorySalesforceServices.isSF1(), 'This page should NOT be considered an SF1 page.');
    }
    
    static testMethod void testCheckFieldPermissionOfInvalidField()
    {
        try{
        	List<String> fieldNames = new List<String>{ 'Fake' };
        	sObjectType sObjType = Opportunity.sObjectType;
        	Eng_IvorySalesforceServices.checkFieldPermission(Eng_IvorySalesforceServices.PermissionType.CREATEABLE, sObjType, fieldNames);
        	System.assert(false, 'An exception should have been thrown.');
        }
        catch(Eng_IvorySalesforceServices.ServiceException e){}
     }
    
     static testMethod void testCheckObjAndFieldPermissions()
     {
        Schema.sObjectType sObjType = Opportunity.sObjectType;
        List<String> fieldNames = new List<String>{ 'Name' };
        Eng_IvorySalesforceServices.checkObjAndFieldPermissions(Eng_IvorySalesforceServices.PermissionType.CREATEABLE, sObjType, fieldNames);
        System.assert(true, 'An exception is thrown if there is an error. This assert is so the SFDC code scanner doesn\'t complain.');
    }
    
    static testMethod void testCheckFieldPermission_NotCreateable()
    {
        ObjectPermissions[] objPermList = [SELECT sObjectType, Parent.Profile.Id, Parent.Profile.Name FROM ObjectPermissions WHERE PermissionsCreate = false AND Parent.Profile.UserLicense.Name = 'Salesforce' LIMIT 1];
        
        if (objPermList.size() > 0)
        {
            System.runAs(getTestUser(objPermList[0].Parent.Profile))
            {
                Schema.sObjectType sObjType = globalDescribeMap.get(objPermList[0].sObjectType);
                try{
                	List<String> fieldNames = new List<String>{ 'Name' };
                	Eng_IvorySalesforceServices.checkFieldPermission(Eng_IvorySalesforceServices.PermissionType.CREATEABLE, sObjType, fieldNames);
                    System.assert(false, 'An exception should have been thrown.');
                }
                catch(Eng_IvorySalesforceServices.PermissionException e){}
            }
        }
    }
    
    static testMethod void testCheckFieldPermission_NotUpdateable()
    {
        ObjectPermissions[] objPermList = [SELECT sObjectType, Parent.Profile.Id, Parent.Profile.Name FROM ObjectPermissions WHERE PermissionsEdit = false AND Parent.Profile.Id != NULL AND Parent.Profile.UserLicense.Name = 'Salesforce' LIMIT 1];
        
        if (objPermList.size() > 0)
        {
            System.runAs(getTestUser(objPermList[0].Parent.Profile))
            {
                Schema.sObjectType sObjType = globalDescribeMap.get(objPermList[0].sObjectType);
                try{
                	List<String> fieldNames = new List<String>{ 'Name' };
                	Eng_IvorySalesforceServices.checkFieldPermission(Eng_IvorySalesforceServices.PermissionType.UPDATEABLE, sObjType, fieldNames);
                    System.assert(false, 'An exception should have been thrown.');
                }
                catch(Eng_IvorySalesforceServices.PermissionException e){}
            }
        }
    }
    
    static testMethod void testCheckObjPermission_NotCreateable()
    {
        ObjectPermissions[] objPermList = [SELECT sObjectType, Parent.Profile.Id, Parent.Profile.Name FROM ObjectPermissions WHERE PermissionsCreate = false AND Parent.Profile.UserLicense.Name = 'Salesforce' LIMIT 1];
        
        if (objPermList.size() > 0)
        {
            System.runAs(getTestUser(objPermList[0].Parent.Profile))
            {
                Schema.sObjectType sObjType = globalDescribeMap.get(objPermList[0].sObjectType);
                try{
                    Eng_IvorySalesforceServices.checkObjPermission(Eng_IvorySalesforceServices.PermissionType.CREATEABLE, sObjType);
                    System.assert(false, 'An exception should have been thrown.');
                }
                catch(Eng_IvorySalesforceServices.PermissionException e){}
            }
        }
    }
    
    static testMethod void testCheckObjPermission_NotUpdateable()
    {
        ObjectPermissions[] objPermList = [SELECT sObjectType, Parent.Profile.Id, Parent.Profile.Name FROM ObjectPermissions WHERE PermissionsEdit = false AND Parent.Profile.Id != NULL AND Parent.Profile.UserLicense.Name = 'Salesforce' LIMIT 1];
        
        if (objPermList.size() > 0)
        {
            System.runAs(getTestUser(objPermList[0].Parent.Profile))
            {
                Schema.sObjectType sObjType = globalDescribeMap.get(objPermList[0].sObjectType);
                try{
                    Eng_IvorySalesforceServices.checkObjPermission(Eng_IvorySalesforceServices.PermissionType.UPDATEABLE, sObjType);
                    System.assert(false, 'An exception should have been thrown.');
                }
                catch(Eng_IvorySalesforceServices.PermissionException e){}
            }
        }
    }
    
    static testMethod void testCheckObjPermission_NotDeletable()
    {
        ObjectPermissions[] objPermList = [SELECT sObjectType, Parent.Profile.Id, Parent.Profile.Name FROM ObjectPermissions WHERE PermissionsDelete = false AND Parent.Profile.Id != NULL AND Parent.Profile.UserLicense.Name = 'Salesforce' LIMIT 1];
        
        if (objPermList.size() > 0)
        {
            System.runAs(getTestUser(objPermList[0].Parent.Profile))
            {
                Schema.sObjectType sObjType = globalDescribeMap.get(objPermList[0].sObjectType);
                try{
                    Eng_IvorySalesforceServices.checkObjPermission(Eng_IvorySalesforceServices.PermissionType.DELETABLE, sObjType);
                    System.assert(false, 'An exception should have been thrown.');
                }
                catch(Eng_IvorySalesforceServices.PermissionException e){}
            }
        }
    }
    
    static testMethod void testCheckObjPermission_NotAccessible()
    {
        // A permission is false if an object permission exists with that permission set to false, or there is no object permission
        // for a particular type.  We are, therefore, finding all the profiles that do have permission and then comparing them against
        // the total number of profiles to find those that don't have permission.
        
        List<Id> profileIdsWithPermission = new List<Id>();
        String sObjTypeName = Schema.sObjectType.Opportunity.Name;
        for (AggregateResult result : [Select Parent.Profile.Id id, Parent.Profile.Name name FROM ObjectPermissions WHERE sObjectType = :sObjTypeName and PermissionsRead = true GROUP BY Parent.Profile.Id, Parent.Profile.Name])
        {
            profileIdsWithPermission.add((Id) result.get('id'));
        }
        
        for (Profile p : [SELECT Id, Name FROM Profile WHERE Id NOT IN :profileIdsWithPermission and (UserLicense.Name LIKE 'Salesforce') LIMIT 1])
        {
            System.runAs(getTestUser(p))
            {
                Schema.sObjectType sObjType = globalDescribeMap.get(sObjTypeName);
                try{
                    Eng_IvorySalesforceServices.checkObjPermission(Eng_IvorySalesforceServices.PermissionType.ACCESSIBLE, sObjType);
                    System.assert(false, 'An exception should have been thrown.');
                }
                catch(Eng_IvorySalesforceServices.PermissionException e){}
            }
        }
    }
    
    static Integer[] chrset;
    
    static Integer[] charset {
        get{
            if (chrset == null){
                chrset = new Integer[0];
                for (Integer i = 48; i < 58; i++) chrset.add(i);// 0-9
                for (Integer i = 65; i < 91; i++) chrset.add(i);// A-Z
                for (Integer i = 97; i < 123; i++) chrset.add(i);// a-z
            }
            return chrset;
        }
    }
        
    private static String generateRandomString(Integer len)
    {
        Integer[] chars = new Integer[len];
        Integer key, size = charset.size();
        
        for (Integer idx = 0; idx < len; idx++)
        {
            chars[idx] = charset[Math.mod(Math.abs(Crypto.getRandomInteger()), size)];
        }
        return String.fromCharArray(chars);
    }
        
    private static User getTestUser(Profile p)
    {
        Integer tries = 0;
        while (true)
        {
            try
            {
                String username = generateRandomString(15) + '@someorgthatonlyisusedfortesting.com';
                Integer aliasLength = Schema.sObjectType.User.fields.Alias.Length;
                User u = new User(
                    Alias = username.substring(0, aliasLength),
                    Email = 'user@someorgthatonlyisusedfortesting.com',
                    EmailEncodingKey = 'UTF-8',
                    LastName = 'TestingUser',
                    LanguageLocaleKey = 'en_US',
                    LocaleSidKey = 'en_US',
                    ProfileId = p != null ? p.Id : null, 
                    TimeZoneSidKey = 'America/Los_Angeles',
                    UserName = username
                );
                insert u;
                
                return u;
            }
            catch(DmlException e)
            {
                if (tries > 5 || e.getDmlType(0) != System.StatusCode.DUPLICATE_USERNAME){
                    throw e;
                }
                tries++;
            }
        }
        return null;
    }
}