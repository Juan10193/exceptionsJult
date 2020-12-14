public with sharing class Eng_IvorySalesforceServices{

    private static Map<String, sObjectType> globalDescribe = Schema.getGlobalDescribe();
    private static Map<sObjectType, Map<String, sObjectField>> objToFieldsMap = new Map<sObjectType, Map<String, sObjectField>>();

    public enum PermissionType { ACCESSIBLE, CREATEABLE, UPDATEABLE, DELETABLE }
    
    public class PermissionException extends Exception{}
    
    public class ServiceException extends Exception{}
             
    public static Map<String, sObjectField> getSObjectFields(sObjectType objType)
    {
        if (objType == null) return null;
        Map<String, sObjectField> fieldMap = objToFieldsMap.get(objType);
        if (fieldMap == null)
        {
            fieldMap = objType.getDescribe().fields.getMap();
            objToFieldsMap.put(objType, fieldMap);
        }
        return fieldMap;
    }
     
    //Determine if this is SF1 app
    public static Boolean isSF1()
    {
        if(String.isNotBlank(ApexPages.currentPage().getParameters().get('sfdcIFrameHost')) ||
            String.isNotBlank(ApexPages.currentPage().getParameters().get('sfdcIFrameOrigin')) ||
            ApexPages.currentPage().getParameters().get('isdtp') == 'p1' ||
            (ApexPages.currentPage().getParameters().get('retURL') != null && ApexPages.currentPage().getParameters().get('retURL').contains('projectone') )
        ){
            return true;
        }
        else
        {
            return false;
        }
    }
    
    public static void checkObjAndFieldPermissions(PermissionType permission, sObjectType sObjType, List<String> fieldNames)
    {
        checkObjPermission(permission, sObjType);
        
        if (permission != PermissionType.DELETABLE)
        {
            checkFieldPermission(permission, sObjType, fieldNames);
        }
    }
        
    public static void checkObjPermission(PermissionType permission, sObjectType objType)
    {
        DescribeSObjectResult describeObj = objType.getDescribe();
        if (permission == PermissionType.ACCESSIBLE && !describeObj.isAccessible())
        {
            throw new PermissionException('You do not have permission to access ' + describeObj.getLabelPlural());
        }
        else if (permission == PermissionType.CREATEABLE && !describeObj.isCreateable())
        {
            throw new PermissionException('You do not have permission to create ' + describeObj.getLabelPlural());
        }
        else if (permission == PermissionType.UPDATEABLE && !describeObj.isUpdateable())
        {
            throw new PermissionException('You do not have permission to update ' + describeObj.getLabelPlural());
        }
        else if (permission == PermissionType.DELETABLE && !describeObj.isDeletable())
        {
            throw new PermissionException('You do not have permission to delete ' + describeObj.getLabelPlural());
        }
    }
        
    public static void checkFieldPermission(PermissionType permission, sObjectType objType, List<String> fieldNames)
    {
        DescribeSObjectResult describeObj = objType.getDescribe();
        List<sObjectField> objFields = getObjectFields(describeObj, fieldNames);
        checkFieldPermission(permission, objFields);
    }
    
    public static void checkFieldPermission(PermissionType permission, List<sObjectField> objFields)
    {
        for (sObjectField objField: objFields)
        {
            checkFieldPermission(permission, objField);
        }
    }
    
    public static void checkFieldPermission(PermissionType permission, sObjectField objField)
    {
        DescribeFieldResult describeField = objField.getDescribe();
        if (permission == PermissionType.ACCESSIBLE && !describeField.isAccessible())
        {
            throw new PermissionException('You do no have permission to access ' + describeField.getLabel());
        }
        else if (permission == PermissionType.CREATEABLE && !describeField.isCreateable())
        {
            throw new PermissionException('You do no have permission to create ' + describeField.getLabel());
        }
        else if (permission == PermissionType.UPDATEABLE && !describeField.isUpdateable())
        {
            throw new PermissionException('You do no have permission to update ' + describeField.getLabel());
        }
    }
    
    private static List<sObjectField> getObjectFields(DescribeSObjectResult describeObj, List<String> fieldNames)
    {
        Map<String, sObjectField> objFields = getSObjectFields(describeObj.getSObjectType());
        List<sObjectField> selectedFields = new List<sObjectField>();
        for (String fieldName : fieldNames)
        {
            sObjectField objField = objFields.get(fieldName);
            if (objField != null)
            {
                selectedFields.add(objField);
            }
            else
            {
                throw new ServiceException('Attempted to validate the permission of a field that does not exist: ' + fieldName);
            }
        }
        return selectedFields;
    }
}