@Istest
public class Data_Factory_CreditApproval_Old {
    public static TBO014_Credit_Approval__c createNewCreditApprovalOld(string accountName){
                         
        TBO014_Credit_Approval__c cAOld = new TBO014_Credit_Approval__c();
        cAOld.BanderaCalculoAmout__c = false;
        cAOld.TBO014_ca_Active__c = true;
        cAOld.TBO014_ca_Credit_Approval__c = true;
        cAOld.TBO014_fh_Effective_End_Date__c = date.today(); 
        cAOld.TBO014_fh_Effective_Start_Date__c = date.today(); 
        cAOld.TBO014_fh_Status_Date__c = date.today(); 
        cAOld.TBO014_ls_Approval_Category__c = 'MOD';
        cAOld.TBO014_ls_EFA_required__c = 'Yes';
        cAOld.TBO014_rb_Account__c = Data_Factory_Account_Test.createNewAccount('Engen').id; 
        cAOld.TBO014_tx_Approval_Type__c = 'MOD';
        cAOld.TBO014_tx_Credit_Approval_Name__c = accountName; 
        //cAOld.TBO014_tx_EXT_REF_ID__c, 
        cAOld.TBO014_tx_Region__c = 'mx';
        cAOld.TBO014_tx_Status__c = 'Approved'; 
        cAOld.TBO014_un_Amount_MXN__c = 800000;   
        insert cAOld;
        return cAOld;
        
    }

}