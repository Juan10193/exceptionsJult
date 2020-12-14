/**
 * @File Name          : TKD_supplierInTD_NewSupplierController.cls
 * @Description        : 
 * @Author             : eduardo.villegas@engeniumcapital.com
 * @Group              : 
 * @Last Modified By   : eduardo.amiens@outlook.com
 * @Last Modified On   : 15/6/2020 17:52:25
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    17/12/2019   eduardo.villegas@engeniumcapital.com     Initial Version
**/
public class TKD_supplierInTD_NewSupplierController {     
    public virtual class BaseException extends Exception {}
    public class OtherException extends BaseException {}
        
    @AuraEnabled 
    public static void insertSupplier(string takedownId, TKD_supplierInTD_NewSupplierWrapper.Supplier supplierDetail) {
        system.debug('supplierDetail ' + supplierDetail);
        system.debug('takedownId ' + takedownId);
        TKD_supplierInTD_NewSupplierHelper newSupplierHelper = new TKD_supplierInTD_NewSupplierHelper(takedownId, supplierDetail);
        Supplier__c supplier = newSupplierHelper.insertSupplier();
        map<TKD_supplierInTD_NewSupplierWrapper.Site,TKD_Site__c> mapSiteSiteWrapper = newSupplierHelper.insertSites(supplier);
        newSupplierHelper.insertBankAccount(mapSiteSiteWrapper);
        newSupplierHelper.insertContact(mapSiteSiteWrapper);
        if(newSupplierHelper.listErrors.size() > 0){
            string error;
            for(string err : newSupplierHelper.listErrors){
                error = error + err;    
            }
            delete newSupplierHelper.listBankAccountRollBack;
            delete newSupplierHelper.listContactRollBack;
            delete newSupplierHelper.listSupplierRollBack;
            throw new OtherException('Errors: ' + error);
        }
   }
    @AuraEnabled
    public static List<String> getCountryPL(){
        List<String> pickListValuesList = new List<String>();
        Schema.DescribeFieldResult fieldResult = TKD_Site__c.TKD_tx_Country__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry pickListVal : ple){
            pickListValuesList.add(pickListVal.getLabel());
            System.debug('Values in TKD_tx_Country__c: '+pickListValuesList);
        }     
        return pickListValuesList;        
    }
    @AuraEnabled
    public static List<String> getSiteState(){
        List<String> pickListValuesList = new List<String>();
        Schema.DescribeFieldResult fieldResult = TKD_Site__c.TKD_ls_State__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry pickListVal : ple){
            pickListValuesList.add(pickListVal.getLabel());
            System.debug('Values in TKD_ls_State__c: '+pickListValuesList);
        }     
        return pickListValuesList;        
    }
    @AuraEnabled
    public static List<String> getAccountBankCurrencyPL(){
        List<String> pickListValuesList = new List<String>();
        Schema.DescribeFieldResult fieldResult = Bank_Account__c.Bank_Account_Currency__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry pickListVal : ple){
            pickListValuesList.add(pickListVal.getLabel());
            System.debug('Values in Account Bank_Account_Currency__c: '+pickListValuesList);
        }     
        return pickListValuesList;        
    }
    @AuraEnabled
    public static List<String> getBankAccount(){
        List<String> pickListValuesList = new List<String>();
        Schema.DescribeFieldResult fieldResult = Bank_Account__c.Bank_Name__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry pickListVal : ple){
            pickListValuesList.add(pickListVal.getLabel());
            System.debug('Values in Bank_Name__c: '+pickListValuesList);
        }     
        return pickListValuesList;        
    }
    @AuraEnabled
    public static String getOperationUnit(string takedownID){
        string operationUnit;
        Takedowns_Contingency_plan__c takedownCP = Data_Access_Takedowns_CP_cls.getAllFieldsByID(takedownID);
        if(takedownCP != null){
        	operationUnit = takedownCP.CPL_ls_Operation_Unit__c.equals('UO_XA7 ENGECAP') ? 'UO_XA7 ENGENCAP' : takedownCP.CPL_ls_Operation_Unit__c;    
        }
        system.debug('operationUnit ' + operationUnit);
        return operationUnit;        
    }
    @AuraEnabled
    public static List<String> getSiteVatCode(){
        List<String> pickListValuesList = new List<String>();
        Schema.DescribeFieldResult fieldResult = TKD_Site__c.TKD_Vat_code__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry pickListVal : ple){
            pickListValuesList.add(pickListVal.getLabel());
            System.debug('Values in TKD_Vat_code__c: ' + pickListValuesList);
        }     
        return pickListValuesList;        
    }
    @AuraEnabled
    public static List<String> getTipo_BIC(){
        List<String> pickListValuesList = new List<String>();
        Schema.DescribeFieldResult fieldResult = Bank_Account__c.Tipo_BIC__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry pickListVal : ple){
            pickListValuesList.add(pickListVal.getLabel());
            System.debug('Values in Tipo_BIC__c: '+pickListValuesList);
        }     
        return pickListValuesList;        
    }   
    @AuraEnabled
    public static List<String> getTipo(){
        List<String> pickListValuesList = new List<String>();
        Schema.DescribeFieldResult fieldResult = Bank_Account__c.Tipo__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry pickListVal : ple){
            pickListValuesList.add(pickListVal.getLabel());
            System.debug('Values in Tipo__c: '+pickListValuesList);
        }     
        return pickListValuesList;        
    }
    @AuraEnabled
    public static List<String> getPago_a_Cuenta_Concentradora(){
        List<String> pickListValuesList = new List<String>();
        Schema.DescribeFieldResult fieldResult = Bank_Account__c.Pago_a_Cuenta_Concentradora__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry pickListVal : ple){
            pickListValuesList.add(pickListVal.getLabel());
            System.debug('Values in Pago_a_Cuenta_Concentradora__c: '+pickListValuesList);
        }     
        return pickListValuesList;        
    } 
    @AuraEnabled
    public static List<String> getCurrencyISOCode(){
        List<String> pickListValuesList = new List<String>();
        Schema.DescribeFieldResult fieldResult = TKD_Site__c.CurrencyIsoCode.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry pickListVal : ple){
            pickListValuesList.add(pickListVal.getLabel());
            System.debug('Values in TKD_Site__c.CurrencyIsoCode: '+pickListValuesList);
        }     
        return pickListValuesList;        
    } 
    @AuraEnabled
    public static List<TKD_Supplier__mdt> getTKD_Supplier_Swift(){
        return [SELECT Id, DeveloperName, MasterLabel, Label, 
            QualifiedApiName, TKD_Use__c, Alternative_Api_Name__c 
            FROM TKD_Supplier__mdt where TKD_Use__c = 'Swift desition'];
    }  
      
}