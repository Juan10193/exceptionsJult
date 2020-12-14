@Istest
public class Data_Factory_BankAccountTest {
    
    public static Bank_Account__c createBankAccountSite(string accNumber, string bnkAccName, Id siteId ){
        Id recordTypeId = Schema.SObjectType.Bank_Account__c.getRecordTypeInfosByDeveloperName().get('Supplier_Account').getRecordTypeId();
        Bank_Account__c bankAcc = new Bank_Account__c();
        bankAcc.Bank_Name__c = 'CITIBANAMEX';
        bankAcc.Name = accNumber;
        bankAcc.Bank_Account_Name__c = bnkAccName;
        bankAcc.Bank_Account_Currency__c ='MXN';
        BankAcc.TKD_rb_Site__c = siteId;
        bankAcc.TKD_tx_OraclebankId__c ='11';
        bankAcc.RecordTypeId = recordTypeId;
        insert bankAcc;
        return bankAcc;
    }
    
    
     public static Bank_Account__c createBankAccountSiteVCODE(string accNumber, string bnkAccName, Id siteId, string vsitecode ){
        Id recordTypeId = Schema.SObjectType.Bank_Account__c.getRecordTypeInfosByDeveloperName().get('Supplier_Account').getRecordTypeId();
        Bank_Account__c bankAcc = new Bank_Account__c();
        bankAcc.Bank_Name__c = 'CITIBANAMEX';
        bankAcc.Name = accNumber;
        bankAcc.Bank_Account_Name__c = bnkAccName;
        bankAcc.Bank_Account_Currency__c ='MXN';
        BankAcc.TKD_rb_Site__c = siteId;
        bankAcc.RecordTypeId = recordTypeId;
        bankAcc.TKD_Vendor_Site_ID__c =vsitecode;
        insert bankAcc;
        return bankAcc;
    }
    public static Bank_Account__c createNewBankAccount(Id siteId){
        Id Bank_Account_RecordTypeId = Schema.SObjectType.Bank_Account__c.getRecordTypeInfosByName().get('Supplier Account').getRecordTypeId();
        Bank_Account__c Bank_Account = new Bank_Account__c();
        Bank_Account.Name = '34242342343242';
        Bank_Account.SR_tx_Bank_Name__c = 'some bank';
        Bank_Account.Bank_Account_Currency__c = 'MXN'; 
        Bank_Account.RecordTypeId = Bank_Account_RecordTypeId;
        Bank_Account.Tipo_BIC__c = 'SWIFT';
        Bank_Account.Codigo_BIC__c = '2343242342';
        Bank_Account.Nombre_Banco_intermediadio__c = 'Some';
        Bank_Account.Tipo__c = 'SWIFT';
        Bank_Account.Codigo__c = '3424234';
        Bank_Account.SR_ls_Specific_intermediary_bank__c = 'No';
        Bank_Account.SR_tx_Country__c = 'Some country';
        Bank_Account.TKD_rb_Site__c = siteId;
        insert Bank_Account;
        return Bank_Account;
    }
    
    
    
}