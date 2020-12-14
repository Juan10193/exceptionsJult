@Istest
 public class Data_Factory_CreditApproval_Test  {
    // Metodo que permite crear una CA de tipo  Workout unicamente con los datos requeridos
    public static Credit_approval_CP__c createNewCreditApprovalTypeWK(string accountName){
                         
        Credit_approval_CP__c CA = new Credit_approval_CP__c();
        Id wkRecordTypeId = Schema.SObjectType.Credit_approval_CP__c.getRecordTypeInfosByName().get('Workout').getRecordTypeId();
        CA.RecordTypeId= wkRecordTypeId;
        CA.Type_of_credit_approval_Workout__c='Extension';
        CA.CPL_rb_account__c=Data_Factory_Account_test.createNewAccount(accountName).Id;
        CA.Risk_Analyst__c=UserInfo.getUserId();
        CA.Sr_Underwriter__c=UserInfo.getUserId();
        CA.Inside_Sales__c=UserInfo.getUserId();
        CA.Approval_Level__c='MDWO';
        CA.SP3_pl_Credit_Approval_Status__c ='New';
        CA.ES3_ls_RISK_REVIEW_STATUS__c ='New';
        CA.ES3_ls_AML_Review_Status__c ='New'; 
        CA.CPI_tx_Risk_Economic_Group__c='ABA';
        CA.ES3_tx_Risk_Economic_Group_Id__c='1234';
 
        
        insert CA;
        return CA;
        
    }
     public static Credit_approval_CP__c createNewCreditApprovalTypeCA(string accountName){
                         
        Credit_approval_CP__c CA = new Credit_approval_CP__c();
        Id RecordTypeId = Schema.SObjectType.Credit_approval_CP__c.getRecordTypeInfosByName().get('Credit Approval').getRecordTypeId();
        CA.RecordTypeId= RecordTypeId;
        CA.CPL_rb_account__c=Data_Factory_Account_test.createNewAccount(accountName).Id;
        CA.Risk_Analyst__c=UserInfo.getUserId();
        CA.Sr_Underwriter__c=UserInfo.getUserId();
        CA.Inside_Sales__c=UserInfo.getUserId();
        CA.Approval_Level__c='Credit Committee';
        CA.SP3_pl_Credit_Approval_Status__c ='New';
        CA.ES3_ls_RISK_REVIEW_STATUS__c ='New';
        CA.ES3_ls_AML_Review_Status__c ='New'; 
        CA.CPI_tx_Risk_Economic_Group__c='ABA';
        CA.ES3_tx_Risk_Economic_Group_Id__c='1234';
 
        
        insert CA;
        return CA;
        
    }

}